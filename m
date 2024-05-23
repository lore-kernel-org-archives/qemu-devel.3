Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3883C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATm-0008Dr-20; Thu, 23 May 2024 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATe-00081E-Lq
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0002V6-Mj
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34e7a35d5d4so1936699f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478520; x=1717083320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ezAvbGcjE6NP0MuMEgqI0ZmfHQe/vfI3+3BnUyySdI=;
 b=baj9hAgEOfGP1GasoTDrBmBc6Xsuyl3/OikOTgjJYRtQYHgEbr3S/b838ZtIcgVvJC
 9hbAmVNom/sMHKz4SbnYbzSeD4QHMFe2MnNo0WORYxH777Ya7HTWydiW5RB/nkVa4ujv
 qscw4VaFTFN8/jTnq0Vl1HyeExiDGjmxrGItIeuphHaDxDjJ6dSxkbt1ATnot5ratWe6
 5o1Ac2727D6Hs78Z37gZltoRZKnHrL9Wn4D7nkrLNUiFrd1fmA0SzEFFOgMkDJbthc3l
 jsCH1qkYjKiNPDDUj1vjwQPrFt2yMD/Fv/yIfW7m643vWlMt/KOzYe6h0Px2HwHzRH8I
 fcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478520; x=1717083320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ezAvbGcjE6NP0MuMEgqI0ZmfHQe/vfI3+3BnUyySdI=;
 b=A9PTIJ4LC3hcfTYKw44RHeLK+tvhxxLgNmeBRJxrF1Fpxl6746oBwWDMm92NbeYrHu
 GYdBuNcCsNOx6rteP6toc6rvES8lzOzmmRsNhyLDXVWF9/YDkPTaZLCzQI1Fl9KMeJgj
 gwqRe4lU1QWtMSHxiRqmFVuMC+FjHalr8f4Pa9JQN+gm/7VAnNqSW3T+arJXFxdeFXll
 KFV+VD5oSUREvbDDGTQ4s+X/7Q5+WTsbIcEX6r8YjReAzfQlsG8MNRLBOFN6Lc7HNnzh
 IdvckHB0NNbj7JOi+ys72dXTl2CvK4kGx3HRehC/G5BjSHEpWtEAgtnEUjlzypW79OrC
 5MIw==
X-Gm-Message-State: AOJu0Yyjcx9vgSOuD607mv3ZKMaZVQ2SoHjkkygWVNtZgGGNiWAU98Pt
 iw5pc05rkFcJiOkeZpd9gDX0t6LKmJY3JWukXDj2npAY2pWxdaIOctiHJLDdyNfpL3bVOfAW0LF
 1
X-Google-Smtp-Source: AGHT+IGgP6Kv4OdONFkLh2qAF7L32Z777Il5WyhK2De/guFbpUj2fvCBAm6z3V79hHKRu/bqDxvyqQ==
X-Received: by 2002:a5d:5704:0:b0:34c:6629:9962 with SMTP id
 ffacd0b85a97d-354d8cde3d6mr4006204f8f.30.1716478519837; 
 Thu, 23 May 2024 08:35:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] target/arm: Convert FMLA, FMLS to decodetree
Date: Thu, 23 May 2024 16:34:53 +0100
Message-Id: <20240523153505.2900433-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-18-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |   2 +
 target/arm/tcg/a64.decode      |  22 +++
 target/arm/tcg/translate-a64.c | 241 +++++++++++++++++----------------
 target/arm/tcg/vec_helper.c    |  14 ++
 4 files changed, 163 insertions(+), 116 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0fd01c9c52d..e021c185178 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -770,9 +770,11 @@ DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index cde4b86303d..11527bb5e5e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -742,12 +742,26 @@ FMINNM_v        0.00 1110 1.1 ..... 11000 1 ..... ..... @qrrr_sd
 FMULX_v         0.00 1110 010 ..... 00011 1 ..... ..... @qrrr_h
 FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
 
+FMLA_v          0.00 1110 010 ..... 00001 1 ..... ..... @qrrr_h
+FMLA_v          0.00 1110 0.1 ..... 11001 1 ..... ..... @qrrr_sd
+
+FMLS_v          0.00 1110 110 ..... 00001 1 ..... ..... @qrrr_h
+FMLS_v          0.00 1110 1.1 ..... 11001 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMUL_si         0101 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMUL_si         0101 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
 
