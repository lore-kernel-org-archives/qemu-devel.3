Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4BFC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnsI-0008Rd-4Z; Sun, 16 Feb 2025 18:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqU-0001UD-K6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:42 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnq5-0005TX-AJ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:29 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so3151760a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747650; x=1740352450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hkt/yfLqwDWGhNRmfLFxPrH6YkVf7u86teKQG8WS83I=;
 b=HUg9hGlzBztEksMrRh2nExvt40a13RZuLAQrjCwQRV5a62M/DxRv+GM+cxSy0jWK0R
 0yP4ERsGu2aqB/a/mRZxzlWq7nXVKnkXEOAmaM4elI0nNrw6qjZvo5ZgDh33wcIuLY8g
 4hOQyc83h0zjzLYushekpexsuKNUoJiSDReYl/Oa/Eitl+ssBXvdjVF/SJkb0Lrjv8z9
 Qh7K5AOoEw9dmWT8EJ3cdGLM3Y3wgdFrbuMFnNot1/rFMgp4CCNa7frDd+eyDtStsj+N
 eQxTFuXXjI8FmYrCHxgQAM7jU1qgR6NFBvSaPosdgeWa/iXfQl81sTH8j32CA39tauqb
 hmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747650; x=1740352450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hkt/yfLqwDWGhNRmfLFxPrH6YkVf7u86teKQG8WS83I=;
 b=i/+rPCn5j+UzrHOGPr2ivLrqP7Xb+b7bPoglc5cxyzXsqHPRnVb+i2ELoYNGJzQWS6
 1d95fSYZHrQyZIYL3cZ/u+CQjjLg9mzi2wJkX3X4tu0XOHJGYJYhYw+jQga8X0LWat1s
 ijNAX0VF1a19zyiAE8jaUpGAXdqN4vNNkuH+5aYIhB1YJWG3laFWOxVY9E7+SWKiJrxn
 Pa7IGheN8BZ0N8htX1aj2KIHO6Hux4f34NxZw/m4NozNCnfHY+KinkyJnI4eOt7pFxkp
 DGFyqdEXGvF0CwZlgubSaS4beVxqvxQt4DfW5uj9jV6f4t/ir6ogATw6VoYW0Zv580hT
 38pw==
X-Gm-Message-State: AOJu0YxfEuzOXcUUenjeyBlGrjJpCyvwZGFGeOOVmwqYbpOIBu8CISsc
 jgvR03dEfBROhyHvyNrs2YrPP4tyeHJzDqMEOBiL7L22SDjah9L0O9+aenFQlWmRSZUSoJ+bT2P
 B
X-Gm-Gg: ASbGnctaEdDOv8GGSapp5rNq5zNsjmonl7tktRTSwQ08kyw+8PyDQyZQgGlpzgH4PhW
 TLYN6oQoV5zMdcnbCVhYGYmgz8Ob4c0Zx0F5mQUsp9lOv9Ic8a0DHY55Fg8TaimfOvjfdp91rdG
 gVLepxkTySim34aXs/KD/eTSm9rRdLAC9lVOjIAKW3UFtq4zA703u3TbCOnrLF/yU3/GFxswkBV
 vdMoAMJjYzHT0ZdO5bZhTHu2IHS22snFIs/X0EjJnmYm9OvsVk5tl3gMz1wgSMvrXEZiMU98O6g
 UsWQihfzxePKJFd+OolTBI1xWpf0H5aHwVDYLgxJDxnxacs=
X-Google-Smtp-Source: AGHT+IGahXUiCgCu7Y6AifKYHT/aepnkoGMFhREdZcioFZrO5t9yNhg3xta93/6MadfVvgmphpjjFQ==
X-Received: by 2002:a17:90b:1e08:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-2fc41150587mr11438033a91.35.1739747650448; 
 Sun, 16 Feb 2025 15:14:10 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 076/162] tcg: Merge INDEX_op_{neg}setcond_{i32,i64}`
Date: Sun, 16 Feb 2025 15:08:45 -0800
Message-ID: <20250216231012.2808572-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
index e73942deae..437d318f6b 100644
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
@@ -5062,10 +5056,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
@@ -5482,10 +5474,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


