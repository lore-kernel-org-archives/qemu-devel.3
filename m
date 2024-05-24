Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F275FC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIX-0000rm-OJ; Fri, 24 May 2024 19:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHe-0007G0-OR
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:19 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHU-0006fh-WD
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8e9878514so1236316b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593100; x=1717197900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMbUPJ6N6KonzyEnUgiB4FTCa95bEc5bnf6ZFlswq0s=;
 b=LCdx84KyL6SmzYqzVuo6ync8mYX/+Qp4MrwZW2kR1Pz5/fgxOyZrB4xeahSRVWaJdd
 sflG45CHz2eJvR3VnqzdSRnDgbnxn4LDdF7uBXdz4FCEhDcNR2ZzK7GCvLLGUMgA3503
 /RrorrBxL4EN5Nu5g90rVj6VEW76hv3kd8izaqC2DLufAGnsUBO3sI0bgKkdJkxd8Coi
 Hyxrtb6adqo+eUd22IPJiGTExtmmyYdteP/31mBilwBR5H7ZURIqoioJyKrsgiG6yW+h
 gayc8O/wTfGIq/+9/9wi9xF381zS+6ti1DdKwrJxv5qnRFI0DzoLTweZ+Mr+TGKRRe44
 byQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593100; x=1717197900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMbUPJ6N6KonzyEnUgiB4FTCa95bEc5bnf6ZFlswq0s=;
 b=k1IjZFkEu67gMuQE5clF55CLYPDG9Cyu0eBHt9Zz7aiuiP8JoqqagB+M0yDCUqZqfI
 vpfyXhD2vaGfDCUw5OGcR4+OFobJMtA4cG8mOlP+ogaS6SUdl0SIbDWWS86ssqEExQ1O
 LTgimdluzCqmB1KPYg5PMKvPEWJ2EKJbUtPGWS05E7b8vYMmMzQ9o0qAijjMYtgm9Lt0
 RbLUsomF9hp/ZrVvNIWOgclNe/ZKnBrYzKX2Tf9tt1FHyUA+qdgyLFs/szf2mF3fIMRJ
 GbsY4YbPZhbNW/X6H0DECtDEiiJfSV1xSzFPE7a8UAL2oZIlOyNXNP6nU7fEVosoh2Yq
 z4UA==
X-Gm-Message-State: AOJu0YyOmtrD+adOJEN3VsLaEbwTREojcEwOAOaPSNAwO5CupKn6rAfh
 6mY78DMVhu/PtMyxqF5qE917I3XfdDxjPaIDJR+QFtsvONh2+k/dyIQrYOOyhoj/kGSiRKyxley
 z
X-Google-Smtp-Source: AGHT+IG+jAK8+PEkVWtZ161ZHAiiFQMDhewmtPVC4rN7YcZQ2kegiSlp8xDZd3IwDpRaFGISxiCZZg==
X-Received: by 2002:a05:6a20:3242:b0:1b1:f321:47ff with SMTP id
 adf61e73a8af0-1b212d0a7d4mr3518315637.17.1716593099148; 
 Fri, 24 May 2024 16:24:59 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:24:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 41/67] target/arm: Convert SQADD, SQSUB, UQADD,
 UQSUB to decodetree
Date: Fri, 24 May 2024 16:20:55 -0700
Message-Id: <20240524232121.284515-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/a64.decode      |  11 ++++
 target/arm/tcg/translate-a64.c | 100 +++++++++++++++++++--------------
 2 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f48adef5bb..19010af03b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -44,6 +44,7 @@
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
+@rrr_e          ........ esz:2 . rm:5 ...... rn:5 rd:5  &rrr_e
 
 @rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
 @rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
@@ -744,6 +745,11 @@ FRECPS_s        0101 1110 0.1 ..... 11111 1 ..... ..... @rrr_sd
 FRSQRTS_s       0101 1110 110 ..... 00111 1 ..... ..... @rrr_h
 FRSQRTS_s       0101 1110 1.1 ..... 11111 1 ..... ..... @rrr_sd
 
+SQADD_s         0101 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
+UQADD_s         0111 1110 ..1 ..... 00001 1 ..... ..... @rrr_e
+SQSUB_s         0101 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
+UQSUB_s         0111 1110 ..1 ..... 00101 1 ..... ..... @rrr_e
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -857,6 +863,11 @@ BSL_v           0.10 1110 011 ..... 00011 1 ..... ..... @qrrr_b
 BIT_v           0.10 1110 101 ..... 00011 1 ..... ..... @qrrr_b
 BIF_v           0.10 1110 111 ..... 00011 1 ..... ..... @qrrr_b
 
+SQADD_v         0.00 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
+UQADD_v         0.10 1110 ..1 ..... 00001 1 ..... ..... @qrrr_e
+SQSUB_v         0.00 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
+UQSUB_v         0.10 1110 ..1 ..... 00101 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca7ba6b1e8..2f7298811d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5060,6 +5060,43 @@ static const FPScalar f_scalar_frsqrts = {
 };
 TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
 
