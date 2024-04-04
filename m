Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F43CCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAI-00023D-HR; Thu, 04 Apr 2024 19:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA7-00021U-I1
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:27 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA5-0007jH-KF
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:27 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so1096815a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271984; x=1712876784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XIrzr8Gj4slMnxdZrOrVhobtdoNtfeTg1wHY9Xb2+Ms=;
 b=LcclhzqWxXTzEm9jSzU84FpKQ6Sk+BsNcWbrbijea8HBmAYI4SQiVAnAC4z33ADUFO
 0ulJU/BJHF5Xhf4S+0yK4hoOYOc0TpytYo86c2pLlWCp/akwRFImOSQbX2wywJJ/fF6D
 dbJTfNo5pZCAz3SgiW0mZtHtIMfRQbyp11KrDWpyKXe3C1gU210OXzGVxJ5WsSRe+6wn
 n2ljbcF5O4iVjdgzobILFQb3xpA3vfScQPcdIWoLhE0129KxzaXVeSad1aQWpTkn+S4T
 vj/knjsAyA/rwA58iHMDrXDEnlS3a2Az3HX/EhmUTZSeq2yqThFSKIpX5SgLaJOpPcOG
 7rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271984; x=1712876784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIrzr8Gj4slMnxdZrOrVhobtdoNtfeTg1wHY9Xb2+Ms=;
 b=ZmEBeh32Dwjajj9Gp2aj9siQV61kIIeNIRVPiDyhoSic+6NSYvoTKmjg5dO4XClRle
 xLxMMGDDq597D19Wp4FWQ7zSCeY6X7xFgG7l9FGE0yvRsdeVXVLneR1tDfgIJsP92615
 Mv0vu6ARqJN1F7ny18MIM7Fk/5FK3Rzv6sw7mtAYA1lu020A13C/47XYomKAzqB2PNBI
 rjkHAqNaitSlIZNR88/1BwW1sEtTFqUP3ii/ObQ97E3TSdEgR+dCtSPAto6DPs64WUTH
 YNyagkEsYGBsGSiF2HsulfU2j8WG+N4FxvqSXNy4k1Tgkl59eYdcaJFk/NZkQQPx1w9S
 jFLw==
X-Gm-Message-State: AOJu0YyzjUiqDOIPiSfqET/iT9lgmi0hplTGqAUOKrH8x0rGLC3WTZEi
 lkbBtkQUXRjiHCobkW12EAlRxxxkBb+P+SqiPnWSy3w3ser8p6pYva6sqH4TM1hwqzRLnmw4E8r
 N
X-Google-Smtp-Source: AGHT+IGFO1gx6SwlyHdxwUl0bXDsgDwdKHjXRTMTVwHryoxahuHnY8oOqO7/DEBLxw8MWeRTjPtkww==
X-Received: by 2002:a17:90a:9a4:b0:2a2:dcbd:9f01 with SMTP id
 33-20020a17090a09a400b002a2dcbd9f01mr2774227pjo.38.1712271984242; 
 Thu, 04 Apr 2024 16:06:24 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/21] plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
Date: Thu,  4 Apr 2024 13:05:58 -1000
Message-Id: <20240404230611.21231-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

By having the qemu_plugin_cb_flags be recorded in the TCGHelperInfo,
we no longer need to distinguish PLUGIN_CB_REGULAR from
PLUGIN_CB_REGULAR_R, so place all TB callbacks in the same queue.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 96 +++++++++++++++++++++++++-----------------
 plugins/api.c          |  6 +--
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4b02c0bfbf..c803fe8e96 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -201,6 +201,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
+    case PLUGIN_GEN_FROM_TB:
         tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
@@ -210,8 +211,6 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
-    case PLUGIN_GEN_FROM_TB:
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
@@ -626,24 +625,6 @@ void plugin_gen_disable_mem_helpers(void)
                    offsetof(CPUState, plugin_mem_cbs) - offsetof(ArchCPU, env));
 }
 
