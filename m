Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17994C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricWI-0006bm-D8; Fri, 08 Mar 2024 10:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricVy-000632-Km; Fri, 08 Mar 2024 10:52:06 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricVw-0004oU-OJ; Fri, 08 Mar 2024 10:52:06 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3EF89488DE;
 Fri,  8 Mar 2024 16:52:03 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: [PATCH 1/2] copy-before-write: allow specifying minimum cluster size
Date: Fri,  8 Mar 2024 16:51:57 +0100
Message-Id: <20240308155158.830258-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308155158.830258-1-f.ebner@proxmox.com>
References: <20240308155158.830258-1-f.ebner@proxmox.com>
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

Useful to make discard-source work in the context of backup fleecing
when the fleecing image has a larger granularity than the backup
target.

Copy-before-write operations will use at least this granularity and in
particular, discard requests to the source node will too. If the
granularity is too small, they will just be aligned down in
cbw_co_pdiscard_snapshot() and thus effectively ignored.

The QAPI uses uint32 so the value will be non-negative, but still fit
into a uint64_t.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/block-copy.c         | 17 +++++++++++++----
 block/copy-before-write.c  |  3 ++-
 include/block/block-copy.h |  1 +
 qapi/block-core.json       |  8 +++++++-
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 7e3b378528..adb1cbb440 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -310,6 +310,7 @@ void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
 }
 
 static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
+                                                 int64_t min_cluster_size,
                                                  Error **errp)
 {
     int ret;
@@ -335,7 +336,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
                     "used. If the actual block size of the target exceeds "
                     "this default, the backup may be unusable",
                     BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
     } else if (ret < 0 && !target_does_cow) {
         error_setg_errno(errp, -ret,
             "Couldn't determine the cluster size of the target image, "
@@ -345,16 +346,18 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
         return ret;
     } else if (ret < 0 && target_does_cow) {
         /* Not fatal; just trudge on ahead. */
-        return BLOCK_COPY_CLUSTER_SIZE_DEFAULT;
+        return MAX(min_cluster_size, BLOCK_COPY_CLUSTER_SIZE_DEFAULT);
     }
 
-    return MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
+    return MAX(min_cluster_size,
+               MAX(BLOCK_COPY_CLUSTER_SIZE_DEFAULT, bdi.cluster_size));
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     int64_t min_cluster_size,
                                      Error **errp)
 {
     ERRP_GUARD();
@@ -365,7 +368,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
 
     GLOBAL_STATE_CODE();
 
-    cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
+    if (min_cluster_size && !is_power_of_2(min_cluster_size)) {
+        error_setg(errp, "min-cluster-size needs to be a power of 2");
+        return NULL;
+    }
+
+    cluster_size = block_copy_calculate_cluster_size(target->bs,
+                                                     min_cluster_size, errp);
     if (cluster_size < 0) {
         return NULL;
     }
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index dac57481c5..f9896c6c1e 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -476,7 +476,8 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->discard_source = flags & BDRV_O_CBW_DISCARD_SOURCE;
     s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap,
-                                  flags & BDRV_O_CBW_DISCARD_SOURCE, errp);
+                                  flags & BDRV_O_CBW_DISCARD_SOURCE,
+                                  opts->min_cluster_size, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
         return -EINVAL;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index bdc703bacd..77857c6c68 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -28,6 +28,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      bool discard_source,
+                                     int64_t min_cluster_size,
                                      Error **errp);
 
 /* Function should be called prior any actual copy request */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0a72c590a8..85c8f88f6e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4625,12 +4625,18 @@
 #     @on-cbw-error parameter will decide how this failure is handled.
 #     Default 0. (Since 7.1)
 #
+# @min-cluster-size: Minimum size of blocks used by copy-before-write
+#     operations.  Has to be a power of 2.  No effect if smaller than
+#     the maximum of the target's cluster size and 64 KiB.  Default 0.
+#     (Since 9.0)
+#
 # Since: 6.2
 ##
 { 'struct': 'BlockdevOptionsCbw',
   'base': 'BlockdevOptionsGenericFormat',
   'data': { 'target': 'BlockdevRef', '*bitmap': 'BlockDirtyBitmap',
-            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32' } }
+            '*on-cbw-error': 'OnCbwError', '*cbw-timeout': 'uint32',
+            '*min-cluster-size': 'uint32' } }
 
 ##
 # @BlockdevOptions:
-- 
2.39.2



