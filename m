Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B939CC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pw-0005Pw-6H; Fri, 30 May 2025 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pt-0005O7-LH; Fri, 30 May 2025 11:13:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pr-0002RF-Q9; Fri, 30 May 2025 11:13:05 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9236B44AEE;
 Fri, 30 May 2025 17:11:49 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 35/48] block: mark bdrv_inactivate() as GRAPH_RDLOCK and
 move drain to callers
Date: Fri, 30 May 2025 17:11:12 +0200
Message-Id: <20250530151125.955508-36-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function bdrv_inactivate() calls bdrv_drain_all_begin(), which
needs to be called with the graph unlocked, so either
bdrv_inactivate() should be marked as GRAPH_UNLOCKED or the drain
needs to be moved to the callers. The caller in
qmp_blockdev_set_active() requires that the locked section covers
bdrv_find_node() too, so the latter alternative is chosen.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c                            | 14 ++----
 blockdev.c                         | 75 ++++++++++++++++++------------
 include/block/block-global-state.h |  2 +-
 3 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/block.c b/block.c
index ae1b122fa8..6f470aac2f 100644
--- a/block.c
+++ b/block.c
@@ -7059,31 +7059,25 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
     return 0;
 }
 
+/* All block nodes must be drained. */
 int bdrv_inactivate(BlockDriverState *bs, Error **errp)
 {
     int ret;
 
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_rdlock_main_loop();
-
     if (bdrv_has_bds_parent(bs, true)) {
         error_setg(errp, "Node has active parent node");
-        ret = -EPERM;
-        goto out;
+        return -EPERM;
     }
 
     ret = bdrv_inactivate_recurse(bs, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to inactivate node");
-        goto out;
+        return ret;
     }
 
-out:
-    bdrv_graph_rdunlock_main_loop();
-    bdrv_drain_all_end();
-    return ret;
+    return 0;
 }
 
 int bdrv_inactivate_all(void)
diff --git a/blockdev.c b/blockdev.c
index 9f3f42d896..b451fee6e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1421,7 +1421,7 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_graph_rdunlock_main_loop();
     /* Paired with .clean() */
     bdrv_drained_begin(state->old_bs);
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     /* Make sure the associated bs did not change with the drain. */
     check_bs = bdrv_lookup_bs(device, node_name, errp);
@@ -1430,18 +1430,18 @@ static void external_snapshot_action(TransactionAction *action,
             error_setg(errp, "Block node of device '%s' unexpectedly changed",
                        device);
         } /* else errp is already set */
-        return;
+        goto unlock;
     }
 
     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, "Device '%s' has no medium",
                    bdrv_get_device_or_node_name(state->old_bs));
-        return;
+        goto unlock;
     }
 
     if (bdrv_op_is_blocked(state->old_bs,
                            BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT, errp)) {
-        return;
+        goto unlock;
     }
 
     if (!bdrv_is_read_only(state->old_bs)) {
@@ -1449,7 +1449,7 @@ static void external_snapshot_action(TransactionAction *action,
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Write to node '%s' failed",
                              bdrv_get_device_or_node_name(state->old_bs));
-            return;
+            goto unlock;
         }
     }
 
