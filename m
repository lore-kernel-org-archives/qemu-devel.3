Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BDDC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATm-0008HO-Mw; Thu, 23 May 2024 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATf-00081x-8F
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATW-0002VO-NM
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-354ba5663c9so1952429f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478521; x=1717083321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AaMTdD1hxgjIPfvS8QEhSXzuebS7gj16do3lFS3yD/E=;
 b=WzBjPQ5DSf/f3pZD57bhHrhrmO8kr74ZOkLkmz5HSH8RihpxIU8ncVU7zqp7R9OuD3
 HFroHlqy4YQNwcU7d1Jq/S/frDfNhC9lEByH//cjWd5fR/IlKjXKKF3rwrczFKR4ykfp
 pI+H6VyKbjBAjKcbacQQ4NdVeMQUjEd4tvc6jbPNb88jjsvoZgVWb+vCFhpaYZIzA9dX
 XytaWPLFzuhLJeQF50UNfTwnig3QNftI9n5Vo6MXIoyzFD1Aag2f3C9G8wS3+mWDlJo/
 gbxcL5EzHxKmUn8MStcWV+0jcllGWzSCndPTSXtL2iAg0udI32CqnC8sMtMR7xRqGjof
 N3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478521; x=1717083321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AaMTdD1hxgjIPfvS8QEhSXzuebS7gj16do3lFS3yD/E=;
 b=oEVV6u2TCsQPksCFj7JpHV/ZGGYne2vuERhaeLC8ZBqFIXAEvi3sxlSXIFxtjoBR5Q
 PMVVvd+K/nVuUWofRZhpy9heDZSsrBKqw+Wlr2ElZMzu6ofrWBos5lNuSa6ppb/tpiwy
 w7FV4s+xnNVZpd1Mvr6VQr/77ofkFeunQx0oA3Hv9LdQjWo88DosVEq7DcqkaVFMS861
 1J3Vu6mxu9VknE8181BYA/YoQTkk3q1xq1JX8equO6mwc8+oD257oGdFoU51COpSEvo8
 J7rM/jcvPQiCezO0eaVpKkJAAV11WBDwuwlt5sazne+6xjyAJ4xrfEVr4ocxJrDVJxM9
 nXkg==
X-Gm-Message-State: AOJu0Ywu/W+ta76nPiTPmDKtRJnReGmHMjMVbqBwydXwe5qkCeYZw22I
 GMSnxVA7PbzAoa+VBdc6an4H8QfoT1vK3Iw4x/KKmOP1I8KeC1iL2KL+e3nc7BWvnGEKnjATzFA
 o
X-Google-Smtp-Source: AGHT+IHUM2YcoBRrzf+hvx1LeEZMMeJ6yfyFxcNIEQC2QlewtNsUHr27/nj2MVgtCWbuaJO4Z+GBoQ==
X-Received: by 2002:adf:e4c3:0:b0:354:f9d9:c37c with SMTP id
 ffacd0b85a97d-354f9d9c5c1mr1543096f8f.0.1716478521234; 
 Thu, 23 May 2024 08:35:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/37] target/arm: Convert FRECPS, FRSQRTS to decodetree
Date: Thu, 23 May 2024 16:34:56 +0100
Message-Id: <20240523153505.2900433-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

These are the last instructions within handle_3same_float
and disas_simd_scalar_three_reg_same_fp16 so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-21-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  12 ++
 target/arm/tcg/translate-a64.c | 293 ++++-----------------------------
 2 files changed, 46 insertions(+), 259 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a852b5f06f0..84cb38f1dd0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -731,6 +731,12 @@ FACGT_s         0111 1110 1.1 ..... 11101 1 ..... ..... @rrr_sd
 FABD_s          0111 1110 110 ..... 00010 1 ..... ..... @rrr_h
 FABD_s          0111 1110 1.1 ..... 11010 1 ..... ..... @rrr_sd
 
