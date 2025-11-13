Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F479CD5BBC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWK-0007hS-F4; Thu, 13 Nov 2025 05:25:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWG-0007YM-F8
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:36 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWB-0007HY-17
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:36 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b73161849e1so101818366b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029530; x=1763634330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OstTs3jOG57kEFzMPI8pVdlBewu1zEirJvZ3MJtQmm8=;
 b=bqpbq76Ic0u6bsWX2qWRRINceUsPVS4bPJUndFjcNwIID2jeY5nM9lstZgOXpuAwT3
 UnaLj96d2TuqI6UxHp/5zDe7I0cdFpxvwK3h2YGVShL2zn7cEWiOqaI/W/Yh/VBO2h3F
 TYZuyUR9/VO8abRiAUK+Bm9pm6oKDUguMQxwJO0O4jDKnTw1G+Cv3HgOygolaS7iIzQo
 zMLGCqZ9bzXjZdjHdtneii48IR7XW96pcpDK/d7sIh7/BpAdZnWR17zQZGCMV9W/wAim
 zlgSoshd2xxbqsy7vPsUBhtsWVbELy5FlCwKSIU6B2hRwqcGZ/JHOJrk6sML9Ihej+p6
 KUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029530; x=1763634330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OstTs3jOG57kEFzMPI8pVdlBewu1zEirJvZ3MJtQmm8=;
 b=XYwyvwAX8nvQ4yvgRxZvI5IkCsyXxV3aIEZN1skod/Ihq23B8B2u4FUY7r7ladN0By
 VgnPU0ruYQ0fblSY049/nHzY9PmFBNk149fUbaT8vdiA+cBkaKiNCX36x0zRZPWBK1qi
 91cAGssfGzn6ENVT4YILHd8QOzxsgsGQAkG50+Z5cYP+wIbZc8qnn3A2tFNYoG9FUc2a
 hAlnN5tcwrb0A65QeLH77+dawah8vlvqfeauZWCUCEhAjEu1ixEz3EVLN3sW6q739WbU
 xonMoiurtmyCM1lToVpChtfUBO/zkzFoTCqHcTC0X0qxIBLzp7X+GEhNFarUPMyHS0kZ
 eB/w==
X-Gm-Message-State: AOJu0Yy10H42dctJDKzWH1OFw4FHFy0JiGIYn/SyHcp8XZgHOW9treCU
 14BVaf9U4boVzh/diXWwqOyVaKT+oXGhiV6bmwUHN+Jvagx2d69jSuD3JbchFgYNkpo=
X-Gm-Gg: ASbGnctrTOIH0apl3xbSeor7mV/07E7CypS/Q7qnO9psXr65Qt6P7FzdwwyBpBSqSjX
 6YeW4MIbT38UNaYV15rFDbm/MHNCAYXyuIt7YUZt7JrzloZAqLBh8CxWUNcZK7qRJGMyv67SknI
 VWcTYebVefJISC9P5JwjpKfDlcodugKamSnzXET2Xe/7qGMgE1g6swWq1le3hd7is39qHDv+MeX
 tpusB0qcUo7YtNBdMZ4KKRrfvktMg9lc0V39uPqSKqUrwa95gRREr/L9AeqjoX9sDj5nY00+Jrk
 7gXm/+UyJX5uJTvvcSWoKUP3aOnfwWCaZNMTmNQKUN36f+i4sog7ZD8TcMvplW2Ih4JtK6lpIWr
 pAugGZ/SPpMCFbBzUcDoX+xosr4T5Dx6JFHMXtzYPMaWh2IKtgsmANGB2uxGLv9wifVXtZTNBaF
 ai
