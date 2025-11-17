Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A36CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1V6-0003sj-Of; Mon, 17 Nov 2025 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UI-0003c1-Ug
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UG-0007wV-Qo
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:49:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477632d9326so30702275e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394591; x=1763999391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45D7C+rKnIIOPHmY3OmANHDsvvvqhjdZFX6coAGide8=;
 b=Yy4GVpCCWUeRzETG0IitihThO6PG7cUQ3j8NjhOUTJCLE8ln7S5Wa0TpjW50saQkZ1
 IQONnZVqoMN4e3NWnfncgKgDhJEap97IhnoHKBpP68K8UVz7SRJ4V0g48SzIm0K4msVs
 xelYfy2EykK13OO2M7iCZNy7MokFgFJUN0TCxdFiXh6oEjsNhYptWWI2NDqtkvrt5/sT
 3Yvz6UW+dmg/niRskLzsJHgkSbGMNW7uWqrkdOzerbmnqPo9SYWiTnn7FVI44O+gEWnM
 Fw57u7tEMF3KVvlR8or3HDG+oOY7FTETwSDrCF5q6kMT6akIqRENJf86WWPvjgTqM7IP
 9yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394591; x=1763999391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=45D7C+rKnIIOPHmY3OmANHDsvvvqhjdZFX6coAGide8=;
 b=klMC4IV+bqVhZrz+asSO8o5HvW4Zj08KsaXCJRVlIrl6kCJ1AkVtBP/tRhLJV58cwq
 22cHJFXws5sLO8aZ7ZVDIJSPfsI5qT5IGLb1m7lfahw/IaxEco2+2y+eo9x78zvQ9CsK
 wYAkrhhuiLkf6eedk8U3NO1iPuKSiJ1HMtWwie+22cjG/Da1vaDlrBg4Xz6Hr/Bf10fw
 5PIyEUOBqzI36jDuV8I8C1DdwfrhR89Y9IZVy3QU4sAd83AUpb6AzmQOmRR5jfw/5L+E
 ZgVnSTYTRWhGVpZcb11FLEGKoxgEEI0dQhTELqn5saiFQ4aaHWQ7b/zThvnhuUzkYWX+
 VMCA==
X-Gm-Message-State: AOJu0Yz0P8R6w8y9wk9B9wJYXXv/HLxAMLXhxRVpUe8GA/5lBfRHykmg
 ESZqnYaag6UjHZGSys6kd7G2MdyiGM9VgD6W53OVkEU4dLs7bPadNLqD6xsdUzeWKCI=
X-Gm-Gg: ASbGncuQ1+a3alaGuUInmjvdcCVy1SEk3crZprilvHy3jpEWkSz0vD3ot+9ZeG/VWy6
 fsjF6hkMlpQDZkTmo6MJIzkccDtzqfSy1IW9Yxcj1el+qMPA9EzB1OUXj/fSLZupm7fD2kY93WW
 bfZA1Dzm/G2rVsRU9eUcBbqIJytuH8MNzWTzXCs11x/3VdiFvtfUAjJYnPj/fs3Wq0ZBHxPM3hl
 eNmnzgwTI2cstdHMukvoGzmMzW+h2opd2NulcjeYw3aOBbrHgtjibMlVOH+arc/9v0+fF702Eql
 m4Kel/V9jZ98Y3hXv8UpifHmhnxTR5xjdkYxv+En3mgfN5Yxlro0Eqi6uijWoZWrlYnxxHjER3r
 kMVVRWFy5JxmOCSOtGLsMxxIy7S9FBbxDDkfJWM26bzVKkXPv//jgySwPAH3+OYMbndhDINLep2
 Uu
X-Google-Smtp-Source: AGHT+IHG7o4qtrArBWAhdtMxAWNHOIo34DCBta+YnwWk/IcUL3SOJlEVa5wGxs1cVMR5NBH/Q7ZB3Q==
X-Received: by 2002:a05:600c:4505:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-4778fea8810mr134747275e9.30.1763394590787; 
 Mon, 17 Nov 2025 07:49:50 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e442c2sm322982415e9.7.2025.11.17.07.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 969815F8B9;
 Mon, 17 Nov 2025 15:49:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/18] tests/lcitool: update ENV stazas outputted by refresh
Date: Mon, 17 Nov 2025 15:49:32 +0000
Message-ID: <20251117154948.4122164-4-alex.bennee@linaro.org>
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

Now lcitool has been updated to use the non-legacy ENVs we should do
the same for what refresh adds.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251117115523.3993105-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 26a39940126..c38ab8247d5 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -181,8 +181,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/x86_64-linux-gnu && \
 ENV ABI="x86_64-linux-gnu"
 ENV MESON_OPTS="--cross-file=x86_64-linux-gnu"
 ENV RUST_TARGET="x86_64-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-linux-gnu-
-ENV DEF_TARGET_LIST x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=x86_64-linux-gnu-
+ENV DEF_TARGET_LIST=x86_64-softmmu,x86_64-linux-user,i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 4b0163fa1b9..2f62da0f5eb 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -180,8 +180,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/aarch64-linux-gnu && \
 ENV ABI="aarch64-linux-gnu"
 ENV MESON_OPTS="--cross-file=aarch64-linux-gnu"
 ENV RUST_TARGET="aarch64-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
-ENV DEF_TARGET_LIST aarch64-softmmu,aarch64-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=aarch64-linux-gnu-
+ENV DEF_TARGET_LIST=aarch64-softmmu,aarch64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 742031ce0a2..62e297f5d12 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -177,8 +177,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/arm-linux-gnueabihf && \
 ENV ABI="arm-linux-gnueabihf"
 ENV MESON_OPTS="--cross-file=arm-linux-gnueabihf"
 ENV RUST_TARGET="armv7-unknown-linux-gnueabihf"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=arm-linux-gnueabihf-