+FRECPS_s        0101 1110 010 ..... 00111 1 ..... ..... @rrr_h
+FRECPS_s        0101 1110 0.1 ..... 11111 1 ..... ..... @rrr_sd
+
+FRSQRTS_s       0101 1110 110 ..... 00111 1 ..... ..... @rrr_h
+FRSQRTS_s       0101 1110 1.1 ..... 11111 1 ..... ..... @rrr_sd
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -784,6 +790,12 @@ FACGT_v         0.10 1110 1.1 ..... 11101 1 ..... ..... @qrrr_sd
 FABD_v          0.10 1110 110 ..... 00010 1 ..... ..... @qrrr_h
 FABD_v          0.10 1110 1.1 ..... 11010 1 ..... ..... @qrrr_sd
 
+FRECPS_v        0.00 1110 010 ..... 00111 1 ..... ..... @qrrr_h
+FRECPS_v        0.00 1110 0.1 ..... 11111 1 ..... ..... @qrrr_sd
+
+FRSQRTS_v       0.00 1110 110 ..... 00111 1 ..... ..... @qrrr_h
+FRSQRTS_v       0.00 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9d1ddfbdddc..a27c01586c0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5035,6 +5035,20 @@ static const FPScalar f_scalar_fabd = {
 };
 TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd)
 
+static const FPScalar f_scalar_frecps = {
+    gen_helper_recpsf_f16,
+    gen_helper_recpsf_f32,
+    gen_helper_recpsf_f64,
+};
+TRANS(FRECPS_s, do_fp3_scalar, a, &f_scalar_frecps)
+
+static const FPScalar f_scalar_frsqrts = {
+    gen_helper_rsqrtsf_f16,
+    gen_helper_rsqrtsf_f32,
+    gen_helper_rsqrtsf_f64,
+};
+TRANS(FRSQRTS_s, do_fp3_scalar, a, &f_scalar_frsqrts)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -5182,6 +5196,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
 };
 TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
 
+static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
+    gen_helper_gvec_recps_h,
+    gen_helper_gvec_recps_s,
+    gen_helper_gvec_recps_d,
+};
+TRANS(FRECPS_v, do_fp3_vector, a, f_vector_frecps)
+
+static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
+    gen_helper_gvec_rsqrts_h,
+    gen_helper_gvec_rsqrts_s,
+    gen_helper_gvec_rsqrts_d,
+};
+TRANS(FRSQRTS_v, do_fp3_vector, a, f_vector_frsqrts)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -9301,107 +9329,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     }
 }
 
