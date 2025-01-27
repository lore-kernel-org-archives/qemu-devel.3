Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CC8C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUg-0006Kg-5w; Mon, 27 Jan 2025 18:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUd-0006K2-RC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:11 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUZ-0005W2-Tq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:11 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so6661975a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020366; x=1738625166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B68aHUjgce2FHHqTRRu8gFQAPKi4L1+0pcChyOeMbAI=;
 b=zm6B4dB2WswikHeDE8M2WNq7sdDPMUAfL+qoOJ2a4yUNnShUVU+9klnqE1KrBFKKmI
 sDjtg0EhNmLhfcI9AWIw7hqO+LTHOlVzHH/azbOaKy+nFX10WxgApdmyhLczgEZsa1SI
 GLm1VG8Sq/TCl4jEfM+c6bLpsIJZOrO6hyjoDmS8B7OpVHciz2k8ayXf14jPwtHBGIf4
 RWddXsCgB6JxHT1SNfJNqETexzcPWMLWO9FRCU+vlDy5ZLz75EDHHV/42QyOMRDFJfWI
 dFz5Q0NnX95qQotsBbcDSe+Cg9OLKErjjjKYQ15h87WC7Qmw5ETKamutiqUnPpTXfFVj
 Ey9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020366; x=1738625166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B68aHUjgce2FHHqTRRu8gFQAPKi4L1+0pcChyOeMbAI=;
 b=EZq1uVR0E7l4UX+ODK78fjgT7t7QWPmU9gjpeBA9sbYpm5SDfDkxWNej+OGreCEZeX
 vtM9cy8PU0nnZ5LMm3HTQL3h0WapvoQgOMnd5TFJI+SVumEKx7PLRPo4YjICMzdfrQZ+
 MAOaQ9O7opra5YKaM/iIIoQc8PxPsXo9adwXISUGMdyvBsvzbEaMVruVAvuGARFBHWNn
 S5KSXwzRfiucCA7CaO0PvGTQFgQYACK37JhsWuFBOj5OUNStMAdI0Z5d/uGB8lj/qiN2
 3NM+UiFEgPA13l9dL3p0AHtpZ8G0IZoN/6otqk6dH1VELacNg5Q0/9aNpCRZOGHol5iL
 oI+w==
X-Gm-Message-State: AOJu0Yyj+n8yQaDLS7Mhhnd/mdqgGAutwx2Z+9tKvB/8z2GoJN/8FDsS
 X5+1FCduE00xMeRCECT2fn6SSCLMCzNlafszt6h9LfUJgPdsqxcEVVZbIBxQQlwSxnLHwG2qF2k
 +
X-Gm-Gg: ASbGncuYUjmlqXjoq3pye5WfWIOtOiYJNpgjvjNtYHsYTqUv2bzQVSjzJxKCf+RqifA
 UuurGYZq+Hv2X6oZzE3hWnRrGG/8l7kg7blpknSPxMwP7x66zJlIQiFiGcqb3LtSTgMUTOQ+LOL
 5+Y0gVz1136jOjz5ogrKUXFNSsK/21GVIvXNwNnJ0iTXykG0L33FOU9ZvfvDslIwN9bHVFzhJky
 U6LrcFfCBc7I/d6g28bdm9bMjxFLmsbG03wJfpUeNBoOHuYBfbaBKvkr0KzPECZG1g3tm4xv8EG
 E8dI2jqAKeSKtpfWjIT6DiynCqcnX8GrSLH4+FU=
X-Google-Smtp-Source: AGHT+IGvZUeIDKF/NVBhObkqpionWchH1zNa6lHPROZvbg4jmvgYHuO/Ba7NUb+P1HxMg4k5jN76tg==
X-Received: by 2002:a17:90b:5448:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2f782c4d75cmr59181680a91.4.1738020366371; 
 Mon, 27 Jan 2025 15:26:06 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 01/22] target/arm: Rename FPST_FPCR_A32 to FPST_A32
