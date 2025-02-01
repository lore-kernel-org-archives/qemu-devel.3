Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9815FC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY4-0006Ck-Kt; Sat, 01 Feb 2025 11:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXx-00066I-ND
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:43 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXu-00016p-UH
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso22545445e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428037; x=1739032837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uDVwutvCVYjvCcYjra198r+Mscxqh0BOrnE6rt1c1dY=;
 b=W0Jeala5YP0OlcLMjhEW0JiX+N+8C7GuztD59sNvtfoiuPnizKF97Mn/UZ1gBRcdq2
 9OeXAZxodR5FtYAK0s1MpRIkIER+eZCMLmNCKWQyr3+VAtmHfy8qZQy+4zbC5letbQNh
 tnPt/d6HTaon6VjH9KYA1hxLwjMBzfEWVtgNFQLoL1LF6DmAapgwIn4mhPx5415K0BoP
 L9HN1nojXPvnvtf6smUSFx6VwQ/U4EKZZ3gAk7DrIWefBc5TGIyVK1oNIkYH+jeUAsUw
 fIZQsMPkvMO1skHpTyOXtkkgIaYblMk4sRCPZ7PEHJKZkgTgqQq94OZpZ8893viSS3dA
 HxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428037; x=1739032837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDVwutvCVYjvCcYjra198r+Mscxqh0BOrnE6rt1c1dY=;
 b=ipIqnVyP5iAcdPMk9fk3bh2+SJF7pjGsg7NlzlyU2beF+AD2xyRh6HsZqW/Asmkijp
 WSMjwATT3vOdIiTAJv9zUuQ9x2xaZHOH3diyPmlrr6LRNxFoJ49oQuexWi2hf+p4xlmA
 lbzlYz+s2M4w6AfHCMmpRJgUGUj1BTQnhXvInD0UUu5F6l5BDYHa9oxw8cfuVjKVHxJr
 6O/p0bcOqzgTMH32UA6/7CVZBr6mY1xBQRHL5lybecjLlk+rwDFEEZ0ab6GpKKCr8klX
 JNV357lbYkYkWlV//RgGwaPvDeCDUK61im/cx9/lWO79vagYS5d0DlwPfZvaVuY4dGMi
 m1Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKu+fiSy7POCeMybMz+5BSI+a4yPbc0Pv312VqbKg6PpH1eptRMw62P+69v+sfI4GdJ2kmiSx6UCp/@nongnu.org
X-Gm-Message-State: AOJu0YxaH5SdE+eXgPe3ELOWjEYmrEmyFOGWq8zoeUweAqfUJ5kn5oSk
 L2iXmRdezslYm7oQsRzUU0WPL2Tu/8/HGt9puDLro7uNQCOB7PAsIZTsR9S06s0=
X-Gm-Gg: ASbGncuggCWz2nFLR1dggiEB8GmP+Joe/A2ocOXHHJu0Fit7VMs1ps3FAoqigXy8uzR
 0bdfhExI1dw6fMANXlSNULXpDr40QW0/jGTBbUN/J2J9nZOml6b2vc3uh7Vo/6yO+UW7nRlfN8V
 qqvW+1omDAPkPSbX1ZMhSk20l9k/WF3rSbbglAXSeJGUwba/6/8K3uwzHB0vzRW2axXuAU+4Dhd
 os9pJ+z3G/n4l4S4MKWX22SLcImRErHddhHcXozHl77gsL4C4IRPW1o9yZs8Yu9J3GHjksqjg0N
 ig2ajd+Bn7eUANCfrP5s
X-Google-Smtp-Source: AGHT+IHBj0NjORBbWdgpiQJNBy1D4oYWtnSbmt0Os/iFYVEpEnvb2ENWbgJ4o8HelR17s03d+6JpEQ==
X-Received: by 2002:a05:600c:4e01:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438dc34b179mr157283975e9.0.1738428037406; 
 Sat, 01 Feb 2025 08:40:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/69] target/arm: Define and use new
 write_fp_*reg_merging() functions
