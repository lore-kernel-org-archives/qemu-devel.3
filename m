Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA614C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2q-0000nQ-7M; Tue, 28 Jan 2025 20:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2n-0000mK-PL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2l-0003Tt-05
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21654fdd5daso107154665ad.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114742; x=1738719542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yk4nAud5otRzQ3dxne70+kFMJfAxDBcEqlullUGNgUE=;
 b=u0+dR5dYTg1wniQotRZSvtjfPItJeKAuPx0UULRt0CA4UobIjiQfUc/HttcOYZiRqm
 C/Szevb1AMc8pHZRJVR5jhwEH623eGRXy4qO+1OlZAGZ2qpNUJSFpRecUg8Y1za2RHLR
 L3iO7gfKLZwZCecjCiCRSGkKM2RCoCmDIa2AgfVM9dav7v3V+tXrRkilqN3DazChqQ9o
 iz5CavFMGaoFUrsct1Dz5qP/XpYOroIYWJ7KymWUE/+voEZOBxeXgGRVydGgMleg/N6D
 31wsmQ152GA2q5xfnopa+PtDgvA0RPzLYr7Butwhy5nSR8ghOOW+t0nWcB8B+BfRnQ05
 7i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114742; x=1738719542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yk4nAud5otRzQ3dxne70+kFMJfAxDBcEqlullUGNgUE=;
 b=OD0A8OcEhGv3s6cafe9iAY2/5iaiYqbEFicXVjoOb3Ma4Gw4R/g/Zhlc6pTfq4hiuH
 GHrsBzbwdXaPG9gDpe3C8ncCo5CcKCfCKqh54gJQA3jFjCokMc1focJ1LeZaViqJqzYq
 HofDbNMG8F0GGPPQzJ85egVRVzIABbyWTSQ9E0KQJQNVXtC1RDpLIGG2B7AxeEl3gxNp
 Ntjar5JXkeLHMZDS+BmGjio2SFX2yOXsguYR7oJDXKV4LyDDNQ7TLHu7yQ9X6eFJUnd5
 VO0N8RWcjUuzaa9NyKUa60NwGwTcHI2DvvZEvurzescTreL/qr3kaBbZIkYwSHciVJbh
 gLNQ==
X-Gm-Message-State: AOJu0Yzze5nxaJAq4QGv5Qysc6LGIWzkqS2QyLlp5mWcfX9qF7JUK9G7
 YlZtkol3nx1rgKnGkRAzYfyyxU66SCtoTryu08ZZVXsKEN0JatjygMlF+vH/FMFDtpfUg0qyFwM
 W
X-Gm-Gg: ASbGncsnf9Q9emn4BE/gaNBcvMVCdljotCkzWj5kA3SKZTOcL8vZXG6ML/AODXcSZ1/
 saLlnOR9f9iYZ+3NmdO0XJ9SrBYiJchZEo6uBuewgPRSaUVWkJGMEwfnUfyvjGAx+J0Hnkhk3A/
 xlL5reHKw58y0kyLYqw9VRdafex8qAMrrpOsHzcixBRq/+QpyGdE347xU3tAS+cdd0Wja4Kq3GP
 TuWL2jLLQjSwM/Ct7xX0y3cHCEOUr1vO6xqzAkpHYo6p/sWAC95W0ewdlZTBkT7VBMPZKN/WGef
 cTIXbp3CaHWyq5Xx3wJ+ymgQSisewssw52sp0J36mGRGBoYJXA==
X-Google-Smtp-Source: AGHT+IHjDm+9LZvNgv1PBloOUq7ygiT9ZCR9ul/OCQwZDHefYwUPcGRSRpBFSBbbmeOynfVgwyujsQ==
X-Received: by 2002:a17:902:f60d:b0:216:725c:a11a with SMTP id
 d9443c01a7336-21dd7c35649mr23200175ad.10.1738114741532; 
 Tue, 28 Jan 2025 17:39:01 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 04/34] target/arm: Rename FPST_FPCR_F16_A64 to FPST_A64_F16
