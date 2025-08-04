Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271F7C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivhk-0006gw-Jn; Mon, 04 Aug 2025 09:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulK-0004Nr-JD
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulI-0000Tp-P1
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:57:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso2525287b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754312275; x=1754917075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk8p4F1HoflijBj7kvVH0absrkNmFbA/1BPCwWNDAoQ=;
 b=JqzwdFd0Ef+5O8dp1x70P+RXjfY1TCO6hbkV7uj/ELAjUyNyPP6FTiXqflvBpcrJS4
 GdfeUN551u5cR1/lNju2pjkaUqe1pXGzdWLVb+fOwCfrGKaOL1EzY0JYGTh5L8AB9pc3
 FPCHDQCJMdlR/uA3EcAD+x949Q/ZdHMan6MVsj3yOSOhmw+s9OUVPSUDF4YcBTC6HC9d
 qjVsASU6vN0ptEjOfvjC75lOumjHu41S+Mo8eTRgCSgkytRjvo6QgTtH9ojmxpIIUU8g
 pVOO1+R+2sJtZTHojrVVzUHtznjBoLRxjmSZvlHFWOCtTjc5YbOEK/xU6APMy8Jd4w2L
 SBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312275; x=1754917075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fk8p4F1HoflijBj7kvVH0absrkNmFbA/1BPCwWNDAoQ=;
 b=fIGEFRmsTqfFTAhndOHTqTqqkOHDXZotx/yzdjNNXcz5/XFfak1ky+Z5gMr6h9zFa1
 QKFqko7JbQ8atvdbbS22ppVHgy7SDACNpN008xAQhJGsEx8q/+RgitXvG8r7+JExJgc2
 5IrRIOQpK9aSJPoniZc+hiqwRqB1jYPYEGRY8WnyW6wjZELzcKuGky6Y63RCKpcPxOdZ
 WK4sc0/wd8bBCPw6hZVSlc835gHRKkFHrF9oWljNF3wHulPDHjliHpqBsdsS5ri1PGhK
 T3t9AV+ymevQP/bI9w6cjtJXHeDNJH/gUADprKf85k0jJi5hz19pwDtJlEZvRubtVpdH
 jh7A==
X-Gm-Message-State: AOJu0YxAYPxk3cezFDmkSvqawwo7XHavdxHckkK5qrpn3xwxQDPETvmr
 QCvrtdgE3swB93WEO9JRLjpx3srxmhq4tS/1iW3iWb+qIELXv1jjB6c+V5f4Vw==
X-Gm-Gg: ASbGnctAvXaGdNHBJqFUXtbHtksgOgBI5fuO0OY1g1PTqD2s4Vr1kHTy0zcFoYgAVVC
 6z3/GkRgS8Rq1gi8UBQYdM3uGMi9J94XSD9/M+DtGDn8j/5IggiqlakCcnmeoB5CII69NhujSYf
 K9w9AKpjYXeEkciTLg6elPr4w/wNTPXivFCX1cGGf+l3n1odWr1osK1DffOeOCBrwBuXZBxdTxH
 CG7FUo6iqFYu4rYZ7ukqTtHS8wjoUn+FuU6nl8bYYUsYK8eJXBTH+s09nP4rNPtBS8SqDOGJSoa
 9XfxQH8+vq8lf+tq2lzDbYOSjmUFIQ7W9nDB6gSRX0Fe+tX9Nz2NdEaPYjBvUBvpoOLM/BS/JT5
 C/ZvxjvI9oKct5NQa2HT/0g==
X-Google-Smtp-Source: AGHT+IErPgoXDN7QRYaZRbdGRg9nvqFHGEycTjJH4moLsXq99uFZ8Vur6xDBtJH0NyqrgTRE/gm8fw==
X-Received: by 2002:a05:6a00:80e:b0:76b:f8f5:2806 with SMTP id
 d2e1a72fcca58-76bf8f53e1dmr7318028b3a.22.1754312275360; 
 Mon, 04 Aug 2025 05:57:55 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:d117:15e5:e721:f1cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm10488308b3a.42.2025.08.04.05.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:57:54 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 3/4] dockerfiles: Add support for wasm64 to the wasm Dockerfile
Date: Mon,  4 Aug 2025 21:57:16 +0900
Message-ID: <cc6f1489159379da7f259f3cfd77e6ded89aeba1.1754310749.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754310749.git.ktokunaga.mail@gmail.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x436.google.com
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
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28cea34271..47b35bae47 100644
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


