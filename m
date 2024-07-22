Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A54C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrSa-0008TV-W3; Mon, 22 Jul 2024 07:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSW-0008Lo-ER
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sVrSR-0002P6-O7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:44:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso2764801f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721648638; x=1722253438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+n8BGOwUhxG6uJAAcZ/OYvOHaCJ7tZUjkrkd4d32s0c=;
 b=XAIwZoDbW9PJbBNMVaJ2/sRfKhN2t+xD4gCAyFZWCis4ceyMc3mDO3cjmbKoBwRrpv
 +DnzQp2X++jEyMIp+DNmE0KBOf+XSbcBDnqnm23cQESVYOp+RL96hxdlZjY0Oql/S1rn
 Sshqhgtx7eYwddFZ2Eu6c9k41fHi1M4YeY15Z9LLkbGwCDYuBka2AySNRZec1H/IwdXm
 OQMuqgifJ5Tw+KXKuCf9a3mFE57OA69bXd7rLIgpipZ9YDdMzQ3qGa+rFoUhPrSueQ59
 K3JQ0faXVHcm9wh+kfRj9gS5266Rd0PNMX7qTLPWdieQk4ecWCY5Q8shhMs3lZuPDKqx
 SIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721648638; x=1722253438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+n8BGOwUhxG6uJAAcZ/OYvOHaCJ7tZUjkrkd4d32s0c=;
 b=XqAvepxSDN9lEpdK/QqbMh9YdWYqw6KW5hXcImbJb8aIjXpLjSpezC6ft2UXNmBAmp
 5wpbP7ROaRW1GAPb7SxUEP63LcM5NOh/qszMQGxHUFKeUOlEN5N9GJG7LqyaR2WcaqyI
 NfRV5gDMl8eXVHKOmg23Igs0l58TmgKInSgQP7simMTnqzc2rhuiK/i1vHzkYIY16WRF
 Gvygbxzmu94LDoJS1pwXAme5KYbAPj+39IwhHFlnvwvAn/W1d0RtgEY7LdrT/IS5au+t
 ceHQrnoU5HdJq5jI0ulX4iFEOG+PZuYPrHKdhTMx/EZe5WUxDLJoAw8lsv7FyiC3RjT6
 yBEw==
X-Gm-Message-State: AOJu0Yz3YezfYrGIL4Ml+i6M/dADh+kJbHxGCWapUmUMBTcG14RFmHxm
 z9uLkhSMlth57HFQZPymX6rjSMHjtc00tT0yKxXJH50QX4eoGdAX+QBBIMdQr5XeBeOsutlfCa1
 5HTU=
X-Google-Smtp-Source: AGHT+IGURgbnoCJNF1OivzIKVIAlSnX52qpcn/AiueU3RjPDaAFRXfhATGrNMpanFDgh24TjMvGeYw==
X-Received: by 2002:adf:f5cd:0:b0:367:f059:4c55 with SMTP id
 ffacd0b85a97d-369bae4cf80mr4553688f8f.26.1721648637871; 
 Mon, 22 Jul 2024 04:43:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eba8csm8323513f8f.91.2024.07.22.04.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:43:57 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v5 2/8] build deps: update lcitool to include rust bits
Date: Mon, 22 Jul 2024 14:43:32 +0300
Message-ID: <49e451adf4a3203760fb671e7509b24a7e31976f.1721648163.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

For rust development we need cargo, rustc and bindgen in our various
development environments. Update the libvirt-ci project to (!495) and
regenerate the containers and other dependency lists.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/cirrus/freebsd-13.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-13.vars                     | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 3 +++
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 3 +++
 tests/docker/dockerfiles/alpine.docker                | 3 +++
 tests/docker/dockerfiles/centos9.docker               | 3 +++
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-armel-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++++
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++++
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++++
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++++
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++++
 tests/docker/dockerfiles/debian.docker                | 3 +++
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 3 +++
 tests/docker/dockerfiles/fedora.docker                | 3 +++
 tests/docker/dockerfiles/opensuse-leap.docker         | 2 ++
 tests/docker/dockerfiles/ubuntu2204.docker            | 3 +++
 tests/lcitool/libvirt-ci                              | 2 +-
 tests/lcitool/projects/qemu.yml                       | 3 +++
 tests/vm/generated/freebsd.json                       | 2 ++
 24 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-13.vars
