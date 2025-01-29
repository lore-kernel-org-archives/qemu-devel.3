Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53400C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2t-0000oS-9S; Tue, 28 Jan 2025 20:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2n-0000mI-F9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2j-0003TY-SV
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216395e151bso3230195ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114740; x=1738719540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yghuBtj/DIiN8eRSXNAxvUfkjrNQffbHrvxPfCnEeII=;
 b=bhPapG1RGtve432mqt5mAVNRUTBnPDwcMbAtrdcOU7m/nDsDPaBYMPLJNfiivBYp3I
 QixjLO1ue2MmsyAHw/COrzCuCm+75doCws5GdJlGQcWsE2bn0TwoV343Sf8PjIQPFcQr
 ha8CEBn9BnApT0td4ogKUDiO+6hpQPtkszr96rASxDAn8ULrrUr2U3nQwCmnt1Wg55WC
 yJjgnL7AGMC8ERim8NLhp6sszHw9XQd9bBYiWjXq5qiYDRlxv7IVAD0M7PKEH5+xbnU8
 QA1RdnFvpgAsoGVCi4vLIIhdD5g3Zf4V9cgtGr5sCM7doBEvT4Sj7zFnSjTQwGp7zrPi
 h9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114740; x=1738719540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yghuBtj/DIiN8eRSXNAxvUfkjrNQffbHrvxPfCnEeII=;
 b=Tts3+hAZyU7w/1gVPUYlNGmw9cOyF75hYSTXAat2PdTnvrcDoaN62uy5Swo5dBtKHw
 Onxd6iwhVID8w9oq0jY2WRfDMq84ozXW40+FvoRU544jpwADxQ2v+M9yKBdLrek960Jf
 a+KJD4fEeYJr46QvqxWQIG9OmazXI4/EuCma9whKGF13c1K8Z2WpYl8rJdyhXWv00MVm
 AY/DxvxCpRZr3mz2igZibBSAwr7azMwxq7TWdgNypy5YlrcRuWaYcBhED/6StWuGNkVJ
 tMWrvSIjmOOvHKWWMFcU6fmHZg4BdL4SmkFmj2AeQA4yBMFRrl2rt9IdRkN/Wsgsbze+
 bGfA==
X-Gm-Message-State: AOJu0YzXnBWNCgX008cSKXiXdJP/rXA2paCwk+/dmGM0UTyGnqWMVyIT
 SKYNNihmuwYNGtT78Mnl8ZKBwrDwObLBKcDvhFlBon0p9zeQMmB4B8er7iOlleOZwLwVYQ8c+2P
 z
X-Gm-Gg: ASbGnct0cRwMXyH++2xb8L/0Z2iFMWKVGrPjuWKnCx7BmklZcRSnXKfIwsAaj/lgyfj
 fcKnLqJ1VcE98iuWaR+vFoFnRtt+VEGahqU94AUuVzPAvnSQNEhFmfPX4p8hZMvHNDQrk1UReiP
 jYwJYF+jCckplFZ/INCG24PloYOHdRDFT07G970pB9/1hdFJ8DDZFtTQbIdQK67C9Hg7vYgQM+x
 M0iK9eFS1TyZp7wH2bY2QFljfKwqYASCw4f92KWY/6bTjPdt/szx+Tdz0kINpT4p/1DsxNGfwCH
 LGWNB3dCJVC5ijnG/QyaEXKaTvQph5yB+ADtaB9AtI58HTpj+Q==
X-Google-Smtp-Source: AGHT+IFTNdpoOLN/uktwFBZgtHV1y3tQQAXhrpndM1OOgHOxtrVJvpWv3YaMUfQr8dlUVOCbO3NAPA==
X-Received: by 2002:a17:902:e74a:b0:215:8847:4377 with SMTP id
 d9443c01a7336-21dd778de3bmr19153395ad.15.1738114740129; 
 Tue, 28 Jan 2025 17:39:00 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:38:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 02/34] target/arm: Rename FPST_FPCR_A64 to FPST_A64
