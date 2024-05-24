Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8ACC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEa-0006ml-JF; Fri, 24 May 2024 19:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEX-0006iU-AO
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEP-0005q4-2q
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:57 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so22972845ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592907; x=1717197707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwWJz5dYdceid2k272oRtgntPmVKRyShOM+but+kUR8=;
 b=K95PmI0HPhCC9IbD6lDDeRMtO8+TWnDtUBIG2X0MWDM1WA5rL0OeP9vENFYjQC3zQ/
 3aIFX0M9d/qicHk/CMxbkkE2bHWHX5rIwSHy9wRDBbMgpHyibWNJxlLrf9dgYjuUe3q6
 D2SOssr5UqlM7pntwabFqAl+pkUCAYbx2WGhmU+taEBVYGp4exp0q3CTUN6b+45KfnwN
 Yr+q9zp+qWKqqT4UpqwvHt6t8lBcXmDGlEc7rQMoYnXPI3yOk+NihDq/qxsDOE/I2me3
 Sj6jHQ7IN8l7cb0F2/DkJ64gP8XCFzjWDeDa511sgJkDzSMfYHxhkNJ8hxXtaa4uefA6
 Fjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592907; x=1717197707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwWJz5dYdceid2k272oRtgntPmVKRyShOM+but+kUR8=;
 b=FW8PN1tA1CT3akhEnl58bJmx6MocENHvKR9qcMOPR1+FSZy9RZhz9mEU5aJdfc8pvz
 MtZphgB8J9BssErHzFbSrfOjbq5RNwyRQUZjI0ZQfSUgzG3YeXskFUsJFbU4+v0nO0Wg
 kK2b9CQ3IpdlFMgu8OJeiMKA/rhMd3OxpTHzwbpa5vc69Uzkub44AfdN3eqEVBKJv2WS
 a3m+DZeD7zpgfjv7ZiwDhvVdt60W12Td8++Fc+sCH3qBW55NWxY1qimbhzNTMyH9jMWo
 wTY104wht2YFlwoewVc+7B93p8NyTXz3Mb9zwXkV5s3mD9UoDC4r9v/+O0GUcozUfzug
 rGkA==
X-Gm-Message-State: AOJu0YzFMt7Rq+M2psiN1Ow0V7xK4Fl+kS6wIowxKKukgxBIKYdK+RAm
 A3qpdtFWVfc+ipYfne93onBOiMHcW5um78odaiNFgvnj+rpexZhH5dAHybGAukExjsKLeOWstEI
 +
X-Google-Smtp-Source: AGHT+IG8BLARPBsm7R1AUMHGvohsV1cyqmp6BFgsqHnAEZXKkvaBRmXIBfyCbEAGNaQ8hGVUJ1cwzA==
X-Received: by 2002:a17:903:1112:b0:1e2:9676:c326 with SMTP id
 d9443c01a7336-1f44871e145mr43385035ad.29.1716592906690; 
 Fri, 24 May 2024 16:21:46 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 27/67] target/arm: Convert FRECPS, FRSQRTS to decodetree
Date: Fri, 24 May 2024 16:20:41 -0700
Message-Id: <20240524232121.284515-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These are the last instructions within handle_3same_float
and disas_simd_scalar_three_reg_same_fp16 so remove them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  12 ++
 target/arm/tcg/translate-a64.c | 293 ++++-----------------------------
 2 files changed, 46 insertions(+), 259 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a852b5f06f..84cb38f1dd 100644
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
index 633384d2a5..a7537a5104 100644
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
@@ -9308,107 +9336,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
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
@@ -9425,33 +9352,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
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
@@ -9568,80 +9468,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
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
@@ -11114,7 +10940,7 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
 
 /* Pairwise op subgroup of C3.6.16.
  *
- * This is called directly or via the handle_3same_float for float pairwise
+ * This is called directly for float pairwise
  * operations where the opcode and size are calculated differently.
  */
 static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
@@ -11271,10 +11097,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
 
-    int datasize = is_q ? 128 : 64;
-    int esize = 32 << size;
-    int elements = datasize / esize;
-
     if (size == 1 && !is_q) {
         unallocated_encoding(s);
         return;
@@ -11293,13 +11115,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
@@ -11328,10 +11143,12 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
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
@@ -11673,17 +11490,11 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -11698,10 +11509,12 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -11765,44 +11578,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
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
@@ -13572,7 +13348,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e400400, 0x9f60c400, disas_simd_three_reg_same_fp16 },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
-    { 0x5e400400, 0xdf60c400, disas_simd_scalar_three_reg_same_fp16 },
     { 0x00000000, 0x00000000, NULL }
 };
 
-- 
2.34.1


