Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4488C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglE-000629-Ek; Fri, 05 Apr 2024 06:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl7-0005zH-4L
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:21 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0004ig-Si
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:20 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-22edbef3b4eso58244fac.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312717; x=1712917517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pVczXwSwmGbu0M1qoWfxeDZ+kVcxLdctaqwAQ3Kgz2g=;
 b=SGddtqgXnHN/lWAyj0B2O8crA2vIl+3kZ/jDjF2LD56oUNUptcgQWNVHQjpEaY/YiK
 WtAGBd3BpnYm+1C3EH9hW6uum8155UnGKptUknH5tj21W5moelaTh0gXOYVzACQlERLh
 OIMDbH/c5d5OzhHdf4FBTQzOVw4yz5y36RbQBZ6bTrQJRPYOh/kQTzD9PbHazbJ77muO
 EcFnnj/3dS+PhmdzoxGWNR3n9tq0zV5CyWAnEEnN2cYRJ7ZuarieMhFXB0E5mVlSAkid
 AYs+ihxp/ioQshEAfx9n9szLB2pdxmACVMcNi5RAl48Pnfn0usLI56NEYpeB4bNv1mtZ
 BOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312717; x=1712917517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVczXwSwmGbu0M1qoWfxeDZ+kVcxLdctaqwAQ3Kgz2g=;
 b=eewbJp4ysEg3FUlUmodmdnwNbgZRyhJi0El+buKledGVAk1EPPXC57E78O7vdZ6fA9
 f6UshJt3GkjvSgCiziw0ryikV4Zu/sCKVHM8IAxUfiqSEcUL7hUdpNahNJ9Ef7023tR4
 4yjztRszNzckboHmZiym2jRr1PHLdfBIjst2gpuUuG2HjmU72cTxItg9bHfEjQQ1Nhvn
 5lII4PR/MK1o29A/yzkAIC/tBER3qE0wtgfoytmkS8Sb8Pbdy+Vi+qcADJ9ajZ7UCT2Z
 mwT1/0CSIyMxh7PIL3k9KMSZvesasSeNEb3qx7G2n52qgE27Jkacdi5dLZz0UI601Cfc
 GF2Q==
X-Gm-Message-State: AOJu0Yx3++804BdWeOb7KsETHs5rlGfQBUoHV4tYxqpHZO3WzMKZMsLk
 htA7B3Mq4W82vJKL/u8YhCO1nbI2N0IGAQMh0eWkwa8j3cFVOmb8HNNqZ7A1JRHPUGNXaClRzk3
 0
X-Google-Smtp-Source: AGHT+IGWeVwSt9QkbyirEdBEepgc/TTxE+FUBxxUrQ8t0+FnLj+/UFsHML326Dd6Rcj0zT0D8J/ZUg==
X-Received: by 2002:a05:6870:1a8f:b0:229:7f3f:bb6a with SMTP id
 ef15-20020a0568701a8f00b002297f3fbb6amr776807oab.32.1712312717203; 
 Fri, 05 Apr 2024 03:25:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/32] plugins: Read mem_only directly from TB cflags
Date: Fri,  5 Apr 2024 00:24:39 -1000
Message-Id: <20240405102459.462551-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Do not pass around a boolean between multiple structures,
just read it from the TranslationBlock in the TCGContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/plugin-gen.h |  7 +++----
 include/qemu/plugin.h     |  3 ---
 accel/tcg/plugin-gen.c    |  4 +---
 accel/tcg/translator.c    |  2 +-
 plugins/api.c             | 14 +++++++++-----
 5 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index f333f33198..cbb2ca2131 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -18,8 +18,7 @@ struct DisasContextBase;
 
 #ifdef CONFIG_PLUGIN
 
-bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
-                         bool supress);
+bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);
@@ -28,8 +27,8 @@ void plugin_gen_disable_mem_helpers(void);
 
 #else /* !CONFIG_PLUGIN */
 
-static inline bool
-plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db, bool sup)
+static inline
+bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db)
 {
     return false;
 }
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index c32bb97667..03081be543 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -106,8 +106,6 @@ struct qemu_plugin_insn {
 
     /* if set, the instruction calls helpers that might access guest memory */
     bool mem_helper;
-
-    bool mem_only;
 };
 
 /* A scoreboard is an array of values, indexed by vcpu_index */
@@ -124,7 +122,6 @@ struct qemu_plugin_tb {
     uint64_t vaddr2;
     void *haddr1;
     void *haddr2;
-    bool mem_only;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index be2451be58..a4656859c6 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -303,8 +303,7 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
     }
 }
 
-bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
-                         bool mem_only)
+bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 {
     bool ret = false;
 
@@ -323,7 +322,6 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->vaddr2 = -1;
         ptb->haddr1 = db->host_addr[0];
         ptb->haddr2 = NULL;
-        ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
         tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0a1d26b2e8..46483414d2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -155,7 +155,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-    plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    plugin_enabled = plugin_gen_tb_start(cpu, db);
     db->plugin_enabled = plugin_enabled;
 
     while (true) {
diff --git a/plugins/api.c b/plugins/api.c
index 7b8b7523b3..39895a1cb1 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -87,12 +87,17 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
 }
 
+static bool tb_is_mem_only(void)
+{
+    return tb_cflags(tcg_ctx->gen_tb) & CF_MEMI_ONLY;
+}
+
 void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *udata)
 {
-    if (!tb->mem_only) {
+    if (!tb_is_mem_only()) {
         plugin_register_dyn_cb__udata(&tb->cbs, cb, flags, udata);
     }
 }
@@ -103,7 +108,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     qemu_plugin_u64 entry,
     uint64_t imm)
 {
-    if (!tb->mem_only) {
+    if (!tb_is_mem_only()) {
         plugin_register_inline_op_on_entry(&tb->cbs, 0, op, entry, imm);
     }
 }
@@ -113,7 +118,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *udata)
 {
-    if (!insn->mem_only) {
+    if (!tb_is_mem_only()) {
         plugin_register_dyn_cb__udata(&insn->insn_cbs, cb, flags, udata);
     }
 }
@@ -124,7 +129,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     qemu_plugin_u64 entry,
     uint64_t imm)
 {
-    if (!insn->mem_only) {
+    if (!tb_is_mem_only()) {
         plugin_register_inline_op_on_entry(&insn->insn_cbs, 0, op, entry, imm);
     }
 }
@@ -206,7 +211,6 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
         return NULL;
     }
     insn = g_ptr_array_index(tb->insns, idx);
-    insn->mem_only = tb->mem_only;
     return insn;
 }
 
-- 
2.34.1


