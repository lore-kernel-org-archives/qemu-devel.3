Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B3CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Mr-000887-Tx; Mon, 17 Nov 2025 10:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Mp-00084T-GP
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:42:11 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL1Ml-00069v-Hc
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:42:11 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so13866675e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394124; x=1763998924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1U4xgVV+pBQ+pjcSk1PrTVW4Uz3FOOYy0zor32u0L0Y=;
 b=VRldGiS73T2uLk/Wp2ctx9Ovtugpt0mwVj2WgkFemSQU24XDyfEzapy7mr0KHm0j99
 P3QFa+A/mXl+QCl+IAEbT/uVSLosO44FTmuSQdSKw5uXdSrotUS39NiMXM+251SbdovW
 zZfWJluG+sg7tf65wcxn86yH1dCD/2yXxnQg62rMCJYAN4paCWs+WxVjcITNdVNBP/XJ
 Yhgg8+mBptbpuiFVhzhnBE2AiAgZVyjGXUwaeoLIqaJuKqfWYt4RKN8+RVnTmIkNeOYZ
 oWB98Eb45GezBC4v4vbyh6mSYogMHdpXLQcpYUtvV/GnI/olfnBIFu8LZllZhKN2Hs6t
 sbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394124; x=1763998924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1U4xgVV+pBQ+pjcSk1PrTVW4Uz3FOOYy0zor32u0L0Y=;
 b=th8/41PQEQCnN8AFC5gsgpqdnRnpd1dvkqtNP/oit1b6gctb83aRKBYC3+k9nF7Nmz
 o18R/9C1cwU6f42Kt3gQKP+zx4Syk8L/Ie8cwBfYLlr1esF96DKAoqyztnkdMdsMPiZH
 x5Mi59OQJm0AVS6WnbJWpxivekoLOTrOct4ET9NQTBVxrrD9sy0k9KfvLdWmFNbB2CQc
 REnixvaEqZlZv6NHE4YcOhf1S6XKQl7CRrz5lSGIPZTqU4yLrwvYdbZLDYBhB4dfARmG
 s+6vP9dQFlOrpzypTmTqC5uZJarVpwIt6qIR00AkfHuZMmnfmcu3Jb5Rzf9XYb2lUB9x
 CM2w==
X-Gm-Message-State: AOJu0YxXrg8t3o6IGHJJ4OBVZGEFo3q9Dupom1cagYwpZbbD5ygWEqwe
 Omj7rXTiHkKVIp4nz8zQ1nZ7lA/EPeRW86VEXdsyIh/etyfPTCUWaTbrTDTIf7YKQACMHcdfh6U
 9maI9929J6UsN
X-Gm-Gg: ASbGncvH8FaXFWVZbY5Bn0oyclgN+q+TdxS5BtAcPkmJJ143Ad+J6404HkIG3ZPSZfx
 8EHWuYit2aOICk68tvdQGP+ftPJ43hR47zAz+ak5+ofUQiLp/TYTs3pmK0bSRMsMtQ0ihOiGvSS
 kx7UBm14ZPOs1IGcP+bzX0uB4Zr4mmKAPxAvYobU3BcVh1yu4tXxkMBFzZ1tUW3+bcw7DKrNhQQ
 zlG7/Gxa+Ts7luYumZBDCdJuOU8kPOAs2OsToEdYeMcLt1b8Wo9z1G93xKSNOeIZ68pBfBfKD40
 YLzKAR0kemKiHWWzmcd1W7XxiBTK7zXwR8ULFGCVjFrqVs6J43yw4eP8pi5fUMrmL4IeDAISgRH
 Rk4hJFkGwcE/MD//xrxLZfB2mFnl0f0RERygEnD+8tQISLlE6gtRczXku85blkaXAuXdEyig2+/
 yPj3RpartbM5SPG7QI0uLFkIJMAP2nSStWcgQANvzWXM4j9bpyogS2JF7S7mbX