Date: Tue, 28 Jan 2025 17:38:25 -0800
Message-ID: <20250129013857.135256-3-richard.henderson@linaro.org>
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
 target/arm/tcg/translate.h     |  8 +--
 target/arm/tcg/translate-a64.c | 78 +++++++++++++--------------
 target/arm/tcg/translate-sme.c |  4 +-
 target/arm/tcg/translate-sve.c | 98 +++++++++++++++++-----------------
 4 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 6ce2471aa6..2edb707b85 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -675,7 +675,7 @@ static inline CPUARMTBFlags arm_tbflags_from_tb(const TranslationBlock *tb)
  */
 typedef enum ARMFPStatusFlavour {
     FPST_A32,
-    FPST_FPCR_A64,
+    FPST_A64,
     FPST_FPCR_F16_A32,
     FPST_FPCR_F16_A64,
     FPST_FPCR_AH,
@@ -694,7 +694,7 @@ typedef enum ARMFPStatusFlavour {
  *
  * FPST_A32
  *   for AArch32 non-FP16 operations controlled by the FPCR
- * FPST_FPCR_A64
+ * FPST_A64
  *   for AArch64 non-FP16 operations controlled by the FPCR
  * FPST_FPCR_F16_A32
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
@@ -720,7 +720,7 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_A32:
         offset = offsetof(CPUARMState, vfp.fp_status_a32);
         break;
-    case FPST_FPCR_A64:
+    case FPST_A64:
         offset = offsetof(CPUARMState, vfp.fp_status_a64);
         break;
     case FPST_FPCR_F16_A32:
@@ -757,7 +757,7 @@ static inline ARMFPStatusFlavour select_fpst(DisasContext *s, MemOp esz)
     if (s->fpcr_ah) {
         return esz == MO_16 ? FPST_FPCR_AH_F16 : FPST_FPCR_AH;
     } else {
-        return esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64;
+        return esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64;
     }
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e2fe46464..bf17ecca80 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5247,7 +5247,7 @@ static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f,
 {
     return do_fp3_scalar_with_fpsttype(s, a, f, mergereg,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+                                       FPST_FPCR_F16_A64 : FPST_A64);
 }
 
 static bool do_fp3_scalar_ah_2fn(DisasContext *s, arg_rrr_e *a,
@@ -5506,9 +5506,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i64 t0 = read_fp_dreg(s, a->rn);
             TCGv_i64 t1 = tcg_constant_i64(0);
             if (swap) {
-                f->gen_d(t0, t1, t0, fpstatus_ptr(FPST_FPCR_A64));
+                f->gen_d(t0, t1, t0, fpstatus_ptr(FPST_A64));
             } else {
-                f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+                f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             }
             write_fp_dreg(s, a->rd, t0);
         }
@@ -5518,9 +5518,9 @@ static bool do_fcmp0_s(DisasContext *s, arg_rr_e *a,
             TCGv_i32 t0 = read_fp_sreg(s, a->rn);
             TCGv_i32 t1 = tcg_constant_i32(0);
             if (swap) {
-                f->gen_s(t0, t1, t0, fpstatus_ptr(FPST_FPCR_A64));
+                f->gen_s(t0, t1, t0, fpstatus_ptr(FPST_A64));
             } else {
-                f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+                f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             }
             write_fp_sreg(s, a->rd, t0);
         }
@@ -5768,7 +5768,7 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
 {
     return do_fp3_vector_with_fpsttype(s, a, data, fns,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 :FPST_FPCR_A64);
+                                       FPST_FPCR_F16_A64 :FPST_A64);
 }
 
 static bool do_fp3_vector_2fn(DisasContext *s, arg_qrrr_e *a, int data,
@@ -6135,7 +6135,7 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
         gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
-                          s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64, a->q,
+                          s->fpcr_ah ? FPST_FPCR_AH : FPST_A64, a->q,
                           gen_helper_gvec_bfmlal);
     }
     return true;
@@ -6174,7 +6174,7 @@ static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                      a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
                       a->rot, fn[a->esz]);
     return true;
 }
