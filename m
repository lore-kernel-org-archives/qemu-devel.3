Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E84CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKFB-0007eH-Gh; Tue, 20 May 2025 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEt-0006qn-QT; Tue, 20 May 2025 06:30:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-00051V-B8; Tue, 20 May 2025 06:30:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B98DE43B1A;
 Tue, 20 May 2025 12:30:18 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 03/24] block/snapshot: move drain outside of read-locked
 bdrv_snapshot_delete()
Date: Tue, 20 May 2025 12:29:51 +0200
Message-Id: <20250520103012.424311-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520103012.424311-1-f.ebner@proxmox.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_snapshot_delete() can recursively call itself.

The return value of bdrv_all_delete_snapshot() changes from -1 to
-errno propagated from failed sub-calls. This is fine for the existing
callers of bdrv_all_delete_snapshot().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Use 'must be drained' instead of 'needs to be drained'.
* Use goto for cleanup/error handling in bdrv_all_delete_snapshot().
* Don't use atomics to access bs->quiesce_counter.

 block/snapshot.c | 26 +++++++++++++++-----------
 blockdev.c       | 25 +++++++++++++++++--------
 qemu-img.c       |  2 ++
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index 22567f1fb9..9f300a78bd 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -327,7 +327,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
 
 /**
  * Delete an internal snapshot by @snapshot_id and @name.
- * @bs: block device used in the operation
+ * @bs: block device used in the operation, must be drained
  * @snapshot_id: unique snapshot ID, or NULL
  * @name: snapshot name, or NULL
  * @errp: location to store error
@@ -358,6 +358,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
 
     GLOBAL_STATE_CODE();
 
+    assert(bs->quiesce_counter > 0);
+
     if (!drv) {
         error_setg(errp, "Device '%s' has no medium",
                    bdrv_get_device_name(bs));
@@ -368,9 +370,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
         return -EINVAL;
     }
 
-    /* drain all pending i/o before deleting snapshot */
-    bdrv_drained_begin(bs);
-
     if (drv->bdrv_snapshot_delete) {
         ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
     } else if (fallback_bs) {
@@ -382,7 +381,6 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
         ret = -ENOTSUP;
     }
 
-    bdrv_drained_end(bs);
     return ret;
 }
 
@@ -571,19 +569,22 @@ int bdrv_all_delete_snapshot(const char *name,
     ERRP_GUARD();
     g_autoptr(GList) bdrvs = NULL;
     GList *iterbdrvs;
+    int ret = 0;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
-        return -1;
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
+
+    ret = bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp);
+    if (ret < 0) {
+        goto out;
     }
 
     iterbdrvs = bdrvs;
     while (iterbdrvs) {
         BlockDriverState *bs = iterbdrvs->data;
         QEMUSnapshotInfo sn1, *snapshot = &sn1;
-        int ret = 0;
 
         if ((devices || bdrv_all_snapshots_includes_bs(bs)) &&
             bdrv_snapshot_find(bs, snapshot, name) >= 0)
@@ -594,13 +595,16 @@ int bdrv_all_delete_snapshot(const char *name,
         if (ret < 0) {
             error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
                           name, bdrv_get_device_or_node_name(bs));
-            return -1;
+            goto out;
         }
 
         iterbdrvs = iterbdrvs->next;
     }
 
-    return 0;
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+    return ret;
 }
 
 
diff --git a/blockdev.c b/blockdev.c
index 21443b4514..3982f9776b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1132,39 +1132,41 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
-        return NULL;
+        goto error;
     }
 
     if (!id && !name) {
         error_setg(errp, "Name or id must be provided");
-        return NULL;
+        goto error;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT_DELETE, errp)) {
-        return NULL;
+        goto error;
     }
 
     ret = bdrv_snapshot_find_by_id_and_name(bs, id, name, &sn, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return NULL;
+        goto error;
     }
     if (!ret) {
         error_setg(errp,
                    "Snapshot with id '%s' and name '%s' does not exist on "
                    "device '%s'",
                    STR_OR_NULL(id), STR_OR_NULL(name), device);
-        return NULL;
+        goto error;
     }
 
     bdrv_snapshot_delete(bs, id, name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return NULL;
+        goto error;
     }
 
     info = g_new0(SnapshotInfo, 1);
@@ -1180,6 +1182,9 @@ SnapshotInfo *qmp_blockdev_snapshot_delete_internal_sync(const char *device,
         info->has_icount = true;
     }
 
+error:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
     return info;
 }
 
@@ -1295,12 +1300,14 @@ static void internal_snapshot_abort(void *opaque)
     Error *local_error = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!state->created) {
         return;
     }
 
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
+
     if (bdrv_snapshot_delete(bs, sn->id_str, sn->name, &local_error) < 0) {
         error_reportf_err(local_error,
                           "Failed to delete snapshot with id '%s' and "
@@ -1308,6 +1315,8 @@ static void internal_snapshot_abort(void *opaque)
                           sn->id_str, sn->name,
                           bdrv_get_device_name(bs));
     }
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 }
 
 static void internal_snapshot_clean(void *opaque)
diff --git a/qemu-img.c b/qemu-img.c
index 76ac5d3028..e81b0fbb6c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3505,6 +3505,7 @@ static int img_snapshot(int argc, char **argv)
         break;
 
     case SNAPSHOT_DELETE:
+        bdrv_drain_all_begin();
         bdrv_graph_rdlock_main_loop();
         ret = bdrv_snapshot_find(bs, &sn, snapshot_name);
         if (ret < 0) {
@@ -3520,6 +3521,7 @@ static int img_snapshot(int argc, char **argv)
             }
         }
         bdrv_graph_rdunlock_main_loop();
+        bdrv_drain_all_end();
         break;
     }
 
-- 
2.39.5



