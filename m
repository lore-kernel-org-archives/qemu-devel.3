Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2DD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjIM-0001CV-Jd; Wed, 03 Dec 2025 04:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjIA-0000r1-Ax; Wed, 03 Dec 2025 04:37:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjI8-00076j-DZ; Wed, 03 Dec 2025 04:36:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C4B51708B7;
 Wed, 03 Dec 2025 12:35:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E699132B5AE;
 Wed, 03 Dec 2025 12:36:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 88/96] block: use pwrite_zeroes_alignment when writing
 first sector
Date: Wed,  3 Dec 2025 12:35:21 +0300
Message-ID: <20251203093612.2370716-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Since commit 5634622bcb33 ("file-posix: allow BLKZEROOUT with -t
writeback"), qemu-img create errors out on a Linux loop block device
with a 4 KB sector size:

  # dd if=/dev/zero of=blockfile bs=1M count=1024
  # losetup --sector-size 4096 /dev/loop0 blockfile
  # qemu-img create -f raw /dev/loop0 1G
  Formatting '/dev/loop0', fmt=raw size=1073741824
  qemu-img: /dev/loop0: Failed to clear the new image's first sector: Invalid argument

Use the pwrite_zeroes_alignment block limit to avoid misaligned
fallocate(2) or ioctl(BLKZEROOUT) in the block/file-posix.c block
driver.

Cc: qemu-stable@nongnu.org
Fixes: 5634622bcb33 ("file-posix: allow BLKZEROOUT with -t writeback")
Reported-by: Jean-Louis Dupond <jean-louis@dupond.be>
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3127
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251007141700.71891-3-stefanha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d704a13d2c025779bc91d04e127427347ddcf3b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block.c b/block.c
index 8848e9a7ed..be77e03904 100644
--- a/block.c
+++ b/block.c
@@ -606,12 +606,13 @@ create_file_fallback_zero_first_sector(BlockBackend *blk,
                                        int64_t current_size,
                                        Error **errp)
 {
+    uint32_t alignment = blk_get_pwrite_zeroes_alignment(blk);
     int64_t bytes_to_clear;
     int ret;
 
     GLOBAL_STATE_CODE();
 
-    bytes_to_clear = MIN(current_size, BDRV_SECTOR_SIZE);
+    bytes_to_clear = MIN(current_size, MAX(BDRV_SECTOR_SIZE, alignment));
     if (bytes_to_clear) {
         ret = blk_co_pwrite_zeroes(blk, 0, bytes_to_clear, BDRV_REQ_MAY_UNMAP);
         if (ret < 0) {
diff --git a/block/block-backend.c b/block/block-backend.c
index d6df369188..98315d4470 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2305,6 +2305,17 @@ uint32_t blk_get_request_alignment(BlockBackend *blk)
     return bs ? bs->bl.request_alignment : BDRV_SECTOR_SIZE;
 }
 
+/* Returns the optimal write zeroes alignment, in bytes; guaranteed nonzero */
+uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk)
+{
+    BlockDriverState *bs = blk_bs(blk);
+    IO_CODE();
+    if (!bs) {
+        return BDRV_SECTOR_SIZE;
+    }
+    return bs->bl.pwrite_zeroes_alignment ?: bs->bl.request_alignment;
+}
+
 /* Returns the maximum hardware transfer length, in bytes; guaranteed nonzero */
 uint64_t blk_get_max_hw_transfer(BlockBackend *blk)
 {
diff --git a/include/system/block-backend-io.h b/include/system/block-backend-io.h
index ba8dfcc7d0..6d5ac476fc 100644
--- a/include/system/block-backend-io.h
+++ b/include/system/block-backend-io.h
@@ -116,6 +116,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
                                   void *opaque, int ret);
 
 uint32_t blk_get_request_alignment(BlockBackend *blk);
+uint32_t blk_get_pwrite_zeroes_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 uint64_t blk_get_max_hw_transfer(BlockBackend *blk);
 
-- 
2.47.3


