Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E17112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L5M-0004cD-GN; Wed, 11 Mar 2026 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L53-0004Qk-Ab; Wed, 11 Mar 2026 11:02:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L4z-0003kQ-D7; Wed, 11 Mar 2026 11:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241303; bh=eij2pWfI5TS+5Aj8jultDnPDfshAPOG6s6Q3bP+Yw1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gV+0Q8Er9Vp6kw9Tj8PGlLTYrdBHfXN0vZWCFaFRLC8vmnMunILJHApQKHF+EB0iF
 k5GZ4Y9xRXXapb0kEoEQQyVf/C0bDmqcyAkLatsoGCC7bAF8+YNz7Bx3dmz8HxjZci
 z0fpQFxBzq4IjPRBXji1hR42cVhJxJdl/Li5Sq3Ek9vmBK6REuXfFU+ewwlquFd2Dg
 kfWZDatf80AiPpXspWVrM2iU28a/8g9ogubr/jzJebk7Paj9OIG7PFMtM7Ztuosl22
 YoAsyZEbPVxgnyRn0jPbpZACzGmP8eD4KYyPv6TC8IDwtImltzAbEc+80xJr/b715p
 h7TjR9YSmMmpw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 73631191E42;
 Wed, 11 Mar 2026 18:01:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5EA7137C294;
 Wed, 11 Mar 2026 18:02:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 04/44] contrib/plugins: Fix type conflict of GLib
 function pointers
Date: Wed, 11 Mar 2026 18:01:36 +0300
Message-ID: <20260311150221.1084186-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <0fcddfca16ca8da2bdaa7b2c114476f5b73d032b.1745295397.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 01499add2ae6529589002860e1880ff193a6578a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 7cfd3df249..56508587d3 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -576,7 +576,7 @@ static void sum_stats(void)
     }
 }
 
-static int dcmp(gconstpointer a, gconstpointer b)
+static int dcmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -584,7 +584,7 @@ static int dcmp(gconstpointer a, gconstpointer b)
     return insn_a->l1_dmisses < insn_b->l1_dmisses ? 1 : -1;
 }
 
-static int icmp(gconstpointer a, gconstpointer b)
+static int icmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -592,7 +592,7 @@ static int icmp(gconstpointer a, gconstpointer b)
     return insn_a->l1_imisses < insn_b->l1_imisses ? 1 : -1;
 }
 
-static int l2_cmp(gconstpointer a, gconstpointer b)
+static int l2_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnData *insn_a = (InsnData *) a;
     InsnData *insn_b = (InsnData *) b;
@@ -645,7 +645,7 @@ static void log_top_insns(void)
     InsnData *insn;
 
     miss_insns = g_hash_table_get_values(miss_ht);
-    miss_insns = g_list_sort(miss_insns, dcmp);
+    miss_insns = g_list_sort_with_data(miss_insns, dcmp, NULL);
     g_autoptr(GString) rep = g_string_new("");
     g_string_append_printf(rep, "%s", "address, data misses, instruction\n");
 
@@ -659,7 +659,7 @@ static void log_top_insns(void)
                                insn->l1_dmisses, insn->disas_str);
     }
 
-    miss_insns = g_list_sort(miss_insns, icmp);
+    miss_insns = g_list_sort_with_data(miss_insns, icmp, NULL);
     g_string_append_printf(rep, "%s", "\naddress, fetch misses, instruction\n");
 
     for (curr = miss_insns, i = 0; curr && i < limit; i++, curr = curr->next) {
@@ -676,7 +676,7 @@ static void log_top_insns(void)
         goto finish;
     }
 
-    miss_insns = g_list_sort(miss_insns, l2_cmp);
+    miss_insns = g_list_sort_with_data(miss_insns, l2_cmp, NULL);
     g_string_append_printf(rep, "%s", "\naddress, L2 misses, instruction\n");
 
     for (curr = miss_insns, i = 0; curr && i < limit; i++, curr = curr->next) {
diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 930ecb46fc..b5e33f25f9 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -98,7 +98,7 @@ static GHashTable *nodes;
 struct qemu_plugin_scoreboard *state;
 
 /* SORT_HOTTEST */
-static gint hottest(gconstpointer a, gconstpointer b)
+static gint hottest(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -107,7 +107,7 @@ static gint hottest(gconstpointer a, gconstpointer b)
         na->dest_count == nb->dest_count ? 0 : 1;
 }
 
-static gint exception(gconstpointer a, gconstpointer b)
+static gint exception(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -116,7 +116,7 @@ static gint exception(gconstpointer a, gconstpointer b)
         na->early_exit == nb->early_exit ? 0 : 1;
 }
 
-static gint popular(gconstpointer a, gconstpointer b)
+static gint popular(gconstpointer a, gconstpointer b, gpointer d)
 {
     NodeData *na = (NodeData *) a;
     NodeData *nb = (NodeData *) b;
@@ -138,7 +138,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) result = g_string_new("collected ");
     GList *data;
-    GCompareFunc sort = &hottest;
+    GCompareDataFunc sort = &hottest;
     int i = 0;
 
     g_mutex_lock(&node_lock);
@@ -162,7 +162,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         break;
     }
 
