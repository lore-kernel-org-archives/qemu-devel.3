Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CADAC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY7-0006F4-2q; Sat, 01 Feb 2025 11:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXt-00063U-7E
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXp-00015U-S4
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:36 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso18601695e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428032; x=1739032832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tNVyOI67cLjV7qgXOMaDxBYxftWVJWK+laD/5IMvX/k=;
 b=gCTMefMNXFrodQWAp4FwaJ0OTco76UjlbjmFy+rDdyp/wbicZcLy+xQKEAdDQRQIWe
 Kuom/QP3voI9FqGS/PSMecDcOACjOf2OUK6pf85rNp5PELk4T5ac6t377ggz+v8Y8zYI
 /5ysfvoOhoRPRTNI5/PjQM422v4gyjP0gBXFtDGkzTfEw4QJLEbGNwvTtPnBr1TQxV+p
 3TsXtzfcMrL5i/XUJAhakZGdclQzJWBqCV7iq3X67V2hg7kVjpYPzk8yIRYCV5BfAMt1
 FrNIhTjqJ765g8QsdRpXcaEI9ZXGp5jpbSzpAmvQDvx92jdvPTDpqcR0wUc83n69ugsr
 gsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428032; x=1739032832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNVyOI67cLjV7qgXOMaDxBYxftWVJWK+laD/5IMvX/k=;
 b=lbAWhL6yU0jzk2TPXHvYelQGt1oXzgcq7Uhx6w9LDYDis2OmxEH58I2pn7JWPjai+M
 eiMa4L2O77/h0kT/mL+C1MIV2tcw3w62IBQOvTNLr2i5J7Cm1GwLTNzm+66hxKE93WA6
 4opZjLeMlSP3kpj5yV9+0jJiZp+zh5+f1KWmMnVYl3KRDee1l/so38cZlR6u8ciRE1Sb
 FCg0ghxNMkPq42gzYyAVL9nosJVulRaluRsvsAVqFMyhKAZWXJJ6/K0sK6NH2Qa5XTl7
 ko8BDUvVZLxhj4Os56qLaUMMUkNWM2ovEvme5sbDQ/uUfG3AKsdSAO0Gqoa6DPHyrHVs
 VqQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYOzC5raZy9VJr5TCEC96gjkWPE23gYJPcIyKn+8Xlu97LeJhwZpny+G0fZSHeyed6kHKMZWH7d91p@nongnu.org
X-Gm-Message-State: AOJu0Yw4lttDwKPKefYw/+X/oYD0BCYwud/c/RSL2cpxfLydi6DRKn1R
 ICDE7qkWvz1hWkvhL5Nvow35/2/Ikk4YJ9Rkm3H6DRs7rB8rstpAE/my/q+Zq2UgX7Ub3eEeKcS
 z
X-Gm-Gg: ASbGncuyEkwn1w8aKE3c77qZ8TAi1YVpP91c2+NbGVeRfN/dIgcoJ2YVUJQoii+37Nc
 L2B/BpN9Q2SNQO31OEg6jRZvGfQ+XIVOAPwE1OE5DGA4JtbEWIOAZ78h80XNw2FdOaGkdcRPIIO
 OGrdVqyMwt3Tt9IVdqwSNIz6dsZsNW9W/gjWmNjDVulbpp93U2Lvwsr6rVmWSnxfhEPp98W+3iz
 8ZMHdetmbHJMwvEWvLrK4C/bOp/UkQ4Ll/TtsZ8xS1W/cVIPmOLa0gJeNeo2WyUfMcMXFnUGAbH
 Su3dK2hL1k7DrPXjBqzw
X-Google-Smtp-Source: AGHT+IFeDeR0l23JtsQlZF7twSsDXghPVgrDlcg9MbxgrIjk3BkT+Qe8lYmwLAOLuIwdMKh8EwZGMA==
X-Received: by 2002:a05:600c:ccc:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-438e15e4757mr84556915e9.6.1738428031503; 
 Sat, 01 Feb 2025 08:40:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/69] target/arm: Use FPST_FPCR_AH for FRECPE, FRECPS,
 FRECPX, FRSQRTE, FRSQRTS
Date: Sat,  1 Feb 2025 16:39:15 +0000
Message-Id: <20250201164012.1660228-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

