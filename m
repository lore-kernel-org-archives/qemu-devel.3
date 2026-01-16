Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F778D4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgac3-0000ZM-S2; Thu, 15 Jan 2026 22:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgac0-0000W8-VU
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:00 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaby-0005uk-I0
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:00 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f3d6990d6so914621b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534497; x=1769139297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V606qWDykwCVpb/3iOpNOphjhPCSJtqkWo8JNzY5dBc=;
 b=Oyze8G8nAXOHgAZHPytIlzaUvqjy63iTbh1sLwB4x5RgK0tRmt7o5ic6IzfM2o1j2V
 G5Bz3/DGikA984/PwsuUbo0uldS7tn8rd/jyOEeFc0hy8L6AajFtbbvcVIpimfE7gocG
 JOei3+wLtO2ZI+OnkGO0LGy2M4xp3mH22BSE03PPHVVpqM1LH9m/GRiK08JaeXscI4ua
 9iRoNYnaLyKTZ3my6JSf9UzUoO8NnfJU4Q9XXC1uWvywn7ajoUmKpXaqg00ZlhURjeUy
 erIohYPK/7zpyrvZBaY6HFQ2JIeAbhYz8bE1JavnkS2sTB24eP462bDDJTm7ZKuakFPb
 Z40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534497; x=1769139297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V606qWDykwCVpb/3iOpNOphjhPCSJtqkWo8JNzY5dBc=;
 b=Cin4rAfvA/Z0wstcAsu02aog9NqQ2l3mGj/nkqbxnmLsgxfS9xJgrvkJXbKj3H6O0E
 5FIeyl4c/fVXdns56KL6lsoWu9ja5w4Ljh/tJl2X16v1RKsKw2v8yBfO9bsY7Mcff8sx
 ReEYFPG8BHtqyIw703WG0udObvKinjR6wSbQkLTPUVhYwBy/N2sFpEU7ipnUvdjaQX45
 bzfKZ6E8W9VtztRbOTq2uhoxIREVsSGC+laO0tq06k2qIJCUgHTD3KDnb+FE45m0nWUU
 iIMSXB+QEsoGKzEP1QM8zKp2KRWtMkqPZjUzkLEm1Cm6umaV6MdTLjCwjUlsoU6VbTg1
 ugdA==
X-Gm-Message-State: AOJu0YzCcrRuo+iRsvNl9UfiYHcaAuRv1voQn4MvSx8QaGOcfHRCf1oW
 9bJ/Men2nNpv2yk3kJbkv/4Rq445J9628tWMeOlGjfhtPl0+nkykEp//J+WfA7YkGJY213xelVn
 7OZGdiDCHWw==
X-Gm-Gg: AY/fxX6Gmzx8godC+xW89gwuHSavU+RkPlcvAkqRrI2P1AvwMd0cGKO7MSIx5PvOYPC
 sPuwnEta65lwZb5fP0w5KQXCb2BnuQh2CbfiGsXUcHP45tb1yjCMEuTmVoDFczSOQ34Vqb6pFEw
 T1AatCqSsBwi0OU5uEB9xD3BeBkuX+At8vacvEsTWx/fMhm++7+1rnRb2qO4K5xmpe+JDQpbHSb
 8gEA7OhzKfzY0iwdA1LbfHs4a8jytrN1BSfbWulXiEX4Sukrn07AaroqWqYBnC/7E2eYnZIa5eW
 dJw/9wNFgbLbyryPLjCh/vVtXPXpoLd86DP4/Ca7XepMTKNVizeDysBDK5Gs0H4TSsx2rlwQYWd
 HArO6+dj99DsdoeoVjQFj8MkbTktD5odjd26SgRRW8l8escvzmwq8kAeknwcSYI5k0O6jGJVJ5w
 M44uEzZXnxw205ylJ8Ug==
X-Received: by 2002:a05:6a00:22cc:b0:81f:3afe:2824 with SMTP id
 d2e1a72fcca58-81f9fce5d63mr1673419b3a.24.1768534496906; 
 Thu, 15 Jan 2026 19:34:56 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 26/58] tcg: Remove INDEX_op_brcond2_i32