Date: Sat,  1 Feb 2025 16:39:19 +0000
Message-Id: <20250201164012.1660228-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

For FEAT_AFP's FPCR.NEP bit, we need to programmatically change the
behaviour of the writeback of the result for most SIMD scalar
operations, so that instead of zeroing the upper part of the result
register it merges the upper elements from one of the input
registers.

Provide new functions write_fp_*reg_merging() which can be used
instead of the existing write_fp_*reg() functions when we want this
"merge the result with one of the input registers if FPCR.NEP is
enabled" handling, and use them in do_fp3_scalar_with_fpsttype().

Note that (as documented in the description of the FPCR.NEP bit)
which input register to use as the merge source varies by
instruction: for these 2-input scalar operations, the comparison
instructions take from Rm, not Rn.

We'll extend this to also provide the merging behaviour for
the remaining scalar insns in subsequent commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v1->v2: use vec_full_reg_offset() in _merging fns
---
 target/arm/tcg/translate-a64.c | 117 +++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e000ff83cb0..e45d96763fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -665,6 +665,68 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
     write_fp_dreg(s, reg, tmp);
 }
 
+/*
+ * Write a double result to 128 bit vector register reg, honouring FPCR.NEP:
+ * - if FPCR.NEP == 0, clear the high elements of reg
+ * - if FPCR.NEP == 1, set the high elements of reg from mergereg
+ *   (i.e. merge the result with those high elements)
+ * In either case, SVE register bits above 128 are zeroed (per R_WKYLB).
+ */
+static void write_fp_dreg_merging(DisasContext *s, int reg, int mergereg,
+                                  TCGv_i64 v)
+{
+    if (!s->fpcr_nep) {
+        write_fp_dreg(s, reg, v);
+        return;
+    }
+
+    /*
+     * Move from mergereg to reg; this sets the high elements and
+     * clears the bits above 128 as a side effect.
+     */
+    tcg_gen_gvec_mov(MO_64, vec_full_reg_offset(s, reg),
+                     vec_full_reg_offset(s, mergereg),
+                     16, vec_full_reg_size(s));
+    tcg_gen_st_i64(v, tcg_env, vec_full_reg_offset(s, reg));
+}
+
+/*
+ * Write a single-prec result, but only clear the higher elements
+ * of the destination register if FPCR.NEP is 0; otherwise preserve them.
+ */
+static void write_fp_sreg_merging(DisasContext *s, int reg, int mergereg,
+                                  TCGv_i32 v)
+{
+    if (!s->fpcr_nep) {
+        write_fp_sreg(s, reg, v);
+        return;
+    }
+
+    tcg_gen_gvec_mov(MO_64, vec_full_reg_offset(s, reg),
+                     vec_full_reg_offset(s, mergereg),
+                     16, vec_full_reg_size(s));
+    tcg_gen_st_i32(v, tcg_env, fp_reg_offset(s, reg, MO_32));
+}
+
+/*
+ * Write a half-prec result, but only clear the higher elements
+ * of the destination register if FPCR.NEP is 0; otherwise preserve them.
+ * The caller must ensure that the top 16 bits of v are zero.
+ */
+static void write_fp_hreg_merging(DisasContext *s, int reg, int mergereg,
+                                  TCGv_i32 v)
+{
+    if (!s->fpcr_nep) {
+        write_fp_sreg(s, reg, v);
+        return;
+    }
+
+    tcg_gen_gvec_mov(MO_64, vec_full_reg_offset(s, reg),
+                     vec_full_reg_offset(s, mergereg),
+                     16, vec_full_reg_size(s));
+    tcg_gen_st16_i32(v, tcg_env, fp_reg_offset(s, reg, MO_16));
+}
+
 /* Expand a 2-operand AdvSIMD vector operation using an expander function.  */
 static void gen_gvec_fn2(DisasContext *s, bool is_q, int rd, int rn,
                          GVecGen2Fn *gvec_fn, int vece)
@@ -5038,7 +5100,7 @@ typedef struct FPScalar {
 } FPScalar;
 
 static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
