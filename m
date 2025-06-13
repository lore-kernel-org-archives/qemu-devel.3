Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4DC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 07:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPzDT-00043S-Mv; Fri, 13 Jun 2025 03:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uPzDO-00041K-Tt
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:52:42 -0400
Received: from [115.124.28.172] (helo=out28-172.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uPzDJ-0007KX-0I
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:52:42 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.dKtfGXS_1749801019 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 13 Jun 2025 15:50:19 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, armbru@redhat.com, balaton@eik.bme.hu
Cc: lc00631@tecorigin.com,
	chao.liu@yeah.net,
	qemu-devel@nongnu.org
Subject: [PATCH v7 1/1] system: improve visual representation of node
 hierarchy in 'info mtree' output for qemu monitor
Date: Fri, 13 Jun 2025 15:49:29 +0800
Message-ID: <2988074841b313decea5f5b9b2fc566b5e4eeadd.1749800810.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1749800810.git.chao.liu@yeah.net>
References: <cover.1749800810.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.172 (deferred)
Received-SPF: pass client-ip=115.124.28.172;
 envelope-from=lc00631@tecorigin.com; helo=out28-172.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

From: Chao Liu <chao.liu@yeah.net>

Make the hierarchical relationship between nodes clearer by adding characters.

e.g.

```
$ qemu-system-riscv64 -M virt -monitor stdio -display none
(qemu) info mtree -v

...
address-space: memory
`- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
   |- 0000000000001000-000000000000ffff (prio 0, rom): riscv_virt_board.mrom
...
   |- 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
   |  `- 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
   |- 0000000004000000-0000000005ffffff (prio 0, i/o): platform bus
...
   |- 0000000080000000-0000000087ffffff (prio 0, ram): riscv_virt_board.ram
   `- 0000000400000000-00000007ffffffff (prio 0, i/o): alias pcie-mmio-high @gpex_mmio_window
```

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hmp-commands-info.hx    |   5 +-
 include/system/memory.h |   3 +-
 monitor/hmp-cmds.c      |   3 +-
 system/memory.c         | 150 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 143 insertions(+), 18 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee5..a1b098d4ac 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -228,10 +228,11 @@ ERST
 
     {
         .name       = "mtree",
-        .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
-        .params     = "[-f][-d][-o][-D]",
+        .args_type  = "flatview:-f,dispatch_tree:-d,treeview:-t,owner:-o,disabled:-D",
+        .params     = "[-f][-d][-t][-o][-D]",
         .help       = "show memory tree (-f: dump flat view for address spaces;"
                       "-d: dump dispatch tree, valid with -f only);"
+                      "-t: dump tree node characters before memory regions;"
                       "-o: dump region owners/parents;"
                       "-D: dump disabled regions",
         .cmd        = hmp_info_mtree,
diff --git a/include/system/memory.h b/include/system/memory.h
index 0848690ea4..3bb9c3e2dd 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2576,7 +2576,8 @@ bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
  */
 void memory_global_dirty_log_stop(unsigned int flags);
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled);
+void mtree_info(bool flatview, bool dispatch_tree, bool treeview,
+                bool owner, bool disabled);
 
 bool memory_region_access_valid(MemoryRegion *mr, hwaddr addr,
                                 unsigned size, bool is_write,
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 74a0f56566..6378636406 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -412,11 +412,12 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict)
 void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
+    bool treeview = qdict_get_try_bool(qdict, "treeview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
     bool owner = qdict_get_try_bool(qdict, "owner", false);
     bool disabled = qdict_get_try_bool(qdict, "disabled", false);
 
-    mtree_info(flatview, dispatch_tree, owner, disabled);
+    mtree_info(flatview, dispatch_tree, treeview, owner, disabled);
 }
 
 #if defined(CONFIG_FDT)
diff --git a/system/memory.c b/system/memory.c
index 306e9ff9eb..7a957d80e3 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3265,10 +3265,25 @@ static const char *memory_region_type(MemoryRegion *mr)
     }
 }
 
+enum mtree_node_type {
+    MTREE_NODE_T_INNER,
+    MTREE_NODE_T_TAIL,
+};
+
+typedef struct PrintCol PrintCol;
+
+struct PrintCol {
+    bool print_col;
+    QTAILQ_ENTRY(PrintCol) queue;
+};
+
+typedef QTAILQ_HEAD(, PrintCol) PrintColHead;
+
 typedef struct MemoryRegionList MemoryRegionList;
 
 struct MemoryRegionList {
     const MemoryRegion *mr;
+    PrintColHead *col_string;
     QTAILQ_ENTRY(MemoryRegionList) mrqueue;
 };
 
@@ -3278,6 +3293,104 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+static void mtree_print_col(PrintColHead *col_string, unsigned int level)
+{
+    PrintCol *col = NULL;
+    int i = 0;
+
+    /* Level 0 always has not a col. */
+    if (level == 0 || col_string == NULL) {
+        return;
+    }
+
+    /*
+     * If the parent node is not a tail node,
+     * print a column at the corresponding level.
+     */
+    if (col_string != NULL) {
+        QTAILQ_FOREACH(col, col_string, queue) {
+            if (i++ == level) {
+                break;
+            }
+        }
+    }
+
+    if (col != NULL && col->print_col) {
+        qemu_printf("|");
+    } else {
+        qemu_printf(" ");
+    }
+
+    /* Align with the first character of the parent node. */
+    qemu_printf("  ");
+}
+
+static void mtree_print_node(enum mtree_node_type node_type)
+{
+    if (node_type == MTREE_NODE_T_TAIL) {
+        qemu_printf("`- ");
+    } else {
+        qemu_printf("|- ");
+    }
+}
+
+static void mtree_print_head(PrintColHead *col_string, unsigned int level,
+                             enum mtree_node_type node_type, bool treeview)
+{
+    if (treeview) {
+        for (int i = 0; i < level; i++) {
+            mtree_print_col(col_string, i);
+        }
+        mtree_print_node(node_type);
+    } else {
+        for (int i = 0; i < level; i++) {
+            qemu_printf(MTREE_INDENT);
+        }
+    }
+}
+
+static PrintColHead *mtree_col_string_new(PrintColHead *col_string, int level,
+                                          enum mtree_node_type node_type)
+{
+    PrintColHead *new_col_string = g_new(PrintColHead, 1);
+    PrintCol *col, *new_col;
+    int i = 0;
+
+    QTAILQ_INIT(new_col_string);
+    if (col_string != NULL) {
+        QTAILQ_FOREACH(col, col_string, queue) {
+            new_col = g_new(PrintCol, 1);
+            new_col->print_col = col->print_col;
+            QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+            i++;
+        }
+    } else {
+        new_col = g_new(PrintCol, 1);
+        new_col->print_col = true;
+        QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+        i++;
+    }
+    for (; i < level; i++) {
+        new_col = g_new(PrintCol, 1);
+        if ((i == (level - 1)) && (node_type == MTREE_NODE_T_TAIL)) {
+            new_col->print_col = false;
+        } else {
+            new_col->print_col = true;
+        }
+        QTAILQ_INSERT_TAIL(new_col_string, new_col, queue);
+    }
+    return new_col_string;
+}
+
+static void mtree_col_string_free(PrintColHead *col_string)
+{
+    PrintCol *col, *next_col;
+    QTAILQ_FOREACH_SAFE(col, col_string, queue, next_col) {
+        g_free(col);
+    }
+    g_free(col_string);
+}
+
 static void mtree_expand_owner(const char *label, Object *obj)
 {
     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
@@ -3317,12 +3430,14 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner, bool display_disabled)
+                           bool owner, bool display_disabled,
+                           PrintColHead *col_string,
+                           enum mtree_node_type node_type,
+                           bool treeview)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
-    unsigned int i;
     hwaddr cur_start, cur_end;
 
     if (!mr) {
@@ -3357,9 +3472,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
         }
         if (mr->enabled || display_disabled) {
-            for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
-            }
+            mtree_print_head(col_string, level, node_type, treeview);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
                         "-" HWADDR_FMT_plx "%s",
