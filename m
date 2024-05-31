Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A60C27C50
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zz-0004Wc-2j; Fri, 31 May 2024 08:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zi-0004Oe-6w
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zc-0003SA-Px
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42125bfa28fso25129945e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157059; x=1717761859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wkv1qh81ByRbs61P0vUEiimiOQzAd8Y0EsU7zHLtts0=;
 b=ND4matMEjcnJyaNJlQKqZeP1d458KoEuqJ/XyEoGFSDrzsvcYVUaztVyVO4XC4v3Hh
 M80doBnAqiQx2M7DPS9TenKCSXjzsc9ZWp5lqepzidpQi2t3v5XWj8eVIfA5fpab3DXz
 D+auHKTgwJ4QXSvD6FNr6lnNdcYc6cDLuTkDrmmRoh7JPZiW5h5ois5D2WDhTJPmbPnh
 PhJ0Bh3IG14+Nq9guiLPJiKAEyGbWu/6O51cEQpeMvUjR+r0WFCm4mv3C8G5wI7QXjvr
 CmPE3hhW9E3W7NpWntS6OqMeLAlPcMGMEIkbnAiR7q+xUKLh//M/MJBzf5m36MeOFhr5
 MOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157059; x=1717761859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkv1qh81ByRbs61P0vUEiimiOQzAd8Y0EsU7zHLtts0=;
 b=aJxTk7+y/AWFh1JxVsHFRDtTA0nMifBOi4qlQYLafjQI/7LQpdghbixDvolhgIOu12
 ihnZjTAvdTAKHTQ2VlcqCiRXAhClcvyFe9FMMsWrq5Pfsbz6yLK5yJVKmF0ZYeGJqMMx
 8DQbsVwmuDTMC60MEaFl4NbFKOGzQvNbrrSKhyOrs9afQgjeOguNAfNPUC8okgxxbdRO
 LB7XeJjkQPuDgI2uZVKrBgH12ynmOfe23bswt7oPwsOWdHL5JvNwTy+9qqg2auDGcVpX
 ryN+tSWc6/DUdvOjryu8PfBX4fRgrKNn9neUoqDwtkFYIvyA238ZOCBO5bDlubz8fISw
 7tjg==
X-Gm-Message-State: AOJu0Yw1Oj7tuIJNEjg9Vc7BY41j6f4/8IdNTOl1J4pJBQZ/cdbkrkl8
 9Mh3R1rqvYQgPqVFEVR0Jb5r17fkAmc/GqsvRRrS9C0POcj9U/smPtVKBZeTLfZ4C2OD7EUOGdt
 H
X-Google-Smtp-Source: AGHT+IHGcXjfoSLhHvI+3xdqgrnCoKoZENLLXsA7ZqZwvmE0UyZZpCCX81yUAkXsi0kn9C6+osRCzA==
X-Received: by 2002:a05:600c:3c9f:b0:41c:2313:da8d with SMTP id
 5b1f17b1804b1-4212e004b7amr18507935e9.0.1717157059357; 
 Fri, 31 May 2024 05:04:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] target/arm: Convert CMGT, CMHI, CMGE, CMHS, CMTST,
 CMEQ to decodetree
Date: Fri, 31 May 2024 13:03:40 +0100
Message-Id: <20240531120401.394550-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20240528203044.612851-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  12 +++
 target/arm/tcg/translate-a64.c | 132 ++++++++++++---------------------
 2 files changed, 60 insertions(+), 84 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 44383b4fc7c..3061e262424 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -767,6 +767,12 @@ UQRSHL_s        0111 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 
 ADD_s           0101 1110 111 ..... 10000 1 ..... ..... @rrr_d
 SUB_s           0111 1110 111 ..... 10000 1 ..... ..... @rrr_d
