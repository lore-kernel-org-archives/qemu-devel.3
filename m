Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C3C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMW-00055J-LP; Fri, 04 Jul 2025 10:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIW-0005Vq-8H
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:52 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIU-00069C-8z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:51 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so794853fac.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638909; x=1752243709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N99/thIYmrVhphn4jsghLGsBrndERIdHe0ir0x8GWEE=;
 b=KYPdP7Gd+T7jWW+nuDah7b4liP7rfW/Tgf/26K76duGE4NPuUd8U+oFxfrMQUn7q6w
 vJB1Yb2xPD5oZWCKRT80T1U3sMy3f+7B4sGHdwFOxwUh0amEjBS9aPeRYxQiAFNWtCj0
 S7VHc3hAfy4xOaSwdH1twa7TuGauBaWEsFrnNyeezAP6uYuYcjzXuX/1isbcmxJW4WuX
 cH4ajJ8OQHQ9gyFAubWv8hkMwUkwnsTlePMRqCgF8kpQEn8FBFnA0ckAzXL9hrwhKv0e
 Z8cD8+waMgcPIvAMRqkxG0VTxVT9p6y45JBoj8cZ0JFNRrclwKXpF/1+6zo7/Br9BCgi
 OgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638909; x=1752243709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N99/thIYmrVhphn4jsghLGsBrndERIdHe0ir0x8GWEE=;
 b=IyLZFChWejhpecJrA/aflKrNXiCb+FcunmIe2PFrktTX/dQeq+T802WHBzF1VLwKL1
 07yKvDTCYsFKJT5UbnvR7B6IIHXsyd6Gi/ZxbrykuL95fADMTIWQVUyRQfWJVbCNm5DK
 WnYGE39rthPMZMrr2Sn++gZRvekbp/LFHe63ziNW4cOf53qEut+5UC5CqKeE8p+derLT
 y5ESe3IeglA5EZTB0U+wIfidicugFPf8Fr2YpimWAfuEAlTVGGDx5hj7kRosjcJV1Vz4
 +wrPmkCDP0tgXiRMKYYb9sKOWYdQoC2WCQy6fAm3xs2rlP/ORsC5Qq42Z38HESSfxVk0
 vRZA==
X-Gm-Message-State: AOJu0YwZpdTG2zVMj/8Q1LYW0WuOTj4xrqvgzQ7gljePW2UPC0x4jmnj
 ARKNEirivekyUqE9oRqfK7M3sxsXvyKtEebIMG420H0eXzxVj/OGpS0Agkv/LewfxsWTnaegLjL
 HmTy9gjE=
X-Gm-Gg: ASbGnctSCej0SfcG7rpYnfVH78ra8/f0i9agttRQCglkYAJJpKjH78JGOgbgQCQXuj3
 MHNMo5XwQwPFqQmLeDZmXmfZ4IVmY5WucELwX0R9IVAPDUZ3lbnVovr+noSjrJVA6tJZA5LteVE
 GP06FZRaFocAbmyBuQdtSCAKKeOH/xNDsSCnyfL7e2ag2jHWZ/ga/eo37SDALBmLj2K91nY8Fha
 ROWqIRPcs5DYamNzQKM7gJ7CFVulgqRtfrLyTdOcHsS75Qmqau5xumd2ClRSxdDI5fJFsY7t1ww
 441zNLeZOdzpae40fILBd4mEZ7cK/Q/Aq9Mc82zqegFVJDR3BJgc9QIOXumhPIuEHuaZpF0VtSF
 VhMQWWCIDPSRu/7yxRtJM7WBPj7YKYs+H15Ux5wY8kSd5N5Cl
X-Google-Smtp-Source: AGHT+IECRBt11eYsF+Iig8KsLvyzlMJf0c8h2uvR9dWkR18NiciS9vhmAZvrjQM2fQysBvWJojDt+Q==
X-Received: by 2002:a05:6870:5588:b0:2b8:e6f2:ba7e with SMTP id
 586e51a60fabf-2f796aaea72mr1847358fac.12.1751638909157; 
 Fri, 04 Jul 2025 07:21:49 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 034/108] target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
Date: Fri,  4 Jul 2025 08:19:57 -0600
Message-ID: <20250704142112.1018902-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
simd_data(desc).  For SVE, this bit remains zero.
For do_FMLAL_zzzw, this requires no change.
For do_FMLAL_zzxw, move the index up one bit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7e304245c6..b85bd885f9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7214,7 +7214,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
     return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
                              a->rd, a->rn, a->rm, a->ra,
-                             (a->index << 2) | (sel << 1) | sub, tcg_env);
+                             (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
 TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 8b49577e2f..e8467823f2 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2191,7 +2191,8 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
@@ -2274,8 +2275,9 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, j, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 3, 3) * sizeof(float16);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
-- 
2.43.0


