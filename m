Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2DEC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmuS-00043T-Kj; Wed, 04 Jun 2025 08:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmuA-0003z3-77; Wed, 04 Jun 2025 08:07:38 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmu1-0002D2-JI; Wed, 04 Jun 2025 08:07:35 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7B5F044B2A;
 Wed,  4 Jun 2025 14:07:25 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH 3/4] block: make calling bdrv_refresh_limits() safe while
 holding graph lock
Date: Wed,  4 Jun 2025 14:07:16 +0200
Message-Id: <20250604120717.458445-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604120717.458445-1-f.ebner@proxmox.com>
References: <20250604120717.458445-1-f.ebner@proxmox.com>
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

The bdrv_refresh_limits() function and driver implementations are
called with the graph lock held. The implementation for the 'compress'
filter calls bdrv_get_info(), which is a generated coroutine wrapper
and thus polls. This can lead to a deadlock when issuing a
blockdev-snapshot QMP command, when bdrv_refresh_limits() is called in
bdrv_append() while the graph lock is held exclusively. This deadlock
was introduced with commit 5661a00d40 ("block: Call transaction
callbacks with lock held").

As a solution, this reverts commit 3d47eb0a2a ("block:
Convert bdrv_get_info() to co_wrapper_mixed"). To do this, it is
necessary to have callers of bdrv_get_info() take the graph lock
themselves. None of the driver implementations rely on being run in
coroutine context and none of the callers rely on the function being
a coroutine.

All callers except one either already hold the graph lock or can claim
the graph lock via bdrv_graph_rdlock_main_loop(). As part of this,
bdrv_get_default_bitmap_granularity() is annotated with GRAPH_RDLOCK
and its callers adapted where necessary.

The single exception is the caller nvme_ns_init_format(), which can
run as a callback in an IO thread, but can also be reached via the QOM
realize handler nvme_ns_realize(). For this caller, a
bdrv_get_info_unlocked() coroutine wrapper is introduced that must be
called with the graph unlocked.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

The test added by the following patch exhibits the issue mentioned
above.

Telling from a quick search, iothread support for nvme devices has not
been merged [0]. So currently, doing the following in
nvme_ns_init_format() might also be an option to avoid the need for
the wrapper:

if (qemu_in_coroutine()) {
    bdrv_graph_co_rdlock();
} else {
    bdrv_graph_rdlock_main_loop()
}

But that doesn't seem future-proof.

[0]: https://lore.kernel.org/qemu-devel/20220827091258.3589230-1-fanjinhao21s@ict.ac.cn/

 block.c                          | 14 ++++++++++----
 block/blkio.c                    |  5 ++---
 block/crypto.c                   |  8 ++++----
 block/file-posix.c               |  7 +++----
 block/io.c                       |  4 ++--
 block/iscsi.c                    |  7 +++----
 block/mirror.c                   |  5 +++--
 block/monitor/bitmap-qmp-cmds.c  |  2 ++
 block/qcow.c                     |  5 ++---
 block/qcow2.c                    |  5 ++---
 block/qed.c                      |  5 ++---
 block/raw-format.c               |  7 +++----
 block/rbd.c                      |  5 ++---
 block/vdi.c                      | 11 ++++++-----
 block/vhdx.c                     |  5 ++---
 block/vmdk.c                     |  5 ++---
 block/vpc.c                      |  5 ++---
 hw/nvme/ns.c                     |  2 +-
 include/block/block-io.h         |  9 +++++----
 include/block/block_int-common.h |  4 ++--
 include/block/dirty-bitmap.h     |  2 +-
 qemu-img.c                       |  6 ++++++
 22 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/block.c b/block.c
index f222e1a50a..c23550ae42 100644
--- a/block.c
+++ b/block.c
@@ -6570,7 +6570,13 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
     pstrcpy(filename, filename_size, bs->backing_file);
 }
 
-int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_get_info_unlocked(BlockDriverState *bs, BlockDriverInfo *bdi)
+{
+    return bdrv_get_info(bs, bdi);
+}
+
+int bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     int ret;
     BlockDriver *drv = bs->drv;
@@ -6581,15 +6587,15 @@ int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     if (!drv) {
         return -ENOMEDIUM;
     }
-    if (!drv->bdrv_co_get_info) {
+    if (!drv->bdrv_get_info) {
         BlockDriverState *filtered = bdrv_filter_bs(bs);
         if (filtered) {
-            return bdrv_co_get_info(filtered, bdi);
+            return bdrv_get_info(filtered, bdi);
         }
         return -ENOTSUP;
     }
     memset(bdi, 0, sizeof(*bdi));
-    ret = drv->bdrv_co_get_info(bs, bdi);
+    ret = drv->bdrv_get_info(bs, bdi);
     if (bdi->subcluster_size == 0) {
         /*
          * If the driver left this unset, subclusters are not supported.
diff --git a/block/blkio.c b/block/blkio.c
index 4142673984..4b04d530e2 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -972,8 +972,7 @@ static int coroutine_fn blkio_truncate(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-static int coroutine_fn
-blkio_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int blkio_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     return 0;
 }
@@ -1094,7 +1093,7 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
     .bdrv_close              = blkio_close, \
     .bdrv_co_getlength       = blkio_co_getlength, \
     .bdrv_co_truncate        = blkio_truncate, \
-    .bdrv_co_get_info        = blkio_co_get_info, \
+    .bdrv_get_info           = blkio_get_info, \
     .bdrv_attach_aio_context = blkio_attach_aio_context, \
     .bdrv_detach_aio_context = blkio_detach_aio_context, \
     .bdrv_co_pdiscard        = blkio_co_pdiscard, \
diff --git a/block/crypto.c b/block/crypto.c
index d4226cc68a..3c19848db0 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -862,13 +862,13 @@ fail:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
-block_crypto_co_get_info_luks(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int GRAPH_RDLOCK
+block_crypto_get_info_luks(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BlockDriverInfo subbdi;
     int ret;
 
-    ret = bdrv_co_get_info(bs->file->bs, &subbdi);
+    ret = bdrv_get_info(bs->file->bs, &subbdi);
     if (ret != 0) {
         return ret;
     }
@@ -1080,7 +1080,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_co_pwritev    = block_crypto_co_pwritev,
     .bdrv_co_getlength  = block_crypto_co_getlength,
     .bdrv_measure       = block_crypto_measure,
-    .bdrv_co_get_info   = block_crypto_co_get_info_luks,
+    .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
     .bdrv_amend_options = block_crypto_amend_options_luks,
     .bdrv_co_amend      = block_crypto_co_amend_luks,
diff --git a/block/file-posix.c b/block/file-posix.c
index 9b5f08ccb2..e14d8c9213 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3743,8 +3743,7 @@ static int coroutine_fn raw_co_pwrite_zeroes(
     return raw_do_pwrite_zeroes(bs, offset, bytes, flags, false);
 }
 
-static int coroutine_fn
-raw_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     return 0;
 }
@@ -4003,7 +4002,7 @@ BlockDriver bdrv_file = {
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
-    .bdrv_co_get_info                   = raw_co_get_info,
+    .bdrv_get_info                      = raw_get_info,
     .bdrv_get_specific_info             = raw_get_specific_info,
     .bdrv_co_get_allocated_file_size    = raw_co_get_allocated_file_size,
     .bdrv_get_specific_stats = raw_get_specific_stats,
@@ -4461,7 +4460,7 @@ static BlockDriver bdrv_host_device = {
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
-    .bdrv_co_get_info                   = raw_co_get_info,
+    .bdrv_get_info                      = raw_get_info,
     .bdrv_get_specific_info             = raw_get_specific_info,
     .bdrv_co_get_allocated_file_size    = raw_co_get_allocated_file_size,
     .bdrv_get_specific_stats = hdev_get_specific_stats,
diff --git a/block/io.c b/block/io.c
index 4fd7768f9c..43cd7b7507 100644
--- a/block/io.c
+++ b/block/io.c
@@ -743,7 +743,7 @@ bdrv_round_to_subclusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
 {
     BlockDriverInfo bdi;
     IO_CODE();
-    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.subcluster_size == 0) {
+    if (bdrv_get_info(bs, &bdi) < 0 || bdi.subcluster_size == 0) {
         *align_offset = offset;
         *align_bytes = bytes;
     } else {
@@ -758,7 +758,7 @@ static int coroutine_fn GRAPH_RDLOCK bdrv_get_cluster_size(BlockDriverState *bs)
     BlockDriverInfo bdi;
     int ret;
 
-    ret = bdrv_co_get_info(bs, &bdi);
+    ret = bdrv_get_info(bs, &bdi);
     if (ret < 0 || bdi.cluster_size == 0) {
         return bs->bl.request_alignment;
     } else {
diff --git a/block/iscsi.c b/block/iscsi.c
index 15b96ee880..4b000df117 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2177,8 +2177,7 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-static int coroutine_fn
-iscsi_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
     bdi->cluster_size = iscsilun->cluster_size;
@@ -2438,7 +2437,7 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_co_invalidate_cache = iscsi_co_invalidate_cache,
 
     .bdrv_co_getlength   = iscsi_co_getlength,
-    .bdrv_co_get_info    = iscsi_co_get_info,
+    .bdrv_get_info       = iscsi_get_info,
     .bdrv_co_truncate    = iscsi_co_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
@@ -2477,7 +2476,7 @@ static BlockDriver bdrv_iser = {
     .bdrv_co_invalidate_cache  = iscsi_co_invalidate_cache,
 
     .bdrv_co_getlength   = iscsi_co_getlength,
-    .bdrv_co_get_info    = iscsi_co_get_info,
+    .bdrv_get_info       = iscsi_get_info,
     .bdrv_co_truncate    = iscsi_co_truncate,
     .bdrv_refresh_limits = iscsi_refresh_limits,
 
diff --git a/block/mirror.c b/block/mirror.c
index c2c5099c95..ea32861db1 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1082,7 +1082,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     bdrv_get_backing_filename(target_bs, backing_filename,
                               sizeof(backing_filename));
     bdrv_graph_co_rdlock();
-    if (!bdrv_co_get_info(target_bs, &bdi) && bdi.cluster_size) {
+    if (!bdrv_get_info(target_bs, &bdi) && bdi.cluster_size) {
         s->target_cluster_size = bdi.cluster_size;
     } else {
         s->target_cluster_size = BDRV_SECTOR_SIZE;
@@ -1844,6 +1844,7 @@ static BlockJob *mirror_start_job(
 
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_rdlock_main_loop();
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
@@ -1852,6 +1853,7 @@ static BlockJob *mirror_start_job(
 
     if (buf_size < 0) {
         error_setg(errp, "Invalid parameter 'buf-size'");
+        bdrv_graph_rdunlock_main_loop();
         return NULL;
     }
 
@@ -1859,7 +1861,6 @@ static BlockJob *mirror_start_job(
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
-    bdrv_graph_rdlock_main_loop();
     if (bdrv_skip_filters(bs) == bdrv_skip_filters(target)) {
         error_setg(errp, "Can't mirror node into itself");
         bdrv_graph_rdunlock_main_loop();
diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index a738e7bbf7..27fd5c12f2 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -114,7 +114,9 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
         }
     } else {
         /* Default to cluster size, if available: */
+        bdrv_graph_rdlock_main_loop();
         granularity = bdrv_get_default_bitmap_granularity(bs);
+        bdrv_graph_rdunlock_main_loop();
     }
 
     if (!has_persistent) {
diff --git a/block/qcow.c b/block/qcow.c
index 8a3e7591a9..1e70c943cb 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1134,8 +1134,7 @@ fail:
     return ret;
 }
 
-static int coroutine_fn
-qcow_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int qcow_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcowState *s = bs->opaque;
     bdi->cluster_size = s->cluster_size;
@@ -1204,7 +1203,7 @@ static BlockDriver bdrv_qcow = {
 
     .bdrv_make_empty        = qcow_make_empty,
     .bdrv_co_pwritev_compressed = qcow_co_pwritev_compressed,
-    .bdrv_co_get_info       = qcow_co_get_info,
+    .bdrv_get_info          = qcow_get_info,
 
     .create_opts            = &qcow_create_opts,
     .strong_runtime_opts    = qcow_strong_runtime_opts,
diff --git a/block/qcow2.c b/block/qcow2.c
index 66fba89b41..9af9eea15d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5236,8 +5236,7 @@ err:
     return NULL;
 }
 
-static int coroutine_fn
-qcow2_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
     bdi->cluster_size = s->cluster_size;
@@ -6174,7 +6173,7 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_snapshot_list                 = qcow2_snapshot_list,
     .bdrv_snapshot_load_tmp             = qcow2_snapshot_load_tmp,
     .bdrv_measure                       = qcow2_measure,
-    .bdrv_co_get_info                   = qcow2_co_get_info,
+    .bdrv_get_info                      = qcow2_get_info,
     .bdrv_get_specific_info             = qcow2_get_specific_info,
 
     .bdrv_co_save_vmstate               = qcow2_co_save_vmstate,
diff --git a/block/qed.c b/block/qed.c
index 4a36fb3929..11bb508f39 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1494,8 +1494,7 @@ static int64_t coroutine_fn bdrv_qed_co_getlength(BlockDriverState *bs)
     return s->header.image_size;
 }
 
-static int coroutine_fn
-bdrv_qed_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int bdrv_qed_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -1664,7 +1663,7 @@ static BlockDriver bdrv_qed = {
     .bdrv_co_pwrite_zeroes          = bdrv_qed_co_pwrite_zeroes,
     .bdrv_co_truncate               = bdrv_qed_co_truncate,
     .bdrv_co_getlength              = bdrv_qed_co_getlength,
-    .bdrv_co_get_info               = bdrv_qed_co_get_info,
+    .bdrv_get_info                  = bdrv_qed_get_info,
     .bdrv_refresh_limits            = bdrv_qed_refresh_limits,
     .bdrv_co_change_backing_file    = bdrv_qed_co_change_backing_file,
     .bdrv_co_invalidate_cache       = bdrv_qed_co_invalidate_cache,
diff --git a/block/raw-format.c b/block/raw-format.c
index df16ac1ea2..473c1a6df4 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -393,10 +393,9 @@ static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
     return info;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
-raw_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int GRAPH_RDLOCK raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
-    return bdrv_co_get_info(bs->file->bs, bdi);
+    return bdrv_get_info(bs->file->bs, bdi);
 }
 
 static void GRAPH_RDLOCK raw_refresh_limits(BlockDriverState *bs, Error **errp)
@@ -660,7 +659,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_getlength    = &raw_co_getlength,
     .is_format            = true,
     .bdrv_measure         = &raw_measure,
-    .bdrv_co_get_info     = &raw_co_get_info,
+    .bdrv_get_info        = &raw_get_info,
     .bdrv_refresh_limits  = &raw_refresh_limits,
     .bdrv_probe_blocksizes = &raw_probe_blocksizes,
     .bdrv_probe_geometry  = &raw_probe_geometry,
diff --git a/block/rbd.c b/block/rbd.c
index 951cd63f9a..cf9670480e 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1399,8 +1399,7 @@ coroutine_fn qemu_rbd_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
 }
 #endif
 
