Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F4DC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRscF-0001gv-7k; Thu, 11 Jul 2024 08:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRsc9-0001Ol-7O; Thu, 11 Jul 2024 08:09:33 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sRsbz-0002s0-91; Thu, 11 Jul 2024 08:09:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0DCD747347;
 Thu, 11 Jul 2024 14:09:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: [PATCH v3 1/2] copy-before-write: allow specifying minimum cluster
 size
Date: Thu, 11 Jul 2024 14:09:14 +0200
Message-Id: <20240711120915.310243-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240711120915.310243-1-f.ebner@proxmox.com>
References: <20240711120915.310243-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

In the context of backup fleecing, discarding the source will not work
when the fleecing image has a larger granularity than the one used for
block-copy operations (can happen if the backup target has smaller
cluster size), because cbw_co_pdiscard_snapshot() will align down the
discard requests and thus effectively ignore then.

To make @discard-source work in such a scenario, allow specifying the
minimum cluster size used for block-copy operations and thus in
particular also the granularity for discard requests to the source.

The type 'size' (corresponding to uint64_t in C) is used in QAPI to
rule out negative inputs and for consistency with already existing
@cluster-size parameters. Since block_copy_calculate_cluster_size()
uses int64_t for its result, a check that the input is not too large
is added in block_copy_state_new() before calling it. The calculation
in block_copy_calculate_cluster_size() is done in the target int64_t
type.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
* Pass min_cluster_size option directly without checking
  has_min_cluster_size, because the default is 0 anyways.
* Calculate maximum of passed-in argument and default once at the
  beginning of block_copy_calculate_cluster_size()
* Update warning message to reflect actual value used
* Use PRI{i,u}64 macros

 block/block-copy.c         | 36 ++++++++++++++++++++++++++----------
 block/copy-before-write.c  |  5 ++++-
 include/block/block-copy.h |  1 +
 qapi/block-core.json       |  8 +++++++-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7e3b378528..59bee538eb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
 }
 
 static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
+                                                 int64_t min_cluster_size,
                                                  Error **errp)
 {
     int ret;
@@ -319,6 +320,9 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    min_cluster_size = MAX(min_cluster_size,
+                           (int64_t)BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
+
     target_does_cow = bdrv_backing_chain_next(target);
 
     /*
@@ -329,13 +333,13 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
     ret = bdrv_get_info(target, &bdi);
     if (ret == -ENOTSUP && !target_does_cow) {
         /* Cluster size is not defined */
-        warn_report("The target block device doesn't provide "
-                    "information about the block size and it doesn't have a "
-                    "backing file. The default block size of %u bytes is "
-                    "used. If the actual block size of the target exceeds "
-                    "this default, the backup may be unusable",
-                    BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        warn_report("The target block device doesn't provide information about "
+                    "the block size and it doesn't have a backing file. The "
+                    "(default) block size of %" PRIi64 " bytes is used. If the "
+                    "actual block size of the target exceeds this value, the "
+                    "backup may be unusable",
+                    min_cluster_size);
+        return min_cluster_size;
     } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
@@ -345,16 +349,17 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
         return ret;
     } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        return min_cluster_size;
     }
 
-    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+    return MAX(min_cluster_size, bdi.cluster_size);
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     uint64_t min_cluster_size,
                                      Error **errp)
 {
     ERRP_GUARD();
@@ -365,7 +370,18 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
 
     GLOBAL_STATE_CODE();
 
-    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
+    if (min_cluster_size > INT64_MAX) {
+        error_setg(errp, "min-cluster-size too large: %" PRIu64 " > %" PRIi64,
+                   min_cluster_size, INT64_MAX);
+        return NULL;
+    } else if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
+        error_setg(errp, "min-cluster-size needs to be a power of 2");
+        return NULL;
+    }
+
+    cluster_size = block_copy_calculate_cluster_size(target->bs,
+                                                     (int64_t)min_cluster_size,
+                                                     errp);
     if (cluster_size < 0) {
         return NULL;
     }
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 853e01a1eb..a919b1f41b 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -417,6 +417,7 @@ static BlockdevOptions *cbw_parse_options(QDict *options, Error **errp)
     qdict_extract_subqdict(options, NULL, "bitmap");
     qdict_del(options, "on-cbw-error");
     qdict_del(options, "cbw-timeout");
+    qdict_del(options, "min-cluster-size");
 
 out:
     visit_free(v);
@@ -476,8 +477,10 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
              bs->file->bs->supported_zero_flags);
 
     s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
+
     s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
-                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
+                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
+                                  opts->min_cluster_size, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
         return -EINVAL;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index bdc703bacd..dd5cc82f3b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     uint64_t min_cluster_size,
                                      Error **errp);
 
 /* Function should be called prior any actual copy request */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 096bdbe0aa..80e32db8aa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4638,12 +4638,18 @@
 #     @on-cbw-error parameter will decide how this failure is handled.
 #     Default 0.  (Since 7.1)
 #
+# @min-cluster-size: Minimum size of blocks used by copy-before-write
+#     operations.  Has to be a power of 2.  No effect if smaller than
+#     the maximum of the target's cluster size and 64 KiB.  Default 0.
+#     (Since 9.1)
+#
 # Since: 6.2
 ##
 { 'struct': 'BlockdevOptionsCbw',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
-            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
+            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
+            '*min-cluster-size': 'size' } }
 
 ##
 # @BlockdevOptions:
-- 
2.39.2