@@ -6543,7 +6543,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i64 t1 = tcg_temp_new_i64();
 
             read_vec_element(s, t1, a->rm, a->idx, MO_64);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_dreg_merging(s, a->rd, a->rn, t0);
         }
         break;
@@ -6553,7 +6553,7 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
             TCGv_i32 t1 = tcg_temp_new_i32();
 
             read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_sreg_merging(s, a->rd, a->rn, t0);
         }
         break;
@@ -6592,7 +6592,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             if (neg) {
                 gen_vfp_maybe_ah_negd(s, t1, t1);
             }
-            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR_A64));
+            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_dreg_merging(s, a->rd, a->rd, t0);
         }
         break;
@@ -6606,7 +6606,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
             if (neg) {
                 gen_vfp_maybe_ah_negs(s, t1, t1);
             }
-            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR_A64));
+            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_sreg_merging(s, a->rd, a->rd, t0);
         }
         break;
@@ -6721,7 +6721,7 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
     }
 
     gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
                       a->idx, fns[esz - 1]);
     return true;
 }
@@ -6755,7 +6755,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
     }
 
     gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                      esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
                       (s->fpcr_ah << 5) | (a->idx << 1) | neg,
                       fns[esz - 1]);
     return true;
@@ -6892,7 +6892,7 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
         gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
-                          s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64,
+                          s->fpcr_ah ? FPST_FPCR_AH : FPST_A64,
                           (a->idx << 1) | a->q,
                           gen_helper_gvec_bfmlal_idx);
     }
@@ -6921,7 +6921,7 @@ static bool trans_FCMLA_vi(DisasContext *s, arg_FCMLA_vi *a)
     }
     if (fp_access_check(s)) {
         gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64,
+                          a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64,
                           (a->idx << 2) | a->rot, fn);
     }
     return true;
@@ -6941,7 +6941,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element(s, t0, a->rn, 0, MO_64);
             read_vec_element(s, t1, a->rn, 1, MO_64);
-            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_dreg(s, a->rd, t0);
         }
         break;
@@ -6952,7 +6952,7 @@ static bool do_fp3_scalar_pair(DisasContext *s, arg_rr_e *a, const FPScalar *f)
 
             read_vec_element_i32(s, t0, a->rn, 0, MO_32);
             read_vec_element_i32(s, t1, a->rn, 1, MO_32);
-            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR_A64));
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_A64));
             write_fp_sreg(s, a->rd, t0);
         }
         break;
@@ -7109,7 +7109,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_maybe_ah_negd(s, tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR_A64);
+            fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
             write_fp_dreg_merging(s, a->rd, a->ra, ta);
         }
@@ -7127,7 +7127,7 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             if (neg_n) {
                 gen_vfp_maybe_ah_negs(s, tn, tn);
             }
-            fpst = fpstatus_ptr(FPST_FPCR_A64);
+            fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
             write_fp_sreg_merging(s, a->rd, a->ra, ta);
         }