Date: Fri, 16 Jan 2026 14:32:32 +1100
Message-ID: <20260116033305.51162-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This opcode was exclusively for 32-bit hosts.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  1 -
 tcg/optimize.c           | 99 ----------------------------------------
 tcg/tcg-op.c             | 32 ++-----------
 tcg/tcg.c                | 34 --------------
 docs/devel/tcg-ops.rst   |  7 +--
 tcg/tci/tcg-target.c.inc | 17 -------
 6 files changed, 4 insertions(+), 186 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index e988edd93a..55283af326 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -103,7 +103,6 @@ DEF(subb1o, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
 DEF(subbi, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN)
 DEF(subbio, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_IN | TCG_OPF_CARRY_OUT)
 
-DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5ae26e4a10..a544c055b8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1597,102 +1597,6 @@ static bool fold_brcond(OptContext *ctx, TCGOp *op)
     return true;
 }
 
-static bool fold_brcond2(OptContext *ctx, TCGOp *op)
-{
-    TCGCond cond;
-    TCGArg label;
-    int i, inv = 0;
-
-    i = do_constant_folding_cond2(ctx, op, &op->args[0]);
-    cond = op->args[4];
-    label = op->args[5];
-    if (i >= 0) {
-        goto do_brcond_const;
-    }
-
-    switch (cond) {
-    case TCG_COND_LT:
-    case TCG_COND_GE:
-        /*
-         * Simplify LT/GE comparisons vs zero to a single compare
-         * vs the high word of the input.
-         */
-        if (arg_is_const_val(op->args[2], 0) &&
-            arg_is_const_val(op->args[3], 0)) {
-            goto do_brcond_high;
-        }
-        break;
-
-    case TCG_COND_NE:
-        inv = 1;
-        QEMU_FALLTHROUGH;
-    case TCG_COND_EQ:
-        /*
-         * Simplify EQ/NE comparisons where one of the pairs
-         * can be simplified.
-         */
-        i = do_constant_folding_cond(TCG_TYPE_I32, op->args[0],
-                                     op->args[2], cond);
-        switch (i ^ inv) {
-        case 0:
-            goto do_brcond_const;
-        case 1:
-            goto do_brcond_high;
-        }
-
-        i = do_constant_folding_cond(TCG_TYPE_I32, op->args[1],
-                                     op->args[3], cond);
-        switch (i ^ inv) {
-        case 0:
-            goto do_brcond_const;
-        case 1:
-            goto do_brcond_low;
-        }
-        break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        if (arg_is_const_val(op->args[2], 0)) {
-            goto do_brcond_high;
-        }
-        if (arg_is_const_val(op->args[3], 0)) {
-            goto do_brcond_low;
-        }
-        break;
-
-    default:
-        break;
-
-    do_brcond_low:
-        op->opc = INDEX_op_brcond;
-        op->args[1] = op->args[2];
-        op->args[2] = cond;
-        op->args[3] = label;
-        return fold_brcond(ctx, op);
-
-    do_brcond_high:
-        op->opc = INDEX_op_brcond;
-        op->args[0] = op->args[1];
-        op->args[1] = op->args[3];
-        op->args[2] = cond;
-        op->args[3] = label;
-        return fold_brcond(ctx, op);
-
-    do_brcond_const:
-        if (i == 0) {
-            tcg_op_remove(ctx->tcg, op);
-            return true;
-        }
-        op->opc = INDEX_op_br;
-        op->args[0] = label;
-        finish_ebb(ctx);
-        return true;
-    }
-
-    finish_bb(ctx);
-    return true;
-}
-
 static bool fold_bswap(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, o_mask, s_mask;
@@ -3163,9 +3067,6 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_brcond:
             done = fold_brcond(&ctx, op);
             break;
-        case INDEX_op_brcond2_i32:
-            done = fold_brcond2(&ctx, op);
-            break;
         case INDEX_op_bswap16:
         case INDEX_op_bswap32:
         case INDEX_op_bswap64:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ab7b409be6..61f6fd9095 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -265,14 +265,6 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
-static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGv_i32 a3, TCGv_i32 a4,
-                                     TCGArg a5, TCGArg a6)
-{
-    return tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                       tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -1873,33 +1865,15 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op;
-        if (TCG_TARGET_REG_BITS == 32) {
-            op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
-                                   TCGV_HIGH(arg1), TCGV_LOW(arg2),
-                                   TCGV_HIGH(arg2), cond, label_arg(l));
-        } else {
-            op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                   label_arg(l));
-        }
+        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
+                                      label_arg(l));
         add_as_label_use(l, op);
     }
 }
 
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-    } else if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
-                                      TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                                      tcg_constant_i32(arg2),
-                                      tcg_constant_i32(arg2 >> 32),
-                                      cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
+    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
 }
 
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fbf09f5c82..0521767c46 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1010,13 +1010,6 @@ typedef struct TCGOutOpBrcond {
                    TCGReg a1, tcg_target_long a2, TCGLabel *label);
 } TCGOutOpBrcond;
 
