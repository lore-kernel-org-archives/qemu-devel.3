Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA268C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublN3-0002LO-K2; Tue, 15 Jul 2025 15:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwZ-0003hb-Vl
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwX-0001Gt-Jy
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68D7OkwdVd3bP6nYCJxOTZBsJbFiTqIIgPgBUBDKP90=;
 b=aZtobncsaRFzfYe0iT2HmWkdUQiP6enboaOrDcRxgFPIAWq9ZvyRmx7SFDI7vPPMFASmfu
 K74WMJ+ptbQ0tweKLiYAt4xR6v76zgVvLlh5g3AA4RBQQgIzWHbFQ/n/4exyOyZYb/eLp9
 fr//RdrntA90r5Em6xye9bxl1GNZNs4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-UXn3L_r7NVutY6x1PkifPQ-1; Tue,
 15 Jul 2025 15:03:55 -0400
X-MC-Unique: UXn3L_r7NVutY6x1PkifPQ-1
X-Mimecast-MFC-AGG-ID: UXn3L_r7NVutY6x1PkifPQ_1752606234
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB55195608F; Tue, 15 Jul 2025 19:03:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76D80197702B; Tue, 15 Jul 2025 19:03:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/57] block: drop wrapper for bdrv_set_backing_hd_drained()
Date: Tue, 15 Jul 2025 21:02:41 +0200
Message-ID: <20250715190330.378764-9-kwolf@redhat.com>
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

Nearly all callers (outside of the tests) are already using the
_drained() variant of the function. It doesn't seem worth keeping.
Simply adapt the remaining callers of bdrv_set_backing_hd() and rename
bdrv_set_backing_hd_drained() to bdrv_set_backing_hd().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-31-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  5 +----
 block.c                            | 20 ++++----------------
 block/commit.c                     |  6 +++---
 block/mirror.c                     |  2 +-
 block/stream.c                     | 13 ++++++-------
 blockdev.c                         | 13 ++++++++-----
 tests/unit/test-bdrv-drain.c       | 12 +++++++++++-
 tests/unit/test-bdrv-graph-mod.c   |  2 +-
 8 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 009b9ac946..bcbb624a7b 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -100,12 +100,9 @@ bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 BlockDriverState * coroutine_fn no_co_wrapper
 bdrv_co_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 
-int GRAPH_UNLOCKED
+int GRAPH_WRLOCK
 bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                     Error **errp);
-int GRAPH_WRLOCK
-bdrv_set_backing_hd_drained(BlockDriverState *bs, BlockDriverState *backing_hd,
-                            Error **errp);
 
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp);
diff --git a/block.c b/block.c
index 9ef3b0262c..4754705bfd 100644
--- a/block.c
+++ b/block.c
@@ -3570,9 +3570,8 @@ out:
  *
  * All block nodes must be drained.
  */
-int bdrv_set_backing_hd_drained(BlockDriverState *bs,
-                                BlockDriverState *backing_hd,
-                                Error **errp)
+int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
+                        Error **errp)
 {
     int ret;
     Transaction *tran = tran_new();
@@ -3594,19 +3593,6 @@ out:
     return ret;
 }
 
-int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
-                        Error **errp)
-{
-    int ret;
-    GLOBAL_STATE_CODE();
-
-    bdrv_graph_wrlock_drained();
-    ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
-    bdrv_graph_wrunlock();
-
-    return ret;
-}
-
 /*
  * Opens the backing file for a BlockDriverState if not yet open
  *
@@ -3715,7 +3701,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
     bdrv_graph_rdunlock_main_loop();
+    bdrv_graph_wrlock_drained();
     ret = bdrv_set_backing_hd(bs, backing_hd, errp);
+    bdrv_graph_wrunlock();
     bdrv_graph_rdlock_main_loop();
     bdrv_unref(backing_hd);
 
diff --git a/block/commit.c b/block/commit.c
index c9690a5da0..7496cf732e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -566,8 +566,8 @@ int bdrv_commit(BlockDriverState *bs)
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_graph_wrlock_drained();
-    bdrv_set_backing_hd_drained(commit_top_bs, backing_file_bs, &error_abort);
-    bdrv_set_backing_hd_drained(bs, commit_top_bs, &error_abort);
+    bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
+    bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
     bdrv_graph_wrunlock();
 
     bdrv_graph_rdlock_main_loop();
@@ -649,7 +649,7 @@ ro_cleanup:
     bdrv_graph_rdunlock_main_loop();
     bdrv_graph_wrlock_drained();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
-        bdrv_set_backing_hd_drained(bs, backing_file_bs, &error_abort);
+        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
     bdrv_graph_wrunlock();
     bdrv_graph_rdlock_main_loop();
diff --git a/block/mirror.c b/block/mirror.c
index 873e95d029..b344182c74 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -772,7 +772,7 @@ static int mirror_exit_common(Job *job)
 
         backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         if (bdrv_cow_bs(unfiltered_target) != backing) {
-            bdrv_set_backing_hd_drained(unfiltered_target, backing, &local_err);
+            bdrv_set_backing_hd(unfiltered_target, backing, &local_err);
             if (local_err) {
                 error_report_err(local_err);
                 local_err = NULL;
diff --git a/block/stream.c b/block/stream.c
index a6ef840e29..17e240460c 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -73,12 +73,11 @@ static int stream_prepare(Job *job)
     s->cor_filter_bs = NULL;
 
     /*
-     * bdrv_set_backing_hd() requires that the unfiltered_bs and the COW child
-     * of unfiltered_bs is drained. Drain already here and use
-     * bdrv_set_backing_hd_drained() instead because the polling during
-     * drained_begin() might change the graph, and if we do this only later, we
-     * may end up working with the wrong base node (or it might even have gone
-     * away by the time we want to use it).
+     * bdrv_set_backing_hd() requires that all block nodes are drained. Drain
+     * already here, because the polling during drained_begin() might change the
+     * graph, and if we do this only later, we may end up working with the wrong
+     * base node (or it might even have gone away by the time we want to use
+     * it).
      */
     if (unfiltered_bs_cow) {
         bdrv_ref(unfiltered_bs_cow);
@@ -105,7 +104,7 @@ static int stream_prepare(Job *job)
         }
 
         bdrv_graph_wrlock();
