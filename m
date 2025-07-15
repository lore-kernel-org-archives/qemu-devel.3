Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB1CC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublWm-0007cR-MK; Tue, 15 Jul 2025 15:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwk-0003uA-B9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwi-0001JG-8f
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SzqBoKbn6ZBWj7S0TT0Fnn+fztMNR9VR1UPKe8EtBA=;
 b=OEfQrPR7wmE9qE0J1PPu3w50zxrmG4L1gFdGFEVHPB8j9fP7kEI0i7cEET+nTpYyb+Ayo+
 GGKA3LLnvCv2nu18sRl6ebJJL4l0RloyeVB0z5zia1yxgrvEPFEx7n2dpOtgoTPRMD5992
 DK7023n9ObgiEIXNhIk6a2RKyWnticc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-cE1AuyjvNxuBsUfCl3WI9w-1; Tue,
 15 Jul 2025 15:04:05 -0400
X-MC-Unique: cE1AuyjvNxuBsUfCl3WI9w-1
X-Mimecast-MFC-AGG-ID: cE1AuyjvNxuBsUfCl3WI9w_1752606244
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 762DF180029E; Tue, 15 Jul 2025 19:04:04 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7489197702C; Tue, 15 Jul 2025 19:04:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/57] block: mark bdrv_inactivate() as GRAPH_RDLOCK and move
 drain to callers
Date: Tue, 15 Jul 2025 21:02:46 +0200
Message-ID: <20250715190330.378764-14-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function bdrv_inactivate() calls bdrv_drain_all_begin(), which
needs to be called with the graph unlocked, so either
bdrv_inactivate() should be marked as GRAPH_UNLOCKED or the drain
needs to be moved to the callers. The caller in
qmp_blockdev_set_active() requires that the locked section covers
bdrv_find_node() too, so the latter alternative is chosen.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-36-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  2 +-
 block.c                            | 14 ++----
 blockdev.c                         | 73 ++++++++++++++++++------------
 3 files changed, 50 insertions(+), 39 deletions(-)

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
diff --git a/block.c b/block.c
index 4754705bfd..932e599f45 100644
--- a/block.c
+++ b/block.c
@@ -7058,31 +7058,25 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
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
+        return;
+    }
+
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
     } else {
-        BlockDriverState *bs = bdrv_find_node(node_name);
-        if (!bs) {
-            error_setg(errp, "Failed to find node with node-name='%s'",
-                       node_name);
-            return;
-        }
+        bdrv_inactivate(bs, errp);
+    }
 
-        if (active) {
-            bdrv_activate(bs, errp);
-        } else {
-            bdrv_inactivate(bs, errp);
-        }
+unlock:
+    bdrv_graph_rdunlock_main_loop();
+    if (!active) {
+        bdrv_drain_all_end();
     }
 }
 
-- 
2.50.1


