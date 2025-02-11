Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0CBC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5Y-0006Tb-B1; Tue, 11 Feb 2025 11:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5V-0006Sc-9i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5S-00036G-T3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439350f1a0bso19847875e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291173; x=1739895973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nFdhuq+zzHoDKB+VSt2vfzAMLbA4ftjzDVhxCbz60t4=;
 b=s5W3NBcIX30aRitN5+3sMkV2Cis+oB5iZuHJA8duQoVsrKWx6yKo8Y0AnfxqpVjwWj
 n0IXbiuLG/238EKFwfDN7ljhLgCGRZw25bjrQ6NMOJW5Hi+30N1M016XF1yfzQvc1Rbr
 +9t9zi8BPniEB52P2EwZol/5c/VlonyiM0zOQbT2G6jq37CnouI9L3zxImUUVEs43wTT
 OuL0IQJhWyPdAnNDxlJt/jr3CQN+b54+n2eC1ZlPFAbwACnWNO7PymkPZY42wlplSL/O
 TaGpBn2fPxvszZCGNzBT4N0da5iGTicB7l4BhdCp9tUrkHdkptb6IqdTKbHczjt7LR+J
 4Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291173; x=1739895973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nFdhuq+zzHoDKB+VSt2vfzAMLbA4ftjzDVhxCbz60t4=;
 b=QJMTIgWrOLfLVb0SsO3DLjDgDHz1/gI4noqASWDogXDm9RvXpr5BivgPRArdPzPMDp
 mF5oeoN8Je6urD5slSriHaMqkFEb/vHDmAdNDfC/OJ/0+e/2vf1kbP5aQ0dtF6becshu
 fyQ6KU2re1WBopKWcEjgxfh34RM0VxahJ5fZYtODMoTEuv86YWBATleY7MPOKQg6FNHT
 EyTNEFlNNaJEYhI0SCLpVuPkAuNgGqOHV3qlRW8pD0i622bNQqa/jlov68XezgI2Q197
 /QBU4PX5KArzvvQy6FQtyt2olqY0SeIZHs6gnfu4btZAqb1lxiJR0pD35C9vaSOpv2uh
 7PIQ==
X-Gm-Message-State: AOJu0Yyiaq2rXdRwvHi8Dp69iL8KvXe5lQecJ1Vv2zzK63EVeVHzzOQL
 AdmsrZkelFhObdxgHNAKv1BRjwEZMrFq00viJdXzapbfiVZ6Pvukkcq/ANKp6Uz3TJy0pZwZ3jM
 B
X-Gm-Gg: ASbGncuyiXOw9/OK6GeBeUYuz5BVVj4XKU8pB2jHs8t8sb9YQ4UI358mA8HMMcz/oNT
 OZje+58eeqeKE9SlAmLsL0H9cgeqwRSgJyHWwfe3tdF8BUKGKmaZsGCeQrX/biL+SAY7d+hdGIo
 rOp7NPZTMzU+NzumaSrfUdDoLxJvD3gJxXjolmDPGZuFdC/dc/z2G9rcIu+YFLZpDmZzdQ8u9is
 bfS1dk1X2KLIo3e40KobhKq/uX+EoUXVuI9fAP4GAL63rUM8yDAeMemWk6s9MLGwMTGV+xMyfZ/
 w7jKxCgds6ZfcLnUJdOa
X-Google-Smtp-Source: AGHT+IF8GIp1P9uCUKBa6o8FPDKjK+erWn+ETAOBcAEeZUunFMu/RxKAqPVM8sId/HbIKkgpwnDhdQ==
X-Received: by 2002:a05:600c:490f:b0:438:9280:61d5 with SMTP id
 5b1f17b1804b1-4394ceb21e5mr32157365e9.5.1739291173289; 
 Tue, 11 Feb 2025 08:26:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/68] target/arm: Define and use new write_fp_*reg_merging()
 functions
Date: Tue, 11 Feb 2025 16:25:01 +0000
Message-Id: <20250211162554.4135349-16-peter.maydell@linaro.org>
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
 target/arm/tcg/translate-a64.c | 117 +++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d94a0022e4c..67c85db4775 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -654,6 +654,68 @@ static void write_fp_sreg(DisasContext *s, int reg, TCGv_i32 v)
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
@@ -5027,7 +5089,7 @@ typedef struct FPScalar {
 } FPScalar;
 
 static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
-                                        const FPScalar *f,
+                                        const FPScalar *f, int mergereg,
                                         ARMFPStatusFlavour fpsttype)
 {
     switch (a->esz) {
@@ -5036,7 +5098,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = read_fp_dreg(s, a->rm);
             f->gen_d(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_dreg(s, a->rd, t0);
+            write_fp_dreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     case MO_32:
@@ -5044,7 +5106,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = read_fp_sreg(s, a->rm);
             f->gen_s(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_sreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     case MO_16:
@@ -5055,7 +5117,7 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
             f->gen_h(t0, t0, t1, fpstatus_ptr(fpsttype));
-            write_fp_sreg(s, a->rd, t0);
+            write_fp_hreg_merging(s, a->rd, mergereg, t0);
         }
         break;
     default:
@@ -5064,16 +5126,19 @@ static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
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
@@ -5081,63 +5146,63 @@ static const FPScalar f_scalar_fadd = {
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
@@ -5162,42 +5227,42 @@ static const FPScalar f_scalar_fnmul = {
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
@@ -5222,21 +5287,21 @@ static const FPScalar f_scalar_fabd = {
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