index 3785afca36..8c3b02d089 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-13.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-13.vars b/.gitlab-ci.d/cirrus/macos-13.vars
index 534f029956..3c8ba1a277 100644
--- a/.gitlab-ci.d/cirrus/macos-13.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index 43070f4a26..d227c5deca 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index fd5489cd82..6f856a5da2 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -7,10 +7,12 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
   - ca-certificates
+  - cargo
   - ccache
   - clang
   - dbus
@@ -112,6 +114,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index afa04502cf..217515f90d 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -7,10 +7,12 @@
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
   - ca-certificates
+  - cargo
   - ccache
   - clang
   - dbus
@@ -110,6 +112,7 @@ packages:
   - python3-venv
   - python3-yaml
   - rpm2cpio
+  - rustc
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index b079a83fe2..fc488c94ac 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -18,6 +18,7 @@ RUN apk update && \
         bzip2-dev \
         ca-certificates \
         capstone-dev \
+        cargo \
         ccache \
         ceph-dev \
         clang \
@@ -89,6 +90,8 @@ RUN apk update && \
         py3-yaml \
         python3 \
         rpm2cpio \
+        rust \
+        rust-bindgen \
         samurai \
         sdl2-dev \
         sdl2_image-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0256865b9e..e6a69c56f8 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -16,12 +16,14 @@ RUN dnf distro-sync -y && \
         alsa-lib-devel \
         bash \
         bc \
+        bindgen-cli \
         bison \
         brlapi-devel \
         bzip2 \
         bzip2-devel \
         ca-certificates \
         capstone-devel \
+        cargo \
         ccache \
         clang \
         ctags \
@@ -102,6 +104,7 @@ RUN dnf distro-sync -y && \
         python3-sphinx_rtd_theme \
         python3-tomli \
         rdma-core-devel \
+        rust \
         sed \
         snappy-devel \
         socat \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 8058695979..62f8c000ed 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
 
 ENV ABI "x86_64-linux-gnu"
 ENV MESON_OPTS "--cross-file=x86_64-linux-gnu"
+ENV RUST_TARGET "x86_64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 15457d7657..42523e9113 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
 
 ENV ABI "aarch64-linux-gnu"
 ENV MESON_OPTS "--cross-file=aarch64-linux-gnu"
+ENV RUST_TARGET "aarch64-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
 ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index c26ffc2e9e..35d42dba97 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabi && \
 
 ENV ABI "arm-linux-gnueabi"
 ENV MESON_OPTS "--cross-file=arm-linux-gnueabi"
+ENV RUST_TARGET "armv5te-unknown-linux-gnueabi"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabi-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user,armeb-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 8f87656d89..1b2c260e5a 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -168,6 +171,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
 
 ENV ABI "arm-linux-gnueabihf"
 ENV MESON_OPTS "--cross-file=arm-linux-gnueabihf"
+ENV RUST_TARGET "armv7-unknown-linux-gnueabihf"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
 ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f4ef054a2e..50ad6179a2 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -169,6 +172,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 
 ENV ABI "i686-linux-gnu"
 ENV MESON_OPTS "--cross-file=i686-linux-gnu"
+ENV RUST_TARGET "i686-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
 ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 59c4c68dce..27db4509b6 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
 
 ENV ABI "mips64el-linux-gnuabi64"
 ENV MESON_OPTS "--cross-file=mips64el-linux-gnuabi64"
