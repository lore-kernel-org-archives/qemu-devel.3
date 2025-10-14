Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42330CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cWI-0005be-Pi; Tue, 14 Oct 2025 06:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVV-0004d1-K0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVF-0003X1-4e
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so55783415e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438606; x=1761043406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogDLw91ptCfy9iIm2H0w8Em9wCPoPjeWqc1JSb8NZJ8=;
 b=OBscSoLdu0KXaNRr3qGT6dxr6h4CeVZrTlWKNhQf7ftLx2ceYEzadOrFAdsBAKs3SU
 1yRSo7sgbZKe9qn4qD1kbw9XsoDwTuGruY3Pv0q6yhX27shkaNbGAyxqbiUsIeVwJfI/
 os7RNIWe/t9DxbfkovgBeDIYVFZLQEV6uxxJZZnM5Tt0hHKvAWsznBV0LoATaop06cy1
 zcRoAoJ8cam6HyuLKa6+qloJ0nx0xrpZ1draLIdhXjjlQ9dpzGb7HR5VGP5H4KYNUs5v
 Rv4bzOtdeJRcL+rimawSGOXZIqA9UnXCZhQU5gWQb75In7enEeNMCTO13U31G2oqE35x
 RrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438606; x=1761043406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogDLw91ptCfy9iIm2H0w8Em9wCPoPjeWqc1JSb8NZJ8=;
 b=ev3rIjce0eXhzZqnVxT3u4YzJ8uQIcsFPwsTRbTjjP0nKbq6vROo7qg7SFGfoin4EJ
 uwrx32xOZ41AnZtYQRlY7G5Td3YcoyNqJ1ok6bXQo9mgsdOAW7gQ9P9XnbG2UMWHkmbq
 A6VxyzZ9F+hsoJzwnPwX93S3EnXhcktDwtx7oOmfK6tX4qtf/aXsY7ft1pdpq5NuSKWC
 XhZOp1gtnfELu478/Ezp0Dz/BThemsWfk6RZPmLQppzlwBBe+RhuaBtijQqwzOKxdHyn
 rbuCZc5Uh49h2HP6hLowu7+LKAgLDAhEAiWKOC2AytFopepePcauym5wi68J31mt2Wn7
 vbUA==
X-Gm-Message-State: AOJu0YyURSRy51jG+yPSnDZgN6oRKmXgragHi9rVnCyB2FoEoRrLPKSd
 VKtvAeHeUa4U8thygcd6ZRT1dETSRkIPkScfy3s7yomJed7tyNLDdyZ4Hmgtq9uJazs=
X-Gm-Gg: ASbGncsjoWqFYkLvgc4Q24SzYGIsuyxPja+P1/nIw+dLYJTfHnXPtTSRjl8XAcASrTB
 TpxQOish/UKBGv4jUfGCwvOTPpx8zakHBg9HuJkoPe07LnJHFc8Zn+z2MKxu+6GLN/qwoBnRCiS
 n24m5dFodgRmz7LrQe6cW+ywMuaFRaOPpnZDRC7Skt4TI9BC5JTDnI4I6nCnvLQIlxaE9q8DKkW
 ccNem7RsDpWdmFHjNk9/s0TNaZzexAtjC4v7yfSVAStGdhBuEM1OOMGCy+I2ddPuqKABNFGDbkw
 TCwewSaZlwaNrPVo4xHYz5qhm5vxHj3bKDewxMXnVIAkM/yKSCRvOZT8f3Jp2KA+iv93NXxOQwn
 sNTECNb42hM0Tffg/BdazyViN3PhyfcTqHNcPNcMVgdZb9Q==
X-Google-Smtp-Source: AGHT+IG/WVuMLWQ69MkhEn81MGHpVyaEf8a+jcmLNNH8AtJM8fLeQMl+Rl+oiGzwDTLDd1YH2e8zOg==
X-Received: by 2002:a05:600c:198f:b0:46e:3b1a:20d7 with SMTP id
 5b1f17b1804b1-46fa9af8595mr197661885e9.19.1760438605672; 
 Tue, 14 Oct 2025 03:43:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb49bd977sm233413605e9.11.2025.10.14.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81E515F82B;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 1/5] tests/lcitool: bump to latest version and regenerate
 (!wait on upstream)
