Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2758E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfV-0004Pu-QD; Thu, 02 Jan 2025 13:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPek-0007Wj-1h
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeg-0006GP-5s
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:49 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216728b1836so140725825ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841445; x=1736446245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TuFUwA8IB5W1G4Atbra68bknXClTIk49s/V409/ZLlA=;
 b=dDJYYeEQRzTp8LuIJmOdjeFm5Ca+/JjUmvdfwUNxD+TQ2U2bps+ieqrpMlBavvltAf
 6YJSrs9mScBU6WS7tjKLKc0uEhpC4i99xvTESwtLyD7pCybTOJAnfDhuamDsvwRwq4mN
 wbIrxMMc1I9T2CmW9bu/k4hk4tvX6yrZa/uBeduNSAuC9A5MPaZKnLc3HvJ7BCmXnL0I
 Ih4D/yR3xi0SZzDIYChbkDog7ZIpIAUim0yk7qZvr/MfW9JnjF+OuWMyMMcC2+mcoc/3
 pg5nN2+W+lVWo3h4Z2AzHZu11lk++0i4guggPcRtBe9Oj2Wytty6N1c+Qp8zPoBGzuG1
 l9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841445; x=1736446245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuFUwA8IB5W1G4Atbra68bknXClTIk49s/V409/ZLlA=;
 b=KTjmu+x6i0BU4QajmUtdscNnBOiYqDax5N6t6aNYv+J/QuIVQJZelsvFd5SWnWI08x
 Uvx8AWI/MA4Y76AvL2a3CjARUDSz3FpBM8HM1llWsmeaqiHREluIKD5qGYthF88ielsE
 kqCAFGM/qfySX7h+c4/DxGc1b9gvuSevXPgSwsAzWshqyYKzhEgYyZhfDh5EHEkh47rW
 GG1siD0ZrA42TGHQtjGdIF5tZNa4/4dY6EaFgTI2RqctjuzU2SIe9Q69Bqg7ayHNsEj1
 GvSFgRULI+F9rBpmJAgreCN9YbehyTvnJdwcbGZCDD+gVQwlDv1o0n20yCkumtf1ddVr
 RvnQ==
X-Gm-Message-State: AOJu0YxP7avPdTrfDI/mevB5e0aw8higzRn7w4iZFJyUjDhpmLD5hUy+
 KybZJ5LCHx9QaS0MkXrSf0wVjRJrNNXiZEFUfjclg1eTXcOPA4STYNbluf4TuJJxXv9m7VB8aDE
 n
X-Gm-Gg: ASbGnctEC6/293atflF1/4TdPsMrmbMwEQicFHQnGc1gQ0NF0gQFLrVHLHA1+FgVJFe
 QgKDoW3etmigK+7ZbBgO3WbgLCjsJ5WcGV/937svH0bLkift+sNxqMpfBpNM3Y9Ng9l1UEperU1
 0m3/4A0580N1fnm9pLsFfdEzC/72NRBjflR7pm2Mr1I7jT2uSjtu4chwrLx1HO6Lb9fDOJJzczs
 gh62eeJOfbVgPXNxRUI689BFqDqXclpRjsGuxX+XucNL6aJ1h2vS1d7LT/04Q==
X-Google-Smtp-Source: AGHT+IF21K++tno6epgpw+qaSDKYQdo4LinyjGIfTBFDOAuQ8gVhgxCG3g7n+Ys8yUpdTh4wAmOH4w==
X-Received: by 2002:a05:6a20:c88f:b0:1d5:10d6:92b9 with SMTP id
 adf61e73a8af0-1e5e07f88demr70420049637.30.1735841444419; 
 Thu, 02 Jan 2025 10:10:44 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 63/73] tcg: Merge integer add, sub, neg operations
Date: Thu,  2 Jan 2025 10:06:43 -0800
Message-ID: <20250102180654.1420056-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |   9 +--
 target/sh4/translate.c           |   6 +-
 tcg/optimize.c                   |  50 ++++--------
 tcg/tcg-op.c                     |  12 +--
 tcg/tcg.c                        |  19 ++---
 tcg/tci.c                        |  15 ++--
 tcg/aarch64/tcg-target.c.inc     |  22 ++----
 tcg/arm/tcg-target.c.inc         |  12 +--
 tcg/i386/tcg-target.c.inc        |  15 ++--
 tcg/loongarch64/tcg-target.c.inc |  50 +++++-------
 tcg/mips/tcg-target.c.inc        |  39 +++++-----
 tcg/ppc/tcg-target.c.inc         |  57 ++++----------
 tcg/riscv/tcg-target.c.inc       |  48 +++++-------
 tcg/s390x/tcg-target.c.inc       | 127 ++++++++++++++-----------------
 tcg/sparc64/tcg-target.c.inc     |  15 ++--
 tcg/tci/tcg-target.c.inc         |  19 ++---
 16 files changed, 194 insertions(+), 321 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 09eb7c3caf..54d43ace2c 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -47,6 +47,9 @@ DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(not, 1, 1, 0, TCG_OPF_INT)