-static int coroutine_fn
-qemu_rbd_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int qemu_rbd_getinfo(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVRBDState *s = bs->opaque;
     bdi->cluster_size = s->object_size;
@@ -1822,7 +1821,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_co_create         = qemu_rbd_co_create,
     .bdrv_co_create_opts    = qemu_rbd_co_create_opts,
     .bdrv_has_zero_init     = bdrv_has_zero_init_1,
-    .bdrv_co_get_info       = qemu_rbd_co_get_info,
+    .bdrv_get_info          = qemu_rbd_getinfo,
     .bdrv_get_specific_info = qemu_rbd_get_specific_info,
     .create_opts            = &qemu_rbd_create_opts,
     .bdrv_co_getlength      = qemu_rbd_co_getlength,
diff --git a/block/vdi.c b/block/vdi.c
index 3ddc62a569..e68455cc4d 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -329,11 +329,12 @@ static int coroutine_fn vdi_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
-static int coroutine_fn
-vdi_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
-    /* TODO: vdi_co_get_info would be needed for machine snapshots.
-       vm_state_offset is still missing. */
+    /*
+     * TODO: vdi_get_info would be needed for machine snapshots.
+     * vm_state_offset is still missing.
+     */
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
     logout("\n");
     bdi->cluster_size = s->block_size;
@@ -1052,7 +1053,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_co_pwritev    = vdi_co_pwritev,
 #endif
 
-    .bdrv_co_get_info = vdi_co_get_info,
+    .bdrv_get_info = vdi_get_info,
 
     .is_format = true,
     .create_opts = &vdi_create_opts,
diff --git a/block/vhdx.c b/block/vhdx.c
index b2a4b813a0..e4d7527bca 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1167,8 +1167,7 @@ static void vhdx_block_translate(BDRVVHDXState *s, int64_t sector_num,
 }
 
 
-static int coroutine_fn
-vhdx_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int vhdx_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVVHDXState *s = bs->opaque;
 
@@ -2257,7 +2256,7 @@ static BlockDriver bdrv_vhdx = {
     .bdrv_co_writev         = vhdx_co_writev,
     .bdrv_co_create         = vhdx_co_create,
     .bdrv_co_create_opts    = vhdx_co_create_opts,
-    .bdrv_co_get_info       = vhdx_co_get_info,
+    .bdrv_get_info          = vhdx_get_info,
     .bdrv_co_check          = vhdx_co_check,
     .bdrv_has_zero_init     = vhdx_has_zero_init,
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 9c7ab037e1..3c5885ba62 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -3047,8 +3047,7 @@ static bool vmdk_extents_type_eq(const VmdkExtent *a, const VmdkExtent *b)
            (a->flat || a->cluster_sectors == b->cluster_sectors);
 }
 
-static int coroutine_fn
-vmdk_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int vmdk_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     int i;
     BDRVVmdkState *s = bs->opaque;
@@ -3166,7 +3165,7 @@ static BlockDriver bdrv_vmdk = {
     .bdrv_has_zero_init           = vmdk_has_zero_init,
     .bdrv_get_specific_info       = vmdk_get_specific_info,
     .bdrv_refresh_limits          = vmdk_refresh_limits,
-    .bdrv_co_get_info             = vmdk_co_get_info,
+    .bdrv_get_info                = vmdk_get_info,
     .bdrv_gather_child_options    = vmdk_gather_child_options,
 
     .is_format                    = true,
diff --git a/block/vpc.c b/block/vpc.c
index 801ff5793f..6e98a57bda 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -605,8 +605,7 @@ fail:
     return ret;
 }
 
-static int coroutine_fn
-vpc_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
+static int vpc_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVVPCState *s = (BDRVVPCState *)bs->opaque;
 
@@ -1246,7 +1245,7 @@ static BlockDriver bdrv_vpc = {
     .bdrv_co_pwritev            = vpc_co_pwritev,
     .bdrv_co_block_status       = vpc_co_block_status,
 
-    .bdrv_co_get_info       = vpc_co_get_info,
+    .bdrv_get_info          = vpc_get_info,
 
     .is_format              = true,
     .create_opts            = &vpc_create_opts,
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 6df2e8e7c5..ee3eabb1aa 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -50,7 +50,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
 
     npdg = ns->blkconf.discard_granularity / ns->lbasz;
 
-    ret = bdrv_get_info(blk_bs(ns->blkconf.blk), &bdi);
+    ret = bdrv_get_info_unlocked(blk_bs(ns->blkconf.blk), &bdi);
     if (ret >= 0 && bdi.cluster_size > ns->blkconf.discard_granularity) {
         npdg = bdi.cluster_size / ns->lbasz;
     }
diff --git a/include/block/block-io.h b/include/block/block-io.h
index b99cc98d26..eb29a04d29 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -193,11 +193,12 @@ bdrv_get_device_name(const BlockDriverState *bs);
 const char * GRAPH_RDLOCK
 bdrv_get_device_or_node_name(const BlockDriverState *bs);
 
+/* The coroutine is called 'unlocked' because the wrapper is. */
 int coroutine_fn GRAPH_RDLOCK
-bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
-
-int co_wrapper_mixed_bdrv_rdlock
-bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
+bdrv_co_get_info_unlocked(BlockDriverState *bs, BlockDriverInfo *bdi);
+int co_wrapper_bdrv_rdlock
+bdrv_get_info_unlocked(BlockDriverState *bs, BlockDriverInfo *bdi);
+int GRAPH_RDLOCK bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 
 ImageInfoSpecific * GRAPH_RDLOCK
 bdrv_get_specific_info(BlockDriverState *bs, Error **errp);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 2982dd3118..22c03c0c40 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -722,8 +722,8 @@ struct BlockDriver {
         BlockDriverState *bs, int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset);
 
-    int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_get_info)(
-        BlockDriverState *bs, BlockDriverInfo *bdi);
+    int GRAPH_RDLOCK_PTR (*bdrv_get_info)(BlockDriverState *bs,
+                                          BlockDriverInfo *bdi);
 
     ImageInfoSpecific * GRAPH_RDLOCK_PTR (*bdrv_get_specific_info)(
         BlockDriverState *bs, Error **errp);
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index fa956debfb..4f5b45d7d7 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -47,7 +47,7 @@ void bdrv_disable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap(BdrvDirtyBitmap *bitmap);
 void bdrv_enable_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap);
 BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs);
