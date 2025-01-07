Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B4E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bW-00046i-FU; Tue, 07 Jan 2025 03:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4al-0000rR-DD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ac-0003c5-66
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:35 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2164b662090so194920505ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237124; x=1736841924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJA4ke5IKXvzmrgDCk+/I87rcp4R9Hb1bj5ELArWRvs=;
 b=sTEk/O7mfTZUpee9dgbhzKUcw7XKQEIemKcFZ//cvsoy5gISNSFYcQ7Sc/cDSs3V1Z
 oHeSeTk0WXfYa5MBYcZ6ZrfX+1wvBcMTfbxqgjNF/DQ0cs2l2hyJiw/3udQMfo67xBhN
 pR16KhNRJqyOjTYwbySw5ZjxMhKhSKELW74bvbHuHu5FKJrW5Vj/IvFU0O1fm8Hhxiao
 Mn6kzVwiWScrVi5JkXYYJ6IRGhHcPhvPruD9z02IErK05jxl4wLdD/WQk92b6GLABPC7
 FiVUHcWoK/CeHkKQii8lPqAILLoWOfY6iqliFxbpscYD6tWHL7V/VA0LFQpekEmtHmmx
 +1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237125; x=1736841925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJA4ke5IKXvzmrgDCk+/I87rcp4R9Hb1bj5ELArWRvs=;
 b=JhFbx9rbfXp+nBfrRgqiOpuNTHdRHjKFhTOLPYRo6uI8ocs9ylHzMbpkGgosaevrI4
 dQ0gwSSrMJcPfBNR4cDuzkRdXXUf7T3hdXPa3d+MMxb/QmWjK19+MN26ToelLQEKTqMB
 P2gj/63nH97ULmWv9bBeT9vb8n1bThphxFSyN47CfM32XkUqgEdj6Ka4LOrsv3f1bNPc
 tWqbgcjEO3BkH5dAQehxW9S214zPtmFs3FqnK9fuiqUOB3+vYvuCJCDkGe5W3GhwyvSL
 yuhisimQlwisShJQTfWWl13giXFXg9XUiauj1jw5DfL5zCWmVXtlUkaPWFHKg8k2/c+d
 1M5g==
X-Gm-Message-State: AOJu0YwIx9smL6kIiQM+r6YSjKZmA0DMKi3tjemwJcAwoqBm67o8yogy
 jQDn86/ZW+ckjAGbMRi9om3aL5GMHGn190XLDoL4xSPQkmk+/yrh0mZQiXynYFla5A6WnjKQbfu
 0
X-Gm-Gg: ASbGncsfJQaR7MzHpdxCUOHKGj+PXKFUjp5Gjkr36qvFe0Q+JeABMlSfIgN4LDUq4uk
 k7BxcvUaVkCQLWAYuARHlZcihMnRPzKAgJFdXxDiiS+Fr6OUdTqYuGI90/L57kYoJKCNV3OqgYm
 y/jtODaagJ/8WG52aMWlSsEde4F8MbbFJVVhhb7TiQb/1ybTzcY5gN4GdOQ2eNVD0aAnmfp8HwI
 PqIsVBTq65gU8bpDoay3Ft2KvaYR+SJ3dTrw+t5W3Ed+NQSnajUsqkZkRM3TKzHoP9VyU54rx5P
 HYcAILaJol/7WHVwDQ==
X-Google-Smtp-Source: AGHT+IEs+hbPa/3p+M2Zz4QGsL/Lg0qKojTLoCx/1JGx1jHZ/nLM/3cuu7XULt/U9fzB8wHEzDOV0g==
X-Received: by 2002:a05:6a00:21c2:b0:725:e4b9:a600 with SMTP id
 d2e1a72fcca58-72abdeaae11mr88798128b3a.16.1736237124605; 
 Tue, 07 Jan 2025 00:05:24 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 66/81] tcg: Merge INDEX_op_xor_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:57 -0800
Message-ID: <20250107080112.1175095-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/sh4/translate.c   |  6 +++---
 tcg/optimize.c           | 18 ++++++++----------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index bd9fa7a35e..4db374e03a 100644
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
index 17e09f3d2a..5cb9ba9434 100644
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
index 39b72e8738..583c4363da 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -429,7 +429,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_or_vec:
         return x | y;
 
-    CASE_OP_32_64_VEC(xor):
+    case INDEX_op_xor:
+    case INDEX_op_xor_vec:
         return x ^ y;
 
     case INDEX_op_shl_i32:
@@ -2274,7 +2275,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode xor_opc, neg_opc;
+            TCGOpcode neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2283,11 +2284,9 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
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
@@ -2299,7 +2298,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
             } else {
-                op->opc = xor_opc;
+                op->opc = INDEX_op_xor;
                 op->args[2] = arg_new_constant(ctx, 1);
             }
             return -1;
@@ -2310,7 +2309,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode xor_opc, neg_opc, shr_opc;
+    TCGOpcode neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2332,7 +2331,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
@@ -2343,7 +2341,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
@@ -2391,7 +2388,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_xor, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
@@ -3043,7 +3040,8 @@ void tcg_optimize(TCGContext *s)
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
index 2e068299ff..b93e68fb12 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -996,8 +996,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
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
@@ -5427,8 +5425,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index 97d86c8348..2a1ae3ec42 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -553,7 +553,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
-        CASE_32_64(xor)
+        case INDEX_op_xor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
@@ -1139,12 +1139,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
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
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ba93a56409..628db04e0c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -709,7 +709,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_xor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
-- 
2.43.0


