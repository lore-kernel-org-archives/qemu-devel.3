Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C484C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Py-0005dx-DB; Fri, 30 May 2025 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pw-0005WU-M5; Fri, 30 May 2025 11:13:08 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Ps-0002Rg-HX; Fri, 30 May 2025 11:13:08 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9FEF744B93;
 Fri, 30 May 2025 17:11:51 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 24/48] block: add bdrv_graph_wrlock_drained() convenience
 wrapper
Date: Fri, 30 May 2025 17:11:01 +0200
Message-Id: <20250530151125.955508-25-f.ebner@proxmox.com>
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

Many write-locked sections are also drained sections. A new
bdrv_graph_wrunlock_drained() wrapper around bdrv_graph_wrunlock() is
introduced, which will begin a drained section first. A global
variable is used so bdrv_graph_wrunlock() knows if it also needs
to end such a drained section. Both the aio_poll call in
bdrv_graph_wrlock() and the aio_bh_poll() in bdrv_graph_wrunlock()
can re-enter a write-locked section. While for the latter, ending the
drain could be moved to before the call, the former requires that the
variable is a counter and not just a boolean.

Since the wrapper calls bdrv_drain_all_begin(), which must be called
with the graph unlocked, mark the wrapper as GRAPH_UNLOCKED too.

The switch to the new helpers was generated with the following
commands and then manually checked:
find . -name '*.c' -exec sed -i -z 's/bdrv_drain_all_begin();\n\s*bdrv_graph_wrlock();/bdrv_graph_wrlock_drained();/g' {} ';'
find . -name '*.c' -exec sed -i -z 's/bdrv_graph_wrunlock();\n\s*bdrv_drain_all_end();/bdrv_graph_wrunlock();/g' {} ';'

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v4:
* Adapt to context changes from earlier patch.
* Mark the wrapper as GRAPH_UNLOCKED itself

 block.c                          | 20 ++++------------
 block/backup.c                   |  4 +---
 block/blklogwrites.c             |  8 ++-----
 block/blkverify.c                |  4 +---
 block/block-backend.c            |  8 ++-----
 block/commit.c                   |  6 +----
 block/graph-lock.c               | 40 +++++++++++++++++++++++++++++---
 block/mirror.c                   |  7 +-----
 block/qcow2.c                    |  4 +---
 block/quorum.c                   |  8 ++-----
 block/replication.c              | 11 ++-------
 block/snapshot.c                 |  4 +---
 block/stream.c                   |  6 +----
 block/vmdk.c                     | 20 ++++------------
 blockdev.c                       |  4 +---
 blockjob.c                       | 10 ++------
 include/block/graph-lock.h       | 11 +++++++++
 tests/unit/test-bdrv-drain.c     | 36 +++++++---------------------
 tests/unit/test-bdrv-graph-mod.c | 20 ++++------------
 19 files changed, 90 insertions(+), 141 deletions(-)

diff --git a/block.c b/block.c
index bfd4340b24..1da10d55f0 100644
--- a/block.c
+++ b/block.c
@@ -1721,14 +1721,12 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
 open_failed:
     bs->drv = NULL;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     if (bs->file != NULL) {
         bdrv_unref_child(bs, bs->file);
         assert(!bs->file);
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -3602,11 +3600,9 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     int ret;
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     return ret;
 }
@@ -3797,12 +3793,10 @@ static BdrvChild *bdrv_open_child_common(const char *filename,
         return NULL;
     }
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     return child;
 }
@@ -5180,8 +5174,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
@@ -5189,7 +5182,6 @@ static void bdrv_close(BlockDriverState *bs)
     assert(!bs->backing);
     assert(!bs->file);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -5515,8 +5507,7 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     assert(!bs_new->backing);
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
 
     child = bdrv_attach_child_noperm(bs_new, bs_top, "backing",
                                      &child_of_bds, bdrv_backing_role(bs_new),
@@ -5537,7 +5528,6 @@ out:
 
     bdrv_refresh_limits(bs_top, NULL, NULL);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     return ret;
 }
diff --git a/block/backup.c b/block/backup.c
index 909027c17a..d4713fa1cd 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -498,12 +498,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_copy_set_speed(bcs, speed);
 
     /* Required permissions are taken by copy-before-write filter target */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     return &job->common;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 70ac76f401..aa1f888869 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -281,11 +281,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     ret = 0;
 fail_log:
     if (ret < 0) {
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock_drained();
         bdrv_unref_child(bs, s->log_file);
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         s->log_file = NULL;
         qemu_mutex_destroy(&s->mutex);
     }