-                                        const FPScalar *f,
+                                        const FPScalar *f, int mergereg,
                                         ARMFPStatusFlavour fpsttype)
 {
     switch (a->esz) {
@@ -5047,7 +5109,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = read_fp_dreg(s, a->rm);
             f->gen_d(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     case MO_32:
@@ -5055,7 +5117,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = read_fp_sreg(s, a->rm);
             f->gen_s(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     case MO_16:
@@ -5066,7 +5128,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
             f->gen_h(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     default:
@@ -5075,16 +5137,19 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
     return true;
 }
 
-static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
+                          int mergereg)
 {
-    return do_fp3_scalar_with_fpsttype(s, a, f,
+    return do_fp3_scalar_with_fpsttype(s, a, f, mergereg,
                                        a->esz == MO_16 ?
                                        FPST_A64_F16 : FPST_A64);
 }
 
-static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
+                             int mergereg)
 {
-    return do_fp3_scalar_with_fpsttype(s, a, f, select_ah_fpst(s, a->esz));
+    return do_fp3_scalar_with_fpsttype(s, a, f, mergereg,
+                                       select_ah_fpst(s, a->esz));
 }
 
 static const FPScalar f_scalar_fadd = {
@@ -5092,63 +5157,63 @@ static const FPScalar f_scalar_fadd = {
     gen_helper_vfp_adds,
     gen_helper_vfp_addd,
 };
-TRANS(FADD_s, do_fp3_scalar, a, &f_scalar_fadd)
+TRANS(FADD_s, do_fp3_scalar, a, &f_scalar_fadd, a->rn)
 
 static const FPScalar f_scalar_fsub = {
     gen_helper_vfp_subh,
     gen_helper_vfp_subs,
     gen_helper_vfp_subd,
 };
-TRANS(FSUB_s, do_fp3_scalar, a, &f_scalar_fsub)
+TRANS(FSUB_s, do_fp3_scalar, a, &f_scalar_fsub, a->rn)
 
 static const FPScalar f_scalar_fdiv = {
     gen_helper_vfp_divh,
     gen_helper_vfp_divs,
     gen_helper_vfp_divd,
 };
-TRANS(FDIV_s, do_fp3_scalar, a, &f_scalar_fdiv)
+TRANS(FDIV_s, do_fp3_scalar, a, &f_scalar_fdiv, a->rn)
 
 static const FPScalar f_scalar_fmul = {
     gen_helper_vfp_mulh,
     gen_helper_vfp_muls,
     gen_helper_vfp_muld,
 };
-TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul)
+TRANS(FMUL_s, do_fp3_scalar, a, &f_scalar_fmul, a->rn)
 
 static const FPScalar f_scalar_fmax = {
     gen_helper_vfp_maxh,
     gen_helper_vfp_maxs,
     gen_helper_vfp_maxd,
 };
-TRANS(FMAX_s, do_fp3_scalar, a, &f_scalar_fmax)
+TRANS(FMAX_s, do_fp3_scalar, a, &f_scalar_fmax, a->rn)
 
 static const FPScalar f_scalar_fmin = {
     gen_helper_vfp_minh,
     gen_helper_vfp_mins,
     gen_helper_vfp_mind,
 };
-TRANS(FMIN_s, do_fp3_scalar, a, &f_scalar_fmin)
+TRANS(FMIN_s, do_fp3_scalar, a, &f_scalar_fmin, a->rn)
 
 static const FPScalar f_scalar_fmaxnm = {
     gen_helper_vfp_maxnumh,
     gen_helper_vfp_maxnums,
     gen_helper_vfp_maxnumd,
 };
-TRANS(FMAXNM_s, do_fp3_scalar, a, &f_scalar_fmaxnm)
+TRANS(FMAXNM_s, do_fp3_scalar, a, &f_scalar_fmaxnm, a->rn)
 
 static const FPScalar f_scalar_fminnm = {
     gen_helper_vfp_minnumh,
     gen_helper_vfp_minnums,
     gen_helper_vfp_minnumd,
 };
-TRANS(FMINNM_s, do_fp3_scalar, a, &f_scalar_fminnm)
+TRANS(FMINNM_s, do_fp3_scalar, a, &f_scalar_fminnm, a->rn)
 
 static const FPScalar f_scalar_fmulx = {
     gen_helper_advsimd_mulxh,
     gen_helper_vfp_mulxs,
     gen_helper_vfp_mulxd,
 };
-TRANS(FMULX_s, do_fp3_scalar, a, &f_scalar_fmulx)
+TRANS(FMULX_s, do_fp3_scalar, a, &f_scalar_fmulx, a->rn)
 
 static void gen_fnmul_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
 {
@@ -5173,42 +5238,42 @@ static const FPScalar f_scalar_fnmul = {
     gen_fnmul_s,
     gen_fnmul_d,
 };
-TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul)
+TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul, a->rn)
 
 static const FPScalar f_scalar_fcmeq = {
     gen_helper_advsimd_ceq_f16,
     gen_helper_neon_ceq_f32,
     gen_helper_neon_ceq_f64,
 };
-TRANS(FCMEQ_s, do_fp3_scalar, a, &f_scalar_fcmeq)
+TRANS(FCMEQ_s, do_fp3_scalar, a, &f_scalar_fcmeq, a->rm)
 
 static const FPScalar f_scalar_fcmge = {
     gen_helper_advsimd_cge_f16,
     gen_helper_neon_cge_f32,
     gen_helper_neon_cge_f64,
 };
-TRANS(FCMGE_s, do_fp3_scalar, a, &f_scalar_fcmge)
+TRANS(FCMGE_s, do_fp3_scalar, a, &f_scalar_fcmge, a->rm)
 
 static const FPScalar f_scalar_fcmgt = {
     gen_helper_advsimd_cgt_f16,
     gen_helper_neon_cgt_f32,
     gen_helper_neon_cgt_f64,
 };
-TRANS(FCMGT_s, do_fp3_scalar, a, &f_scalar_fcmgt)
+TRANS(FCMGT_s, do_fp3_scalar, a, &f_scalar_fcmgt, a->rm)
 
 static const FPScalar f_scalar_facge = {
     gen_helper_advsimd_acge_f16,
     gen_helper_neon_acge_f32,
     gen_helper_neon_acge_f64,
 };
-TRANS(FACGE_s, do_fp3_scalar, a, &f_scalar_facge)
+TRANS(FACGE_s, do_fp3_scalar, a, &f_scalar_facge, a->rm)
 
 static const FPScalar f_scalar_facgt = {
     gen_helper_advsimd_acgt_f16,
     gen_helper_neon_acgt_f32,
     gen_helper_neon_acgt_f64,
 };
-TRANS(FACGT_s, do_fp3_scalar, a, &f_scalar_facgt)
+TRANS(FACGT_s, do_fp3_scalar, a, &f_scalar_facgt, a->rm)
 
 static void gen_fabd_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
 {
@@ -5233,21 +5298,21 @@ static const FPScalar f_scalar_fabd = {
     gen_fabd_s,
     gen_fabd_d,
 };
-TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd)
+TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd, a->rn)
 
 static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f16,
     gen_helper_recpsf_f32,
     gen_helper_recpsf_f64,
 };
-TRANS(FRECPS_s, do_fp3_scalar_ah, a, &f_scalar_frecps)
+TRANS(FRECPS_s, do_fp3_scalar_ah, a, &f_scalar_frecps, a->rn)
 
 static const FPScalar f_scalar_frsqrts = {
     gen_helper_rsqrtsf_f16,
     gen_helper_rsqrtsf_f32,
     gen_helper_rsqrtsf_f64,
 };
-TRANS(FRSQRTS_s, do_fp3_scalar_ah, a, &f_scalar_frsqrts)
+TRANS(FRSQRTS_s, do_fp3_scalar_ah, a, &f_scalar_frsqrts, a->rn)
 
 static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
                        const FPScalar *f, bool swap)
-- 
2.34.1


