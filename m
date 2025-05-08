Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA86C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1x9-0002fI-IY; Thu, 08 May 2025 10:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1x6-0002Xr-7s; Thu, 08 May 2025 10:10:20 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1x1-0008Ur-JW; Thu, 08 May 2025 10:10:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1C53143648;
 Thu,  8 May 2025 16:09:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 10/11] block/graph-lock: add drain flag to bdrv_graph_wr{,
 un}lock
Date: Thu,  8 May 2025 16:09:35 +0200
Message-Id: <20250508140936.3344485-11-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508140936.3344485-1-f.ebner@proxmox.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
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

For convenience, allow indicating whether the write-locked section
should also be a drained section directly when taking the write
lock.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

In bdrv_graph_wrlock() there is a comment that it uses
bdrv_drain_all_begin_nopoll() to make sure that constantly arriving
new I/O doesn't cause starvation. The changes from this series are at
odds with that, but there doesn't seem to be any (new) test failures.

The following script was used:

> find . -name '*.c' -exec sed -i -z 's/bdrv_drain_all_begin();\n\s*bdrv_graph_wrlock();/bdrv_graph_wrlock(true);/g' {} ';'
> find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();\n\s*bdrv_drain_all_end();/bdrv_graph_wrunlock(true);/g' {} ';'
> find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrlock();/bdrv_graph_wrlock(false);/g' {} ';'
> find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();/bdrv_graph_wrunlock(false);/g' {} ';'

 block.c                            | 62 ++++++++++++------------------
 block/backup.c                     |  6 +--
 block/blklogwrites.c               | 12 ++----
 block/blkverify.c                  |  6 +--
 block/block-backend.c              | 12 ++----
 block/commit.c                     | 20 ++++------
 block/graph-lock.c                 | 22 ++++++++---
 block/mirror.c                     | 27 ++++++-------
 block/qcow2.c                      |  6 +--
 block/quorum.c                     | 12 ++----
 block/replication.c                | 21 ++++------
 block/snapshot.c                   |  6 +--
 block/stream.c                     | 16 +++-----
 block/vmdk.c                       | 30 +++++----------
 blockdev.c                         | 10 ++---
 blockjob.c                         | 18 +++------
 include/block/graph-lock.h         |  8 +++-
 scripts/block-coroutine-wrapper.py |  4 +-
 tests/unit/test-bdrv-drain.c       | 58 ++++++++++------------------
 tests/unit/test-bdrv-graph-mod.c   | 30 +++++----------
 20 files changed, 152 insertions(+), 234 deletions(-)

diff --git a/block.c b/block.c
index d84ac2f394..836e23b989 100644
--- a/block.c
+++ b/block.c
@@ -1720,14 +1720,12 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
 open_failed:
     bs->drv = NULL;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     if (bs->file != NULL) {
         bdrv_unref_child(bs, bs->file);
         assert(!bs->file);
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -3587,11 +3585,9 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_ref(drain_bs);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     bdrv_unref(drain_bs);
 
     return ret;
@@ -3783,12 +3779,10 @@ static BdrvChild *bdrv_open_child_common(const char *filename,
         return NULL;
     }
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     return child;
 }
@@ -4640,9 +4634,9 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         bdrv_reopen_commit(&bs_entry->state);
     }
 
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     tran_commit(tran);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
 
     QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         BlockDriverState *bs = bs_entry->state.bs;
