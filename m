Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B5FE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4aq-00011g-2m; Tue, 07 Jan 2025 03:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ab-0000Yo-Ox
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aR-0003On-Qz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso214603165ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237113; x=1736841913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEe4v5C9/PWNyByBZmpxPddvBHJdcBQ7qIXflzieNkU=;
 b=HGRB58jmGLyyWZiMmZ4Ts9qSlolMp45vHfA6zBvRT44ndyf1RqbWak/1hIH+sCfp34
 /avP4ugDw+SRlqqoHVA38EqV6V1zjfeM+xkKVgh0/BSjjx2RyBcA4egNweZOdwIAi5j7
 khT42DKtXCPnaq4/uX75q/4T46OrlUXt374oX8nK88ysybqK669YWroC74mEA/0yxXVW
 1K6FGM2+KnsMCOJU5ykWq0NKY15SMJEN7i28qqK3Lwb4pG/gf3Uv12Q1ZA3mfoihCK1D
 zUZiSIBnc2bIf9Xbyukpjd0NtllEod0S+TwiE5k1KX0ufBvCstVnrCDxKYhX6Szp8jZi
 Xq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237113; x=1736841913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEe4v5C9/PWNyByBZmpxPddvBHJdcBQ7qIXflzieNkU=;
 b=Nx7sfTx41T9m1KE71CXzAwmw8tExr7UirVQfDJBV2M1MylFoLvk8535KKpsKSav+4G
 Y3BxAvy4hUxKze7JTufCfWYjI3Oxy2rrp2d+ePgzK2HtwVAGfEoELhz18CMvEH5QZYXt
 6enMz5wcveECIW5oloqixmd8ZHgpOLuG9+qnriOQohqVpNZs+ornB7Bo+B6yb7FGVlGy
 XnhMuUNMaaVd7RRWT/r3Juo0JYrCJd701+EQEPMtJr0Lm0vDHZOYr5KmJ/YLeGr0/X3F
 Lajgo//JgyxmTkv8erllrsZpSgO9rYkc2aZRB8X49y+vLd55/fgzpGko3GjQnVVP2bp5
 K+Ow==
X-Gm-Message-State: AOJu0YykfGlgUWwEAWPLXtU9WprVGv2PUwemDwJDoZG7GLBWSNEl05Go
 74qY3KELDue5a59zAmJyqcWtGpqz5Bf5Tu3CuNjQrSKk7TXJOq3wkQskc4AbGj/6rIPvtSNSJdu
 D
X-Gm-Gg: ASbGncslEPGdCW+vsvoKXG+IcClZ7nEL/geCLAFniTB0X3N272wVkTd+niqO0m75tRD
 wHb4WmqezrIKK8UdwYorksKpSyj1ayKyHAPwXWlHpuWihk85Y5Ns1r+Yh+MGbg27h0qHtkytTJP
 AIx08zuzYNaIsETYwsPOF9qjzMJVJLI66/Jx+oNZoizU0Sa+A9WNbFZYLgmmjUES5a6RidJuT10
 L7RAZxjuDaYjrLES9tmFJ5Fx9EVdWvTqxNMOsgwYbPjdHGuRfM+3iKp76uyMCV7NYTFKXcbUNGb
 Yo1j+x5QcarExSdljQ==
X-Google-Smtp-Source: AGHT+IHcbyGorECF1XBYmxT2GvJr003/2KC/b+ph21jBq5FhHI/CNNVm8sTbzPCHbAFoze0q+FtuFQ==
X-Received: by 2002:a05:6a21:2d09:b0:1e1:6ec8:fc63 with SMTP id
 adf61e73a8af0-1e5e046520fmr93757821637.11.1736237113329; 
 Tue, 07 Jan 2025 00:05:13 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 55/81] tcg: Merge INDEX_op_and_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:46 -0800
Message-ID: <20250107080112.1175095-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h    |  3 +--
 target/sh4/translate.c   |  4 ++--
 tcg/optimize.c           | 40 ++++++++++++----------------------------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 23 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c6977f1030..fda5181cf4 100644
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
index 6b7cf2ca49..79af2c312a 100644
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
@@ -787,9 +788,7 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst) {
-        TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
-                             ? INDEX_op_and_i32 : INDEX_op_and_i64);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
         TCGArg tmp = arg_new_temp(ctx);
 
         op2->args[0] = tmp;
@@ -882,8 +881,8 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
-        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and, 3);
         TCGArg t1 = arg_new_temp(ctx);
         TCGArg t2 = arg_new_temp(ctx);
 
@@ -1694,8 +1693,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     TempOptInfo *t2 = arg_info(op->args[2]);
     int ofs = op->args[3];
     int len = op->args[4];
-    int width;
-    TCGOpcode and_opc;
+    int width = ctx->type == TCG_TYPE_I32 ? 32 : 64;
     uint64_t z_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
@@ -1704,24 +1702,11 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
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
@@ -1731,7 +1716,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     if (ti_is_const_val(t2, 0)) {
         uint64_t mask = deposit64(-1, ofs, len, 0);
 
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[2] = arg_new_constant(ctx, mask);
         return fold_and(ctx, op);
     }
@@ -2282,7 +2267,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2304,7 +2289,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        and_opc = INDEX_op_and_i32;
         sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
@@ -2317,7 +2301,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        and_opc = INDEX_op_and_i64;
         sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
@@ -2356,7 +2339,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
             op2->args[2] = arg_new_constant(ctx, sh);
             src1 = ret;
         }
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[1] = src1;
         op->args[2] = arg_new_constant(ctx, 1);
     }
@@ -2833,7 +2816,8 @@ void tcg_optimize(TCGContext *s)
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
index 2bdf958e61..e77a24adc7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -992,8 +992,7 @@ static const TCGOutOp outop_notreached = {
 static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
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
@@ -5429,8 +5427,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_add:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 662770ef9d..ce7cbe566b 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -545,7 +545,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
-        CASE_32_64(and)
+        case INDEX_op_and:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
             break;
@@ -1139,12 +1139,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
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
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index fe0ad71b57..4830c3b24d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -673,7 +673,7 @@ static const TCGOutOpBinary outop_add = {
 static void tgen_and(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_and_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_and = {
-- 
2.43.0