+DEF(add, 1, 2, 0, TCG_OPF_INT)
+DEF(sub, 1, 2, 0, TCG_OPF_INT)
+DEF(neg, 1, 1, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -55,8 +58,6 @@ DEF(movcond_i32, 1, 4, 1, 0)
 DEF(ld_i32, 1, 1, 2, 0)
 DEF(st_i32, 0, 2, 2, 0)
 /* arith */
-DEF(add_i32, 1, 2, 0, 0)
-DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
@@ -88,7 +89,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(neg_i32, 1, 1, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -100,8 +100,6 @@ DEF(movcond_i64, 1, 4, 1, 0)
 DEF(ld_i64, 1, 1, 2, 0)
 DEF(st_i64, 0, 2, 2, 0)
 /* arith */
-DEF(add_i64, 1, 2, 0, 0)
-DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
@@ -130,7 +128,6 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(neg_i64, 1, 1, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bfb8d4919a..5cb9ba9434 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1940,7 +1940,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
     NEXT_INSN;
     switch (ctx->opcode & 0xf00f) {
     case 0x300c: /* add Rm,Rn */
-        op_opc = INDEX_op_add_i32;
+        op_opc = INDEX_op_add;
         goto do_reg_op;
     case 0x2009: /* and Rm,Rn */
         op_opc = INDEX_op_and;
@@ -1984,7 +1984,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if (op_dst != B11_8 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_add_i32;
+        op_opc = INDEX_op_add;
         op_arg = tcg_constant_i32(B7_0s);
         break;
 
@@ -2087,7 +2087,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
                                 ctx->memidx, ld_mop);
         break;
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index d01cd22bf9..08f090edae 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -408,10 +408,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     uint64_t l64, h64;
 
     switch (op) {
-    CASE_OP_32_64(add):
+    case INDEX_op_add:
         return x + y;
 
-    CASE_OP_32_64(sub):
+    case INDEX_op_sub:
         return x - y;
 
     CASE_OP_32_64(mul):
@@ -463,7 +463,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_not_vec:
         return ~x;
 
-    CASE_OP_32_64(neg):
+    case INDEX_op_neg:
         return -x;
 
     case INDEX_op_andc:
@@ -2249,29 +2249,13 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode add_opc, neg_opc;
-
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
             }
-
-            switch (op->type) {
-            case TCG_TYPE_I32:
-                add_opc = INDEX_op_add_i32;
-                neg_opc = INDEX_op_neg_i32;
-                break;
-            case TCG_TYPE_I64:
-                add_opc = INDEX_op_add_i64;
-                neg_opc = INDEX_op_neg_i64;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
             if (!inv) {
-                op->opc = neg_opc;
+                op->opc = INDEX_op_neg;
             } else if (neg) {
-                op->opc = add_opc;
+                op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, op->type, -1);
             } else {
                 op->opc = INDEX_op_xor;
@@ -2285,7 +2269,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sub_opc, neg_opc, shr_opc;
+    TCGOpcode shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2307,9 +2291,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        sub_opc = INDEX_op_sub_i32;
         shr_opc = INDEX_op_shr_i32;
-        neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = INDEX_op_extract_i32;
         }
@@ -2318,9 +2300,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        sub_opc = INDEX_op_sub_i64;
         shr_opc = INDEX_op_shr_i64;
-        neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = INDEX_op_extract_i64;
         }
@@ -2361,7 +2341,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, op->type, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_sub, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, op->type, 1);
@@ -2371,7 +2351,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, op->type, 1);
     } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, op->type, 2);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_neg, op->type, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
     }
@@ -2583,11 +2563,8 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        neg_op = INDEX_op_neg_i32;
-        have_neg = true;
-        break;
     case TCG_TYPE_I64:
-        neg_op = INDEX_op_neg_i64;
+        neg_op = INDEX_op_neg;
         have_neg = true;
         break;
     case TCG_TYPE_V64:
