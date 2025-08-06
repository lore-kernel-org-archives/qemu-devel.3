Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302BBC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhZK-0002T7-O0; Wed, 06 Aug 2025 13:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPX-0007Ji-Ev
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:42 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPV-00038E-J9
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso100741b3a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754495436; x=1755100236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x9rJebi4ww0j3yzQwPP8A8E8ND6zxr0JuowMgv1Zjc=;
 b=VX7AE0NV+U/it1jolnK3Pvi43lrmFhk7PKRA+QkhuoeT8Hme+BNbvHs1kfmgqDSjQe
 kkKdn5Lsi5hPHGhrRwhKlp9LMFJJRrlzsAfJC+dFiQYA24RK1rfb4F0ljDwlrrVCmhzW
 Z/dyIN4BYoaOUXZPVFCZdLlrXW5xAHMrYEOTA6YzXEFhKFULBIYB9sM8nCc5RswPNbdI
 /mcv/5S9BHB2Yc4ZRdxj+sgMY7zpMXMXLpsruWx2G9NWKNh/Krml5wctArbLGqbxn0gb
 DBkuu8sLw4TLAQ/lny65yyLq8gQdk9vyuumYCVDZmBBzBcmv2ltrITtEIBUGU7Ov5Xj7
 VJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495436; x=1755100236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x9rJebi4ww0j3yzQwPP8A8E8ND6zxr0JuowMgv1Zjc=;
 b=ne9ymEzfFoDybmwiOp+anK4f6iOxdZrW/0UjU+1cJPnWUGZaHbRjkBMUhlgROTTHoV
 y/db7Oo4iW3LIJ2ER2vWQgSyTaGnj+cPqc9RxsUHeyQpD1VNGJ7lz0aDnPdVq0J6HCjz
 hhKJ72d407s4Pzr9ZPGY9Q1MQbWv9IP59MhWSK/CAji1vcEPxuKAmp9Qqa7avxYoO50c
 Dtn4/P3GK1y6eyJdgCr739uM57miUhtsMjAnDfdUhmrLJhcpr2rpVDRsbkyOwMdjHn7B
 jTwcp7YsqQd/vrFGxaJBCC55j6xLNTfwc62FHOs45RnCSw02Id4t5geXSAM2TItYYWve
 v91g==
X-Gm-Message-State: AOJu0YwGCA0vDECbHt12+1j7QW2NkRsVMI30rxQ5sBSiDsTTtoTllXAo
 gBxbl/6izP7MyXu0QOMtL+Jgg0C3N0TOqTJCayRnQ9zms79t+NjoA7QKmOjV9Q==
X-Gm-Gg: ASbGncvtLaZgKOJZ5LsTs+qBXefuLjZyFNnzp9ni2nktZwehHmWyvHlslMmnqasacOA
 akcPB176j/zl++1GVVi96ZtKN/unpGObuHsVyQHT5K96P2KPn1VcyKiQEk73MQtLDjusooXZ3rR
 Y3k+8mrw/mplsF+Kxh6BlnzmECnLa3sbFwxG6TWXUkqit1rOgMCmUOkvwyk/CexBgc0tC/R9BfJ
 ItwbrAAo3k5sLLymR6DHwHIY3skXV8bF8HRVQxxrza0jbWWtt176WLAQO6lp/PgmxK1OBV+Sf94
 ScwmYOT/9K1RMd53iB6QWkJNMbmT3IVJa7TPMa2K3ZT0k2mcxck/yFE+/WJa5LWRZZgpr967YOG
 6PzC9DRGpYC+GSLD2PYlxhA==
X-Google-Smtp-Source: AGHT+IG6xzIN3ultW80XyTJTvNIb7qd2LMqbOS5wuQRpE3mTzy5C5zlTUOeAX42jEvWorZ1dzOFR7w==
X-Received: by 2002:a17:902:f60c:b0:240:2145:e51d with SMTP id
 d9443c01a7336-2429f625afemr55702845ad.31.1754495436010; 
 Wed, 06 Aug 2025 08:50:36 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:4cca:cbdb:3f01:1165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a3asm163374575ad.87.2025.08.06.08.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:50:35 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Thu,  7 Aug 2025 00:49:50 +0900
Message-ID: <bdaf29b98bd83174ef5246548f516eadae508211.1754494089.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754494089.git.ktokunaga.mail@gmail.com>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit fixes Dockerfile of the wasm build to support both of wasm32 and
wasm64 build. Dockerfile takes the following build arguments and use these
values for building dependencies.

- TARGET_CPU: target wasm arch (wasm32 or wasm64)
- WASM64_MEMORY64: target -sMEMORY64 mode (1 or 2)

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..433a44118d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -647,7 +647,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
-F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
similarity index 85%
rename from tests/docker/dockerfiles/emsdk-wasm32-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm-cross.docker
index 60a7d02f56..4b41be62ab 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -1,14 +1,17 @@
 # syntax = docker/dockerfile:1.5
 
-ARG EMSDK_VERSION_QEMU=3.1.50
+ARG EMSDK_VERSION_QEMU=4.0.10
 ARG ZLIB_VERSION=1.3.1
 ARG GLIB_MINOR_VERSION=2.84
 ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=0.44.2
-ARG FFI_VERSION=v3.4.7
+ARG FFI_VERSION=v3.5.2
 ARG MESON_VERSION=1.5.0
+ARG TARGET_CPU=wasm32
+ARG WASM64_MEMORY64=0
 
-FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
+ARG TARGET_CPU
 ARG MESON_VERSION
 ENV TARGET=/builddeps/target
 ENV CPATH="$TARGET/include"
@@ -33,8 +36,8 @@ RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = 'wasm32'
-cpu = 'wasm32'
+cpu_family = '${TARGET_CPU}'
+cpu = '${TARGET_CPU}'
 endian = 'little'
 
 [binaries]
@@ -46,6 +49,16 @@ pkgconfig = ['pkg-config', '--static']
 EOT
 EOF
 
+FROM build-base-common AS build-base-wasm32
+
+FROM build-base-common AS build-base-wasm64
+ARG WASM64_MEMORY64
+ENV CFLAGS="$CFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+ENV LDFLAGS="$LDFLAGS -sMEMORY64=${WASM64_MEMORY64}"
+
+FROM build-base-${TARGET_CPU} AS build-base
+
 FROM build-base AS zlib-dev
 ARG ZLIB_VERSION
 RUN mkdir -p /zlib
@@ -56,17 +69,19 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
+ARG TARGET_CPU
+ARG WASM64_MEMORY64
 ARG FFI_VERSION
 RUN mkdir -p /libffi
 RUN git clone https://github.com/libffi/libffi /libffi
 WORKDIR /libffi
 RUN git checkout $FFI_VERSION
 RUN autoreconf -fiv
-RUN emconfigure ./configure --host=wasm32-unknown-linux \
+RUN emconfigure ./configure --host=${TARGET_CPU}-unknown-linux \
     --prefix=$TARGET --enable-static \
     --disable-shared --disable-dependency-tracking \
     --disable-builddir --disable-multi-os-directory \
-    --disable-raw-api --disable-docs
+    --disable-raw-api --disable-docs WASM64_MEMORY64=${WASM64_MEMORY64}
 RUN emmake make install SUBDIRS='include' -j$(nproc)
 
 FROM build-base AS pixman-dev
-- 
2.43.0


