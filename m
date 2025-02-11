Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063BEC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6o-00009z-2a; Tue, 11 Feb 2025 11:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht67-0006uE-Ux
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:27:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht65-0003XN-N2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso13529185e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291212; x=1739896012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1nZ+IEGOFKvIZqBhBAoMWi6SFgehG7OHzLJ4Ei6wvCU=;
 b=pHuxrg2n/Q6sL0jAC/gBGRlBgeScw7xo4hDkMLVZgNLXhU9BOg4vUmTQeSfg/2aXB4
 vztWSFbZWuSjLc7xvJ0jbcf9NjVUQA3bqfC49mxHkS1RBoukFJ3HQahYpBSez/WCM9pS
 Luxzk96T7LRmDUgcULtYj9MHSgePxaTq/EAo7Qhk3gbhrAikSFDr2hSTg4aOr/mDkWuz
 yygo0piLRP07v7+EI5wYydhKKEcg33AiXSM9y/TArbR7T4RvpLTxk1wUg6vw7/SyeF1i
 Pdetex7W0yTG4iDMAB5SLzgJWabOPHSpRfCpjkACZWtBEGK4U1jfmD6Gc2nt97S/Of1x
 nEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291212; x=1739896012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nZ+IEGOFKvIZqBhBAoMWi6SFgehG7OHzLJ4Ei6wvCU=;
 b=g1dGafiCjv2W5z+6t3Lt9kSrMe18RQaZZjsFsmSx00TqrMN8eJvYredkYTr8h6I17T
 BVaUlDaGilplFA05EPrjS3kGSY7jS/lqXeC0XmKT0ayNp6cPIOjMA/C432d2lkmUyJit
 78W0yOw5ALWStWnXGn8c/UY4MN6m7j6rvZUCH/hKAUXEjlB0S2Vr+Vm3QSSbPnysERlN
 g6KSNZOMN2eskLn8Qc2m3980Gw84g0iuxrZc5JLXb52+sQNWgCr3xY6gr8G86iw/eCN7
 qwsKWh+rDW8B2OU3UktTe6ijASyBLY2W/k0swmmDqpyDdVPMtFO7ruzbStoZNpwifcDM
 i2YA==
X-Gm-Message-State: AOJu0Yx+HUrYw2s5cUCDdtd7fXX1BeWxSxlWh9QZXxZb5auSUZzwcCK9
 TDp5OytWwW3vAFPlZmdtP5DjoERwrr8r+9n3q03NeeQx2rfu1Q8xyHxqkz5gh0qi71t3aosLfSM
 a
X-Gm-Gg: ASbGncuZu/TooxMhKztixC1WCVoTt+NULcosKpBTblqKnLh79My7u+uResGXpENB/Hj
 SNNkAsLyFnXszceTAkmzdWTY3D9K3rE3vPUT6M+29KSivKvMDKLZhOjSDeKHmqZPAlXPkdR7VpF
 +t5khMy8Kzec/4C51ySbp+CoZcJJwO1+foObDpivVJU1Am3L6u4St2LRnCOxVlcdVmmKVH7ugSV
 5jrvL5uXXc9CGTKUUg2h8WlGUbef+3m3fUXbWQfBUpVTCnMahoYhOPKhw33jXou9V4zce0SMqpa
 g3MSBjwcmOb9plc/dWEs
X-Google-Smtp-Source: AGHT+IFGACRCt+3Wp7ZY3ZIvz8cjgQ/1amCVJkx0mv5qslK7WWYPg2cuEA4W0n2MhyDzkk5QUj+5Tg==
X-Received: by 2002:a05:600c:3b11:b0:439:574c:bf77 with SMTP id
 5b1f17b1804b1-439574cc16amr6858115e9.8.1739291211728; 
 Tue, 11 Feb 2025 08:26:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 52/68] target/arm: Plumb FEAT_RPRES frecpe and frsqrte through
 to new helper
Date: Tue, 11 Feb 2025 16:25:38 +0000
Message-Id: <20250211162554.4135349-53-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

FEAT_RPRES implements an "increased precision" variant of the single
precision FRECPE and FRSQRTE instructions from an 8 bit to a 12
bit mantissa. This applies only when FPCR.AH == 1. Note that the
halfprec and double versions of these insns retain the 8 bit
precision regardless.