@@ -2632,8 +2609,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[2])) {
         uint64_t val = arg_info(op->args[2])->val;
 
-        op->opc = (op->type == TCG_TYPE_I32
-                   ? INDEX_op_add_i32 : INDEX_op_add_i64);
+        op->opc = INDEX_op_add;
         op->args[2] = arg_new_constant(ctx, op->type, -val);
     }
     return finish_folding(ctx, op);
@@ -2772,7 +2748,7 @@ void tcg_optimize(TCGContext *s)
          * Sorted alphabetically by opcode as much as possible.
          */
         switch (opc) {
-        CASE_OP_32_64(add):
+        case INDEX_op_add:
             done = fold_add(&ctx, op);
             break;
         case INDEX_op_add_vec:
@@ -2873,7 +2849,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
-        CASE_OP_32_64(neg):
+        case INDEX_op_neg:
             done = fold_neg(&ctx, op);
             break;
         case INDEX_op_nor:
@@ -2947,7 +2923,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-        CASE_OP_32_64(sub):
+        case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
         case INDEX_op_sub_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aec952667a..c5554ea948 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -356,7 +356,7 @@ void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_add_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
 }
 
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -371,7 +371,7 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
 }
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -390,7 +390,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
+    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
 }
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -1553,7 +1553,7 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_add_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
     } else {
         tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
@@ -1563,7 +1563,7 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
     } else {
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
@@ -1689,7 +1689,7 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
     } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9292e0bdd1..160b711ee0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2185,9 +2185,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
+    case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_neg:
     case INDEX_op_or:
+    case INDEX_op_sub:
     case INDEX_op_xor:
         return has_type;
 
@@ -2196,9 +2199,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_movcond_i32:
     case INDEX_op_ld_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_add_i32:
-    case INDEX_op_sub_i32:
-    case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2268,9 +2268,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_movcond_i64:
     case INDEX_op_ld_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_add_i64:
-    case INDEX_op_sub_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -3955,16 +3952,12 @@ liveness_pass_1(TCGContext *s)
             break;
 
         case INDEX_op_add2_i32:
-            opc_new = INDEX_op_add_i32;
+        case INDEX_op_add2_i64:
+            opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
-            opc_new = INDEX_op_sub_i32;
-            goto do_addsub2;
-        case INDEX_op_add2_i64:
-            opc_new = INDEX_op_add_i64;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub_i64;
+            opc_new = INDEX_op_sub;
         do_addsub2:
             nb_iargs = 4;
             nb_oargs = 2;
diff --git a/tcg/tci.c b/tcg/tci.c
index af94428975..568b00f35e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -531,11 +531,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (mixed 32/64 bit). */
 
-        CASE_32_64(add)
+        case INDEX_op_add:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
-        CASE_32_64(sub)
+        case INDEX_op_sub:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
@@ -683,7 +683,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
-        CASE_32_64(neg)
+        case INDEX_op_neg:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
             break;
