Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681F7C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9N-0007an-9n; Fri, 25 Apr 2025 18:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7u-0005tu-13
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7p-0001QA-Ph
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:28 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-306b78ae2d1so2324791a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618544; x=1746223344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSykMlfWHGLPM5UjAijVZ55LWA+0iWJFzGasPNfb3HQ=;
 b=lE3golNX+tbjsMJeUUQdqJd+x8k+WfbKFNxB4C9q8Et1VXvib+ED5zdYZ79D8VgirD
 fGPBnY0BDlpBeCrvFbNMo/uj2vrAjgs0QuJWTs6UZ8B+IOiP6pMV/2bUfKE+YzzBtI57
 +CyPV1012UaTDHNrk20kEfq0ai2Z7+kbSJHwdUpEV6kvsAoUxA12HTz2p8x12iDRHW6L
 umTxZs729zBJwxvjd1X5lXXGpZutQMOKLXj7Bk2tO5df9PM0m4oJ3v8O5xL3jmR3bsHE
 FEexllQ+SMOIwomuSkUrPocQ9V8+XGAEHHxx33FI8k9oR159P/LRmNDqZXgeFI7Stg3n
 lM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618544; x=1746223344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSykMlfWHGLPM5UjAijVZ55LWA+0iWJFzGasPNfb3HQ=;
 b=NhCtWg2vYkpV/rTjhsLPOPqBfZ6xv96uO/lAkws3EGNhOiZZIgF9TZLUrEQyfucQmN
 Kay6wia/iYP4poEGRk9UkC9s/+F4c6nOfM/aIN/+P2dkZAlFmYz4qxnZBgDP9tj19ziD
 go6d4fqOzHlbDl4VL4t/vL9beReLBjSIGa8YPY9pu38gViS6bTR0iWCulUOAFwXNfFEZ
 yxAxA+3LhJ0FljhSO2zAgSjp1vlATCnq7Z1/vH3IKRJQLed+6/0yoWPVf1c9nSdUWe78
 hAhA6Rg8czx70Njrn+Ya+YP0SUV2V4x5LVCQHrcgfueEqL53tgRkBBV98Nh3r+KveVk8
 Re5A==
X-Gm-Message-State: AOJu0Yy+NF4JNWMym0PyF6V0q9yW1wBAeLMaVonfvDMyyglgbA2o/SxE
 jxYb/0daOQh7XDj05uwT/hDp+QGRbo1WYCosUmXVcULuvk4gUv1VKSxXgrqnOx18G6ayOHwAYc0
 m
X-Gm-Gg: ASbGncvxsegyPwdAkenDjrKsuG1oUPK2P/UeCvmcOEPbMlLrlD3u+gaOdlbjok+AYoq
 KL4Ckp+x8W9gpNHMKluqWvsB6FeUS6Juph6LZh0Qz8f8vWrSTrT1bzbLJAVCO2ZbBUHTZrwQgjL
 Kgjjgp3ETbgExMW1oqK/PZ8kahIQ6r/KYkZ8VCafkSfkv1UlendhByvW0ko8ogA2GxieicHxVuH
 B/g5YiWXaDADoTJ5pzMv6J6Zpzhk1/peCNiEfhliDe2k8mcovAeS14JcoAbJyUtHNd/HBELaYZ9
 +NfNjdoLCNGx6ukrzLhCjb6MNWpXw3rT0MVcg4MTSE24y3nGNHcqna6uKutaK32XEis4Hhbh7Hc
 =
X-Google-Smtp-Source: AGHT+IH5B0C4seHBfnNpZ8/NKAsb/NAiVzBO+oky3YMJc1Hwh+ylEL1Bv3nw5DkP1wmmBQ7iKT8VDg==
X-Received: by 2002:a17:90b:2dd2:b0:2fe:9581:fbea with SMTP id
 98e67ed59e1d1-30a013bcc03mr1286520a91.29.1745618543862; 
 Fri, 25 Apr 2025 15:02:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 119/159] tcg/optimize: Handle add/sub with carry opcodes
Date: Fri, 25 Apr 2025 14:54:13 -0700
Message-ID: <20250425215454.886111-120-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Propagate known carry when possible, and simplify the opcodes
to not require carry-in when known.  The result will be cleaned
up further by the subsequent liveness analysis pass.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 319 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8b00833f97..cfcd0ab7f9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -66,6 +66,7 @@ typedef struct OptContext {
 
     /* In flight values from optimization. */
     TCGType type;
+    int carry_state;  /* -1 = non-constant, {0,1} = constant carry-in */
 } OptContext;
 
 static inline TempOptInfo *ts_info(TCGTemp *ts)
@@ -1203,8 +1204,10 @@ static bool fold_xx_to_x(OptContext *ctx, TCGOp *op)
  *   3) those that produce information about the result value.
  */
 
+static bool fold_addco(OptContext *ctx, TCGOp *op);
 static bool fold_or(OptContext *ctx, TCGOp *op);
 static bool fold_orc(OptContext *ctx, TCGOp *op);
