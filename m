Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE13C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldO-0003jv-Gw; Wed, 24 Apr 2024 19:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldM-0003hw-Mg
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldK-0002d1-VR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso322302a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999754; x=1714604554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2G4bfhkGtHkTpReC7gmCGCR5um+WwFsm5xLqETkyRYk=;
 b=MS+I9jIk0xXiKX8hk8xvKBNSzgSuRwkC9ZaIjTtxlLob8eS3Am97ZlimqbmjsmI7aT
 YWonRnwtLTpJ/+tD1erKzIZ1TQPegrDsrbrhAqVw3JkXZ45YEyenGSlYeHL0TXT/BKtk
 SKJ8nqoswHIGH5ZmEEtSMZRclOFwMwkaHOc7+EuknE8MMG77604b07YQgyyxrj98gzQn
 tFm2wDySM4h2B6CYda05uCHJ1oNpA4FMizCCBeV5KN7GsG7wE0S/7cK/NThkDn6GgXkc
 o/DKxjyuK0AsGQp+QM2yurVwRHFBxnvsa/xNA/8P/9O4bg3szMK5JvJfPxbaU0788gNB
 pAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999754; x=1714604554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2G4bfhkGtHkTpReC7gmCGCR5um+WwFsm5xLqETkyRYk=;
 b=CwCvrGxBOj9b3HKjnAPBqoypRAc9QWUs9skbKpE9CnfwVxb8/V6pfKqxckk64KoXbq
 x8bKPFBEsu8DEPsotbALWwvyb4Edz/SYI0w1OCODFpI+luOrGtV6HVYYYZRCSfXx6ZN8
 8fQB0ha0042urk6DKnvi1yrkqMFQliKl3f8SjRyr95FUj3mSGHDuG9Z/ta1enUutUXj7
 ENueJaSFxKOuQXjDOnsDrBalmmS56//dL5eCSm9OFA8qSL/VJ4tIwTEgwLhNJPv+AaBN
 e7aijKs8f4kjBJr/EcDWEsWzXoktdekIffWbDrEy2Ez8tfh9P9XXwhAqBQ+pSh7gI7S1
 cQsQ==
X-Gm-Message-State: AOJu0YxO/9/fuNqSCj+wnMGplOQ8NLHWtyGvu1Xc9j3CiIMXmR/hVU1i
 TGukkZwBljU8Nr1jOse6cyYastmKgojJSqj/MBSmM/Xa1xFELXtM7fZjwtdHRzjo1qbmM0RDOGg
 0
X-Google-Smtp-Source: AGHT+IFmoWXQYVQWkWwgEPsH0yaAdJgWogd+xv+U6Al8yYF+Xk2eXWpJLFDSWHr4a+rbepBykAKOYw==
X-Received: by 2002:a05:6a20:3252:b0:1a9:5e1f:8485 with SMTP id
 hm18-20020a056a20325200b001a95e1f8485mr3885592pzc.31.1713999753608; 
 Wed, 24 Apr 2024 16:02:33 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/20] plugins: Use emit_before_op for PLUGIN_GEN_AFTER_INSN
Date: Wed, 24 Apr 2024 16:02:10 -0700
Message-Id: <20240424230224.941028-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


