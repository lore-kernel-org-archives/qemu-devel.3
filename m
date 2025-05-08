Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4680CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1wo-00023G-6t; Thu, 08 May 2025 10:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wm-00020D-5d; Thu, 08 May 2025 10:10:00 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wg-0008UC-QZ; Thu, 08 May 2025 10:09:59 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 98F9542E20;
 Thu,  8 May 2025 16:09:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 09/11] block: move drain out of bdrv_change_aio_context()
Date: Thu,  8 May 2025 16:09:34 +0200
Message-Id: <20250508140936.3344485-10-f.ebner@proxmox.com>
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

While bdrv_drained_begin() is now marked as GRAPH_UNLOCKED, TSA is not
able to catch a remaining instance where the function is called with
the graph lock held in bdrv_change_aio_context(). This is because the
call is preceded by a bdrv_graph_rdunlock_main_loop(), but for callers
that hold the exclusive lock that does not actually release the lock.

In combination with block-stream, there is a deadlock that can happen
because of this [0]. In particular, it can happen that
main thread              IO thread
1. acquires write lock
                         in blk_co_do_preadv_part():
                         2. have non-zero blk->in_flight
                         3. try to acquire read lock
4. begin drain

Steps 3 and 4 might be switched. Draining will poll and get stuck,
because it will see the non-zero in_flight counter. But the IO thread
will not make any progress either, because it cannot acquire the read
lock.

More granular draining is not trivially possible, because
bdrv_change_aio_context() can recursively call itself e.g. via
bdrv_child_change_aio_context().

[0]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/

Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c                            | 91 ++++++++++++++++++++----------
 block/backup.c                     |  2 +
 block/blklogwrites.c               |  4 ++
 block/blkverify.c                  |  2 +
 block/block-backend.c              |  4 ++
 block/commit.c                     |  4 ++
 block/mirror.c                     |  5 ++
 block/qcow2.c                      |  2 +
 block/quorum.c                     |  4 ++
 block/replication.c                |  7 +++
 block/snapshot.c                   |  2 +
 block/stream.c                     | 10 ++--
 block/vmdk.c                       | 10 ++++
 blockdev.c                         | 17 ++++--
 blockjob.c                         |  6 ++
 include/block/block-global-state.h |  8 ++-
 tests/unit/test-bdrv-drain.c       | 18 ++++++
 tests/unit/test-bdrv-graph-mod.c   | 10 ++++
 18 files changed, 164 insertions(+), 42 deletions(-)

