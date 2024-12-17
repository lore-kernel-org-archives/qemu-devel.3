Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0CFE77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 22:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNgHl-0004Ms-Mb; Tue, 17 Dec 2024 17:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHg-0004Jz-Ub
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNgHf-0001AW-98
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 17:43:20 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-728ea1573c0so5112694b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734475398; x=1735080198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fpq9JRkJksoEkEWeOYDLbD75PjoHd4ohCmD67AV53u8=;
 b=Iqk/lGhU7rni03XzBqYo/YngFsgOgKjsNKz9sSBzBeDWMEOSWAn3E91gKekUKVcAlg
 EPmKQpYo57xdsKyfAyzj4JKIqY69FUc1c/4a7rsau+f4hNz3krp0w5C6DlFwFo26qY1K
 ZkGsUEfnxr9sZ+T9bZsrr9CTZgl0nkUPnpTOAO8nrbUyvjr8l8GZ2QXnpgXoABpMHuDz
 99zDtYoXvx5j7fjPmrqP83VamhhWcT+exSJg9fzf8uL0TN1XFvSEZIZNxTKwNwFS2/2w
 WDuIg0+tON2QLA4cPQmRaw/qRqwTRcEMxc9gNdrcen7qH4Cmbfg2i/g/K9oz9niMJsoW
 C16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734475398; x=1735080198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fpq9JRkJksoEkEWeOYDLbD75PjoHd4ohCmD67AV53u8=;
 b=uoiLQ4l/wK/+pJcQ6mNfgYkyZKSXhyWZnyhP+oTwIRu28b0BFB9V4J7QJXwEkeYsst
 ZNDGyOyGzO+ypZH1rj3zljUg5ZA9D2y4ZXRAfihABe/+Cq8zHXI4hpOu+BO6iCJpPvZJ
 ap3NiOa69SvsPuprgZJ+IGE7ZFN5+M1JrTWZ617OsKAAaYSpU68qgqM4JxKP/njHZLqD
 +1HLz2JppI0xE+mdk60/60oexs2fcT9w5nmVbcbhVlVMNX83Pa1hwz+T2zI6UezZY71Q
 1R6BScwXWKv0aG2ql0rhIUB2waa2hr8TPqn/QCcO5l93hxZfZcEwZDsRfdtow2fRvX5K
 mXGg==
X-Gm-Message-State: AOJu0YxuSiYklh+9050qRx40CVnZeCrJY6a1h+bT0KVxWVihUCIEG7HK
 7fC5MiHoNeIRlTrdVIOMSAkUke7c2v4QR60nxBI/aPbNtn8/9rrYnsIweJUCvPNtlKrEHOj6qpW
 0guo=
X-Gm-Gg: ASbGncss2W2E4NyU8s5truzlOm+0wfBW+/sb7tNuqqPwHlLr8E1evA+u3ONsSJVHO24
 wgmuP9dPqhBuzx1sp7zxu85VwrSahqQ1SpXnvYpJpDcoH/k7VGThc2QHhxu5OMJQpPVv+nwZQyH
 TaoLbDc2oOrTsD+UXQ481es//IaoLwlCRC+eXbp/r6fFMJfx1vD1AO7o7WaBh/0FjKp8K7s0jd8
 oYdhT5Wd1YjCYOvQzEw68cRMrjiAewHILdjqrtuJifLIlYw7SSvMxRB
X-Google-Smtp-Source: AGHT+IEDYvJfYG57rYGxOhmIsTt0v8reNhAbSO3hpKXBG93eYpkGY5OVbt7m4JNSYv/INQFu+psG+A==
X-Received: by 2002:a05:6a00:21c6:b0:728:eb32:356c with SMTP id
 d2e1a72fcca58-72a8d2611f2mr992157b3a.11.1734475398045; 
 Tue, 17 Dec 2024 14:43:18 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac53f3sm7463214b3a.27.2024.12.17.14.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 14:43:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 08/11] contrib/plugins/cflow: fix 32-bit build
Date: Tue, 17 Dec 2024 14:43:03 -0800
Message-Id: <20241217224306.2900490-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/cflow.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index b39974d1cf3..930ecb46fcd 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -76,6 +76,8 @@ typedef struct {
 
 /* We use this to track the current execution state */
 typedef struct {
+    /* address of current translated block */
+    uint64_t tb_pc;
     /* address of end of block */
     uint64_t end_block;
     /* next pc after end of block */
@@ -85,6 +87,7 @@ typedef struct {
 } VCPUScoreBoard;
 
 /* descriptors for accessing the above scoreboard */
+static qemu_plugin_u64 tb_pc;
 static qemu_plugin_u64 end_block;
 static qemu_plugin_u64 pc_after_block;
 static qemu_plugin_u64 last_pc;
@@ -189,10 +192,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     g_mutex_init(&node_lock);
-    nodes = g_hash_table_new(NULL, g_direct_equal);
+    nodes = g_hash_table_new(g_int64_hash, g_int64_equal);
     state = qemu_plugin_scoreboard_new(sizeof(VCPUScoreBoard));
 
     /* score board declarations */
+    tb_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, tb_pc);
     end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
                                                      end_block);
     pc_after_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
@@ -215,10 +219,10 @@ static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
     NodeData *node = NULL;
 
     g_mutex_lock(&node_lock);
-    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
+    node = (NodeData *) g_hash_table_lookup(nodes, &addr);
     if (!node && create_if_not_found) {
         node = create_node(addr);
-        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
+        g_hash_table_insert(nodes, &node->addr, node);
     }
     g_mutex_unlock(&node_lock);
     return node;
@@ -234,7 +238,7 @@ static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
     uint64_t lpc = qemu_plugin_u64_get(last_pc, cpu_index);
     uint64_t ebpc = qemu_plugin_u64_get(end_block, cpu_index);
     uint64_t npc = qemu_plugin_u64_get(pc_after_block, cpu_index);
-    uint64_t pc = GPOINTER_TO_UINT(udata);
+    uint64_t pc = qemu_plugin_u64_get(tb_pc, cpu_index);
 
     /* return early for address 0 */
     if (!lpc) {
@@ -305,10 +309,11 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
      * handle both early block exits and normal branches in the
      * callback if we hit it.
      */
-    gpointer udata = GUINT_TO_POINTER(pc);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_STORE_U64, tb_pc, pc);
     qemu_plugin_register_vcpu_tb_exec_cond_cb(
         tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
-        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
+        QEMU_PLUGIN_COND_NE, pc_after_block, pc, NULL);
 
     /*
      * Now we can set start/end for this block so the next block can
-- 
2.39.5


