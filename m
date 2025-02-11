Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106E8C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht61-0006ir-F8; Tue, 11 Feb 2025 11:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5i-0006Wk-NQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:30 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5g-0003Bb-Sc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a823036so17355855e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291187; x=1739895987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=39J0JXSrMipnMfbSOwfE7kxwC3F4TjK/BrCWs8c1l2A=;
 b=MKJR/35zdRRb+yzi4AYjHklWPzNQQHE2nCTxC8islwdsmc2AUfd+pA1HvfZTQUFyCj
 sLXbaLgrFGpBb8TKb26yUPVkOphD50FghtXaMeS7XmA0uxE3po18lohvmiJJ6L0r5LMF
 fv0wE26AlJHigY0m9zDGuKS+LRgW8pvrbQdbrG4kEYsAz92BgNxv5peunkdoT+rRBOzF
 P8dz00igjKWpRHU+ZGrD/c/YsmIFcFOGKdizMj1d5RLeFhoNpKyW1yDWGDHk5mpOYjVG
 T8c+jHJX+E9A68eiPnMFbo3+Yl08GqM0Lc3Ym55UwNAErGk1dvGNTcT79t5wu8V5AAUV
 7jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291187; x=1739895987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39J0JXSrMipnMfbSOwfE7kxwC3F4TjK/BrCWs8c1l2A=;
 b=WFWCK4DeuIfyMVxUScS+2kciP6n5lubG8YW2t5LiDcftODyoISV8apgiq+NrS+uYD2
 +TzaqF47ZU8tJSNPK1d7b+P7mddC03CwSxwkY7wbGQC7uBYPSYmJrGE47v83CRy5jkoc
 EU7fR5lllWXltOMO29C6tY+Uz5AWcxE+Eh0jWqIKcXIn/AK3PI58/Dld/FJtGzYcLZy4
 7QhHYJPrThs6Kd+AgCR3kJ0prDuBCuTKzQfQt3LJUBShQsp+z+VOxw81hRiwx9vAuoVg
 S4vo7rGootzMS3+F0OhnWcssQCrBAS0civkby2sXFE88bbe2k+3ol6ZojsljKuH5MLuR
 QjYg==
X-Gm-Message-State: AOJu0Ywe0aeS3QnV1NADZpFvDUifS7zMNdukR7mMVdToqv45ht2j3P3c
 eCS5INFTlxjwTx+IfIl54WZiEujj/GAw5e8p2gEZ7XFjHBlnvOLEnMYSvogrrdYQBHZdn11uA0j
 R
X-Gm-Gg: ASbGnctp4ESDpH3gEyV0Zx8Ue6lIbFs9YwLzg3GtwnRLLW3h8sxdPYUUi2v38YYFXA+
 4hikUz8WuOaBpVHet+7YdBv5bYhP20FditPZ/RVmSQ+XR+CopJhtm/u57DH19oh1OXNanWemKIm
 OikwxVVzOd/DitI0UpldrltqM4wT0DZoFj94GVE8PqTqG50tW9DYoCXdDwsYC3VRUyEdkUSHBL6
 P/mjuP7V8OOeHaUGGFleIc7wUjMlKiM42qHVLZijqLp6NzxG5f1mdJf5YOUrYPPqthwrSkqoS1C
 07/uNFEeDGYTL7AIG1D9
X-Google-Smtp-Source: AGHT+IG6GX1GfJ/spfdp5LmTuhX/8/2R1AQB0IwyJlHqmKWauHa5+4dOWHreuX7R7iluab4ctz1b2w==
X-Received: by 2002:a05:600c:1e21:b0:439:3eed:1cf9 with SMTP id
 5b1f17b1804b1-4393eed2360mr98475725e9.17.1739291187380; 
 Tue, 11 Feb 2025 08:26:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/68] target/arm: Implement FPCR.AH handling of negation of NaN
Date: Tue, 11 Feb 2025 16:25:16 +0000
Message-Id: <20250211162554.4135349-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

FPCR.AH == 1 mandates that negation of a NaN value should not flip
its sign bit.  This means we can no longer use gen_vfp_neg*()
everywhere but must instead generate slightly more complex code when
FPCR.AH is set.

Make this change for the scalar FNEG and for those places in
translate-a64.c which were previously directly calling
gen_vfp_neg*().

