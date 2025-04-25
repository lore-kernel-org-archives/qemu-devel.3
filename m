Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2437EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0o-0007I8-7F; Fri, 25 Apr 2025 17:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0m-0007Gw-4E
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0i-0000K8-8G
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:07 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736a72220edso2826976b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618103; x=1746222903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaIjQjWnSKoHULckO21MDpGamfwh7bzBpCPZhEnr3iw=;
 b=MEfSjf6h0h1IG8d2PzvYpTIt3aoZk+zdJ3fZaCQ0nshTW24KYR+PS4Y5Q95pWFQO30
 XVolfOKcaSyxXyhWEHOZcP/7/jx6Zq7WWUAulJwONessz51ikJ5AijQJJOpNvDlJgkuf
 tMyZ9QXrJWPuXT2GmT7fvkhkSYNnXP7qxy72e3TJCW0Ev/o5TCv16YZ/wEbHHeI88tY5
 GiuiT5/d6Sv2elngBlllSsY8Y0B2Zb1XxObJf26FcIWfdC8jvNfdFXLGDjinKlOXcl5c
 /7DsHAEOstGtuWWnsOb7mtJpdAFsR24L3128U1S2kPd7iDeZxdMrNLGUbXku0WvIN1Wr
 /fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618103; x=1746222903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaIjQjWnSKoHULckO21MDpGamfwh7bzBpCPZhEnr3iw=;
 b=KhbEO1tEjgNTNDV7Wtix4P5yNEEyJmeoBsqE8SxisF5WitzzSXCz9y+vHde/2fR36F
 y4bAyBNP31XsYUoKcGNrWN0eEq+jH1YkhZh8oWfXyKgIauKXlFhr7pfFGQm70cLDKuW8
 GkWNRedqMfbo8L2DVCiZLB7c5uEQa95KW44OjALS0tLYeFlNTQEWlEGQ+gzPCs5AEB2u
 QThgaUNjktzlmaEuZgnccisWx0GzXW28FXeH0GAfae9eOajetPc4B4wuDx616CI+yETs
 2hdWl8srI7eGeEuaroXQOreMOxt66D8Js24EMBf0Xp9kwhlY1FdS+XE3XUpybTJTpawc
 8jhw==
X-Gm-Message-State: AOJu0Yy9TWsMg2VGZyfsn1UdHu01U+sRVkwsF3oMZBn8qmsbZASwPr9z
 4uMqlPmiVHdQx0uFugUiE8hs8yhF05WHSrQd1l43TRmRxgkpKKPw/8b+em8UMHBHDiJKRDf99X7
 m
X-Gm-Gg: ASbGnctZ6qsr2bJS/qTDAzwgRCZRDyiMOmYYZxTcHhCz70n8lApYvgoLg6W+8y/Ueko
 wt0wbi2ARtV9kNL+/t4fNLBRLPPJeK5+byk6ZC7ZohBQ9fUXEgF0qpVdhl5GNpa3WoD2XIdtkrh
 y34JQPScVYVKvzM5NH9Oe/FM7d9cGLhaMVGwx+hYgDG6AD6YkHW7vhyUZ9VuxX//4SjiPn9r+x4
 kxc5EsmDkTEf/+oagxZV4My98AgRilgBYNTtmUNVmCeBHDdFmpfs1ZBS0TiSbghhIlWbgk7sK0d
 qHG71wJ7t53l+Xyp2/CIdzn9+JXxdbrQ/y2CR+ZWBGOcAIzh8JkdxlF1X8RLprzY4hfIxv9KdZE
 cFmNh4qlq2g==
X-Google-Smtp-Source: AGHT+IGpv9fCJRajcntippFpUSZQF5r8gMCpbhdezB1cWZxfSNzTemmg40Adl7kmHRwyHddrDof+Sw==
X-Received: by 2002:a05:6a00:2e83:b0:73c:3116:cf10 with SMTP id
 d2e1a72fcca58-73fd9044734mr5113154b3a.23.1745618102740; 
 Fri, 25 Apr 2025 14:55:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 010/159] tcg: Merge INDEX_op_add_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:24 -0700
Message-ID: <20250425215454.886111-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Rely on TCGOP_TYPE instead of opcodes specific to each type.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  4 ++--
 target/sh4/translate.c   |  6 +++---
 tcg/optimize.c           | 13 +++++--------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 15 +++++----------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  6 ++----
 8 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 766fd00d99..0282779468 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -39,6 +39,8 @@ DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 