-    data = g_list_sort(data, sort);
+    data = g_list_sort_with_data(data, sort, NULL);
 
     for (GList *l = data;
          l != NULL && i < topn;
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index f12bfb7a26..98404b6885 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -39,7 +39,7 @@ typedef struct {
     unsigned long insns;
 } ExecCount;
 
-static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+static gint cmp_exec_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
@@ -79,7 +79,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
-    it = g_list_sort(counts, cmp_exec_count);
+    it = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (it) {
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index c6e6493719..9d48ac969e 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -48,7 +48,7 @@ typedef struct {
 static GMutex lock;
 static GHashTable *pages;
 
-static gint cmp_access_count(gconstpointer a, gconstpointer b)
+static gint cmp_access_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     PageCounters *ea = (PageCounters *) a;
     PageCounters *eb = (PageCounters *) b;
@@ -83,7 +83,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (counts && g_list_next(counts)) {
         GList *it;
 
-        it = g_list_sort(counts, cmp_access_count);
+        it = g_list_sort_with_data(counts, cmp_access_count, NULL);
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
             PageCounters *rec = (PageCounters *) it->data;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 2aa9029c3f..42bddb6566 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -155,7 +155,7 @@ static ClassSelector class_tables[] = {
 static InsnClassExecCount *class_table;
 static int class_table_sz;
 
-static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+static gint cmp_exec_count(gconstpointer a, gconstpointer b, gpointer d)
 {
     InsnExecCount *ea = (InsnExecCount *) a;
     InsnExecCount *eb = (InsnExecCount *) b;
@@ -208,7 +208,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     counts = g_hash_table_get_values(insns);
     if (counts && g_list_next(counts)) {
         g_string_append_printf(report, "Individual Instructions:\n");
-        counts = g_list_sort(counts, cmp_exec_count);
+        counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
         for (i = 0; i < limit && g_list_next(counts);
              i++, counts = g_list_next(counts)) {
diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index 2a4cbc47d4..a9838ccc87 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -71,7 +71,7 @@ static void plugin_init(void)
     devices = g_hash_table_new(NULL, NULL);
 }
 
-static gint sort_cmp(gconstpointer a, gconstpointer b)
+static gint sort_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     DeviceCounts *ea = (DeviceCounts *) a;
     DeviceCounts *eb = (DeviceCounts *) b;
@@ -79,7 +79,7 @@ static gint sort_cmp(gconstpointer a, gconstpointer b)
            eb->totals.reads + eb->totals.writes ? -1 : 1;
 }
 
-static gint sort_loc(gconstpointer a, gconstpointer b)
+static gint sort_loc(gconstpointer a, gconstpointer b, gpointer d)
 {
     IOLocationCounts *ea = (IOLocationCounts *) a;
     IOLocationCounts *eb = (IOLocationCounts *) b;
@@ -126,13 +126,13 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (counts && g_list_next(counts)) {
         GList *it;
 
-        it = g_list_sort(counts, sort_cmp);
+        it = g_list_sort_with_data(counts, sort_cmp, NULL);
 
         while (it) {
             DeviceCounts *rec = (DeviceCounts *) it->data;
             if (rec->detail) {
                 GList *accesses = g_hash_table_get_values(rec->detail);
-                GList *io_it = g_list_sort(accesses, sort_loc);
+                GList *io_it = g_list_sort_with_data(accesses, sort_loc, NULL);
                 const char *prefix = pattern ? "off" : "pc";
                 g_string_append_printf(report, "%s @ 0x%"PRIx64"\n",
                                        rec->name, rec->base);
diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index d87d6628e0..ca4e8883dd 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -67,7 +67,7 @@ static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
 static GMutex lock;
 static GHashTable *regions;
 
-static gint addr_order(gconstpointer a, gconstpointer b)
+static gint addr_order(gconstpointer a, gconstpointer b, gpointer d)
 {
     RegionInfo *na = (RegionInfo *) a;
     RegionInfo *nb = (RegionInfo *) b;
@@ -94,7 +94,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (do_region_summary) {
         GList *counts = g_hash_table_get_values(regions);
 
-        counts = g_list_sort(counts, addr_order);
+        counts = g_list_sort_with_data(counts, addr_order, NULL);
 
         g_string_printf(out, "Region Base, Reads, Writes, Seen all\n");
 
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 47aad55fc1..42801f5c86 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -180,7 +180,7 @@ static void print_entry(gpointer val, gpointer user_data)
     qemu_plugin_outs(out);
 }
 
-static gint comp_func(gconstpointer ea, gconstpointer eb)
+static gint comp_func(gconstpointer ea, gconstpointer eb, gpointer d)
 {
     SyscallStats *ent_a = (SyscallStats *) ea;
     SyscallStats *ent_b = (SyscallStats *) eb;
@@ -197,7 +197,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     g_mutex_lock(&lock);
     GList *entries = g_hash_table_get_values(statistics);
-    entries = g_list_sort(entries, comp_func);
+    entries = g_list_sort_with_data(entries, comp_func, NULL);
     qemu_plugin_outs("syscall no.  calls  errors\n");
 
     g_list_foreach(entries, print_entry, NULL);
-- 
2.47.3


