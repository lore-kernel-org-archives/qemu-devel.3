Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847BBCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 14:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uojhM-000458-2c; Wed, 20 Aug 2025 10:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojhE-00043V-Az
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uojh9-0006uw-4X
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 10:21:46 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b0d231eso36228175e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755699685; x=1756304485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AA+lur7hdgcnhE/6Nghjh0Gy+07MKpaRzdBHxvMucdQ=;
 b=mdDlSXWfuRcq9atlYwbkvImgKL2V50+a5xi+s/m9bRPv+DDFbd7OENEsoCif5ezJry
 ZyqfWNNGPx78z1cYT5yvAz63oKg8T1efLfFWbGYZ3tWQNjy3BC644zHysnSwV/PekypT
 VGWJ8TGVSyRWeTj9F+KfI9ArBxfQdUDmet6X+cMNEl8E2pOFgqg0NqdyOycredc1jIDv
 sOePvkLtqGbpOAQuGwg1TB/xCYH65ZQ14ZxCv2cL81gGm79Iyc+caru9xIg80xYy8WrF
 m46RiZpSPezPIhkrr+LTZT9Rb+uSfqMhUPxiPyFP7/M2RWejevKqEI9OINPsY17JAdSl
 KJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755699685; x=1756304485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AA+lur7hdgcnhE/6Nghjh0Gy+07MKpaRzdBHxvMucdQ=;
 b=oQ25BCyrLFuWCIlcYriq8hUOdfpcT115bZDJN8Rc44ZXA5UbBbGtZOK9EK/EosZq92
 KjjlbGP0Y0Lq6iPJZLWbuCr2Iq3R55NnOpJ7Ms/gKR80hkqfD4mA0UJUpTRP/bW4J4zj
 Xkzie+dHAa+3IjzJRhV6D3m6dsTesvhVynaSuA/tKQ68BjKZklrpxURbnFL//3lR6mQp
 V8Owgy7NewmeStJ2I4c9TyN2/td8N34ZxFVWkuo37nTnVagTB6pnFBXK6ESXbSg79Drp
 nMQcQcdj+sCllUC9Rl8Zprtl3Bqm8nnMUAvbM6o7ckFBYd1UmYeCWNe9vZYUOSfRZpxY
 6ICw==
X-Gm-Message-State: AOJu0Yxtja+jcjZ1cqJbWetGdaGAQiU8RlVWN/dWa46xAhFFf1vIHKaC
 HhfHw0Dby7baJdp6DsShEDfjwasT//n58qF3ZQHYwU8Sj2AktBSz2A/DyO3SDdmPEU0FbISLKPR
 nvds+
X-Gm-Gg: ASbGncuN1SzLB+xwt8mL+3VywPVohC1f3CrL1QnPp22Okaqs6p4lP83v7CVuLizaAih
 6Zl63Pjsn576km+wYaauT0FxeY7OFKcw7uJX+qQMNtOrNbRAWAH4d8sYZoPAwUQxff6Hi5/nA09
 1V4W6hptcqnVbZf+Qq4jhzhFHndEcNqhXaXEofxSUDhtLrd5pTFeZY64rvMj3tyLPEACyywYQX6
 lYcRwe90KVoZ/HZbk+anK6fsALZpxnutirScdXrrCQI9o8D1g1qcb8mhCwbO5IzwfMV6f/v36YC
 MqdYsx1HRqCwmIk9s8x/xZ8zRMv0QdORP6W3P6JtSz+XcG+UJtgsuIP+wOFGmR62mhBZ+NbPdev
 U8jmLEPr+0wFoKm3DwsJH5Bj3Xxsy9rVzd2yLgyP89gZm824tPk+4xrhbKOmTqokCAQGg58nic/
 0Osw==
X-Google-Smtp-Source: AGHT+IGBZfM98QWYDh+mIZnSDSPulPKqFMZhVKjuBe90JIqA5Nt8pj1ruV7Ayr0dQF1rg5KGV3Dyhg==
X-Received: by 2002:a05:600c:190d:b0:456:1560:7c5f with SMTP id
 5b1f17b1804b1-45b479b8f95mr24444435e9.14.1755699685081; 
 Wed, 20 Aug 2025 07:21:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077788b39sm8003934f8f.47.2025.08.20.07.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Aug 2025 07:21:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/5] docker: Stop building 32-bit MIPS images
