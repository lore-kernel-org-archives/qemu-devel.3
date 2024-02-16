Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C4CC48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravsU-0008LP-Ve; Fri, 16 Feb 2024 05:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsT-0008Js-F2; Fri, 16 Feb 2024 05:55:33 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsP-0007cZ-Ii; Fri, 16 Feb 2024 05:55:33 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B2AD34852A;
 Fri, 16 Feb 2024 11:55:20 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
Subject: [RFC 1/4] drive-mirror: add support for sync=bitmap mode=never
Date: Fri, 16 Feb 2024 11:55:10 +0100
Message-Id: <20240216105513.309901-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216105513.309901-1-f.ebner@proxmox.com>
References: <20240216105513.309901-1-f.ebner@proxmox.com>
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

This patch adds support for the "BITMAP" sync mode to drive-mirror and
blockdev-mirror. It adds support only for the BitmapSyncMode "never,"
because it's the simplest mode.

This mode simply uses a user-provided bitmap as an initial copy
manifest, and then does not clear any bits in the bitmap at the
conclusion of the operation.

Any new writes dirtied during the operation are copied out, in contrast
to backup. Note that whether these writes are reflected in the bitmap
at the conclusion of the operation depends on whether that bitmap is
actually recording!

This patch was originally based on one by Ma Haocong, but it has since
been modified pretty heavily.

Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: John Snow <jsnow@redhat.com>
[FG: switch to bdrv_dirty_bitmap_merge_internal]
Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: rebase for 9.0
     update version and formatting in QAPI]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/mirror.c                         | 96 ++++++++++++++++++++------
 blockdev.c                             | 38 +++++++++-
 include/block/block_int-global-state.h |  4 +-
 qapi/block-core.json                   | 25 ++++++-
 tests/unit/test-block-iothread.c       |  4 +-
 5 files changed, 139 insertions(+), 28 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..315dff11e2 100644
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
@@ -73,6 +73,8 @@ typedef struct MirrorBlockJob {
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
+    BdrvDirtyBitmap *sync_bitmap;
+    BitmapSyncMode bitmap_mode;
     BdrvDirtyBitmap *dirty_bitmap;
     BdrvDirtyBitmapIter *dbi;
     uint8_t *buf;
@@ -718,7 +720,8 @@ static int mirror_exit_common(Job *job)
                              &error_abort);
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing;
+        backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
 
         if (bdrv_cow_bs(unfiltered_target) != backing) {
@@ -815,6 +818,16 @@ static void mirror_abort(Job *job)
     assert(ret == 0);
 }
 
+/* Always called after commit/abort. */
+static void mirror_clean(Job *job)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
+
+    if (s->sync_bitmap) {
+        bdrv_dirty_bitmap_set_busy(s->sync_bitmap, false);
+    }
+}
+
 static void coroutine_fn mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -1011,7 +1024,8 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     mirror_free_init(s);
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if ((s->sync_mode == MIRROR_SYNC_MODE_TOP) ||
+        (s->sync_mode == MIRROR_SYNC_MODE_FULL)) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
@@ -1302,6 +1316,7 @@ static const BlockJobDriver mirror_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = mirror_cancel,
@@ -1320,6 +1335,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
         .cancel                 = commit_active_cancel,