@@ -1068,8 +1068,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
@@ -1077,10 +1076,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1));
         break;
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_add:
+    case INDEX_op_sub:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_and:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4168350845..3a4d878e14 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2195,10 +2195,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_add_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
         if (c2) {
             tcg_out_addsubi(s, ext, a0, a1, a2);
         } else {
@@ -2206,10 +2203,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_sub_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         if (c2) {
             tcg_out_addsubi(s, ext, a0, a1, -a2);
         } else {
@@ -2217,8 +2211,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_neg_i64:
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
@@ -2955,8 +2948,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2977,10 +2969,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_add:
+    case INDEX_op_sub:
         return C_O1_I2(r, r, rA);
 
     case INDEX_op_setcond_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 2422dd1d1b..03069148e1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1908,11 +1908,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         tcg_out_dat_rIN(s, COND_AL, ARITH_ADD, ARITH_SUB,
                         args[0], args[1], args[2], const_args[2]);
         break;
-    case INDEX_op_sub_i32:
+    case INDEX_op_sub:
         if (const_args[1]) {
             if (const_args[2]) {
                 tcg_out_movi32(s, COND_AL, args[0], args[1] - args[2]);
@@ -1982,7 +1982,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
         tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
         break;
     case INDEX_op_not:
@@ -2182,7 +2182,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I1(r);
 
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -2193,8 +2193,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_sub_i32:
+    case INDEX_op_add:
+    case INDEX_op_sub:
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 8064bee3a1..afe62d8067 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2733,7 +2733,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(add):
+    case INDEX_op_add:
         /* For 3-operand addition, use LEA.  */
         if (a0 != a1) {
             TCGArg c3 = 0;
@@ -2751,7 +2751,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         c = ARITH_ADD;
         goto gen_arith;
-    OP_32_64(sub):
+    case INDEX_op_sub:
         c = ARITH_SUB;
         goto gen_arith;
     case INDEX_op_and:
@@ -2898,7 +2898,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(neg):
+    case INDEX_op_neg:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
         break;
     case INDEX_op_not:
@@ -3692,12 +3692,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         }
         g_assert_not_reached();
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
         return C_O1_I2(r, r, re);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_or:
@@ -3733,8 +3731,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index a665f71e4a..2d23fae5dc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1529,41 +1529,32 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, a2);
-        } else {
+            tcg_out_addi(s, type, a0, a1, a2);
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_add_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, a2);
         } else {
             tcg_out_opc_add_d(s, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_sub_i32:
+    case INDEX_op_sub:
         if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, -a2);
-        } else {
+            tcg_out_addi(s, type, a0, a1, -a2);
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_opc_sub_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, -a2);
         } else {
             tcg_out_opc_sub_d(s, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_sub_d(s, a0, TCG_REG_ZERO, a1);
+    case INDEX_op_neg:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
+        } else {
+            tcg_out_opc_sub_d(s, a0, TCG_REG_ZERO, a1);
+        }
         break;
 
     case INDEX_op_mul_i32:
@@ -2240,8 +2231,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
@@ -2281,10 +2271,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
-    case INDEX_op_add_i32:
-        return C_O1_I2(r, r, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rJ);
+    case INDEX_op_add:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rJ));
+    case INDEX_op_sub:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, rZ, ri)
+                : C_O1_I2(r, rZ, rJ));
 
     case INDEX_op_and:
     case INDEX_op_nor:
@@ -2304,10 +2298,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rZ);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
         return C_O1_I2(r, rZ, ri);
-    case INDEX_op_sub_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rJ);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index c2233a6931..34284441ed 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1763,11 +1763,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_add_i32:
-        i1 = OPC_ADDU, i2 = OPC_ADDIU;
-        goto do_binary;
-    case INDEX_op_add_i64:
-        i1 = OPC_DADDU, i2 = OPC_DADDIU;
+    case INDEX_op_add:
+        if (type == TCG_TYPE_I32) {
+            i1 = OPC_ADDU, i2 = OPC_ADDIU;
+        } else {
+            i1 = OPC_DADDU, i2 = OPC_DADDIU;
+        }
         goto do_binary;
     case INDEX_op_or:
         i1 = OPC_OR, i2 = OPC_ORI;
@@ -1783,12 +1784,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, i1, a0, a1, a2);
         break;
 
-    case INDEX_op_sub_i32:
-        i1 = OPC_SUBU, i2 = OPC_ADDIU;
-        goto do_subtract;
-    case INDEX_op_sub_i64:
-        i1 = OPC_DSUBU, i2 = OPC_DADDIU;
-    do_subtract:
+    case INDEX_op_sub:
+        if (type == TCG_TYPE_I32) {
+            i1 = OPC_SUBU, i2 = OPC_ADDIU;
+        } else {
+            i1 = OPC_DSUBU, i2 = OPC_DADDIU;
+        }
         if (c2) {
             tcg_out_opc_imm(s, i2, a0, a1, -a2);
             break;
@@ -1933,11 +1934,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_reg(s, OPC_MFHI, a1, 0, 0);
         break;
 
-    case INDEX_op_neg_i32:
-        i1 = OPC_SUBU;
-        goto do_unary;
-    case INDEX_op_neg_i64:
-        i1 = OPC_DSUBU;
+    case INDEX_op_neg:
+        i1 = type == TCG_TYPE_I32 ? OPC_SUBU : OPC_DSUBU;
         goto do_unary;
     case INDEX_op_not:
         i1 = OPC_NOR;
@@ -2174,14 +2172,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I1(r);
 
     case INDEX_op_ld_i32:
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
@@ -2197,11 +2194,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
         return C_O1_I2(r, r, rJ);
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         return C_O1_I2(r, rZ, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9a499f6861..c984bb24d3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3017,26 +3017,25 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-        do_addi_32:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, (int32_t)a2);
+            tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
         } else {
             tcg_out32(s, ADD | TAB(a0, a1, a2));
         }
         break;
-    case INDEX_op_sub_i32:
+
+    case INDEX_op_sub:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[1]) {
             if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I32, a0, a1 - a2);
