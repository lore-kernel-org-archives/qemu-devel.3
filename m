Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD0AC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat3-0000tA-Ut; Sun, 18 Jan 2026 17:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasm-0000UP-0w
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:30 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasj-0000SI-Bn
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:27 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so23698025ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773864; x=1769378664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxgl+NvwjE6afUEeClSmXGywb0xq3jmuZXqbn2txRNc=;
 b=iAMN3JR+EYRKV2pFyTbb3uelOx6rqIHG2Nuan8giu/sUnRmahNPC669SaRW40PFseb
 oaG35tEBmZXX1jnX3jutvGVX9NLo1u3920c4lEc7XEvJGe3bKCMSnunoAnGrhjN31skk
 q0I1oh0noDYwjYrP/3gCCzzCiDvXqJA8Mvxy1EwqN6PiTe1UVkjxd1IwtXX0j2pd34DY
 4Q8jTgfdD1FxeD9+Guoov+FNI0PuHFGn5ledNL9CWWGUaB5/8qYHpF73ICeazUQVXlVp
 /RFTrsvOZ0znhmp0XoBFk0GE4aAvyeI6cebAmC+N4OC0+0184Ka7mAFSbz+MAyqNnvc+
 kaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773864; x=1769378664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wxgl+NvwjE6afUEeClSmXGywb0xq3jmuZXqbn2txRNc=;
 b=OHQ50i50Lnh6+tAClyDi3dS/nDeT7n+BsZmgbiDHKS1klMeyoPcdzvOV6FWjTeM6V3
 01Qd4Oi+6Ay1kfJ/8j4MsJnFudaF1gF2qvqlanCnMjekilDxQDrVEioCSQxo5a7FTMoH
 R9h8i842niBsIO5nlleh2T5QyP7Rw6T2MBorYHecqK5wU6zENY0Ta4X9YinUt8FPjlu3
 MBSUXLNEFRXFXt7WbKjt0ht+dwngUrJh5DsiunwBNyomdc9FG4X+7tadEQpNDqFzDgif
 s0DeyHBEHdgnIBnnUlPi4s+M0nratlUiYo9ie1pir7hUqDsaEsvwIwgSnQA9kzMwLqG4
 QRJQ==
X-Gm-Message-State: AOJu0Yy7o0HjXBdCUJ2JKBLcXPwS1S/HN9P9rVbDSziPVKCtmwVVgg+w
 QmOPp/qyD7l7DWd7k6yd0OikwE1CMxUy2M/tCmwAu0Y/lHBiR8muBJP2qxGEHEi0o17ZQ1v1rDA
 +DysikK2gMw==
X-Gm-Gg: AY/fxX7EGP+i5nCtHp12iNtlruhwIU88f7IX/m5WIC9A5nR67V6AneXjec/vxHo5Ksc
 h4jLjIuNGF/WSOOnzjnxL6LFCc52F6x0mdF2hD+XbmGjmd2GdQCGZy1ziFfxGR/2526K4ZaSbph
 NDTNQHDpu0njMUgDaxsbKfKRfllgWUAyKFhW1WrhjxCpqeOgFYmFQp0KNhB8umqD39Usa/Uq5Ic
 TA7F91OQFlmzY23HXoWVv9bSh+rOdJdz3R4LsCIVq8hC4mg3AXXHsE+QTrfVgLiDtRmuIGX5Pev
 MDgJPqy8RMdSJDLHdbMHbXir22Rn4KieMk1qC4zAXa5DtRDeQOgILKusaAsXuM3HGs3q7OdBChQ
 LXauO266+JpMh5BsfXiNUOB4lnPswPMyFIwV4tXwHGg25lJGzcmE6OtiUKj07tI3dsy1/vVoKhe
 y+LcF02GFc50t52RxogLGpPJ602fR9c8tTGX/UpnA=
X-Received: by 2002:a17:903:1108:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2a7009ba1a2mr111512495ad.13.1768773863727; 
 Sun, 18 Jan 2026 14:04:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 02/54] tests/docker/dockerfiles: Drop wasm32 from
 emsdk-wasm-cross.docker
Date: Mon, 19 Jan 2026 09:03:22 +1100
Message-ID: <20260118220414.8177-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We will no longer build wasm32, so drop the docker config.
Streamline the dockerfile to hardcode TARGET_CPU as wasm64.

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/container-cross.yml                 |  1 -
 tests/docker/dockerfiles/emsdk-wasm-cross.docker | 15 ++++-----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 6bdd482b80..b376c837dc 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -90,5 +90,4 @@ wasm64-emsdk-cross-container:
   extends: .container_job_template
   variables:
     NAME: emsdk-wasm64-cross
-    BUILD_ARGS: --build-arg TARGET_CPU=wasm64
     DOCKERFILE: emsdk-wasm-cross
diff --git a/tests/docker/dockerfiles/emsdk-wasm-cross.docker b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
index ecd5a02903..8a924816f9 100644
--- a/tests/docker/dockerfiles/emsdk-wasm-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm-cross.docker
@@ -7,7 +7,6 @@ ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
 ARG PIXMAN_VERSION=0.44.2
 ARG FFI_VERSION=v3.5.2
 ARG MESON_VERSION=1.5.0
-ARG TARGET_CPU=wasm32
 
 FROM docker.io/emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base-common
 ARG MESON_VERSION
@@ -31,21 +30,16 @@ RUN mkdir /build
 WORKDIR /build
 RUN mkdir -p $TARGET
 
-FROM build-base-common AS build-base-wasm32
-
-FROM build-base-common AS build-base-wasm64
+FROM build-base-common AS build-base
 ENV CFLAGS="$CFLAGS -sMEMORY64=1"
 ENV CXXFLAGS="$CXXFLAGS -sMEMORY64=1"
 ENV LDFLAGS="$LDFLAGS -sMEMORY64=1"
-
-FROM build-base-${TARGET_CPU} AS build-base
-ARG TARGET_CPU
 RUN <<EOF
 cat <<EOT > /cross.meson
 [host_machine]
 system = 'emscripten'
-cpu_family = '${TARGET_CPU}'
-cpu = '${TARGET_CPU}'
+cpu_family = 'wasm64'
+cpu = 'wasm64'
 endian = 'little'
 
 [binaries]
@@ -67,14 +61,13 @@ RUN emconfigure ./configure --prefix=$TARGET --static
 RUN emmake make install -j$(nproc)
 
 FROM build-base AS libffi-dev
-ARG TARGET_CPU
 ARG FFI_VERSION
 RUN mkdir -p /libffi
 RUN git clone https://github.com/libffi/libffi /libffi
 WORKDIR /libffi
 RUN git checkout $FFI_VERSION
 RUN autoreconf -fiv
-RUN emconfigure ./configure --host=${TARGET_CPU}-unknown-linux \
+RUN emconfigure ./configure --host=wasm64-unknown-linux \
     --prefix=$TARGET --enable-static \
     --disable-shared --disable-dependency-tracking \
     --disable-builddir --disable-multi-os-directory \
-- 
2.43.0


