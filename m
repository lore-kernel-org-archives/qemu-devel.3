Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5391CC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 04:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9yiY-0001Mg-H7; Wed, 30 Apr 2025 00:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u9yi0-00019X-Mi
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 00:06:08 -0400
Received: from out28-219.mail.aliyun.com ([115.124.28.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u9yhy-0005U5-Cg
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 00:06:08 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cbi39O2_1745985955 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 30 Apr 2025 12:05:55 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, philmd@linaro.org
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, lc00631@tecorigin.com,
 qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] system: optimizing info mtree printing for monitors
Date: Wed, 30 Apr 2025 12:02:23 +0800
Message-ID: <8b29b86a9af84edba54cc53aec017224478312bf.1745894489.git.lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <cover.1745894489.git.lc00631@tecorigin.com>
References: <cover.1745894489.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.219;
 envelope-from=lc00631@tecorigin.com; helo=out28-219.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Chao Liu <lc00631@tecorigin.com>
---
 system/memory.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 71434e7ad0..e723928068 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3296,6 +3296,22 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
                            int128_sub((size), int128_one())) : 0)
 #define MTREE_INDENT "  "
 
+#define PRINT_MTREE_COL(level) do { \
+    if (level == 0) {               \
+        qemu_printf("│  ");         \
+    } else {                        \
+        qemu_printf("│   ");        \
+    }                               \
+} while (0)
+
+#define PRINT_MTREE_NODE(is_tail) do { \
+    if (is_tail) {                     \
+        qemu_printf("└── ");           \
+    } else {                           \
+        qemu_printf("├── ");           \
+    }                                  \
+} while (0)
+
 static void mtree_expand_owner(const char *label, Object *obj)
 {
     DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
@@ -3335,9 +3351,9 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
                            hwaddr base,
                            MemoryRegionListHead *alias_print_queue,
-                           bool owner, bool display_disabled)
+                           bool owner, bool display_disabled, bool is_tail)
 {
-    MemoryRegionList *new_ml, *ml, *next_ml;
+    MemoryRegionList *new_ml, *ml, *next_ml, *ml_tail;
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
     unsigned int i;
@@ -3376,8 +3392,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         }
         if (mr->enabled || display_disabled) {
             for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
+                PRINT_MTREE_COL(i);
             }
+            PRINT_MTREE_NODE(is_tail);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
                         "-" HWADDR_FMT_plx "%s",
@@ -3398,8 +3415,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     } else {
         if (mr->enabled || display_disabled) {
             for (i = 0; i < level; i++) {
-                qemu_printf(MTREE_INDENT);
+                PRINT_MTREE_COL(i);
             }
+            PRINT_MTREE_NODE(is_tail);
             qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s%s",
                         cur_start, cur_end,
@@ -3434,9 +3452,11 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         }
     }
 
+    ml_tail = QTAILQ_LAST(&submr_print_queue);
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
         mtree_print_mr(ml->mr, level + 1, cur_start,
-                       alias_print_queue, owner, display_disabled);
+                       alias_print_queue, owner,
+                       display_disabled, ml_tail == ml);
     }
 
     QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
@@ -3614,7 +3634,7 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     struct AddressSpaceInfo *asi = user_data;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
+    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled, false);
     qemu_printf("\n");
 }
 
@@ -3659,7 +3679,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled, false);
         qemu_printf("\n");
     }
 
-- 
2.48.1


