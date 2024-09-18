Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4549DCDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tQ-0004pw-DO; Wed, 18 Sep 2024 17:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tO-0004oJ-Mt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tM-0001ZV-6h
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c27067b81aso204088a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693634; x=1727298434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diSn4mrhaw+TlxcBATzSgJEMltlc4QxqrTJlAiDxcps=;
 b=krwoDnY0dveSxZZ7nrK1k3bCBFs8LDTBcIMd3Q2JALP2d+situWw34RlSraP/J+04+
 frk4YGPyXJz26f18izEssOot9M0aMUDpv1A6y72nCqEEs3LtF1esxvpNSrjBgs5EqBR4
 V621+6NlAHLsxT4c4Pkl6qn0Dk99enTIwkKRr0aoSZf1gLGVA9Ninn/1UYB7/Yi+HOIg
 OS02JngkVvQs2Zuso6ZEFZehgdZ0XXCLOwq4LbAxdgWwEpUoImTHFfSEfBmYLZfDDTLz
 tPUzU254geJfi2uwlwfeNup+5tgUBGSupB/62ekou1lJIs9yYHwy7Pk25tgwaUeniAcd
 VTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693634; x=1727298434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diSn4mrhaw+TlxcBATzSgJEMltlc4QxqrTJlAiDxcps=;
 b=Xr2s3zI0jCngK4tj/j/htW/1KoseutJ5WhtDa8+2rGkY16NsnixoHIx3cPw/ZKtVDd
 Q0JbS4ec9JB7+ZZWwXRy6LNkBb6XTXgABo6Rr5XfRyaQUEJ7wFnUykmZgVoiP1amIqzt
 bL0kYRHa4Xkl0mXAVYzhpF7dftGvsgB0dZmlfMJU7Hi3/LMxyzABQ98NZuAtvb7NoHA5
 b5VEpCsvBh0cHBjLG/tdqjd2HuwuDrCJKWTifdxAjdmgFdzjv86QgycF+QEYXop7+iXz
 Zd97LJ+8vd7gdVX3HItvE0sAex3N/V+p9gskBew4OkSP6nyCY78oEcc6tvCM28hWoQ8Q
 nhhw==
X-Gm-Message-State: AOJu0YyhLxqqQ7QDpxTMyc1xYWqO4GZnS206EH8Tw1aNijZ9Ms7OVbbb
 LSKG3UsF9EmYvZBYFlWg0++rhC+7M+X6sLfs3ZP/N9a83B+VaaAR9JlubDHyuIiGxSbmreT8Y4C
 D2zk=
X-Google-Smtp-Source: AGHT+IEeyhF4/+RG/b4mwRldmhB34hffYtf9ww9o3eWV+VRBBkb0dJk4fhHQ+HCAK2SeN3zRH9F/yQ==
X-Received: by 2002:a17:907:9443:b0:a7d:a00a:a9fe with SMTP id
 a640c23a62f3a-a9047ca9533mr1919028866b.17.1726693634166; 
 Wed, 18 Sep 2024 14:07:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612e56a1sm642408566b.171.2024.09.18.14.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84A235F8DA;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 03/18] contrib/plugins: control flow plugin
Date: Wed, 18 Sep 2024 22:06:57 +0100
Message-Id: <20240918210712.2336854-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