+CMGT_s          0101 1110 111 ..... 00110 1 ..... ..... @rrr_d
+CMHI_s          0111 1110 111 ..... 00110 1 ..... ..... @rrr_d
+CMGE_s          0101 1110 111 ..... 00111 1 ..... ..... @rrr_d
+CMHS_s          0111 1110 111 ..... 00111 1 ..... ..... @rrr_d
+CMTST_s         0101 1110 111 ..... 10001 1 ..... ..... @rrr_d
+CMEQ_s          0111 1110 111 ..... 10001 1 ..... ..... @rrr_d
 
 ### Advanced SIMD scalar pairwise
 
@@ -900,6 +906,12 @@ UQRSHL_v        0.10 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 
 ADD_v           0.00 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
 SUB_v           0.10 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+CMGT_v          0.00 1110 ..1 ..... 00110 1 ..... ..... @qrrr_e
+CMHI_v          0.10 1110 ..1 ..... 00110 1 ..... ..... @qrrr_e
+CMGE_v          0.00 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
+CMHS_v          0.10 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
+CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
+CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 77a64923e7f..3c6cfc29525 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5180,6 +5180,24 @@ static const ENVScalar2 f_scalar_uqrshl = {
 };
 TRANS(UQRSHL_s, do_env_scalar2, a, &f_scalar_uqrshl)
 
