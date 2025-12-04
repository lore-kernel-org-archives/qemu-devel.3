Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD750D29FB2
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKD-0006yX-IQ; Thu, 04 Dec 2025 14:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKB-0006x5-KW
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK9-0007LN-74
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:11 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42e2d5e119fso617477f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877747; x=1765482547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zg4xRZhuaR8wJhUP+XuTXHROpM79t4M5zqxXh+ZdiQA=;
 b=bYkligrYmyYn/m7A/yVoQsof3ULsblL+UEZ69nNoJ3t+GFGSOD+yqENR7VyRTzqawQ
 N9pfBXS2msG0oUKuhQ2kiDRollfhcKIP2c281UX8wzDdhYoealuDdoujL0ulQChKxXzP
 edqv31V99dqPakIMMMrar18O5bBvwV/nI0+mx5Vf4A333F04iMebatk7hX6sbKU8QzXt
 08TxMACzhxUi84WH/Z+4rb5QH+kSNmPqIq/zz+a2Jboy4iip6ZhVff08jT7CWqgPjpXd
 H/N1vXBXWD1HDBrGquLQOwnyjKdVXUOCtv4GeQlggU1I4JmZhhpRSUJm7MpJcng7a9lQ
 NVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877748; x=1765482548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zg4xRZhuaR8wJhUP+XuTXHROpM79t4M5zqxXh+ZdiQA=;
 b=hGULw/hHqFc56ackzZbMIgWl1dJNuFLz0wI7Nr06R+Z7Mvu8Af8LopdHBbS4dxClls
 zi7UHoolz/y3wzU9nnIxTRlZDySOzjvYXT409i471MYJIgSqz7EXlD9prQXEIZJKvsRD
 shL9TOwZxDFep9tjOtqKNDkzj4uyX8u+OpjWlPx8RFiJ5Sfw9JKO4o6s/Btqkzf4Rh50
 rmYXZONdWXs11KLwG0LmWHbyDGTgPle9I0FP8VaoTWX3/f9s+OA/piWM7qba+NJ9gHOH
 PTpA/Y/3jzGkGCCDs9w4K8LZ9mHCWAH+aKILruzfR0DKtqATDS0RLipMgtP2oHsNqytf
 ApcQ==
X-Gm-Message-State: AOJu0Ywfp7ASUxxwrQNUxmage2iAcjzCpC2ZHYQTTbq8fsjwSC1d+kAg
 TiSmzQe7j1JbKMeKoWGi9b4Ydxs3wVdF69WNBsWGeR+kCRqGo1grAkrRZrjaFcnLoa8=
X-Gm-Gg: ASbGncs1+cnRyy6RGrtcnAmPV9W4uLzhjCcSwI2JqCN9HJycAt5KQlRqyecRzarYuh4
 0b0/0wnhW+DToHS/49f9CCCDbQboRHK++/NgL2K4jqlxUfTxoZC/4oj1BowLLypGfEQ2advfjv1
 ZArxqh8KrLseDSW6T9qxSaiwbIH1CO9EuyQzC0pxOPnyT+O5NxKnuFTVYlw3tb3QuUoaEzDamj0
 fYN6xnc01IWZyE9MThlSAHGqNLE4OPGEbFJj4xMOCOv1bt9qvlEyZ/ZBTsn2yCYOx5QHKhHPKAW
 8PDzEEd4hn/2+KqARzA/X1MZXtiKP+3rC0Dx/YOpquem7ZR9K6tWSKXFVpI6p7rpsEZzs+QmAWt
 rPocNcLsfevlzhz1fBKg2mK30F4lC1Faa4Y6ZxioQQPNd5Fha+MOd4w8c2eO0LQGw1+DMcOaZBk
 /URfbKeUtCkcU=