+static bool do_satacc_s(DisasContext *s, arg_rrr_e *a,
+                MemOp sgn_n, MemOp sgn_m,
+                void (*gen_bhs)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp),
+                void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 t0, t1, t2, qc;
+    MemOp esz = a->esz;
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    t0 = tcg_temp_new_i64();
+    t1 = tcg_temp_new_i64();
+    t2 = tcg_temp_new_i64();
+    qc = tcg_temp_new_i64();
+    read_vec_element(s, t1, a->rn, 0, esz | sgn_n);
+    read_vec_element(s, t2, a->rm, 0, esz | sgn_m);
+    tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+
+    if (esz == MO_64) {
+        gen_d(t0, qc, t1, t2);
+    } else {
+        gen_bhs(t0, qc, t1, t2, esz);
+        tcg_gen_ext_i64(t0, t0, esz);
+    }
+
+    write_fp_dreg(s, a->rd, t0);
+    tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
+    return true;
+}
+
+TRANS(SQADD_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqadd_bhs, gen_sqadd_d)
+TRANS(SQSUB_s, do_satacc_s, a, MO_SIGN, MO_SIGN, gen_sqsub_bhs, gen_sqsub_d)
+TRANS(UQADD_s, do_satacc_s, a, 0, 0, gen_uqadd_bhs, gen_uqadd_d)
+TRANS(UQSUB_s, do_satacc_s, a, 0, 0, gen_uqsub_bhs, gen_uqsub_d)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5298,6 +5335,11 @@ TRANS(BSL_v, do_bitsel, a->q, a->rd, a->rd, a->rn, a->rm)
 TRANS(BIT_v, do_bitsel, a->q, a->rd, a->rm, a->rn, a->rd)
 TRANS(BIF_v, do_bitsel, a->q, a->rd, a->rm, a->rd, a->rn)
 
+TRANS(SQADD_v, do_gvec_fn3, a, gen_gvec_sqadd_qc)
+TRANS(UQADD_v, do_gvec_fn3, a, gen_gvec_uqadd_qc)
+TRANS(SQSUB_v, do_gvec_fn3, a, gen_gvec_sqsub_qc)
+TRANS(UQSUB_v, do_gvec_fn3, a, gen_gvec_uqsub_qc)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9291,29 +9333,8 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
      * or scalar-three-reg-same groups.
      */
     TCGCond cond;
-    TCGv_i64 qc;
 
     switch (opcode) {
-    case 0x1: /* SQADD */
-        qc = tcg_temp_new_i64();
-        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        if (u) {
-            gen_uqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        } else {
-            gen_sqadd_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        }
-        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        break;
-    case 0x5: /* SQSUB */
-        qc = tcg_temp_new_i64();
-        tcg_gen_ld_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        if (u) {
-            gen_uqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        } else {
-            gen_sqsub_d(tcg_rd, qc, tcg_rn, tcg_rm);
-        }
-        tcg_gen_st_i64(qc, tcg_env, offsetof(CPUARMState, vfp.qc));
-        break;
     case 0x6: /* CMGT, CMHI */
         cond = u ? TCG_COND_GTU : TCG_COND_GT;
     do_cmop:
@@ -9366,6 +9387,8 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         break;
     default:
+    case 0x1: /* SQADD / UQADD */
+    case 0x5: /* SQSUB / UQSUB */
         g_assert_not_reached();
     }
 }
@@ -9387,8 +9410,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
 
     switch (opcode) {
-    case 0x1: /* SQADD, UQADD */
-    case 0x5: /* SQSUB, UQSUB */
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
@@ -9410,6 +9431,8 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x1: /* SQADD, UQADD */
+    case 0x5: /* SQSUB, UQSUB */
         unallocated_encoding(s);
         return;
     }
@@ -9436,12 +9459,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         void (*genfn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64, MemOp) = NULL;
 
         switch (opcode) {
-        case 0x1: /* SQADD, UQADD */
-            genfn = u ? gen_uqadd_bhs : gen_sqadd_bhs;
-            break;
-        case 0x5: /* SQSUB, UQSUB */
-            genfn = u ? gen_uqsub_bhs : gen_sqsub_bhs;
-            break;
         case 0x9: /* SQSHL, UQSHL */
         {
             static NeonGenTwoOpEnvFn * const fns[3][2] = {
@@ -9473,6 +9490,8 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
             break;
         }
         default:
+        case 0x1: /* SQADD, UQADD */
+        case 0x5: /* SQSUB, UQSUB */
             g_assert_not_reached();
         }
 
@@ -10933,6 +10952,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+
+    case 0x01: /* SQADD, UQADD */
+    case 0x05: /* SQSUB, UQSUB */
+        unallocated_encoding(s);
+        return;
     }
 
     if (!fp_access_check(s)) {
@@ -10940,20 +10964,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x01: /* SQADD, UQADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqadd_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqadd_qc, size);
-        }
-        return;
-    case 0x05: /* SQSUB, UQSUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uqsub_qc, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sqsub_qc, size);
-        }
-        return;
     case 0x08: /* SSHL, USHL */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_ushl, size);
@@ -11038,6 +11048,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                          vec_full_reg_offset(s, rm),
                          is_q ? 16 : 8, vec_full_reg_size(s));
         return;
+
+    case 0x01: /* SQADD, UQADD */
+    case 0x05: /* SQSUB, UQSUB */
+        g_assert_not_reached();
     }
 
     if (size == 3) {
-- 
2.34.1