+                tcg_out_movi(s, type, a0, a1 - a2);
             } else {
                 tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
             }
         } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tcg_out_mem_long(s, ADDI, ADD, a0, a1, -a2);
         } else {
             tcg_out32(s, SUBF | TAB(a0, a2, a1));
         }
@@ -3203,8 +3202,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
         tcg_out32(s, NEG | RT(args[0]) | RA(args[1]));
         break;
 
@@ -3212,31 +3210,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            tcg_out_mem_long(s, ADDI, ADD, a0, a1, a2);
-        } else {
-            tcg_out32(s, ADD | TAB(a0, a1, a2));
-        }
-        break;
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I64, a0, a1 - a2);
-            } else {
-                tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
-            }
-        } else if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
-        } else {
-            tcg_out32(s, SUBF | TAB(a0, a2, a1));
-        }
-        break;
-
     case INDEX_op_shl_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4157,7 +4130,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
@@ -4165,7 +4138,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sextract_i32:
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -4192,9 +4164,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
                 ? C_O1_I2(r, r, ri)
                 : C_O1_I2(r, r, r));
 
+    case INDEX_op_add:
+    case INDEX_op_sub:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rT));
+
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_add_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -4227,12 +4204,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_sub_i32:
-        return C_O1_I2(r, rI, ri);
-    case INDEX_op_add_i64:
-        return C_O1_I2(r, r, rT);
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 5650ab8115..1d008278d2 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1968,6 +1968,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
     int c2 = const_args[2];
+    RISCVInsn insn;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2031,33 +2032,23 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, a2);
+            insn = type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI;
+            tcg_out_opc_imm(s, insn, a0, a1, a2);
         } else {
-            tcg_out_opc_reg(s, OPC_ADDW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_add_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADD, a0, a1, a2);
+            insn = type == TCG_TYPE_I32 ? OPC_ADDW : OPC_ADD;
+            tcg_out_opc_reg(s, insn, a0, a1, a2);
         }
         break;
 
-    case INDEX_op_sub_i32:
+    case INDEX_op_sub:
         if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
+            insn = type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI;
+            tcg_out_opc_imm(s, insn, a0, a1, -a2);
         } else {
-            tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
+            insn = type == TCG_TYPE_I32 ? OPC_SUBW : OPC_SUB;
+            tcg_out_opc_reg(s, insn, a0, a1, a2);
         }
         break;
 
@@ -2111,11 +2102,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_opc_reg(s, OPC_SUBW, a0, TCG_REG_ZERO, a1);
-        break;
-    case INDEX_op_neg_i64:
-        tcg_out_opc_reg(s, OPC_SUB, a0, TCG_REG_ZERO, a1);
+    case INDEX_op_neg:
+        insn = type == TCG_TYPE_I32 ? OPC_SUBW : OPC_SUB;
+        tcg_out_opc_reg(s, insn, a0, TCG_REG_ZERO, a1);
         break;
 
     case INDEX_op_mul_i32:
@@ -2620,9 +2609,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_not:
-    case INDEX_op_neg_i32:
+    case INDEX_op_neg:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
@@ -2644,11 +2632,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
+    case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_or:
     case INDEX_op_xor:
-    case INDEX_op_add_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
@@ -2660,8 +2647,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_eqv:
         return C_O1_I2(r, r, rJ);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         return C_O1_I2(r, rZ, rN);
 
     case INDEX_op_mul_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 8d738b41bb..38338e316c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1164,6 +1164,40 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg dest, TCGReg src)
     tcg_out_mov(s, TCG_TYPE_I32, dest, src);
 }
 
+static void tgen_addi(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg src, int64_t imm)
+{
+    if (type == TCG_TYPE_I32) {
+        imm = (int32_t)imm;
+        if (dest == src) {
+            if (imm == (int16_t)imm) {
+                tcg_out_insn(s, RI, AHI, dest, imm);
+            } else {
+                tcg_out_insn(s, RIL, AFI, dest, imm);
+            }
+            return;
+        }
+    } else if (dest == src) {
+        if (imm == (int16_t)imm) {
+            tcg_out_insn(s, RI, AGHI, dest, imm);
+            return;
+        }
+        if (imm == (int32_t)imm) {
+            tcg_out_insn(s, RIL, AGFI, dest, imm);
+            return;
+        }
+        if (imm == (uint32_t)imm) {
+            tcg_out_insn(s, RIL, ALGFI, dest, imm);
+            return;
+        }
+        if (-imm == (uint32_t)-imm) {
+            tcg_out_insn(s, RIL, SLGFI, dest, -imm);
+            return;
+        }
+    }
+    tcg_out_mem(s, RX_LA, RXY_LAY, dest, src, TCG_REG_NONE, imm);
+}
+
 static void tgen_andi_risbg(TCGContext *s, TCGReg out, TCGReg in, uint64_t val)
 {
     int msb, lsb;
@@ -2217,30 +2251,25 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
+    case INDEX_op_add:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-        do_addi_32:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AHI, a0, a2);
-                    break;
-                }
-                tcg_out_insn(s, RIL, AFI, a0, a2);
-                break;
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
+            tgen_addi(s, type, a0, a1, a2);
+        } else if (a0 != a1) {
+            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_insn(s, RR, AR, a0, a2);
         } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
