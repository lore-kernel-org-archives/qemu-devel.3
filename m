Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D1D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtYX-0000uR-IK; Thu, 08 Jan 2026 12:12:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYW-0000tj-8G
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYU-0000Hk-Gd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-29efd139227so26524155ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892333; x=1768497133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3hPq5nnBVZFbgfle8XGAVUtD1GKUlumskUvVM+cv9Mg=;
 b=X1Y3kvkJ3cZ608AbkXMQd4th7SiZbdCgcA1FmyXyFc7SPKknqZDDQDA576vdnuW5em
 3+Yza5FOZqCfv/JkeVqmIUVt4gO5SsJUCp41M9fRuBIkf8v12NaekgVG3ey+9YqKv63b
 rvqU9IjD4ukHq1Gj/r3kN8Zg2EKNMWqFFziud/B1Pc/+jPAge1hPQLE0wgS74rBK2eCb
 AiApVAS4BngmfHurFDYL2tURypQLNOj/7QmUiTCbIRjQ2HuhHOXHZ9DGRR1RW/zuiHGp
 VQGSJRc8JhwvY89kjYUbXA2GVIe1l0q0PYGTKRbB9t+40G02gGJTdxp71WwoVe03miK4
 yRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892333; x=1768497133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3hPq5nnBVZFbgfle8XGAVUtD1GKUlumskUvVM+cv9Mg=;
 b=mUO/mmjlQh6+D0oe3vqOMdtI6/2rwyax65czYYaXon44JUqETY0KJ5/vZNF7RqL/LF
 HGOl4+2xEYJVG6dFif2K+2i/cazbuQHLCXnOPWRwf2yPP+GICNnlrRb4ZbsOmstksFES
 E37YIPpiZItqMtPKDRawCf7H5lFKA72jZbb8snv815YjhTKIz9DRT5zYdyLlcxsgfkXf
 VrMpvbGahemplHsc7//iEs2p4YVUyi/xuDUfe4+HhwiGB5BlGxs9T8QI59zEilKCPShK
 xcDHXvdhZzzb+8AwdN5q3vQVqa2//HXeERk4JJ/THNZdTKqZEKzalwopDyj0H9NNF+kT
 4wqA==
X-Gm-Message-State: AOJu0YxRD8biN3hRLxP/3zrLrJ3dmU0TstnxMSqCjNY8Iba+bqfeNsO2
 S6K8ITgJNlcsAGJlvTmd9oQVYeyvrDqkEoMzfIfT2v2Rxsg0Irg3Zf0fkdZZH7Mr
X-Gm-Gg: AY/fxX466fjefRwV+ghpZwB77LIHnruxyHwo/W31BigmIxJx0y6pMklw8o4WXXP83OO
 8pa3UmVuvbGjKUDeqt8kf2d//RLW17ZmsDot7gKbJBCW+PBp7hczDzKQv4xmMqdIprmCaoxlUun
 lFppSt5lp1lpDXRORSmQkJmbMkN8Us4CTku1ZbljPVD85ePyxGymqybSZ7mRd48TqjzDAPYsLZE
 ABB3ZkLtIaNbmPDy7qUwWBWnnI2yqRAvYpbcdc0dgeZC6u/KlUjsKJ07QqUwig8/K5ECJwNKb8z
 5M4LuGWDBtVA5aOU6UOH1WI4SSkiLKf4BrnuZe/P+67riqjcyS3Mux6+zxRzXYLv312WQCzcEQV
 3zjBVOyq0QXAjTQUy7XVvdTKc9Lnn/3fg12gpbTVvf1Dx5xsSbQ32aJdNlxQsoTo4A2Y3cYLpgQ
 ARV1LI/mW/0w==
X-Google-Smtp-Source: AGHT+IHznpWxzk3tMO+9AIYVCVoItuMAGCeF+/coFuDe3gg+rv/rdigB9ZwWV0Wf6DZUuuHNZ7ut7w==
X-Received: by 2002:a17:902:e841:b0:2a0:9411:e8c0 with SMTP id
 d9443c01a7336-2a3ee4b580emr63729965ad.32.1767892333107; 
 Thu, 08 Jan 2026 09:12:13 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:7ace:63ca:408f:4cc4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm82808355ad.3.2026.01.08.09.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:12:12 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/4] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Fri,  9 Jan 2026 02:11:27 +0900
Message-ID: <bd5596d373b9b801c5ca838d316bea4c5aba4674.1767886100.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767886100.git.ktokunaga.mail@gmail.com>
References: <cover.1767886100.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
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
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (86%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a55b649e8..22974fdd73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -671,7 +671,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
-F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
similarity index 86%
rename from tests/docker/dockerfiles/emsdk-wasm32-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm-cross.docker
index 1f08eb0b85..fa2c723dff 100644
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
 
-FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
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


