#!/bin/bash

# Copyright 2020 Intel Corporation
# SPDX-License-Identifier: Apache 2.0

export http_proxy_host=$(echo $http_proxy | awk -F':' {'print $2'} | tr -d '/')
export http_proxy_port=$(echo $http_proxy | awk -F':' {'print $3'} | tr -d '/')

export https_proxy_host=$(echo $https_proxy | awk -F':' {'print $2'} | tr -d '/')
export https_proxy_port=$(echo $https_proxy | awk -F':' {'print $3'} | tr -d '/')

export _JAVA_OPTIONS="-Dhttp.proxyHost=$http_proxy_host -Dhttp.proxyPort=$http_proxy_port -Dhttps.proxyHost=$https_proxy_host -Dhttps.proxyPort=$https_proxy_port"

REMOTE_URL=https://github.com/secure-device-onboard/iot-platform-sdk
REMOTE_BRANCH=1.10-rel

if [ "$use_remote" = "1" ]; then
  echo "Building $REMOTE_URL : $REMOTE_BRANCH"
  cd /tmp/
  git clone $REMOTE_URL
  cd /tmp/iot-platform-sdk/
  git checkout $REMOTE_BRANCH
  mvn clean install
  cd demo && find . -name \*.war -exec cp --parents {} /home/sdouser/iot-platform-sdk/demo \;
else
  echo "Building local copy"
  mvn clean install
fi
