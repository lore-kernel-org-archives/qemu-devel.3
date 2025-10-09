Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9ECCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 19:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wgr-0007gu-JM; Thu, 09 Oct 2025 15:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgj-0007dr-D1
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6wgg-0004VX-FJ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 15:52:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e37d6c21eso8453555e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760039548; x=1760644348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhUoExjkumxb1mfVALZ2GeOgFNw1j12GnXp1Z99TJtQ=;
 b=CAO65/xI4AJ5FginrUFcCTiSA51YSDoKpuiDqhYmvnTt6eEtZJSr4ToKiq9bonISuz
 XmZGVDnxM+OxOq3poCLzth2LqhjeH4KCFEPiNPdeoDwUB2AMa2Y4edME3HzKaQuGae8u
 QNs4oFDmdMT1mkJMspX3+BFyvaBuTunBj8jrbeN05D14Nr+3U2Ky3a/KHAXCEKLjF/a8
 5+bY3+ZwPqmRFGIaOpvcyCFUwAnlhTJlMRdmTC+QPINBD14B6qe3tzfT0NI4b3SLNPtB
 bZCtGpBvEYHlz1+X0p7fb6eB9xafI28dfqkUwcdUuWkKyMgYeNJM4mJm7WOzEwi+K/FF
 VP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760039548; x=1760644348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhUoExjkumxb1mfVALZ2GeOgFNw1j12GnXp1Z99TJtQ=;
 b=OaNW/q25dgFSXVegpOauHJa/5P8P21jqNrvwiTKdZB9gwQul0N7nswcw8bfjHke0+Y
 CXv4PAIvsxHNk/MpYpMMxxgBgfObh4Gy397aINpPRnhcD/BF6J5IxF2Gjxu9cPr3iaHY
 8dnS/gh3n5yacy+ahI8g9dgIayjwK4vGU2CEeD7rukgS88VWCdHGCzO+GPIMtqLS7W+K
 xQ5nndNRVSm5cK8VgrKusEtltB0pbMJX2aitDPx4SdMd3QIkvGpvQ9XXR8oxVAi36DD5
 yqUNE4GE8sOyCfg/LNjmjMP2gXo8hr0QXHVdYgjCBQPL2grTk25hqhr5XyI54hSSgsIc
 TgIA==
X-Gm-Message-State: AOJu0YzNAabe+4MSPcKVVkPfrbC2P1eoPFiAUbO0hZDKW10jyYZuFlBw
 pPPjB3xeYQrxHwK3dDV++o8YsR2fHoo4kcXLtyAm86S1miIr6orjnpDNNvrxJj2NPqbWGW8aiJ6
 bjv7mk3eqynlF
X-Gm-Gg: ASbGncsbEeL682noZ9emzNmFhfvK+5b7rhQoC0D/RvTr6vaNtkVgRT9RQ1Xia0Di6Lt
 FUUmRtgFsoQRXBS2rrOO+2Zdzgp5+anGlT1V9vpupZDKxTPQoRAoOsLMKYcyrtILdYIJRQnHW2W
 h6FqZraOv65VOOTysgoPGol39PQhu5zoJ0qnIgSBKELlfsBukUvadZh40cBa1hquhgYi/Pz/WS+
 XKQjwfQtf9jVRfsLQKyztH9G2Y+F5YFtgLNZ3+OnLPsZzKsD2pafGQlmlCA6clm8MY0h6sZHnhv
 bT4nQJUCnX3/2lWHtZaG71ctSzXkrXMtV69uH7BH1GiYsIWpgjrSxiNIAtk5b52kBde1fwkZbAe
 fn5CwNCEVrqvIygcaOyso4FPtGt3pxmDDExvP87SqYwKx3lm2yhLCDdplwLg2exXnlZ2HZfVbOx
 qIefvMFLVMoxlzGFO1mVIYrSVv
X-Google-Smtp-Source: AGHT+IHimdpxfUo2klfM+kl50K8hMfOiSU0nB2thzCAZvdY0KJTDlCaDxydxg8BijeNzYDfN/Foaow==
X-Received: by 2002:a05:600c:6383:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46fa9a8f146mr59748485e9.7.1760039547717; 
 Thu, 09 Oct 2025 12:52:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36ed3bsm46812215e9.0.2025.10.09.12.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 12:52:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 3/7] docker: Stop building 32-bit MIPS images
Date: Thu,  9 Oct 2025 21:52:06 +0200
Message-ID: <20251009195210.33161-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009195210.33161-1-philmd@linaro.org>
References: <20251009195210.33161-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 configure                                     |   2 -
 tests/docker/Makefile.include                 |   2 +-
 .../dockerfiles/debian-mipsel-cross.docker    | 187 ------------------
 tests/lcitool/refresh                         |   5 -
 4 files changed, 1 insertion(+), 195 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker

diff --git a/configure b/configure
index 461b53dd605..6a633ac2b16 100755
--- a/configure
+++ b/configure
@@ -1360,8 +1360,6 @@ fi
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
index 5f4e3fa9636..00000000000
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ /dev/null
@@ -1,187 +0,0 @@
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
-                      python3-venv \
-                      python3-wheel \
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
-RUN /usr/bin/pip3 install meson==1.8.1
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
-                      libstd-rust-dev:mipsel \
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
-
-ENV ENABLE_RUST 1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 056cfb6e9d7..39bfc7e1113 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -225,11 +225,6 @@ try:
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
 
-    generate_dockerfile("debian-mipsel-cross", "debian-12",
-                        cross="mipsel",
-                        trailer=cross_build("mipsel-linux-gnu-",
-                                            "mipsel-softmmu,mipsel-linux-user"))
-
     generate_dockerfile("debian-ppc64el-cross", "debian-13",
                         cross="ppc64le",
                         trailer=cross_build("powerpc64le-linux-gnu-",
-- 
2.51.0


