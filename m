Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A871C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhfo-0005gP-Ma; Mon, 11 Mar 2024 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhfm-0005ex-Ox
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:34:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjhfk-0006EO-G3
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:34:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-413183f5e11so17575855e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710171279; x=1710776079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBncdoSZmTUoP5BilG527cTjiARGsoRXwBhFtFEzxqY=;
 b=tcoo2OUnpRmQRk4IzWMBrxL05nq4aR0cMWdn3rSVkxRoC2qs1LJ3nHYOnDGrC6+UPn
 khY1azxY4nlLWoFAsBNWI3DAcrKeqeKuod45vafneex4OaZ6r4qmgKmJWt//+X3nO1YB
 TMbem/RjWZJ4RzZeGlHRpZsn4/a+kPCd5q1wiMQnSuTjHDXa7Pck8dFz9JG2krZMNRXS
 8RIr8UafF0zK82HYdN5dJKcvtWVqi/6Ji3/QAk5chox/GWF8U35+Dxx8+zlE1X/KL4MK
 9HFN7dPf84+zCcAQyRenqDgCpKkZ4DXnnwVFmZ7UO/PaAQbcKxJkDfRVsPDxkyLz6Tct
 YSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171279; x=1710776079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBncdoSZmTUoP5BilG527cTjiARGsoRXwBhFtFEzxqY=;
 b=N4TD00BB8vmKXiTIOjDR56XmDqoRaQ2X/iduEGwx/1ygEhQKX8nuurJWjhRgY4h2mf
 Mi/ltfSVVQgHTqDx6vPFSBgH+oq+HIXSA1mhb3sP8qpO0tO38ArKKCrF78JiIGjvdAL5
 KSVWfqOYj/FVLf6YHm2yV2nyjAr9zi6gTc0ACmV02nfCOoe4E4iEz2mvZF4vZP1BqMv7
 cd3iCzCqtkRXxCNHKX4ZViL+18ppK4Mct3+wkKZWC/2K8sjDzxk2W2MMjddzV/wYC/ee
 pp/H9cJQn8t+h8TIqd3vmTQGJrdY13oQYwPuFLCVfi3cTFwmHqeHO9LSTKOZShB36Yju
 uzoQ==
X-Gm-Message-State: AOJu0Yx9hNjoqdbGQbMtq0YvCxWmwCZ0CKOp2bG0s5/XYWLQziiz6eMd
 Yu+8CthWYgr6LLZESDUp8SzXHJ2VjRwRAyo8MssCXBwm6BKg7SZBq3yaNunzlTtJp9gAicMw+kC
 x
X-Google-Smtp-Source: AGHT+IE8x6Ca28rK0rydyGQSbjS2MLYbNTpOZRXkseIO4M6M+gBXygpAINDXVTbZ5cE5fQiY6GNxxA==
X-Received: by 2002:a05:600c:1991:b0:413:2704:a1c1 with SMTP id
 t17-20020a05600c199100b004132704a1c1mr4046582wmq.11.1710171278702; 
 Mon, 11 Mar 2024 08:34:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c10-20020a05600c0a4a00b004132f8c2ac1sm1157989wmq.14.2024.03.11.08.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:34:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0B0775F88D;
 Mon, 11 Mar 2024 15:34:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH] contrib/plugins: control flow plugin (WIP!)
Date: Mon, 11 Mar 2024 15:34:32 +0000
Message-Id: <20240311153432.1395190-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

This is a simple control flow tracking plugin that uses the latest
inline and conditional operations to detect and track control flow
changes. It is currently an exercise at seeing how useful the changes
are.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Based-on: 20240229055359.972151-1-pierrick.bouvier@linaro.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---
This is a work in progress. It looks like I've found a bug in the
processing of udata (see fprintf) because I see:

vcpu_tb_trans: 0x41717c
vcpu_tb_branched_exec: 0x5620a598e8a0
vcpu_tb_trans: 0x417194
vcpu_tb_trans: 0x409af0
vcpu_tb_branched_exec: 0x5620a598e8a0
vcpu_tb_trans: 0x409afc
vcpu_tb_trans: 0x423920
vcpu_tb_branched_exec: 0x5620a598e8a0
collected 1429 destination nodes in the hash table
  addr: 0x4046a4 b.hs #0x4046c8
    branches 1
      to 0xa598e8a0 (0)
  addr: 0x4019c0 bl #0x400944
    branches 12
      to 0xa598e8a0 (11)
  addr: 0x445da8 b.eq #0x445df8

