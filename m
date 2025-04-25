Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBFAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1u-0005dP-TQ; Fri, 25 Apr 2025 11:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1U-0004JD-Sz
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L1R-00043K-QY
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:31:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso16277995e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595084; x=1746199884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xGHuCsRdje5pcdO5UsvJlrtmSn8pTXFr/0z+13dWE0=;
 b=X2meCIDiqh7i37aO0A/AkFB1SUkHC1tJhWWtpzYO3Rg++Vgg1fY/jMDf8Ol1sbQDV+
 wfLE2vQhxRxb/Cy5rnDy/5VSGnOHCqBEJnHNksuyEvksgDczy2kBKFnx8+/gDOTFCr/t
 xuxAUzecHQZOKQdD14uD6sT3QMfuvsnjqUEE4G+4ZhqxRVTHiQuB2BhE0X3N7H5rk+N/
 paIqxu63PFosyMZgqGN1wnbSwPacOlbY8fD4m17nDH6MUahto+wLp1I6ojTgtfus00Xx
 kG374Ff1IhYjkU2UCCJniDafqFrLtpX4tvgF9jX1MvIQiVLuQUtQa2zEL7b+yUb3J27I
 nEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595084; x=1746199884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xGHuCsRdje5pcdO5UsvJlrtmSn8pTXFr/0z+13dWE0=;
 b=po8YBmcY9Wxh89ER72ATwZMEVQdXmBlZwOgXfFRUBPvvucrwLDkAXVAVav8+MGUPas
 mpgIsdO2j99WRF0oGWHBRRBVpVifhz+gwtM1vmtIwrI4qTEzfjJ4HcIstekBK0qW6/1T
 yLqb/oviqYJG7uXK9ACTMpbUSD6QQkMrEb3US7W2FjQKHUImRizCT1XrODK7nsoSQyyP
 Ndxcmd/L/8ljrGtNEOv2ehnSJWnoqsH4LmVdBp8LS74UyJVbeUHKgSCDO/Yc8aZjyCQP
 k/Y+67DSLxbBi7u+gNd0CSDd8FDs0bLeoei09c3nsThnL1idDtbl2vGwi42xgqbefCDC
 IOBw==
X-Gm-Message-State: AOJu0YzHQXx9AuIE1nl+zVnEh8WliNhH/kNy581rml0u4WTfcLnLVsRs
 JN11lrvfM3w8GspGgHjk9ilBJq3J6cjzULQ9H3DlSceQl0MUsfY9plJ3W4XZQwiMK7HUeVn8EhA
 A
X-Gm-Gg: ASbGncsrBfrOxXnyLFB8avRlYADTOgdV04inJvIJ2kTEp0h1fR5eIaX9dfMfHgKmB8Z
 1vDqWSesqVxVCkgkzQhOzkrca6kd+8ZCvOl7hkmge7Sj9JBW+9Q9hW7dNE6Ue9pcTULlUq/uWOa
 CFP+4K4HD8KxR3ulO/CykZoGF+aqjR37fTNowWRd3PT6/qezEM8goad6t3+4o8eizx9ynRoWXaB
 yDl+4QU3L8wfOfdkTIt6fVJhFHp2lLiu4eBhnFVaINc6irFF01n/6KpzLuDZlpNfw4pNRx9cWhK
 Tw1DAqLcv4bGSWklJMqc1R19SqmqK768APfuteFQgXsyoyn47h2gjMJEID8O72XQN1oamaqid+D
 XINEhrUOGfjsYC3o=
X-Google-Smtp-Source: AGHT+IFd7Up1iEO+x63BwueZ3Tq0LxY4XlzGbwie5OAw/gU6pVoVrGJfKdzQSuFGK+G0TcPwPxtAsQ==
X-Received: by 2002:a05:600c:1c1e:b0:43b:ca8c:fca3 with SMTP id
 5b1f17b1804b1-440a6693ad8mr22416055e9.11.1745595083694; 
 Fri, 25 Apr 2025 08:31:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c9cdsm2618984f8f.87.2025.04.25.08.31.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:31:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/58] contrib/plugins: Fix type conflict of GLib function
 pointers
Date: Fri, 25 Apr 2025 17:28:16 +0200
Message-ID: <20250425152843.69638-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 contrib/plugins/cache.c     | 12 ++++++------
 contrib/plugins/cflow.c     | 10 +++++-----
 contrib/plugins/hotblocks.c |  4 ++--
 contrib/plugins/hotpages.c  |  4 ++--
 contrib/plugins/howvec.c    |  4 ++--
 contrib/plugins/hwprofile.c |  8 ++++----
 tests/tcg/plugins/mem.c     |  4 ++--
 tests/tcg/plugins/syscall.c |  4 ++--
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 7cfd3df249e..56508587d3a 100644
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
index 930ecb46fcd..b5e33f25f9b 100644
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
index f12bfb7a267..98404b68852 100644
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
index c6e64937194..9d48ac969eb 100644
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
index 2aa9029c3f0..42bddb6566d 100644
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
index 2a4cbc47d40..a9838ccc879 100644
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
index d87d6628e09..ca4e8883dd2 100644
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
index 47aad55fc1b..42801f5c863 100644
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
2.47.1


