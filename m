Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A1C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2ua-00064s-KI; Wed, 30 Apr 2025 04:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uA2uX-00064I-Ui
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:35:21 -0400
Received: from out28-173.mail.aliyun.com ([115.124.28.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1uA2uV-0004j6-8S
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:35:21 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cbxIByq_1746002110 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 30 Apr 2025 16:35:10 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, philmd@linaro.org
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] system: optimizing info mtree printing for monitors
Date: Wed, 30 Apr 2025 16:31:47 +0800
Message-ID: <501e578a4ef28515ccdefcbc82defc04363855ca.1746001489.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1746001489.git.lc00631@tecorigin.com>
References: <cover.1746001489.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.173;
 envelope-from=lc00631@tecorigin.com; helo=out28-173.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Make the hierarchical relationship between nodes clearer by adding characters

e.g.

qemu-system-riscv64 -M virt -monitor stdio -display none

```
(qemu) info mtree
...
memory-region: system
│  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
│  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
│  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
...
│  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
```

Signed-off-by: Chao Liu <lc00631@tecorigin.com>
Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
---
 system/memory.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 71434e7ad0..3a7faeb533 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3296,6 +3296,27 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+enum mtree_node_type {
+    MTREE_NODE_T_INNER,
+    MTREE_NODE_T_TAIL,
+};
+
+#define PRINT_MTREE_NODE(node_type) do {  \
+    if (node_type == MTREE_NODE_T_TAIL) { \
+        qemu_printf("└── ");              \
+    } else {                              \
+        qemu_printf("├── ");              \
+    }                                     \
+} while (0)
+
+#define PRINT_MTREE_COL(level) do { \
+    if (level == 0) {               \
+        qemu_printf("│  ");         \
+    } else {                        \
+        qemu_printf("│   ");        \
+    }                               \
+} while (0)
+
 static void mtree_expand_owner(const char *label, Object *obj)
 {
     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
@@ -3335,7 +3356,8 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner, bool display_disabled)
+                           bool owner, bool display_disabled,
+                           enum mtree_node_type node_type)
 {
     MemoryRegionList *new_ml, *ml, *next_ml;
     MemoryRegionListHead submr_print_queue;
@@ -3376,8 +3398,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         }
         if (mr->enabled || display_disabled) {
             for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
+                PRINT_MTREE_COL(i);
             }
+            PRINT_MTREE_NODE(node_type);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
                         "-" HWADDR_FMT_plx "%s",
@@ -3398,8 +3421,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     } else {
         if (mr->enabled || display_disabled) {
             for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
+                PRINT_MTREE_COL(i);
             }
+            PRINT_MTREE_NODE(node_type);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s%s",
                         cur_start, cur_end,
@@ -3435,8 +3459,12 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
+        if (ml == QTAILQ_LAST(&submr_print_queue)) {
+            node_type = MTREE_NODE_T_TAIL;
+        }
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner, display_disabled);
+                       alias_print_queue, owner,
+                       display_disabled, node_type);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -3614,7 +3642,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     struct AddressSpaceInfo *asi = user_data;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
+    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
+                   MTREE_NODE_T_INNER);
     qemu_printf("\n");
 }
 
@@ -3659,7 +3688,8 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
+                       MTREE_NODE_T_INNER);
         qemu_printf("\n");
     }
 
-- 
2.48.1


