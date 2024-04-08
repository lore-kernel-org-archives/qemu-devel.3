Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0863DCD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt8A-00024q-05; Mon, 08 Apr 2024 13:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt86-00023u-V3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt85-0003gn-8C
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:50:02 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso3844865a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598600; x=1713203400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hrHUKRn6eQNytNYIbrEJFLCXruCPezaWV08Xln+A+c=;
 b=qf8/kLNw1raBfX+unDKpS/Zh2CiNTa3N3AeOmUxo0VIYIq5xFdOa49TrMWrKVxvVP6
 vdNTw2TMoXUfQqu+2oT70Ep6IUvaTkVgbTbyN1K6Grxzp9h9L0rTZYDz8RugvTyntRWG
 Fuc6bwn73AojZZQgQc7ixNINMcBYQAXpFmfCqAiVd8n2UwumMwK62JIdN8wSxq/OSuZB
 GH+RxafXYp798NZ3TvNa4ri34AHpoJnBgyI5Zu34AIn9OSpIuT31EVMvz2u01hOnfWhh
 33LygMBpNebwD8dM6nLRS03b7euXRrte5kOtzoWrPgn0F6yxphEHCJS+Zr6I8wKzXdYT
 0clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598600; x=1713203400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hrHUKRn6eQNytNYIbrEJFLCXruCPezaWV08Xln+A+c=;
 b=l1gjGZllMIYU2Ou7zM/k1B037t1pQGsScPfdP9LyOjBxatSSaaxLKuJR7nG0cbnm7G
 l8WtGT40LZ0RpLHOGQyB1rHjOvvSdDL5oIizyeeyKEMOFnzC4pVngmtkvkc+flU4U7NP
 EnYHQAgrnrL1KlV4R315cM3cen67fl+cUCjd3yoLqi64UMBr0yO1zvwuVGS/gya7Ircz
 ghRdpk4VoayLHGus0kHe5uHMQgK2qS4A1x5KLpjAc8GJbPu4BbnF0Cnan8JcLvYEggWt
 goD8a92EyeskJ90TE57l5zAwjFCoqWoQd50DR6GgWu5BPuWYBQ4cq+hV6dyWxvtFgQx4
 bRLQ==
X-Gm-Message-State: AOJu0YysDRnIbm/t7+7o2VXVTWr2KL/fCqtJKCnPylR3C2H4GO15Yf4g
 gwmJ9lYANH9fWOk9BMo+7fd7bRJ867dFsdtGUmH/AWBs7/KSl8AHUYhg3d9qZJU+zPxhoNrNxyH
 s
X-Google-Smtp-Source: AGHT+IGTaEnYk4STDPsrRRIKmkPstaFBC0Tn01CTIXP7vMu1T0G1y8vZYfVDUaLuH9zdEBPZgijPrQ==
X-Received: by 2002:a17:90a:d997:b0:2a2:cf1d:895c with SMTP id
 d23-20020a17090ad99700b002a2cf1d895cmr7502918pjv.41.1712598599664; 
 Mon, 08 Apr 2024 10:49:59 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 19/35] tcg: Add TCGContext.emit_before_op
Date: Mon,  8 Apr 2024 07:49:13 -1000
Message-Id: <20240408174929.862917-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Allow operations to be emitted via normal expanders
into the middle of the opcode stream.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  6 ++++++
 tcg/tcg.c         | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 451f3fec41..05a1912f8a 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -553,6 +553,12 @@ struct TCGContext {
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
     QSIMPLEQ_HEAD(, TCGLabel) labels;
 
+    /*
+     * When clear, new ops are added to the tail of @ops.
+     * When set, new ops are added in front of @emit_before_op.
+     */
+    TCGOp *emit_before_op;
+
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
     TCGTemp *reg_to_temp[TCG_TARGET_NB_REGS];
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d6670237fb..0c0bb9d169 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1521,6 +1521,7 @@ void tcg_func_start(TCGContext *s)
 
     QTAILQ_INIT(&s->ops);
     QTAILQ_INIT(&s->free_ops);
+    s->emit_before_op = NULL;
     QSIMPLEQ_INIT(&s->labels);
 
     tcg_debug_assert(s->addr_type == TCG_TYPE_I32 ||
@@ -2332,7 +2333,11 @@ static void tcg_gen_callN(TCGHelperInfo *info, TCGTemp *ret, TCGTemp **args)
     op->args[pi++] = (uintptr_t)info;
     tcg_debug_assert(pi == total_args);
 
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
 
     tcg_debug_assert(n_extend < ARRAY_SIZE(extend_free));
     for (i = 0; i < n_extend; ++i) {
@@ -3215,7 +3220,12 @@ static TCGOp *tcg_op_alloc(TCGOpcode opc, unsigned nargs)
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs)
 {
     TCGOp *op = tcg_op_alloc(opc, nargs);
-    QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+
+    if (tcg_ctx->emit_before_op) {
+        QTAILQ_INSERT_BEFORE(tcg_ctx->emit_before_op, op, link);
+    } else {
+        QTAILQ_INSERT_TAIL(&tcg_ctx->ops, op, link);
+    }
     return op;
 }
 
-- 
2.34.1


