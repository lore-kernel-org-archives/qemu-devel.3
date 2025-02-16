Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2521C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmS-0005Xh-9L; Sun, 16 Feb 2025 18:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmK-0005UY-Ah
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:24 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmG-0005Ck-UN
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-220c4159f87so49414675ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747419; x=1740352219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMOGMscOHLolJS3viE5Ak01dGaJ1f+2vioA6mZtVzE0=;
 b=Yfl3ka/QjT5ymNfWSMlS+uFJAWeRwNkonrPJARbKsNcDxhyojRkloHMyLDkiyLB+Dx
 T0x5Wcmm7S/Skjq1JnTCSgPqLTjxe4FGUrftflLwkD6Nz50mhmOiHOG2N5C4ibjtOw3S
 EUEgzgo8Koi30XYBoorWS0A3qIiAZUcP9fz3um1Q88Gcl9Xy4BcjTyLg/L+UGsCRMPz4
 TJ+NhJrP5W0QF+MQlBD728ZzuQULYnCHtMSt/beKbo8kZ9m9pq7/8XNEG9SQ1sSm0HQE
 d8nm2USB9OE17omQj5NnP5zheH6SUFYqZQl/f6pQlPMOAezuybaOsYycgONWR8StqZtx
 MC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747419; x=1740352219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMOGMscOHLolJS3viE5Ak01dGaJ1f+2vioA6mZtVzE0=;
 b=FzIf4Fwz3/65lsaHG/8fj1USzgQohcx5bnEh2WTXbV+PAEfemURt/1PJeJx7JxlgIN
 c7aVYKFTIwmzoD3aCkd6OnRwN2tMtC7m2M0V5Gr8F4PO7DbLVy2RVspo5RNbvb9Yow78
 IvVhvIzOfk6voGccLqrGnvK3g/5IPaf1l6VJzgLVX0FDzaFLS0PK1+wSaOpd5cTSEHWR
 /wTPpez9HRPfjqog3CQJsxQZqJmIromyF2Z212l1UGyMYF0+lhncuTwZg0lObrUH50zp
 /xHqQAAaXABZaiuXOvMHdEtorCDEKZPiUfneC83d0v4DqFeob1h2k/JMtdghUWiWdFzy
 YxiA==
X-Gm-Message-State: AOJu0Yyw/oHEWzbHDSThBP0CGs3R97JLjehR/vkcM7OHl/kRFy4dwDJ9
 dvEXq4uqxMQszootVbrjgz6L6+CQwHU4Shi3mT198Q3TxSF3X6Xa7ADTVJwipFSBi5WVg+BFGIj
 Y
X-Gm-Gg: ASbGncv4M3bBESo4ntFTZ7MBCWng9YeyLdE9BFXi7LnCf2/n4YM9hh5COv3CCUCSo0T
 plketuboQK83ZYSKtgbxWZ4njW4FMjuButz10mhVF3SklBdTF0fSz2s9nT12IMd4DWJ1frUoazL
 Aod2b27G6ePFnMH6ffS/cbPi9b+WCQZmesrKswwHJAX1Q5oCQhmJbW8RTk4LC3wG5kIG9CvcQ7A
 S9f1ICv1sgSuoCfZmweN3I3SQ7wY4H+QGQd7dk34p3fUG6C0JmSquvreVTOkTtDt/atNuiQNe8H
 1B9wf9kOrERDu7Ia8deA6cajBpwGQzpRLX0QG35PN+zQysI=
X-Google-Smtp-Source: AGHT+IEm8jjPJ42ZiBFDQE6BcPGwDf7c/QT+pKqgs0ckIKXX3w74H/1iV3GxwK/2IwLK9Pc2cUi1Nw==
X-Received: by 2002:a17:903:2cb:b0:21f:6ce6:7243 with SMTP id
 d9443c01a7336-221040d84c0mr117162245ad.51.1739747419379; 
 Sun, 16 Feb 2025 15:10:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 007/162] tcg: Merge INDEX_op_and_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:36 -0800
Message-ID: <20250216231012.2808572-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 target/sh4/translate.c   |  4 ++--
 tcg/optimize.c           | 40 ++++++++++++----------------------------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 8 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 0282779468..f45029caa7 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -40,6 +40,7 @@ DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 
 DEF(add, 1, 2, 0, TCG_OPF_INT)
