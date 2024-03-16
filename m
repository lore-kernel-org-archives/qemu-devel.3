Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65175C54E68
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJIw-0002o3-Bb; Fri, 15 Mar 2024 21:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIu-0002ne-R2
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJIt-0000jB-1n
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so19696915ad.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554261; x=1711159061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNF27JH3rJLz68kZoTFt9GK2MSk5zOPAV8Ck18ejJIY=;
 b=bLYM9M/5r179hXEgx8PeR4rnDvWx30nS8WOz5VJyOaw0y2eVi7ptmRyLZQvEeysSIC
 1ozP12sdAhJtUA4noJFuTv1M48pkTnJqlyOaG4quvqH70qn+ldv+yRZvNr4VKIZOgB+R
 7IOYhstcRg7UuU7NV40lYrmob4wyea8lIQtCc4FKTfPCxR9xMYULcCC7lHLHbR0tl6qG
 Lk3jiPf2bDlPNXdmdl8xwBEQ+AiikvaoFspiRG0byt+NIsDeIuTCbd03RibhfxELG5Rp
 AvWdRsuATPcIk+k20laSDKmNgMa/hByO99g8SNTScpdS7+4Eb2KO7YN2QWczv2/HcQg0
 I3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554261; x=1711159061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNF27JH3rJLz68kZoTFt9GK2MSk5zOPAV8Ck18ejJIY=;
 b=m9wzY+CGszLwCDmpzSLn4ScjXx+Ndnlyz6Uw1fb7U9kcwpYXxHW3nGEjlNLUS7e4K9
 QW++9nT2HSrcAHi3kENuoR1o50YcHEm8k9g2KW+DMJtqPAQQLVpTVGHAZwEsaN80aUcT
 8AmNcQjiwhotKVU1IPysvW+DY9DDhNFhAMKnMMYHSxe57a5I448uasiCtBz2DT4bOqfq
 4IaBx5de2Q6kUE4USBjqTmXgLa6hCwI2d9MJnqx5RnrLWdVyhZJFwjI6MqfC9khJ98gP
 /AnzR1AwFe4LFhtvyU0oBlG7icQLiHxGxKMMBLHdfUD1X0pgMo3nO0UDpySjjbNUXQrc
 zfBg==
X-Gm-Message-State: AOJu0Yz8Xx+pATU+CAVnCOXZeXNMDsZzL9ZAlhh47urwgjqEmTpeCwEk
 0Kfin6d33i75zajIsgJ/QQZCY31VsPU+WQGuWg0Bex0OCiwfpf/h7ZCGNLa15bq3ouY94acY+TB
 1
X-Google-Smtp-Source: AGHT+IEm8iFZxBrSVoOoyI5OXCVx6X8i7v9Ixz7G65lqfp0B3MFPPIGedMCk+jgiifrLIkUv9WLoXA==
X-Received: by 2002:a17:902:e74f:b0:1dd:8c28:8a8d with SMTP id
 p15-20020a170902e74f00b001dd8c288a8dmr8482107plf.68.1710554261732; 
 Fri, 15 Mar 2024 18:57:41 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 08/22] plugins: Use emit_before_op for PLUGIN_GEN_FROM_TB
Date: Fri, 15 Mar 2024 15:57:06 -1000
Message-Id: <20240316015720.3661236-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

By having the qemu_plugin_cb_flags be recorded in the TCGHelperInfo,
we no longer need to distinguish PLUGIN_CB_REGULAR from
PLUGIN_CB_REGULAR_R, so place all TB callbacks in the same queue.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 96 +++++++++++++++++++++++++-----------------
 plugins/api.c          |  6 +--
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8fa342b425..f92aa80510 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -207,6 +207,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
+    case PLUGIN_GEN_FROM_TB:
         tcg_gen_plugin_cb(from);
         break;
     case PLUGIN_GEN_FROM_INSN:
@@ -216,8 +217,6 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
-    case PLUGIN_GEN_FROM_TB:
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
@@ -632,24 +631,6 @@ void plugin_gen_disable_mem_helpers(void)
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
@@ -708,6 +689,41 @@ static void gen_disable_mem_helper(struct qemu_plugin_tb *ptb,
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
@@ -786,6 +802,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
         {
             enum plugin_gen_from from = op->args[0];
             struct qemu_plugin_insn *insn = NULL;
+            const GArray *cbs;
+            int i, n;
 
             if (insn_idx >= 0) {
                 insn = g_ptr_array_index(plugin_tb->insns, insn_idx);
@@ -798,6 +816,25 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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
@@ -813,25 +850,6 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
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