Date: Tue, 14 Oct 2025 11:43:18 +0100
Message-ID: <20251014104323.3023714-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014104323.3023714-1-alex.bennee@linaro.org>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that lcitool can build cross images for Ubuntu and expose just the
foreign layer to yaml output re-generate the armhf package list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
upstream MR: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/552
---
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml |  4 ++--
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   |  4 ++--
 tests/docker/dockerfiles/alpine.docker           | 10 +++++-----
 tests/docker/dockerfiles/centos9.docker          | 10 +++++-----
 .../docker/dockerfiles/debian-amd64-cross.docker | 16 ++++++++--------
 .../docker/dockerfiles/debian-arm64-cross.docker | 16 ++++++++--------
 .../docker/dockerfiles/debian-armhf-cross.docker | 16 ++++++++--------
 .../docker/dockerfiles/debian-i686-cross.docker  | 16 ++++++++--------
 .../dockerfiles/debian-mips64el-cross.docker     | 16 ++++++++--------
 .../dockerfiles/debian-mipsel-cross.docker       | 16 ++++++++--------
 .../dockerfiles/debian-ppc64el-cross.docker      | 16 ++++++++--------
 .../dockerfiles/debian-riscv64-cross.docker      | 16 ++++++++--------
 .../docker/dockerfiles/debian-s390x-cross.docker | 16 ++++++++--------
 tests/docker/dockerfiles/debian.docker           | 10 +++++-----
 .../dockerfiles/fedora-rust-nightly.docker       | 10 +++++-----
 .../docker/dockerfiles/fedora-win64-cross.docker | 14 +++++++-------
 tests/docker/dockerfiles/fedora.docker           | 10 +++++-----
 tests/docker/dockerfiles/opensuse-leap.docker    | 10 +++++-----
 tests/docker/dockerfiles/ubuntu2204.docker       | 10 +++++-----
 tests/lcitool/libvirt-ci                         |  2 +-
 20 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index ce632d97108..70063db198e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index f45f75c9602..4f1a49be34a 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -26,7 +26,7 @@ packages:
   - git
   - hostname
   - libaio-dev
-  - libasan6
+  - libasan8
   - libasound2-dev
   - libattr1-dev
   - libbpf-dev
@@ -37,7 +37,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
-  - libclang-dev
+  - libclang-rt-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 52adf9ccbb7..1da375c9158 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -126,11 +126,11 @@ RUN apk update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # https://gitlab.alpinelinux.org/alpine/aports/-/issues/17463
 RUN apk add clang19-libclang
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0674d778262..ff3e8069b45 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -132,11 +132,11 @@ RUN dnf distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 7f4674400df..26a39940126 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture amd64 && \
@@ -178,9 +178,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-linux-gnu-gcc
 
-ENV ABI "x86_64-linux-gnu"
-ENV MESON_OPTS "--cross-file=x86_64-linux-gnu"
-ENV RUST_TARGET "x86_64-unknown-linux-gnu"
+ENV ABI="x86_64-linux-gnu"
+ENV MESON_OPTS="--cross-file=x86_64-linux-gnu"
+ENV RUST_TARGET="x86_64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index c7cd54ee5ca..4b0163fa1b9 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture arm64 && \
@@ -177,9 +177,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/aarch64-linux-gnu-gcc
 
-ENV ABI "aarch64-linux-gnu"
-ENV MESON_OPTS "--cross-file=aarch64-linux-gnu"
-ENV RUST_TARGET "aarch64-unknown-linux-gnu"
+ENV ABI="aarch64-linux-gnu"
+ENV MESON_OPTS="--cross-file=aarch64-linux-gnu"
+ENV RUST_TARGET="aarch64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 627d41c6dee..742031ce0a2 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture armhf && \
@@ -174,9 +174,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-gcc
 
-ENV ABI "arm-linux-gnueabihf"
-ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
-ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
+ENV ABI="arm-linux-gnueabihf"
+ENV MESON_OPTS="--cross-file=arm-linux-gnueabihf"
+ENV RUST_TARGET="armv7-unknown-linux-gnueabihf"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 2998764065f..1ccfde2e4bb 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture i386 && \
@@ -174,9 +174,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/i686-linux-gnu-gcc
 
-ENV ABI "i686-linux-gnu"
-ENV MESON_OPTS "--cross-file=i686-linux-gnu"
-ENV RUST_TARGET "i686-unknown-linux-gnu"
+ENV ABI="i686-linux-gnu"
+ENV MESON_OPTS="--cross-file=i686-linux-gnu"
+ENV RUST_TARGET="i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 6e88777f76d..eeb77212d5d 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -71,11 +71,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture mips64el && \
@@ -173,9 +173,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mips64el-linux-gnuabi64-gcc
 
