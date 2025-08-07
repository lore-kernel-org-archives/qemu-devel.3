Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AE5C87FD3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujquS-0007vG-6f; Wed, 06 Aug 2025 23:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu8-0007k9-Nu
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:58 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu3-0002IN-U6
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b34a6d0c9a3so531513a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754535769; x=1755140569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x9rJebi4ww0j3yzQwPP8A8E8ND6zxr0JuowMgv1Zjc=;
 b=BKsOLxx5PWrs5ILSsqWCXYpLombax7Or0zjWNuA7eAgqKXnU+UmP4RlNNidHEOc3xV
 hbfOOjlYwolh6wDfZq6DoycvaRe9Kv7NeCrnSQ127/N8tP1Z6hlC3+Z7DowLStHppXtk
 6KCbyBjil4sn7TXSeriYuV37Hvc/mwKclfS5PXc1+aXw2Y1sB9X20UCdBQvx+QHFufq6
 FhFXT7w+5YWIk8kuZ7h93Ka9VmPHS0gA4LkOrmbK7g8yluEuPh5OF0qmKxK7U30OnuA2
 qEf5VhoJtoHwp7dbBlOg4aoXdfEVkehwrLDRODOoO9axXuBztNplzpopO2jDCh5ucz7Y
 yR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535769; x=1755140569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x9rJebi4ww0j3yzQwPP8A8E8ND6zxr0JuowMgv1Zjc=;
 b=BeMKELgsniHwdDz0jczHPVorLd4tizeTX0VlOAKgV4t3+Xo72DR0vpv6/gdsETfSrq
 96fzAHx/dv+ATAmaRN4d0Ha8WrKwgH0UWbtyPcS9lWxR/VRoQX/emyVBSqvztvt+tzHK
 wWSfToK6cvVPEGb4Efaacy4DTJaQnHZd2xxhGZ4jCJBm6owhqbUvXFHBoARzBlpDca53
 Lie7HeZU3YgDWjkApS16qUDjyZteZHVZfEDgmZZuqJ130goS928H4+AWv16J87ajWkJQ
 iz0Jt357vwHyAQhvH0W1sS2c+z7YMcKx+0YRd2gGqOHH3TQSI1iXvWghnOl1XJ86sdS+
 IYQA==
X-Gm-Message-State: AOJu0Yw8Kf9qt45unG4YL9DMyEFLbLFytf38uan1WROasLSP3kxIKqIP
 6IyIKlT6Fih54gmMe/MkztFzDRlurvOvrYeQarzb+IE4908qPUSbkKCDIITvEA==
X-Gm-Gg: ASbGncud1VLI3hXtvWKY9MBApzwiDhqETSHxVEptUQtaRhpYkAr0N0Jsx5LRavpNKu5
 1dyfPru4PpBuoJb+QfBAdDMTfJv60BKObDIfKnptV7CIXtdD0R4wsKl2AaFOFQGK9ei4vUblPcT
 TPiavNBxAUa7N+OTaQfg9FT+cLpnENVL3wRlH6Ht481+NwVF3VmTyuvvZUFPDFX9ubSOuEY7Iwp
 9OpppIvUk1sB3DDWxwD5Q6MOdGX+8SZtYAssTZQrP1twyJ0+Clzkc/sVsiDQUjKnm2UxA9F7Aey
 IbK8JV4z3JB1OR934saMuM2e2CSCWVdODg8x/5xPTG0dBj3hrnve0fEG+B+fo5pyeOlINGPQ6Dw
 f2ZqwKC+pKPthZd1/OpnjyDeYbRKzkQYm
X-Google-Smtp-Source: AGHT+IG9i/jBc35U7sABGPGaOcHa2S53whkpuFMkbi5OnXE7zJqQEZlDP1ID/7Vp3cjb+k2wcCU2hw==
X-Received: by 2002:a17:903:ac6:b0:240:7f7d:2b57 with SMTP id
 d9443c01a7336-2429f4ae04fmr52416815ad.28.1754535768800; 
 Wed, 06 Aug 2025 20:02:48 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:81e2:9f1d:777a:7b46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6ac6sm173154585ad.1.2025.08.06.20.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:02:48 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Thu,  7 Aug 2025 12:02:02 +0900
Message-ID: <d995965f035f6a3ec57382497b204a425f7efaf2.1754534225.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754534225.git.ktokunaga.mail@gmail.com>
References: <cover.1754534225.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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