For the instructions FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, use
FPST_FPCR_AH or FPST_FPCR_AH_F16 when FPCR.AH is 1, so that they get
the required behaviour changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v1->v2: rename select_fpst() to select_ah_fpst(), put it in
translate-a64.h
---
 target/arm/tcg/translate-a64.h |  13 ++++
 target/arm/tcg/translate-a64.c | 119 +++++++++++++++++++++++++--------
 target/arm/tcg/translate-sve.c |  30 ++++++---
 3 files changed, 127 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 0fcf7cb63ad..7d3b59ccd96 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -185,6 +185,19 @@ static inline TCGv_ptr pred_full_reg_ptr(DisasContext *s, int regno)
     return ret;
 }
 
+/*
+ * Return the ARMFPStatusFlavour to use based on element size and
+ * whether FPCR.AH is set.
+ */
+static inline ARMFPStatusFlavour select_ah_fpst(DisasContext *s, MemOp esz)
+{
+    if (s->fpcr_ah) {
+        return esz == MO_16 ? FPST_AH_F16 : FPST_AH;
+    } else {
+        return esz == MO_16 ? FPST_A64_F16 : FPST_A64;
+    }
+}
+
 bool disas_sve(DisasContext *, uint32_t);
 bool disas_sme(DisasContext *, uint32_t);
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac4e8f8ec4a..b01d05fe30e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -723,10 +723,10 @@ static void gen_gvec_op3_ool(DisasContext *s, bool is_q, int rd,
  * an out-of-line helper.
  */
 static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
-                              int rm, bool is_fp16, int data,
+                              int rm, ARMFPStatusFlavour fpsttype, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -5036,14 +5036,16 @@ typedef struct FPScalar {
     void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 } FPScalar;
 
-static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+static bool do_fp3_scalar_with_fpsttype(DisasContext *s, arg_rrr_e *a,
+                                        const FPScalar *f,
+                                        ARMFPStatusFlavour fpsttype)
 {
     switch (a->esz) {
     case MO_64:
         if (fp_access_check(s)) {
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = read_fp_dreg(s, a->rm);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -5051,7 +5053,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = read_fp_sreg(s, a->rm);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5062,7 +5064,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(fpsttype));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5072,6 +5074,18 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
     return true;
 }
 
+static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+{
+    return do_fp3_scalar_with_fpsttype(s, a, f,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp3_scalar_ah(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+{
+    return do_fp3_scalar_with_fpsttype(s, a, f, select_ah_fpst(s, a->esz));
+}
+
 static const FPScalar f_scalar_fadd = {
     gen_helper_vfp_addh,
     gen_helper_vfp_adds,
@@ -5225,14 +5239,14 @@ static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f32,
     gen_helper_recpsf_f64,
 };
-TRANS(FRECPS_s, do_fp3_scalar, a, &f_scalar_frecps)
+TRANS(FRECPS_s, do_fp3_scalar_ah, a, &f_scalar_frecps)
 
 static const FPScalar f_scalar_frsqrts = {
     gen_helper_rsqrtsf_f16,
     gen_helper_rsqrtsf_f32,
     gen_helper_rsqrtsf_f64,
 };
-TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
+TRANS(FRSQRTS_s, do_fp3_scalar_ah, a, &f_scalar_frsqrts)
 
 static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
                        const FPScalar *f, bool swap)
@@ -5483,8 +5497,10 @@ TRANS(CMHS_s, do_cmop_d, a, TCG_COND_GEU)
 TRANS(CMEQ_s, do_cmop_d, a, TCG_COND_EQ)
 TRANS(CMTST_s, do_cmop_d, a, TCG_COND_TSTNE)
 
-static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
-                          gen_helper_gvec_3_ptr * const fns[3])
+static bool do_fp3_vector_with_fpsttype(DisasContext *s, arg_qrrr_e *a,
+                                        int data,
+                                        gen_helper_gvec_3_ptr * const fns[3],
+                                        ARMFPStatusFlavour fpsttype)
 {
     MemOp esz = a->esz;
     int check = fp_access_check_vector_hsd(s, a->q, esz);
@@ -5493,11 +5509,26 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
         return check == 0;
     }
 
-    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16, data, fns[esz - 1]);
+    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm, fpsttype,
+                      data, fns[esz - 1]);
     return true;
 }
 
