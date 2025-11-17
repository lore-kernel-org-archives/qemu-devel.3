Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA1FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1Uk-0003lV-Ev; Mon, 17 Nov 2025 10:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UL-0003cG-6P
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:58 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UH-0007x3-Nw
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso12545465e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394592; x=1763999392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fr7TAfPGI4EjkEoYpy34hrh8j2zoqJ1qF1FmM1UdQgQ=;
 b=BrVdr16bYNN6xBfkd9Qr8Xwwf5ESq7BJpm7N6dHcY4kmax+i1oODFHCJpOpjs7TUoO
 Q5lVQlvPj204Mf8Tx8PagETsKtCrClGmYVy+0Jf7Fwu6LZBTuZ0YunHRXM9EcjDhkvSJ
 JQZz2lrPAB0iAjJCElFcvrshcX3vc7W7rKKXMpVai8MtKRLdGCb193wMH6AaV3e7gxRl
 l0K+5fsgsQNd6dcQZ4Bp1MQz++Y0MJeszcEY0kgx8F91/i+eWPIbPTUK/WmylZn5Es/O
 5pG0Tn81kSq7rR3kTHZVi49aHX4C6x1xqL0ca80du5q7aewDALJginm6cwkSM5mRZGqM
 wczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394592; x=1763999392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fr7TAfPGI4EjkEoYpy34hrh8j2zoqJ1qF1FmM1UdQgQ=;
 b=TkH2BL7C8dLxQ60qhCytXXr624qifokIWl5eZDkmCddvcbruE/884zOaEazMI6ZIjl
 loGcv72ZqmbnUywyoiNPTMNMZLATx/q+B6RP5rXxOVns3eZA/PlH13wrbIniMoGVzZzt
 4iwcusJJt7dnSWS18tEKryjsAD5jD7UUAckMrhhV88bwaX52i2W3vDPPZIQDysxNVB/v
 C1DT14znGMthNkkwlVUmPjwSM1i9yBVSb/a+A8OH6nOiCuCDyvTG3lFWCCwKegteE/jW
 L1PfMFJjr1DxgZ/Gc7w2NdnRPOhxUIwmSqB21efkGoOCiZJcBZLpy8ePhF3YsPiMUyDP
 I/Pg==
X-Gm-Message-State: AOJu0Yw2dBw3f2tI+nh83q4+tg0qVCw7WvllQH/AkLoEY2z1ZhJH8PS5
 VyNqVVu9F2Atwbi/k1sKxn7p5k40Tg1n3IPaWaJg1o00OkLM7kQOFuNLatcAlBDJJdo=
X-Gm-Gg: ASbGncsz1gRPNpvZBe0Vp/DyqU8hFzFCYY9k5aHgeNchrgHnKdqqU+OLTOmxyDEzGRl
 FJC7TnOrYxZKVhvFiJU5Ztvz3DcYkMWQDT4rIgnr5EORUjD2NWAmkF9Qly+gElq66P+m3SYfcZa
 gI8rDbXsPgqQ7OfPxuODtVewjnRmPoJpJbshE54u8/16eQdanu2Z1g3IZV+Pi5K0w0tfrESOz0D
 HEj5QUGPrcdqhK+LUstOtYkCMm1cOzTwfc8lbeFSIcp4kAVgWWIY8Q5Kx5Uhd5FOr7DxtWH3o83
 0Nas0OQA1vRUlKmKxIJZZvoUCHifuhxmLx5NEXqzDL5onaF6/kk5jpVQPcZkpc9OmoU67YZ0nu5
 YytjjHgj3R2PNNSTnL4NPfSSNzP9OoRHHgs18MbW9cexQG1EehjpRRgYEUzOIoXaEKfCZeqVKf1
 2TAl+U42HNm/Q=
X-Google-Smtp-Source: AGHT+IEz7gHu5S5zi0omMRAIjrVmEloFP/E5B6H6vNWdkHUQSMgYeGzopXofa5ru/MJkHkjhg6EREw==
X-Received: by 2002:a05:600c:19d0:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-4779e0c124bmr64641315e9.2.1763394592289; 
 Mon, 17 Nov 2025 07:49:52 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779d722bc5sm130034415e9.2.2025.11.17.07.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:50 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C9D8B5F8C8;
 Mon, 17 Nov 2025 15:49:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/18] tests/docker: add coreutils to the package list
Date: Mon, 17 Nov 2025 15:49:33 +0000
Message-ID: <20251117154948.4122164-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
Message-ID: <20251117115523.3993105-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