-typedef struct TCGOutOpBrcond2 {
-    TCGOutOp base;
-    void (*out)(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                TCGArg bl, bool const_bl,
-                TCGArg bh, bool const_bh, TCGLabel *l);
-} TCGOutOpBrcond2;
-
 typedef struct TCGOutOpBswap {
     TCGOutOp base;
     void (*out_rr)(TCGContext *s, TCGType type,
@@ -1248,7 +1241,6 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     [INDEX_op_goto_ptr] = &outop_goto_ptr,
 
 #if TCG_TARGET_REG_BITS == 32
-    OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
     OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
@@ -2490,7 +2482,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
@@ -3022,7 +3013,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_setcond:
             case INDEX_op_negsetcond:
             case INDEX_op_movcond:
-            case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
@@ -3106,7 +3096,6 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_set_label:
             case INDEX_op_br:
             case INDEX_op_brcond:
-            case INDEX_op_brcond2_i32:
                 col += ne_fprintf(f, "%s$L%d", k ? "," : "",
                                   arg_label(op->args[k])->id);
                 i++, k++;
@@ -3563,9 +3552,6 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     case INDEX_op_brcond:
         remove_label_use(op, 3);
         break;
-    case INDEX_op_brcond2_i32:
-        remove_label_use(op, 5);
-        break;
     default:
         break;
     }
@@ -3664,9 +3650,6 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
         case INDEX_op_brcond:
             op->args[3] = label_arg(to);
             break;
-        case INDEX_op_brcond2_i32:
-            op->args[5] = label_arg(to);
-            break;
         default:
             g_assert_not_reached();
         }
@@ -5285,9 +5268,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_cmp_vec:
         op_cond = op->args[3];
         break;
-    case INDEX_op_brcond2_i32:
-        op_cond = op->args[4];
-        break;
     case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
     case INDEX_op_cmpsel_vec:
@@ -5890,19 +5870,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
 #if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_brcond2_i32:
-        {
-            const TCGOutOpBrcond2 *out = &outop_brcond2;
-            TCGCond cond = new_args[4];
-            TCGLabel *label = arg_label(new_args[5]);
-
-            tcg_debug_assert(!const_args[0]);
-            tcg_debug_assert(!const_args[1]);
-            out->out(s, cond, new_args[0], new_args[1],
-                     new_args[2], const_args[2],
-                     new_args[3], const_args[3], label);
-        }
-        break;
     case INDEX_op_setcond2_i32:
         {
             const TCGOutOpSetcond2 *out = &outop_setcond2;
@@ -5915,7 +5882,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 #else
-    case INDEX_op_brcond2_i32:
     case INDEX_op_setcond2_i32:
         g_assert_not_reached();
 #endif
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f26b837a30..10d5edb4ca 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -705,11 +705,6 @@ They are emitted as needed by inline functions within ``tcg-op.h``.
 
 .. list-table::
 
-   * - brcond2_i32 *t0_low*, *t0_high*, *t1_low*, *t1_high*, *cond*, *label*
-
-     - | Similar to brcond, except that the 64-bit values *t0* and *t1*
-         are formed from two 32-bit arguments.
-
    * - setcond2_i32 *dest*, *t1_low*, *t1_high*, *t2_low*, *t2_high*, *cond*
 
      - | Similar to setcond, except that the 64-bit values *t1* and *t2* are
@@ -940,7 +935,7 @@ The target word size (``TCG_TARGET_REG_BITS``) is expected to be 32 bit or
 
 On a 32 bit target, all 64 bit operations are converted to 32 bits.
 A few specific operations must be implemented to allow it
-(see brcond2_i32, setcond2_i32).
+(see setcond2_i32).
 
 On a 64 bit target, the values are transferred between 32 and 64-bit
 registers using the following ops:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 532f87262c..1756ffc59c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -1047,23 +1047,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                         TCGArg bl, bool const_bl,
-                         TCGArg bh, bool const_bh, TCGLabel *l)
-{
-    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
-                      al, ah, bl, bh, cond);
-    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
-}
-
-#if TCG_TARGET_REG_BITS != 32
-__attribute__((unused))
-#endif
-static const TCGOutOpBrcond2 outop_brcond2 = {
-    .base.static_constraint = C_O0_I4(r, r, r, r),
-    .out = tgen_brcond2,
-};
-
 static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
                           TCGReg al, TCGReg ah,
                           TCGArg bl, bool const_bl,
-- 
2.43.0