+static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
+                          gen_helper_gvec_3_ptr * const fns[3])
+{
+    return do_fp3_vector_with_fpsttype(s, a, data, fns,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp3_vector_ah(DisasContext *s, arg_qrrr_e *a, int data,
+                             gen_helper_gvec_3_ptr * const f[3])
+{
+    return do_fp3_vector_with_fpsttype(s, a, data, f,
+                                       select_ah_fpst(s, a->esz));
+}
+
 static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
     gen_helper_gvec_fadd_h,
     gen_helper_gvec_fadd_s,
@@ -5622,14 +5653,14 @@ static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector, a, 0, f_vector_frecps)
+TRANS(FRECPS_v, do_fp3_vector_ah, a, 0, f_vector_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector, a, 0, f_vector_frsqrts)
+TRANS(FRSQRTS_v, do_fp3_vector_ah, a, 0, f_vector_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
@@ -6385,7 +6416,8 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     }
 
     gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16, a->idx, fns[esz - 1]);
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
+                      a->idx, fns[esz - 1]);
     return true;
 }
 
@@ -8394,8 +8426,9 @@ typedef struct FPScalar1 {
     void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_ptr);
 } FPScalar1;
 
-static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
-                          const FPScalar1 *f, int rmode)
+static bool do_fp1_scalar_with_fpsttype(DisasContext *s, arg_rr_e *a,
+                                        const FPScalar1 *f, int rmode,
+                                        ARMFPStatusFlavour fpsttype)
 {
     TCGv_i32 tcg_rmode = NULL;
     TCGv_ptr fpst;
@@ -8407,7 +8440,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fpst = fpstatus_ptr(fpsttype);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -8438,6 +8471,20 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
     return true;
 }
 
+static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    return do_fp1_scalar_with_fpsttype(s, a, f, rmode,
+                                       a->esz == MO_16 ?
+                                       FPST_A64_F16 : FPST_A64);
+}
+
+static bool do_fp1_scalar_ah(DisasContext *s, arg_rr_e *a,
+                             const FPScalar1 *f, int rmode)
+{
+    return do_fp1_scalar_with_fpsttype(s, a, f, rmode, select_ah_fpst(s, a->esz));
+}
+
 static const FPScalar1 f_scalar_fsqrt = {
     gen_helper_vfp_sqrth,
     gen_helper_vfp_sqrts,
@@ -8492,21 +8539,21 @@ static const FPScalar1 f_scalar_frecpe = {
     gen_helper_recpe_f32,
     gen_helper_recpe_f64,
 };
-TRANS(FRECPE_s, do_fp1_scalar, a, &f_scalar_frecpe, -1)
+TRANS(FRECPE_s, do_fp1_scalar_ah, a, &f_scalar_frecpe, -1)
 
 static const FPScalar1 f_scalar_frecpx = {
     gen_helper_frecpx_f16,
     gen_helper_frecpx_f32,
     gen_helper_frecpx_f64,
 };
-TRANS(FRECPX_s, do_fp1_scalar, a, &f_scalar_frecpx, -1)
+TRANS(FRECPX_s, do_fp1_scalar_ah, a, &f_scalar_frecpx, -1)
 
 static const FPScalar1 f_scalar_frsqrte = {
     gen_helper_rsqrte_f16,
     gen_helper_rsqrte_f32,
     gen_helper_rsqrte_f64,
 };
-TRANS(FRSQRTE_s, do_fp1_scalar, a, &f_scalar_frsqrte, -1)
+TRANS(FRSQRTE_s, do_fp1_scalar_ah, a, &f_scalar_frsqrte, -1)
 
 static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
 {
@@ -9361,9 +9408,10 @@ TRANS_FEAT(FRINT64Z_v, aa64_frint, do_fp1_vector, a,
            &f_scalar_frint64, FPROUNDING_ZERO)
 TRANS_FEAT(FRINT64X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint64, -1)
 
-static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
-                             int rd, int rn, int data,
-                             gen_helper_gvec_2_ptr * const fns[3])
+static bool do_gvec_op2_fpst_with_fpsttype(DisasContext *s, MemOp esz,
+                                           bool is_q, int rd, int rn, int data,
+                                           gen_helper_gvec_2_ptr * const fns[3],
+                                           ARMFPStatusFlavour fpsttype)
 {
     int check = fp_access_check_vector_hsd(s, is_q, esz);
     TCGv_ptr fpst;
@@ -9372,7 +9420,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fpst = fpstatus_ptr(fpsttype);
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn), fpst,
                        is_q ? 16 : 8, vec_full_reg_size(s),
@@ -9380,6 +9428,23 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
     return true;
 }
 