Date: Mon, 27 Jan 2025 15:25:43 -0800
Message-ID: <20250127232604.20386-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  6 ++--
 target/arm/tcg/translate-vfp.c | 54 +++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 59e780df2e..6ce2471aa6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -674,7 +674,7 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  * Enum for argument to fpstatus_ptr().
  */
 typedef enum ARMFPStatusFlavour {
-    FPST_FPCR_A32,
+    FPST_A32,
     FPST_FPCR_A64,
     FPST_FPCR_F16_A32,
     FPST_FPCR_F16_A64,
@@ -692,7 +692,7 @@ typedef enum ARMFPStatusFlavour {
  * been set up to point to the requested field in the CPU state struct.
  * The options are:
  *
- * FPST_FPCR_A32
+ * FPST_A32
  *   for AArch32 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_A64
  *   for AArch64 non-FP16 operations controlled by the FPCR
@@ -717,7 +717,7 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     int offset;
 
     switch (flavour) {
-    case FPST_FPCR_A32:
+    case FPST_A32:
         offset = offsetof(CPUARMState, vfp.fp_status_a32);
         break;
     case FPST_FPCR_A64:
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 8eebba0f27..4cc12a407b 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -462,7 +462,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR_A32);
+        fpst = fpstatus_ptr(FPST_A32);
     }
 
     tcg_rmode = gen_set_rmode(rounding, fpst);
@@ -529,7 +529,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     if (sz == 1) {
         fpst = fpstatus_ptr(FPST_FPCR_F16_A32);
     } else {
-        fpst = fpstatus_ptr(FPST_FPCR_A32);
+        fpst = fpstatus_ptr(FPST_A32);
     }
 
     tcg_shift = tcg_constant_i32(0);
@@ -1398,7 +1398,7 @@ static bool do_vfp_3op_sp(DisasContext *s, VFPGen3OpSPFn *fn,
     f0 = tcg_temp_new_i32();
     f1 = tcg_temp_new_i32();
     fd = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
 
     vfp_load_reg32(f0, vn);
     vfp_load_reg32(f1, vm);
@@ -1517,7 +1517,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     f0 = tcg_temp_new_i64();
     f1 = tcg_temp_new_i64();
     fd = tcg_temp_new_i64();
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
 
     vfp_load_reg64(f0, vn);
     vfp_load_reg64(f1, vm);
@@ -2181,7 +2181,7 @@ static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negs(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_vfp_muladds(vd, vn, vm, vd, fpst);
     vfp_store_reg32(vd, a->vd);
     return true;
@@ -2246,7 +2246,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
         /* VFNMA, VFNMS */
         gen_vfp_negd(vd, vd);
     }
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_vfp_muladdd(vd, vn, vm, vd, fpst);
     vfp_store_reg64(vd, a->vd);
     return true;
@@ -2429,12 +2429,12 @@ static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_A32));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_A32));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
@@ -2565,7 +2565,7 @@ static bool trans_VCVT_f32_f16(DisasContext *s, arg_VCVT_f32_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2599,7 +2599,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     /* The T bit tells us if we want the low or high 16 bits of Vm */
@@ -2623,7 +2623,7 @@ static bool trans_VCVT_b16_f32(DisasContext *s, arg_VCVT_b16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     tmp = tcg_temp_new_i32();
 
     vfp_load_reg32(tmp, a->vm);
@@ -2646,7 +2646,7 @@ static bool trans_VCVT_f16_f32(DisasContext *s, arg_VCVT_f16_f32 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
 
@@ -2680,7 +2680,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     ahp_mode = get_ahp_flag();
     tmp = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
@@ -2727,7 +2727,7 @@ static bool trans_VRINTR_sp(DisasContext *s, arg_VRINTR_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rints(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2757,7 +2757,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rintd(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2803,7 +2803,7 @@ static bool trans_VRINTZ_sp(DisasContext *s, arg_VRINTZ_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rints(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2836,7 +2836,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     tcg_rmode = gen_set_rmode(FPROUNDING_ZERO, fpst);
     gen_helper_rintd(tmp, tmp, fpst);
     gen_restore_rmode(tcg_rmode, fpst);
@@ -2880,7 +2880,7 @@ static bool trans_VRINTX_sp(DisasContext *s, arg_VRINTX_sp *a)
 
     tmp = tcg_temp_new_i32();
     vfp_load_reg32(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rints_exact(tmp, tmp, fpst);
     vfp_store_reg32(tmp, a->vd);
     return true;
@@ -2910,7 +2910,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
 
     tmp = tcg_temp_new_i64();
     vfp_load_reg64(tmp, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     gen_helper_rintd_exact(tmp, tmp, fpst);
     vfp_store_reg64(tmp, a->vd);
     return true;
@@ -2937,7 +2937,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
+    gen_helper_vfp_fcvtds(vd, vm, fpstatus_ptr(FPST_A32));
     vfp_store_reg64(vd, a->vd);
     return true;
 }
@@ -2963,7 +2963,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     vd = tcg_temp_new_i32();
     vm = tcg_temp_new_i64();
     vfp_load_reg64(vm, a->vm);
-    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_FPCR_A32));
+    gen_helper_vfp_fcvtsd(vd, vm, fpstatus_ptr(FPST_A32));
     vfp_store_reg32(vd, a->vd);
     return true;
 }
@@ -3010,7 +3010,7 @@ static bool trans_VCVT_int_sp(DisasContext *s, arg_VCVT_int_sp *a)
 
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     if (a->s) {
         /* i32 -> f32 */
         gen_helper_vfp_sitos(vm, vm, fpst);
@@ -3044,7 +3044,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     vm = tcg_temp_new_i32();
     vd = tcg_temp_new_i64();
     vfp_load_reg32(vm, a->vm);
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     if (a->s) {
         /* i32 -> f64 */
         gen_helper_vfp_sitod(vd, vm, fpst);
@@ -3161,7 +3161,7 @@ static bool trans_VCVT_fix_sp(DisasContext *s, arg_VCVT_fix_sp *a)
     vd = tcg_temp_new_i32();
     vfp_load_reg32(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3223,7 +3223,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     vd = tcg_temp_new_i64();
     vfp_load_reg64(vd, a->vd);
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     shift = tcg_constant_i32(frac_bits);
 
     /* Switch on op:U:sx bits */
@@ -3307,7 +3307,7 @@ static bool trans_VCVT_sp_int(DisasContext *s, arg_VCVT_sp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     vm = tcg_temp_new_i32();
     vfp_load_reg32(vm, a->vm);
 
@@ -3347,7 +3347,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
         return true;
     }
 
-    fpst = fpstatus_ptr(FPST_FPCR_A32);
+    fpst = fpstatus_ptr(FPST_A32);
     vm = tcg_temp_new_i64();
     vd = tcg_temp_new_i32();
     vfp_load_reg64(vm, a->vm);
-- 
2.43.0


