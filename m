Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD2CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2zP-0007G3-Ga; Mon, 01 Sep 2025 07:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yx-0006mQ-9P; Mon, 01 Sep 2025 07:45:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yo-0001IZ-44; Mon, 01 Sep 2025 07:45:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2445806e03cso47820245ad.1; 
 Mon, 01 Sep 2025 04:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727139; x=1757331939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=io12k5COHOK3Yc/em6rq8KtQkvhygCFM2FsEAygkmkY=;
 b=XPNaqIGaD8PNDWxeDI0+8eZSR17g8twtl8L22t4tm3B6c+8hm+LSgEjcInDSMr/PLq
 9+7PbDZkMPxWiIkmVkRbMalv6/jNd2Wbo/rr5Fw38PHTBpD6LYuxJsL5ou5Im+pGqDK9
 K7HdeFbKL7kYJFWLINodS4KHZStbSZiPe6IRce/HIDJyavwsGq0fl12YGj930DHrXMBk
 urxKe6pXutw/qkOeABci0B8N1/JLw1+q7uYy4nhooDMHudUB5PYbUGvGYE73hp7Fe+iZ
 4kDhFKpaqzkr9B/VJrKQ9oHiZMbreQs1DxXhF7UMnWTRRl7C88JSJiVeIKE5nPubP+0C
 xeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727139; x=1757331939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=io12k5COHOK3Yc/em6rq8KtQkvhygCFM2FsEAygkmkY=;
 b=oSdjNgRU+4A03AD7ryfPlo6AwPB1drixGvOKt1qkmR2Z5R4uSV4eXScjCWdKqsmDV6
 KiKGkMCpRwQPAHgORfWhwsF4rusIavIj9C1WBpPm6qru+lOgtz4XXw8db1HNTAXtzCX5
 /BrMUkAGcYiCNaoefu42GcQ7QFud2QJS4KSSHrXNU6ZwS0A82BpS/DiJgOfXwj1nZWWy
 IsomVUNXzclM1SZhTP1wU6yVxG9MHpKNK2CHcF1NDAIjEy5xzNXrbNDaWUJo+hC45sg/
 bPk3XEdKjokYRG29MDfV9fG7pHtb3U2g5RlSOB78mrUFuEEyWlOqAsc8u7BDmj4y2Dvr
 2r7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+MtUO2O33vpVnbLyHpKxkWDX3Qqw8Ih9K9mcIKIIfQCCG5Ln4NSJMy/2d3bcz/Hkw+aAsqoINw==@nongnu.org,
 AJvYcCX7uD8VzcOpYVej//qmy5rraeCIa49W83t/1zwCwpH1wtSN7qJf8ZncT8vOR4EF3I3e49CN8Yituom5IQ==@nongnu.org
X-Gm-Message-State: AOJu0YzfBMVSoMqnAEJA8wGJN+BnkhMIRrMHnkLBZ5WrTakWl65IA93q
 7d5O9aG3WAQW34VQGeZPm5zv1DheREaPY/lirffRwngGNAQqGP3uL9Y1ehHzFA==
X-Gm-Gg: ASbGncsUOJFQOKiVLLZwInyh6qzJBfs7GDC+Ewg6g/jrSYi1d88K1SWhLFPCw6LqXa7
 Lqa+0dF24jg/z2GUwHOl5s8hp8j6RG6NUKwRU0wpC5c2NNzY4bdx4y2c+lWMSkurDU0ly2e14U0
 S3vKMU6QqsknTKv3WEpujp1vWYdHBzMG5aaCMIcnfHg4bmFFkLn8bHe4V8JF0McLcHJKJz++d3U
 NgZU3RCoPZUgabqNrZtQKxwRODROPgrX85BBsaAboMjWeNI6tUoWoxkjnl/fudp0rE6a3IgBUp/
 8U7GIN2qE6tdyqPpCN3C4TocXfqWhlVeetN3L8ATwREVNetIkcAu5ZyhYBJ4USlOXWZ0sV63QvX
 JTTqKRpIODCOgAG088r8fYoEbgRMHyNG2
X-Google-Smtp-Source: AGHT+IEvGePlQn9QMKxmtmqoa8FIVGL1cCpeRfOkWdgU8ix3zc0C3oTbwMqiTJ9WQn4JsCCwDGwPmA==
X-Received: by 2002:a17:902:ce09:b0:240:8ec:fe2 with SMTP id
 d9443c01a7336-2494487448fmr85433825ad.4.1756727139512; 
 Mon, 01 Sep 2025 04:45:39 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:38 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 03/35] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Mon,  1 Sep 2025 20:44:05 +0900
Message-ID: <dd1d5aee5cc69ad95f6cf11106cf020bc3bc4b59.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

V3:
- This commit is under review in another patch series so please ignore it
  here.

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


