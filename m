Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC510C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojfB-0000LM-H8; Mon, 25 Mar 2024 08:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojef-00005p-S4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:25 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rojee-0006fu-3J
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:42:21 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51381021af1so6632276e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370537; x=1711975337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cou8ZHLxFtHbxq//TR+XjCD6vcNQOpnA7W/aP2xbs5E=;
 b=s2gLSEd0p+WoFYugw+0hM0OTFI6UzykR7cVoy6AaULxDorbzFoozrbI+YyIpmDTyfS
 5VCzE6kEosRzzBTb5u6SX8OfdBvnfTmgHFK131NRmLoMa1A9jy+1gkCAy/OOs8b4MyXJ
 FY2TNiwohjLbYw+VUwvzKpjW2G3/dr97kPM/X5cWlKeHs0Cru3LRTTQfh26wMnTQHceo
 0i55WORRupxMxyQcuvconW3pxYKuybrgG6chSbej3bp7vtxiBQCTYzRIIueD/+hszmEW
 mIGg0Idex8jo2I1ZP03f81izePHWDwnut5N34rZB40XBK15gPbtdBVFCmTVaolZTNnCV
 H5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370537; x=1711975337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cou8ZHLxFtHbxq//TR+XjCD6vcNQOpnA7W/aP2xbs5E=;
 b=Qo49amF6341XFq8iZADIqSb4QfCOKiova6fMiP+fspqtKiJutOV72jXW40waTOA5d4
 huMdCmY3gZPDgQ3csk+iDi8P9mD1VnvHV6nRjdnfR3dDIfZrJlfHXe6SAFQ+4SWqkTdQ
 zbs009mn4Z9qVjqwqTrixCzu3+5iq839rwM4EpK4RCL/Nb4xDZkY/zVBbyQ7oiYHrUyj
 FxYdPSCPWYCTa0UQCVUU3AHB4irLBdvu6pq/hrsQSqNsrBjLVmzKOIxamWFICLH3mg0G
 asibE45LFP6811UK/EZWRjGHpNdgfYI/PPUndPR+fitfMfT/lPBmTzrQ4Q+PGHMsrqel
 9+bg==
X-Gm-Message-State: AOJu0Yzl+jDCmyjG8xIftFTHMHgIaZP+WOKwDBOk/OyXoIwm5ITRvK1I
 9r0zfoTsQHXVHfK8DpSHIdnhj4cmSqRCGQrdUL1f1XpMNgDDwKtjf1LLPWmWWfeRFBqh1w/jnFz
 Q
X-Google-Smtp-Source: AGHT+IG2lehQGtZ/24Sdy+uX3nskI4hdRwr14BjPCIvFvOOPezEeghWBeBh+YXdlbbByyVv3D5KtjQ==
X-Received: by 2002:a19:2d5a:0:b0:513:c61c:7331 with SMTP id
 t26-20020a192d5a000000b00513c61c7331mr5833999lft.3.1711370537542; 
 Mon, 25 Mar 2024 05:42:17 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 t20-20020ac243b4000000b00515b1b3a2bdsm35231lfl.194.2024.03.25.05.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:42:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 4/8] tests/plugin/inline: add test for STORE_U64 inline op
Date: Mon, 25 Mar 2024 16:41:47 +0400
Message-Id: <20240325124151.336003-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x135.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
index 0163e9b51c5..103c3a22f6e 100644
--- a/tests/plugin/inline.c
+++ b/tests/plugin/inline.c
@@ -22,6 +22,12 @@ typedef struct {
     uint64_t count_mem_inline;
 } CPUCount;
 
+typedef struct {
+    uint64_t data_insn;
+    uint64_t data_tb;
+    uint64_t data_mem;
+} CPUData;
+
 static struct qemu_plugin_scoreboard *counts;
 static qemu_plugin_u64 count_tb;
 static qemu_plugin_u64 count_tb_inline;
@@ -29,6 +35,10 @@ static qemu_plugin_u64 count_insn;
 static qemu_plugin_u64 count_insn_inline;
 static qemu_plugin_u64 count_mem;
 static qemu_plugin_u64 count_mem_inline;
+static struct qemu_plugin_scoreboard *data;
+static qemu_plugin_u64 data_insn;
+static qemu_plugin_u64 data_tb;
+static qemu_plugin_u64 data_mem;
 
 static uint64_t global_count_tb;
 static uint64_t global_count_insn;
@@ -109,11 +119,13 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
     stats_mem();
 
     qemu_plugin_scoreboard_free(counts);
+    qemu_plugin_scoreboard_free(data);
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_tb, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_tb, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&tb_lock);
     max_cpu_index = MAX(max_cpu_index, cpu_index);
     global_count_tb++;
@@ -123,6 +135,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 {
     qemu_plugin_u64_add(count_insn, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_insn, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&insn_lock);
     global_count_insn++;
     g_mutex_unlock(&insn_lock);
@@ -131,9 +144,10 @@ static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
 static void vcpu_mem_access(unsigned int cpu_index,
                             qemu_plugin_meminfo_t info,
                             uint64_t vaddr,
-                            void *userdata)
+                            void *udata)
 {
     qemu_plugin_u64_add(count_mem, cpu_index, 1);
+    g_assert(qemu_plugin_u64_get(data_mem, cpu_index) == (uintptr_t) udata);
     g_mutex_lock(&mem_lock);
     global_count_mem++;
     g_mutex_unlock(&mem_lock);
@@ -141,20 +155,34 @@ static void vcpu_mem_access(unsigned int cpu_index,
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
+    void *tb_store = tb;
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_STORE_U64, data_tb, (uintptr_t) tb_store);
     qemu_plugin_register_vcpu_tb_exec_cb(
-        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, tb_store);
     qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
         tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
 
     for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        void *insn_store = insn;
+        void *mem_store = (char *)insn_store + 0xff;
+
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_STORE_U64, data_insn,
+            (uintptr_t) insn_store);
         qemu_plugin_register_vcpu_insn_exec_cb(
-            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
+            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, insn_store);
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
             insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
+
+        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+            insn, QEMU_PLUGIN_MEM_RW,
+            QEMU_PLUGIN_INLINE_STORE_U64,
+            data_mem, (uintptr_t) mem_store);
         qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
                                          QEMU_PLUGIN_CB_NO_REGS,
-                                         QEMU_PLUGIN_MEM_RW, 0);
+                                         QEMU_PLUGIN_MEM_RW, mem_store);
         qemu_plugin_register_vcpu_mem_inline_per_vcpu(
             insn, QEMU_PLUGIN_MEM_RW,
             QEMU_PLUGIN_INLINE_ADD_U64,
@@ -179,6 +207,11 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         counts, CPUCount, count_insn_inline);
     count_mem_inline = qemu_plugin_scoreboard_u64_in_struct(
         counts, CPUCount, count_mem_inline);
+    data = qemu_plugin_scoreboard_new(sizeof(CPUData));
+    data_insn = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_insn);
+    data_tb = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_tb);
+    data_mem = qemu_plugin_scoreboard_u64_in_struct(data, CPUData, data_mem);
+
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-- 
2.39.2