+ENV RUST_TARGET "mips64el-unknown-linux-gnuabi64"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
 ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 880c774f1c..725a632e4b 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -54,6 +56,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
 
 ENV ABI "mipsel-linux-gnu"
 ENV MESON_OPTS "--cross-file=mipsel-linux-gnu"
+ENV RUST_TARGET "mipsel-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
 ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 1d55b9514c..c85b43704c 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -167,6 +170,7 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
 
 ENV ABI "powerpc64le-linux-gnu"
 ENV MESON_OPTS "--cross-file=powerpc64le-linux-gnu"
+ENV RUST_TARGET "powerpc64le-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
 ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 62ccda6ab1..022c84b0da 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       dbus \
                       debianutils \
@@ -52,6 +54,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
@@ -166,6 +169,7 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
 
 ENV ABI "s390x-linux-gnu"
 ENV MESON_OPTS "--cross-file=s390x-linux-gnu"
+ENV RUST_TARGET "s390x-unknown-linux-gnu"
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
 ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 0d1d401eb8..c30fab88f7 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       clang \
                       dbus \
@@ -119,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 007e1574bd..d1a1922b35 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -20,9 +20,11 @@ exec "$@"\n' > /usr/bin/nosync && \
     nosync dnf install -y \
                bash \
                bc \
+               bindgen-cli \
                bison \
                bzip2 \
                ca-certificates \
+               cargo \
                ccache \
                ctags \
                dbus-daemon \
@@ -52,6 +54,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
+               rust \
                sed \
                socat \
                sparse \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 44f239c088..bb05ca4172 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -23,12 +23,14 @@ exec "$@"\n' > /usr/bin/nosync && \
                alsa-lib-devel \
                bash \
                bc \
+               bindgen-cli \
                bison \
                brlapi-devel \
                bzip2 \
                bzip2-devel \
                ca-certificates \
                capstone-devel \
+               cargo \
                ccache \
                clang \
                ctags \
@@ -112,6 +114,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-sphinx_rtd_theme \
                python3-zombie-imp \
                rdma-core-devel \
+               rust \
                sed \
                snappy-devel \
                socat \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 836f531ac1..3e8bc8447e 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -16,6 +16,7 @@ RUN zypper update -y && \
            brlapi-devel \
            bzip2 \
            ca-certificates \
+           cargo \
            ccache \
            clang \
            ctags \
@@ -94,6 +95,7 @@ RUN zypper update -y && \
            python311-pip \
            python311-setuptools \
            rdma-core-devel \
+           rust \
            sed \
            snappy-devel \
            sndio-devel \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index beeb44fc28..98ee55f7e0 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -13,10 +13,12 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     eatmydata apt-get install --no-install-recommends -y \
                       bash \
                       bc \
+                      bindgen \
                       bison \
                       bsdextrautils \
                       bzip2 \
                       ca-certificates \
+                      cargo \
                       ccache \
                       clang \
                       dbus \
@@ -119,6 +121,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-venv \
                       python3-yaml \
                       rpm2cpio \
+                      rustc \
                       sed \
                       socat \
                       sparse \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 0e9490cebc..9b2b2ceb80 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
+Subproject commit 9b2b2ceb80a7a215bdfb9000bcc2c1a30457ec69
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 0c85784259..7e85b27b66 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -3,11 +3,13 @@ packages:
  - alsa
  - bash
  - bc
+ - bindgen
  - bison
  - brlapi
  - bzip2
  - bzip2-libs
  - capstone
+ - cargo
  - ccache
  - clang
  - cmocka
@@ -100,6 +102,7 @@ packages:
  - python3-tomli
  - python3-venv
  - rpm2cpio
+ - rust
  - sdl2
  - sdl2-image
  - sed
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 2d5895ebed..3d36c8af7c 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -60,6 +60,8 @@
     "py39-yaml",
     "python3",
     "rpm2cpio",
+    "rust",
+    "rust-bindgen-cli",
     "sdl2",
     "sdl2_image",
     "snappy",
-- 
γαῖα πυρί μιχθήτω


