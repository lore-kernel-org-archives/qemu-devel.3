Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0240CC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKGu-0003Xl-Od; Tue, 20 May 2025 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFK-0008N8-Uo; Tue, 20 May 2025 06:30:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKFH-00054I-Bh; Tue, 20 May 2025 06:30:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4937443B7B;
 Tue, 20 May 2025 12:30:24 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 15/24] block: move drain outside of bdrv_root_unref_child()
Date: Tue, 20 May 2025 12:30:03 +0200
Message-Id: <20250520103012.424311-16-f.ebner@proxmox.com>
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

bdrv_root_unref_child() is called by:
1. blk_remove_bs(), where a drained section is introduced.
2. bdrv_unref_child(), which runs under the graph lock, so the drain
   will be moved further up to its callers.
3. block_job_remove_all_bdrv(), where a drained section is introduced.

For all callers of bdrv_unref_child() a drained section is introduced,
they are not explicilty listed here. The caller quorum_del_child()
holds the graph lock, so it is not actually allowed to drain. This
will be addressed in the next commit.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Split up into smaller pieces, flesh out commit messages.

 block.c                      |  6 ++++--
 block/blklogwrites.c         |  4 ++++
 block/blkverify.c            |  2 ++
 block/block-backend.c        |  2 ++
 block/qcow2.c                |  2 ++
 block/quorum.c               |  6 ++++++
 block/replication.c          |  2 ++
 block/snapshot.c             |  2 ++
 block/vmdk.c                 | 10 ++++++++++
 blockjob.c                   |  2 ++
 tests/unit/test-bdrv-drain.c |  2 ++
 11 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index b9de3a25cf..dfe665e457 100644
--- a/block.c
+++ b/block.c
@@ -1721,12 +1721,14 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
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
@@ -3316,10 +3318,8 @@ void bdrv_root_unref_child(BdrvChild *child)
          * When the parent requiring a non-default AioContext is removed, the
          * node moves back to the main AioContext
          */
-        bdrv_drain_all_begin();
         bdrv_try_change_aio_context_locked(child_bs, qemu_get_aio_context(),
                                            NULL, NULL);
-        bdrv_drain_all_end();
     }
 
     bdrv_schedule_unref(child_bs);
@@ -5163,6 +5163,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
@@ -5171,6 +5172,7 @@ static void bdrv_close(BlockDriverState *bs)
     assert(!bs->backing);
     assert(!bs->file);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_free(bs->opaque);
     bs->opaque = NULL;
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
index 24cae3cb55..68209bb2f7 100644
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
diff --git a/block/qcow2.c b/block/qcow2.c
index 66fba89b41..420918b3c3 100644
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
index ed8ce801ee..81407a38ee 100644
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
@@ -1143,7 +1147,9 @@ quorum_del_child(BlockDriverState *bs, BdrvChild *child, Error **errp)
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
 
+    bdrv_drain_all_begin();
     bdrv_unref_child(bs, child);
+    bdrv_drain_all_end();
 
     quorum_refresh_flags(bs);
 }
diff --git a/block/replication.c b/block/replication.c
index 54cbd03e00..0879718854 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -656,12 +656,14 @@ static void replication_done(void *opaque, int ret)
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
index 9f300a78bd..28c9c43621 100644
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
diff --git a/block/vmdk.c b/block/vmdk.c
index 9c7ab037e1..89a7250120 100644
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
diff --git a/blockjob.c b/blockjob.c
index 44991e3ff7..e68181a35b 100644
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
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index ac76525e5a..c33f7d31c2 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -955,11 +955,13 @@ static void bdrv_test_top_close(BlockDriverState *bs)
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
-- 
2.39.5