This change in semantics also affects any other instruction whose
pseudocode calls FPNeg(); in following commits we extend this
change to the other affected instructions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 125 ++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 02701b10c6b..abd0d916b19 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -828,6 +828,74 @@ static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
+/*
+ * When FPCR.AH == 1, NEG and ABS do not flip the sign bit of a NaN.
+ * These functions implement
+ *   d = floatN_is_any_nan(s) ? s : floatN_chs(s)
+ * which for float32 is
+ *   d = (s & ~(1 << 31)) > 0x7f800000UL) ? s : (s ^ (1 << 31))
+ * and similarly for the other float sizes.
+ */
+static void gen_vfp_ah_negh(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32(), chs_s = tcg_temp_new_i32();
+
+    gen_vfp_negh(chs_s, s);
+    gen_vfp_absh(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7c00),
+                        s, chs_s);
+}
+
+static void gen_vfp_ah_negs(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32(), chs_s = tcg_temp_new_i32();
+
+    gen_vfp_negs(chs_s, s);
+    gen_vfp_abss(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7f800000UL),
+                        s, chs_s);
+}
+
+static void gen_vfp_ah_negd(TCGv_i64 d, TCGv_i64 s)
+{
+    TCGv_i64 abs_s = tcg_temp_new_i64(), chs_s = tcg_temp_new_i64();
+
+    gen_vfp_negd(chs_s, s);
+    gen_vfp_absd(abs_s, s);
+    tcg_gen_movcond_i64(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i64(0x7ff0000000000000ULL),
+                        s, chs_s);
+}
+
+static void gen_vfp_maybe_ah_negh(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negh(d, s);
+    } else {
+        gen_vfp_negh(d, s);
+    }
+}
+
+static void gen_vfp_maybe_ah_negs(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negs(d, s);
+    } else {
+        gen_vfp_negs(d, s);
+    }
+}
+
+static void gen_vfp_maybe_ah_negd(DisasContext *dc, TCGv_i64 d, TCGv_i64 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negd(d, s);
+    } else {
+        gen_vfp_negd(d, s);
+    }
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -5241,12 +5309,35 @@ static void gen_fnmul_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
     gen_vfp_negd(d, d);
 }
 
+static void gen_fnmul_ah_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_mulh(d, n, m, s);
+    gen_vfp_ah_negh(d, d);
+}
+
+static void gen_fnmul_ah_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muls(d, n, m, s);
+    gen_vfp_ah_negs(d, d);
+}
+
+static void gen_fnmul_ah_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muld(d, n, m, s);
+    gen_vfp_ah_negd(d, d);
+}
+
 static const FPScalar f_scalar_fnmul = {
     gen_fnmul_h,
     gen_fnmul_s,
     gen_fnmul_d,
 };
-TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul, a->rn)
+static const FPScalar f_scalar_ah_fnmul = {
+    gen_fnmul_ah_h,
+    gen_fnmul_ah_s,
+    gen_fnmul_ah_d,
+};
+TRANS(FNMUL_s, do_fp3_scalar_2fn, a, &f_scalar_fnmul, &f_scalar_ah_fnmul, a->rn)
 
 static const FPScalar f_scalar_fcmeq = {
     gen_helper_advsimd_ceq_f16,
@@ -6388,7 +6479,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element(s, t2, a->rm, a->idx, MO_64);
             if (neg) {
-                gen_vfp_negd(t1, t1);
+                gen_vfp_maybe_ah_negd(s, t1, t1);
             }
             gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_dreg_merging(s, a->rd, a->rd, t0);
@@ -6402,7 +6493,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element_i32(s, t2, a->rm, a->idx, MO_32);
             if (neg) {
-                gen_vfp_negs(t1, t1);
+                gen_vfp_maybe_ah_negs(s, t1, t1);
             }
             gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_sreg_merging(s, a->rd, a->rd, t0);
@@ -6419,7 +6510,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element_i32(s, t2, a->rm, a->idx, MO_16);
             if (neg) {
-                gen_vfp_negh(t1, t1);
+                gen_vfp_maybe_ah_negh(s, t1, t1);
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
                                        fpstatus_ptr(FPST_A64_F16));
@@ -6902,10 +6993,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i64 ta = read_fp_dreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negd(ta, ta);
+                gen_vfp_maybe_ah_negd(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negd(tn, tn);
+                gen_vfp_maybe_ah_negd(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
@@ -6920,10 +7011,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i32 ta = read_fp_sreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negs(ta, ta);
+                gen_vfp_maybe_ah_negs(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negs(tn, tn);
+                gen_vfp_maybe_ah_negs(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
@@ -6941,10 +7032,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i32 ta = read_fp_hreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negh(ta, ta);
+                gen_vfp_maybe_ah_negh(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negh(tn, tn);
+                gen_vfp_maybe_ah_negh(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
@@ -8533,6 +8624,13 @@ static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
     return true;
 }
 
+static bool do_fp1_scalar_int_2fn(DisasContext *s, arg_rr_e *a,
+                                  const FPScalar1Int *fnormal,
+                                  const FPScalar1Int *fah)
+{
+    return do_fp1_scalar_int(s, a, s->fpcr_ah ? fah : fnormal, true);
+}
+
 static const FPScalar1Int f_scalar_fmov = {
     tcg_gen_mov_i32,
     tcg_gen_mov_i32,
@@ -8552,7 +8650,12 @@ static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negs,
     gen_vfp_negd,
 };
-TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg, true)
+static const FPScalar1Int f_scalar_ah_fneg = {
+    gen_vfp_ah_negh,
+    gen_vfp_ah_negs,
+    gen_vfp_ah_negd,
+};
+TRANS(FNEG_s, do_fp1_scalar_int_2fn, a, &f_scalar_fneg, &f_scalar_ah_fneg)
 
 typedef struct FPScalar1 {
     void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
-- 
2.34.1


