Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B6CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWA9-00022E-3W; Thu, 04 Apr 2024 19:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA7-00021J-Ek
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA4-0007iz-G6
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so1317675a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271983; x=1712876783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2G4bfhkGtHkTpReC7gmCGCR5um+WwFsm5xLqETkyRYk=;
 b=q1LWy8u16lzydDhH5R+BAJvaccwh5ivUodJTFKVnTqbG1iJcqx94rXEflKxp5yO7xS
 6ssl10zydLMTx5Ss9YZeQ4VtUzvzsz4L4xBRsbXzxKUS9nDJ5AN+E/mbcrmBHOUDTO3n
 67oqrEWOKGASM0dDnBTvid3iYCFffDY1k1CO71qJ0RvlSKi7Ze+9uyEd+x5opq27twcR
 VKkdgo6JoBHrtxhRbTzZT3hgvjn3LwUdvqH9Fw/zfk4r9xiBpavb2vIR+GLw96pRvpyA
 Y3Wt+obX7YzhBpNDKfoPuJVZd7/Fvqigf/Kb9uh77Q9KL7YWLok3t14+r83usbsN31aO
 NzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271983; x=1712876783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2G4bfhkGtHkTpReC7gmCGCR5um+WwFsm5xLqETkyRYk=;
 b=LEokrby/qjMeBwq/FncsL79MqJZmNUz2Q1U58d6rhi4Z9C+5ZkFJJWeYiMsm9PCYs7
 YxTFa9vgywcjqMzYZcOGrIKalzFGSmdFH853wG27VjYUYHHLHAr9Xg7hMjFXMdY2It39
 0yHdbm3Ps8byWM/8g9qgp3QJcUbP0+OcubIG5IEpwi4//7gqWyWuU6pPaErX3i/5PKLN
 GY4ARyqb3KGjbVPJL77h/AM3RbwiFc+sBuo4RTIMM478CsidtnC8/CtWN4wNryNnb65y
 vkDyiUaZR/enJemC77FnNYr9Tz1arWSa7Wjewqr36ofeuN90L8RPVDhYUkn17Y96vcLu
 JoXg==
X-Gm-Message-State: AOJu0Yyqtpc0iR4xwBBea2aL8/QPm9pgcYWVchfdhYPtc0uI0T4dawr0
 dJ1Z3mTeXSEFd5MWR9X66EpRFO5tzR7CaEmFHa58c0p/cMc3tZ7iChlo0/uy2UBKdX/e9kYckpT
 k
X-Google-Smtp-Source: AGHT+IGFV91JPHDD6TAkXJ4R2cPN8mW/qzDuH6ItU/iX0yuwDntfri59e2h12sGFBRGdbMhGVm251g==
X-Received: by 2002:a17:90a:68ca:b0:2a2:b097:dabc with SMTP id
 q10-20020a17090a68ca00b002a2b097dabcmr1218430pjj.31.1712271982981; 
 Thu, 04 Apr 2024 16:06:22 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/21] plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
Date: Thu,  4 Apr 2024 13:05:57 -1000
Message-Id: <20240404230611.21231-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Introduce a new plugin_cb op and migrate one operation.
By using emit_before_op, we do not need to emit opcodes
early and modify them later -- we can simply emit the
final set of opcodes once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 include/tcg/tcg-opc.h       |  1 +
 accel/tcg/plugin-gen.c      | 74 +++++++++++++++++++++----------------
 tcg/tcg-op.c                |  5 +++
 4 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2d932a515e..9de5a7f280 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -74,6 +74,7 @@ void tcg_gen_goto_tb(unsigned idx);
  */
 void tcg_gen_lookup_and_goto_ptr(void);
 
+void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr);
 void tcg_gen_plugin_cb_end(void);
 
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index b80227fa1c..3b7cb2bce1 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -197,6 +197,7 @@ DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
+DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_start, 0, 0, 3, TCG_OPF_NOT_PRESENT)
 DEF(plugin_cb_end, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4b488943ff..4b02c0bfbf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -201,8 +201,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
-        gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
-                    gen_empty_mem_helper);
+        tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
         /*
@@ -608,16 +607,6 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
     inject_mem_helper(begin_op, arr);
 }
 
-static void inject_mem_disable_helper(struct qemu_plugin_insn *plugin_insn,
-                                      TCGOp *begin_op)
-{
-    if (likely(!plugin_insn->mem_helper)) {
-        rm_ops(begin_op);
-        return;
-    }
-    inject_mem_helper(begin_op, NULL);
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -703,11 +692,14 @@ static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     inject_mem_enable_helper(ptb, insn, begin_op);
 }
 
-static void plugin_gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
-                                          TCGOp *begin_op, int insn_idx)
+static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
+                                   struct qemu_plugin_insn *insn)
 {
-    struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_mem_disable_helper(insn, begin_op);
+    if (insn->mem_helper) {
+        tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
+                       offsetof(CPUState, plugin_mem_cbs) -
+                       offsetof(ArchCPU, env));
+    }
 }
 
 /* #define DEBUG_PLUGIN_GEN_OPS */
@@ -766,16 +758,49 @@ static void pr_ops(void)
 
 static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 {
-    TCGOp *op;
+    TCGOp *op, *next;
     int insn_idx = -1;
 
     pr_ops();
 
-    QTAILQ_FOREACH(op, &tcg_ctx->ops, link) {
+    /*
+     * While injecting code, we cannot afford to reuse any ebb temps
+     * that might be live within the existing opcode stream.
+     * The simplest solution is to release them all and create new.
+     */
+    memset(tcg_ctx->free_temps, 0, sizeof(tcg_ctx->free_temps));
+
+    QTAILQ_FOREACH_SAFE(op, &tcg_ctx->ops, link, next) {
         switch (op->opc) {
         case INDEX_op_insn_start:
             insn_idx++;
             break;
+
+        case INDEX_op_plugin_cb:
+        {
+            enum plugin_gen_from from = op->args[0];
+            struct qemu_plugin_insn *insn = NULL;
+
+            if (insn_idx >= 0) {
+                insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
+            }
+
+            tcg_ctx->emit_before_op = op;
+
+            switch (from) {
+            case PLUGIN_GEN_AFTER_INSN:
+                assert(insn != NULL);
+                gen_disable_mem_helper(plugin_tb, insn);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            tcg_ctx->emit_before_op = NULL;
+            tcg_op_remove(tcg_ctx, op);
+            break;
+        }
+
         case INDEX_op_plugin_cb_start:
         {
             enum plugin_gen_from from = op->args[0];
@@ -840,19 +865,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 break;
             }
-            case PLUGIN_GEN_AFTER_INSN:
-            {
-                g_assert(insn_idx >= 0);
-
-                switch (type) {
-                case PLUGIN_GEN_DISABLE_MEM_HELPER:
-                    plugin_gen_disable_mem_helper(plugin_tb, op, insn_idx);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aa6bc6f57d..0f2026c91c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -312,6 +312,11 @@ void tcg_gen_mb(TCGBar mb_type)
     }
 }
 
+void tcg_gen_plugin_cb(unsigned from)
+{
+    tcg_gen_op1(INDEX_op_plugin_cb, from);
+}
+
 void tcg_gen_plugin_cb_start(unsigned from, unsigned type, unsigned wr)
 {
     tcg_gen_op3(INDEX_op_plugin_cb_start, from, type, wr);
-- 
2.34.1