@@ -4656,9 +4650,9 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     goto cleanup;
 
 abort:
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     tran_abort(tran);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
 
     QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (bs_entry->prepared) {
@@ -4813,14 +4807,12 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     }
 
     bdrv_graph_rdunlock_main_loop();
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
 
     ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
                                           tran, errp);
 
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     if (old_child_bs) {
         bdrv_unref(old_child_bs);
@@ -5164,16 +5156,14 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
 
     assert(!bs->backing);
     assert(!bs->file);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -5466,9 +5456,9 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_drained_begin(child_bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(child_bs);
 
     return ret;
@@ -5499,8 +5489,7 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     assert(!bs_new->backing);
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
 
     child = bdrv_attach_child_noperm(bs_new, bs_top, "backing",
                                      &child_of_bds, bdrv_backing_role(bs_new),
@@ -5520,8 +5509,7 @@ out:
     tran_finalize(tran, ret);
 
     bdrv_refresh_limits(bs_top, NULL, NULL);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     return ret;
 }
@@ -5540,7 +5528,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     bdrv_ref(old_bs);
     bdrv_drained_begin(old_bs);
     bdrv_drained_begin(new_bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
 
     bdrv_replace_child_tran(child, new_bs, tran);
 
@@ -5551,7 +5539,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
 
     tran_finalize(tran, ret);
 
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(old_bs);
     bdrv_drained_end(new_bs);
     bdrv_unref(old_bs);
@@ -5633,9 +5621,9 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
     bdrv_ref(bs);
     bdrv_drained_begin(bs);
     bdrv_drained_begin(new_node_bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     ret = bdrv_replace_node(bs, new_node_bs, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(new_node_bs);
     bdrv_drained_end(bs);
     bdrv_unref(bs);
@@ -5891,7 +5879,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 
     bdrv_ref(top);
     bdrv_drained_begin(base);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
 
     if (!top->drv || !base->drv) {
         goto exit_wrlock;
@@ -5931,7 +5919,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
      * That's a FIXME.
      */
     bdrv_replace_node_common(top, base, false, false, &local_err);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
 
     if (local_err) {
         error_report_err(local_err);
@@ -5969,7 +5957,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
     goto exit;
 
 exit_wrlock:
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
 exit:
     bdrv_drained_end(base);
     bdrv_unref(top);
diff --git a/block/backup.c b/block/backup.c
index 9d55e55b79..02f2cd8276 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -497,12 +497,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_copy_set_speed(bcs, speed);
 
     /* Required permissions are taken by copy-before-write filter target */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     return &job->common;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 70ac76f401..b08c584e08 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -281,11 +281,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     ret = 0;
 fail_log:
     if (ret < 0) {
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(true);
         bdrv_unref_child(bs, s->log_file);
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         s->log_file = NULL;
         qemu_mutex_destroy(&s->mutex);
     }
@@ -298,12 +296,10 @@ static void blk_log_writes_close(BlockDriverState *bs)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     qemu_mutex_destroy(&s->mutex);
 }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 3a71f7498c..554817f88c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -151,12 +151,10 @@ static void blkverify_close(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_unref_child(bs, s->test_file);
     s->test_file = NULL;
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/block-backend.c b/block/block-backend.c
index 2b30a34662..63393ddb73 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -889,11 +889,9 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_root_unref_child(root);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 /*
@@ -906,8 +904,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
 
     if ((bs->open_flags & BDRV_O_INACTIVE) && blk_can_inactivate(blk)) {
         blk->disable_perm = true;
@@ -921,8 +918,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        perm, shared_perm, blk, errp);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/commit.c b/block/commit.c
index 6c06b894ff..9791ac5d2a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -102,9 +102,9 @@ static void commit_abort(Job *job)
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_drained_begin(commit_top_backing_bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(commit_top_backing_bs);
 
     bdrv_unref(s->commit_top_bs);
@@ -342,8 +342,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * this is the responsibility of the interface (i.e. whoever calls
      * commit_start()).
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     s->base_overlay = bdrv_find_overlay(top, base);
     assert(s->base_overlay);
 
@@ -374,22 +373,19 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  iter_shared_perms, errp);
         if (ret < 0) {
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     if (ret < 0) {
         goto fail;
@@ -442,9 +438,9 @@ fail:
      * otherwise this would fail because of lack of permissions. */
     if (commit_top_bs) {
         bdrv_drained_begin(top);
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(false);
         bdrv_replace_node(commit_top_bs, top, &error_abort);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(false);
         bdrv_drained_end(top);
     }
 }
diff --git a/block/graph-lock.c b/block/graph-lock.c
index c81162b147..a2bc0de060 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -106,14 +106,20 @@ static uint32_t reader_count(void)
     return rd;
 }
 
-void no_coroutine_fn bdrv_graph_wrlock(void)
+void no_coroutine_fn bdrv_graph_wrlock(bool drain)
 {
     GLOBAL_STATE_CODE();
     assert(!qatomic_read(&has_writer));
     assert(!qemu_in_coroutine());
 
-    /* Make sure that constantly arriving new I/O doesn't cause starvation */
-    bdrv_drain_all_begin_nopoll();
+    if (drain) {
+        bdrv_drain_all_begin();
+    } else {
+        /*
+         * Make sure that constantly arriving new I/O doesn't cause starvation
+         */
+        bdrv_drain_all_begin_nopoll();
+    }
 
     /*
      * reader_count == 0: this means writer will read has_reader as 1
@@ -139,10 +145,12 @@ void no_coroutine_fn bdrv_graph_wrlock(void)
         smp_mb();
     } while (reader_count() >= 1);
 
-    bdrv_drain_all_end();
+    if (!drain) {
+        bdrv_drain_all_end();
+    }
 }
 
-void no_coroutine_fn bdrv_graph_wrunlock(void)
+void no_coroutine_fn bdrv_graph_wrunlock(bool drain)
 {
     GLOBAL_STATE_CODE();
     assert(qatomic_read(&has_writer));
@@ -168,6 +176,10 @@ void no_coroutine_fn bdrv_graph_wrunlock(void)
      * progress.
      */
     aio_bh_poll(qemu_get_aio_context());
+
+    if (drain) {
+        bdrv_drain_all_end();
+    }
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
diff --git a/block/mirror.c b/block/mirror.c
index 5c1acd650b..4acb03e61c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -762,7 +762,7 @@ static int mirror_exit_common(Job *job)
          * check for an op blocker on @to_replace, and we have our own
          * there.
          */
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(false);
         if (bdrv_recurse_can_replace(src, to_replace)) {
             bdrv_replace_node(to_replace, target_bs, &local_err);
         } else {
@@ -771,7 +771,7 @@ static int mirror_exit_common(Job *job)
                        "would not lead to an abrupt change of visible data",
                        to_replace->node_name, target_bs->node_name);
         }
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(false);
         bdrv_drained_end(to_replace);
         if (local_err) {
             error_report_err(local_err);
@@ -791,9 +791,9 @@ static int mirror_exit_common(Job *job)
      * valid.
      */
     block_job_remove_all_bdrv(bjob);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
 
     if (abort && s->base_ro && !bdrv_is_read_only(target_bs)) {
         bdrv_reopen_set_read_only(target_bs, true, NULL);
@@ -1904,15 +1904,13 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
                              BLK_PERM_CONSISTENT_READ,
                              errp);
     if (ret < 0) {
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         goto fail;
     }
 
@@ -1957,20 +1955,17 @@ static BlockJob *mirror_start_job(
             ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                      iter_shared_perms, errp);
             if (ret < 0) {
-                bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
+                bdrv_graph_wrunlock(true);
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             goto fail;
         }
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     QTAILQ_INIT(&s->ops_in_flight);
 
@@ -1996,12 +1991,12 @@ fail:
 
     bs_opaque->stop = true;
     bdrv_drained_begin(bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     assert(mirror_top_bs->backing->bs == bs);
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
     bdrv_replace_node(mirror_top_bs, bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(bs);
 
     bdrv_unref(mirror_top_bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index bba7c90713..8d0bc49e85 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2821,11 +2821,9 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     if (close_data_file && has_data_file(bs)) {
         GLOBAL_STATE_CODE();
         bdrv_graph_rdunlock_main_loop();
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(true);
         bdrv_unref_child(bs, s->data_file);
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         s->data_file = NULL;
         bdrv_graph_rdlock_main_loop();
     }
diff --git a/block/quorum.c b/block/quorum.c
index 3a5928d574..fd542b25f2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1037,16 +1037,14 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
 close_exit:
     /* cleanup on error */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     for (i = 0; i < s->num_children; i++) {
         if (!opened[i]) {
             continue;
         }
         bdrv_unref_child(bs, s->children[i]);
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     g_free(s->children);
     g_free(opened);
 exit:
@@ -1059,13 +1057,11 @@ static void quorum_close(BlockDriverState *bs)
     BDRVQuorumState *s = bs->opaque;
     int i;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     for (i = 0; i < s->num_children; i++) {
         bdrv_unref_child(bs, s->children[i]);
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     g_free(s->children);
 }
diff --git a/block/replication.c b/block/replication.c
index ec54a9a907..a2640a97f1 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -540,8 +540,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(true);
 
         bdrv_ref(hidden_disk->bs);
         s->hidden_disk = bdrv_attach_child(bs, hidden_disk->bs, "hidden disk",
@@ -549,8 +548,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                            &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             return;
         }
 
@@ -560,8 +558,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                               BDRV_CHILD_DATA, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             return;
         }
 
@@ -573,15 +570,13 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (!top_bs || !bdrv_is_root_node(top_bs) ||
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             reopen_backing_file(bs, false, NULL);
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
 
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
@@ -654,14 +649,12 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->stage = BLOCK_REPLICATION_DONE;
 
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(true);
         bdrv_unref_child(bs, s->secondary_disk);
         s->secondary_disk = NULL;
         bdrv_unref_child(bs, s->hidden_disk);
         s->hidden_disk = NULL;
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
 
         s->error = 0;
     } else {
diff --git a/block/snapshot.c b/block/snapshot.c
index 88c3190eff..7f79fe8056 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -291,11 +291,9 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         }
 
         /* .bdrv_open() will re-attach it */
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(true);
         bdrv_unref_child(bs, fallback);
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         memset(bs->opaque, 0, drv->instance_size);
diff --git a/block/stream.c b/block/stream.c
index 6e68b0c9f8..665e75099e 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -104,9 +104,9 @@ static int stream_prepare(Job *job)
             }
         }
 
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock(false);
         bdrv_set_backing_hd_drained(unfiltered_bs, base, &local_err);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(false);
 
         /*
          * This call will do I/O, so the graph can change again from here on.
@@ -371,12 +371,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached.
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         goto fail;
     }
 
@@ -396,13 +394,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  basic_flags, errp);
         if (ret < 0) {
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             goto fail;
         }
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/block/vmdk.c b/block/vmdk.c
index e76464685e..c626cf6157 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -271,8 +271,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *e;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     for (i = 0; i < s->num_extents; i++) {
         e = &s->extents[i];
         g_free(e->l1_table);
@@ -283,8 +282,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
             bdrv_unref_child(bs, e->file);
         }
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     g_free(s->extents);
 }
@@ -1249,11 +1247,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock(true);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
+                bdrv_graph_wrunlock(true);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1270,11 +1266,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             g_free(buf);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock(true);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
+                bdrv_graph_wrunlock(true);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1283,11 +1277,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock(true);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
+                bdrv_graph_wrunlock(true);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1295,11 +1287,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
             bdrv_graph_rdunlock_main_loop();
-            bdrv_drain_all_begin();
-            bdrv_graph_wrlock();
+            bdrv_graph_wrlock(true);
             bdrv_unref_child(bs, extent_file);
-            bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
+            bdrv_graph_wrunlock(true);
             bdrv_graph_rdlock_main_loop();
             ret = -ENOTSUP;
             goto out;
diff --git a/blockdev.c b/blockdev.c
index b6a4bc2bfc..267746172a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1576,9 +1576,9 @@ static void external_snapshot_abort(void *opaque)
             }
 
             bdrv_drained_begin(state->new_bs);
-            bdrv_graph_wrlock();
+            bdrv_graph_wrlock(false);
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(false);
             bdrv_drained_end(state->new_bs);
 
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
@@ -3539,8 +3539,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
     if (!parent_bs) {
@@ -3576,8 +3575,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     }
 
 out:
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
diff --git a/blockjob.c b/blockjob.c
index 390301d3cf..5a1d74a672 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,8 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     while (job->nodes) {
         GSList *l = job->nodes;
         BdrvChild *c = l->data;
@@ -211,8 +210,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
 
         g_slist_free_1(l);
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
@@ -498,8 +496,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     int ret;
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
         job_id = bdrv_get_device_name(bs);
@@ -508,8 +505,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job = job_create(job_id, &driver->job_driver, txn, bdrv_get_aio_context(bs),
                      flags, cb, opaque, errp);
     if (job == NULL) {
-        bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
+        bdrv_graph_wrunlock(true);
         return NULL;
     }
 
@@ -547,13 +543,11 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         goto fail;
     }
 
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     return job;
 
 fail:
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 2c26c72108..f291ccbc97 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -108,17 +108,21 @@ void unregister_aiocontext(AioContext *ctx);
  *
  * The wrlock can only be taken from the main loop, with BQL held, as only the
  * main loop is allowed to modify the graph.
+ *
+ * @drain whether bdrv_drain_all_begin() should be called before taking the lock
  */
 void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
-bdrv_graph_wrlock(void);
+bdrv_graph_wrlock(bool drain);
 
 /*
  * bdrv_graph_wrunlock:
  * Write finished, reset global has_writer to 0 and restart
  * all readers that are waiting.
+ *
+ * @drain whether bdrv_drain_all_end() should be called after releasing the lock
  */
 void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
-bdrv_graph_wrunlock(void);
+bdrv_graph_wrunlock(bool drain);
 
 /*
  * bdrv_graph_co_rdlock:
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39..3286c4fe02 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -259,8 +259,8 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
         graph_lock='    bdrv_graph_rdlock_main_loop();'
         graph_unlock='    bdrv_graph_rdunlock_main_loop();'
     elif func.graph_wrlock:
-        graph_lock='    bdrv_graph_wrlock();'
-        graph_unlock='    bdrv_graph_wrunlock();'
+        graph_lock='    bdrv_graph_wrlock(false);'
+        graph_unlock='    bdrv_graph_wrunlock(false);'
 
     return f"""\
 /*
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index d931c5183e..589ef66a11 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -772,11 +772,9 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     tjob->bs = src;
     job = &tjob->common;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     switch (result) {
     case TEST_JOB_SUCCESS:
@@ -955,13 +953,11 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 {
     BdrvChild *c, *next_c;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
         bdrv_unref_child(bs, c);
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1051,12 +1047,10 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1064,25 +1058,21 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1165,16 +1155,14 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
 
     bdrv_dec_in_flight(data->child_b->bs);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_unref_child(data->parent_b, data->child_b);
 
     bdrv_ref(data->c);
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 }
 
 static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1272,8 +1260,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
                                 BDRV_CHILD_DATA, &error_abort);
     child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
@@ -1283,8 +1270,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     bdrv_attach_child(parent_a, a, "PA-A",
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1701,8 +1687,7 @@ static void test_drop_intermediate_poll(void)
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     for (i = 0; i < 3; i++) {
         if (i) {
             /* Takes the reference to chain[i - 1] */
@@ -1710,8 +1695,7 @@ static void test_drop_intermediate_poll(void)
                               &chain_child_class, BDRV_CHILD_COW, &error_abort);
         }
     }
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1958,12 +1942,10 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     new_child_bs->total_sectors = 1;
 
     bdrv_ref(old_child_bs);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
@@ -1994,9 +1976,9 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     g_assert(parent_bs->quiesce_counter == old_drain_count);
     bdrv_drained_begin(old_child_bs);
     bdrv_drained_begin(new_child_bs);
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(false);
     bdrv_replace_node(old_child_bs, new_child_bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(false);
     bdrv_drained_end(new_child_bs);
     bdrv_drained_end(old_child_bs);
     g_assert(parent_bs->quiesce_counter == new_drain_count);
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 7b03ebe4b0..f4961d3f09 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -137,12 +137,10 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     ret = bdrv_append(filter, bs, NULL);
     g_assert_cmpint(ret, <, 0);
@@ -206,13 +204,11 @@ static void test_should_update_child(void)
 
     bdrv_set_backing_hd(target, bs, &error_abort);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
     bdrv_append(filter, bs, &error_abort);
 
     bdrv_graph_rdlock_main_loop();
@@ -248,8 +244,7 @@ static void test_parallel_exclusive_write(void)
     bdrv_ref(base);
     bdrv_ref(fl1);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
@@ -261,8 +256,7 @@ static void test_parallel_exclusive_write(void)
                       &error_abort);
 
     bdrv_replace_node(fl1, fl2, &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     bdrv_drained_end(fl2);
     bdrv_drained_end(fl1);
@@ -369,8 +363,7 @@ static void test_parallel_perm_update(void)
      */
     bdrv_ref(base);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(top, ws, "file", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     c_fl1 = bdrv_attach_child(ws, fl1, "first", &child_of_bds,
@@ -383,8 +376,7 @@ static void test_parallel_perm_update(void)
     bdrv_attach_child(fl2, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -438,13 +430,11 @@ static void test_append_greedy_filter(void)
     BlockDriverState *base = no_perm_node("base");
     BlockDriverState *fl = exclusive_writer_node("fl1");
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock(true);
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
-    bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
+    bdrv_graph_wrunlock(true);
 
     bdrv_append(fl, base, &error_abort);
     bdrv_unref(fl);
-- 
2.39.5