@@ -1461,13 +1461,13 @@ static void external_snapshot_action(TransactionAction *action,
 
         if (node_name && !snapshot_node_name) {
             error_setg(errp, "New overlay node-name missing");
-            return;
+            goto unlock;
         }
 
         if (snapshot_node_name &&
             bdrv_lookup_bs(snapshot_node_name, snapshot_node_name, NULL)) {
             error_setg(errp, "New overlay node-name already in use");
-            return;
+            goto unlock;
         }
 
         flags = state->old_bs->open_flags;
@@ -1480,7 +1480,7 @@ static void external_snapshot_action(TransactionAction *action,
             int64_t size = bdrv_getlength(state->old_bs);
             if (size < 0) {
                 error_setg_errno(errp, -size, "bdrv_getlength failed");
-                return;
+                goto unlock;
             }
             bdrv_refresh_filename(state->old_bs);
 
@@ -1491,7 +1491,7 @@ static void external_snapshot_action(TransactionAction *action,
 
             if (local_err) {
                 error_propagate(errp, local_err);
-                return;
+                goto unlock;
             }
         }
 
@@ -1507,7 +1507,7 @@ static void external_snapshot_action(TransactionAction *action,
 
     /* We will manually add the backing_hd field to the bs later */
     if (!state->new_bs) {
-        return;
+        goto unlock;
     }
 
     /*
@@ -1518,22 +1518,22 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_get_cumulative_perm(state->new_bs, &perm, &shared);
     if (perm & BLK_PERM_CONSISTENT_READ) {
         error_setg(errp, "The overlay is already in use");
-        return;
+        goto unlock;
     }
 
     if (state->new_bs->drv->is_filter) {
         error_setg(errp, "Filters cannot be used as overlays");
-        return;
+        goto unlock;
     }
 
     if (bdrv_cow_child(state->new_bs)) {
         error_setg(errp, "The overlay already has a backing image");
-        return;
+        goto unlock;
     }
 
     if (!state->new_bs->drv->supports_backing) {
         error_setg(errp, "The overlay does not support backing images");
-        return;
+        goto unlock;
     }
 
     /*
@@ -1546,17 +1546,23 @@ static void external_snapshot_action(TransactionAction *action,
      * to keep this working.
      */
     if (bdrv_is_inactive(state->old_bs) && !bdrv_is_inactive(state->new_bs)) {
+        bdrv_graph_rdunlock_main_loop();
+        bdrv_drain_all_begin();
+        bdrv_graph_rdlock_main_loop();
         ret = bdrv_inactivate(state->new_bs, errp);
+        bdrv_drain_all_end();
         if (ret < 0) {
-            return;
+            goto unlock;
         }
     }
 
     ret = bdrv_append(state->new_bs, state->old_bs, errp);
     if (ret < 0) {
-        return;
+        goto unlock;
     }
     state->overlay_appended = true;
+unlock:
+    bdrv_graph_rdunlock_main_loop();
 }
 
 static void external_snapshot_commit(void *opaque)
@@ -3520,10 +3526,10 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
 
 void qmp_blockdev_set_active(const char *node_name, bool active, Error **errp)
 {
+    BlockDriverState *bs;
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!node_name) {
         if (active) {
@@ -3534,19 +3540,30 @@ void qmp_blockdev_set_active(const char *node_name, bool active, Error **errp)
                 error_setg_errno(errp, -ret, "Failed to inactivate all nodes");
             }
         }
-    } else {
-        BlockDriverState *bs = bdrv_find_node(node_name);
-        if (!bs) {
-            error_setg(errp, "Failed to find node with node-name='%s'",
-                       node_name);
-            return;
-        }
+        return;
+    }
 
-        if (active) {
-            bdrv_activate(bs, errp);
-        } else {
-            bdrv_inactivate(bs, errp);
-        }
+    if (!active) {
+        bdrv_drain_all_begin();
+    }
+    bdrv_graph_rdlock_main_loop();
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Failed to find node with node-name='%s'",
+                   node_name);
+        goto unlock;
+    }
+    if (active) {
+        bdrv_activate(bs, errp);
+    } else {
+        bdrv_inactivate(bs, errp);
+    }
+
+unlock:
+    bdrv_graph_rdunlock_main_loop();
+    if (!active) {
+        bdrv_drain_all_end();
     }
 }
 
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index f25c65c1b4..a641beb270 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -183,7 +183,7 @@ bdrv_activate(BlockDriverState *bs, Error **errp);
 int coroutine_fn no_co_wrapper_bdrv_rdlock
 bdrv_co_activate(BlockDriverState *bs, Error **errp);
 
-int no_coroutine_fn
+int no_coroutine_fn GRAPH_RDLOCK
 bdrv_inactivate(BlockDriverState *bs, Error **errp);
 
 void bdrv_activate_all(Error **errp);
-- 
2.39.5