+            tcg_out_insn(s, RRE, AGR, a0, a2);
         }
         break;
-    case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = (int32_t)args[2];
+
+    case INDEX_op_sub:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_32;
+            tgen_addi(s, type, a0, a1, -a2);
+        } else if (type != TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, SR, a0, a2);
         } else {
@@ -2342,9 +2371,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_neg_i32:
-        tcg_out_insn(s, RR, LCR, args[0], args[1]);
+    case INDEX_op_neg:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RR, LCR, args[0], args[1]);
+        } else {
+            tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
+        }
         break;
+
     case INDEX_op_not:
         if (type == TCG_TYPE_I32) {
             tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
@@ -2526,48 +2560,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_add_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-        do_addi_64:
-            if (a0 == a1) {
-                if (a2 == (int16_t)a2) {
-                    tcg_out_insn(s, RI, AGHI, a0, a2);
-                    break;
-                }
-                if (a2 == (int32_t)a2) {
-                    tcg_out_insn(s, RIL, AGFI, a0, a2);
-                    break;
-                }
-                if (a2 == (uint32_t)a2) {
-                    tcg_out_insn(s, RIL, ALGFI, a0, a2);
-                    break;
-                }
-                if (-a2 == (uint32_t)-a2) {
-                    tcg_out_insn(s, RIL, SLGFI, a0, -a2);
-                    break;
-                }
-            }
-            tcg_out_mem(s, RX_LA, RXY_LAY, a0, a1, TCG_REG_NONE, a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RRE, AGR, a0, a2);
-        } else {
-            tcg_out_insn(s, RX, LA, a0, a1, a2, 0);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            a2 = -a2;
-            goto do_addi_64;
-        } else {
-            tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
-        }
-        break;
-
-    case INDEX_op_neg_i64:
-        tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
@@ -3208,8 +3200,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
+    case INDEX_op_sub:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -3227,10 +3219,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_and:
         return (op->type == TCG_TYPE_I32
                 ? C_O1_I2(r, r, ri)
@@ -3277,8 +3265,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index cec6a3df43..0134898c8a 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1362,10 +1362,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(add):
+    case INDEX_op_add:
         c = ARITH_ADD;
         goto gen_arith;
-    OP_32_64(sub):
+    case INDEX_op_sub:
         c = ARITH_SUB;
         goto gen_arith;
     case INDEX_op_and:
@@ -1399,7 +1399,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         c = ARITH_UMUL;
         goto gen_arith;
 
-    OP_32_64(neg):
+    case INDEX_op_neg:
 	c = ARITH_SUB;
 	goto gen_arith1;
     case INDEX_op_not:
@@ -1554,8 +1554,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
@@ -1577,16 +1576,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
     case INDEX_op_divu_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 8a6e8a9185..2268e1ff6d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -45,8 +45,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
     case INDEX_op_not:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -76,10 +75,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_add:
+    case INDEX_op_sub:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_and:
@@ -454,9 +451,7 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
     stack_bounds_check(base, offset);
     if (offset != sextract32(offset, 0, 16)) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
-        tcg_out_op_rrr(s, (TCG_TARGET_REG_BITS == 32
-                           ? INDEX_op_add_i32 : INDEX_op_add_i64),
-                       TCG_REG_TMP, TCG_REG_TMP, base);
+        tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
         base = TCG_REG_TMP;
         offset = 0;
     }
@@ -716,8 +711,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(add)
-    CASE_32_64(sub)
+    case INDEX_op_add:
+    case INDEX_op_sub:
     CASE_32_64(mul)
     case INDEX_op_and:
     case INDEX_op_or:
@@ -760,7 +755,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
         break;
 
-    CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
+    case INDEX_op_neg:
     case INDEX_op_not:
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap). */
-- 
2.43.0