@@ -298,12 +296,10 @@ static void blk_log_writes_close(BlockDriverState *bs)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     qemu_mutex_destroy(&s->mutex);
 }
 
diff --git a/block/blkverify.c b/block/blkverify.c
index 3a71f7498c..72efcbe7ef 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -151,12 +151,10 @@ static void blkverify_close(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_unref_child(bs, s->test_file);
     s->test_file = NULL;
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/block-backend.c b/block/block-backend.c
index 68209bb2f7..f8d6ba65c1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -889,11 +889,9 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_root_unref_child(root);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 /*
@@ -906,8 +904,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
 
     if ((bs->open_flags & BDRV_O_INACTIVE) && blk_can_inactivate(blk)) {
         blk->disable_perm = true;
@@ -922,7 +919,6 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        perm, shared_perm, blk, errp);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/commit.c b/block/commit.c
index 6c4b736ff8..dc1942483b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -392,8 +392,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * this is the responsibility of the interface (i.e. whoever calls
      * commit_start()).
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     s->base_overlay = bdrv_find_overlay(top, base);
     assert(s->base_overlay);
 
@@ -425,21 +424,18 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                                  iter_shared_perms, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     if (ret < 0) {
         goto fail;
diff --git a/block/graph-lock.c b/block/graph-lock.c
index c81162b147..b7319473a1 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -33,6 +33,17 @@ static QemuMutex aio_context_list_lock;
 /* Written and read with atomic operations. */
 static int has_writer;
 
+/*
+ * Many write-locked sections are also drained sections. There is a convenience
+ * wrapper bdrv_graph_wrlock_drained() which begins a drained section before
+ * acquiring the lock. This variable here is used so bdrv_graph_wrunlock() knows
+ * if it also needs to end such a drained section. It needs to be a counter,
+ * because the aio_poll() call in bdrv_graph_wrlock() might re-enter
+ * bdrv_graph_wrlock_drained(). And note that aio_bh_poll() in
+ * bdrv_graph_wrunlock() might also re-enter a write-locked section.
+ */
+static int wrlock_quiesced_counter;
+
 /*
  * A reader coroutine could move from an AioContext to another.
  * If this happens, there is no problem from the point of view of
@@ -112,8 +123,14 @@ void no_coroutine_fn bdrv_graph_wrlock(void)
     assert(!qatomic_read(&has_writer));
     assert(!qemu_in_coroutine());
 
-    /* Make sure that constantly arriving new I/O doesn't cause starvation */
-    bdrv_drain_all_begin_nopoll();
+    bool need_drain = wrlock_quiesced_counter == 0;
+
+    if (need_drain) {
+        /*
+         * Make sure that constantly arriving new I/O doesn't cause starvation
+         */
+        bdrv_drain_all_begin_nopoll();
+    }
 
     /*
      * reader_count == 0: this means writer will read has_reader as 1
@@ -139,7 +156,18 @@ void no_coroutine_fn bdrv_graph_wrlock(void)
         smp_mb();
     } while (reader_count() >= 1);
 
-    bdrv_drain_all_end();
+    if (need_drain) {
+        bdrv_drain_all_end();
+    }
+}
+
+void no_coroutine_fn bdrv_graph_wrlock_drained(void)
+{
+    GLOBAL_STATE_CODE();
+
+    bdrv_drain_all_begin();
+    wrlock_quiesced_counter++;
+    bdrv_graph_wrlock();
 }
 
 void no_coroutine_fn bdrv_graph_wrunlock(void)
@@ -168,6 +196,12 @@ void no_coroutine_fn bdrv_graph_wrunlock(void)
      * progress.
      */
     aio_bh_poll(qemu_get_aio_context());
+
+    if (wrlock_quiesced_counter > 0) {
+        bdrv_drain_all_end();
+        wrlock_quiesced_counter--;
+    }
+
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
diff --git a/block/mirror.c b/block/mirror.c
index 6e8caf4b49..82a6e50cf8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -2014,15 +2014,13 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
                              BLK_PERM_CONSISTENT_READ,
                              errp);
     if (ret < 0) {
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -2068,19 +2066,16 @@ static BlockJob *mirror_start_job(
                                      iter_shared_perms, errp);
             if (ret < 0) {
                 bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     QTAILQ_INIT(&s->ops_in_flight);
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 45451a7ee8..4aa9f9e068 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2823,11 +2823,9 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     if (close_data_file && has_data_file(bs)) {
         GLOBAL_STATE_CODE();
         bdrv_graph_rdunlock_main_loop();
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock_drained();
         bdrv_unref_child(bs, s->data_file);
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         s->data_file = NULL;
         bdrv_graph_rdlock_main_loop();
     }
diff --git a/block/quorum.c b/block/quorum.c
index cc3bc5f4e7..76a4feb2d9 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1037,8 +1037,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
 close_exit:
     /* cleanup on error */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     for (i = 0; i < s->num_children; i++) {
         if (!opened[i]) {
             continue;
@@ -1046,7 +1045,6 @@ close_exit:
         bdrv_unref_child(bs, s->children[i]);
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     g_free(s->children);
     g_free(opened);
 exit:
@@ -1059,13 +1057,11 @@ static void quorum_close(BlockDriverState *bs)
     BDRVQuorumState *s = bs->opaque;
     int i;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     for (i = 0; i < s->num_children; i++) {
         bdrv_unref_child(bs, s->children[i]);
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     g_free(s->children);
 }
diff --git a/block/replication.c b/block/replication.c
index 0879718854..83978b61f5 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -540,8 +540,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock_drained();
 
         bdrv_ref(hidden_disk->bs);
         s->hidden_disk = bdrv_attach_child(bs, hidden_disk->bs, "hidden disk",
@@ -550,7 +549,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             return;
         }
 
@@ -561,7 +559,6 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             return;
         }
 
@@ -574,14 +571,12 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             reopen_backing_file(bs, false, NULL);
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
 
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
@@ -656,14 +651,12 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->stage = BLOCK_REPLICATION_DONE;
 
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock_drained();
         bdrv_unref_child(bs, s->secondary_disk);
         s->secondary_disk = NULL;
         bdrv_unref_child(bs, s->hidden_disk);
         s->hidden_disk = NULL;
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
 
         s->error = 0;
     } else {
diff --git a/block/snapshot.c b/block/snapshot.c
index 28c9c43621..bd9d759b32 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -291,11 +291,9 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         }
 
         /* .bdrv_open() will re-attach it */
-        bdrv_drain_all_begin();
-        bdrv_graph_wrlock();
+        bdrv_graph_wrlock_drained();
         bdrv_unref_child(bs, fallback);
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         memset(bs->opaque, 0, drv->instance_size);
diff --git a/block/stream.c b/block/stream.c
index f5441f27f4..a6ef840e29 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -371,12 +371,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached.
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -397,12 +395,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                                  basic_flags, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/block/vmdk.c b/block/vmdk.c
index 89a7250120..04986c8d55 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -271,8 +271,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *e;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     for (i = 0; i < s->num_extents; i++) {
         e = &s->extents[i];
         g_free(e->l1_table);
@@ -284,7 +283,6 @@ static void vmdk_free_extents(BlockDriverState *bs)
         }
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     g_free(s->extents);
 }
@@ -1249,11 +1247,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock_drained();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1270,11 +1266,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             g_free(buf);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock_drained();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1283,11 +1277,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
             if (ret) {
                 bdrv_graph_rdunlock_main_loop();
-                bdrv_drain_all_begin();
-                bdrv_graph_wrlock();
+                bdrv_graph_wrlock_drained();
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
-                bdrv_drain_all_end();
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1295,11 +1287,9 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
             bdrv_graph_rdunlock_main_loop();
-            bdrv_drain_all_begin();
-            bdrv_graph_wrlock();
+            bdrv_graph_wrlock_drained();
             bdrv_unref_child(bs, extent_file);
             bdrv_graph_wrunlock();
-            bdrv_drain_all_end();
             bdrv_graph_rdlock_main_loop();
             ret = -ENOTSUP;
             goto out;
diff --git a/blockdev.c b/blockdev.c
index 2e7fda6780..e625534925 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3561,8 +3561,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
     if (!parent_bs) {
@@ -3599,7 +3598,6 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
 
 out:
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
diff --git a/blockjob.c b/blockjob.c
index e68181a35b..db7c3a69a0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,8 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     while (job->nodes) {
         GSList *l = job->nodes;
         BdrvChild *c = l->data;
@@ -212,7 +211,6 @@ void block_job_remove_all_bdrv(BlockJob *job)
         g_slist_free_1(l);
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
@@ -498,8 +496,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     int ret;
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
         job_id = bdrv_get_device_name(bs);
@@ -509,7 +506,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                      flags, cb, opaque, errp);
     if (job == NULL) {
         bdrv_graph_wrunlock();
-        bdrv_drain_all_end();
         return NULL;
     }
 
@@ -548,12 +544,10 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     }
 
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     return job;
 
 fail:
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 2c26c72108..b564cba2c0 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -112,10 +112,21 @@ void unregister_aiocontext(AioContext *ctx);
 void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
 bdrv_graph_wrlock(void);
 
+/*
+ * bdrv_graph_wrlock_drained:
+ * Similar to bdrv_graph_wrlock, but will begin a drained section before
+ * locking.
+ */
+void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA GRAPH_UNLOCKED
+bdrv_graph_wrlock_drained(void);
+
 /*
  * bdrv_graph_wrunlock:
  * Write finished, reset global has_writer to 0 and restart
  * all readers that are waiting.
+ *
+ * Also ends the drained section if bdrv_graph_wrlock_drained() was used to lock
+ * the graph.
  */
 void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
 bdrv_graph_wrunlock(void);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 59c2793725..3369c2c2aa 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -772,11 +772,9 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     tjob->bs = src;
     job = &tjob->common;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     switch (result) {
     case TEST_JOB_SUCCESS:
@@ -955,13 +953,11 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 {
     BdrvChild *c, *next_c;
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
         bdrv_unref_child(bs, c);
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1053,12 +1049,10 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1066,25 +1060,21 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1167,8 +1157,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
 
     bdrv_dec_in_flight(data->child_b->bs);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_unref_child(data->parent_b, data->child_b);
 
     bdrv_ref(data->c);
@@ -1176,7 +1165,6 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 }
 
 static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1274,8 +1262,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
                                 BDRV_CHILD_DATA, &error_abort);
     child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
@@ -1286,7 +1273,6 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1699,8 +1685,7 @@ static void test_drop_intermediate_poll(void)
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     for (i = 0; i < 3; i++) {
         if (i) {
             /* Takes the reference to chain[i - 1] */
@@ -1709,7 +1694,6 @@ static void test_drop_intermediate_poll(void)
         }
     }
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1956,12 +1940,10 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     new_child_bs->total_sectors = 1;
 
     bdrv_ref(old_child_bs);
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 7b03ebe4b0..b077f0e3e3 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -137,12 +137,10 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     ret = bdrv_append(filter, bs, NULL);
     g_assert_cmpint(ret, <, 0);
@@ -206,13 +204,11 @@ static void test_should_update_child(void)
 
     bdrv_set_backing_hd(target, bs, &error_abort);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
     bdrv_append(filter, bs, &error_abort);
 
     bdrv_graph_rdlock_main_loop();
@@ -248,8 +244,7 @@ static void test_parallel_exclusive_write(void)
     bdrv_ref(base);
     bdrv_ref(fl1);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
@@ -262,7 +257,6 @@ static void test_parallel_exclusive_write(void)
 
     bdrv_replace_node(fl1, fl2, &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     bdrv_drained_end(fl2);
     bdrv_drained_end(fl1);
@@ -369,8 +363,7 @@ static void test_parallel_perm_update(void)
      */
     bdrv_ref(base);
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(top, ws, "file", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     c_fl1 = bdrv_attach_child(ws, fl1, "first", &child_of_bds,
@@ -384,7 +377,6 @@ static void test_parallel_perm_update(void)
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -438,13 +430,11 @@ static void test_append_greedy_filter(void)
     BlockDriverState *base = no_perm_node("base");
     BlockDriverState *fl = exclusive_writer_node("fl1");
 
-    bdrv_drain_all_begin();
-    bdrv_graph_wrlock();
+    bdrv_graph_wrlock_drained();
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
-    bdrv_drain_all_end();
 
     bdrv_append(fl, base, &error_abort);
     bdrv_unref(fl);
-- 
2.39.5