X-Google-Smtp-Source: AGHT+IGr/ZFIGluKY9aCkp9Dh61b45t9r2e0QHMZj1FwBqHi1bNt/aB16UeLcaO642PjdB8th3P23A==
X-Received: by 2002:a05:600c:19ce:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-477a8272cf2mr8892395e9.23.1763394123887; 
 Mon, 17 Nov 2025 07:42:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47799768409sm144324065e9.3.2025.11.17.07.42.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 07:42:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH-for-10.2 1/2] gitlab: Stop cross-testing for 32-bit ARM hosts
Date: Mon, 17 Nov 2025 16:41:53 +0100
Message-ID: <20251117154154.79090-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117154154.79090-1-philmd@linaro.org>
References: <20251117154154.79090-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

32-bit host support is deprecated since commit 6d701c9bac1
("meson: Deprecate 32-bit host support"). Next commits will
remove support for 32-bit ARM hosts. Stop cross-building
QEMU on our CI. Remove the CI jobs and related Docker files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                                     |   9 -
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/crossbuilds.yml                  |   7 -
 python/qemu/utils/accel.py                    |   1 -
 roms/edk2-build.py                            |   4 -
 .../dockerfiles/debian-armhf-cross.docker     | 188 ------------------
 tests/docker/dockerfiles/debian-bootstrap.pre |   5 +-
 tests/lcitool/refresh                         |   5 -
 8 files changed, 1 insertion(+), 224 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker

diff --git a/configure b/configure
index a2f66f7ff9c..4b8f92e822b 100755
--- a/configure
+++ b/configure
@@ -1334,8 +1334,6 @@ fi
 : ${cross_prefix_aarch64="aarch64-linux-gnu-"}
 : ${cross_prefix_aarch64_be="$cross_prefix_aarch64"}
 : ${cross_prefix_alpha="alpha-linux-gnu-"}
-: ${cross_prefix_arm="arm-linux-gnueabihf-"}
-: ${cross_prefix_armeb="$cross_prefix_arm"}
 : ${cross_prefix_hexagon="hexagon-unknown-linux-musl-"}
 : ${cross_prefix_loongarch64="loongarch64-unknown-linux-gnu-"}
 : ${cross_prefix_hppa="hppa-linux-gnu-"}
@@ -1359,8 +1357,6 @@ fi
 
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
 : ${cross_cc_cflags_aarch64_be="-mbig-endian"}
-: ${cross_cc_armeb="$cross_cc_arm"}
-: ${cross_cc_cflags_armeb="-mbig-endian"}
 : ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
 : ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
 : ${cross_cc_cflags_i386="-m32"}
@@ -1481,11 +1477,6 @@ probe_target_compiler() {
         # We don't have any bigendian build tools so we only use this for AArch64
         container_image=debian-arm64-cross
         ;;
-      arm)
-        # We don't have any bigendian build tools so we only use this for ARM
-        container_image=debian-armhf-cross
-        container_cross_prefix=arm-linux-gnueabihf-
-        ;;
       hexagon)
         container_cross_prefix=hexagon-unknown-linux-musl-
         container_cross_cc=${container_cross_prefix}clang
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 0fd7341afac..e7ce1392770 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -22,12 +22,6 @@ arm64-debian-cross-container:
   variables:
     NAME: debian-arm64-cross
 
-armhf-debian-cross-container:
-  extends: .container_job_template
-  stage: containers
-  variables:
-    NAME: debian-armhf-cross
-
 hexagon-cross-container:
   extends: .container_job_template
   stage: containers
diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 99dfa7eea6f..e0a68c2023d 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -1,13 +1,6 @@
 include:
   - local: '/.gitlab-ci.d/crossbuild-template.yml'
 
