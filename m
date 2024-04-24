Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D1AC19F4E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5g-0005tJ-QD; Wed, 24 Apr 2024 19:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5b-0005p0-Qo
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:48 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Z-0003Sm-3I
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:46 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so344153a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001504; x=1714606304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0UouwPRH3wiOAKSw9/lZXQqYu42fLT9B5DWzvUjcMtE=;
 b=QskXoIfFD9ECj4+c74073CtaV1gvF5cL170QHg/fuTcYbslFWXE8vO8IlDlTGMLDtX
 fWU6cKwiSLxh8LYQkT8Rbu0FMgkkaVL43LXDEjmPREmQUXM/pJw2LOGTcTqym4tGIjiv
 yR3yI1Bq6nt8luzoA2Vr4uKhWJ94AOcMaCNu+ytoy7ClLcpuaPSplW+VKaqqMnW72QHK
 m/6RMiJZwXeRPb6Rwjr2ZysWLt5DVf3fOfO+f18fTSyt7Wefsqr22cEh1S2wDPF1San5
 onIgfe0UeiyZ6gKhQLL7iI5n6brVB3ZyhuV9vD987z6DzaAUPgEYdU10N1dlD9GNzvFb
 5/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001504; x=1714606304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0UouwPRH3wiOAKSw9/lZXQqYu42fLT9B5DWzvUjcMtE=;
 b=xSjioeySt1t0UfXPPiVY4ACPXfTzWqCm9y0KaKdizJEP45lX0GtBhiRjlUvgv/+RzD
 BiKljGe/l1jznYi+NjqqM5l5+UIthbxqBN4AwCKi8DdHyHWFB/ERD6zIVMj+a2CPnU6n
 N7NcOf/kwerlXatXljEFnxmH42S87LxoIM/iqLO9OfYpbYjWfHlfMdtpESnD3nVwf8Vs
 SHlLr373g3fP26xCRDV80OiZmpmAyjhhJpmwXydNgQ+DyrlfL58iwKZTch0TAOaQgXsA
 7K3xpS1V7ZnmgsVFoxrcNnbJb5g7EWrzFZHuGxdJM8Dyj4SkPy/F1gSzq3l+yQh5N0vz
 wwwQ==
X-Gm-Message-State: AOJu0Yy7xxqcjEdM12z+iE+NcjHmKRk2RXGiRQ9PvED/m6CT6xXsz6CR
 +oILZ2ghs8gKf1uIf1opY6va19x8z4Vnl8+Rg3ZXXifTzgNmt/ZDD0lA7rUXmxTz6qpxFGjy5jE
 5
X-Google-Smtp-Source: AGHT+IHwttuFZDczB/4TdPgGG4Jlyv5HhRlHSYvgIlv9mryTcrnN0xDZ9SbdBr+9S2rSdawmLahlhQ==
X-Received: by 2002:a17:90b:1d0d:b0:2aa:d88d:d706 with SMTP id
 on13-20020a17090b1d0d00b002aad88dd706mr1694186pjb.4.1714001503763; 
 Wed, 24 Apr 2024 16:31:43 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/33] plugins: Read mem_only directly from TB cflags
Date: Wed, 24 Apr 2024 16:31:10 -0700
Message-Id: <20240424233131.988727-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
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
index df73312f99..5a059ce83e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -143,7 +143,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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


