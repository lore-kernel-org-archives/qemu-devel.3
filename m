Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057FCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rg-000483-BO; Wed, 15 May 2024 03:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rd-00046U-IS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ra-0001Zi-Vm
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so42159555e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759577; x=1716364377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkVl83KsOOTJGy2FEx65OPALX7XGIVav7feQhODj4vs=;
 b=sPv4zHSI0UDmJOO23daDvuX6i6g+XeTZ40oD/2ejRmjvuwueeYsgmrDtDvVblQWKso
 Z26xFx0x74UNzb2eMJAu2FeuKs8nLsumaVI8QAOKJ+b8qLIi9KBjmVRx72YSIikHNaJM
 dNgTB0GA7sx52uQBZJ7l8MBIdeZ47QaN9XTrsIGgscSU0gCKmzX5pLHpUfD70T5UvbuU
 EPv8uCzHTYARk3wNYNUrTeksnQZEhU5yt5ucVn+xOwXNaT43RE8oTpAEUcryeCLbz69+
 NxBLjygod/8tKn27ELcZxaNEfyGEzNZvMGqL6PMK3nF6Q3SOpFPGoiidTNpUd+nqlxyR
 aL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759577; x=1716364377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkVl83KsOOTJGy2FEx65OPALX7XGIVav7feQhODj4vs=;
 b=WHHfAKOmRrq2xPRAY6dWoHRPpzDyZHusJT8ZVYGvXYKaCQ9LEYef6en+fBs3j8yOSN
 EyQBBputQVTvIFH2HRsLdn1i8DzG4dYDCyMrsK3F0Uvx7T8Vi53thvUs8RextNcRXmCM
 rmLgepdmz8ipFrmD5WsIkitczDpTkqtmI2H5IzYCH4dlNSPmK41SnSa32oSxVntUs6oG
 pKMJN9L8jmmjU7A6LIn+8dFl5G2ERtxvYnCaepRtZcX7dct1/eRWLLQxeJkUVZblhDp1
 2S6kqsnWi2bZJbDKrU1lujHf5FtnBA+mN/SMG5KwtwGST08Jgtd/XO3EPASqPLt0vn8V
 5CUA==
X-Gm-Message-State: AOJu0YyX7bCvqhJ85M152ainz3rIrjJn6W5KKdxBqDehrAoqbelG8qiH
 2HhjiUxIRAXeZUWg6rHBfsHKvN9doCd1ZHGfQio+Ez+k80d4jsCsZBU9w2Mxp94mOclTgAlRQpW
 xE/0=
X-Google-Smtp-Source: AGHT+IHFSlAoAFaswa1ww372Yo6XPiu+bS4QFvM80s/7F0diyiUYXHZx8aW9xHAxtaHV8nwXgHfvkw==
X-Received: by 2002:a05:600c:4f06:b0:418:2981:c70f with SMTP id
 5b1f17b1804b1-41fbcfb8473mr160848025e9.19.1715759577586; 
 Wed, 15 May 2024 00:52:57 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/34] plugins: Read mem_only directly from TB cflags
Date: Wed, 15 May 2024 09:52:25 +0200
Message-Id: <20240515075247.68024-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index c8dd2c42fa..c28d0ca31c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -107,8 +107,6 @@ struct qemu_plugin_insn {
 
     /* if set, the instruction calls helpers that might access guest memory */
     bool mem_helper;
-
-    bool mem_only;
 };
 
 /* A scoreboard is an array of values, indexed by vcpu_index */
@@ -125,7 +123,6 @@ struct qemu_plugin_tb {
     uint64_t vaddr2;
     void *haddr1;
     void *haddr2;
-    bool mem_only;
 
     /* if set, the TB calls helpers that might access guest memory */
     bool mem_helper;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 716c8ec753..2aa1e08c17 100644
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
index 986045154c..157b447810 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -144,7 +144,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
-    plugin_enabled = plugin_gen_tb_start(cpu, db, cflags & CF_MEMI_ONLY);
+    plugin_enabled = plugin_gen_tb_start(cpu, db);
     db->plugin_enabled = plugin_enabled;
 
     while (true) {
diff --git a/plugins/api.c b/plugins/api.c
index 15467acdfd..9e4aa9d2d9 100644
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


