Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSi-0003lf-64; Sun, 17 May 2026 21:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0003Wr-DT
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:50 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSI-0007Ko-5y
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:40 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3695bf7d082so1571285a91.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066457; x=1779671257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLMsaRRd+pis62E/1xgM+yw8GBK94iWcjzAmfGhBkrw=;
 b=MGWjjG79CTJDv2zH/W7Eq4qKPWE/cGJeDpKE3K2+D6j4h/CBB1MF7yffNv9I/sRvWE
 xBTz9zVLaXYgHc1tp25lEOg2df05J+7mjDzfh/PmQP/SC/7blwFW3cwI1zufMJEfTnRD
 2bZF5jx+NPe3RzIrIZY1ZPJZ2VFnSkiESPCq5hAaKpG4BbNHIJDs15Nv1lXyFlES7PGI
 vR6d4hnvq7fDJyV13gb5MIAea6+RmHLopXWrDGZERPBkuZtUwmWJGxwryaEe6wkhc9Rs
 vBrBdMj1/nMDWx6wN502SS1lNFTPP9JpQV4kqmOeGIiwdAZ5tUECc9Rg3pLqTQxH2rL9
 1b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066457; x=1779671257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pLMsaRRd+pis62E/1xgM+yw8GBK94iWcjzAmfGhBkrw=;
 b=VnhjCfN0wLiFQKCZ48FEBVLfDO0o0cq669MgnXQTJuNrhrW5Gk2RSGMKSRRbCUMI06
 3xXlrPrGTIMiLxq2s1ytEdo0EUruw9y6aYUaO1cLEgZlKxAoRIzcs2/Rsc61vZmCZ0qu
 qEoj84JyDiKZheoOA2CRao4zcjumSkN/X80Wab08hnbyAioyTzhgiMhLlHZM6lnr35Dl
 44C6u4CIU6fAN++DPjIrfie4B4v4+A4/uu3MMD96IBaNLis7RwmY2xGXmvN83uQDOWkl
 jne+0EiN9kVCdAGirHyO2DfeoAWdQZQoTaodz9Nmq5GK+azWgORBUn/GQxo+CFaX0yrK
 WUqw==
X-Gm-Message-State: AOJu0Ywu7OP71zqNspZb2LEcM4SUC1ebgywKeHRTYE4I9q/EQQxLOAyY
 RdeoA+t8o5j5rrQ77gfdqmXcshDVn0NTstMey1YzIVLqXjkbRKRnxB6ZqYVbQ7Sd3zcuf+M224b
 PKlZW
X-Gm-Gg: Acq92OG+lL+IkJFR8jZUaI1CtXTqDYMQvKkZzh6Tz/aHM1XhOOQQmVifyuoFw1b2zWF
 +KkeiazbLmZvUGG3bj0vcyMciobFP+wDQYZfgVbgCr9IcOUY+uTVJo43X9ACW3YGaG/Iouc7FWQ
 k6KFQQpnMG+QkR7qniLjhAUF7nnIoJ7qgu03q/IGC46jzx+ZttUaygpSzILLsaQrnDX9zkp9dfi
 sfa0KERgASs8KHCj/mZN7p9mbR4uXzgUe+RH/zL+sy20ZiEACI6YPaL3sOf4Sa7YCLPGJqTHhDO
 wPln1UuqfC2N8+5auRWi6p6qhm/3nPRERjom73yHs2ArtrHYgxifWdFYdxbhxP8joq/j7Xkx+7H
 h5QyCGmvx+cbbGdyMUESWogNwz5rFIfzE70dR+GE32xvv+7vmYl5YdKN8XA0Epm828BoPQGytnF
 kIKte6wZDnS7ZM8xz6tojNaD05fWDdtjvMXlD6v0A=
X-Received: by 2002:a17:90b:264e:b0:369:a359:b18e with SMTP id
 98e67ed59e1d1-369a35a164bmr3610418a91.9.1779066456760; 
 Sun, 17 May 2026 18:07:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 2/9] tcg: Optimize INDEX_op_mul[us]2 for 0 and 1
Date: Sun, 17 May 2026 18:07:26 -0700
Message-ID: <20260518010733.502237-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Zero operand produces zero product.
One operand produces copy and {zero,sign} extension
of the other operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 90 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 31 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b1abec69a5..a42ab16fb4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2173,45 +2173,73 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 {
     swap_commutative(op->args[0], &op->args[2], &op->args[3]);
 
-    if (arg_is_const(op->args[2]) && arg_is_const(op->args[3])) {
-        uint64_t a = arg_const_val(op->args[2]);
+    if (arg_is_const(op->args[3])) {
         uint64_t b = arg_const_val(op->args[3]);
-        uint64_t h, l;
-        TCGArg rl, rh;
+        TCGArg rl = op->args[0];
+        TCGArg rh = op->args[1];
         TCGOp *op2;
 
-        switch (op->opc) {
-        case INDEX_op_mulu2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (uint64_t)(uint32_t)a * (uint32_t)b;
-                h = (int32_t)(l >> 32);
-                l = (int32_t)l;
-            } else {
-                mulu64(&l, &h, a, b);
+        if (arg_is_const(op->args[2])) {
+            uint64_t a = arg_const_val(op->args[2]);
+            uint64_t h, l;
+
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                    h = (int32_t)(l >> 32);
+                    l = (int32_t)l;
+                } else {
+                    mulu64(&l, &h, a, b);
+                }
+                break;
+            case INDEX_op_muls2:
+                if (ctx->type == TCG_TYPE_I32) {
+                    l = (int64_t)(int32_t)a * (int32_t)b;
+                    h = l >> 32;
+                    l = (int32_t)l;
+                } else {
+                    muls64(&l, &h, a, b);
+                }
+                break;
+            default:
+                g_assert_not_reached();
             }
-            break;
-        case INDEX_op_muls2:
-            if (ctx->type == TCG_TYPE_I32) {
-                l = (int64_t)(int32_t)a * (int32_t)b;
-                h = l >> 32;
-                l = (int32_t)l;
-            } else {
-                muls64(&l, &h, a, b);
-            }
-            break;
-        default:
-            g_assert_not_reached();
+
+            /* The proper opcode is supplied by tcg_opt_gen_mov. */
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, l);
+            tcg_opt_gen_movi(ctx, op, rh, h);
+            return true;
         }
 
-        rl = op->args[0];
-        rh = op->args[1];
+        if (b == 0) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_movi(ctx, op2, rl, 0);
+            tcg_opt_gen_movi(ctx, op, rh, 0);
+            return true;
+        }
+        if (b == 1) {
+            op2 = opt_insert_before(ctx, op, 0, 2);
+            tcg_opt_gen_mov(ctx, op2, rl, op->args[2]);
 
-        /* The proper opcode is supplied by tcg_opt_gen_mov. */
-        op2 = opt_insert_before(ctx, op, 0, 2);
+            switch (op->opc) {
+            case INDEX_op_mulu2:
+                tcg_opt_gen_movi(ctx, op, rh, 0);
+                break;
+            case INDEX_op_muls2:
+                op->opc = INDEX_op_sar;
+                op->args[0] = rh;
+                op->args[1] = rl;
+                op->args[2] =
+                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                break;
+            default:
+                g_assert_not_reached();
+            }
 
-        tcg_opt_gen_movi(ctx, op, rl, l);
-        tcg_opt_gen_movi(ctx, op2, rh, h);
-        return true;
+            return true;
+        }
     }
     return finish_folding(ctx, op);
 }
-- 
2.43.0


