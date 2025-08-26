Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CC2CA0FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGx-0003nf-2r; Tue, 26 Aug 2025 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGl-0003g9-CE; Tue, 26 Aug 2025 12:11:36 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGi-0007lq-NR; Tue, 26 Aug 2025 12:11:35 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4c3d8bd21eso173318a12.2; 
 Tue, 26 Aug 2025 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224688; x=1756829488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kdhJ8qVaboMFQEuaKJAhE/K3VU7nR9Fg/XwpkOOA2I=;
 b=KW7k4OVxN/+9+e4akGHbmSQGXnDb847jFGLolZ+sDhic1L9CKQ1GVQ/8a3uTkyfVw2
 EQBkgAS99KaHqSC27FQqixVIS8wBSN7woNSnTF3diuP/uavWzMyLe1TvWkLode0tuIJY
 Ym0BcAR5HrSGW/DCXGHxj3a8fwg4E/d8ks3NKZIEzRT+u6Pdjge55hVOnebGjPerjGAW
 weWDVKHAV9sYVCC6E6xA6DFG3QWVxyJ5PXhJ8gCbUVdaJopacNYSVchvf6Uxo4+8Yv2f
 YZf7LIBranOgfdq81XAGCKzVyrh1OKmaWSZc0UqG2WPcdAApLPUzZPwVvHhE7Ab6DBJW
 xmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224688; x=1756829488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kdhJ8qVaboMFQEuaKJAhE/K3VU7nR9Fg/XwpkOOA2I=;
 b=ZjWtkJ1zVexWaDg3qvQEorJ8LN4hhwKiof1YaQD6gn8xsvozSMEUPGRTBMa3Dy2vCw
 6uJwop51moVaHCii3MYwQn4sNgMvJ7hXGd/wA7sxeSXQ44kDkADtfMYWTk+GVl2Dwe+u
 B12x/XegpNZI2rkMyXKBziMe1YCQHYa7zuZY7HVhjaPBy69f2qdfUGXrPvG0eJ4nWVP+
 l0zzU2Dmr53/8SYRK3QMYIdSM27dgI9e2s6SgVaYf3VUTQIbgfakYpni4gE/XSRcomJ8
 AwD2hQLS7F7Wzm+GoY0uDKfWnWZz1IiJ2ujd+g7RuhVykbEilYLRS8T9hP51bVRuCGth
 iB1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYBL5cAvO8tLTbn5hy9aOXhQVF06lwIc2Oz1e2f7cffGa+5jFUj0GYh1VX69qnSpElusqueLrWig==@nongnu.org,
 AJvYcCXsiZB0KXCSN9D1xr3haaBMwP4gt3i2sU61adrDMk7XLILR433g474Q6+VoxRiTx+tSAbN2z3DvKNL17w==@nongnu.org
X-Gm-Message-State: AOJu0YwgHmPiTeQJmhPmPGpSqRH1owB7ArbKbu3Y0l3y4O88OfQdbj7N
 giJDgM0I77+VTPaDJfpSRXqNArU7UEVUTEhBFVTvFS9+sXfwxa4Pd1B4PWhKFw==
X-Gm-Gg: ASbGncvrEnUDRYTuKTMDLIKiL8ZtowE4uspvzlGufpoxH9Y/QH+kJwAemfI8pv73KPc
 DMsoQnkABy/BzA9lZO9dIv6OxuptekzdkdzhaDAldTmbbk/AXtDH+nmuyzrDZWzPqQlGNvUE7Ot
 xcovRJT+pbHd2ipH6uoBe8sp8QpdlRuXyJmsIdA/hzUhuQwcTsJiHdqSQI7eH/cVQwjkifEnJDz
 K2/8k93D4jBVy0fPG1FbDZhr3SHDH4JfY9EaEE977Ne4CJPvSQzl+fDkojAxoN5ISBrF+9Y+zUP
 4ol8Am6DjGLkmg1scQ7oYSWoCjcjHChGHIpID0c054TRYIAReXm9mq4hfKIZan82fmQO7cKdMH0
 LBtiFwygNMatgh1+QiGV7Pg==
X-Google-Smtp-Source: AGHT+IFzvxQCHKPwaGwQEGeld5cnUhg5+g3NLLqLFlCfWoXgneEah+9GpE/7wzlXmT9xhRivPIefOA==
X-Received: by 2002:a17:90b:3dcb:b0:325:4731:cea5 with SMTP id
 98e67ed59e1d1-3254731d6c8mr14741705a91.31.1756224687782; 
 Tue, 26 Aug 2025 09:11:27 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:26 -0700 (PDT)
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
Subject: [PATCH v2 03/35] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Wed, 27 Aug 2025 01:10:08 +0900
Message-ID: <dd1d5aee5cc69ad95f6cf11106cf020bc3bc4b59.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x531.google.com
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

V2:
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