+static bool fold_subbo(OptContext *ctx, TCGOp *op);
 static bool fold_xor(OptContext *ctx, TCGOp *op);
 
 static bool fold_add(OptContext *ctx, TCGOp *op)
@@ -1226,9 +1229,167 @@ static bool fold_add_vec(OptContext *ctx, TCGOp *op)
     return finish_folding(ctx, op);
 }
 
-static bool fold_add_carry(OptContext *ctx, TCGOp *op)
+static void squash_prev_carryout(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+
+    op = QTAILQ_PREV(op, link);
+    switch (op->opc) {
+    case INDEX_op_addco:
+        op->opc = INDEX_op_add;
+        fold_add(ctx, op);
+        break;
+    case INDEX_op_addcio:
+        op->opc = INDEX_op_addci;
+        break;
+    case INDEX_op_addc1o:
+        op->opc = INDEX_op_add;
+        t2 = arg_info(op->args[2]);
+        if (ti_is_const(t2)) {
+            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
+            /* Perform other constant folding, if needed. */
+            fold_add(ctx, op);
+        } else {
+            TCGArg ret = op->args[0];
+            op = opt_insert_after(ctx, op, INDEX_op_add, 3);
+            op->args[0] = ret;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, 1);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool fold_addci(OptContext *ctx, TCGOp *op)
 {
     fold_commutative(ctx, op);
+
+    if (ctx->carry_state < 0) {
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_carryout(ctx, op);
+    op->opc = INDEX_op_add;
+
+    if (ctx->carry_state > 0) {
+        TempOptInfo *t2 = arg_info(op->args[2]);
+
+        /*
+         * Propagate the known carry-in into a constant, if possible.
+         * Otherwise emit a second add +1.
+         */
+        if (ti_is_const(t2)) {
+            op->args[2] = arg_new_constant(ctx, ti_const_val(t2) + 1);
+        } else {
+            TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_add, 3);
+
+            op2->args[0] = op->args[0];
+            op2->args[1] = op->args[1];
+            op2->args[2] = op->args[2];
+            fold_add(ctx, op2);
+
+            op->args[1] = op->args[0];
+            op->args[2] = arg_new_constant(ctx, 1);
+        }
+    }
+
+    ctx->carry_state = -1;
+    return fold_add(ctx, op);
+}
+
+static bool fold_addcio(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int carry_out = -1;
+    uint64_t sum, max;
+
+    fold_commutative(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    /*
+     * The z_mask value is >= the maximum value that can be represented
+     * with the known zero bits.  So adding the z_mask values will not
+     * overflow if and only if the true values cannot overflow.
+     */
+    if (!uadd64_overflow(t1->z_mask, t2->z_mask, &sum) &&
+        !uadd64_overflow(sum, ctx->carry_state != 0, &sum)) {
+        carry_out = 0;
+    }
+
+    if (ctx->carry_state < 0) {
+        ctx->carry_state = carry_out;
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_carryout(ctx, op);
+    if (ctx->carry_state == 0) {
+        goto do_addco;
+    }
+
+    /* Propagate the known carry-in into a constant, if possible. */
+    max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
+    if (ti_is_const(t2)) {
+        uint64_t v = ti_const_val(t2) & max;
+        if (v < max) {
+            op->args[2] = arg_new_constant(ctx, v + 1);
+            goto do_addco;
+        }
+        /* max + known carry in produces known carry out. */
+        carry_out = 1;
+    }
+    if (ti_is_const(t1)) {
+        uint64_t v = ti_const_val(t1) & max;
+        if (v < max) {
+            op->args[1] = arg_new_constant(ctx, v + 1);
+            goto do_addco;
+        }
+        carry_out = 1;
+    }
+
+    /* Adjust the opcode to remember the known carry-in. */
+    op->opc = INDEX_op_addc1o;
+    ctx->carry_state = carry_out;
+    return finish_folding(ctx, op);
+
+ do_addco:
+    op->opc = INDEX_op_addco;
+    return fold_addco(ctx, op);
+}
+
+static bool fold_addco(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int carry_out = -1;
+    uint64_t ign;
+
+    fold_commutative(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    if (ti_is_const(t2)) {
+        uint64_t v2 = ti_const_val(t2);
+
+        if (ti_is_const(t1)) {
+            uint64_t v1 = ti_const_val(t1);
+            /* Given sign-extension of z_mask for I32, we need not truncate. */
+            carry_out = uadd64_overflow(v1, v2, &ign);
+        } else if (v2 == 0) {
+            carry_out = 0;
+        }
+    } else {
+        /*
+         * The z_mask value is >= the maximum value that can be represented
+         * with the known zero bits.  So adding the z_mask values will not
+         * overflow if and only if the true values cannot overflow.
+         */
+        if (!uadd64_overflow(t1->z_mask, t2->z_mask, &ign)) {
+            carry_out = 0;
+        }
+    }
+    ctx->carry_state = carry_out;
     return finish_folding(ctx, op);
 }
 
@@ -2649,6 +2810,145 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
     return fold_addsub2(ctx, op, false);
 }
 
+static void squash_prev_borrowout(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+
+    op = QTAILQ_PREV(op, link);
+    switch (op->opc) {
+    case INDEX_op_subbo:
+        op->opc = INDEX_op_sub;
+        fold_sub(ctx, op);
+        break;
+    case INDEX_op_subbio:
+        op->opc = INDEX_op_subbi;
+        break;
+    case INDEX_op_subb1o:
+        t2 = arg_info(op->args[2]);
+        if (ti_is_const(t2)) {
+            op->opc = INDEX_op_add;
+            op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
+            /* Perform other constant folding, if needed. */
+            fold_add(ctx, op);
+        } else {
+            TCGArg ret = op->args[0];
+            op->opc = INDEX_op_sub;
+            op = opt_insert_after(ctx, op, INDEX_op_add, 3);
+            op->args[0] = ret;
+            op->args[1] = ret;
+            op->args[2] = arg_new_constant(ctx, -1);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static bool fold_subbi(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t2;
+    int borrow_in = ctx->carry_state;
+
+    if (borrow_in < 0) {
+        return finish_folding(ctx, op);
+    }
+    ctx->carry_state = -1;
+
+    squash_prev_borrowout(ctx, op);
+    if (borrow_in == 0) {
+        op->opc = INDEX_op_sub;
+        return fold_sub(ctx, op);
+    }
+
+    /*
+     * Propagate the known carry-in into any constant, then negate to
+     * transform from sub to add.  If there is no constant, emit a
+     * separate add -1.
+     */
+    t2 = arg_info(op->args[2]);
+    if (ti_is_const(t2)) {
+        op->args[2] = arg_new_constant(ctx, -(ti_const_val(t2) + 1));
+    } else {
+        TCGOp *op2 = opt_insert_before(ctx, op, INDEX_op_sub, 3);
+
+        op2->args[0] = op->args[0];
+        op2->args[1] = op->args[1];
+        op2->args[2] = op->args[2];
+        fold_sub(ctx, op2);
+
+        op->args[1] = op->args[0];
+        op->args[2] = arg_new_constant(ctx, -1);
+    }
+    op->opc = INDEX_op_add;
+    return fold_add(ctx, op);
+}
+
+static bool fold_subbio(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1, *t2;
+    int borrow_out = -1;
+
+    if (ctx->carry_state < 0) {
+        return finish_folding(ctx, op);
+    }
+
+    squash_prev_borrowout(ctx, op);
+    if (ctx->carry_state == 0) {
+        goto do_subbo;
+    }
+
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    /* Propagate the known borrow-in into a constant, if possible. */
+    if (ti_is_const(t2)) {
+        uint64_t max = ctx->type == TCG_TYPE_I32 ? UINT32_MAX : UINT64_MAX;
+        uint64_t v = ti_const_val(t2) & max;
+
+        if (v < max) {
+            op->args[2] = arg_new_constant(ctx, v + 1);
+            goto do_subbo;
+        }
+        /* subtracting max + 1 produces known borrow out. */
+        borrow_out = 1;
+    }
+    if (ti_is_const(t1)) {
+        uint64_t v = ti_const_val(t1);
+        if (v != 0) {
+            op->args[2] = arg_new_constant(ctx, v - 1);
+            goto do_subbo;
+        }
+    }
+
+    /* Adjust the opcode to remember the known carry-in. */
+    op->opc = INDEX_op_subb1o;
+    ctx->carry_state = borrow_out;
+    return finish_folding(ctx, op);
+
+ do_subbo:
+    op->opc = INDEX_op_subbo;
+    return fold_subbo(ctx, op);
+}
+
+static bool fold_subbo(OptContext *ctx, TCGOp *op)
+{
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    int borrow_out = -1;
+
+    if (ti_is_const(t2)) {
+        uint64_t v2 = ti_const_val(t2);
+        if (v2 == 0) {
+            borrow_out = 0;
+        } else if (ti_is_const(t1)) {
+            uint64_t v1 = ti_const_val(t1);
+            borrow_out = v1 < v2;
+        }
+    }
+    ctx->carry_state = borrow_out;
+    return finish_folding(ctx, op);
+}
+
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask = -1, s_mask = 0;
@@ -2836,9 +3136,13 @@ void tcg_optimize(TCGContext *s)
             done = fold_add_vec(&ctx, op);
             break;
         case INDEX_op_addci:
-        case INDEX_op_addco:
+            done = fold_addci(&ctx, op);
+            break;
         case INDEX_op_addcio:
-            done = fold_add_carry(&ctx, op);
+            done = fold_addcio(&ctx, op);
+            break;
+        case INDEX_op_addco:
+            done = fold_addco(&ctx, op);
             break;
         CASE_OP_32_64(add2):
             done = fold_add2(&ctx, op);
@@ -3020,6 +3324,15 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
+        case INDEX_op_subbi:
+            done = fold_subbi(&ctx, op);
+            break;
+        case INDEX_op_subbio:
+            done = fold_subbio(&ctx, op);
+            break;
+        case INDEX_op_subbo:
+            done = fold_subbo(&ctx, op);
+            break;
         case INDEX_op_sub_vec:
             done = fold_sub_vec(&ctx, op);
             break;
-- 
2.43.0


