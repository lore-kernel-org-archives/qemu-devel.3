Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C6C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riE9g-0001aW-Ds; Thu, 07 Mar 2024 08:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE65-00062L-Ge; Thu, 07 Mar 2024 08:47:46 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE5z-00088q-Kc; Thu, 07 Mar 2024 08:47:45 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 758684888D;
 Thu,  7 Mar 2024 14:47:18 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v2 2/4] mirror: allow specifying working bitmap
Date: Thu,  7 Mar 2024 14:47:09 +0100
Message-Id: <20240307134711.709816-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307134711.709816-1-f.ebner@proxmox.com>
References: <20240307134711.709816-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

for the mirror job. The bitmap's granularity is used as the job's
granularity.

The new @bitmap parameter is marked unstable in the QAPI and can
currently only be used for @sync=full mode.

Clusters initially dirty in the bitmap as well as new writes are
copied to the target.

Using block-dirty-bitmap-clear and block-dirty-bitmap-merge API,
callers can simulate the three kinds of @BitmapSyncMode (which is used
by backup):
1. always: default, just pass bitmap as working bitmap.
2. never: copy bitmap and pass copy to the mirror job.
3. on-success: copy bitmap and pass copy to the mirror job and if
   successful, merge bitmap into original afterwards.

When the target image is a fresh "diff image", i.e. one that was not
used as the target of a previous mirror and the target image's cluster
size is larger than the bitmap's granularity, or when
@copy-mode=write-blocking is used, there is a pitfall, because the
cluster in the target image will be allocated, but not contain all the
data corresponding to the same region in the source image.

An idea to avoid the limitation would be to mark clusters which are
affected by unaligned writes and are not allocated in the target image
dirty, so they would be copied fully later. However, for migration,
the invariant that an actively synced mirror stays actively synced
(unless an error happens) is useful, because without that invariant,
migration might inactivate block devices when mirror still got work
to do and run into an assertion failure [0].

Another approach would be to read the missing data from the source
upon unaligned writes to be able to write the full target cluster
instead.

But certain targets like NBD do not allow querying the cluster size.
To avoid limiting/breaking the use case of syncing to an existing
target, which is arguably more common than the diff image use case,
document the limiation in QAPI.

This patch was originally based on one by Ma Haocong, but it has since
been modified pretty heavily, first by John and then again by Fiona.

[0]: https://lore.kernel.org/qemu-devel/1db7f571-cb7f-c293-04cc-cd856e060c3f@proxmox.com/

Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: John Snow <jsnow@redhat.com>
[FG: switch to bdrv_dirty_bitmap_merge_internal]
Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: rebase for 9.0
     get rid of bitmap mode parameter
     use caller-provided bitmap as working bitmap
     turn bitmap parameter experimental]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c                         | 95 ++++++++++++++++++++------
 blockdev.c                             | 39 +++++++++--
 include/block/block_int-global-state.h |  5 +-
 qapi/block-core.json                   | 37 +++++++++-
 tests/unit/test-block-iothread.c       |  2 +-
 5 files changed, 146 insertions(+), 32 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1609354db3..5c9a00b574 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -51,7 +51,7 @@ typedef struct MirrorBlockJob {
     BlockDriverState *to_replace;
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
-    bool is_none_mode;
+    MirrorSyncMode sync_mode;
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
@@ -73,6 +73,11 @@ typedef struct MirrorBlockJob {
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
+    /*
+     * Whether the bitmap is created locally or provided by the caller (for
+     * incremental sync).
+     */
+    bool dirty_bitmap_is_local;
     BdrvDirtyBitmap *dirty_bitmap;
     BdrvDirtyBitmapIter *dbi;
     uint8_t *buf;
@@ -687,7 +692,11 @@ static int mirror_exit_common(Job *job)
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
 
-    bdrv_release_dirty_bitmap(s->dirty_bitmap);
+    if (s->dirty_bitmap_is_local) {
+        bdrv_release_dirty_bitmap(s->dirty_bitmap);
+    } else {
+        bdrv_enable_dirty_bitmap(s->dirty_bitmap);
+    }
 
     /* Make sure that the source BDS doesn't go away during bdrv_replace_node,
      * before we can call bdrv_drained_end */
@@ -718,7 +727,8 @@ static int mirror_exit_common(Job *job)
                              &error_abort);
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing;
+        backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
 
         if (bdrv_cow_bs(unfiltered_target) != backing) {
@@ -815,6 +825,16 @@ static void mirror_abort(Job *job)
     assert(ret == 0);
 }
 
+/* Always called after commit/abort. */
+static void mirror_clean(Job *job)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
+
+    if (!s->dirty_bitmap_is_local && s->dirty_bitmap) {
+        bdrv_dirty_bitmap_set_busy(s->dirty_bitmap, false);
+    }
+}
+
 static void coroutine_fn mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -1011,7 +1031,8 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     mirror_free_init(s);
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if ((s->sync_mode == MIRROR_SYNC_MODE_TOP ||
+         s->sync_mode == MIRROR_SYNC_MODE_FULL) && s->dirty_bitmap_is_local) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
@@ -1024,6 +1045,14 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
      */
     mirror_top_opaque->job = s;
 
