Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B81CC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMH-0002Nl-5s; Wed, 04 Jun 2025 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM4-0002FH-6Q
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM0-0000Pq-35
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJh8u9RJAYyXP7u7wNsz7XpdpvjO7kfc6fAGQ2VLvSU=;
 b=LDokX8swBfadLrgY9Onh1D2RzO4wnJYa1zLZ+ta5g5Jg+gPmZ1icRc1tM/hNlgzWJ60woO
 P9kLilzV54szojHU2dXbvoyKgax7xw5BPNxLbBBVa2y+hTI/9cXltquByqRheu54cG5Nre
 Ln9PtuJ9c6pTnGyZQWC2LAg+wM5NOdc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-GHo06sxcOMGBiHBMYYo4xw-1; Wed,
 04 Jun 2025 13:56:26 -0400
X-MC-Unique: GHo06sxcOMGBiHBMYYo4xw-1
X-Mimecast-MFC-AGG-ID: GHo06sxcOMGBiHBMYYo4xw_1749059785
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F38C195608E; Wed,  4 Jun 2025 17:56:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3D2718002A5; Wed,  4 Jun 2025 17:56:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/24] block/snapshot: move drain outside of read-locked
 bdrv_snapshot_delete()
Date: Wed,  4 Jun 2025 19:55:52 +0200
Message-ID: <20250604175613.344113-4-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_snapshot_delete() can recursively call itself.

The return value of bdrv_all_delete_snapshot() changes from -1 to
-errno propagated from failed sub-calls. This is fine for the existing
callers of bdrv_all_delete_snapshot().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-4-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
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
index 139eeb5039..e75707180d 100644
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
2.49.0