+DEF(add, 1, 2, 0, TCG_OPF_INT)
+
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
@@ -52,7 +54,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(add_i32, 1, 2, 0, 0)
 DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
@@ -115,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(add_i64, 1, 2, 0, 0)
 DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d796ad52c4..c20204cb52 100644
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
         op_opc = INDEX_op_and_i32;
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
index 8d5bad07aa..a53e4f4675 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -424,7 +424,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     uint64_t l64, h64;
 
     switch (op) {
-    CASE_OP_32_64(add):
+    case INDEX_op_add:
         return x + y;
 
     CASE_OP_32_64(sub):
@@ -2261,7 +2261,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode add_opc, xor_opc, neg_opc;
+            TCGOpcode xor_opc, neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2269,12 +2269,10 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
             switch (ctx->type) {
             case TCG_TYPE_I32:
-                add_opc = INDEX_op_add_i32;
                 neg_opc = INDEX_op_neg_i32;
                 xor_opc = INDEX_op_xor_i32;
                 break;
             case TCG_TYPE_I64:
-                add_opc = INDEX_op_add_i64;
                 neg_opc = INDEX_op_neg_i64;
                 xor_opc = INDEX_op_xor_i64;
                 break;
@@ -2285,7 +2283,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             if (!inv) {
                 op->opc = neg_opc;
             } else if (neg) {
-                op->opc = add_opc;
+                op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
             } else {
                 op->opc = xor_opc;
@@ -2650,8 +2648,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[2])) {
         uint64_t val = arg_info(op->args[2])->val;
 
-        op->opc = (ctx->type == TCG_TYPE_I32
-                   ? INDEX_op_add_i32 : INDEX_op_add_i64);
+        op->opc = INDEX_op_add;
         op->args[2] = arg_new_constant(ctx, -val);
     }
     return finish_folding(ctx, op);
@@ -2842,7 +2839,7 @@ void tcg_optimize(TCGContext *s)
          * Sorted alphabetically by opcode as much as possible.
          */
         switch (opc) {
-        CASE_OP_32_64(add):
+        case INDEX_op_add:
             done = fold_add(&ctx, op);
             break;
         case INDEX_op_add_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 108dc61e9a..344d490966 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -362,7 +362,7 @@ void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
 
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_add_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
 }
 
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1555,7 +1555,7 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_add_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_add, ret, arg1, arg2);
     } else {
         tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 18b2981c79..0f0a3f56d8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1004,8 +1004,7 @@ QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
 
 /* Register allocation descriptions for every TCGOpcode. */
 static const TCGOutOp * const all_outop[NB_OPS] = {
-    OUTOP(INDEX_op_add_i32, TCGOutOpBinary, outop_add),
-    OUTOP(INDEX_op_add_i64, TCGOutOpBinary, outop_add),
+    OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
 };
 
 #undef OUTOP
@@ -2206,6 +2205,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
+    case INDEX_op_add:
     case INDEX_op_mov:
         return has_type;
 
@@ -2220,7 +2220,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
@@ -2304,7 +2303,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_add_i64:
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
@@ -4015,14 +4013,12 @@ liveness_pass_1(TCGContext *s)
             break;
 
         case INDEX_op_add2_i32:
-            opc_new = INDEX_op_add_i32;
+        case INDEX_op_add2_i64:
+            opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
             opc_new = INDEX_op_sub_i32;
             goto do_addsub2;
-        case INDEX_op_add2_i64:
-            opc_new = INDEX_op_add_i64;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
             opc_new = INDEX_op_sub_i64;
         do_addsub2:
@@ -5445,8 +5441,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 78183ea47d..ceb791a735 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -523,7 +523,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (mixed 32/64 bit). */
 
-        CASE_32_64(add)
+        case INDEX_op_add:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
@@ -1082,8 +1082,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), str_r(r1));
         break;
 
-    case INDEX_op_add_i32:
-    case INDEX_op_add_i64:
+    case INDEX_op_add:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index e6ccc78fa1..67387bfddf 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -261,7 +261,7 @@ Arithmetic
 
 .. list-table::
 
-   * - add_i32/i64 *t0*, *t1*, *t2*
+   * - add *t0*, *t1*, *t2*
 
      - | *t0* = *t1* + *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e6ec31e351..726b645da8 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -453,9 +453,7 @@ static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
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
@@ -644,7 +642,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 static void tgen_add(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_add_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_add = {
-- 
2.43.0