In this commit we add all the plumbing to make these instructions
call a new helper function when the increased-precision is in
effect. In the following commit we will provide the actual change
in behaviour in the helpers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++----
 target/arm/tcg/translate-sve.c | 16 ++++++++++++++--
 target/arm/tcg/vec_helper.c    |  2 ++
 target/arm/vfp_helper.c        | 32 ++++++++++++++++++++++++++++++--
 6 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 7bf24c506b3..525e4cee12f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -597,6 +597,11 @@ static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
 }
 
+static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, RPRES);
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index f0a783b7088..09075058391 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -245,9 +245,11 @@ DEF_HELPER_4(vfp_muladdh, f16, f16, f16, f16, fpst)
 
 DEF_HELPER_FLAGS_2(recpe_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
 DEF_HELPER_FLAGS_2(recpe_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(recpe_rpres_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(recpe_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_2(rsqrte_f16, TCG_CALL_NO_RWG, f16, f16, fpst)
 DEF_HELPER_FLAGS_2(rsqrte_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
+DEF_HELPER_FLAGS_2(rsqrte_rpres_f32, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(rsqrte_f64, TCG_CALL_NO_RWG, f64, f64, fpst)
 DEF_HELPER_FLAGS_1(recpe_u32, TCG_CALL_NO_RWG, i32, i32)
 DEF_HELPER_FLAGS_1(rsqrte_u32, TCG_CALL_NO_RWG, i32, i32)
@@ -680,10 +682,12 @@ DEF_HELPER_FLAGS_4(gvec_vrintx_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frecpe_rpres_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(gvec_frsqrte_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_frsqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(gvec_frsqrte_rpres_s, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(gvec_frsqrte_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_4(gvec_fcgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1846f81bf58..8bef391bb03 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8903,7 +8903,14 @@ static const FPScalar1 f_scalar_frecpe = {
     gen_helper_recpe_f32,
     gen_helper_recpe_f64,
 };
-TRANS(FRECPE_s, do_fp1_scalar_ah, a, &f_scalar_frecpe, -1)
+static const FPScalar1 f_scalar_frecpe_rpres = {
+    gen_helper_recpe_f16,
+    gen_helper_recpe_rpres_f32,
+    gen_helper_recpe_f64,
+};
+TRANS(FRECPE_s, do_fp1_scalar_ah, a,
+      s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
+      &f_scalar_frecpe_rpres : &f_scalar_frecpe, -1)
 
 static const FPScalar1 f_scalar_frecpx = {
     gen_helper_frecpx_f16,
@@ -8917,7 +8924,14 @@ static const FPScalar1 f_scalar_frsqrte = {
     gen_helper_rsqrte_f32,
     gen_helper_rsqrte_f64,
 };
-TRANS(FRSQRTE_s, do_fp1_scalar_ah, a, &f_scalar_frsqrte, -1)
+static const FPScalar1 f_scalar_frsqrte_rpres = {
+    gen_helper_rsqrte_f16,
+    gen_helper_rsqrte_rpres_f32,
+    gen_helper_rsqrte_f64,
+};
+TRANS(FRSQRTE_s, do_fp1_scalar_ah, a,
+      s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
+      &f_scalar_frsqrte_rpres : &f_scalar_frsqrte, -1)
 
 static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
 {
@@ -9948,14 +9962,26 @@ static gen_helper_gvec_2_ptr * const f_frecpe[] = {
     gen_helper_gvec_frecpe_s,
     gen_helper_gvec_frecpe_d,
 };
-TRANS(FRECPE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
+static gen_helper_gvec_2_ptr * const f_frecpe_rpres[] = {
+    gen_helper_gvec_frecpe_h,
+    gen_helper_gvec_frecpe_rpres_s,
+    gen_helper_gvec_frecpe_d,
+};
+TRANS(FRECPE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0,
+      s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ? f_frecpe_rpres : f_frecpe)
 
 static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
     gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s,
     gen_helper_gvec_frsqrte_d,
 };
-TRANS(FRSQRTE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
+static gen_helper_gvec_2_ptr * const f_frsqrte_rpres[] = {
+    gen_helper_gvec_frsqrte_h,
+    gen_helper_gvec_frsqrte_rpres_s,
+    gen_helper_gvec_frsqrte_d,
+};
+TRANS(FRSQRTE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0,
+      s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ? f_frsqrte_rpres : f_frsqrte)
 
 static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6af94fedd0a..d23be477b4d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3629,13 +3629,25 @@ static gen_helper_gvec_2_ptr * const frecpe_fns[] = {
     NULL,                     gen_helper_gvec_frecpe_h,
     gen_helper_gvec_frecpe_s, gen_helper_gvec_frecpe_d,
 };
-TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frecpe_fns[a->esz], a, 0)
+static gen_helper_gvec_2_ptr * const frecpe_rpres_fns[] = {
+    NULL,                           gen_helper_gvec_frecpe_h,
+    gen_helper_gvec_frecpe_rpres_s, gen_helper_gvec_frecpe_d,
+};
+TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_ah_arg_zz,
+           s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
+           frecpe_rpres_fns[a->esz] : frecpe_fns[a->esz], a, 0)
 
 static gen_helper_gvec_2_ptr * const frsqrte_fns[] = {
     NULL,                      gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s, gen_helper_gvec_frsqrte_d,
 };
-TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frsqrte_fns[a->esz], a, 0)
+static gen_helper_gvec_2_ptr * const frsqrte_rpres_fns[] = {
+    NULL,                            gen_helper_gvec_frsqrte_h,
+    gen_helper_gvec_frsqrte_rpres_s, gen_helper_gvec_frsqrte_d,
+};
+TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_ah_arg_zz,
+           s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
+           frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
 /*
  *** SVE Floating Point Compare with Zero Group
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index aefcd07ef00..ff3f7d8208f 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1236,10 +1236,12 @@ void HELPER(NAME)(void *vd, void *vn, float_status *stat, uint32_t desc)  \
 
 DO_2OP(gvec_frecpe_h, helper_recpe_f16, float16)
 DO_2OP(gvec_frecpe_s, helper_recpe_f32, float32)
+DO_2OP(gvec_frecpe_rpres_s, helper_recpe_rpres_f32, float32)
 DO_2OP(gvec_frecpe_d, helper_recpe_f64, float64)
 
 DO_2OP(gvec_frsqrte_h, helper_rsqrte_f16, float16)
 DO_2OP(gvec_frsqrte_s, helper_rsqrte_f32, float32)
+DO_2OP(gvec_frsqrte_rpres_s, helper_rsqrte_rpres_f32, float32)
 DO_2OP(gvec_frsqrte_d, helper_rsqrte_f64, float64)
 
 DO_2OP(gvec_vrintx_h, float16_round_to_int, float16)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 5c370e263c6..b97417e5a1a 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -841,7 +841,11 @@ uint32_t HELPER(recpe_f16)(uint32_t input, float_status *fpst)
     return make_float16(f16_val);
 }
 
-float32 HELPER(recpe_f32)(float32 input, float_status *fpst)
+/*
+ * FEAT_RPRES means the f32 FRECPE has an "increased precision" variant
+ * which is used when FPCR.AH == 1.
+ */
+static float32 do_recpe_f32(float32 input, float_status *fpst, bool rpres)
 {
     float32 f32 = float32_squash_input_denormal(input, fpst);
     uint32_t f32_val = float32_val(f32);
@@ -890,6 +894,16 @@ float32 HELPER(recpe_f32)(float32 input, float_status *fpst)
     return make_float32(f32_val);
 }
 
+float32 HELPER(recpe_f32)(float32 input, float_status *fpst)
+{
+    return do_recpe_f32(input, fpst, false);
+}
+
+float32 HELPER(recpe_rpres_f32)(float32 input, float_status *fpst)
+{
+    return do_recpe_f32(input, fpst, true);
+}
+
 float64 HELPER(recpe_f64)(float64 input, float_status *fpst)
 {
     float64 f64 = float64_squash_input_denormal(input, fpst);
@@ -1035,7 +1049,11 @@ uint32_t HELPER(rsqrte_f16)(uint32_t input, float_status *s)
     return make_float16(val);
 }
 
-float32 HELPER(rsqrte_f32)(float32 input, float_status *s)
+/*
+ * FEAT_RPRES means the f32 FRSQRTE has an "increased precision" variant
+ * which is used when FPCR.AH == 1.
+ */
+static float32 do_rsqrte_f32(float32 input, float_status *s, bool rpres)
 {
     float32 f32 = float32_squash_input_denormal(input, s);
     uint32_t val = float32_val(f32);
@@ -1080,6 +1098,16 @@ float32 HELPER(rsqrte_f32)(float32 input, float_status *s)
     return make_float32(val);
 }
 
+float32 HELPER(rsqrte_f32)(float32 input, float_status *s)
+{
+    return do_rsqrte_f32(input, s, false);
+}
+
+float32 HELPER(rsqrte_rpres_f32)(float32 input, float_status *s)
+{
+    return do_rsqrte_f32(input, s, true);
+}
+
 float64 HELPER(rsqrte_f64)(float64 input, float_status *s)
 {
     float64 f64 = float64_squash_input_denormal(input, s);
-- 
2.34.1