-ENV DEF_TARGET_LIST arm-softmmu,arm-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=arm-linux-gnueabihf-
+ENV DEF_TARGET_LIST=arm-softmmu,arm-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 1ccfde2e4bb..eb9a915d492 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -177,8 +177,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/i686-linux-gnu && \
 ENV ABI="i686-linux-gnu"
 ENV MESON_OPTS="--cross-file=i686-linux-gnu"
 ENV RUST_TARGET="i686-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=i686-linux-gnu-
-ENV DEF_TARGET_LIST i386-softmmu,i386-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=i686-linux-gnu-
+ENV DEF_TARGET_LIST=i386-softmmu,i386-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index eeb77212d5d..42e8444d153 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -176,8 +176,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mips64el-linux-gnuabi64 && \
 ENV ABI="mips64el-linux-gnuabi64"
 ENV MESON_OPTS="--cross-file=mips64el-linux-gnuabi64"
 ENV RUST_TARGET="mips64el-unknown-linux-gnuabi64"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=mips64el-linux-gnuabi64-
-ENV DEF_TARGET_LIST mips64el-softmmu,mips64el-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=mips64el-linux-gnuabi64-
+ENV DEF_TARGET_LIST=mips64el-softmmu,mips64el-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 9b3dca44f15..1ab197b144d 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -176,8 +176,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/mipsel-linux-gnu && \
 ENV ABI="mipsel-linux-gnu"
 ENV MESON_OPTS="--cross-file=mipsel-linux-gnu"
 ENV RUST_TARGET="mipsel-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsel-linux-gnu-
-ENV DEF_TARGET_LIST mipsel-softmmu,mipsel-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=mipsel-linux-gnu-
+ENV DEF_TARGET_LIST=mipsel-softmmu,mipsel-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 15c6b436d31..85d2c0ffdc2 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -179,8 +179,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/powerpc64le-linux-gnu && \
 ENV ABI="powerpc64le-linux-gnu"
 ENV MESON_OPTS="--cross-file=powerpc64le-linux-gnu"
 ENV RUST_TARGET="powerpc64le-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc64le-linux-gnu-
-ENV DEF_TARGET_LIST ppc64-softmmu,ppc64-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=powerpc64le-linux-gnu-
+ENV DEF_TARGET_LIST=ppc64-softmmu,ppc64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 2591c4adc96..4f01eecf416 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -179,8 +179,8 @@ endian = 'little'\n" > /usr/local/share/meson/cross/riscv64-linux-gnu && \
 ENV ABI="riscv64-linux-gnu"
 ENV MESON_OPTS="--cross-file=riscv64-linux-gnu"
 ENV RUST_TARGET="riscv64gc-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=riscv64-linux-gnu-
-ENV DEF_TARGET_LIST riscv64-softmmu,riscv64-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=riscv64-linux-gnu-
+ENV DEF_TARGET_LIST=riscv64-softmmu,riscv64-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 57aa3209c5c..2a3046e7859 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -178,8 +178,8 @@ endian = 'big'\n" > /usr/local/share/meson/cross/s390x-linux-gnu && \
 ENV ABI="s390x-linux-gnu"
 ENV MESON_OPTS="--cross-file=s390x-linux-gnu"
 ENV RUST_TARGET="s390x-unknown-linux-gnu"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
-ENV DEF_TARGET_LIST s390x-softmmu,s390x-linux-user
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=s390x-linux-gnu-
+ENV DEF_TARGET_LIST=s390x-softmmu,s390x-linux-user
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index bbb920c6815..c1817f162f6 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -169,7 +169,7 @@ RUN cd /usr/src/netmap/LINUX && \
   ./configure --no-drivers --no-apps \
   --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \
   && make install
-ENV QEMU_CONFIGURE_OPTS --enable-netmap
+ENV QEMU_CONFIGURE_OPTS=--enable-netmap
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index e6f84dd556f..1da425768fc 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -112,8 +112,8 @@ RUN nosync dnf install -y \
 
 ENV ABI="x86_64-w64-mingw32"
 ENV MESON_OPTS="--cross-file=/usr/share/mingw/toolchain-mingw64.meson"
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32-
-ENV DEF_TARGET_LIST x86_64-softmmu
+ENV QEMU_CONFIGURE_OPTS=--cross-prefix=x86_64-w64-mingw32-
+ENV DEF_TARGET_LIST=x86_64-softmmu
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index df186caffe6..3a31fcfee9c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -121,7 +121,7 @@ debian13_extras = [
     "  ./configure --no-drivers --no-apps \\\n",
     "  --kernel-dir=$(ls -d /usr/src/linux-headers-*-$(dpkg --print-architecture)) \\\n",
     "  && make install\n",
-    "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
+    "ENV QEMU_CONFIGURE_OPTS=--enable-netmap\n"
 ]
 
 # Based on the hub.docker.com/library/rust Dockerfiles
@@ -162,8 +162,8 @@ ubuntu2204_rust_extras = [
 ]
 
 def cross_build(prefix, targets):
-    conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
-    targets = "ENV DEF_TARGET_LIST %s\n" % (targets)
+    conf = "ENV QEMU_CONFIGURE_OPTS=--cross-prefix=%s\n" % (prefix)
+    targets = "ENV DEF_TARGET_LIST=%s\n" % (targets)
     return "".join([conf, targets])
 
 #
-- 
2.47.3