-static void plugin_gen_tb_udata(const struct qemu_plugin_tb *ptb,
-                                TCGOp *begin_op)
-{
-    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR], begin_op);
-}
-
-static void plugin_gen_tb_udata_r(const struct qemu_plugin_tb *ptb,
-                                  TCGOp *begin_op)
-{
-    inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
-}
-
-static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
-                                 TCGOp *begin_op)
-{
-    inject_inline_cb(ptb->cbs[PLUGIN_CB_INLINE], begin_op, op_ok);
-}
-
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
                                   TCGOp *begin_op, int insn_idx)
 {
@@ -702,6 +683,41 @@ static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
     }
 }
 
+static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_call2(cb->regular.f.vcpu_udata, cb->regular.info, NULL,
+                  tcgv_i32_temp(cpu_index),
+                  tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_temp_free_i32(cpu_index);
+}
+
+static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    GArray *arr = cb->inline_insn.entry.score->data;
+    size_t offset = cb->inline_insn.entry.offset;
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_i64 val = tcg_temp_ebb_new_i64();
+    TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
+
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_muli_i32(cpu_index, cpu_index, g_array_get_element_size(arr));
+    tcg_gen_ext_i32_ptr(ptr, cpu_index);
+    tcg_temp_free_i32(cpu_index);
+
+    tcg_gen_addi_ptr(ptr, ptr, (intptr_t)arr->data);
+    tcg_gen_ld_i64(val, ptr, offset);
+    tcg_gen_addi_i64(val, val, cb->inline_insn.imm);
+    tcg_gen_st_i64(val, ptr, offset);
+
+    tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(ptr);
+}
+
 /* #define DEBUG_PLUGIN_GEN_OPS */
 static void pr_ops(void)
 {
@@ -780,6 +796,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
         {
             enum plugin_gen_from from = op->args[0];
             struct qemu_plugin_insn *insn = NULL;
+            const GArray *cbs;
+            int i, n;
 
             if (insn_idx >= 0) {
                 insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
@@ -792,6 +810,25 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 assert(insn != NULL);
                 gen_disable_mem_helper(plugin_tb, insn);
                 break;
+
+            case PLUGIN_GEN_FROM_TB:
+                assert(insn == NULL);
+
+                cbs = plugin_tb->cbs[PLUGIN_CB_REGULAR];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_udata_cb(cb);
+                }
+
+                cbs = plugin_tb->cbs[PLUGIN_CB_INLINE];
+                for (i = 0, n = (cbs ? cbs->len : 0); i < n; i++) {
+                    struct qemu_plugin_dyn_cb *cb =
+                        &g_array_index(cbs, struct qemu_plugin_dyn_cb, i);
+                    gen_inline_cb(cb);
+                }
+                break;
+
             default:
                 g_assert_not_reached();
             }
@@ -807,25 +844,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
             enum plugin_gen_cb type = op->args[1];
 
             switch (from) {
-            case PLUGIN_GEN_FROM_TB:
-            {
-                g_assert(insn_idx == -1);
-
-                switch (type) {
-                case PLUGIN_GEN_CB_UDATA:
-                    plugin_gen_tb_udata(plugin_tb, op);
-                    break;
-                case PLUGIN_GEN_CB_UDATA_R:
-                    plugin_gen_tb_udata_r(plugin_tb, op);
-                    break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_tb_inline(plugin_tb, op);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
             case PLUGIN_GEN_FROM_INSN:
             {
                 g_assert(insn_idx >= 0);
diff --git a/plugins/api.c b/plugins/api.c
index 8fa5a600ac..5d119e8049 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -92,11 +92,7 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           void *udata)
 {
     if (!tb->mem_only) {
-        int index = flags == QEMU_PLUGIN_CB_R_REGS ||
-                    flags == QEMU_PLUGIN_CB_RW_REGS ?
-                    PLUGIN_CB_REGULAR_R : PLUGIN_CB_REGULAR;
-
-        plugin_register_dyn_cb__udata(&tb->cbs[index],
+        plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
                                       cb, flags, udata);
     }
 }
-- 
2.34.1