Date: Wed, 20 Aug 2025 16:21:06 +0200
Message-ID: <20250820142108.46639-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820142108.46639-1-philmd@linaro.org>
References: <20250820142108.46639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
("meson: Deprecate 32-bit host support"). Besides, the Debian
distribution we are using to cross-build dropped support for
MIPS as of Debian 13 [*]:

  From trixie, the architectures mipsel and mips64el are no
  longer supported by Debian. Users of these architectures
  are advised to switch to different hardware.

Next commits will remove support for 32-bit MIPS hosts. Stop
building the mipsel Docker image.

[*] https://www.debian.org/releases/trixie/release-notes/issues.en.html#mips-architectures-removed

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                                     |   2 -
 tests/docker/Makefile.include                 |   2 +-
 .../dockerfiles/debian-mipsel-cross.docker    | 180 ------------------
 tests/lcitool/refresh                         |   5 -
 4 files changed, 1 insertion(+), 188 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/configure b/configure
index 274a7787642..2d85a6a156c 100755
--- a/configure
+++ b/configure
@@ -1347,8 +1347,6 @@ fi
 : ${cross_prefix_microblaze="microblaze-linux-musl-"}
 : ${cross_prefix_mips64el="mips64el-linux-gnuabi64-"}
 : ${cross_prefix_mips64="mips64-linux-gnuabi64-"}
-: ${cross_prefix_mipsel="mipsel-linux-gnu-"}
-: ${cross_prefix_mips="mips-linux-gnu-"}
 : ${cross_prefix_ppc="powerpc-linux-gnu-"}
 : ${cross_prefix_ppc64="powerpc64-linux-gnu-"}
 : ${cross_prefix_ppc64le="$cross_prefix_ppc64"}
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3959d8a028a..ac8ca1fe3a0 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -82,7 +82,7 @@ endif
 
 # For non-x86 hosts not all cross-compilers have been packaged
 ifneq ($(HOST_ARCH),x86_64)