diff --git a/block.c b/block.c
index 10052027cd..d84ac2f394 100644
--- a/block.c
+++ b/block.c
@@ -1720,12 +1720,14 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
 open_failed:
     bs->drv = NULL;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     if (bs->file != NULL) {
         bdrv_unref_child(bs, bs->file);
         assert(!bs->file);
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -3027,7 +3029,8 @@ static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
     bdrv_replace_child_noperm(s->child, NULL);
 
     if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
-        bdrv_try_change_aio_context(bs, s->old_child_ctx, NULL, &error_abort);
+        bdrv_try_change_aio_context_locked(bs, s->old_child_ctx, NULL,
+                                           &error_abort);
     }
 
     if (bdrv_child_get_parent_aio_context(s->child) != s->old_parent_ctx) {
@@ -3112,8 +3115,8 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
     parent_ctx = bdrv_child_get_parent_aio_context(new_child);
     if (child_ctx != parent_ctx) {
         Error *local_err = NULL;
-        int ret = bdrv_try_change_aio_context(child_bs, parent_ctx, NULL,
-                                              &local_err);
+        int ret = bdrv_try_change_aio_context_locked(child_bs, parent_ctx, NULL,
+                                                     &local_err);
 
         if (ret < 0 && child_class->change_aio_ctx) {
             Transaction *aio_ctx_tran = tran_new();
@@ -3314,8 +3317,8 @@ void bdrv_root_unref_child(BdrvChild *child)
          * When the parent requiring a non-default AioContext is removed, the
          * node moves back to the main AioContext
          */
-        bdrv_try_change_aio_context(child_bs, qemu_get_aio_context(), NULL,
-                                    NULL);
+        bdrv_try_change_aio_context_locked(child_bs, qemu_get_aio_context(),
+                                           NULL, NULL);
     }
 
     bdrv_schedule_unref(child_bs);
@@ -3584,11 +3587,11 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bdrv_graph_rdunlock_main_loop();
 
     bdrv_ref(drain_bs);
-    bdrv_drained_begin(drain_bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
     bdrv_graph_wrunlock();
-    bdrv_drained_end(drain_bs);
+    bdrv_drain_all_end();
     bdrv_unref(drain_bs);
 
     return ret;
@@ -3780,10 +3783,12 @@ static BdrvChild *bdrv_open_child_common(const char *filename,
         return NULL;
     }
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     return child;
 }
@@ -4805,20 +4810,19 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
 
     if (old_child_bs) {
         bdrv_ref(old_child_bs);
-        bdrv_graph_rdunlock_main_loop();
-        bdrv_drained_begin(old_child_bs);
-    } else {
-        bdrv_graph_rdunlock_main_loop();
     }
+
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
                                           tran, errp);
 
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     if (old_child_bs) {
-        bdrv_drained_end(old_child_bs);
         bdrv_unref(old_child_bs);
     }
 
@@ -5160,6 +5164,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
@@ -5168,6 +5173,7 @@ static void bdrv_close(BlockDriverState *bs)
     assert(!bs->backing);
     assert(!bs->file);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -5493,9 +5499,7 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     assert(!bs_new->backing);
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_drained_begin(bs_top);
-    bdrv_drained_begin(bs_new);
-
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     child = bdrv_attach_child_noperm(bs_new, bs_top, "backing",
@@ -5517,9 +5521,7 @@ out:
 
     bdrv_refresh_limits(bs_top, NULL, NULL);
     bdrv_graph_wrunlock();
-
-    bdrv_drained_end(bs_top);
-    bdrv_drained_end(bs_new);
+    bdrv_drain_all_end();
 
     return ret;
 }
@@ -7626,10 +7628,6 @@ bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
 static void bdrv_set_aio_context_clean(void *opaque)
 {
     BdrvStateSetAioContext *state = (BdrvStateSetAioContext *) opaque;
-    BlockDriverState *bs = (BlockDriverState *) state->bs;
-
-    /* Paired with bdrv_drained_begin in bdrv_change_aio_context() */
-    bdrv_drained_end(bs);
 
     g_free(state);
 }
@@ -7693,8 +7691,7 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
         .bs = bs,
     };
 
-    /* Paired with bdrv_drained_end in bdrv_set_aio_context_clean() */
-    bdrv_drained_begin(bs);
+    assert(qatomic_read(&bs->quiesce_counter) > 0);
 
     tran_add(tran, &set_aio_context, state);
 
@@ -7702,14 +7699,12 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
 }
 
 /*
- * Change bs's and recursively all of its parents' and children's AioContext
- * to the given new context, returning an error if that isn't possible.
- *
- * If ignore_child is not NULL, that child (and its subgraph) will not
- * be touched.
+ * Use bdrv_try_change_aio_context() or bdrv_try_change_aio_context_locked().
  */
-int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
-                                BdrvChild *ignore_child, Error **errp)
+static int bdrv_try_change_aio_context_common(BlockDriverState *bs,
+                                              AioContext *ctx,
+                                              BdrvChild *ignore_child,
+                                              Error **errp)
 {
     Transaction *tran;
     GHashTable *visited;
@@ -7747,6 +7742,40 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
     return 0;
 }
 
