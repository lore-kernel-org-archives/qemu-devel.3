Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36D9C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riE9R-0001FN-Pk; Thu, 07 Mar 2024 08:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE64-000601-0b; Thu, 07 Mar 2024 08:47:44 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE5z-00088f-Ll; Thu, 07 Mar 2024 08:47:43 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6F4744888A;
 Thu,  7 Mar 2024 14:47:17 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v2 1/4] qapi/block-core: avoid the re-use of MirrorSyncMode
 for backup
Date: Thu,  7 Mar 2024 14:47:08 +0100
Message-Id: <20240307134711.709816-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307134711.709816-1-f.ebner@proxmox.com>
References: <20240307134711.709816-1-f.ebner@proxmox.com>
MIME-Version: 1.0
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

Backup supports all modes listed in MirrorSyncMode, while mirror does
not. Introduce BackupSyncMode by copying the current MirrorSyncMode
and drop the variants mirror does not support from MirrorSyncMode as
well as the corresponding manual check in mirror_start().

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

I felt like keeping the "Since: X.Y" as before makes the most sense as
to not lose history. Or is it necessary to change this for
BackupSyncMode (and its members) since it got a new name?

 block/backup.c                         | 18 ++++++++---------
 block/mirror.c                         |  7 -------
 block/monitor/block-hmp-cmds.c         |  2 +-
 block/replication.c                    |  2 +-
 blockdev.c                             | 26 ++++++++++++-------------
 include/block/block_int-global-state.h |  2 +-
 qapi/block-core.json                   | 27 +++++++++++++++++++++-----
 7 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ec29d6b810..1cc4e055c6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -37,7 +37,7 @@ typedef struct BackupBlockJob {
 
     BdrvDirtyBitmap *sync_bitmap;
 
-    MirrorSyncMode sync_mode;
+    BackupSyncMode sync_mode;
     BitmapSyncMode bitmap_mode;
     BlockdevOnError on_source_error;
     BlockdevOnError on_target_error;
@@ -111,7 +111,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
 
     assert(block_job_driver(job) == &backup_job_driver);
 
-    if (backup_job->sync_mode != MIRROR_SYNC_MODE_NONE) {
+    if (backup_job->sync_mode != BACKUP_SYNC_MODE_NONE) {
         error_setg(errp, "The backup job only supports block checkpoint in"
                    " sync=none mode");
         return;
@@ -231,11 +231,11 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
     uint64_t estimate;
     BdrvDirtyBitmap *bcs_bitmap = block_copy_dirty_bitmap(job->bcs);
 
-    if (job->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
+    if (job->sync_mode == BACKUP_SYNC_MODE_BITMAP) {
         bdrv_clear_dirty_bitmap(bcs_bitmap, NULL);
         bdrv_dirty_bitmap_merge_internal(bcs_bitmap, job->sync_bitmap, NULL,
                                          true);
-    } else if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
+    } else if (job->sync_mode == BACKUP_SYNC_MODE_TOP) {
         /*
          * We can't hog the coroutine to initialize this thoroughly.
          * Set a flag and resume work when we are able to yield safely.
@@ -254,7 +254,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
     backup_init_bcs_bitmap(s);
 
-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
+    if (s->sync_mode == BACKUP_SYNC_MODE_TOP) {
         int64_t offset = 0;
         int64_t count;
 
@@ -282,7 +282,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
         block_copy_set_skip_unallocated(s->bcs, false);
     }
 
-    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    if (s->sync_mode == BACKUP_SYNC_MODE_NONE) {
         /*
          * All bits are set in bcs bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied.
@@ -354,7 +354,7 @@ static const BlockJobDriver backup_job_driver = {
 
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
-                  MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
+                  BackupSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   BitmapSyncMode bitmap_mode,
                   bool compress,
                   const char *filter_node_name,
@@ -376,8 +376,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     /* QMP interface protects us from these cases */
-    assert(sync_mode != MIRROR_SYNC_MODE_INCREMENTAL);
-    assert(sync_bitmap || sync_mode != MIRROR_SYNC_MODE_BITMAP);
+    assert(sync_mode != BACKUP_SYNC_MODE_INCREMENTAL);
+    assert(sync_bitmap || sync_mode != BACKUP_SYNC_MODE_BITMAP);
 
     if (bs == target) {
         error_setg(errp, "Source and target cannot be the same");
diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..1609354db3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -2011,13 +2011,6 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
 
     GLOBAL_STATE_CODE();
 
-    if ((mode == MIRROR_SYNC_MODE_INCREMENTAL) ||
-        (mode == MIRROR_SYNC_MODE_BITMAP)) {
-        error_setg(errp, "Sync mode '%s' not supported",
-                   MirrorSyncMode_str(mode));
-        return;
-    }
-
     bdrv_graph_rdlock_main_loop();
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index d954bec6f1..9633d000c0 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -266,7 +266,7 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict)
         .device = (char *)device,
         .target = (char *)filename,
         .format = (char *)format,
-        .sync = full ? MIRROR_SYNC_MODE_FULL : MIRROR_SYNC_MODE_TOP,
+        .sync = full ? BACKUP_SYNC_MODE_FULL : BACKUP_SYNC_MODE_TOP,
         .has_mode = true,
         .mode = reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PATHS,
         .has_compress = !!compress,
diff --git a/block/replication.c b/block/replication.c
index ca6bd0a720..1355e686f4 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -582,7 +582,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
+                                0, BACKUP_SYNC_MODE_NONE, NULL, 0, false, NULL,
                                 &perf,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
diff --git a/blockdev.c b/blockdev.c
index f8bb0932f8..8dadbb353b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1642,7 +1642,7 @@ static void drive_backup_action(DriveBackup *backup,
      * See if we have a backing HD we can use to create our new image
      * on top of.
      */
-    if (backup->sync == MIRROR_SYNC_MODE_TOP) {
+    if (backup->sync == BACKUP_SYNC_MODE_TOP) {
         /*
          * Backup will not replace the source by the target, so none
          * of the filters skipped here will be removed (in contrast to
@@ -1651,10 +1651,10 @@ static void drive_backup_action(DriveBackup *backup,
          */
         source = bdrv_cow_bs(bdrv_skip_filters(bs));
         if (!source) {
-            backup->sync = MIRROR_SYNC_MODE_FULL;
+            backup->sync = BACKUP_SYNC_MODE_FULL;
         }
     }
-    if (backup->sync == MIRROR_SYNC_MODE_NONE) {
+    if (backup->sync == BACKUP_SYNC_MODE_NONE) {
         source = bs;
         flags |= BDRV_O_NO_BACKING;
         set_backing_hd = true;
@@ -2655,27 +2655,27 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         }
     }
 
-    if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
-        (backup->sync == MIRROR_SYNC_MODE_INCREMENTAL)) {
+    if ((backup->sync == BACKUP_SYNC_MODE_BITMAP) ||
+        (backup->sync == BACKUP_SYNC_MODE_INCREMENTAL)) {
         /* done before desugaring 'incremental' to print the right message */
         if (!backup->bitmap) {
             error_setg(errp, "must provide a valid bitmap name for "
-                       "'%s' sync mode", MirrorSyncMode_str(backup->sync));
+                       "'%s' sync mode", BackupSyncMode_str(backup->sync));
             return NULL;
         }
     }
 
-    if (backup->sync == MIRROR_SYNC_MODE_INCREMENTAL) {
+    if (backup->sync == BACKUP_SYNC_MODE_INCREMENTAL) {
         if (backup->has_bitmap_mode &&
             backup->bitmap_mode != BITMAP_SYNC_MODE_ON_SUCCESS) {
             error_setg(errp, "Bitmap sync mode must be '%s' "
                        "when using sync mode '%s'",
                        BitmapSyncMode_str(BITMAP_SYNC_MODE_ON_SUCCESS),
-                       MirrorSyncMode_str(backup->sync));
+                       BackupSyncMode_str(backup->sync));
             return NULL;
         }
         backup->has_bitmap_mode = true;
-        backup->sync = MIRROR_SYNC_MODE_BITMAP;
+        backup->sync = BACKUP_SYNC_MODE_BITMAP;
         backup->bitmap_mode = BITMAP_SYNC_MODE_ON_SUCCESS;
     }
 
@@ -2695,19 +2695,19 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         }
 
         /* This does not produce a useful bitmap artifact: */
-        if (backup->sync == MIRROR_SYNC_MODE_NONE) {
+        if (backup->sync == BACKUP_SYNC_MODE_NONE) {
             error_setg(errp, "sync mode '%s' does not produce meaningful bitmap"
-                       " outputs", MirrorSyncMode_str(backup->sync));
+                       " outputs", BackupSyncMode_str(backup->sync));
             return NULL;
         }
 
         /* If the bitmap isn't used for input or output, this is useless: */
         if (backup->bitmap_mode == BITMAP_SYNC_MODE_NEVER &&
-            backup->sync != MIRROR_SYNC_MODE_BITMAP) {
+            backup->sync != BACKUP_SYNC_MODE_BITMAP) {
             error_setg(errp, "Bitmap sync mode '%s' has no meaningful effect"
                        " when combined with sync mode '%s'",
                        BitmapSyncMode_str(backup->bitmap_mode),
-                       MirrorSyncMode_str(backup->sync));
+                       BackupSyncMode_str(backup->sync));
             return NULL;
         }
     }
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index d2201e27f4..54f8c8cbcb 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -190,7 +190,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  */
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BlockDriverState *target, int64_t speed,
-                            MirrorSyncMode sync_mode,
+                            BackupSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             BitmapSyncMode bitmap_mode,
                             bool compress,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1874f880a8..59d75b0793 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1304,10 +1304,10 @@
   'data': ['report', 'ignore', 'enospc', 'stop', 'auto'] }
 
 ##
-# @MirrorSyncMode:
+# @BackupSyncMode:
 #
-# An enumeration of possible behaviors for the initial synchronization
-# phase of storage mirroring.
+# An enumeration of possible behaviors for image synchronization used
+# by backup jobs.
 #
 # @top: copies data in the topmost image to the destination
 #
@@ -1323,7 +1323,7 @@
 #
 # Since: 1.3
 ##
-{ 'enum': 'MirrorSyncMode',
+{ 'enum': 'BackupSyncMode',
   'data': ['top', 'full', 'none', 'incremental', 'bitmap'] }
 
 ##
@@ -1347,6 +1347,23 @@
 { 'enum': 'BitmapSyncMode',
   'data': ['on-success', 'never', 'always'] }
 
+##
+# @MirrorSyncMode:
+#
+# An enumeration of possible behaviors for the initial synchronization
+# phase of storage mirroring.
+#
+# @top: copies data in the topmost image to the destination
+#
+# @full: copies data from all images to the destination
+#
+# @none: only copy data written from now on
+#
+# Since: 1.3
+##
+{ 'enum': 'MirrorSyncMode',
+  'data': ['top', 'full', 'none'] }
+
 ##
 # @MirrorCopyMode:
 #
@@ -1624,7 +1641,7 @@
 ##
 { 'struct': 'BackupCommon',
   'data': { '*job-id': 'str', 'device': 'str',
-            'sync': 'MirrorSyncMode', '*speed': 'int',
+            'sync': 'BackupSyncMode', '*speed': 'int',
             '*bitmap': 'str', '*bitmap-mode': 'BitmapSyncMode',
             '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
-- 
2.39.2



