Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76CC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDn-000750-Lb; Tue, 29 Apr 2025 07:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDi-0006vg-1w; Tue, 29 Apr 2025 07:33:50 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008Ey-Em; Tue, 29 Apr 2025 07:33:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 21831613BD;
 Tue, 29 Apr 2025 14:33:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-LeCo85cr; Tue, 29 Apr 2025 14:33:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926419;
 bh=A0n8HyYvSwxkRyzh1ThtysCFIAcf3fFl7IdICB5q2i0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xjI4iZKNIPAr7m8UGHTTgHDB56NzNbkbdwcGxW5IdLF4jdkS4NCfvhliZ7AJNMyoU
 G2KeoG/o6EPvIIjO+hnbZXktHt/p3wjMCvmry9W0FX749UJqfrcF5/wsgRWQHssist
 DLvM0x8+95hSCJutUaLKKAXLXy3KFQUHzlP96IjI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 2/5] backup: add minimum cluster size to performance options
Date: Tue, 29 Apr 2025 14:33:25 +0300
Message-ID: <20250429113335.423535-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

In the context of backup fleecing, discarding the source will not work
when the fleecing image has a larger granularity than the one used for
block-copy operations (can happen if the backup target has smaller
cluster size), because cbw_co_pdiscard_snapshot() will align down the
discard requests and thus effectively ignore then.

To make @discard-source work in such a scenario, allow specifying the
minimum cluster size used for block-copy operations and thus in
particular also the granularity for discard requests to the source.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240711120915.310243-3-f.ebner@proxmox.com>
[vsementsov: switch version to 9.2 in QAPI doc]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c            | 2 +-
 block/copy-before-write.c | 9 +++++++++
 block/copy-before-write.h | 1 +
 blockdev.c                | 3 +++
 qapi/block-core.json      | 9 +++++++--
 5 files changed, 21 insertions(+), 3 deletions(-)

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
index a919b1f41b..e835987e52 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -548,6 +548,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
                                   bool discard_source,
+                                  uint64_t min_cluster_size,
                                   BlockCopyState **bcs,
                                   Error **errp)
 {
@@ -567,6 +568,14 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
     qdict_put_str(opts, "file", bdrv_get_node_name(source));
     qdict_put_str(opts, "target", bdrv_get_node_name(target));
 
+    if (min_cluster_size > INT64_MAX) {
+        error_setg(errp, "min-cluster-size too large: %" PRIu64 " > %" PRIi64,
+                   min_cluster_size, INT64_MAX);
+        qobject_unref(opts);
+        return NULL;
+    }
+    qdict_put_int(opts, "min-cluster-size", (int64_t)min_cluster_size);
+
     top = bdrv_insert_node(source, opts, flags, errp);
     if (!top) {
         return NULL;
diff --git a/block/copy-before-write.h b/block/copy-before-write.h
index 01af0cd3c4..2a5d4ba693 100644
--- a/block/copy-before-write.h
+++ b/block/copy-before-write.h
@@ -40,6 +40,7 @@ BlockDriverState *bdrv_cbw_append(BlockDriverState *source,
                                   BlockDriverState *target,
                                   const char *filter_node_name,
                                   bool discard_source,
+                                  uint64_t min_cluster_size,
                                   BlockCopyState **bcs,
                                   Error **errp);
 void bdrv_cbw_drop(BlockDriverState *bs);
diff --git a/blockdev.c b/blockdev.c
index 835064ed03..6740663fda 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2655,6 +2655,9 @@ static BlockJob *do_backup_common(BackupCommon *backup,
         if (backup->x_perf->has_max_chunk) {
             perf.max_chunk = backup->x_perf->max_chunk;
         }
+        if (backup->x_perf->has_min_cluster_size) {
+            perf.min_cluster_size = backup->x_perf->min_cluster_size;
+        }
     }
 
     if ((backup->sync == MIRROR_SYNC_MODE_BITMAP) ||
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6751022428..c3b0a2376b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1551,11 +1551,16 @@
 #     it should not be less than job cluster size which is calculated
 #     as maximum of target image cluster size and 64k.  Default 0.
 #
+# @min-cluster-size: Minimum size of blocks used by copy-before-write
+#     and background copy operations.  Has to be a power of 2.  No
+#     effect if smaller than the maximum of the target's cluster size
+#     and 64 KiB.  Default 0.  (Since 9.2)
+#
 # Since: 6.0
 ##
 { 'struct': 'BackupPerf',
-  'data': { '*use-copy-range': 'bool',
-            '*max-workers': 'int', '*max-chunk': 'int64' } }
+  'data': { '*use-copy-range': 'bool', '*max-workers': 'int',
+            '*max-chunk': 'int64', '*min-cluster-size': 'size' } }
 
 ##
 # @BackupCommon:
-- 
2.34.1


