Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A3AC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m1I-0002lU-AQ; Tue, 15 Apr 2025 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyN-0005e2-8C
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyG-0000xU-H3
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:29:30 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so4930499a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745362; x=1745350162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u+FG8kGDibyf2ItPqkoMa6uS8D9Wg8kxexWPr8XfGhI=;
 b=xZKcJnTLTocvIVwQVQolyHqg6LkHTG8MWoRN1C+RhPXX3FJF/PdRh5exn0NaFQMCZd
 Trh2uQzXU+9BmWZAAjTrJLfeZ5tk2Y3orD+P0aCGLMPmieWRJVu1ZP00bKnPzzych4x1
 +Q/76CC4B818n1Ran7V76kGkQ7BlMLsWOuaAnk5ADHEUtbHC/MubCnjKCpw3jJShsRve
 gWhd9veNvXkdMTsnTL1EtBlZQSrx6y4pmqDqNKhC7ex+mBMf2F55TkoJIM/ivjd5QwP+
 2uQD/SZsvXTxLNpIXaPF4/mW3LVl5Aqt7OuFeYj1ze5/lPWiDT2TVW3TyjVDcQqeOdkN
 DhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745362; x=1745350162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+FG8kGDibyf2ItPqkoMa6uS8D9Wg8kxexWPr8XfGhI=;
 b=lTHdLYLZifGbTDda7EHVPDRuE26VD0J0qzZsqJ9Vrl4uoX1LaZXkn7DC4VBBE0STZJ
 gPb/iSgTPI4+cSOQk5jHqpc6ypWD1BMiMF/NjUA0H++MDoyvqUBLx66dQ+WOyjBhHvKz
 flk793dThtcoqq3f9N7BJmBTGCAKtDC1dQ90+GiOv0OXu2wXOVD0GoXxdO1gcjWxYwD0
 /SWArzGrRC6vdp+C7kxZHE19lBOntSH2Q1iHzMlie+MjkvSqs+60FjBbRlQvOoD5uqKS
 TJU0COomin073QcPC9hdET6y+KO0U5THhAVQnlasd3E7OYC5ER5bQlENrbSOU8TXujxH
 xJoQ==
X-Gm-Message-State: AOJu0YwMN/DjWFChE/KvyIIKDGfMGU9j2CkEnZwSTmKusKskIoni4Bbk
 hkf1LsJ2txTBng5GV3A+bGpa/F4Sid9s4M9Mow4CqJaKtlwDcvn4JE3hC7evoNugEq2Ps8U4nCC
 /
X-Gm-Gg: ASbGncu/qPjm9XI4NM6jZ6/pSka3VTDtskJ+Ii7dJvaYj6Y8jjaTvJ9n+DWBQMzrh2q
 1jZET07z7sLUVaTXCkTptXcgne8efXxk4IgU2aCBaJJiMW5M5AMLvznQTwmIi1NPNug5b2wAsLH
 0m1ahqowYwuPcR/o5VMH3ULJ+KbufqVgRKG4iH5abbFfLTcXiTqDDQX17Br6ZvKcCZLq+gduX0N
 iHwGGdozM4o37B2m0apBxf4ZVGrcYJ1Z/Ii2KEy2uvrwy9AURbtP0mR6K4N1KmINwesYQ5qo7bS
 HuyxCWE0LMuk2QCL/MaBMb4GZJdozza9DxiDKqM/qEfaRf3ZtDGhczmx3RjfmVwjd7m5X6W/YEG
 glO/UeZfd1g==