+/*
+ * Change bs's and recursively all of its parents' and children's AioContext
+ * to the given new context, returning an error if that isn't possible.
+ *
+ * If ignore_child is not NULL, that child (and its subgraph) will not
+ * be touched.
+ */
+int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
+                                BdrvChild *ignore_child, Error **errp)
+{
+    int ret;
+    bdrv_drain_all_begin();
+    ret = bdrv_try_change_aio_context_common(bs, ctx, ignore_child, errp);
+    bdrv_drain_all_end();
+    return ret;
+}
+
+/*
+ * Change bs's and recursively all of its parents' and children's AioContext
+ * to the given new context, returning an error if that isn't possible.
+ *
+ * If ignore_child is not NULL, that child (and its subgraph) will not
+ * be touched.
+ *
+ * Called with the graph lock held.
+ *
+ * Called while all bs are drained.
+ */
+int bdrv_try_change_aio_context_locked(BlockDriverState *bs, AioContext *ctx,
+                                       BdrvChild *ignore_child, Error **errp)
+{
+    return bdrv_try_change_aio_context_common(bs, ctx, ignore_child, errp);
+}
+
 void bdrv_add_aio_context_notifier(BlockDriverState *bs,
         void (*attached_aio_context)(AioContext *new_context, void *opaque),
         void (*detach_aio_context)(void *opaque), void *opaque)
diff --git a/block/backup.c b/block/backup.c
index 79652bf57b..9d55e55b79 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -497,10 +497,12 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_copy_set_speed(bcs, speed);
 
     /* Required permissions are taken by copy-before-write filter target */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     return &job->common;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index b0f78c4bc7..70ac76f401 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -281,9 +281,11 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     ret = 0;
 fail_log:
     if (ret < 0) {
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
         bdrv_unref_child(bs, s->log_file);
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         s->log_file = NULL;
         qemu_mutex_destroy(&s->mutex);
     }
@@ -296,10 +298,12 @@ static void blk_log_writes_close(BlockDriverState *bs)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     qemu_mutex_destroy(&s->mutex);
 }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index db79a36681..3a71f7498c 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -151,10 +151,12 @@ static void blkverify_close(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_unref_child(bs, s->test_file);
     s->test_file = NULL;
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/block-backend.c b/block/block-backend.c
index a402db13f2..2b30a34662 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -889,9 +889,11 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_root_unref_child(root);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 /*
@@ -904,6 +906,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     if ((bs->open_flags & BDRV_O_INACTIVE) && blk_can_inactivate(blk)) {
@@ -919,6 +922,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        perm, shared_perm, blk, errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/commit.c b/block/commit.c
index 5df3d05346..6c06b894ff 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -342,6 +342,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * this is the responsibility of the interface (i.e. whoever calls
      * commit_start()).
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     s->base_overlay = bdrv_find_overlay(top, base);
     assert(s->base_overlay);
@@ -374,18 +375,21 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                                  iter_shared_perms, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     if (ret < 0) {
         goto fail;
diff --git a/block/mirror.c b/block/mirror.c
index a53582f17b..5c1acd650b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1904,6 +1904,7 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
@@ -1911,6 +1912,7 @@ static BlockJob *mirror_start_job(
                              errp);
     if (ret < 0) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -1956,16 +1958,19 @@ static BlockJob *mirror_start_job(
                                      iter_shared_perms, errp);
             if (ret < 0) {
                 bdrv_graph_wrunlock();
+                bdrv_drain_all_end();
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     QTAILQ_INIT(&s->ops_in_flight);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f090..bba7c90713 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2821,9 +2821,11 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     if (close_data_file && has_data_file(bs)) {
         GLOBAL_STATE_CODE();
         bdrv_graph_rdunlock_main_loop();
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
         bdrv_unref_child(bs, s->data_file);
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         s->data_file = NULL;
         bdrv_graph_rdlock_main_loop();
     }
diff --git a/block/quorum.c b/block/quorum.c
index 30747a6df9..3a5928d574 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1037,6 +1037,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
 close_exit:
     /* cleanup on error */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     for (i = 0; i < s->num_children; i++) {
         if (!opened[i]) {
@@ -1045,6 +1046,7 @@ close_exit:
         bdrv_unref_child(bs, s->children[i]);
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     g_free(s->children);
     g_free(opened);
 exit:
@@ -1057,11 +1059,13 @@ static void quorum_close(BlockDriverState *bs)
     BDRVQuorumState *s = bs->opaque;
     int i;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     for (i = 0; i < s->num_children; i++) {
         bdrv_unref_child(bs, s->children[i]);
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_free(s->children);
 }
diff --git a/block/replication.c b/block/replication.c
index d6625c51fe..ec54a9a907 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -540,6 +540,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
 
         bdrv_ref(hidden_disk->bs);
@@ -549,6 +550,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             return;
         }
 
@@ -559,6 +561,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             return;
         }
 
@@ -571,12 +574,14 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             reopen_backing_file(bs, false, NULL);
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
 
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
@@ -649,12 +654,14 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->stage = BLOCK_REPLICATION_DONE;
 
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
         bdrv_unref_child(bs, s->secondary_disk);
         s->secondary_disk = NULL;
         bdrv_unref_child(bs, s->hidden_disk);
         s->hidden_disk = NULL;
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
 
         s->error = 0;
     } else {
diff --git a/block/snapshot.c b/block/snapshot.c
index 7788e1130b..88c3190eff 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -291,9 +291,11 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         }
 
         /* .bdrv_open() will re-attach it */
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
         bdrv_unref_child(bs, fallback);
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         memset(bs->opaque, 0, drv->instance_size);
diff --git a/block/stream.c b/block/stream.c
index 999d9e56d4..6e68b0c9f8 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -80,10 +80,9 @@ static int stream_prepare(Job *job)
      * may end up working with the wrong base node (or it might even have gone
      * away by the time we want to use it).
      */