Date: Tue, 28 Jan 2025 17:38:27 -0800
Message-ID: <20250129013857.135256-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/tcg/translate.h     |  8 ++---
 target/arm/tcg/translate-a64.c | 44 +++++++++++------------
 target/arm/tcg/translate-sve.c | 66 +++++++++++++++++-----------------
 3 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index adf6eb8b91..cc753419ed 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -677,7 +677,7 @@ typedef enum ARMFPStatusFlavour {
     FPST_A32,
     FPST_A64,
     FPST_A32_F16,
-    FPST_FPCR_F16_A64,
+    FPST_A64_F16,
     FPST_FPCR_AH,
     FPST_FPCR_AH_F16,
     FPST_STD,
@@ -698,7 +698,7 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_A32_F16
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
- * FPST_FPCR_F16_A64
+ * FPST_A64_F16
  *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_FPCR_AH:
  *   for AArch64 operations which change behaviour when AH=1 (specifically,
@@ -726,7 +726,7 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_A32_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a32);
         break;
-    case FPST_FPCR_F16_A64:
+    case FPST_A64_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
         break;
     case FPST_FPCR_AH:
@@ -757,7 +757,7 @@ static inline ARMFPStatusFlavour select_fpst(DisasContext *s, MemOp esz)
     if (s->fpcr_ah) {
         return esz == MO_16 ? FPST_FPCR_AH_F16 : FPST_FPCR_AH;
     } else {
-        return esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64;
+        return esz == MO_16 ? FPST_A64_F16 : FPST_A64;
     }
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bf17ecca80..35d409685c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5247,7 +5247,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
 {
     return do_fp3_scalar_with_fpsttype(s, a, f, mergereg,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 : FPST_A64);
+                                       FPST_A64_F16 : FPST_A64);
 }
 
 static bool do_fp3_scalar_ah_2fn(DisasContext *s, arg_rrr_e *a,
@@ -5533,9 +5533,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i32 t0 = read_fp_hreg(s, a->rn);
             TCGv_i32 t1 = tcg_constant_i32(0);
             if (swap) {
-                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_FPCR_F16_A64));
+                f->gen_h(t0, t1, t0, fpstatus_ptr(FPST_A64_F16));
             } else {
-                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
+                f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             }
             write_fp_sreg(s, a->rd, t0);
         }
@@ -5768,7 +5768,7 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
 {
     return do_fp3_vector_with_fpsttype(s, a, data, fns,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 :FPST_A64);
+                                       FPST_A64_F16 :FPST_A64);
 }
 
 static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
@@ -6174,7 +6174,7 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
+                      a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
                       a->rot, fn[a->esz]);
     return true;
 }
@@ -6566,7 +6566,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i32 t1 = tcg_temp_new_i32();
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             write_fp_hreg_merging(s, a->rd, a->rn, t0);
         }
         break;
@@ -6624,7 +6624,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
                 gen_vfp_maybe_ah_negh(s, t1, t1);
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
-                                       fpstatus_ptr(FPST_FPCR_F16_A64));
+                                       fpstatus_ptr(FPST_A64_F16));
             write_fp_hreg_merging(s, a->rd, a->rd, t0);
         }
         break;
@@ -6721,7 +6721,7 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     }
 
     gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
                       a->idx, fns[esz - 1]);
     return true;
 }
@@ -6755,7 +6755,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
+                      esz == MO_16 ? FPST_A64_F16 : FPST_A64,
                       (s->fpcr_ah << 5) | (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
@@ -6921,7 +6921,7 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     }
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
+                          a->esz == MO_16 ? FPST_A64_F16 : FPST_A64,
                           (a->idx << 2) | a->rot, fn);
     }
     return true;
@@ -6966,7 +6966,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t0, a->rn, 0, MO_16);
             read_vec_element_i32(s, t1, a->rn, 1, MO_16);
-            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16_A64));
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_A64_F16));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -7148,7 +7148,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_maybe_ah_negh(s, tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
+            fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
             write_fp_hreg_merging(s, a->rd, a->ra, ta);
         }
@@ -7243,7 +7243,7 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
-        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
         TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst,
                                        s->fpcr_ah ? fah : fnormal);
         write_fp_sreg(s, a->rd, res);