-ENV ABI "mips64el-linux-gnuabi64"
-ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
-ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
+ENV ABI="mips64el-linux-gnuabi64"
+ENV MESON_OPTS="--cross-file=mips64el-linux-gnuabi64"
+ENV RUST_TARGET="mips64el-unknown-linux-gnuabi64"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
 ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 5f4e3fa9636..9b3dca44f15 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -71,11 +71,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture mipsel && \
@@ -173,9 +173,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
 
-ENV ABI "mipsel-linux-gnu"
-ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
-ENV RUST_TARGET "mipsel-unknown-linux-gnu"
+ENV ABI="mipsel-linux-gnu"
+ENV MESON_OPTS="--cross-file=mipsel-linux-gnu"
+ENV RUST_TARGET="mipsel-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index dfa690616d1..15c6b436d31 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture ppc64el && \
@@ -176,9 +176,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/powerpc64le-linux-gnu-gcc
 
-ENV ABI "powerpc64le-linux-gnu"
-ENV MESON_OPTS "--cross-file=powerpc64le-linux-gnu"
-ENV RUST_TARGET "powerpc64le-unknown-linux-gnu"
+ENV ABI="powerpc64le-linux-gnu"
+ENV MESON_OPTS="--cross-file=powerpc64le-linux-gnu"
+ENV RUST_TARGET="powerpc64le-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
 ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 09b2953f32c..7a395cc594c 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture riscv64 && \
@@ -179,9 +179,9 @@ endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/riscv64-linux-gnu-gcc
 
-ENV ABI "riscv64-linux-gnu"
-ENV MESON_OPTS "--cross-file=riscv64-linux-gnu"
-ENV RUST_TARGET "riscv64gc-unknown-linux-gnu"
+ENV ABI="riscv64-linux-gnu"
+ENV MESON_OPTS="--cross-file=riscv64-linux-gnu"
+ENV RUST_TARGET="riscv64gc-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
 ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 09a78c15baf..57aa3209c5c 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -72,11 +72,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg --add-architecture s390x && \
@@ -175,9 +175,9 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/s390x-linux-gnu-gcc
 
-ENV ABI "s390x-linux-gnu"
-ENV MESON_OPTS "--cross-file=s390x-linux-gnu"
-ENV RUST_TARGET "s390x-unknown-linux-gnu"
+ENV ABI="s390x-linux-gnu"
+ENV MESON_OPTS="--cross-file=s390x-linux-gnu"
+ENV RUST_TARGET="s390x-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 8dd893be4b0..bbb920c6815 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -152,11 +152,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # netmap/cscope/global
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 7d31c9f4060..e4233b53cbe 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -152,11 +152,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index c76a70c3684..e6f84dd556f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -72,11 +72,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 
 RUN nosync dnf install -y \
                mingw-w64-tools \
@@ -110,8 +110,8 @@ RUN nosync dnf install -y \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-g++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-gcc
 
-ENV ABI "x86_64-w64-mingw32"
-ENV MESON_OPTS "--cross-file=/usr/share/mingw/toolchain-mingw64.meson"
+ENV ABI="x86_64-w64-mingw32"
+ENV MESON_OPTS="--cross-file=/usr/share/mingw/toolchain-mingw64.meson"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32-
 ENV DEF_TARGET_LIST x86_64-softmmu
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 891a740fcbc..632259378c9 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -152,11 +152,11 @@ exec "$@"\n' > /usr/bin/nosync && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 75e17477807..def0ca9db46 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -138,11 +138,11 @@ RUN /usr/bin/pip3.11 install \
                      sphinx \
                      sphinx-rtd-theme
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3.11"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3.11"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index b393db55a8c..e9f059d0659 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -150,11 +150,11 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
 
 RUN /usr/bin/pip3 install meson==1.8.1
 
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
 ENV RUSTC=/usr/bin/rustc-1.77
 ENV RUSTDOC=/usr/bin/rustdoc-1.77
 ENV CARGO_HOME=/usr/local/cargo
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9da20ff7c3b..1b943062a29 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9da20ff7c3bc9067804a7561c2ff87583b434853
+Subproject commit 1b943062a29cf56b5e6d7aedf865843d65ba69a7
-- 
2.47.3