+FMLA_si         0101 1111 00 .. .... 0001 . 0 ..... .....   @rrx_h
+FMLA_si         0101 1111 10 .. .... 0001 . 0 ..... .....   @rrx_s
+FMLA_si         0101 1111 11 0. .... 0001 . 0 ..... .....   @rrx_d
+
+FMLS_si         0101 1111 00 .. .... 0101 . 0 ..... .....   @rrx_h
+FMLS_si         0101 1111 10 .. .... 0101 . 0 ..... .....   @rrx_s
+FMLS_si         0101 1111 11 0. .... 0101 . 0 ..... .....   @rrx_d
+
 FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
 FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
 FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
@@ -758,6 +772,14 @@ FMUL_vi         0.00 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMUL_vi         0.00 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMUL_vi         0.00 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
 
+FMLA_vi         0.00 1111 00 .. .... 0001 . 0 ..... .....   @qrrx_h
+FMLA_vi         0.00 1111 10 . ..... 0001 . 0 ..... .....   @qrrx_s
+FMLA_vi         0.00 1111 11 0 ..... 0001 . 0 ..... .....   @qrrx_d
+
+FMLS_vi         0.00 1111 00 .. .... 0101 . 0 ..... .....   @qrrx_h
+FMLS_vi         0.00 1111 10 . ..... 0101 . 0 ..... .....   @qrrx_s
+FMLS_vi         0.00 1111 11 0 ..... 0101 . 0 ..... .....   @qrrx_d
+
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f5370c1f10b..c8a20f0231d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5066,6 +5066,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
 };
 TRANS(FMULX_v, do_fp3_vector, a, f_vector_fmulx)
 
+static gen_helper_gvec_3_ptr * const f_vector_fmla[3] = {
+    gen_helper_gvec_vfma_h,
+    gen_helper_gvec_vfma_s,
+    gen_helper_gvec_vfma_d,
+};
+TRANS(FMLA_v, do_fp3_vector, a, f_vector_fmla)
+
+static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
+    gen_helper_gvec_vfms_h,
+    gen_helper_gvec_vfms_s,
+    gen_helper_gvec_vfms_d,
+};
+TRANS(FMLS_v, do_fp3_vector, a, f_vector_fmls)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5115,6 +5129,64 @@ static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
 TRANS(FMUL_si, do_fp3_scalar_idx, a, &f_scalar_fmul)
 TRANS(FMULX_si, do_fp3_scalar_idx, a, &f_scalar_fmulx)
 
+static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = read_fp_dreg(s, a->rd);
+            TCGv_i64 t1 = read_fp_dreg(s, a->rn);
+            TCGv_i64 t2 = tcg_temp_new_i64();
+
+            read_vec_element(s, t2, a->rm, a->idx, MO_64);
+            if (neg) {
+                gen_vfp_negd(t1, t1);
+            }
+            gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_sreg(s, a->rd);
+            TCGv_i32 t1 = read_fp_sreg(s, a->rn);
+            TCGv_i32 t2 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t2, a->rm, a->idx, MO_32);
+            if (neg) {
+                gen_vfp_negs(t1, t1);
+            }
+            gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_FPCR));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_hreg(s, a->rd);
+            TCGv_i32 t1 = read_fp_hreg(s, a->rn);
+            TCGv_i32 t2 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t2, a->rm, a->idx, MO_16);
+            if (neg) {
+                gen_vfp_negh(t1, t1);
+            }
+            gen_helper_advsimd_muladdh(t0, t1, t2, t0,
+                                       fpstatus_ptr(FPST_FPCR_F16));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+TRANS(FMLA_si, do_fmla_scalar_idx, a, false)
+TRANS(FMLS_si, do_fmla_scalar_idx, a, true)
+
 static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5157,6 +5229,42 @@ static gen_helper_gvec_3_ptr * const f_vector_idx_fmulx[3] = {
 };
 TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
 
