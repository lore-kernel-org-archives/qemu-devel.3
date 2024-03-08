Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E68C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricWJ-0006rD-Sy; Fri, 08 Mar 2024 10:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricVz-00066j-Mx; Fri, 08 Mar 2024 10:52:08 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricVw-0004oS-PJ; Fri, 08 Mar 2024 10:52:07 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3D0CB488C3;
 Fri,  8 Mar 2024 16:52:03 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com
Subject: [PATCH 2/2] backup: add minimum cluster size to performance options
Date: Fri,  8 Mar 2024 16:51:58 +0100
Message-Id: <20240308155158.830258-3-f.ebner@proxmox.com>
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

Backup/block-copy will use at least this granularity for copy operations
and in particular, discard requests to the backup source will too. If
the granularity is too small, they will just be aligned down in
cbw_co_pdiscard_snapshot() and thus effectively ignored.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/backup.c            | 2 +-
 block/copy-before-write.c | 2 ++
 block/copy-before-write.h | 1 +
 blockdev.c                | 3 +++
 qapi/block-core.json      | 9 +++++++--
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 3dd2e229d2..a1292c01ec 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -458,7 +458,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     cbw = bdrv_cbw_append(bs, target, filter_node_name, discard_source,
-                          &bcs, errp);
+                          perf->min_cluster_size, &bcs, errp);
     if (!cbw) {
         goto error;
     }
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index f9896c6c1e..55a9272485 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -545,6 +545,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
                                   bool discard_source,
+                                  int64_t min_cluster_size,
                                   BlockCopyState **bcs,
                                   Error **errp)
 {
@@ -563,6 +564,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
     }
     qdict_put_str(opts, "file", bdrv_get_node_name(source));
     qdict_put_str(opts, "target", bdrv_get_node_name(target));
+    qdict_put_int(opts, "min-cluster-size", min_cluster_size);
 
     top = bdrv_insert_node(source, opts, flags, errp);
     if (!top) {
diff --git a/block/copy-before-write.h b/block/copy-before-write.h
index 01af0cd3c4..dc6cafe7fa 100644
--- a/block/copy-before-write.h
+++ b/block/copy-before-write.h
@@ -40,6 +40,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
                                   bool discard_source,
+                                  int64_t min_cluster_size,
                                   BlockCopyState **bcs,
                                   Error **errp);
 void bdrv_cbw_drop(BlockDriverState *bs);
diff --git a/blockdev.c b/blockdev.c
index daceb50460..8e6bdbc94a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2653,6 +2653,9 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         if (backup->x_perf->has_max_chunk) {
             perf.max_chunk = backup->x_perf->max_chunk;
         }
+        if (backup->x_perf->has_min_cluster_size) {
+            perf.min_cluster_size = backup->x_perf->min_cluster_size;
+        }
     }
 
     if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85c8f88f6e..ba0836892f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1551,11 +1551,16 @@
 #     it should not be less than job cluster size which is calculated
 #     as maximum of target image cluster size and 64k.  Default 0.
 #
+# @min-cluster-size: Minimum size of blocks used by copy-before-write
+#     and background copy operations.  Has to be a power of 2.  No
+#     effect if smaller than the maximum of the target's cluster size
+#     and 64 KiB.  Default 0.  (Since 9.0)
+#
 # Since: 6.0
 ##
 { 'struct': 'BackupPerf',
-  'data': { '*use-copy-range': 'bool',
-            '*max-workers': 'int', '*max-chunk': 'int64' } }
+  'data': { '*use-copy-range': 'bool', '*max-workers': 'int',
+            '*max-chunk': 'int64', '*min-cluster-size': 'uint32' } }
 
 ##
 # @BackupCommon:
-- 
2.39.2