@@ -7294,7 +7294,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_A64_F16 : FPST_A64);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -8829,7 +8829,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
 {
     return do_fp1_scalar_with_fpsttype(s, a, f, rmode,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 : FPST_A64);
+                                       FPST_A64_F16 : FPST_A64);
 }
 
 static bool do_fp1_scalar_ah(DisasContext *s, arg_rr_e *a,
@@ -8999,7 +8999,7 @@ static bool trans_FCVT_s_sh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64_F16);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f32(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -9013,7 +9013,7 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_hreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
-        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
+        TCGv_ptr tcg_fpst = fpstatus_ptr(FPST_A64_F16);
         TCGv_i32 tcg_ahp = get_ahp_flag();
 
         gen_helper_vfp_fcvt_f16_to_f64(tcg_rd, tcg_rn, tcg_fpst, tcg_ahp);
@@ -9029,7 +9029,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
 
     switch (esz) {
@@ -9124,7 +9124,7 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
     tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
 
@@ -9773,7 +9773,7 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -9847,7 +9847,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
                              gen_helper_gvec_2_ptr * const fns[3])
 {
     return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data, fns,
-                                          esz == MO_16 ? FPST_FPCR_F16_A64 :
+                                          esz == MO_16 ? FPST_A64_F16 :
                                           FPST_A64);
 }
 
@@ -10024,7 +10024,7 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         TCGv_i32 tcg_res[4];
         TCGv_i32 ahp = get_ahp_flag();
 
-        fpst = fpstatus_ptr(FPST_FPCR_F16_A64);
+        fpst = fpstatus_ptr(FPST_A64_F16);
 
         for (pass = 0; pass < 4; pass++) {
             tcg_res[pass] = tcg_temp_new_i32();
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3cc678154a..3811316a2d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -191,7 +191,7 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
-                             a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+                             a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 static bool gen_gvec_fpst_ah_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
@@ -404,7 +404,7 @@ static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
-                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 /* Invoke a vector expander on two Zregs and an immediate.  */
@@ -3534,7 +3534,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
                               (s->fpcr_ah << 5) | (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+                              a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
 
 TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
@@ -3550,7 +3550,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Fast Reduction Group
@@ -3583,7 +3583,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
     fn(temp, t_zn, t_pg, status, t_desc);
 
@@ -3659,7 +3659,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status =
-            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+            fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
         tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
@@ -3696,7 +3696,7 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
                         ftmad_fns[a->esz], a->rd, a->rn, a->rm,
                         a->imm | (s->fpcr_ah << 3),
-                        a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+                        a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Accumulating Reduction Group
@@ -3729,7 +3729,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, tcg_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     t_desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3829,7 +3829,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
 
-    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    status = fpstatus_ptr(is_fp16 ? FPST_A64_F16 : FPST_A64);
     desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 }
@@ -3902,7 +3902,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3935,7 +3935,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 #define DO_FMLA(NAME, name, ah_name)                                    \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
@@ -3949,7 +3949,7 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp,                     \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz, fmla_zpzzz)
@@ -3965,14 +3965,14 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
 TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 /*
  *** SVE Floating Point Unary Operations Predicated Group
@@ -3981,7 +3981,7 @@ TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
 TRANS_FEAT(FCVT_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hs, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvt_hs, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
@@ -3990,24 +3990,24 @@ TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_hd, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvt_hd, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVT_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzs_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzu_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZS_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hs, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzs_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hs, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzu_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZS_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_hd, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzs_hd, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_fcvtzu_hd, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
@@ -4034,7 +4034,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_d
 };
 TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4043,7 +4043,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_d
 };
 TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -4060,7 +4060,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     }
 
     vsz = vec_full_reg_size(s);
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
     tmode = gen_set_rmode(mode, status);
 
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
@@ -4095,14 +4095,14 @@ static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
 TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(SCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_sh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_scvt_sh, a, 0, FPST_A64_F16)
 TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_scvt_dh, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_ss, a, 0, FPST_A64)
@@ -4115,11 +4115,11 @@ TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_ucvt_hh, a, 0, FPST_A64_F16)
 TRANS_FEAT(UCVTF_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_sh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_ucvt_sh, a, 0, FPST_A64_F16)
 TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16_A64)
+           gen_helper_sve_ucvt_dh, a, 0, FPST_A64_F16)
 
 TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
@@ -7153,7 +7153,7 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     gen_helper_flogb_s, gen_helper_flogb_d
 };
 TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
+           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
-- 
2.43.0