+    /*
+     * External/caller-provided bitmap can only be disabled now that
+     * bdrv_mirror_top_do_write() can access it.
+     */
+    if (!s->dirty_bitmap_is_local) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
+
     assert(!s->dbi);
     s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
     for (;;) {
@@ -1302,6 +1331,7 @@ static const BlockJobDriver mirror_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = mirror_cancel,
@@ -1320,6 +1350,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = commit_active_cancel,
@@ -1712,7 +1743,9 @@ static BlockJob *mirror_start_job(
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             MirrorSyncMode sync_mode,
+                             BdrvDirtyBitmap *bitmap,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1726,10 +1759,15 @@ static BlockJob *mirror_start_job(
 
     GLOBAL_STATE_CODE();
 
-    if (granularity == 0) {
+    /* QMP interface ensures these conditions */
+    assert(!bitmap || sync_mode == MIRROR_SYNC_MODE_FULL);
+    assert(!(bitmap && granularity));
+
+    if (bitmap) {
+        granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    } else if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
-
     assert(is_power_of_2(granularity));
 
     if (buf_size < 0) {
@@ -1869,7 +1907,7 @@ static BlockJob *mirror_start_job(
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
     qatomic_set(&s->copy_mode, copy_mode);
@@ -1883,17 +1921,27 @@ static BlockJob *mirror_start_job(
     }
     bdrv_graph_rdunlock_main_loop();
 
-    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
-                                               NULL, errp);
-    if (!s->dirty_bitmap) {
-        goto fail;
+    if (bitmap) {
+        s->dirty_bitmap_is_local = false;
+        s->dirty_bitmap = bitmap;
+        bdrv_dirty_bitmap_set_busy(s->dirty_bitmap, true);
+    } else {
+        s->dirty_bitmap_is_local = true;
+        s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs,
+                                                   granularity, NULL, errp);
+        if (!s->dirty_bitmap) {
+            goto fail;
+        }
     }
 
     /*
      * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
-     * mode.
+     * mode. For external/caller-provided bitmap, need to wait until
+     * bdrv_mirror_top_do_write() can actually access it before disabling.
      */
-    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    if (s->dirty_bitmap_is_local) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
 
     bdrv_graph_wrlock();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
@@ -1975,7 +2023,11 @@ fail:
         blk_unref(s->target);
         bs_opaque->job = NULL;
         if (s->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(s->dirty_bitmap);
+            if (s->dirty_bitmap_is_local) {
+                bdrv_release_dirty_bitmap(s->dirty_bitmap);
+            } else {
+                bdrv_dirty_bitmap_set_busy(s->dirty_bitmap, false);
+            }
         }
         job_early_fail(&s->common.job);
     }
@@ -1999,27 +2051,26 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
                   MirrorCopyMode copy_mode, Error **errp)
 {
-    bool is_none_mode;
     BlockDriverState *base;
 
     GLOBAL_STATE_CODE();
 
     bdrv_graph_rdlock_main_loop();
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     bdrv_graph_rdunlock_main_loop();
 
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
+                     &mirror_job_driver, mode, bitmap, base, false,
                      filter_node_name, true, copy_mode, errp);
 }
 
@@ -2047,9 +2098,9 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
-                     filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
-                     errp);
+                     &commit_active_job_driver, MIRROR_SYNC_MODE_FULL, NULL,
+                     base, auto_complete, filter_node_name, false,
+                     MIRROR_COPY_MODE_BACKGROUND, errp);
     if (!job) {
         goto error_restore_flags;
     }
diff --git a/blockdev.c b/blockdev.c
index 8dadbb353b..c76eb97a4c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2776,6 +2776,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockDriverState *target,
                                    const char *replaces,
                                    enum MirrorSyncMode sync,
+                                   const char *bitmap_name,
                                    BlockMirrorBackingMode backing_mode,
                                    bool zero_target,
                                    bool has_speed, int64_t speed,
@@ -2794,6 +2795,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 {
     BlockDriverState *unfiltered_bs;
     int job_flags = JOB_DEFAULT;
+    BdrvDirtyBitmap *bitmap = NULL;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
@@ -2844,6 +2846,28 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         return;
     }
 
+    if (bitmap_name) {
+        if (sync != MIRROR_SYNC_MODE_FULL) {
+            error_setg(errp, "Sync mode '%s' not supported with bitmap.",
+                       MirrorSyncMode_str(sync));
+            return;
+        }
+        if (granularity) {
+            error_setg(errp, "Granularity and bitmap cannot both be set");
+            return;
+        }
+
+        bitmap = bdrv_find_dirty_bitmap(bs, bitmap_name);
+        if (!bitmap) {
+            error_setg(errp, "Dirty bitmap '%s' not found", bitmap_name);
+            return;
+        }
+
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+            return;
+        }
+    }
+
     if (!bdrv_backing_chain_next(bs) && sync == MIRROR_SYNC_MODE_TOP) {
         sync = MIRROR_SYNC_MODE_FULL;
     }