@@ -7243,7 +7243,7 @@ static bool do_fp_reduction(DisasContext *s, arg_qrr_e *a,
     if (fp_access_check(s)) {
         MemOp esz = a->esz;
         int elts = (a->q ? 16 : 8) >> esz;
-        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
         TCGv_i32 res = do_reduction_op(s, a->rn, esz, 0, elts, fpst,
                                        s->fpcr_ah ? fah : fnormal);
         write_fp_sreg(s, a->rd, res);
@@ -7294,7 +7294,7 @@ static void handle_fp_compare(DisasContext *s, int size,
                               bool cmp_with_zero, bool signal_all_nans)
 {
     TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 
     if (size == MO_64) {
         TCGv_i64 tcg_vn, tcg_vm;
@@ -8829,7 +8829,7 @@ static bool do_fp1_scalar(DisasContext *s, arg_rr_e *a,
 {
     return do_fp1_scalar_with_fpsttype(s, a, f, rmode,
                                        a->esz == MO_16 ?
-                                       FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+                                       FPST_FPCR_F16_A64 : FPST_A64);
 }
 
 static bool do_fp1_scalar_ah(DisasContext *s, arg_rr_e *a,
@@ -8866,7 +8866,7 @@ TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
 static bool trans_BFCVT_s(DisasContext *s, arg_rr_e *a)
 {
-    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64;
+    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_FPCR_AH : FPST_A64;
     TCGv_i32 t32;
     int check;
 
@@ -8944,7 +8944,7 @@ static bool trans_FCVT_s_ds(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tcg_rn = read_fp_sreg(s, a->rn);
         TCGv_i64 tcg_rd = tcg_temp_new_i64();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtds(tcg_rd, tcg_rn, fpst);
         write_fp_dreg_merging(s, a->rd, a->rd, tcg_rd);
@@ -8957,7 +8957,7 @@ static bool trans_FCVT_s_hs(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i32 tmp = read_fp_sreg(s, a->rn);
         TCGv_i32 ahp = get_ahp_flag();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
         /* write_fp_hreg_merging is OK here because top half of result is zero */
@@ -8971,7 +8971,7 @@ static bool trans_FCVT_s_sd(DisasContext *s, arg_rr *a)
     if (fp_access_check(s)) {
         TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvtsd(tcg_rd, tcg_rn, fpst);
         write_fp_sreg_merging(s, a->rd, a->rd, tcg_rd);
@@ -8985,7 +8985,7 @@ static bool trans_FCVT_s_hd(DisasContext *s, arg_rr *a)
         TCGv_i64 tcg_rn = read_fp_dreg(s, a->rn);
         TCGv_i32 tcg_rd = tcg_temp_new_i32();
         TCGv_i32 ahp = get_ahp_flag();
-        TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+        TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
         gen_helper_vfp_fcvt_f64_to_f16(tcg_rd, tcg_rn, fpst, ahp);
         /* write_fp_hreg_merging is OK here because top half of tcg_rd is zero */
@@ -9029,7 +9029,7 @@ static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
 
     switch (esz) {
@@ -9124,7 +9124,7 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
 
-    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
     tcg_shift = tcg_constant_i32(shift);
     tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
 
@@ -9290,7 +9290,7 @@ static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
     }
     if (fp_access_check(s)) {
         TCGv_i64 t = read_fp_dreg(s, a->rn);
-        TCGv_ptr fpstatus = fpstatus_ptr(FPST_FPCR_A64);
+        TCGv_ptr fpstatus = fpstatus_ptr(FPST_A64);
 
         gen_helper_fjcvtzs(t, t, fpstatus);
 
@@ -9550,7 +9550,7 @@ static bool trans_FCVTXN_s(DisasContext *s, arg_rr_e *a)
          */
         TCGv_i64 src = read_fp_dreg(s, a->rn);
         TCGv_i32 dst = tcg_temp_new_i32();
-        gen_helper_fcvtx_f64_to_f32(dst, src, fpstatus_ptr(FPST_FPCR_A64));
+        gen_helper_fcvtx_f64_to_f32(dst, src, fpstatus_ptr(FPST_A64));
         write_fp_sreg_merging(s, a->rd, a->rd, dst);
     }
     return true;
@@ -9638,7 +9638,7 @@ static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
     TCGv_i32 tcg_lo = tcg_temp_new_i32();
     TCGv_i32 tcg_hi = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
     TCGv_i32 ahp = get_ahp_flag();
 
     tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, n);
@@ -9651,7 +9651,7 @@ static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
 
     gen_helper_vfp_fcvtsd(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
@@ -9664,7 +9664,7 @@ static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
      * with von Neumann rounding (round to odd)
      */
     TCGv_i32 tmp = tcg_temp_new_i32();
-    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_FPCR_A64));
+    gen_helper_fcvtx_f64_to_f32(tmp, n, fpstatus_ptr(FPST_A64));
     tcg_gen_extu_i32_i64(d, tmp);
 }
 
@@ -9683,7 +9683,7 @@ TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
 static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_A64);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_A64);
     TCGv_i32 tmp = tcg_temp_new_i32();
     gen_helper_bfcvt_pair(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
@@ -9773,7 +9773,7 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
         return check == 0;
     }
 
-    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
     if (rmode >= 0) {
         tcg_rmode = gen_set_rmode(rmode, fpst);
     }
@@ -9848,7 +9848,7 @@ static bool do_gvec_op2_fpst(DisasContext *s, MemOp esz, bool is_q,
 {
     return do_gvec_op2_fpst_with_fpsttype(s, esz, is_q, rd, rn, data, fns,
                                           esz == MO_16 ? FPST_FPCR_F16_A64 :
-                                          FPST_FPCR_A64);
+                                          FPST_A64);
 }
 
 static bool do_gvec_op2_ah_fpst(DisasContext *s, MemOp esz, bool is_q,
@@ -10008,7 +10008,7 @@ static bool trans_FCVTL_v(DisasContext *s, arg_qrr_e *a)
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         int srcelt = a->q ? 2 : 0;
 
-        fpst = fpstatus_ptr(FPST_FPCR_A64);
+        fpst = fpstatus_ptr(FPST_A64);
 
         for (pass = 0; pass < 2; pass++) {
             tcg_res[pass] = tcg_temp_new_i64();
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 29bec7dd7b..fcbb350016 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -358,9 +358,9 @@ static bool do_outprod_env(DisasContext *s, arg_op *a, MemOp esz,
 TRANS_FEAT(FMOPA_h, aa64_sme, do_outprod_env, a,
            MO_32, gen_helper_sme_fmopa_h)
 TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
-           MO_32, FPST_FPCR_A64, gen_helper_sme_fmopa_s)
+           MO_32, FPST_A64, gen_helper_sme_fmopa_s)
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
-           MO_64, FPST_FPCR_A64, gen_helper_sme_fmopa_d)
+           MO_64, FPST_A64, gen_helper_sme_fmopa_d)
 
 TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 454f7ff900..3cc678154a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -191,7 +191,7 @@ static bool gen_gvec_fpst_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
                                   arg_rrr_esz *a, int data)
 {
     return gen_gvec_fpst_zzz(s, fn, a->rd, a->rn, a->rm, data,
-                             a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+                             a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 }
 
 static bool gen_gvec_fpst_ah_arg_zzz(DisasContext *s, gen_helper_gvec_3_ptr *fn,
@@ -404,7 +404,7 @@ static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
-                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 }
 
 /* Invoke a vector expander on two Zregs and an immediate.  */
@@ -3534,7 +3534,7 @@ static bool do_FMLA_zzxz(DisasContext *s, arg_rrxr_esz *a, bool sub)
     };
     return gen_gvec_fpst_zzzz(s, fns[a->esz], a->rd, a->rn, a->rm, a->ra,
                               (s->fpcr_ah << 5) | (a->index << 1) | sub,
-                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+                              a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 }
 
 TRANS_FEAT(FMLA_zzxz, aa64_sve, do_FMLA_zzxz, a, false)
@@ -3550,7 +3550,7 @@ static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
            fmul_idx_fns[a->esz], a->rd, a->rn, a->rm, a->index,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 /*
  *** SVE Floating Point Fast Reduction Group
@@ -3583,7 +3583,7 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
 
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, a->rn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 
     fn(temp, t_zn, t_pg, status, t_desc);
 
@@ -3659,7 +3659,7 @@ static bool do_ppz_fp(DisasContext *s, arg_rpr_esz *a,
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status =
-            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+            fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 
         tcg_gen_gvec_3_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
@@ -3696,7 +3696,7 @@ static gen_helper_gvec_3_ptr * const ftmad_fns[4] = {
 TRANS_FEAT_NONSTREAMING(FTMAD, aa64_sve, gen_gvec_fpst_zzz,
                         ftmad_fns[a->esz], a->rd, a->rn, a->rm,
                         a->imm | (s->fpcr_ah << 3),
-                        a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+                        a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 /*
  *** SVE Floating Point Accumulating Reduction Group
@@ -3729,7 +3729,7 @@ static bool trans_FADDA(DisasContext *s, arg_rprr_esz *a)
     t_pg = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_rm, tcg_env, vec_full_reg_offset(s, a->rm));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, a->pg));
-    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    t_fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
     t_desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
 
     fns[a->esz - 1](t_val, t_val, t_rm, t_pg, t_fpst, t_desc);
@@ -3829,7 +3829,7 @@ static void do_fp_scalar(DisasContext *s, int zd, int zn, int pg, bool is_fp16,
     tcg_gen_addi_ptr(t_zn, tcg_env, vec_full_reg_offset(s, zn));
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
 
-    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    status = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16_A64 : FPST_A64);
     desc = tcg_constant_i32(simd_desc(vsz, vsz, 0));
     fn(t_zd, t_zn, t_pg, scalar, status, desc);
 }
@@ -3902,7 +3902,7 @@ static bool do_fp_cmp(DisasContext *s, arg_rprr_esz *a,
     }
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
-        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+        TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
         tcg_gen_gvec_4_ptr(pred_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
@@ -3935,7 +3935,7 @@ static gen_helper_gvec_4_ptr * const fcadd_fns[] = {
 };
 TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
            a->rd, a->rn, a->rm, a->pg, a->rot | (s->fpcr_ah << 1),
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 #define DO_FMLA(NAME, name, ah_name)                                    \
     static gen_helper_gvec_5_ptr * const name##_fns[4] = {              \
@@ -3949,7 +3949,7 @@ TRANS_FEAT(FCADD, aa64_sve, gen_gvec_fpst_zzzp, fcadd_fns[a->esz],
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_fpst_zzzzp,                     \
                s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz], \
                a->rd, a->rn, a->rm, a->ra, a->pg, 0,                    \
-               a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+               a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 /* We don't need an ah_fmla_zpzzz because fmla doesn't negate anything */
 DO_FMLA(FMLA_zpzzz, fmla_zpzzz, fmla_zpzzz)
@@ -3965,36 +3965,36 @@ static gen_helper_gvec_5_ptr * const fcmla_fns[4] = {
 };
 TRANS_FEAT(FCMLA_zpzzz, aa64_sve, gen_gvec_fpst_zzzzp, fcmla_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->pg, a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 static gen_helper_gvec_4_ptr * const fcmla_idx_fns[4] = {
     NULL, gen_helper_gvec_fcmlah_idx, gen_helper_gvec_fcmlas_idx, NULL
 };
 TRANS_FEAT(FCMLA_zzxz, aa64_sve, gen_gvec_fpst_zzzz, fcmla_idx_fns[a->esz],
            a->rd, a->rn, a->rm, a->ra, a->index * 4 + a->rot,
-           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 /*
  *** SVE Floating Point Unary Operations Predicated Group
  */
 
 TRANS_FEAT(FCVT_sh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_sh, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hs, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
-           s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64)
+           s->fpcr_ah ? FPST_FPCR_AH : FPST_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_dh, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_hd, a, 0, FPST_FPCR_F16_A64)
 TRANS_FEAT(FCVT_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVT_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvt_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzs_hh, a, 0, FPST_FPCR_F16_A64)
@@ -4010,22 +4010,22 @@ TRANS_FEAT(FCVTZU_hd, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_hd, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(FCVTZS_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_ss, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzs_ss, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_ss, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzu_ss, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZS_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzs_sd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzu_sd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZS_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzs_ds, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzu_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTZS_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzs_dd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzs_dd, a, 0, FPST_A64)
 TRANS_FEAT(FCVTZU_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_fcvtzu_dd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
     NULL,
@@ -4034,7 +4034,7 @@ static gen_helper_gvec_3_ptr * const frint_fns[] = {
     gen_helper_sve_frint_d
 };
 TRANS_FEAT(FRINTI, aa64_sve, gen_gvec_fpst_arg_zpz, frint_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     NULL,
@@ -4043,7 +4043,7 @@ static gen_helper_gvec_3_ptr * const frintx_fns[] = {
     gen_helper_sve_frintx_d
 };
 TRANS_FEAT(FRINTX, aa64_sve, gen_gvec_fpst_arg_zpz, frintx_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
 
 static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
                           ARMFPRounding mode, gen_helper_gvec_3_ptr *fn)
@@ -4060,7 +4060,7 @@ static bool do_frint_mode(DisasContext *s, arg_rpr_esz *a,
     }
 
     vsz = vec_full_reg_size(s);
-    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64);
+    status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64);
     tmode = gen_set_rmode(mode, status);
 
     tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
@@ -4095,7 +4095,7 @@ static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     gen_helper_sve_fsqrt_s, gen_helper_sve_fsqrt_d,
 };
 TRANS_FEAT(FSQRT, aa64_sve, gen_gvec_fpst_arg_zpz, fsqrt_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 TRANS_FEAT(SCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_FPCR_F16_A64)
@@ -4105,14 +4105,14 @@ TRANS_FEAT(SCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_dh, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(SCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_ss, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_scvt_ss, a, 0, FPST_A64)
 TRANS_FEAT(SCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_scvt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(SCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_scvt_sd, a, 0, FPST_A64)
 TRANS_FEAT(SCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_scvt_dd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_scvt_dd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_hh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_hh, a, 0, FPST_FPCR_F16_A64)
@@ -4122,14 +4122,14 @@ TRANS_FEAT(UCVTF_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_ucvt_dh, a, 0, FPST_FPCR_F16_A64)
 
 TRANS_FEAT(UCVTF_ss, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_ss, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_ucvt_ss, a, 0, FPST_A64)
 TRANS_FEAT(UCVTF_ds, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_ucvt_ds, a, 0, FPST_A64)
 TRANS_FEAT(UCVTF_sd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_ucvt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve_ucvt_dd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve_ucvt_dd, a, 0, FPST_A64)
 
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
@@ -7011,10 +7011,10 @@ DO_ZPZZ_FP(FMINP, aa64_sve2, sve2_fminp_zpzz)
 
 TRANS_FEAT_NONSTREAMING(FMMLA_s, aa64_sve_f32mm, gen_gvec_fpst_zzzz,
                         gen_helper_fmmla_s, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_FPCR_A64)
+                        0, FPST_A64)
 TRANS_FEAT_NONSTREAMING(FMMLA_d, aa64_sve_f64mm, gen_gvec_fpst_zzzz,
                         gen_helper_fmmla_d, a->rd, a->rn, a->rm, a->ra,
-                        0, FPST_FPCR_A64)
+                        0, FPST_A64)
 
 static gen_helper_gvec_4 * const sqdmlal_zzzw_fns[] = {
     NULL,                           gen_helper_sve2_sqdmlal_zzzw_h,
@@ -7130,18 +7130,18 @@ TRANS_FEAT_NONSTREAMING(RAX1, aa64_sve2_sha3, gen_gvec_fn_arg_zzz,
                         gen_gvec_rax1, a)
 
 TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtnt_sh, a, 0, FPST_FPCR_A64)
+           gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
 TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtnt_ds, a, 0, FPST_FPCR_A64)
+           gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
-           s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64)
+           s->fpcr_ah ? FPST_FPCR_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_FPCR_A64)
+           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
 TRANS_FEAT(FCVTLT_sd, aa64_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_sd, a, 0, FPST_FPCR_A64)
+           gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds, aa64_sve2, do_frint_mode, a,
            FPROUNDING_ODD, gen_helper_sve_fcvt_ds)
@@ -7153,7 +7153,7 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     gen_helper_flogb_s, gen_helper_flogb_d
 };
 TRANS_FEAT(FLOGB, aa64_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_FPCR_A64)
+           a, 0, a->esz == MO_16 ? FPST_FPCR_F16_A64 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
@@ -7198,7 +7198,7 @@ static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
                               a->rd, a->rn, a->rm, a->ra, sel,
-                              s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64);
+                              s->fpcr_ah ? FPST_FPCR_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7209,7 +7209,7 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
                               (a->index << 1) | sel,
-                              s->fpcr_ah ? FPST_FPCR_AH : FPST_FPCR_A64);
+                              s->fpcr_ah ? FPST_FPCR_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.43.0


