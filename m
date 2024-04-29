Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965B6C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYc-0008IH-Kw; Mon, 29 Apr 2024 07:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYZ-0008GM-Nm; Mon, 29 Apr 2024 07:52:27 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYQ-0001ol-GK; Mon, 29 Apr 2024 07:52:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 82BC260C36;
 Mon, 29 Apr 2024 14:52:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-VcFi89zK; Mon, 29 Apr 2024 14:52:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391534;
 bh=AdQfubhmAF0PPkZqpSttOuQyyd9tUV5FqMJvZMix/K0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mk46DQS0r2Tjj0VZ8lWQ9B+R+/9RioO3T+c3J2tNu0A615ZXxXT8BJGncsG1un6aU
 yAcQI5Lps4GfkXtMDcMFgrelIAiwxxpGVJd6ue592peaU9xE5fkcIRZpE/GfoZDOWr
 3krL54VeSOsSwWjjFvCvUpxCGpI/J8NeoI93bllQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 5/6] qapi: blockdev-backup: add discard-source parameter
Date: Mon, 29 Apr 2024 14:51:56 +0300
Message-Id: <20240429115157.2260885-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a parameter that enables discard-after-copy. That is mostly useful
in "push backup with fleecing" scheme, when source is snapshot-access
format driver node, based on copy-before-write filter snapshot-access
API:

[guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
   |            |
   | root       | file
   v            v
[copy-before-write]
   |             |
   | file        | target
   v             v
[active disk]   [temp.img]

In this case discard-after-copy does two things:

 - discard data in temp.img to save disk space
 - avoid further copy-before-write operation in discarded area

Note that we have to declare WRITE permission on source in
copy-before-write filter, for discard to work. Still we can't take it
unconditionally, as it will break normal backup from RO source. So, we
have to add a parameter and pass it thorough bdrv_open flags.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20240313152822.626493-5-vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c                         |  5 +++--
 block/block-copy.c                     |  9 +++++++++
 block/copy-before-write.c              | 15 +++++++++++++--
 block/copy-before-write.h              |  1 +
 block/replication.c                    |  4 ++--
 blockdev.c                             |  2 +-
 include/block/block-common.h           |  2 ++
 include/block/block-copy.h             |  1 +
 include/block/block_int-global-state.h |  2 +-
 qapi/block-core.json                   |  4 ++++
 10 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ec29d6b810..3dd2e229d2 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -356,7 +356,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   BitmapSyncMode bitmap_mode,
-                  bool compress,
+                  bool compress, bool discard_source,
                   const char *filter_node_name,
                   BackupPerf *perf,
                   BlockdevOnError on_source_error,
@@ -457,7 +457,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    cbw = bdrv_cbw_append(bs, target, filter_node_name, &bcs, errp);
+    cbw = bdrv_cbw_append(bs, target, filter_node_name, discard_source,
+                          &bcs, errp);
     if (!cbw) {
         goto error;
     }
diff --git a/block/block-copy.c b/block/block-copy.c
index 8fca2c3698..7e3b378528 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -137,6 +137,7 @@ typedef struct BlockCopyState {
     CoMutex lock;
     int64_t in_flight_bytes;
     BlockCopyMethod method;
+    bool discard_source;
     BlockReqList reqs;
     QLIST_HEAD(, BlockCopyCallState) calls;
     /*
@@ -353,6 +354,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
+                                     bool discard_source,
                                      Error **errp)
 {
     ERRP_GUARD();
@@ -418,6 +420,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                     cluster_size),
     };
 
+    s->discard_source = discard_source;
     block_copy_set_copy_opts(s, false, false);
 
     ratelimit_init(&s->rate_limit);
@@ -589,6 +592,12 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     co_put_to_shres(s->mem, t->req.bytes);
     block_copy_task_end(t, ret);
 
+    if (s->discard_source && ret == 0) {
+        int64_t nbytes =
+            MIN(t->req.offset + t->req.bytes, s->len) - t->req.offset;
+        bdrv_co_pdiscard(s->source, t->req.offset, nbytes);
+    }
+
     return ret;
 }
 
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index ed2c228da7..cd65524e26 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -44,6 +44,7 @@ typedef struct BDRVCopyBeforeWriteState {
     BdrvChild *target;
     OnCbwError on_cbw_error;
     uint32_t cbw_timeout_ns;
+    bool discard_source;
 
     /*
      * @lock: protects access to @access_bitmap, @done_bitmap and
@@ -357,6 +358,8 @@ cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
                uint64_t perm, uint64_t shared,
                uint64_t *nperm, uint64_t *nshared)
 {
+    BDRVCopyBeforeWriteState *s = bs->opaque;
+
     if (!(role & BDRV_CHILD_FILTERED)) {
         /*
          * Target child
@@ -381,6 +384,10 @@ cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
              * start
              */
             *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
+            if (s->discard_source) {
+                *nperm = *nperm | BLK_PERM_WRITE;
+            }
+
             *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
         }
     }
