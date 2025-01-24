Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A2DC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMa1-0006X9-FT; Fri, 24 Jan 2025 11:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYN-0003ta-7I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:08 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYG-0005SL-9b
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso15006755e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736138; x=1738340938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9SD9SO5LCP25e7fb/iGaRdiCK9e0Vue8v7YEc3GCsWk=;
 b=MaFL5hTqXW0qRM0rwX/ZpvV/hXI0M9yPxL8qlccAR3pq40t0DJQBeEbbgZyE0wtAzP
 frAk2EsH3sRZg9T83SYn0KzkcYk55O0ECNrWEolSW+NyvLJh2xg8PrtprHC9GSILAymQ
 Jea83qRDNobxwSZcAxBXWF5J7bHiqtg4yGjTAOIW5Fq+0YvnfPLUaSC68afY7nBP1PW1
 R3TdQ9hBd3RbFDIRguHOr/8Kc+PyU/paRid8twtZGCItM/ZgPk6KRnXoD0A0kO7xM6QD
 bs7pDKJi72TC1SEoMvFEnEGS9ySx0GQbCO23DMdqf+ECMWLc2KBX34wSVhTYheo22UjY
 nvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736138; x=1738340938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9SD9SO5LCP25e7fb/iGaRdiCK9e0Vue8v7YEc3GCsWk=;
 b=vX19Jzch3/1h/1YSLsqFj3T2eURsTjA8ySica/bYFigsJSXzGkGYkejEMBpZttBYcv
 I/0Lyn/3KuXjhwUt7Um73aBYpn/cgKHNRUto3SZBXYyoH9X65rl+qUfAhaZi4vw3xrO2
 hU+BS5xGYP7t9lL2Q9SNaDQ4U9oUE1vIUl9CrgWENxJHG6DKwq/z2h3Lib5ykJKWNXiR
 I8g+rpmfDjt1zkdfgCoN5NXRv366bfY7bRBUk7DaJaKSs9iHeOs1SXHWiSTIBJeD7GFe
 sUa2Ig8UU646rImlHMl4P6q0XShfP8vzLyX1+wmr20NO2pG99uIWu4tn5eqATeg5keH+
 g0mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGjexRad+sJmRaNizqnEnS/ulx+OpZdNZqyelCWplsWP+WkbfBkS4mmcMRxubeZCZpmfS2K1fq1/aE@nongnu.org
X-Gm-Message-State: AOJu0Yw3MO2r9yBO5wg4kqNamuFZop7EpVaZa1nXv1z6L6DghOI76TH4
 jQnrp2E42y2/7wsby37OeHSgOB/hpUVN/Es0sS+z/ZHRNjFyUHs7kmT0F4/zivjKagBsPfceAaL
 2
X-Gm-Gg: ASbGnct6Ll/2CYoESS9cxXVeoNXlbrQ+HyfdUNw1HH1DOYTBBVBbxpPh6Wl41ao5tk4
 dfOxDy7pkZ7tlv2c7piFo83+hJu8ZWrbnht5yS1gBg7CrhJexwhT1HPrRn0+cb7vXTEiypD6xFe
 56AAKWMsW3WxoQ9qE7YTw3x3+GiZQ4WwSqibI7kxwX8pB4zUE3BizchQ0Gk/fd9Q2rgyN3i7zI1
 tBc3F6ROHUmJjgATfVTp2MBLlzNDfAdYznuUeoWoFIYnWasg3Iyp0qLqNg5XLayQJOlUQ7J4Yo/
 8DSvuRfs9/oFtPV6OUJV8A==
X-Google-Smtp-Source: AGHT+IFXHq6Jy7SHdUZ7HbpH4FMDCcuUvhGApOz6XoM8mSem6+bFa4xJxWPmFYby+kwbjEhpWSQ5MA==
X-Received: by 2002:a05:600c:3844:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-438913dbc09mr299117405e9.12.1737736138358; 
 Fri, 24 Jan 2025 08:28:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/76] target/arm: Use FPST_FPCR_F16_A64 in A64 decoder
Date: Fri, 24 Jan 2025 16:27:37 +0000
Message-Id: <20250124162836.2332150-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In the A32 decoder, use FPST_FPCR_F16_A32 rather than FPST_FPCR_F16.
By doing an automated conversion of the whole file we avoid possibly
using more than one fpst value in a set_rmode/op/restore_rmode
sequence.

Patch created with
  perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_FPCR_F16_A64/g' target/arm/tcg/translate-{a64,sve,sme}.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 32 ++++++++---------
 target/arm/tcg/translate-sve.c | 66 +++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9f10b2b2e6a..b713a5f6025 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -726,7 +726,7 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, bool is_fp16, int data,
                               gen_helper_gvec_3_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm), fpst,