+static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
+                             int rd, int rn, int data,
+                             gen_helper_gvec_2_ptr * const fns[3])
+{
+    return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data, fns,
+                                          esz == MO_16 ? FPST_A64_F16 :
+                                          FPST_A64);
+}
+
+static bool do_gvec_op2_ah_fpst(DisasContext *s, MemOp esz, bool is_q,
+                                int rd, int rn, int data,
+                                gen_helper_gvec_2_ptr * const fns[3])
+{
+    return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data,
+                                          fns, select_ah_fpst(s, esz));
+}
+
 static gen_helper_gvec_2_ptr * const f_scvtf_v[] = {
     gen_helper_gvec_vcvt_sh,
     gen_helper_gvec_vcvt_sf,
@@ -9489,14 +9554,14 @@ static gen_helper_gvec_2_ptr * const f_frecpe[] = {
     gen_helper_gvec_frecpe_s,
     gen_helper_gvec_frecpe_d,
 };
-TRANS(FRECPE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
+TRANS(FRECPE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frecpe)
 
 static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
     gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s,
     gen_helper_gvec_frsqrte_d,
 };
-TRANS(FRSQRTE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
+TRANS(FRSQRTE_v, do_gvec_op2_ah_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
 
 static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
 {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e1788330aa7..c084bb58e7e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -137,11 +137,11 @@ static bool gen_gvec_fpst_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
     return true;
 }
 
-static bool gen_gvec_fpst_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
-                                 arg_rr_esz *a, int data)
+static bool gen_gvec_fpst_ah_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
+                                    arg_rr_esz *a, int data)
 {
     return gen_gvec_fpst_zz(s, fn, a->rd, a->rn, data,
-                            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+                            select_ah_fpst(s, a->esz));
 }
 
 /* Invoke an out-of-line helper on 3 Zregs. */
@@ -194,6 +194,13 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
+static bool gen_gvec_fpst_ah_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                                     arg_rrr_esz *a, int data)
+{
+    return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
+                             select_ah_fpst(s, a->esz));
+}
+
 /* Invoke an out-of-line helper on 4 Zregs. */
 static bool gen_gvec_ool_zzzz(DisasContext *s, gen_helper_gvec_4 *fn,
                               int rd, int rn, int rm, int ra, int data)
@@ -3597,13 +3604,13 @@ static gen_helper_gvec_2_ptr * const frecpe_fns[] = {
     NULL,                     gen_helper_gvec_frecpe_h,
     gen_helper_gvec_frecpe_s, gen_helper_gvec_frecpe_d,
 };
-TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_arg_zz, frecpe_fns[a->esz], a, 0)
+TRANS_FEAT(FRECPE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frecpe_fns[a->esz], a, 0)
 
 static gen_helper_gvec_2_ptr * const frsqrte_fns[] = {
     NULL,                      gen_helper_gvec_frsqrte_h,
     gen_helper_gvec_frsqrte_s, gen_helper_gvec_frsqrte_d,
 };
-TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_arg_zz, frsqrte_fns[a->esz], a, 0)
+TRANS_FEAT(FRSQRTE, aa64_sve, gen_gvec_fpst_ah_arg_zz, frsqrte_fns[a->esz], a, 0)
 
 /*
  *** SVE Floating Point Compare with Zero Group
@@ -3707,11 +3714,18 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     };                                                              \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_arg_zzz, name##_fns[a->esz], a, 0)
 
+#define DO_FP3_AH(NAME, name) \
+    static gen_helper_gvec_3_ptr * const name##_fns[4] = {          \
+        NULL, gen_helper_gvec_##name##_h,                           \
+        gen_helper_gvec_##name##_s, gen_helper_gvec_##name##_d      \
+    };                                                              \
+    TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_ah_arg_zzz, name##_fns[a->esz], a, 0)
+
 DO_FP3(FADD_zzz, fadd)
 DO_FP3(FSUB_zzz, fsub)
 DO_FP3(FMUL_zzz, fmul)
-DO_FP3(FRECPS, recps)
-DO_FP3(FRSQRTS, rsqrts)
+DO_FP3_AH(FRECPS, recps)
+DO_FP3_AH(FRSQRTS, rsqrts)
 
 #undef DO_FP3
 
@@ -3993,7 +4007,7 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
 TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+           a, 0, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
-- 
2.34.1