-    bdrv_drained_begin(unfiltered_bs);
+    bdrv_drain_all_begin();
     if (unfiltered_bs_cow) {
         bdrv_ref(unfiltered_bs_cow);
-        bdrv_drained_begin(unfiltered_bs_cow);
     }
 
     bdrv_graph_rdlock_main_loop();
@@ -124,10 +123,9 @@ static int stream_prepare(Job *job)
 
 out:
     if (unfiltered_bs_cow) {
-        bdrv_drained_end(unfiltered_bs_cow);
         bdrv_unref(unfiltered_bs_cow);
     }
-    bdrv_drained_end(unfiltered_bs);
+    bdrv_drain_all_end();
     return ret;
 }
 
@@ -373,10 +371,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached.
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -397,10 +397,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                                  basic_flags, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/block/vmdk.c b/block/vmdk.c
index 2adec49912..e76464685e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -271,6 +271,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *e;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     for (i = 0; i < s->num_extents; i++) {
         e = &s->extents[i];
@@ -283,6 +284,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_free(s->extents);
 }
@@ -1247,9 +1249,11 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
                 bdrv_graph_rdunlock_main_loop();
+                bdrv_drain_all_begin();
                 bdrv_graph_wrlock();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1266,9 +1270,11 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             g_free(buf);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
+                bdrv_drain_all_begin();
                 bdrv_graph_wrlock();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1277,9 +1283,11 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
+                bdrv_drain_all_begin();
                 bdrv_graph_wrlock();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1287,9 +1295,11 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
             bdrv_graph_rdunlock_main_loop();
+            bdrv_drain_all_begin();
             bdrv_graph_wrlock();
             bdrv_unref_child(bs, extent_file);
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             bdrv_graph_rdlock_main_loop();
             ret = -ENOTSUP;
             goto out;
diff --git a/blockdev.c b/blockdev.c
index 4a672f9bac..b6a4bc2bfc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3539,6 +3539,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
@@ -3576,6 +3577,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
 
 out:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
@@ -3609,12 +3611,13 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     AioContext *new_context;
     BlockDriverState *bs;
 
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     bs = bdrv_find_node(node_name);
     if (!bs) {
         error_setg(errp, "Failed to find node with node-name='%s'", node_name);
-        return;
+        goto out;
     }
 
     /* Protects against accidents. */
@@ -3622,14 +3625,14 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
         error_setg(errp, "Node %s is associated with a BlockBackend and could "
                          "be in use (use force=true to override this check)",
                          node_name);