-/* Handle the 3-same-operands float operations; shared by the scalar
- * and vector encodings. The caller must filter out any encodings
- * not allocated for the encoding it is dealing with.
- */
-static void handle_3same_float(DisasContext *s, int size, int elements,
-                               int fpopcode, int rd, int rn, int rm)
-{
-    int pass;
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-
-    for (pass = 0; pass < elements; pass++) {
-        if (size) {
-            /* Double */
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op1, rn, pass, MO_64);
-            read_vec_element(s, tcg_op2, rm, pass, MO_64);
-
-            switch (fpopcode) {
-            case 0x1f: /* FRECPS */
-                gen_helper_recpsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3f: /* FRSQRTS */
-                gen_helper_rsqrtsf_f64(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x18: /* FMAXNM */
-            case 0x19: /* FMLA */
-            case 0x1a: /* FADD */
-            case 0x1b: /* FMULX */
-            case 0x1c: /* FCMEQ */
-            case 0x1e: /* FMAX */
-            case 0x38: /* FMINNM */
-            case 0x39: /* FMLS */
-            case 0x3a: /* FSUB */
-            case 0x3e: /* FMIN */
-            case 0x5b: /* FMUL */
-            case 0x5c: /* FCMGE */
-            case 0x5d: /* FACGE */
-            case 0x5f: /* FDIV */
-            case 0x7a: /* FABD */
-            case 0x7c: /* FCMGT */
-            case 0x7d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        } else {
-            /* Single */
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_32);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_32);
-
-            switch (fpopcode) {
-            case 0x1f: /* FRECPS */
-                gen_helper_recpsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0x3f: /* FRSQRTS */
-                gen_helper_rsqrtsf_f32(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x18: /* FMAXNM */
-            case 0x19: /* FMLA */
-            case 0x1a: /* FADD */
-            case 0x1b: /* FMULX */
-            case 0x1c: /* FCMEQ */
-            case 0x1e: /* FMAX */
-            case 0x38: /* FMINNM */
-            case 0x39: /* FMLS */
-            case 0x3a: /* FSUB */
-            case 0x3e: /* FMIN */
-            case 0x5b: /* FMUL */
-            case 0x5c: /* FCMGE */
-            case 0x5d: /* FACGE */
-            case 0x5f: /* FDIV */
-            case 0x7a: /* FABD */
-            case 0x7c: /* FCMGT */
-            case 0x7d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            if (elements == 1) {
-                /* scalar single so clear high part */
-                TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-                tcg_gen_extu_i32_i64(tcg_tmp, tcg_res);
-                write_vec_element(s, tcg_tmp, rd, pass, MO_64);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-            }
-        }
-    }
-
-    clear_vec_high(s, elements * (size ? 8 : 4) > 8, rd);
-}
-
 /* AdvSIMD scalar three same
  *  31 30  29 28       24 23  22  21 20  16 15    11  10 9    5 4    0
  * +-----+---+-----------+------+---+------+--------+---+------+------+
@@ -9418,33 +9345,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     bool u = extract32(insn, 29, 1);
     TCGv_i64 tcg_rd;
 
-    if (opcode >= 0x18) {
-        /* Floating point: U, size[1] and opcode indicate operation */
-        int fpopcode = opcode | (extract32(size, 1, 1) << 5) | (u << 6);
-        switch (fpopcode) {
-        case 0x1f: /* FRECPS */
-        case 0x3f: /* FRSQRTS */
-            break;
-        default:
-        case 0x1b: /* FMULX */
-        case 0x5d: /* FACGE */
-        case 0x7d: /* FACGT */
-        case 0x1c: /* FCMEQ */
-        case 0x5c: /* FCMGE */
-        case 0x7a: /* FABD */
-        case 0x7c: /* FCMGT */
-            unallocated_encoding(s);
-            return;
-        }
-
-        if (!fp_access_check(s)) {
-            return;
-        }
-
-        handle_3same_float(s, extract32(size, 0, 1), 1, fpopcode, rd, rn, rm);
-        return;
-    }
-
     switch (opcode) {
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
@@ -9561,80 +9461,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     write_fp_dreg(s, rd, tcg_rd);
 }
 