+static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
+{
+    static gen_helper_gvec_4_ptr * const fns[3] = {
+        gen_helper_gvec_fmla_idx_h,
+        gen_helper_gvec_fmla_idx_s,
+        gen_helper_gvec_fmla_idx_d,
+    };
+    MemOp esz = a->esz;
+
+    switch (esz) {
+    case MO_64:
+        if (!a->q) {
+            return false;
+        }
+        break;
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                          esz == MO_16, (a->idx << 1) | neg,
+                          fns[esz - 1]);
+    }
+    return true;
+}
+
+TRANS(FMLA_vi, do_fmla_vector_idx, a, false)
+TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
+
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -9112,15 +9220,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element(s, tcg_op2, rm, pass, MO_64);
 
             switch (fpopcode) {
-            case 0x39: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negd(tcg_op1, tcg_op1);
-                /* fall through */
-            case 0x19: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
-                gen_helper_vfp_muladdd(tcg_res, tcg_op1, tcg_op2,
-                                       tcg_res, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9148,10 +9247,12 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             default:
             case 0x18: /* FMAXNM */
+            case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
+            case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
@@ -9170,15 +9271,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
 
             switch (fpopcode) {
-            case 0x39: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negs(tcg_op1, tcg_op1);
-                /* fall through */
-            case 0x19: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-                gen_helper_vfp_muladds(tcg_res, tcg_op1, tcg_op2,
-                                       tcg_res, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9206,10 +9298,12 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 break;
             default:
             case 0x18: /* FMAXNM */
+            case 0x19: /* FMLA */
             case 0x1a: /* FADD */
             case 0x1b: /* FMULX */
             case 0x1e: /* FMAX */
             case 0x38: /* FMINNM */
+            case 0x39: /* FMLS */
             case 0x3a: /* FSUB */
             case 0x3e: /* FMIN */
             case 0x5b: /* FMUL */
@@ -11133,8 +11227,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x3f: /* FRSQRTS */
     case 0x5d: /* FACGE */
     case 0x7d: /* FACGT */
-    case 0x19: /* FMLA */
-    case 0x39: /* FMLS */
     case 0x1c: /* FCMEQ */
     case 0x5c: /* FCMGE */
     case 0x7a: /* FABD */
@@ -11167,10 +11259,12 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
 
     default:
     case 0x18: /* FMAXNM */
+    case 0x19: /* FMLA */
     case 0x1a: /* FADD */
     case 0x1b: /* FMULX */
     case 0x1e: /* FMAX */
     case 0x38: /* FMINNM */
+    case 0x39: /* FMLS */
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
     case 0x5b: /* FMUL */
@@ -11516,10 +11610,8 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     int pass;
 
     switch (fpopcode) {
-    case 0x1: /* FMLA */
     case 0x4: /* FCMEQ */
     case 0x7: /* FRECPS */
-    case 0x9: /* FMLS */
     case 0xf: /* FRSQRTS */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11537,10 +11629,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         break;
     default:
     case 0x0: /* FMAXNM */
+    case 0x1: /* FMLA */
     case 0x2: /* FADD */
     case 0x3: /* FMULX */
     case 0x6: /* FMAX */
     case 0x8: /* FMINNM */
+    case 0x9: /* FMLS */
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
     case 0x13: /* FMUL */
@@ -11610,24 +11704,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
             switch (fpopcode) {
-            case 0x1: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                           fpst);
-                break;
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             case 0x7: /* FRECPS */
                 gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x9: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                tcg_gen_xori_i32(tcg_op1, tcg_op1, 0x8000);
-                read_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-                gen_helper_advsimd_muladdh(tcg_res, tcg_op1, tcg_op2, tcg_res,
-                                           fpst);
-                break;
             case 0xf: /* FRSQRTS */
                 gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11649,10 +11731,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 break;
             default:
             case 0x0: /* FMAXNM */
+            case 0x1: /* FMLA */
             case 0x2: /* FADD */
             case 0x3: /* FMULX */
             case 0x6: /* FMAX */
             case 0x8: /* FMINNM */
+            case 0x9: /* FMLS */
             case 0xa: /* FSUB */
             case 0xe: /* FMIN */
             case 0x13: /* FMUL */
@@ -12873,10 +12957,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
         break;
-    case 0x01: /* FMLA */
-    case 0x05: /* FMLS */
-        is_fp = 1;
-        break;
     case 0x1d: /* SQRDMLAH */
     case 0x1f: /* SQRDMLSH */
         if (!dc_isar_feature(aa64_rdm, s)) {
@@ -12943,6 +13023,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
+    case 0x01: /* FMLA */
+    case 0x05: /* FMLS */
     case 0x09: /* FMUL */
     case 0x19: /* FMULX */
         unallocated_encoding(s);
@@ -12951,20 +13033,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
 
     switch (is_fp) {
     case 1: /* normal fp */
-        /* convert insn encoded size to MemOp size */
-        switch (size) {
-        case 0: /* half-precision */
-            size = MO_16;
-            is_fp16 = true;
-            break;
-        case MO_32: /* single precision */
-        case MO_64: /* double precision */
-            break;
-        default:
-            unallocated_encoding(s);
-            return;
-        }
-        break;
+        unallocated_encoding(s); /* in decodetree */
+        return;
 
     case 2: /* complex fp */
         /* Each indexable element is a complex pair.  */
@@ -13143,38 +13213,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     if (size == 3) {
-        TCGv_i64 tcg_idx = tcg_temp_new_i64();
-        int pass;
-
-        assert(is_fp && is_q && !is_long);
-
-        read_vec_element(s, tcg_idx, rm, index, MO_64);
-
-        for (pass = 0; pass < (is_scalar ? 1 : 2); pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-
-            switch (16 * u + opcode) {
-            case 0x05: /* FMLS */
-                /* As usual for ARM, separate negation for fused multiply-add */
-                gen_vfp_negd(tcg_op, tcg_op);
-                /* fall through */
-            case 0x01: /* FMLA */
-                read_vec_element(s, tcg_res, rd, pass, MO_64);
-                gen_helper_vfp_muladdd(tcg_res, tcg_op, tcg_idx, tcg_res, fpst);
-                break;
-            default:
-            case 0x09: /* FMUL */
-            case 0x19: /* FMULX */
-                g_assert_not_reached();
-            }
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
-
-        clear_vec_high(s, !is_scalar, rd);
+        g_assert_not_reached();
     } else if (!is_long) {
         /* 32 bit floating point, or 16 or 32 bit integer.
          * For the 16 bit scalar case we use the usual Neon helpers and
@@ -13230,38 +13269,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op, tcg_res);
                 break;
             }
-            case 0x05: /* FMLS */
-            case 0x01: /* FMLA */
-                read_vec_element_i32(s, tcg_res, rd, pass,
-                                     is_scalar ? size : MO_32);
-                switch (size) {
-                case 1:
-                    if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for fused
-                         * multiply-add */
-                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80008000);
-                    }
-                    if (is_scalar) {
-                        gen_helper_advsimd_muladdh(tcg_res, tcg_op, tcg_idx,
-                                                   tcg_res, fpst);
-                    } else {
-                        gen_helper_advsimd_muladd2h(tcg_res, tcg_op, tcg_idx,
-                                                    tcg_res, fpst);
-                    }
-                    break;
-                case 2:
-                    if (opcode == 0x5) {
-                        /* As usual for ARM, separate negation for
-                         * fused multiply-add */
-                        tcg_gen_xori_i32(tcg_op, tcg_op, 0x80000000);
-                    }
-                    gen_helper_vfp_muladds(tcg_res, tcg_op, tcg_idx,
-                                           tcg_res, fpst);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
@@ -13303,6 +13310,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 }
                 break;
             default:
+            case 0x01: /* FMLA */
+            case 0x05: /* FMLS */
             case 0x09: /* FMUL */
             case 0x19: /* FMULX */
                 g_assert_not_reached();
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 99ef6760719..b925b9f21be 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1309,6 +1309,12 @@ static float32 float32_muladd_f(float32 dest, float32 op1, float32 op2,
     return float32_muladd(op1, op2, dest, 0, stat);
 }
 
+static float64 float64_muladd_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(op1, op2, dest, 0, stat);
+}
+
 static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
                                  float_status *stat)
 {
@@ -1321,6 +1327,12 @@ static float32 float32_mulsub_f(float32 dest, float32 op1, float32 op2,
     return float32_muladd(float32_chs(op1), op2, dest, 0, stat);
 }
 
+static float64 float64_mulsub_f(float64 dest, float64 op1, float64 op2,
+                                 float_status *stat)
+{
+    return float64_muladd(float64_chs(op1), op2, dest, 0, stat);
+}
+
 #define DO_MULADD(NAME, FUNC, TYPE)                                     \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
@@ -1340,9 +1352,11 @@ DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
 
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
+DO_MULADD(gvec_vfma_d, float64_muladd_f, float64)
 
 DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
+DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
 
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
-- 
2.34.1