X-Google-Smtp-Source: AGHT+IFK5L2I9qNTalq7O8fqdgtga1CFaqC4vq7tT+qY8pzfk9sfQSs0LsW5AsMbuwyCRmQeNcFusg==
X-Received: by 2002:a17:90b:3c0e:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-3085ef5321emr608998a91.33.1744745362000; 
 Tue, 15 Apr 2025 12:29:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 077/163] tcg: Merge INDEX_op_{neg}setcond_{i32,i64}`
Date: Tue, 15 Apr 2025 12:23:48 -0700
Message-ID: <20250415192515.232910-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 include/tcg/tcg-opc.h        |  6 ++----
 target/sh4/translate.c       |  6 +++---
 tcg/optimize.c               | 32 ++++++++------------------------
 tcg/tcg-op.c                 |  8 ++++----
 tcg/tcg.c                    | 30 ++++++++++--------------------
 tcg/tci.c                    | 14 +++++++-------
 docs/devel/tcg-ops.rst       |  4 ++--
 tcg/tci/tcg-target-opc.h.inc |  1 +
 tcg/tci/tcg-target.c.inc     |  4 ++--
 9 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 287bdf3473..f40bb5796a 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -57,6 +57,7 @@ DEF(mulu2, 2, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
+DEF(negsetcond, 1, 2, 1, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(not, 1, 1, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
@@ -66,13 +67,12 @@ DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
+DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
-DEF(setcond_i32, 1, 2, 1, 0)
-DEF(negsetcond_i32, 1, 2, 1, 0)
 DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
@@ -99,8 +99,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 
-DEF(setcond_i64, 1, 2, 1, 0)
-DEF(negsetcond_i64, 1, 2, 1, 0)
 DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5cb9ba9434..2ef48b1d17 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1995,7 +1995,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if ((ld_dst == B11_8) + (ld_dst == B7_4) != 1 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_setcond_i32;  /* placeholder */
+        op_opc = INDEX_op_setcond;  /* placeholder */
         op_src = (ld_dst == B11_8 ? B7_4 : B11_8);
         op_arg = REG(op_src);
 
@@ -2030,7 +2030,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         if (ld_dst != B11_8 || ld_dst != B7_4 || mv_src >= 0) {
             goto fail;
         }
-        op_opc = INDEX_op_setcond_i32;
+        op_opc = INDEX_op_setcond;
         op_arg = tcg_constant_i32(0);
 
         NEXT_INSN;
@@ -2147,7 +2147,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond:
         if (st_src == ld_dst) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9acf63e4cd..4b78b0ba82 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1984,35 +1984,19 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     if (ti_is_const(tt) && ti_is_const(ft)) {
         uint64_t tv = ti_const_val(tt);
         uint64_t fv = ti_const_val(ft);
-        TCGOpcode opc, negopc;
         TCGCond cond = op->args[5];
 
-        switch (ctx->type) {
-        case TCG_TYPE_I32:
-            opc = INDEX_op_setcond_i32;
-            negopc = INDEX_op_negsetcond_i32;
-            tv = (int32_t)tv;
-            fv = (int32_t)fv;
-            break;
-        case TCG_TYPE_I64:
-            opc = INDEX_op_setcond_i64;
-            negopc = INDEX_op_negsetcond_i64;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
         if (tv == 1 && fv == 0) {
-            op->opc = opc;
+            op->opc = INDEX_op_setcond;
             op->args[3] = cond;
         } else if (fv == 1 && tv == 0) {
-            op->opc = opc;
+            op->opc = INDEX_op_setcond;
             op->args[3] = tcg_invert_cond(cond);
         } else if (tv == -1 && fv == 0) {
-            op->opc = negopc;
+            op->opc = INDEX_op_negsetcond;
             op->args[3] = cond;
         } else if (fv == -1 && tv == 0) {
-            op->opc = negopc;
+            op->opc = INDEX_op_negsetcond;
             op->args[3] = tcg_invert_cond(cond);
         }
     }
@@ -2514,14 +2498,14 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     do_setcond_low:
         op->args[2] = op->args[3];
         op->args[3] = cond;
-        op->opc = INDEX_op_setcond_i32;
+        op->opc = INDEX_op_setcond;
         return fold_setcond(ctx, op);
 
     do_setcond_high:
         op->args[1] = op->args[2];
         op->args[2] = op->args[4];
         op->args[3] = cond;
-        op->opc = INDEX_op_setcond_i32;
+        op->opc = INDEX_op_setcond;
         return fold_setcond(ctx, op);
     }
 
@@ -3013,10 +2997,10 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_shr:
             done = fold_shift(&ctx, op);
             break;
-        CASE_OP_32_64(setcond):
+        case INDEX_op_setcond:
             done = fold_setcond(&ctx, op);
             break;
-        CASE_OP_32_64(negsetcond):
+        case INDEX_op_negsetcond:
             done = fold_negsetcond(&ctx, op);
             break;
         case INDEX_op_setcond2_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 413b68352d..477dfc25b7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -552,7 +552,7 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
     } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond_i32, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
     }
 }
 
@@ -570,7 +570,7 @@ void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i32(ret, 0);
     } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     }
 }
 
@@ -1911,7 +1911,7 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                              TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
             tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         } else {
-            tcg_gen_op4i_i64(INDEX_op_setcond_i64, ret, arg1, arg2, cond);
+            tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
         }
     }
 }
@@ -1948,7 +1948,7 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_movi_i64(ret, 0);
     } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
+        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
     } else {
         tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a65c44c679..f51f727618 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1055,8 +1055,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
-    OUTOP(INDEX_op_negsetcond_i32, TCGOutOpSetcond, outop_negsetcond),
-    OUTOP(INDEX_op_negsetcond_i64, TCGOutOpSetcond, outop_negsetcond),
+    OUTOP(INDEX_op_negsetcond, TCGOutOpSetcond, outop_negsetcond),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_not, TCGOutOpUnary, outop_not),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
@@ -1066,8 +1065,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
-    OUTOP(INDEX_op_setcond_i32, TCGOutOpSetcond, outop_setcond),
-    OUTOP(INDEX_op_setcond_i64, TCGOutOpSetcond, outop_setcond),
+    OUTOP(INDEX_op_setcond, TCGOutOpSetcond, outop_setcond),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -2275,12 +2273,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_negsetcond:
     case INDEX_op_or:
+    case INDEX_op_setcond:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
     case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
@@ -2311,8 +2309,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
     case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
@@ -2864,14 +2860,12 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             }
             switch (c) {
             case INDEX_op_brcond_i32:
-            case INDEX_op_setcond_i32:
-            case INDEX_op_negsetcond_i32:
+            case INDEX_op_setcond:
+            case INDEX_op_negsetcond:
             case INDEX_op_movcond_i32:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
             case INDEX_op_brcond_i64:
-            case INDEX_op_setcond_i64:
-            case INDEX_op_negsetcond_i64:
             case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
@@ -5065,10 +5059,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_brcond_i64:
         op_cond = op->args[2];
         break;
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
     case INDEX_op_cmp_vec:
         op_cond = op->args[3];
         break;
@@ -5491,10 +5483,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i32:
-    case INDEX_op_negsetcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_negsetcond:
         {
             const TCGOutOpSetcond *out =
                 container_of(all_outop[op->opc], TCGOutOpSetcond, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 569b5c7ed0..d97ca1fade 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -438,10 +438,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_l(insn, tb_ptr, &ptr);
             tb_ptr = ptr;
             continue;
-        case INDEX_op_setcond_i32:
-            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
-            regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
-            break;
         case INDEX_op_movcond_i32:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
             tmp32 = tci_compare32(regs[r1], regs[r2], condition);
@@ -455,7 +451,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = tci_compare64(T1, T2, condition);
             break;
 #elif TCG_TARGET_REG_BITS == 64
-        case INDEX_op_setcond_i64:
+        case INDEX_op_setcond:
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
             break;
@@ -628,6 +624,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tmp32 = regs[r1];
             regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
             break;
+        case INDEX_op_tci_setcond32:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
+            break;
 
             /* Shift/rotate operations. */
 
@@ -971,8 +971,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                            op_name, str_r(r0), ptr);
         break;
 
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
+    case INDEX_op_setcond:
+    case INDEX_op_tci_setcond32:
         tci_args_rrrc(insn, &r0, &r1, &r2, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1), str_r(r2), str_c(c));
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 592e002971..d3283265cd 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -499,13 +499,13 @@ Conditional moves
 
 .. list-table::
 
-   * - setcond_i32/i64 *dest*, *t1*, *t2*, *cond*
+   * - setcond *dest*, *t1*, *t2*, *cond*
 
      - | *dest* = (*t1* *cond* *t2*)
        |
        | Set *dest* to 1 if (*t1* *cond* *t2*) is true, otherwise set to 0.
 
-   * - negsetcond_i32/i64 *dest*, *t1*, *t2*, *cond*
+   * - negsetcond *dest*, *t1*, *t2*, *cond*
 
      - | *dest* = -(*t1* *cond* *t2*)
        |
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 2bb346f4c8..27b4574e4f 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -10,3 +10,4 @@ DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
 DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1b75aba698..d49c767de5 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -942,8 +942,8 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGReg dest, TCGReg arg1, TCGReg arg2)
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
-                     ? INDEX_op_setcond_i32
-                     : INDEX_op_setcond_i64);
+                     ? INDEX_op_tci_setcond32
+                     : INDEX_op_setcond);
     tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
 }
 
-- 
2.43.0