-uint32_t bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
+uint32_t GRAPH_RDLOCK bdrv_get_default_bitmap_granularity(BlockDriverState *bs);
 uint32_t bdrv_dirty_bitmap_granularity(const BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_enabled(BdrvDirtyBitmap *bitmap);
 bool bdrv_dirty_bitmap_has_successor(BdrvDirtyBitmap *bitmap);
diff --git a/qemu-img.c b/qemu-img.c
index 139eeb5039..8c24956f39 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2506,10 +2506,12 @@ static int img_convert(int argc, char **argv)
         src_bs = blk_bs(s.src[bs_i]);
         s.src_alignment[bs_i] = DIV_ROUND_UP(src_bs->bl.request_alignment,
                                              BDRV_SECTOR_SIZE);
+        bdrv_graph_rdlock_main_loop();
         if (!bdrv_get_info(src_bs, &bdi)) {
             s.src_alignment[bs_i] = MAX(s.src_alignment[bs_i],
                                         bdi.cluster_size / BDRV_SECTOR_SIZE);
         }
+        bdrv_graph_rdunlock_main_loop();
         s.total_sectors += s.src_sectors[bs_i];
     }
 
@@ -2768,7 +2770,9 @@ static int img_convert(int argc, char **argv)
         s.target_backing_sectors = -1;
     }
 
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_get_info(out_bs, &bdi);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         if (s.compressed) {
             error_report("could not get block driver info");
@@ -3694,7 +3698,9 @@ static int img_rebase(int argc, char **argv)
      * We need overlay subcluster size (or cluster size in case writes are
      * compressed) to make sure write requests are aligned.
      */
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_get_info(unfiltered_bs, &bdi);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         error_report("could not get block driver info");
         goto out;
-- 
2.39.5