+DEF(and, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -62,7 +63,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(and_i32, 1, 2, 0, 0)
 DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
@@ -124,7 +124,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(and_i64, 1, 2, 0, 0)
 DEF(or_i64, 1, 2, 0, 0)
 DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index aa7e0a6690..acc6b92f18 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1943,7 +1943,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_add;
         goto do_reg_op;
     case 0x2009: /* and Rm,Rn */
-        op_opc = INDEX_op_and_i32;
+        op_opc = INDEX_op_and;
         goto do_reg_op;
     case 0x200a: /* xor Rm,Rn */
         op_opc = INDEX_op_xor_i32;
@@ -2105,7 +2105,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_and_i32:
+    case INDEX_op_and:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index b6386a69fe..f217ed9366 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -421,7 +421,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64(mul):
         return x * y;
 
-    CASE_OP_32_64_VEC(and):
+    case INDEX_op_and:
+    case INDEX_op_and_vec:
         return x & y;
 
     CASE_OP_32_64_VEC(or):
@@ -790,9 +791,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst) {
-        TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
-                             ? INDEX_op_and_i32 : INDEX_op_and_i64);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
         TCGArg tmp = arg_new_temp(ctx);
 
         op2->args[0] = tmp;
@@ -885,8 +884,8 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
-        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
         TCGArg t1 = arg_new_temp(ctx);
         TCGArg t2 = arg_new_temp(ctx);
 
@@ -1697,8 +1696,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     TempOptInfo *t2 = arg_info(op->args[2]);
     int ofs = op->args[3];
     int len = op->args[4];
-    int width;
-    TCGOpcode and_opc;
+    int width = 8 * tcg_type_size(ctx->type);
     uint64_t z_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
@@ -1707,24 +1705,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    switch (ctx->type) {
-    case TCG_TYPE_I32:
-        and_opc = INDEX_op_and_i32;
-        width = 32;
-        break;
-    case TCG_TYPE_I64:
-        and_opc = INDEX_op_and_i64;
-        width = 64;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     /* Inserting a value into zero at offset 0. */
     if (ti_is_const_val(t1, 0) && ofs == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, len);
 
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
         return fold_and(ctx, op);
@@ -1734,7 +1719,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     if (ti_is_const_val(t2, 0)) {
         uint64_t mask = deposit64(-1, ofs, len, 0);
 
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[2] = arg_new_constant(ctx, mask);
         return fold_and(ctx, op);
     }
@@ -2285,7 +2270,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2307,7 +2292,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        and_opc = INDEX_op_and_i32;
         sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
@@ -2320,7 +2304,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        and_opc = INDEX_op_and_i64;
         sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
@@ -2359,7 +2342,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
             op2->args[2] = arg_new_constant(ctx, sh);
             src1 = ret;
         }
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[1] = src1;
         op->args[2] = arg_new_constant(ctx, 1);
     }
@@ -2836,7 +2819,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(add2):
             done = fold_add2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(and):
+        case INDEX_op_and:
+        case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
             break;
         CASE_OP_32_64_VEC(andc):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 344d490966..82f3ad501f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -401,7 +401,7 @@ void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_and_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
 }
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1575,7 +1575,7 @@ void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_and_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_and_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 68afee4423..99dff2b875 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1005,8 +1005,7 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
-    OUTOP(INDEX_op_and_i32, TCGOutOpBinary, outop_and),
-    OUTOP(INDEX_op_and_i64, TCGOutOpBinary, outop_and),
+    OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
 };
 
 #undef OUTOP
@@ -2208,6 +2207,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
     case INDEX_op_add:
+    case INDEX_op_and:
     case INDEX_op_mov:
         return has_type;
 
@@ -2225,7 +2225,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_and_i32:
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
@@ -2308,7 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
@@ -5438,8 +5436,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_add:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index ceb791a735..8762a99fb6 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -535,7 +535,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
-        CASE_32_64(and)
+        case INDEX_op_and:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
             break;
@@ -1083,12 +1083,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_add:
+    case INDEX_op_and:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
     case INDEX_op_or_i32:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 67387bfddf..6a8025c0bf 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -303,7 +303,7 @@ Logical
 
 .. list-table::
 
-   * - and_i32/i64 *t0*, *t1*, *t2*
+   * - and *t0*, *t1*, *t2*
 
      - | *t0* = *t1* & *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index fd38ecad39..b0141f8ed6 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -651,7 +651,7 @@ static const TCGOutOpBinary outop_add = {
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_and_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_and = {
-- 
2.43.0