-cross-armhf-user:
-  extends: .cross_user_build_job
-  needs:
-    - job: armhf-debian-cross-container
-  variables:
-    IMAGE: debian-armhf-cross
-
 cross-arm64-system:
   extends: .cross_system_build_job
   needs:
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index f915b646692..e6fca304b33 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -26,7 +26,6 @@
 # support which often includes its 32 bit cousin.
 ADDITIONAL_ARCHES = {
     "x86_64": "i386",
-    "aarch64": "armhf",
     "ppc64le": "ppc64",
 }
 
diff --git a/roms/edk2-build.py b/roms/edk2-build.py
index c7e9dc58ec0..683c622c3d6 100755
--- a/roms/edk2-build.py
+++ b/roms/edk2-build.py
@@ -289,10 +289,6 @@ def prepare_env(cfg, silent = False):
     os.environ['PYTHONHASHSEED'] = '1'
 
     # for cross builds
-    if binary_exists('arm-linux-gnueabi-gcc'):
-        # ubuntu
-        os.environ['GCC5_ARM_PREFIX'] = 'arm-linux-gnueabi-'
-        os.environ['GCC_ARM_PREFIX'] = 'arm-linux-gnueabi-'
     if binary_exists('loongarch64-linux-gnu-gcc'):
         os.environ['GCC5_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
         os.environ['GCC_LOONGARCH64_PREFIX'] = 'loongarch64-linux-gnu-'
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
deleted file mode 100644
index 627d41c6dee..00000000000
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ /dev/null
@@ -1,188 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch armv7l debian-13 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:13-slim
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    apt-get update && \
-    apt-get install -y eatmydata && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      bash \
-                      bc \
-                      bindgen \
-                      bison \
-                      bsdextrautils \
-                      bzip2 \
-                      ca-certificates \
-                      ccache \
-                      dbus \
-                      debianutils \
-                      diffutils \
-                      exuberant-ctags \
-                      findutils \
-                      flex \
-                      gcc \
-                      gcovr \
-                      gettext \
-                      git \
-                      hostname \
-                      libclang-rt-dev \
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      mtools \
-                      ncat \
-                      ninja-build \
-                      openssh-client \
-                      pkgconf \
-                      python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
-                      python3-pip \
-                      python3-setuptools \
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-tomli \
-                      python3-venv \
-                      python3-wheel \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc \
-                      sed \
-                      socat \
-                      sparse \
-                      swtpm \
-                      tar \
-                      tesseract-ocr \
-                      tesseract-ocr-eng \
-                      vulkan-tools \
-                      xorriso \
-                      zstd && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
-    dpkg-reconfigure locales && \
-    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
-
-RUN /usr/bin/pip3 install meson==1.8.1
-
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture armhf && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-arm-linux-gnueabihf \
-                      libaio-dev:armhf \
-                      libasan8:armhf \
-                      libasound2-dev:armhf \
-                      libattr1-dev:armhf \
-                      libbpf-dev:armhf \
-                      libbrlapi-dev:armhf \
-                      libbz2-dev:armhf \
-                      libc6-dev:armhf \
-                      libcacard-dev:armhf \
-                      libcap-ng-dev:armhf \
-                      libcapstone-dev:armhf \
-                      libcbor-dev:armhf \
-                      libcmocka-dev:armhf \
-                      libcurl4-gnutls-dev:armhf \
-                      libdaxctl-dev:armhf \
-                      libdrm-dev:armhf \
-                      libepoxy-dev:armhf \
-                      libfdt-dev:armhf \
-                      libffi-dev:armhf \
-                      libfuse3-dev:armhf \
-                      libgbm-dev:armhf \
-                      libgcrypt20-dev:armhf \
-                      libglib2.0-dev:armhf \
-                      libgnutls28-dev:armhf \
-                      libgtk-3-dev:armhf \
-                      libgtk-vnc-2.0-dev:armhf \
-                      libibverbs-dev:armhf \
-                      libiscsi-dev:armhf \
-                      libjemalloc-dev:armhf \
-                      libjpeg62-turbo-dev:armhf \
-                      libjson-c-dev:armhf \
-                      liblttng-ust-dev:armhf \
-                      liblzo2-dev:armhf \
-                      libncursesw5-dev:armhf \
-                      libnfs-dev:armhf \
-                      libnuma-dev:armhf \
-                      libpam0g-dev:armhf \
-                      libpcre2-dev:armhf \
-                      libpipewire-0.3-dev:armhf \
-                      libpixman-1-dev:armhf \
-                      libpng-dev:armhf \
-                      libpulse-dev:armhf \
-                      librdmacm-dev:armhf \
-                      libsasl2-dev:armhf \
-                      libsdl2-dev:armhf \
-                      libsdl2-image-dev:armhf \
-                      libseccomp-dev:armhf \
-                      libselinux1-dev:armhf \
-                      libslirp-dev:armhf \
-                      libsnappy-dev:armhf \
-                      libsndio-dev:armhf \
-                      libspice-protocol-dev:armhf \
-                      libspice-server-dev:armhf \
-                      libssh-dev:armhf \
-                      libstd-rust-dev:armhf \
-                      libsystemd-dev:armhf \
-                      libtasn1-6-dev:armhf \
-                      libubsan1:armhf \
-                      libudev-dev:armhf \
-                      liburing-dev:armhf \
-                      libusb-1.0-0-dev:armhf \
-                      libusbredirhost-dev:armhf \
-                      libvdeplug-dev:armhf \
-                      libvirglrenderer-dev:armhf \
-                      libvte-2.91-dev:armhf \
-                      libxdp-dev:armhf \
-                      libzstd-dev:armhf \
-                      nettle-dev:armhf \
-                      systemtap-sdt-dev:armhf \
-                      zlib1g-dev:armhf && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/arm-linux-gnueabihf-gcc'\n\
-ar = '/usr/bin/arm-linux-gnueabihf-gcc-ar'\n\
-strip = '/usr/bin/arm-linux-gnueabihf-strip'\n\
-pkgconfig = '/usr/bin/arm-linux-gnueabihf-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'arm'\n\
-cpu = 'armhf'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/arm-linux-gnueabihf-gcc
-
-ENV ABI "arm-linux-gnueabihf"
-ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
-ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
-ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
-
-ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-bootstrap.pre b/tests/docker/dockerfiles/debian-bootstrap.pre
index 35c85f7db8a..0a652754dfd 100755
--- a/tests/docker/dockerfiles/debian-bootstrap.pre
+++ b/tests/docker/dockerfiles/debian-bootstrap.pre
@@ -21,7 +21,7 @@ if [ -z $FAKEROOT ]; then
 fi
 
 if [ -z "${DEB_ARCH}" ]; then
-    echo "Please set DEB_ARCH to choose an architecture (e.g. armhf)" >&2
+    echo "Please set DEB_ARCH to choose an architecture (e.g. arm64)" >&2
     exit_and_skip
 
 fi
@@ -99,9 +99,6 @@ else
         amd64)
             QEMU=qemu-i386
             ;;
-        armel|armhf)
-            QEMU=qemu-arm
-            ;;
         arm64)
             QEMU=qemu-aarch64
             ;;
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index df186caffe6..d3743ba73e8 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -208,11 +208,6 @@ try:
                         trailer=cross_build("aarch64-linux-gnu-",
                                             "aarch64-softmmu,aarch64-linux-user"))
 
-    generate_dockerfile("debian-armhf-cross", "debian-13",
-                        cross="armv7l",
-                        trailer=cross_build("arm-linux-gnueabihf-",
-                                            "arm-softmmu,arm-linux-user"))
-
     generate_dockerfile("debian-i686-cross", "debian-13",
                         cross="i686",
                         trailer=cross_build("i686-linux-gnu-",
-- 
2.51.0