-/* AdvSIMD scalar three same FP16
- *  31 30  29 28       24 23  22 21 20  16 15 14 13    11 10  9  5 4  0
- * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
- * | 0 1 | U | 1 1 1 1 0 | a | 1 0 |  Rm  | 0 0 | opcode | 1 | Rn | Rd |
- * +-----+---+-----------+---+-----+------+-----+--------+---+----+----+
- * v: 0101 1110 0100 0000 0000 0100 0000 0000 => 5e400400
- * m: 1101 1111 0110 0000 1100 0100 0000 0000 => df60c400
- */
-static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
-                                                  uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int opcode = extract32(insn, 11, 3);
-    int rm = extract32(insn, 16, 5);
-    bool u = extract32(insn, 29, 1);
-    bool a = extract32(insn, 23, 1);
-    int fpopcode = opcode | (a << 3) |  (u << 4);
-    TCGv_ptr fpst;
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-
-    switch (fpopcode) {
-    case 0x07: /* FRECPS */
-    case 0x0f: /* FRSQRTS */
-        break;
-    default:
-    case 0x03: /* FMULX */
-    case 0x04: /* FCMEQ (reg) */
-    case 0x14: /* FCMGE (reg) */
-    case 0x15: /* FACGE */
-    case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT (reg) */
-    case 0x1d: /* FACGT */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!dc_isar_feature(aa64_fp16, s)) {
-        unallocated_encoding(s);
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
-
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-    tcg_res = tcg_temp_new_i32();
-
-    switch (fpopcode) {
-    case 0x07: /* FRECPS */
-        gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    case 0x0f: /* FRSQRTS */
-        gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
-    default:
-    case 0x03: /* FMULX */
-    case 0x04: /* FCMEQ (reg) */
-    case 0x14: /* FCMGE (reg) */
-    case 0x15: /* FACGE */
-    case 0x1a: /* FABD */
-    case 0x1c: /* FCMGT (reg) */
-    case 0x1d: /* FACGT */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
 /* AdvSIMD scalar three same extra
  *  31 30  29 28       24 23  22  21 20  16  15 14    11  10 9  5 4  0
  * +-----+---+-----------+------+---+------+---+--------+---+----+----+
@@ -11107,7 +10933,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 
 /* Pairwise op subgroup of C3.6.16.
  *
- * This is called directly or via the handle_3same_float for float pairwise
+ * This is called directly for float pairwise
  * operations where the opcode and size are calculated differently.
  */
 static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
@@ -11264,10 +11090,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
-    int datasize = is_q ? 128 : 64;
-    int esize = 32 << size;
-    int elements = datasize / esize;
-
     if (size == 1 && !is_q) {
         unallocated_encoding(s);
         return;
@@ -11286,13 +11108,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_32,
                                rn, rm, rd);
         return;
-    case 0x1f: /* FRECPS */
-    case 0x3f: /* FRSQRTS */
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_3same_float(s, size, elements, fpopcode, rd, rn, rm);
-        return;
 
     case 0x1d: /* FMLAL  */
     case 0x3d: /* FMLSL  */
@@ -11321,10 +11136,12 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     case 0x1b: /* FMULX */
     case 0x1c: /* FCMEQ */
     case 0x1e: /* FMAX */
+    case 0x1f: /* FRECPS */
     case 0x38: /* FMINNM */
     case 0x39: /* FMLS */
     case 0x3a: /* FSUB */
     case 0x3e: /* FMIN */
+    case 0x3f: /* FRSQRTS */
     case 0x5b: /* FMUL */
     case 0x5c: /* FCMGE */
     case 0x5d: /* FACGE */
@@ -11666,17 +11483,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
      * together indicate the operation.
      */
     int fpopcode = opcode | (a << 3) | (u << 4);
-    int datasize = is_q ? 128 : 64;
-    int elements = datasize / 16;
     bool pairwise;
     TCGv_ptr fpst;
     int pass;
 
     switch (fpopcode) {
-    case 0x7: /* FRECPS */
-    case 0xf: /* FRSQRTS */
-        pairwise = false;
-        break;
     case 0x10: /* FMAXNMP */
     case 0x12: /* FADDP */
     case 0x16: /* FMAXP */
@@ -11691,10 +11502,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x3: /* FMULX */
     case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
+    case 0x7: /* FRECPS */
     case 0x8: /* FMINNM */
     case 0x9: /* FMLS */
     case 0xa: /* FSUB */
     case 0xe: /* FMIN */
+    case 0xf: /* FRSQRTS */
     case 0x13: /* FMUL */
     case 0x14: /* FCMGE */
     case 0x15: /* FACGE */
@@ -11758,44 +11571,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             write_vec_element_i32(s, tcg_res[pass], rd, pass, MO_16);
         }
     } else {
-        for (pass = 0; pass < elements; pass++) {
-            TCGv_i32 tcg_op1 = tcg_temp_new_i32();
-            TCGv_i32 tcg_op2 = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op1, rn, pass, MO_16);
-            read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
-
-            switch (fpopcode) {
-            case 0x7: /* FRECPS */
-                gen_helper_recpsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            case 0xf: /* FRSQRTS */
-                gen_helper_rsqrtsf_f16(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
-            default:
-            case 0x0: /* FMAXNM */
-            case 0x1: /* FMLA */
-            case 0x2: /* FADD */
-            case 0x3: /* FMULX */
-            case 0x4: /* FCMEQ */
-            case 0x6: /* FMAX */
-            case 0x8: /* FMINNM */
-            case 0x9: /* FMLS */
-            case 0xa: /* FSUB */
-            case 0xe: /* FMIN */
-            case 0x13: /* FMUL */
-            case 0x14: /* FCMGE */
-            case 0x15: /* FACGE */
-            case 0x17: /* FDIV */
-            case 0x1a: /* FABD */
-            case 0x1c: /* FCMGT */
-            case 0x1d: /* FACGT */
-                g_assert_not_reached();
-            }
-
-            write_vec_element_i32(s, tcg_res, rd, pass, MO_16);
-        }
+        g_assert_not_reached();
     }
 
     clear_vec_high(s, is_q, rd);
@@ -13565,7 +13341,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
-    { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.34.1