-DOCKER_PARTIAL_IMAGES += debian-mipsel-cross debian-mips64el-cross
+DOCKER_PARTIAL_IMAGES += debian-mips64el-cross
 DOCKER_PARTIAL_IMAGES += debian-ppc64el-cross
 DOCKER_PARTIAL_IMAGES += debian-s390x-cross
 DOCKER_PARTIAL_IMAGES += fedora
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
deleted file mode 100644
index 4d3e5d711bd..00000000000
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ /dev/null
@@ -1,180 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool dockerfile --layers all --cross-arch mipsel debian-12 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-FROM docker.io/library/debian:12-slim
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
-                      libglib2.0-dev \
-                      llvm \
-                      locales \
-                      make \
-                      meson \
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
-                      python3-sphinx \
-                      python3-sphinx-rtd-theme \
-                      python3-venv \
-                      python3-yaml \
-                      rpm2cpio \
-                      rustc-web \
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
-ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
-ENV LANG "en_US.UTF-8"
-ENV MAKE "/usr/bin/make"
-ENV NINJA "/usr/bin/ninja"
-ENV PYTHON "/usr/bin/python3"
-
-RUN export DEBIAN_FRONTEND=noninteractive && \
-    dpkg --add-architecture mipsel && \
-    eatmydata apt-get update && \
-    eatmydata apt-get dist-upgrade -y && \
-    eatmydata apt-get install --no-install-recommends -y dpkg-dev && \
-    eatmydata apt-get install --no-install-recommends -y \
-                      gcc-mipsel-linux-gnu \
-                      libaio-dev:mipsel \
-                      libasound2-dev:mipsel \
-                      libattr1-dev:mipsel \
-                      libbpf-dev:mipsel \
-                      libbrlapi-dev:mipsel \
-                      libbz2-dev:mipsel \
-                      libc6-dev:mipsel \
-                      libcacard-dev:mipsel \
-                      libcap-ng-dev:mipsel \
-                      libcapstone-dev:mipsel \
-                      libcbor-dev:mipsel \
-                      libcmocka-dev:mipsel \
-                      libcurl4-gnutls-dev:mipsel \
-                      libdaxctl-dev:mipsel \
-                      libdrm-dev:mipsel \
-                      libepoxy-dev:mipsel \
-                      libfdt-dev:mipsel \
-                      libffi-dev:mipsel \
-                      libfuse3-dev:mipsel \
-                      libgbm-dev:mipsel \
-                      libgcrypt20-dev:mipsel \
-                      libglib2.0-dev:mipsel \
-                      libglusterfs-dev:mipsel \
-                      libgnutls28-dev:mipsel \
-                      libgtk-3-dev:mipsel \
-                      libgtk-vnc-2.0-dev:mipsel \
-                      libibverbs-dev:mipsel \
-                      libiscsi-dev:mipsel \
-                      libjemalloc-dev:mipsel \
-                      libjpeg62-turbo-dev:mipsel \
-                      libjson-c-dev:mipsel \
-                      liblttng-ust-dev:mipsel \
-                      liblzo2-dev:mipsel \
-                      libncursesw5-dev:mipsel \
-                      libnfs-dev:mipsel \
-                      libnuma-dev:mipsel \
-                      libpam0g-dev:mipsel \
-                      libpcre2-dev:mipsel \
-                      libpipewire-0.3-dev:mipsel \
-                      libpixman-1-dev:mipsel \
-                      libpng-dev:mipsel \
-                      libpulse-dev:mipsel \
-                      librbd-dev:mipsel \
-                      librdmacm-dev:mipsel \
-                      libsasl2-dev:mipsel \
-                      libsdl2-dev:mipsel \
-                      libsdl2-image-dev:mipsel \
-                      libseccomp-dev:mipsel \
-                      libselinux1-dev:mipsel \
-                      libslirp-dev:mipsel \
-                      libsnappy-dev:mipsel \
-                      libsndio-dev:mipsel \
-                      libspice-protocol-dev:mipsel \
-                      libspice-server-dev:mipsel \
-                      libssh-dev:mipsel \
-                      libsystemd-dev:mipsel \
-                      libtasn1-6-dev:mipsel \
-                      libudev-dev:mipsel \
-                      liburing-dev:mipsel \
-                      libusb-1.0-0-dev:mipsel \
-                      libusbredirhost-dev:mipsel \
-                      libvdeplug-dev:mipsel \
-                      libvirglrenderer-dev:mipsel \
-                      libvte-2.91-dev:mipsel \
-                      libxdp-dev:mipsel \
-                      libzstd-dev:mipsel \
-                      nettle-dev:mipsel \
-                      systemtap-sdt-dev:mipsel \
-                      zlib1g-dev:mipsel && \
-    eatmydata apt-get autoremove -y && \
-    eatmydata apt-get autoclean -y && \
-    mkdir -p /usr/local/share/meson/cross && \
-    printf "[binaries]\n\
-c = '/usr/bin/mipsel-linux-gnu-gcc'\n\
-ar = '/usr/bin/mipsel-linux-gnu-gcc-ar'\n\
-strip = '/usr/bin/mipsel-linux-gnu-strip'\n\
-pkgconfig = '/usr/bin/mipsel-linux-gnu-pkg-config'\n\
-\n\
-[host_machine]\n\
-system = 'linux'\n\
-cpu_family = 'mips'\n\
-cpu = 'mipsel'\n\
-endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
-    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
-    mkdir -p /usr/libexec/ccache-wrappers && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-cc && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/mipsel-linux-gnu-gcc
-
-ENV ABI "mipsel-linux-gnu"
-ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
-ENV RUST_TARGET "mipsel-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
-ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
-# As a final step configure the user (if env is defined)
-ARG USER
-ARG UID
-RUN if [ "${USER}" ]; then \
-  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index d3488b2679e..6a70e1dc497 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -214,11 +214,6 @@ try:
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
 
-    generate_dockerfile("debian-mipsel-cross", "debian-12",
-                        cross="mipsel",
-                        trailer=cross_build("mipsel-linux-gnu-",
-                                            "mipsel-softmmu,mipsel-linux-user"))
-
     generate_dockerfile("debian-ppc64el-cross", "debian-12",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
-- 
2.51.0