@@ -3379,9 +3492,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         }
     } else {
         if (mr->enabled || display_disabled) {
-            for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
-            }
+            mtree_print_head(col_string, level, node_type, treeview);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s%s",
                         cur_start, cur_end,
@@ -3402,6 +3513,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
         new_ml = g_new(MemoryRegionList, 1);
         new_ml->mr = submr;
+        new_ml->col_string = mtree_col_string_new(col_string,
+                                                  level + 1, node_type);
         QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
             if (new_ml->mr->addr < ml->mr->addr ||
                 (new_ml->mr->addr == ml->mr->addr &&
@@ -3418,10 +3531,13 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner, display_disabled);
+                       alias_print_queue, owner, display_disabled,
+                       ml->col_string, ml == QTAILQ_LAST(&submr_print_queue),
+                       treeview);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
+        mtree_col_string_free(ml->col_string);
         g_free(ml);
     }
 }
@@ -3571,6 +3687,7 @@ struct AddressSpaceInfo {
     MemoryRegionListHead *ml_head;
     bool owner;
     bool disabled;
+    bool treeview;
 };
 
 /* Returns negative value if a < b; zero if a = b; positive value if a > b. */
@@ -3596,7 +3713,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     struct AddressSpaceInfo *asi = user_data;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
+    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
+                   NULL, MTREE_NODE_T_TAIL, asi->treeview);
     qemu_printf("\n");
 }
 
@@ -3610,7 +3728,8 @@ static gboolean mtree_info_as_free(gpointer key, gpointer value,
     return true;
 }
 
-static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
+static void mtree_info_as(bool dispatch_tree, bool treeview,
+                          bool owner, bool disabled)
 {
     MemoryRegionListHead ml_head;
     MemoryRegionList *ml, *ml2;
@@ -3621,6 +3740,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
         .ml_head = &ml_head,
         .owner = owner,
         .disabled = disabled,
+        .treeview = treeview,
     };
 
     QTAILQ_INIT(&ml_head);
@@ -3641,7 +3761,8 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
+                       NULL, MTREE_NODE_T_TAIL, treeview);
         qemu_printf("\n");
     }
 
@@ -3650,12 +3771,13 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
+void mtree_info(bool flatview, bool dispatch_tree, bool treeview,
+                bool owner, bool disabled)
 {
     if (flatview) {
         mtree_info_flatview(dispatch_tree, owner);
     } else {
-        mtree_info_as(dispatch_tree, owner, disabled);
+        mtree_info_as(dispatch_tree, treeview, owner, disabled);
     }
 }
 
-- 
2.48.1