X-Google-Smtp-Source: AGHT+IFm1/DZw9OpFQybmxsWqi6Q4CG5TZomW42C6M4qbvVHsbjsMPzQ0Q3lzmT1+HS4E125iWS+YQ==
X-Received: by 2002:a05:6000:2903:b0:42c:a4e7:3975 with SMTP id
 ffacd0b85a97d-42f731e928fmr7141440f8f.30.1764877747446; 
 Thu, 04 Dec 2025 11:49:07 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm4976288f8f.22.2025.12.04.11.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 362AA5F8FD;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 06/11] tests/docker: transition debian-all-test-cross to
 lcitool
Date: Thu,  4 Dec 2025 19:48:57 +0000
Message-ID: <20251204194902.1340008-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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

While we are at it bump up to debian-13. As we use this container in
the CI runs this also has the benefit of ensuring our qemu-minimal
dependencies project really has just what we need to build a basic
QEMU.

We add a few extra packages so we can build with clang as well as what
we need to probe for the available cross-compilers in the image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add dpkg-dev, clang and libclang-rt-dev to extras
---
 .../dockerfiles/debian-all-test-cross.docker  | 129 ++++++++++--------
 tests/lcitool/refresh                         |  49 +++++++
 2 files changed, 124 insertions(+), 54 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 420a4e33e60..1b01cfe8504 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -1,77 +1,98 @@
+# THIS FILE WAS AUTO-GENERATED
 #
-# Docker all cross-compiler target (tests only)
+#  $ lcitool dockerfile --layers all debian-13 qemu-minimal
 #
-# While the normal cross builds take care to setup proper multiarch
-# build environments which can cross build QEMU this just installs the
-# basic compilers for as many targets as possible. We shall use this
-# to build and run linux-user tests on GitLab
-#
-FROM docker.io/library/debian:12-slim
+# https://gitlab.com/libvirt/libvirt-ci
 
-# Duplicate deb line as deb-src
-RUN sed -in "s/Types: deb/Types: deb deb-src/g" /etc/apt/sources.list.d/debian.sources
+FROM docker.io/library/debian:13-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get install -y eatmydata && \
     eatmydata apt-get dist-upgrade -y && \
-    apt build-dep -yy --arch-only qemu
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bison \
+                      bzip2 \
+                      ca-certificates \
+                      ccache \
+                      findutils \
+                      flex \
+                      gcc \
+                      git \
+                      libc6-dev \
+                      libfdt-dev \
+                      libffi-dev \
+                      libglib2.0-dev \
+                      libpixman-1-dev \
+                      locales \
+                      make \
+                      nettle-dev \
+                      ninja-build \
+                      pkgconf \
+                      python3 \
+                      python3-pip \
+                      python3-setuptools \
+                      python3-venv \
+                      python3-wheel \
+                      sed \
+                      tar && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-# Add extra build tools and as many cross compilers as we can for testing
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        bison \
-        ccache \
-        clang  \
-        dpkg-dev \
-        flex \
-        gcc \
-        git \
-        libclang-rt-dev \
-        ninja-build \
-        python3-pip \
-        python3-setuptools \
-        python3-tomli \
-        python3-venv \
-        python3-wheel
+RUN /usr/bin/pip3 install meson==1.8.1
 
-# All the generally available compilers
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
+# extras for cross and alternate toolchains
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
+  clang\
+  dpkg-dev\
+  libclang-rt-dev
 ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