@@ -468,7 +475,9 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
             ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
              bs->file->bs->supported_zero_flags);
 
-    s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap, errp);
+    s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
+    s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
+                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
         return -EINVAL;
@@ -535,12 +544,14 @@ static BlockDriver bdrv_cbw_filter = {
 BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
+                                  bool discard_source,
                                   BlockCopyState **bcs,
                                   Error **errp)
 {
     BDRVCopyBeforeWriteState *state;
     BlockDriverState *top;
     QDict *opts;
+    int flags = BDRV_O_RDWR | (discard_source ? BDRV_O_CBW_DISCARD_SOURCE : 0);
 
     assert(source->total_sectors == target->total_sectors);
     GLOBAL_STATE_CODE();
@@ -553,7 +564,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
     qdict_put_str(opts, "file", bdrv_get_node_name(source));
     qdict_put_str(opts, "target", bdrv_get_node_name(target));
 
-    top = bdrv_insert_node(source, opts, BDRV_O_RDWR, errp);
+    top = bdrv_insert_node(source, opts, flags, errp);
     if (!top) {
         return NULL;
     }
diff --git a/block/copy-before-write.h b/block/copy-before-write.h
index 6e72bb25e9..01af0cd3c4 100644
--- a/block/copy-before-write.h
+++ b/block/copy-before-write.h
@@ -39,6 +39,7 @@
 BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
+                                  bool discard_source,
                                   BlockCopyState **bcs,
                                   Error **errp);
 void bdrv_cbw_drop(BlockDriverState *bs);
diff --git a/block/replication.c b/block/replication.c
index ca6bd0a720..0415a5e8b7 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -582,8 +582,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
-                                &perf,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, false,
+                                NULL, &perf,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index 08eccc9052..875a6a4ac1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2726,7 +2726,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->bitmap_mode,
-                            backup->compress,
+                            backup->compress, backup->discard_source,
                             backup->filter_node_name,
                             &perf,
                             backup->on_source_error,
diff --git a/include/block/block-common.h b/include/block/block-common.h
index a846023a09..338fe5ff7a 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -243,6 +243,8 @@ typedef enum {
                                       read-write fails */
 #define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
+#define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
+
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
 
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 8b41643bfa..bdc703bacd 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -27,6 +27,7 @@ typedef struct BlockCopyCallState BlockCopyCallState;
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
+                                     bool discard_source,
                                      Error **errp);
 
 /* Function should be called prior any actual copy request */
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index d2201e27f4..eb2d92a226 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -193,7 +193,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             BitmapSyncMode bitmap_mode,
-                            bool compress,
+                            bool compress, bool discard_source,
                             const char *filter_node_name,
                             BackupPerf *perf,
                             BlockdevOnError on_source_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 746d1694c2..df5e07debd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1610,6 +1610,9 @@
 #     node specified by @drive.  If this option is not given, a node
 #     name is autogenerated.  (Since: 4.2)
 #
+# @discard-source: Discard blocks on source which have already been
+#     copied to the target.  (Since 9.1)
+#
 # @x-perf: Performance options.  (Since 6.0)
 #
 # Features:
@@ -1631,6 +1634,7 @@
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
             '*filter-node-name': 'str',
+            '*discard-source': 'bool',
             '*x-perf': { 'type': 'BackupPerf',
                          'features': [ 'unstable' ] } } }
 
-- 
2.34.1


