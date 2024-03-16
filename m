Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE7C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIq-0002l4-Ho; Fri, 15 Mar 2024 21:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIk-0002kP-Au
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:34 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIe-0000hc-M2
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:31 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29bc1c64a98so1946826a91.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554247; x=1711159047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=La+2iVCXFm9nixFDLUn8X+dnCJSJftKhHVIhvf5XOuw=;
 b=UbByIborFU+07bEtkql2HaZgGO+2WrNsRwLjU/D/K7pHmbpPFREQahp+EZGsWNK/ST
 r0+cZliaDrPnjfiPqCFFbI16h92UqNx/wo/p6rffM9Bq0nFVJYrX/OzX281aDim4NCW2
 +vnRvPcs2stOmp3hyxl3ggWioKcYFfWJU5piBm5w/59NCL8Fp8u785aVtJ2SraCDEjVJ
 kEhgjMyonW95wjKeW3xFX+ibsRCS2zh37k58oPCUaeByxFB6ydHgEgYKqudzR7VuwenW
 XTJA11DwWcARhcaIZkwZmNgy0RFx0XfhzcXmaj2qh6WAAOZUGTboUbd2ck1UPFd/X8wr
 I2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554247; x=1711159047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=La+2iVCXFm9nixFDLUn8X+dnCJSJftKhHVIhvf5XOuw=;
 b=rqX9M/BEYBoAPKMfm3k3tv+OwpOUd8MkdYweDSmKdUx7OSOMG2bURtjTKOqTjCcutO
 aF7k4Bnni3RsYaEXoMuilzDSNRq3fDbA8ryNfVLcoekwuFAuI6Dj8AkjinNGnv+xUUFK
 de2tHR3b3cBxzef+1LYiZMVbqrpjBqws6dpM5sgLNyIjefxzX0snIRmbrUy6wKRzhrVM
 lCBiqsvYOh+L/OcvEPlrUs5rCnfSi6htBSH+QD5nWAxwM8I64TfWA/B5ZhHgfhqMvCyj
 4l50r0MyIAyuJPfzggdRmvHH+wyXyFNsb5e6+97/0N3zwQmFItOA+FyqPZpOI3HSmqZ6
 EaTQ==
X-Gm-Message-State: AOJu0YzBThk6B1X0T8JjoHJGJZijLaPyJgOx/FYzMso5ulpEWhs5ngGy
 PB4Aw5CQBf3x8edFXNlrKJsFKSE47uiR9gBVoy1mX151FIgrCCe/aX9Anuyw6h0JSzTF/0kp/e+
 0
X-Google-Smtp-Source: AGHT+IFJ4NIMfWexRm6hqRfsRZN1NlYMurPXTK64skz6sFBkiKq6RYLR1ZwGvlUBlawdgW0gDr7oUA==
X-Received: by 2002:a17:902:e5c3:b0:1dd:66d4:4d46 with SMTP id
 u3-20020a170902e5c300b001dd66d44d46mr4935155plf.66.1710554247145; 
 Fri, 15 Mar 2024 18:57:27 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 01/22] tcg: Add TCGContext.emit_before_op
Date: Fri, 15 Mar 2024 15:56:59 -1000
Message-Id: <20240316015720.3661236-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  1 +
 tcg/tcg.c         | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 451f3fec41..e9d05f40b0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -552,6 +552,7 @@ struct TCGContext {
 
     QTAILQ_HEAD(, TCGOp) ops, free_ops;
     QSIMPLEQ_HEAD(, TCGLabel) labels;
+    TCGOp *emit_before_op;
 
     /* Tells which temporary holds a given register.
        It does not take into account fixed registers */
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


