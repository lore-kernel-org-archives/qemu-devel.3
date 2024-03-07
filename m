Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826D9C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riE9J-0000rX-NY; Thu, 07 Mar 2024 08:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE63-0005zm-1o; Thu, 07 Mar 2024 08:47:44 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE5z-00088O-2A; Thu, 07 Mar 2024 08:47:42 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3298C4288D;
 Thu,  7 Mar 2024 14:47:17 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v2 4/4] blockdev: mirror: check for target's cluster size when
 using bitmap
Date: Thu,  7 Mar 2024 14:47:11 +0100
Message-Id: <20240307134711.709816-5-f.ebner@proxmox.com>
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

When using mirror with a bitmap and the target is a diff image, i.e.
one that should only contain the delta and was not synced to
previously, a too large cluster size for the target can be
problematic. In particular, when the mirror sends data to the target
aligned to the jobs granularity, but not aligned to the larger target
image's cluster size, the target's cluster would be allocated but only
be filled partially. When rebasing such a diff image later, the
corresponding cluster of the base image would get "masked" and the
part of the cluster not in the diff image is not accessible anymore.

Unfortunately, it is not always possible to check for the target
image's cluster size, e.g. when it's NBD. Because the limitation is
already documented in the QAPI description for the @bitmap parameter
and it's only required for special diff image use-case, simply skip
the check then.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 blockdev.c                                    | 19 +++++++++++++++++++
 tests/qemu-iotests/tests/bitmap-sync-mirror   |  6 ++++++
 .../qemu-iotests/tests/bitmap-sync-mirror.out |  7 +++++++
 3 files changed, 32 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index c76eb97a4c..968d44cd3b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2847,6 +2847,9 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     }
 
     if (bitmap_name) {
+        BlockDriverInfo bdi;
+        uint32_t bitmap_granularity;
+
         if (sync != MIRROR_SYNC_MODE_FULL) {
             error_setg(errp, "Sync mode '%s' not supported with bitmap.",
                        MirrorSyncMode_str(sync));
@@ -2863,6 +2866,22 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
             return;
         }
 
+        bitmap_granularity = bdrv_dirty_bitmap_granularity(bitmap);
+        /*
+         * Ignore if unable to get the info, e.g. when target is NBD. It's only
+         * relevant for syncing to a diff image and the documentation already
+         * states that the target's cluster size needs to small enough then.
+         */
+        if (bdrv_get_info(target, &bdi) >= 0) {
+            if (bitmap_granularity < bdi.cluster_size ||
+                bitmap_granularity % bdi.cluster_size != 0) {
+                error_setg(errp, "Bitmap granularity %u is not a multiple of "
+                           "the target image's cluster size %u",
+                           bitmap_granularity, bdi.cluster_size);
+                return;
+            }
+        }
+
         if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
             return;
         }
diff --git a/tests/qemu-iotests/tests/bitmap-sync-mirror b/tests/qemu-iotests/tests/bitmap-sync-mirror
index 898f1f4ba4..cbd5cc99cc 100755
--- a/tests/qemu-iotests/tests/bitmap-sync-mirror
+++ b/tests/qemu-iotests/tests/bitmap-sync-mirror
@@ -552,6 +552,12 @@ def test_mirror_api():
                                 bitmap=bitmap)
                 log('')
 
+        log("-- Test bitmap with too small granularity --\n".format(sync_mode))
+        vm.qmp_log("block-dirty-bitmap-add", node=drive0.node,
+                   name="bitmap-small", granularity=(GRANULARITY // 2))
+        blockdev_mirror(drive0.vm, drive0.node, "mirror_target", "full",
+                        job_id='api_job', bitmap="bitmap-small")
+        log('')
 
 def main():
     for bsync_mode in ("never", "on-success", "always"):
diff --git a/tests/qemu-iotests/tests/bitmap-sync-mirror.out b/tests/qemu-iotests/tests/bitmap-sync-mirror.out
index c05b4788c6..d40ea7d689 100644
--- a/tests/qemu-iotests/tests/bitmap-sync-mirror.out
+++ b/tests/qemu-iotests/tests/bitmap-sync-mirror.out
@@ -2937,3 +2937,10 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
 {"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
 {"error": {"class": "GenericError", "desc": "Sync mode 'none' not supported with bitmap."}}
 
+-- Test bitmap with too small granularity --
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 32768, "name": "bitmap-small", "node": "drive0"}}
+{"return": {}}
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap-small", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Bitmap granularity 32768 is not a multiple of the target image's cluster size 65536"}}
+
-- 
2.39.2



