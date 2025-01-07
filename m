Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6319DE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4ba-0004e6-8Y; Tue, 07 Jan 2025 03:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ax-0001oV-Sd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:48 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ap-0003gF-8j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:47 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso214607305ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237138; x=1736841938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9jeBfF8mo0TOCuj7YpNgpjnk7h7kgjhekHIytAbTK8=;
 b=IPbzsrjOltjWoqrV+KesgHixvAcRSpVcE6slFyDbjU+kPk8pSQPJQd7qIDjFs428xl
 UHUoSNFwCfKk0ihkez53dTwda/Tpnu7KrVlWWSgKpDEdJz16tgQQF0+KGMXdfg9XV7ie
 Nn6oMTsbdR3cHWLYrF/eF62WCGRJ9c0J8kg9zC7bZFa+qbBN3kKO4wUkBw2+X4TrosyW
 EdY3BneK2eX24mxk873LB/e8YHuRjo0c4W66J9pae6xfUwpFqbu+GgHTgp0t13uJVdO/
 q1oSb3mTu4VOZjttmvW3Tc627+ikFwG7mWaSajJwEYdTphKUxL79c9ja2kYXliz7ucUN
 NEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237138; x=1736841938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9jeBfF8mo0TOCuj7YpNgpjnk7h7kgjhekHIytAbTK8=;
 b=dyCQNig6nKnM9ycS26aOCEXerlJhV5l5zMjT8OGtBn9eMkuB8hAULzwKSKEagGa+an
 ubBZodjHQILZz+ztsrK5NCkWEZ9eLMy2SCCFQnKZTohU7xxMpn/9mbxkPl9AZcC8mHS9
 BZTByUekXmRDxAuB/fR2OrSG/IHmeoyglJcFx5jpAslBKGqhLq9VHrKZXuHyIITxzGRG
 yXo+qz+Y3BwUSZvFq2RdzDBQU73ydsJag1yLd59bLrVfmnLuK+EcTH5k02UoBumpCf4L
 hjhBaxq7h5uVUcU5qwUDDzI67jRsfw8jMaDGw0dD1wcm83RuTAthzR+Ey+HVc41ja+T7
 ABew==
X-Gm-Message-State: AOJu0YzMRKUFnruYsmIEjC6RDOQ0qJEeWLLMbCPxir+3STwxbmWtZjeq
 eE1YV05y8hx9Yn3ou/p5tYR2UFtA7HV3AJ+rsgFGy/dfkyuLSsmfFWWfS278/efAuYd5lmMt0JR
 Q
X-Gm-Gg: ASbGncvBAxOh8sFxZlq+BrSvGotiZhRXwXwPkMJG9Re+GKNJOdCwxLO95Z/AFwfTuC2
 5IB3br1uUG8lgc2A0tyi8Bv4ZKY6/aDyzkR+OJEnmbiDKwhZK/jicL6Yrx03JY9d8C/o4C21OHI
 PKbwXJPXd6TNTdnBIb+W3stjgnHkjIsvdM8eG/oqMY+058kzB/gTac/hQ42Qj7Wj/QaGww33r0i
 ZeBTkeCY0Fl6sqLZOCKWbm79zeH9SyJy1xehY0KcQI5j8zrRPBZvH0/5dkH2OZ0Y5h+vQtaljr2
 WqDLQIH3mw6vj+TXow==
X-Google-Smtp-Source: AGHT+IGk43EqioZiSNQzMMP13qCg8vhlcelMZ+S2qIAqdYpwY8JcEZZHN9ppfDjxra+l+ScCi2xo7g==
X-Received: by 2002:a05:6a20:4328:b0:1e0:ca1c:8581 with SMTP id
 adf61e73a8af0-1e5e04a29aamr96451449637.21.1736237137887; 
 Tue, 07 Jan 2025 00:05:37 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 79/81] tcg: Merge INDEX_op_neg_{i32,i64}
Date: Tue,  7 Jan 2025 00:01:10 -0800
Message-ID: <20250107080112.1175095-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 30 ++++++------------------------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++++------
 tcg/tci/tcg-target.c.inc |  2 +-
 6 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 69fa55f3c6..9e148bb1b2 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
+DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
-DEF(neg_i32, 1, 1, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -145,7 +145,6 @@ DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
-DEF(neg_i64, 1, 1, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2acff375b7..63d36afe69 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -466,7 +466,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64_VEC(not):
         return ~x;
 
-    CASE_OP_32_64(neg):
+    case INDEX_op_neg:
         return -x;
 
     case INDEX_op_andc:
@@ -2299,25 +2299,12 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode neg_opc;
-
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
             }
 
-            switch (ctx->type) {
-            case TCG_TYPE_I32:
-                neg_opc = INDEX_op_neg_i32;
-                break;
-            case TCG_TYPE_I64:
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
                 op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
@@ -2333,7 +2320,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode neg_opc, shr_opc;
+    TCGOpcode shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2356,7 +2343,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         shr_opc = INDEX_op_shr_i32;
-        neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = INDEX_op_extract_i32;
         }
@@ -2366,7 +2352,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         break;
     case TCG_TYPE_I64:
         shr_opc = INDEX_op_shr_i64;
-        neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = INDEX_op_extract_i64;
         }
@@ -2417,7 +2402,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_neg, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
     }
@@ -2629,11 +2614,8 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
 
     switch (ctx->type) {
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
@@ -2983,7 +2965,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
-        CASE_OP_32_64(neg):
+        case INDEX_op_neg:
             done = fold_neg(&ctx, op);
             break;
         case INDEX_op_nor:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 15faf4dc57..cb2eb9ae52 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -396,7 +396,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
+    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
 }
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -1691,7 +1691,7 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
     } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2bbc4297c9..e7e8232219 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,8 +1009,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_neg_i32, TCGOutOpUnary, outop_neg),
-    OUTOP(INDEX_op_neg_i64, TCGOutOpUnary, outop_neg),
+    OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
@@ -5456,8 +5455,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 1e176f03ee..b091dde7c8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -577,6 +577,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
+        case INDEX_op_neg:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = -regs[r1];
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -707,10 +711,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ~regs[r1];
             break;
 #endif
-        CASE_32_64(neg)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = -regs[r1];
-            break;
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
@@ -1110,6 +1110,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_mov:
+    case INDEX_op_neg:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -1119,8 +1120,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap64_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 45115d7e82..bb9dcbb75d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -753,7 +753,7 @@ static const TCGOutOpBinary outop_xor = {
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, glue(INDEX_op_neg_i,TCG_TARGET_REG_BITS), a0, a1);
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
 }
 
 static const TCGOutOpUnary outop_neg = {
-- 
2.43.0


