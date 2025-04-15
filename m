Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0864C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lua-0008Tj-5r; Tue, 15 Apr 2025 15:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luR-0008Pc-I4
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:28 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luO-0007wE-D8
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:27 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736a72220edso6125312b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745123; x=1745349923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D387i58UkR52733owjYk+bJShzCa6myPCNjS7nZeUg8=;
 b=aFrzelyFa3ZexxTr25MA4RaY4xdYPM7E9dBu19G9/kzx7aTnOGaaY/afU0jLWWU1vr
 0hdxqfjKkutQxByha12Cfe0er1xfK0FmchTeDttgXH3duLy4jSuzUU+r0YsxHfQ3rMBn
 h1dFthspXJjJxgt0/1zkU5PWi4ZU2T0x6JKxg/AZyd81iGa6+MefiyLuEgtSKt8Eb3Qs
 kqvHSU2+XgUxs58qpFBIABjWbDwUhUqNG9/08goXDq3D/X2rsJE6dYkpRIfxpoquYQjo
 hEuDHbzbt9g+dSxVdC5tAxunBOKipPXEDaHyK/jDqkmIwa+sN2AeI3ZjY/SCQQu1V5Ss
 JwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745123; x=1745349923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D387i58UkR52733owjYk+bJShzCa6myPCNjS7nZeUg8=;
 b=T0QtoxJMLUn5A04glqp2p3OKEUQeo1+Yjv2c66AtLb69PfzHbCd8kQdddQDA1tHpT8
 eqvFdxWCRn4nOy0KaJRgOV5jsUK4KgKbBe3lm7xsNzzoBV7VMTG+Q/Vjkwbs4vayTcGX
 bnaenW7CM5UP/iLeMFqj/7M0KcjsoJCBuc0MRfSs3uYx/zrQjRnB7YqT1HYCav6Ua9/f
 lyrJ4lZi9sTDBLymBe5t+RM2WNOiBFZQli6IfDqG6wcNsUsVwcVCvfOC3HgKQE/VMs//
 qAucE+935+QnNoYY1y+ggWecpOg0l2Fk9SM3n2zGMBRBI2BqPSxJkll94Dk+IWw/uTes
 02Pw==
X-Gm-Message-State: AOJu0Yxw9uchz7b480ghLafBkxGAdSRinBt/180dgKREV7dbP4+UPXYQ
 VER38OfJ6vdK1eNK9ctnpvcCEFCr1m1QQh34d/wjWh1FodoTbgC05KVFThLGQZ9FNkpRPcQCxGD
 i
X-Gm-Gg: ASbGncv0pcT7Q/10B5TopnEowAIgvgAl3t4toEIVnHNSVz5kgtafREkB0T18mPWe3ke
 y57kbd/t6DxgBdlDuuKxDpD3K4GocL3mdrKg1dD3Kk+9CTuI9QssUGOBleLlNJBab71PQkhurRV
 HyGY4snVzN82ikAnjzFyEOEeP3a0sjQ60rSKfIYeqUrmAZ0eUUUUVGFNI3mxd4AQb25ZBHZIhGA
 lYbcuxFnFHh2SxOws/faO3v4VZco2Xg4nWsiIzHzaPe4DrINdyWqBFhhKN+TYkIJcLBgJge6Dxr
 S0tZ2BVAfhDEfxt9/USZKrDoBU9PFrEm89VvumXtq4Pez95Lf49zVY8hTJ76NWQSFU2cN8b9tkc
 =
X-Google-Smtp-Source: AGHT+IGEdmcG2QSZjNQvImRJCrTiKqSRyC4JLCsaqOmAB3ym1LXxbn0HNipLP/WnkIge+9nTnzjZfA==
X-Received: by 2002:a05:6a00:3cc2:b0:736:bfc4:ef2c with SMTP id
 d2e1a72fcca58-73c1f787691mr903022b3a.0.1744745122859; 
 Tue, 15 Apr 2025 12:25:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 008/163] tcg: Merge INDEX_op_and_{i32,i64}
Date: Tue, 15 Apr 2025 12:22:39 -0700
Message-ID: <20250415192515.232910-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 92c504c641..2320408c4a 100644
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
@@ -5441,8 +5439,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