@@ -2889,10 +2913,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target,
-                 replaces, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode, zero_target,
-                 on_source_error, on_target_error, unmap, filter_node_name,
-                 copy_mode, errp);
+                 replaces, job_flags, speed, granularity, buf_size, sync,
+                 bitmap, backing_mode, zero_target, on_source_error,
+                 on_target_error, unmap, filter_node_name, copy_mode, errp);
 }
 
 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
@@ -3033,7 +3056,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     }
 
     blockdev_mirror_common(arg->job_id, bs, target_bs,
-                           arg->replaces, arg->sync,
+                           arg->replaces, arg->sync, arg->bitmap,
                            backing_mode, zero_target,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
@@ -3053,6 +3076,7 @@ void qmp_blockdev_mirror(const char *job_id,
                          const char *device, const char *target,
                          const char *replaces,
                          MirrorSyncMode sync,
+                         const char *bitmap,
                          bool has_speed, int64_t speed,
                          bool has_granularity, uint32_t granularity,
                          bool has_buf_size, int64_t buf_size,
@@ -3093,8 +3117,9 @@ void qmp_blockdev_mirror(const char *job_id,
     }
 
     blockdev_mirror_common(job_id, bs, target_bs,
-                           replaces, sync, backing_mode,
-                           zero_target, has_speed, speed,
+                           replaces, sync, bitmap,
+                           backing_mode, zero_target,
+                           has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
                            has_on_source_error, on_source_error,
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 54f8c8cbcb..8b93db017e 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -138,6 +138,8 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
  * @granularity: The chosen granularity for the dirty bitmap.
  * @buf_size: The amount of data that can be in flight at one time.
  * @mode: Whether to collapse all images in the chain to the target.
+ * @bitmap: Use this bitmap as a working bitmap, i.e. non-dirty clusters are
+            only mirrored if written to later.
  * @backing_mode: How to establish the target's backing chain after completion.
  * @zero_target: Whether the target should be explicitly zero-initialized
  * @on_source_error: The action to take upon error reading from the source.
@@ -158,7 +160,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 59d75b0793..4859fffd48 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2191,6 +2191,18 @@
 #     destination (all the disk, only the sectors allocated in the
 #     topmost image, or only new I/O).
 #
+# @bitmap: The name of a bitmap to use as a working bitmap for
+#     sync=full mode.  This argument must be not be present for other
+#     sync modes and not at the same time as @granularity.  The
+#     bitmap's granularity is used as the job's granularity.  When
+#     the target is a diff image, i.e. one that should only contain
+#     the delta and was not synced to previously, the target's
+#     cluster size must not be larger than the bitmap's granularity.
+#     For a diff image target, using copy-mode=write-blocking should
+#     not be used, because unaligned writes will lead to allocated
+#     clusters with partial data in the target image!  The bitmap
+#     will be enabled after the job finishes.  (Since 9.0)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K if the
 #     image format doesn't have clusters, 4K if the clusters are
 #     smaller than that, else the cluster size.  Must be a power of 2
@@ -2228,12 +2240,18 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
+# Features:
+#
+# @unstable: Member @bitmap is experimental.
+#
 # Since: 1.3
 ##
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
+            'sync': 'MirrorSyncMode',
+            '*bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
+            '*mode': 'NewImageMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
@@ -2513,6 +2531,18 @@
 #     destination (all the disk, only the sectors allocated in the
 #     topmost image, or only new I/O).
 #
+# @bitmap: The name of a bitmap to use as a working bitmap for
+#     sync=full mode.  This argument must be not be present for other
+#     sync modes and not at the same time as @granularity.  The
+#     bitmap's granularity is used as the job's granularity.  When
+#     the target is a diff image, i.e. one that should only contain
+#     the delta and was not synced to previously, the target's
+#     cluster size must not be larger than the bitmap's granularity.
+#     For a diff image target, using copy-mode=write-blocking should
+#     not be used, because unaligned writes will lead to allocated
+#     clusters with partial data in the target image!  The bitmap
+#     will be enabled after the job finishes.  (Since 9.0)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K if the
 #     image format doesn't have clusters, 4K if the clusters are
 #     smaller than that, else the cluster size.  Must be a power of 2
@@ -2548,6 +2578,10 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
+# Features:
+#
+# @unstable: Member @bitmap is experimental.
+#
 # Since: 2.6
 #
 # Example:
@@ -2562,6 +2596,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
+            '*bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 3766d5de6b..b64158aa11 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -755,7 +755,7 @@ static void test_propagate_mirror(void)
 
     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
+                 MIRROR_SYNC_MODE_NONE, NULL, MIRROR_OPEN_BACKING_CHAIN, false,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
-- 
2.39.2