-        bdrv_set_backing_hd_drained(unfiltered_bs, base, &local_err);
+        bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
         bdrv_graph_wrunlock();
 
         /*
diff --git a/blockdev.c b/blockdev.c
index 3c53472a23..9f3f42d896 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1587,12 +1587,12 @@ static void external_snapshot_abort(void *opaque)
             /*
              * Note that state->old_bs would not disappear during the
              * write-locked section, because the unref from
-             * bdrv_set_backing_hd_drained() only happens at the end of the
-             * write-locked section. However, just be explicit about keeping a
-             * reference and don't rely on that implicit detail.
+             * bdrv_set_backing_hd() only happens at the end of the write-locked
+             * section. However, just be explicit about keeping a reference and
+             * don't rely on that implicit detail.
              */
             bdrv_ref(state->old_bs);
-            bdrv_set_backing_hd_drained(state->new_bs, NULL, &error_abort);
+            bdrv_set_backing_hd(state->new_bs, NULL, &error_abort);
 
             /*
              * The call to bdrv_set_backing_hd() above returns state->old_bs to
@@ -1776,7 +1776,10 @@ static void drive_backup_action(DriveBackup *backup,
     }
 
     if (set_backing_hd) {
-        if (bdrv_set_backing_hd(target_bs, source, errp) < 0) {
+        bdrv_graph_wrlock_drained();
+        ret = bdrv_set_backing_hd(target_bs, source, errp);
+        bdrv_graph_wrunlock();
+        if (ret < 0) {
             goto unref;
         }
     }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 3369c2c2aa..43b0ba8648 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -193,7 +193,9 @@ static BlockBackend * no_coroutine_fn test_setup(void)
     blk_insert_bs(blk, bs, &error_abort);
 
     backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(bs, backing, &error_abort);
+    bdrv_graph_wrunlock();
 
     bdrv_unref(backing);
     bdrv_unref(bs);
@@ -386,7 +388,9 @@ static void test_nested(void)
 
     backing = bdrv_new_open_driver(&bdrv_test, "backing", 0, &error_abort);
     backing_s = backing->opaque;
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(bs, backing, &error_abort);
+    bdrv_graph_wrunlock();
 
     for (outer = 0; outer < DRAIN_TYPE_MAX; outer++) {
         for (inner = 0; inner < DRAIN_TYPE_MAX; inner++) {
@@ -733,10 +737,12 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     src_overlay = bdrv_new_open_driver(&bdrv_test, "source-overlay",
                                        BDRV_O_RDWR, &error_abort);
 
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(src_overlay, src, &error_abort);
     bdrv_unref(src);
     bdrv_set_backing_hd(src, src_backing, &error_abort);
     bdrv_unref(src_backing);
+    bdrv_graph_wrunlock();
 
     blk_src = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk_src, src_overlay, &error_abort);
@@ -1436,8 +1442,10 @@ static void test_drop_backing_job_commit(Job *job)
     TestDropBackingBlockJob *s =
         container_of(job, TestDropBackingBlockJob, common.job);
 
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(s->bs, NULL, &error_abort);
     bdrv_set_backing_hd(s->detach_also, NULL, &error_abort);
+    bdrv_graph_wrunlock();
 
     *s->did_complete = true;
 }
@@ -1530,7 +1538,9 @@ static void test_blockjob_commit_by_drained_end(void)
         snprintf(name, sizeof(name), "parent-node-%i", i);
         bs_parents[i] = bdrv_new_open_driver(&bdrv_test, name, BDRV_O_RDWR,
                                              &error_abort);
+        bdrv_graph_wrlock_drained();
         bdrv_set_backing_hd(bs_parents[i], bs_child, &error_abort);
+        bdrv_graph_wrunlock();
     }
 
     job = block_job_create("job", &test_drop_backing_job_driver, NULL,
@@ -1679,13 +1689,13 @@ static void test_drop_intermediate_poll(void)
 
     job_node = bdrv_new_open_driver(&bdrv_test, "job-node", BDRV_O_RDWR,
                                     &error_abort);
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(job_node, chain[1], &error_abort);
 
     /*
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
-    bdrv_graph_wrlock_drained();
     for (i = 0; i < 3; i++) {
         if (i) {
             /* Takes the reference to chain[i - 1] */
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index b077f0e3e3..567db99e4f 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -202,9 +202,9 @@ static void test_should_update_child(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
+    bdrv_graph_wrlock_drained();
     bdrv_set_backing_hd(target, bs, &error_abort);
 
-    bdrv_graph_wrlock_drained();
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-- 
2.50.1


