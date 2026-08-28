Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DB8C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jk-0000zG-7S; Fri, 28 Aug 2026 18:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jj-0000z1-A6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jh-0004Lz-S3
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:44:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1517038a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957096; x=1788561896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01btesOwNgMfqCYbEWPvGU0XYarTSw2hO7HljLt34Hk=;
 b=iDZeZxhQaHIjNZX4NDUTre52/xyi7mIFZWaTQW/i/MouVDfBQmjP9J5QSXAVqmwf0t
 jMnxN9YPMF9hsEsstepUGUxqGOaS0jeRPj5tdD9gyqgRCcvu1puq2DAWoVANIpzcWPLK
 /1ViB02Roxeipk7YYy3LGXunEfPMKpUqzKtG38DzZBORLWEM6N/24MiospjmWB3ue8LY
 In6KivYP4AUNjbBQMyqnTXOmKSz3JrfLkxNd4Wraq/JS+9ccWvJBQV9PmH7bJAl0aKC2
 DTeqbliqsRr5Q3bfiWuytx0S0dq2l4xupxsxCBviY5A++uqTD1aKWy0J0M+CCHQVKW25
 ZSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957096; x=1788561896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=01btesOwNgMfqCYbEWPvGU0XYarTSw2hO7HljLt34Hk=;
 b=PMDpv6sx+R8rIiTHVNDetqIVtuq1Tq0u9MUCsdX43nTCOBAXoREAY3jwcd2S7qBRrF
 VUpEw+7qyCQVOTiabYStzC/llMi68jJFTBYU1IJX7RR8Ub8WJbTFGxzc/5+6+td2j8+O
 CpTsw+Ryav4DGBjgZe9Um/3gJPki3ybQxj+/kjqovXBQJNBdwU5l1dEuyZG6Q0oK7bqR
 w8z/XRhDb7D6J7J+yZEc0mVzz3iCg2zD58soHQSsXV4eMdgAtXqIEYLwmsllNl/CqWa5
 gc2eqDJHxf6gFMoQPL85ngiesSenjxEIAlM+qCVKsgu7OYN4za/++DX24XI55tGTWJYC
 1XuA==
X-Gm-Message-State: AFuF++n0a7rxr6lUtGFSubDgGGEH0Ty+nwnOCWzNxwArcXryh0Trp4rd
 wsL+TWhsYoQpCLRwqAmVlJpJTd9+R+qPZcN17boYW5BfQNSiaWcfEvQND2MoYca1etO9b9oFPNu
 TDWgA
X-Gm-Gg: AYBFou3336qPKJHAnFyXHPop5ZB6U7vrYwdgBA0pyFkjbkVUjknQHUndr7Xz0ug3s+P
 av7f8F0+hbopTriytFdqDaNZ8be6yON3gXKcimZ25CiSN6ZT/bQqLrSynpDNbhUTxvxN31VMyHR
 tieveojZvnNizmVWhvp41M4rwmVJzyIAejG4uxsO4+Do1To2gMqPEPmHw4M36IqhwryWmTmF/pu
 8EguGV8kOLImHhO5s6YdF3gg/S4NPcb5qnVHY9uF+D0i+Rpy3yi7QKuDeveinjT35lVvR8HZA2A
 7FbmxQ53qvc4ZaUnc9pNK2tZV+3EE2MoyEyEaeKy+EY0rcTTaMYWthGBOjF/OCwXDFLrL0H7dHp
 a93JJTBrmTTHnhYY1xdbDhg3Ds3eSnuh3xf/jNgIyusvmBgJ4U61awJ4D3VyciRNAR1dzmmq1+8
 lumiFVTtvKfKHxUstJKmEXf5ZU5gfKbNjUa1A1P53zxNK2TC+ZktlgSerHT7u84e9meabQrCPq7
 K6zHpWIptcAm1BT/Sz5
X-Received: by 2002:a17:90b:288a:b0:396:6344:3b62 with SMTP id
 98e67ed59e1d1-396d0f1a708mr20161579a91.12.1787957096458; 
 Fri, 28 Aug 2026 15:44:56 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 04/16] tcg/optimize: Handle INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:39 -0700
Message-ID: <20260828224451.1564072-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d291c844ca8..83f95e26643 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2101,6 +2101,68 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
     return fold_masks_zo(ctx, op, z_mask, o_mask);
 }
 
+static bool fold_shift(OptContext *ctx, TCGOp *op);
+static bool fold_lea(OptContext *ctx, TCGOp *op)
+{
+    TCGArg sh = op->args[3];
+    TCGArg imm = op->args[4];
+    int var_mask = 0;
+
+    if (arg_is_const(op->args[1])) {
+        imm += arg_const_val(op->args[1]);
+    } else {
+        var_mask |= 1;
+    }
+    if (arg_is_const(op->args[2])) {
+        imm += arg_const_val(op->args[2]) << sh;
+    } else {
+        var_mask |= 2;
+    }
+
+    switch (var_mask) {
+    case 0:
+        return tcg_opt_gen_movi(ctx, op, op->args[0], imm);
+
+    case 1:
+        if (imm == 0) {
+            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
+        }
+        op->opc = INDEX_op_add;
+        op->args[2] = arg_new_constant(ctx, imm);
+        break;
+
+    case 2:
+        if (sh == 0) {
+            if (imm == 0) {
+                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]);
+            }
+            op->opc = INDEX_op_add;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, imm);
+            break;
+        }
+        if (imm == 0) {
+            op->opc = INDEX_op_shl;
+            op->args[1] = op->args[2];
+            op->args[2] = arg_new_constant(ctx, sh);
+            return fold_shift(ctx, op);
+        }
+
+        /* If arg1 was not already 0, fold the immediates. */
+        if (arg_const_val(op->args[1]) != 0) {
+            if (TCG_TARGET_lea_imm_valid(ctx->type, imm)) {
+                op->args[1] = arg_new_constant(ctx, 0);
+                op->args[4] = imm;
+            } else {
+                op->args[1] = arg_new_constant(ctx, imm);
+                op->args[4] = 0;
+            }
+        }
+        break;
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_mb(OptContext *ctx, TCGOp *op)
 {
     /* Eliminate duplicate and redundant fence instructions.  */
@@ -3209,6 +3271,9 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_st_vec:
             done = fold_tcg_st_memcopy(&ctx, op);
             break;
+        case INDEX_op_lea:
+            done = fold_lea(&ctx, op);
+            break;
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-- 
2.53.0