@@ -1712,7 +1728,10 @@ static BlockJob *mirror_start_job(
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             MirrorSyncMode sync_mode,
+                             BdrvDirtyBitmap *bitmap,
+                             BitmapSyncMode bitmap_mode,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1726,10 +1745,39 @@ static BlockJob *mirror_start_job(
 
     GLOBAL_STATE_CODE();
 
-    if (granularity == 0) {
-        granularity = bdrv_get_default_bitmap_granularity(target);
+    if (sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        error_setg(errp, "Sync mode '%s' not supported",
+                   MirrorSyncMode_str(sync_mode));
+        return NULL;
+    } else if (sync_mode == MIRROR_SYNC_MODE_BITMAP) {
+        if (!bitmap) {
+            error_setg(errp, "Must provide a valid bitmap name for '%s'"
+                       " sync mode",
+                       MirrorSyncMode_str(sync_mode));
+            return NULL;
+        } else if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
+            error_setg(errp,
+                       "Bitmap Sync Mode '%s' is not supported by Mirror",
+                       BitmapSyncMode_str(bitmap_mode));
+        }
+    } else if (bitmap) {
+        error_setg(errp,
+                   "sync mode '%s' is not compatible with bitmaps",
+                   MirrorSyncMode_str(sync_mode));
+        return NULL;
     }
 
+    if (bitmap) {
+        if (granularity) {
+            error_setg(errp, "granularity (%d)"
+                       "cannot be specified when a bitmap is provided",
+                       granularity);
+            return NULL;
+        }
+        granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    } else if (granularity == 0) {
+        granularity = bdrv_get_default_bitmap_granularity(target);
+    }
     assert(is_power_of_2(granularity));
 
     if (buf_size < 0) {
@@ -1869,7 +1917,9 @@ static BlockJob *mirror_start_job(
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
+    s->sync_bitmap = bitmap;
+    s->bitmap_mode = bitmap_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
     qatomic_set(&s->copy_mode, copy_mode);
@@ -1895,6 +1945,15 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
+    if (s->sync_bitmap) {
+        bdrv_dirty_bitmap_set_busy(s->sync_bitmap, true);
+    }
+
+    if (s->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
+        bdrv_dirty_bitmap_merge_internal(s->dirty_bitmap, s->sync_bitmap,
+                                         NULL, true);
+    }
+
     bdrv_graph_wrlock();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
@@ -1977,6 +2036,9 @@ fail:
         if (s->dirty_bitmap) {
             bdrv_release_dirty_bitmap(s->dirty_bitmap);
         }
+        if (s->sync_bitmap) {
+            bdrv_dirty_bitmap_set_busy(s->sync_bitmap, false);
+        }
         job_early_fail(&s->common.job);
     }
 
@@ -1999,35 +2061,28 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BitmapSyncMode bitmap_mode,
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
 
-    if ((mode == MIRROR_SYNC_MODE_INCREMENTAL) ||
-        (mode == MIRROR_SYNC_MODE_BITMAP)) {
-        error_setg(errp, "Sync mode '%s' not supported",
-                   MirrorSyncMode_str(mode));
-        return;
-    }
-
     bdrv_graph_rdlock_main_loop();
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     bdrv_graph_rdunlock_main_loop();
 
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     &mirror_job_driver, mode, bitmap, bitmap_mode, base,
+                     false, filter_node_name, true, copy_mode, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -2054,7 +2109,8 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, MIRROR_SYNC_MODE_FULL,
+                     NULL, 0, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      errp);
     if (!job) {
diff --git a/blockdev.c b/blockdev.c
index f8bb0932f8..c65d9ded70 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2776,6 +2776,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockDriverState *target,
                                    const char *replaces,
                                    enum MirrorSyncMode sync,
+                                   const char *bitmap_name,
+                                   bool has_bitmap_mode,
+                                   BitmapSyncMode bitmap_mode,
                                    BlockMirrorBackingMode backing_mode,
                                    bool zero_target,
                                    bool has_speed, int64_t speed,
@@ -2794,6 +2797,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 {
     BlockDriverState *unfiltered_bs;
     int job_flags = JOB_DEFAULT;
+    BdrvDirtyBitmap *bitmap = NULL;
 
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
@@ -2848,6 +2852,29 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
+    if (bitmap_name) {
+        if (granularity) {
+            error_setg(errp, "Granularity and bitmap cannot both be set");
+            return;
+        }
+
+        if (!has_bitmap_mode) {
+            error_setg(errp, "bitmap-mode must be specified if"
+                       " a bitmap is provided");
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
     if (!replaces) {
         /* We want to mirror from @bs, but keep implicit filters on top */
         unfiltered_bs = bdrv_skip_implicit_filters(bs);
@@ -2889,8 +2916,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target,
-                 replaces, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode, zero_target,
+                 replaces, job_flags, speed, granularity, buf_size, sync,
+                 bitmap, bitmap_mode, backing_mode, zero_target,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
 }
@@ -3034,6 +3061,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     blockdev_mirror_common(arg->job_id, bs, target_bs,
                            arg->replaces, arg->sync,
+                           arg->bitmap,
+                           arg->has_bitmap_mode, arg->bitmap_mode,
                            backing_mode, zero_target,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
@@ -3053,6 +3082,8 @@ void qmp_blockdev_mirror(const char *job_id,
                          const char *device, const char *target,
                          const char *replaces,
                          MirrorSyncMode sync,
+                         const char *bitmap,
+                         bool has_bitmap_mode, BitmapSyncMode bitmap_mode,
                          bool has_speed, int64_t speed,
                          bool has_granularity, uint32_t granularity,
                          bool has_buf_size, int64_t buf_size,
@@ -3093,7 +3124,8 @@ void qmp_blockdev_mirror(const char *job_id,
     }
 
     blockdev_mirror_common(job_id, bs, target_bs,
-                           replaces, sync, backing_mode,
+                           replaces, sync,
+                           bitmap, has_bitmap_mode, bitmap_mode, backing_mode,
                            zero_target, has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index d2201e27f4..cc1387ae02 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -158,7 +158,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BitmapSyncMode bitmap_mode,
+                  BlockMirrorBackingMode backing_mode,
                   bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab5a93a966..ac05483958 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2181,6 +2181,15 @@
 #     destination (all the disk, only the sectors allocated in the
 #     topmost image, or only new I/O).
 #
+# @bitmap: The name of a bitmap to use for sync=bitmap mode.  This
+#     argument must be present for bitmap mode and absent otherwise.
+#     The bitmap's granularity is used instead of @granularity.
+#     (Since 9.0).
+#
+# @bitmap-mode: Specifies the type of data the bitmap should contain
+#     after the operation concludes.  Must be present if sync is
+#     "bitmap".  Must NOT be present otherwise.  (Since 9.0)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K if the
 #     image format doesn't have clusters, 4K if the clusters are
 #     smaller than that, else the cluster size.  Must be a power of 2
@@ -2223,7 +2232,9 @@
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
+            'sync': 'MirrorSyncMode', '*bitmap': 'str',
+            '*bitmap-mode': 'BitmapSyncMode',
+            '*mode': 'NewImageMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
@@ -2507,6 +2518,15 @@
 #     destination (all the disk, only the sectors allocated in the
 #     topmost image, or only new I/O).
 #
+# @bitmap: The name of a bitmap to use for sync=bitmap mode.  This
+#     argument must be present for bitmap mode and absent otherwise.
+#     The bitmap's granularity is used instead of @granularity.
+#     (Since 9.0).
+#
+# @bitmap-mode: Specifies the type of data the bitmap should contain
+#     after the operation concludes.  Must be present if sync is
+#     "bitmap".  Must NOT be present otherwise.  (Since 9.0)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K if the
 #     image format doesn't have clusters, 4K if the clusters are
 #     smaller than that, else the cluster size.  Must be a power of 2
@@ -2557,7 +2577,8 @@
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
-            'sync': 'MirrorSyncMode',
+            'sync': 'MirrorSyncMode', '*bitmap': 'str',
+            '*bitmap-mode': 'BitmapSyncMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 3766d5de6b..afa44cbd34 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -755,8 +755,8 @@ static void test_propagate_mirror(void)
 
     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
-                 BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
+                 MIRROR_SYNC_MODE_NONE, NULL, 0, MIRROR_OPEN_BACKING_CHAIN,
+                 false, BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
 
-- 
2.39.2