X-Google-Smtp-Source: AGHT+IG8FYzDlaNjL85sKEPkw5FaQt99k9bBn+v+dWCcOorC0xWV3xBAXNGvYm6P7adv5KpYmGsdWA==
X-Received: by 2002:a17:906:c112:b0:b72:7dbd:3bf with SMTP id
 a640c23a62f3a-b7331a97155mr626120966b.43.1763029529239; 
 Thu, 13 Nov 2025 02:25:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa80bf5sm136506166b.3.2025.11.13.02.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A12F5F90C;
 Thu, 13 Nov 2025 10:25:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 04/18] tests/docker: add coreutils to the package list
Date: Thu, 13 Nov 2025 10:25:10 +0000
Message-ID: <20251113102525.1255370-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

We need coreutils to run the IO tests so we need to include it in the
package list. Now we have the latest libvirt we can do that.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus/freebsd-14.vars                   | 2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                     | 2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml        | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml        | 1 +
 tests/docker/dockerfiles/alpine.docker                | 1 +
 tests/docker/dockerfiles/centos9.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 tests/vm/generated/freebsd.json                       | 1 +
 24 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 19ca0d36638..6477440ef30 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
index b039465f56f..4701c388e14 100644
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ b/.gitlab-ci.d/cirrus/macos-14.vars
@@ -11,6 +11,6 @@ MAKE='/opt/homebrew/bin/gmake'
 NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
+PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
 PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index e29c9c18403..25d96cea460 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index d303411391f..6a72eabca9e 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 4ee8630cc43..6001da12504 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -14,6 +14,7 @@ packages:
   - ca-certificates
   - ccache
   - clang
+  - coreutils
   - dbus
   - debianutils
   - diffutils
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 1da375c9158..03dd6851f60 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -22,6 +22,7 @@ RUN apk update && \
         ceph-dev \
         clang \
         cmocka-dev \
+        coreutils \
         ctags \
         curl-dev \
         cyrus-sasl-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index ff3e8069b45..670e22be5ad 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -26,6 +26,7 @@ RUN dnf distro-sync -y && \
         ccache \
         clang \
         compiler-rt \
+        coreutils-single \
         ctags \
         cyrus-sasl-devel \
         daxctl-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index c38ab8247d5..c386b658b04 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 2f62da0f5eb..9d83ab7a32e 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 62e297f5d12..c2077ec7a2c 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index eb9a915d492..db9f04ee93d 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 42e8444d153..7758afd80aa 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 1ab197b144d..cba7f43870f 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 85d2c0ffdc2..24f946d1441 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 4f01eecf416..f476cf65eaa 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 2a3046e7859..a60b4ab01d1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       bzip2 \
                       ca-certificates \
                       ccache \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index c1817f162f6..6c6ab0256ea 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -20,6 +20,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       ca-certificates \
                       ccache \
                       clang \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index e4233b53cbe..8e3b3a9fd90 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -33,6 +33,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ccache \
                clang \
                compiler-rt \
+               coreutils \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 1da425768fc..4f743c00434 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -26,6 +26,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ca-certificates \
                ccache \
                compiler-rt \
+               coreutils \
                ctags \
                dbus-daemon \
                diffutils \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 632259378c9..9278d797693 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -33,6 +33,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                ccache \
                clang \
                compiler-rt \
+               coreutils \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index def0ca9db46..a041d439768 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -20,6 +20,7 @@ RUN zypper update -y && \
            ccache \
            clang \
            clang-devel \
+           coreutils \
            ctags \
            cyrus-sasl-devel \
            dbus-1 \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index c8cc6249296..23b33d6ad44 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -19,6 +19,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       ca-certificates \
                       ccache \
                       clang \
+                      coreutils \
                       dbus \
                       debianutils \
                       diffutils \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82812e77365..1ee7dcf3d46 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -13,6 +13,7 @@ packages:
  - clang
  - cmocka
  - column
+ - coreutils
  - ctags
  - cyrus-sasl
  - daxctl
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index c03e1cd5863..f586827b136 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -15,6 +15,7 @@
     "capstone4",
     "ccache4",
     "cmocka",
+    "coreutils",
     "ctags",
     "curl",
     "cyrus-sasl",
-- 
2.47.3


