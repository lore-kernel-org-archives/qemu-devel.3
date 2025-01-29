Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3FAC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2m-0000lS-IT; Tue, 28 Jan 2025 20:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2l-0000ku-30
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2j-0003TC-0j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:02 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21654fdd5daso107154355ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114739; x=1738719539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B68aHUjgce2FHHqTRRu8gFQAPKi4L1+0pcChyOeMbAI=;
 b=UmIpeKRWFV5lxciSQO8Thr8hAIk0exLkz+Z/vSMXB1ARjIE26lIeRo3/QazoxPz000
 UkuOANptt4UF4FA+UUfFNvNUejTuRtotD58egpOt8Fcf5qf1JV4nXQtflGzsGBvbZo7R
 Pti8pXLusFxnT/MzLxdKAvSSboYjV16MClVWEJmTO9ZozKh0GwEhARygDAT7Y5g64GsO
 6w+XGr/0OmzdOlbaiMq1bOPeu2rmoSCfZ1LYDWVOiicQyzfGQg8u+M97MoqEpTdtoPP9
 RsrCNWjc4QdxsqtmkSSNVjSYyk1Da+KZD9w6EpSgBczh3LF5AmoMQs+HUFyMgkIzqDWq
 1lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114739; x=1738719539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B68aHUjgce2FHHqTRRu8gFQAPKi4L1+0pcChyOeMbAI=;
 b=usNAC6HlFd0r4uo2AWPRMpIITbJgb5ZEKfIebaenz7bYde0osvBqi+gwGhrCShMDVt
 TjpKkBNMbVocCt0E3tY7OEBI55pkLQBsRuNwZdHCsN2TbXXPty82WU7uACd8uwAQsUz0
 FUTyOnVmMvO35xVwh0wO8bOnqAQJUWoBrNJwmGCIlnjMx7lQ+BedSkJ2g5H0/t+xlYIH
 eyvUxvPQS6G9NAPPyShOtugD5j3+rshu0R7PgY0vbUpBagwgeM3Pc2Y40r4Iu2FimIAP
 8t2KDXloFKFI6jK1icX01Cc8npkeNd08QtjXOHL5SpEPSm7BNKHZ9AI+lpEulvr7D3Wg
 1Cog==
X-Gm-Message-State: AOJu0Yz+xC4xcUfQWMrvw+tyWXtttfxaRapeybUKrj39NIaoGSs/jAmU
 JhQbPnr7vPK9SlIROI/MiYW+F7UZW5IUkIeN1+qRB7bOz9a1444MAlfgtmUszeBHYymimsORrQT
 u
X-Gm-Gg: ASbGncstJ+jl2DCLbje+AsUptZ8AYSOHii2A55MLEyj05lWBnDMNnYpq3F/McYV/hR5
 L3n6LQCa3Gaw0ADQCxbT26WRvHjWTLKH6IpgWvjHNhKYViq7i+EPoHHQ92Py8To1RWwsf8zonSX
 LglfLwG4Wp/jIXttEfQq1I2wBydfMYqHsSz83B1lcKn3LiFvZbXGuncCb4ur63UGtz8l4sBWq/R
 RROEpZ/0GpqzTPfFMOwqGhnb0yUTt5cMzCmts2AcIfKdH/jRXdY0UFqeYeGK/+st1fap2WFu3JC
 sDM1LTsV2A6ef+IK7K3SdxFI1GV4lTEbZnwP1ujZEXXf5hv7pQ==
X-Google-Smtp-Source: AGHT+IEY468IpAwCPI44DCNaFdqznKsjIr5OYCNEMu7RjieYIUC8s/FQIWx+ryQPfVL6NSsnsilxQA==
X-Received: by 2002:a17:902:d4d1:b0:21c:1140:136c with SMTP id
 d9443c01a7336-21dd7c3558cmr17532545ad.3.1738114739461; 
 Tue, 28 Jan 2025 17:38:59 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:38:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 01/34] target/arm: Rename FPST_FPCR_A32 to FPST_A32
Date: Tue, 28 Jan 2025 17:38:24 -0800
Message-ID: <20250129013857.135256-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