@@ -768,7 +768,7 @@ static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
                               int rm, int ra, bool is_fp16, int data,
                               gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn),
                        vec_full_reg_offset(s, rm),
@@ -5062,7 +5062,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
         if (fp_access_check(s)) {
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = read_fp_hreg(s, a->rm);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -5270,9 +5270,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = tcg_constant_i32(0);
             if (swap) {
-                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_FPCR_F16));
+                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_FPCR_F16_A64));
             } else {
-                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
             }
             write_fp_sreg(s, a->rd, t0);
         }
@@ -6230,7 +6230,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i32 t1 = tcg_temp_new_i32();
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6288,7 +6288,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_negh(t1, t1);
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
-                                       fpstatus_ptr(FPST_FPCR_F16));
+                                       fpstatus_ptr(FPST_FPCR_F16_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6626,7 +6626,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t0, a->rn, 0, MO_16);
             read_vec_element_i32(s, t1, a->rn, 1, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -6801,7 +6801,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_negh(tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR_F16);
+            fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
             write_fp_sreg(s, a->rd, ta);
         }
@@ -6895,7 +6895,7 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
-        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
         TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst, fn);
         write_fp_sreg(s, a->rd, res);
     }
@@ -6939,7 +6939,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -8407,7 +8407,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -8598,7 +8598,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tcg_shift = tcg_constant_i32(shift);
 
     switch (esz) {
@@ -8693,7 +8693,7 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tcg_shift = tcg_constant_i32(shift);
     tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
 
@@ -9312,7 +9312,7 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -9372,7 +9372,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, rd),
                        vec_full_reg_offset(s, rn), fpst,
                        is_q ? 16 : 8, vec_full_reg_size(s),
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index caf8ea18328..37de816964a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -141,7 +141,7 @@ static bool gen_gvec_fpst_arg_zz(DisasContext *s, gen_helper_gvec_2_ptr *fn,
                                  arg_rr_esz *a, int data)
 {
     return gen_gvec_fpst_zz(s, fn, a->rd, a->rn, data,
-                            a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+                            a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 }
 
 /* Invoke an out-of-line helper on 3 Zregs. */
@@ -191,7 +191,7 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
-                             a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+                             a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 }
 
 /* Invoke an out-of-line helper on 4 Zregs. */
@@ -397,7 +397,7 @@ static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 }
 
 /* Invoke a vector expander on two Zregs and an immediate.  */
@@ -3517,7 +3517,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
                               (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 }
 
 TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
@@ -3533,7 +3533,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 /*
  *** SVE Floating Point Fast Reduction Group
@@ -3566,7 +3566,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 
     fn(temp, t_zn, t_pg, status, t_desc);
 
@@ -3618,7 +3618,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status =
-            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 
         tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
@@ -3654,7 +3654,7 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
 };
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
                         ftmad_fns[a->esz], a->rd, a->rn, a->rm, a->imm,
-                        a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+                        a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 /*
  *** SVE Floating Point Accumulating Reduction Group
@@ -3687,7 +3687,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, tcg_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     t_desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3762,7 +3762,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
 
-    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 }
@@ -3814,7 +3814,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3847,7 +3847,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 #define DO_FMLA(NAME, name) \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
@@ -3856,7 +3856,7 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
     };                                                                  \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp, name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+               a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz)
 DO_FMLA(FMLS_zpzzz, fmls_zpzzz)
@@ -3871,14 +3871,14 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
 TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 /*
  *** SVE Floating Point Unary Operations Predicated Group
@@ -3902,17 +3902,17 @@ TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_FPCR_A64)
 
 TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVTZU_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVTZS_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hs, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hs, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVTZU_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hs, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hs, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVTZS_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hd, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzs_hd, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_FPCR_A64)
@@ -3939,7 +3939,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_d
 };
 TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -3948,7 +3948,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_d
 };
 TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -3965,7 +3965,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     }
 
     vsz = vec_full_reg_size(s);
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
     tmode = gen_set_rmode(mode, status);
 
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
@@ -3993,21 +3993,21 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
     gen_helper_sve_frecpx_s, gen_helper_sve_frecpx_d,
 };
 TRANS_FEAT(FRECPX, aa64_sve, gen_gvec_fpst_arg_zpz, frecpx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
 TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(SCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_sh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_sh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_FPCR_A64)
@@ -4020,11 +4020,11 @@ TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_FPCR_A64)
 
 TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(UCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_sh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_sh, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16)
+           gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_FPCR_A64)
@@ -7057,7 +7057,7 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     gen_helper_flogb_s, gen_helper_flogb_d
 };
 TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
-- 
2.34.1


