Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE326E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL29m-0007YO-Hu; Tue, 10 Dec 2024 10:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29g-0006f0-7F
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:08 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL29e-0000KI-23
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:28:07 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e019b00e8so694329a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844484; x=1734449284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lMlOWnE/8rGwDe2I7u+91BhniWC68DXpBuoq//8jnkI=;
 b=s4bGPw8CiGK0VxXfIr+Im4uA4oek9U9gUdqclIbDmrW4Pqpy478fSu51jdIMoCVoXg
 6mYD7y+KTTqye9RyJOr7XYM1ZlBUIRcQI25XwNeREg1KrcFjDbRDGbKHQPi/uywMuamy
 DvrfeQ9C6FxVvK8yOnydqcbtJ+OuuXyrIA+qzllR50AI7PV4Yd2mNAn/fi+cJGbLbwfD
 00jBA/Xi0bmEu/adoTOLH4yhV0qN7oXe/KlRPyycWgxLQPvbWaO57Be+o0rsFL1D030V
 upijd2KvYTSRTg/uoSF2jdWDX7lACV9iBow49BUULQ3QmbfKWtFpJ22B8nqC1Q562+3R
 W48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844484; x=1734449284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMlOWnE/8rGwDe2I7u+91BhniWC68DXpBuoq//8jnkI=;
 b=RneyxFWLcTOgbfkhs5xRfbm1PMffuv0tRs5j/T1jCdHFvQHY5b4VKfV7rHp36JAZG+
 PLxoH/+/HXSPgWFaY5lvXOuzfdHc2TV28KbUU3641pXeN10BAgg9MHQMFZmh1IySLQ3W
 AiqtRZF7tsG8p2ilGMxgPZ+JE/6F4s5GMrFQtBSsHfUzuZB3DXgfZ2Vhp5XmousE3Fqj
 /M4gLUmxfRQJ3JXvCiSnrxmbiZvRmYV7BtH27dSWx0kbCZuz4wZI1icXYnlTydQXxxR4
 GBGoZ6/LoWwFC0ITAZplDaeGs52bFYUaO22QuSGoYL/xXUFxjz2jr/hPZ3XLTcRA5Ees
 AYug==
X-Gm-Message-State: AOJu0Yy5T4ZtpftexmVSc9c5sZKC2I9jE0BVBHQF3XZm6fOoDrSiNMmv
 Oh25+eUfB1J6l5LrC5WZPtdUCgEMzP030XEhurUD1lUV4e6NQorC4LHqmsl8IXHL4Rmuu9CcaU2
 IR1S1rZTD
X-Gm-Gg: ASbGncsxH1YmIf2dWbU9blKpbjgmH6ndOhP6JHSK/RylbNfE98MoEhxqhZoB3dc15gL
 qclX7HnssA2xEXdc5UzUEmka9J41mpwD0NFMRQoOYVgusUfrxoCPzyWIx/MGmEP3xzcoN3jtDc3
 mog1IC6XpyloeBYNQma13Jcd+8+aC8ObsIJQ5FHSjDO3lblFQ8Kdk3EaUhJpJIqMY7TH/JJ2w+E
 fNesrMmib9HW4s1kWX9s/DXMCH5T8lB3n6s2abC2yWSco54OeZeTvSM328TLA==
X-Google-Smtp-Source: AGHT+IGgT+cwGJoEVkNg65l0tDDZm+A734FkAfLfafbaibFTL7CL526atRObOvBtEJTG++GAstl0lA==
X-Received: by 2002:a05:6830:6112:b0:718:167f:7f1c with SMTP id
 46e09a7af769-71dcf4e7ae5mr11509551a34.13.1733844483928; 
 Tue, 10 Dec 2024 07:28:03 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc4a0267esm2785955a34.52.2024.12.10.07.28.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:28:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 46/46] tcg/optimize: Move fold_cmp_vec,
 fold_cmpsel_vec into alphabetic sort
Date: Tue, 10 Dec 2024 09:24:01 -0600
Message-ID: <20241210152401.1823648-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

The big comment just above says functions should be sorted.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 +++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 54082042aa..2c5691e3c9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1610,6 +1610,36 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
     return true;
 }
 
+static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
+{
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[3] = tcg_swap_cond(op->args[3]);
+    }
+    return finish_folding(ctx, op);
+}
+
+static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
+{
+    /* If true and false values are the same, eliminate the cmp. */
+    if (args_are_copies(op->args[3], op->args[4])) {
+        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
+    }
+
+    /* Canonicalize the comparison to put immediate second. */
+    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
+        op->args[5] = tcg_swap_cond(op->args[5]);
+    }
+    /*
+     * Canonicalize the "false" input reg to match the destination,
+     * so that the tcg backend can implement "move if true".
+     */
+    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
+        op->args[5] = tcg_invert_cond(op->args[5]);
+    }
+    return finish_folding(ctx, op);
+}
+
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask;
@@ -2499,36 +2529,6 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     return tcg_opt_gen_movi(ctx, op, op->args[0], i);
 }
 
-static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
-{
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[3] = tcg_swap_cond(op->args[3]);
-    }
-    return finish_folding(ctx, op);
-}
-
-static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-{
-    /* If true and false values are the same, eliminate the cmp. */
-    if (args_are_copies(op->args[3], op->args[4])) {
-        return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[3]);
-    }
-
-    /* Canonicalize the comparison to put immediate second. */
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[5] = tcg_swap_cond(op->args[5]);
-    }
-    /*
-     * Canonicalize the "false" input reg to match the destination,
-     * so that the tcg backend can implement "move if true".
-     */
-    if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
-        op->args[5] = tcg_invert_cond(op->args[5]);
-    }
-    return finish_folding(ctx, op);
-}
-
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old, a_mask = -1;
-- 
2.43.0