-        libc6-dev-arm64-cross \
-        gcc-arm-linux-gnueabihf \
-        libc6-dev-armhf-cross \
-        gcc-mips-linux-gnu \
-        libc6-dev-mips-cross \
-        gcc-mips64-linux-gnuabi64 \
-        libc6-dev-mips64-cross \
-        gcc-mips64el-linux-gnuabi64 \
-        libc6-dev-mips64el-cross \
-        gcc-mipsel-linux-gnu \
-        libc6-dev-mipsel-cross \
-        gcc-powerpc64le-linux-gnu \
-        libc6-dev-ppc64el-cross \
-        gcc-riscv64-linux-gnu \
-        libc6-dev-riscv64-cross \
-        gcc-s390x-linux-gnu \
-        libc6-dev-s390x-cross
-
+  libc6-dev-arm64-cross \
+  gcc-arm-linux-gnueabihf \
+  libc6-dev-armhf-cross \
+  gcc-mips-linux-gnu \
+  libc6-dev-mips-cross \
+  gcc-mips64-linux-gnuabi64 \
+  libc6-dev-mips64-cross \
+  gcc-mips64el-linux-gnuabi64 \
+  libc6-dev-mips64el-cross \
+  gcc-mipsel-linux-gnu \
+  libc6-dev-mipsel-cross \
+  gcc-powerpc64le-linux-gnu \
+  libc6-dev-ppc64el-cross \
+  gcc-riscv64-linux-gnu \
+  libc6-dev-riscv64-cross \
+  gcc-s390x-linux-gnu \
+  libc6-dev-s390x-cross
 RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-  fi && \
-  DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        ${AVAILABLE_COMPILERS} && \
-        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-
-
+fi && \
+DEBIAN_FRONTEND=noninteractive eatmydata \
+apt install -y --no-install-recommends \
+${AVAILABLE_COMPILERS} && \
+dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
-ENV MAKE /usr/bin/make
 ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 3a31fcfee9c..c5e936112c6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -161,6 +161,46 @@ ubuntu2204_rust_extras = [
     'RUN cargo install bindgen-cli\n',
 ]
 
+debian_all_test_cross_compilers = [
+    "# extras for cross and alternate toolchains\n",
+    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
+    "  apt install -y --no-install-recommends \\\n",
+    "  clang\\\n",
+    "  dpkg-dev\\\n",
+    "  libclang-rt-dev\n",
+    "ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \\\n",
+    "  libc6-dev-arm64-cross \\\n",
+    "  gcc-arm-linux-gnueabihf \\\n",
+    "  libc6-dev-armhf-cross \\\n",
+    "  gcc-mips-linux-gnu \\\n",
+    "  libc6-dev-mips-cross \\\n",
+    "  gcc-mips64-linux-gnuabi64 \\\n",
+    "  libc6-dev-mips64-cross \\\n",
+    "  gcc-mips64el-linux-gnuabi64 \\\n",
+    "  libc6-dev-mips64el-cross \\\n",
+    "  gcc-mipsel-linux-gnu \\\n",
+    "  libc6-dev-mipsel-cross \\\n",
+    "  gcc-powerpc64le-linux-gnu \\\n",
+    "  libc6-dev-ppc64el-cross \\\n",
+    "  gcc-riscv64-linux-gnu \\\n",
+    "  libc6-dev-riscv64-cross \\\n",
+    "  gcc-s390x-linux-gnu \\\n",
+    "  libc6-dev-s390x-cross\n",
+    "RUN if dpkg-architecture -e amd64; then \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross\"; \\\n",
+    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross\"; \\\n",
+    "fi && \\\n",
+    "DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
+    "apt install -y --no-install-recommends \\\n",
+    "${AVAILABLE_COMPILERS} && \\\n",
+    "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
+    "ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools\n",
+    "ENV DEF_TARGET_LIST aarch64-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sparc64-linux-user\n",
+]
+
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS=--cross-prefix=%s\n" % (prefix)
     targets = "ENV DEF_TARGET_LIST=%s\n" % (targets)
@@ -256,6 +296,15 @@ try:
                         # https://github.com/mesonbuild/meson/pull/14991
                         enable_rust=False)
 
+    # We also generate some docker files with minimal dependencies and
+    # as many cross-compilers as Debian will package for building TCG
+    # tests.
+
+    generate_dockerfile("debian-all-test-cross", "debian-13",
+                        project="qemu-minimal",
+                        enable_rust=False,
+                        trailer="".join(debian_all_test_cross_compilers))
+
     #
     # Cirrus packages lists for GitLab
     #
-- 
2.47.3