-        return;
+        goto out;
     }
 
     if (iothread->type == QTYPE_QSTRING) {
         IOThread *obj = iothread_by_id(iothread->u.s);
         if (!obj) {
             error_setg(errp, "Cannot find iothread %s", iothread->u.s);
-            return;
+            goto out;
         }
 
         new_context = iothread_get_aio_context(obj);
@@ -3637,7 +3640,11 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
         new_context = qemu_get_aio_context();
     }
 
-    bdrv_try_change_aio_context(bs, new_context, NULL, errp);
+    bdrv_try_change_aio_context_locked(bs, new_context, NULL, errp);
+
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 }
 
 QemuOptsList qemu_common_drive_opts = {
diff --git a/blockjob.c b/blockjob.c
index 32007f31a9..390301d3cf 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,6 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     while (job->nodes) {
         GSList *l = job->nodes;
@@ -211,6 +212,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
         g_slist_free_1(l);
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
@@ -496,6 +498,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     int ret;
     GLOBAL_STATE_CODE();
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
@@ -506,6 +509,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                      flags, cb, opaque, errp);
     if (job == NULL) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         return NULL;
     }
 
@@ -544,10 +548,12 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     }
 
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     return job;
 
 fail:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9be34b3c99..da842e6019 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -277,8 +277,12 @@ bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag);
 bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
                                    GHashTable *visited, Transaction *tran,
                                    Error **errp);
-int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
-                                BdrvChild *ignore_child, Error **errp);
+int GRAPH_UNLOCKED
+bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
+                            BdrvChild *ignore_child, Error **errp);
+int GRAPH_RDLOCK
+bdrv_try_change_aio_context_locked(BlockDriverState *bs, AioContext *ctx,
+                                   BdrvChild *ignore_child, Error **errp);
 
 int GRAPH_RDLOCK bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 290cd2a70e..d931c5183e 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -772,9 +772,11 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     tjob->bs = src;
     job = &tjob->common;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     switch (result) {
     case TEST_JOB_SUCCESS:
@@ -953,11 +955,13 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 {
     BdrvChild *c, *next_c;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
         bdrv_unref_child(bs, c);
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1047,10 +1051,12 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1058,21 +1064,25 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1155,6 +1165,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
 
     bdrv_dec_in_flight(data->child_b->bs);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_unref_child(data->parent_b, data->child_b);
 
@@ -1163,6 +1174,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1260,6 +1272,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
                                 BDRV_CHILD_DATA, &error_abort);
@@ -1271,6 +1284,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1687,6 +1701,7 @@ static void test_drop_intermediate_poll(void)
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     for (i = 0; i < 3; i++) {
         if (i) {
@@ -1696,6 +1711,7 @@ static void test_drop_intermediate_poll(void)
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1942,10 +1958,12 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     new_child_bs->total_sectors = 1;
 
     bdrv_ref(old_child_bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index d743abb4bb..7b03ebe4b0 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -137,10 +137,12 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     ret = bdrv_append(filter, bs, NULL);
     g_assert_cmpint(ret, <, 0);
@@ -204,11 +206,13 @@ static void test_should_update_child(void)
 
     bdrv_set_backing_hd(target, bs, &error_abort);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     bdrv_append(filter, bs, &error_abort);
 
     bdrv_graph_rdlock_main_loop();
@@ -244,6 +248,7 @@ static void test_parallel_exclusive_write(void)
     bdrv_ref(base);
     bdrv_ref(fl1);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
@@ -257,6 +262,7 @@ static void test_parallel_exclusive_write(void)
 
     bdrv_replace_node(fl1, fl2, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     bdrv_drained_end(fl2);
     bdrv_drained_end(fl1);
@@ -363,6 +369,7 @@ static void test_parallel_perm_update(void)
      */
     bdrv_ref(base);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, ws, "file", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
@@ -377,6 +384,7 @@ static void test_parallel_perm_update(void)
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -430,11 +438,13 @@ static void test_append_greedy_filter(void)
     BlockDriverState *base = no_perm_node("base");
     BlockDriverState *fl = exclusive_writer_node("fl1");
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     bdrv_append(fl, base, &error_abort);
     bdrv_unref(fl);
-- 
2.39.5



