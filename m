Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0713D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaaa-00054n-Sj; Thu, 15 Jan 2026 22:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaa-00054d-6v
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:32 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaY-0005DD-Ex
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:31 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso969044b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534409; x=1769139209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yguf5MQWeecW8uYtbHFfNKk14zdSjyRF1HRDoDaJ2G0=;
 b=vsMdzBlPMbZKasNre2RnjtsPTlb/4HTHQZfLoPI25nnIs3bKzafN+ljQltmLELrJ9L
 Q4ZNtdrCZErk4BIaDigFPJM3YifzC56b6RU7FyPIlCYdu69ld10oepu3uXCzkvJdbLRF
 /QS2U9kBWw2oQ9Rg4wq+sd9SR64FPg2hu+DIqH0F5jw/cSymzKzOSkXWEff2R2CMEGuq
 qMpEkrS9T5kgmNfEvcHcCcsizzvpQsKR2FHuyspeUpPlMM10a8R/Ego41eJ/mne05/0m
 DIutue7bzxRE1fNX7K48CDcvlniIhPcclvyklkHlqIG7SR9hTq74BT9QajIY+vl5ohWC
 9X6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534409; x=1769139209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yguf5MQWeecW8uYtbHFfNKk14zdSjyRF1HRDoDaJ2G0=;
 b=W1IoGjuwEr8fgdEjJyppritA/93aduvvH82tUJdDvv+LXX+wQxLXZ95MjVPdRb8jLH
 5Fe7N2Jzu5UYYbmDE6ZxNgPIg2yEgzErMBzxGIZntgbvVVCUrK0z9jYKZvOitB0PSaXr
 GFUNpsQRNF8M+7MuQoTtjXSHofDADpc9J9DBe194+rOs0dGcNm3kLLOyF7KqCrGd1t9z
 hX9EC/Bo+GXv69Tjwuw5UGlJMC9y9Xsxd2fdHIphOBrx5vK/oUi3stnEGmEWzM7iTTJ6
 dRoShWgaBjycsgY5XgziqjzYBfGuIJOJylx11KVJPI8aV0StPFgfdJw38MIes/WgvTzB
 wWDw==
X-Gm-Message-State: AOJu0YybLxXsnxCoIjzx8wS2cjE864gIygN86xxJZxWhxw9cgJbvigrv
 3w5pnVubjNu+36GMJMd1vhqkN9jojFqZDV2lC2kYkLnAD5v8MPT+URa2Nqf5yu1sRYom0lfN4HR
 p0ExPvJof2g==
X-Gm-Gg: AY/fxX7/xJbYDSDVHEAf4T0WTqYeQdDs9FA8VoxhTZR4VHjC3PCKBmQrgfUk1FqoYGr
 M5VDZMGgR+RenoKCybmbz3qOpblVQ5dBnThkJwfUnFT+cCjk0THfwdmanu5Syha+W2AaWnEHEPB
 fdrqnZimG5Dqaeg44z4Hy9KBfdP9w/Vee8iqqsxHw9zEfithkPwASzJMzysnip1C4lz/WellE6L
 XxJKMZy1asUyAe/JiIcijbJdSn0SfSSRvbqgTcQEwXqAzeeBMC4kVz4mSWmCmWH/mx/V9Q5BFuu
 BOoBO2xBm72ssN9pT7W3xtYWrIE8P5ZkALyyqetGou4KqtOqgIJt+Mk7w+QClBl21OU/K3ZvSeA
 DD5uXpiIizgDKjbbA7QWAk3J/CysnLX6YSxuT+995d4jTEq9yMZKjSmITTEIW40cg05n7Hb/WjZ
 BnW7Y91TgyObtWUsF6uw==
X-Received: by 2002:a05:6a00:1884:b0:81f:3fa0:8c39 with SMTP id
 d2e1a72fcca58-81fa189743dmr1072891b3a.67.1768534409058; 
 Thu, 15 Jan 2026 19:33:29 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 03/58] dockerfiles: Add support for wasm64 to the wasm
 Dockerfile
Date: Fri, 16 Jan 2026 14:32:09 +1100
Message-ID: <20260116033305.51162-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

This commit fixes Dockerfile of the wasm build to support both of wasm32 and
wasm64 build. Dockerfile takes the following build argument and use it for
building dependencies.

- TARGET_CPU: target wasm arch (wasm32 or wasm64)

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f21342f50e0412a32143fe21ecc0d8db95b3f37.1768308374.git.ktokunaga.mail@gmail.com>
---
 MAINTAINERS                                   |  2 +-
 ...2-cross.docker => emsdk-wasm-cross.docker} | 26 ++++++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (89%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ddbfba9f0..de8246c3ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,7 +683,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
-F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
similarity index 89%
rename from tests/docker/dockerfiles/emsdk-wasm32-cross.docker
rename to tests/docker/dockerfiles/emsdk-wasm-cross.docker
index 1f08eb0b85..ecd5a02903 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -1,14 +1,15 @@
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
 
-FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
 ARG MESON_VERSION
 ENV TARGET=/builddeps/target
 ENV CPATH="$TARGET/include"
@@ -29,12 +30,22 @@ RUN pip3 install meson==${MESON_VERSION} tomli
 RUN mkdir /build
 WORKDIR /build
 RUN mkdir -p $TARGET
+
+FROM build-base-common AS build-base-wasm32
+
+FROM build-base-common AS build-base-wasm64
+ENV CFLAGS="$CFLAGS -sMEMORY64=1"
+ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=1"
+ENV LDFLAGS="$LDFLAGS -sMEMORY64=1"
+
+FROM build-base-${TARGET_CPU} AS build-base
+ARG TARGET_CPU
 RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = 'wasm32'
-cpu = 'wasm32'
+cpu_family = '${TARGET_CPU}'
+cpu = '${TARGET_CPU}'
 endian = 'little'
 
 [binaries]
@@ -56,13 +67,14 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
+ARG TARGET_CPU
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
@@ -140,6 +152,6 @@ RUN sed -i -E "/#define HAVE_POSIX_SPAWN 1/d" ./_build/config.h
 RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" ./_build/config.h
 RUN meson install -C _build
 
-FROM build-base
+FROM build-base-common
 COPY --from=glib-dev /builddeps/ /builddeps/
 COPY --from=pixman-dev /builddeps/ /builddeps/
-- 
2.43.0