This is a simple control flow tracking plugin that uses the latest
inline and conditional operations to detect and track control flow
changes. It is currently an exercise at seeing how useful the changes
are.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-4-alex.bennee@linaro.org>

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
new file mode 100644
index 0000000000..6faa55d10d
--- /dev/null
+++ b/contrib/plugins/cflow.c
@@ -0,0 +1,388 @@
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
+typedef enum {
+    SORT_HOTTEST,  /* hottest branch insn */
+    SORT_EXCEPTION,    /* most early exits */
+    SORT_POPDEST,  /* most destinations (usually ret's) */
+} ReportType;
+
+ReportType report = SORT_HOTTEST;
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
+    /* early exit/fault count */
+    uint64_t early_exit;
+    /* jump destination count */
+    uint64_t dest_count;
+    /* instruction data */
+    char *insn_disas;
+    /* symbol? */
+    const char *symbol;
+    /* times translated as last in block? */
+    int last_count;
+    /* times translated in the middle of block? */
+    int mid_count;
+} NodeData;
+
+typedef enum {
+    /* last insn in block, expected flow control */
+    LAST_INSN = (1 << 0),
+    /* mid-block insn, can only be an exception */
+    EXCP_INSN = (1 << 1),
+    /* multiple disassembly, may have changed */
+    MULT_INSN = (1 << 2),
+} InsnTypes;
+
+typedef struct {
+    /* address of the branch point */
+    uint64_t addr;
+    /* disassembly */
+    char *insn_disas;
+    /* symbol? */
+    const char *symbol;
+    /* types */
+    InsnTypes type_flag;
+} InsnData;
+
+/* We use this to track the current execution state */
+typedef struct {
+    /* address of end of block */
+    uint64_t end_block;
+    /* next pc after end of block */
+    uint64_t pc_after_block;
+    /* address of last executed PC */
+    uint64_t last_pc;
+} VCPUScoreBoard;
+
+/* descriptors for accessing the above scoreboard */
+static qemu_plugin_u64 end_block;
+static qemu_plugin_u64 pc_after_block;
+static qemu_plugin_u64 last_pc;
+
+
+static GMutex node_lock;
+static GHashTable *nodes;
+struct qemu_plugin_scoreboard *state;
+
+/* SORT_HOTTEST */
+static gint hottest(gconstpointer a, gconstpointer b)
+{
+    NodeData *na = (NodeData *) a;
+    NodeData *nb = (NodeData *) b;
+
+    return na->dest_count > nb->dest_count ? -1 :
+        na->dest_count == nb->dest_count ? 0 : 1;
+}
+
+static gint exception(gconstpointer a, gconstpointer b)
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
+/* Filter out non-branches - returns true to remove entry */
+static gboolean filter_non_branches(gpointer key, gpointer value,
+                                    gpointer user_data)
+{
+    NodeData *node = (NodeData *) value;
+
+    return node->dest_count == 0;
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
+    g_string_append_printf(result, "%d control flow nodes in the hash table\n",
+                           g_hash_table_size(nodes));
+
+    /* remove all nodes that didn't branch */
+    g_hash_table_foreach_remove(nodes, filter_non_branches, NULL);
+
+    data = g_hash_table_get_values(nodes);
+
+    switch (report) {
+    case SORT_HOTTEST:
+        sort = &hottest;
+        break;
+    case SORT_EXCEPTION:
+        sort = &exception;
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
+        const char *type = n->mid_count ? "sync fault" : "branch";
+        g_string_append_printf(result, "  addr: 0x%"PRIx64 " %s: %s (%s)\n",
+                               n->addr, n->symbol, n->insn_disas, type);
+        if (n->early_exit) {
+            g_string_append_printf(result, "    early exits %"PRId64"\n",
+                                   n->early_exit);
+        }
+        g_string_append_printf(result, "    branches %"PRId64"\n",
+                               n->dest_count);
+        for (int j = 0; j < n->dests->len; j++) {
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
+
+    /* score board declarations */
+    end_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
+                                                     end_block);
+    pc_after_block = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
+                                                          pc_after_block);
+    last_pc = qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard,
+                                                   last_pc);
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
+/*
+ * Called when we detect a non-linear execution (pc !=
+ * pc_after_block). This could be due to a fault causing some sort of
+ * exit exception (if last_pc != block_end) or just a taken branch.
+ */
+static void vcpu_tb_branched_exec(unsigned int cpu_index, void *udata)
+{
+    uint64_t lpc = qemu_plugin_u64_get(last_pc, cpu_index);
+    uint64_t ebpc = qemu_plugin_u64_get(end_block, cpu_index);
+    uint64_t npc = qemu_plugin_u64_get(pc_after_block, cpu_index);
+    uint64_t pc = GPOINTER_TO_UINT(udata);
+
+    /* return early for address 0 */
+    if (!lpc) {
+        return;
+    }
+
+    NodeData *node = fetch_node(lpc, true);
+    DestData *data = NULL;
+    bool early_exit = (lpc != ebpc);
+    GArray *dests;
+
+    /* the condition should never hit */
+    g_assert(pc != npc);
+
+    g_mutex_lock(&node->lock);
+
+    if (early_exit) {
+        fprintf(stderr, "%s: pc=%"PRIx64", epbc=%"PRIx64
+                " npc=%"PRIx64", lpc=%"PRIx64"\n",
+                __func__, pc, ebpc, npc, lpc);
+        node->early_exit++;
+        if (!node->mid_count) {
+            /* count now as we've only just allocated */
+            node->mid_count++;
+        }
+    }
+
+    dests = node->dests;
+    for (int i = 0; i < dests->len; i++) {
+        if (g_array_index(dests, DestData, i).daddr == pc) {
+            data = &g_array_index(dests, DestData, i);
+        }
+    }
+
+    /* we've never seen this before, allocate a new entry */
+    if (!data) {
+        DestData new_entry = { .daddr = pc };
+        g_array_append_val(dests, new_entry);
+        data = &g_array_index(dests, DestData, dests->len - 1);
+        g_assert(data->daddr == pc);
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
+    struct qemu_plugin_insn *first_insn = qemu_plugin_tb_get_insn(tb, 0);
+    struct qemu_plugin_insn *last_insn = qemu_plugin_tb_get_insn(tb, insns - 1);
+
+    /*
+     * check if we are executing linearly after the last block. We can
+     * handle both early block exits and normal branches in the
+     * callback if we hit it.
+     */
+    gpointer udata = GUINT_TO_POINTER(pc);
+    qemu_plugin_register_vcpu_tb_exec_cond_cb(
+        tb, vcpu_tb_branched_exec, QEMU_PLUGIN_CB_NO_REGS,
+        QEMU_PLUGIN_COND_NE, pc_after_block, pc, udata);
+
+    /*
+     * Now we can set start/end for this block so the next block can
+     * check where we are at. Do this on the first instruction and not
+     * the TB so we don't get mixed up with above.
+     */
+    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      end_block, qemu_plugin_insn_vaddr(last_insn));
+    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
+                                                      QEMU_PLUGIN_INLINE_STORE_U64,
+                                                      pc_after_block,
+                                                      qemu_plugin_insn_vaddr(last_insn) +
+                                                      qemu_plugin_insn_size(last_insn));
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        uint64_t ipc = qemu_plugin_insn_vaddr(insn);
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
+            if (!node->symbol) {
+                node->symbol = qemu_plugin_insn_symbol(insn);
+            }
+            if (last_insn == insn) {
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
+                report = SORT_HOTTEST;
+            } else if (g_strcmp0(tokens[1], "early") == 0) {
+                report = SORT_EXCEPTION;
+            } else if (g_strcmp0(tokens[1], "exceptions") == 0) {
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
index 05a2a45c5c..d4ac599f93 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -29,6 +29,7 @@ NAMES += cache
 NAMES += drcov
 NAMES += ips
 NAMES += stoptrigger
+NAMES += cflow
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
-- 
2.39.5


