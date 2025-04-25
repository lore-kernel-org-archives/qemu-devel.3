Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97617C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R12-0007YO-Bf; Fri, 25 Apr 2025 17:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0u-0007Rs-Mw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0r-0000Xf-S9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:16 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2699205b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618112; x=1746222912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtGbIUCZnHKa1iffT33ZLsfWkyAb7Wj0qqI5fHLpxLE=;
 b=ZRG9AuBTBSrOsnt4R3YkJkrpnjFrS9vAoejkwG43LgdLg3sFcUIyrRr4OXzRaRvhDu
 UWrDW2J/XzDbiTdRKRDP1HqxKhwBcol5E94Qe90FDwzNtYPEXO/BBwxYb/jfRuvhd+8l
 +wtLrUc4cu5J9NUxegYcFp1gpJh6jJzCslqKMlD+x5BX11Zd9Pe8Ya5O3T20hE8u3vca
 qaI5YDn7pZZ8id2AT6SxuR9EwIsPGPBcFu0YaYBS6fyKdJnqkqPOrLMJifLjHQ12BkKH
 dBAai9oRHmoKQ2wFYsi1IeRzYjphN2CkZ3qFlsO3ZoRhQPxY6jRiVUNpWmxXNQJZuljv
 1wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618112; x=1746222912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtGbIUCZnHKa1iffT33ZLsfWkyAb7Wj0qqI5fHLpxLE=;
 b=JarHJ2zcONqqVlDvE776gf4puF/+edl9xqlFpbqjHYpG0tChSzRpd1LiP071sluh8b
 srqp/E5QTOxEGcn+4Tpp7BxlFnDAu1s3atr1d/4TE52YKz2/AZ3yIVbP8a29oonyIH7L
 kuuZGFvYbrteawTglja/D0O+x1UeLliSmIUwI04tlK5R+yD8qBrARI/9SjrLvh18i8z3
 Ry+rCH6f1UWoCtWQzEX0upT1a7ADzPeoj7A5aaDhceaJYl/Mu2mrYENH8rcCT6p+TCl9
 V+5nKQcUkLTchwdYAVHcPHxR8QAfdbpnE7X7XqG9ltlQFM9ipbf+qi5y2/mQAH6QDMaQ
 JZYQ==
X-Gm-Message-State: AOJu0Yzsvp7PMEV32YwXaxbmIh9gOvAdBX6Nu1lBKnddV+B6fxf794/D
 dVULOqtrQ+ELkxrbUNyYYub+umS4vZJV2p7QCLuXzLc4d9G6ocT9kBRnUxvl7DjpQI4ZFnIZkhc
 E
X-Gm-Gg: ASbGnct1zViafxG226+PD7A5Ar4E0pbNqApzTN6NX2d3lCRDzD/Jj16fgiIaYou8okx
 A7otIopqm1Fn299opjgU4Ho2C6Jx858nMIIv/OhhYZ0PN5+25cCdAqo3LO4gIsnPfcJszCjVbUs
 BzgyYQtN9iux7pffjJJs8nmyySH6/jAQDdxIScexi5eRNmDBe9msvrNXBo5Fc9AX2xu2waWfiuk
 eo4Bojsjw0rE2p0zvRlPPhQdCInsYp8wHmOD16hGcBvQpF/jj+9RQYpoTgaj5AoH0W2A5W4euU6
 DKLe7tn7scMxeuYH4d6wN7hlmInjEL+4ULNpxzDJBShbWlR8MtuAKIvFpaZdgiD4ccRbt3ogZGI
 =
X-Google-Smtp-Source: AGHT+IFidcXblSJE/0iVHQMgnqZ62sLz4SQyw021yvF7/UXgkwsZ9WxDjpMiO3IRDR2QjezeL1Lf5g==
X-Received: by 2002:a05:6a00:14c6:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-73ff7390b87mr1428183b3a.20.1745618112347; 
 Fri, 25 Apr 2025 14:55:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 023/159] tcg: Merge INDEX_op_xor_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:37 -0700
Message-ID: <20250425215454.886111-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 target/sh4/translate.c   |  6 +++---
 tcg/optimize.c           | 18 ++++++++----------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 8 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index caf0f01042..8f6115bedb 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -66,7 +67,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -124,7 +124,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 094613d312..8248648c0c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1946,7 +1946,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_and;
         goto do_reg_op;
     case 0x200a: /* xor Rm,Rn */
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         goto do_reg_op;
     case 0x200b: /* or Rm,Rn */
         op_opc = INDEX_op_or;
@@ -1976,7 +1976,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
             goto fail;
         }
         op_dst = B11_8;
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         op_arg = tcg_constant_i32(-1);
         break;
 
@@ -2133,7 +2133,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_xor_i32:
+    case INDEX_op_xor:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5f0ab354d6..9303bb5b64 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -441,7 +441,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_or_vec:
         return x | y;
 
-    CASE_OP_32_64_VEC(xor):
+    case INDEX_op_xor:
+    case INDEX_op_xor_vec:
         return x ^ y;
 
     case INDEX_op_shl_i32:
@@ -2289,7 +2290,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode xor_opc, neg_opc;
+            TCGOpcode neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2298,11 +2299,9 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             switch (ctx->type) {
             case TCG_TYPE_I32:
                 neg_opc = INDEX_op_neg_i32;
-                xor_opc = INDEX_op_xor_i32;
                 break;
             case TCG_TYPE_I64:
                 neg_opc = INDEX_op_neg_i64;
-                xor_opc = INDEX_op_xor_i64;
                 break;
             default:
                 g_assert_not_reached();
@@ -2314,7 +2313,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
             } else {
-                op->opc = xor_opc;
+                op->opc = INDEX_op_xor;
                 op->args[2] = arg_new_constant(ctx, 1);
             }
             return -1;
@@ -2325,7 +2324,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode xor_opc, neg_opc, shr_opc;
+    TCGOpcode neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2347,7 +2346,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
@@ -2358,7 +2356,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
@@ -2406,7 +2403,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
-        op2 = opt_insert_after(ctx, op, xor_opc, 3);
+        op2 = opt_insert_after(ctx, op, INDEX_op_xor, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
@@ -3051,7 +3048,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sub2):
             done = fold_sub2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(xor):
+        case INDEX_op_xor:
+        case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
             break;
         case INDEX_op_set_label:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bf481060fa..b10f61435c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,7 +453,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_xor_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
 }
 
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1595,7 +1595,7 @@ void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_xor_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 042f177966..3c4905aa68 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,8 +1009,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_xor_i32, TCGOutOpBinary, outop_xor),
-    OUTOP(INDEX_op_xor_i64, TCGOutOpBinary, outop_xor),
+    OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
 #undef OUTOP
@@ -2215,6 +2214,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_and:
     case INDEX_op_mov:
     case INDEX_op_or:
+    case INDEX_op_xor:
         return has_type;
 
     case INDEX_op_setcond_i32:
@@ -2231,7 +2231,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2308,7 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -5442,8 +5440,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 68636e70da..cb300c4846 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -543,7 +543,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
-        CASE_32_64(xor)
+        case INDEX_op_xor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
@@ -1083,12 +1083,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_xor:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c5c5a4d19e..a4aa4f8824 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -311,7 +311,7 @@ Logical
 
      - | *t0* = *t1* | *t2*
 
-   * - xor_i32/i64 *t0*, *t1*, *t2*
+   * - xor *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ^ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 85caff300f..0a912744b3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -687,7 +687,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_xor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
-- 
2.43.0