+static bool do_cmop_d(DisasContext *s, arg_rrr_e *a, TCGCond cond)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = read_fp_dreg(s, a->rn);
+        TCGv_i64 t1 = read_fp_dreg(s, a->rm);
+        tcg_gen_negsetcond_i64(cond, t0, t0, t1);
+        write_fp_dreg(s, a->rd, t0);
+    }
+    return true;
+}
+
+TRANS(CMGT_s, do_cmop_d, a, TCG_COND_GT)
+TRANS(CMHI_s, do_cmop_d, a, TCG_COND_GTU)
+TRANS(CMGE_s, do_cmop_d, a, TCG_COND_GE)
+TRANS(CMHS_s, do_cmop_d, a, TCG_COND_GEU)
+TRANS(CMEQ_s, do_cmop_d, a, TCG_COND_EQ)
+TRANS(CMTST_s, do_cmop_d, a, TCG_COND_TSTNE)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5437,6 +5455,28 @@ TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 
+static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
+{
+    if (a->esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        tcg_gen_gvec_cmp(cond, a->esz,
+                         vec_full_reg_offset(s, a->rd),
+                         vec_full_reg_offset(s, a->rn),
+                         vec_full_reg_offset(s, a->rm),
+                         a->q ? 16 : 8, vec_full_reg_size(s));
+    }
+    return true;
+}
+
+TRANS(CMGT_v, do_cmop_v, a, TCG_COND_GT)
+TRANS(CMHI_v, do_cmop_v, a, TCG_COND_GTU)
+TRANS(CMGE_v, do_cmop_v, a, TCG_COND_GE)
+TRANS(CMHS_v, do_cmop_v, a, TCG_COND_GEU)
+TRANS(CMEQ_v, do_cmop_v, a, TCG_COND_EQ)
+TRANS(CMTST_v, do_gvec_fn3, a, gen_gvec_cmtst)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9421,45 +9461,6 @@ static void disas_simd_scalar_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-static void handle_3same_64(DisasContext *s, int opcode, bool u,
-                            TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 tcg_rm)
-{
-    /* Handle 64x64->64 opcodes which are shared between the scalar
-     * and vector 3-same groups. We cover every opcode where size == 3
-     * is valid in either the three-reg-same (integer, not pairwise)
-     * or scalar-three-reg-same groups.
-     */
-    TCGCond cond;
-
-    switch (opcode) {
-    case 0x6: /* CMGT, CMHI */
-        cond = u ? TCG_COND_GTU : TCG_COND_GT;
-    do_cmop:
-        /* 64 bit integer comparison, result = test ? -1 : 0. */
-        tcg_gen_negsetcond_i64(cond, tcg_rd, tcg_rn, tcg_rm);
-        break;
-    case 0x7: /* CMGE, CMHS */
-        cond = u ? TCG_COND_GEU : TCG_COND_GE;
-        goto do_cmop;
-    case 0x11: /* CMTST, CMEQ */
-        if (u) {
-            cond = TCG_COND_EQ;
-            goto do_cmop;
-        }
-        gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
-        break;
-    default:
-    case 0x1: /* SQADD / UQADD */
-    case 0x5: /* SQSUB / UQSUB */
-    case 0x8: /* SSHL, USHL */
-    case 0x9: /* SQSHL, UQSHL */
-    case 0xa: /* SRSHL, URSHL */
-    case 0xb: /* SQRSHL, UQRSHL */
-    case 0x10: /* ADD, SUB */
-        g_assert_not_reached();
-    }
-}
-
 /* AdvSIMD scalar three same
  *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+---+------+------+
@@ -9477,14 +9478,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     TCGv_i64 tcg_rd;
 
     switch (opcode) {
-    case 0x6: /* CMGT, CMHI */
-    case 0x7: /* CMGE, CMHS */
-    case 0x11: /* CMTST, CMEQ */
-        if (size != 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x16: /* SQDMULH, SQRDMULH (vector) */
         if (size != 1 && size != 2) {
             unallocated_encoding(s);
@@ -9494,11 +9487,14 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     default:
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
+    case 0x6: /* CMGT, CMHI */
+    case 0x7: /* CMGE, CMHS */
     case 0x8: /* SSHL, USHL */
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
     case 0x10: /* ADD, SUB (vector) */
+    case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
         return;
     }
@@ -9510,10 +9506,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     tcg_rd = tcg_temp_new_i64();
 
     if (size == 3) {
-        TCGv_i64 tcg_rn = read_fp_dreg(s, rn);
-        TCGv_i64 tcg_rm = read_fp_dreg(s, rm);
-
-        handle_3same_64(s, opcode, u, tcg_rd, tcg_rn, tcg_rm);
+        g_assert_not_reached();
     } else {
         /* Do a single operation on the lowest element in the vector.
          * We use the standard Neon helpers and rely on 0 OP 0 == 0 with
@@ -10919,7 +10912,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
     int pass;
-    TCGCond cond;
 
     switch (opcode) {
     case 0x13: /* MUL, PMUL */
@@ -10956,11 +10948,14 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
+    case 0x06: /* CMGT, CMHI */
+    case 0x07: /* CMGE, CMHS */
     case 0x08: /* SSHL, USHL */
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
     case 0x0b: /* SQRSHL, UQRSHL */
     case 0x10: /* ADD, SUB */
+    case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
         return;
     }
@@ -11021,41 +11016,10 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_op3_qc(s, is_q, rd, rn, rm, fns[size - 1][u]);
         }
         return;
-    case 0x11:
-        if (!u) { /* CMTST */
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_cmtst, size);
-            return;
-        }
-        /* else CMEQ */
-        cond = TCG_COND_EQ;
-        goto do_gvec_cmp;
-    case 0x06: /* CMGT, CMHI */
-        cond = u ? TCG_COND_GTU : TCG_COND_GT;
-        goto do_gvec_cmp;
-    case 0x07: /* CMGE, CMHS */
-        cond = u ? TCG_COND_GEU : TCG_COND_GE;
-    do_gvec_cmp:
-        tcg_gen_gvec_cmp(cond, size, vec_full_reg_offset(s, rd),
-                         vec_full_reg_offset(s, rn),
-                         vec_full_reg_offset(s, rm),
-                         is_q ? 16 : 8, vec_full_reg_size(s));
-        return;
     }
 
     if (size == 3) {
-        assert(is_q);
-        for (pass = 0; pass < 2; pass++) {
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-            handle_3same_64(s, opcode, u, tcg_res, tcg_op1, tcg_op2);
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
+        g_assert_not_reached();
     } else {
         for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
             TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-- 
2.34.1


