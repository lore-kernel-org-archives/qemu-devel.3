Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F5C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zy-0004WS-Kk; Fri, 31 May 2024 08:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0004Kb-L7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zW-0003Px-KH
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4211245e889so18903265e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157053; x=1717761853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MDVtVXNUWV5xf/Hbc6P/GzccXQUN1TotV4yNg0bYHsI=;
 b=qhuWg1wfde6uZ8KTfvarxnBxmmkf6illYUd66TzPY5cKvZa/fGiOFWJ+m7l2aZMObM
 rbN3Hs5iOlIFhMIprbwxmpwoz1n3T2yXE9XfCsxuzyfAEBW+q3PQCxLhZ1DqcEDWhi1e
 FUD9tIW+ImeC70jqBwPk7NbevzARHseyVjbAOwjkzxb+VWZ+6/F3lrsFsEjmQjaanA27
 31iIsa/PaSxsHQ1HAXX7QH/uWlnS7OVjQkW3Nhbw6bMxHtBNx+TbydXl+EAwjg4B/+Ux
 nKax4gO6HWd/Ime9i2hKQNuxOp/hds0WdIKi40XB7SLcptdOtybvlzfQQJAgv3SEbSYZ
 vqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157053; x=1717761853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MDVtVXNUWV5xf/Hbc6P/GzccXQUN1TotV4yNg0bYHsI=;
 b=CtFfQdCpcsz7/Pvebdc9QjbjikR8K9uQ4c6GpXSqJsi8vTA8U2z0EGLpA2tbaMDA6f
 HYtFnECRU6N0TWmSFyzBE4M6ENe02zGSzUsVcURUcOWujnNPvHeLht/zIH8CJ3kKKPyh
 8VKtVV/oIazrhPH2RAYEyFmK8BYXiyJjRu2VLs16MBMJ6IIPcGsM20/zndvk+PiP0g57
 8uM7H9JJiQ6nwzqQtP4bBcxvGe8UMU1vyahzOuVCpNgFJ5j9MO4ojmwT5YrTU0xAnDpe
 N8BEeVdvgCCx1azYn4UGIS0wbhLlSSoRBgoZaGmsDFth87rJwwgb4Y5euZa3aD4EXU9l
 1A3w==
X-Gm-Message-State: AOJu0Yx3TcD8Ir/rWvylir6H9N62IYg4xc1jH0A7F2QUdYwFGgDJDl3k
 2CqG0lR4UI/GH5XOf0WpTM6JLYO6BFaAGcBpKDRGH8HOwFX8Rn9GJTNQIIT/JwgiueHri5kk7yW
 l
X-Google-Smtp-Source: AGHT+IE4mi8l6u0gacT+ysUM54PnRue7wdninVxt4zY3GARJ6IR9BkwcRBk2iRISgV4tCk2KB5Fm1w==
X-Received: by 2002:a05:600c:3595:b0:420:2ca9:1b90 with SMTP id
 5b1f17b1804b1-4212e044239mr13363555e9.5.1717157052740; 
 Fri, 31 May 2024 05:04:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/43] target/arm: Convert SQADD, SQSUB, UQADD,
 UQSUB to decodetree
Date: Fri, 31 May 2024 13:03:30 +0100
Message-Id: <20240531120401.394550-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240528203044.612851-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 11 ++++
 target/arm/tcg/translate-a64.c | 96 +++++++++++++++++++---------------
 2 files changed, 64 insertions(+), 43 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f48adef5bba..19010af03bb 100644
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
index ca7ba6b1e8c..3956c415431 100644
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
-- 
2.34.1