so it looks like udata is always junk.
---
 contrib/plugins/cflow.c  | 344 +++++++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile |   1 +
 2 files changed, 345 insertions(+)
 create mode 100644 contrib/plugins/cflow.c

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
new file mode 100644
index 0000000000..f3ad6fd20f
--- /dev/null
+++ b/contrib/plugins/cflow.c
@@ -0,0 +1,344 @@
+/*
+ * Control Flow plugin
+ *
+ * This plugin will track changes to control flow and detect where
+ * instructions fault.
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <glib.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/* Temp hack, works for Aarch64 */
+#define INSN_WIDTH 4
+
+typedef enum {
+    SORT_HOTDEST,  /* hottest branch */
+    SORT_EARLY,    /* most early exits */
+    SORT_POPDEST,  /* most destinations */
+} ReportType;
+
+ReportType report = SORT_HOTDEST;
+int topn = 10;
+
+typedef struct {
+    uint64_t daddr;
+    uint64_t dcount;
+} DestData;
+
+/* A node is an address where we can go to multiple places */
+typedef struct {
+    GMutex lock;
+    /* address of the branch point */
+    uint64_t addr;
+    /* array of DestData */
+    GArray *dests;
+    /* early exit count */
+    uint64_t early_exit;
+    /* jump destination count */
+    uint64_t dest_count;
+    /* instruction data */
+    char *insn_disas;
+    /* times translated as last in block? */
+    int last_count;
+    /* times translated in the middle of block? */
+    int mid_count;
+} NodeData;
+
+/* We use this to track the current execution state */
+typedef struct {
+    /* address of start of block */
+    uint64_t block_start;
+    /* address of end of block */
+    uint64_t block_end;
+    /* address of last executed PC */
+    uint64_t last_pc;
+} VCPUScoreBoard;
+
+static GMutex node_lock;
+static GHashTable *nodes;
+struct qemu_plugin_scoreboard *state;
+
+/* SORT_HOTDEST */
+static gint hottest(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->dest_count > nb->dest_count ? -1 :
+        na->dest_count == nb->dest_count ? 0 : 1;
+}
+
+static gint early(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->early_exit > nb->early_exit ? -1 :
+        na->early_exit == nb->early_exit ? 0 : 1;
+}
+
+static gint popular(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->dests->len > nb->dests->len ? -1 :
+        na->dests->len == nb->dests->len ? 0 : 1;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) result = g_string_new("collected ");
+    GList *data;
+    GCompareFunc sort = &hottest;
+    int n = 0;
+
+    g_mutex_lock(&node_lock);
+    g_string_append_printf(result, "%d destination nodes in the hash table\n",
+                           g_hash_table_size(nodes));
+
+    data = g_hash_table_get_values(nodes);
+
+    switch (report) {
+    case SORT_HOTDEST:
+        sort = &hottest;
+        break;
+    case SORT_EARLY:
+        sort = &early;
+        break;
+    case SORT_POPDEST:
+        sort = &popular;
+        break;
+    }
+
+    data = g_list_sort(data, sort);
+
+    for (GList *l = data;
+         l != NULL && n < topn;
+         l = l->next, n++) {
+        NodeData *n = l->data;
+        g_string_append_printf(result, "  addr: 0x%"PRIx64 " %s\n",
+                               n->addr, n->insn_disas);
+        if (n->early_exit) {
+            g_string_append_printf(result, "    early exits %"PRId64"\n",
+                                   n->early_exit);
+        }
+        g_string_append_printf(result, "    branches %"PRId64"\n",
+                               n->dest_count);
+        for (int j = 0; j < n->dests->len; j++ ) {
+            DestData *dd = &g_array_index(n->dests, DestData, j);
+            g_string_append_printf(result, "      to 0x%"PRIx64" (%"PRId64")\n",
+                                   dd->daddr, dd->dcount);
+        }
+    }
+
+    qemu_plugin_outs(result->str);
+
+    g_mutex_unlock(&node_lock);
+}
+
+static void plugin_init(void)
+{
+    g_mutex_init(&node_lock);
+    nodes = g_hash_table_new(NULL, g_direct_equal);
+    state = qemu_plugin_scoreboard_new(sizeof(VCPUScoreBoard));
+}
+
+static NodeData *create_node(uint64_t addr)
+{
+    NodeData *node = g_new0(NodeData, 1);
+    g_mutex_init(&node->lock);
+    node->addr = addr;
+    node->dests = g_array_new(true, true, sizeof(DestData));
+    return node;
+}
+
+static NodeData *fetch_node(uint64_t addr, bool create_if_not_found)
+{
+    NodeData *node = NULL;
+
+    g_mutex_lock(&node_lock);
+    node = (NodeData *) g_hash_table_lookup(nodes, (gconstpointer) addr);
+    if (!node && create_if_not_found) {
+        node = create_node(addr);
+        g_hash_table_insert(nodes, (gpointer) addr, (gpointer) node);
+    }
+    g_mutex_unlock(&node_lock);
+    return node;
+}
+
+/* Called when we detect an early exit from a block */
+static void vcpu_tb_early_exit_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64 last_pc_entry = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, last_pc);
+    uint64_t last_pc = qemu_plugin_u64_get(last_pc_entry, cpu_index);
+    NodeData *node = fetch_node(last_pc, true);
+    g_mutex_lock(&node->lock);
+    node->early_exit++;
+    if (!node->mid_count) {
+        /* count now as we've only just allocated */
+        node->mid_count++;
+    }
+    g_mutex_unlock(&node->lock);
+}
+
+/* Called when we detect a non-linear execution */
+static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
+{
+    qemu_plugin_u64 last_pc_entry = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, last_pc);
+    uint64_t last_pc = qemu_plugin_u64_get(last_pc_entry, cpu_index);
+
+    /* return early for address 0 */
+    if (!last_pc) {
+        return;
+    }
+
+    uint64_t current_pc = GPOINTER_TO_UINT(udata);
+    NodeData *node = fetch_node(last_pc, true);
+    DestData *data = NULL;
+    GArray *dests;
+
+    /* BUG? */
+    fprintf(stderr, "%s: %p\n", __func__, udata);
+
+    g_mutex_lock(&node->lock);
+    dests = node->dests;
+    for (int i = 0; i < dests->len; i++) {
+        if (g_array_index(dests, DestData, i).daddr == current_pc) {
+            data = &g_array_index(dests, DestData, i);
+        }
+    }
+
+    /* we've never seen this before, allocate a new entry */
+    if (!data) {
+        DestData new_entry = { .daddr = current_pc };
+        g_array_append_val(dests, new_entry);
+        data = &g_array_index(dests, DestData, dests->len);
+    }
+
+    data->dcount++;
+    node->dest_count++;
+
+    g_mutex_unlock(&node->lock);
+}
+
+/*
+ * At the start of each block we need to resolve two things:
+ *
+ *  - is last_pc == block_end, if not we had an early exit
+ *  - is start of block last_pc + insn width, if not we jumped
+ *
+ * Once those are dealt with we can instrument the rest of the
+ * instructions for their execution.
+ *
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    size_t insns = qemu_plugin_tb_n_insns(tb);
+
+    /* score board declarations */
+    qemu_plugin_u64 start_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, block_start);
+    qemu_plugin_u64 end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, block_end);
+    qemu_plugin_u64 last_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, last_pc);
+
+    /*
+     * check for last_pc != block_end
+     */
+    /* qemu_plugin_register_vcpu_tb_exec_cond_cb( */
+    /*     tb, vcpu_tb_early_exit_exec, QEMU_PLUGIN_CB_NO_REGS, */
+    /*     QEMU_PLUGIN_COND_NEQ, last_pc, /\* block_end *\/, GUINT_TO_POINTER(pc)); */
+
+    /*
+     * check for pc == last_pc + insn_width
+     */
+    uint64_t pc_minus = pc - INSN_WIDTH;
+    gpointer udata = GUINT_TO_POINTER(pc);
+    /* BUG? udata getting corrupted */
+    fprintf(stderr, "%s: %p\n", __func__, udata);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_NE, last_pc, pc_minus, udata);
+
+    /*
+     * Now we can set start/end for this block so the next block can
+     * check where we are at.
+     */
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      start_block, pc);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      end_block, pc + (INSN_WIDTH * insns));
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        uint64_t ipc = qemu_plugin_insn_vaddr(insn);
+        bool last_insn = idx == (insns - 1);
+        /*
+         * If this is a potential branch point check if we could grab
+         * the disassembly for it. If it is the last instruction
+         * always create an entry.
+         */
+        NodeData *node = fetch_node(ipc, last_insn);
+        if (node) {
+            g_mutex_lock(&node->lock);
+            if (!node->insn_disas) {
+                node->insn_disas = qemu_plugin_insn_disas(insn);
+            }
+            if (last_insn) {
+                node->last_count++;
+            } else {
+                node->mid_count++;
+            }
+            g_mutex_unlock(&node->lock);
+        }
+
+        /* Store the PC of what we are about to execute */
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            last_pc, ipc);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "sort") == 0) {
+            if (g_strcmp0(tokens[1], "hottest") == 0) {
+                report = SORT_HOTDEST;
+            } else if (g_strcmp0(tokens[1], "early") == 0) {
+                report = SORT_EARLY;
+            } else if (g_strcmp0(tokens[1], "popular") == 0) {
+                report = SORT_POPDEST;
+            } else {
+                fprintf(stderr, "failed to parse: %s\n", tokens[1]);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 0b64d2c1e3..78dc7407a5 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -27,6 +27,7 @@ endif
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+NAMES += cflow
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.2


