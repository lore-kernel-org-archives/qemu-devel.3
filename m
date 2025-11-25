Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A707BD0E6F5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 16:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNvjB-0006ui-Fc; Tue, 25 Nov 2025 11:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj5-0006iz-6L
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vNvj2-00056h-Lm
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 11:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764087428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08v7AzWh8ahJ/6I5lOs9Lhby5WymPW1UOUKrJIxyHcE=;
 b=SlTx+GNxrgNIomDlRW7ZFbtyi5xXVb1aMpmyHufUGiJbcELDuPUNuJh3qCmsZlx9CUf58P
 2likeN3As/7S3igFsa+xpZBMavrrVvkc7mBWjr4bhTWS10cLhSGhF9O6/QxuWbZNXNM+R2
 l1KJnWYoqvelh8uq4GrtI25DNz0S0L0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-scK4zRyvPnC38L3M5eDcXw-1; Tue,
 25 Nov 2025 11:17:06 -0500
X-MC-Unique: scK4zRyvPnC38L3M5eDcXw-1
X-Mimecast-MFC-AGG-ID: scK4zRyvPnC38L3M5eDcXw_1764087425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28FF5180045C; Tue, 25 Nov 2025 16:17:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C352F18004A3; Tue, 25 Nov 2025 16:17:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] block: use pwrite_zeroes_alignment when writing first
 sector
Date: Tue, 25 Nov 2025 17:16:47 +0100
Message-ID: <20251125161648.259321-4-kwolf@redhat.com>
In-Reply-To: <20251125161648.259321-1-kwolf@redhat.com>
References: <20251125161648.259321-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/system/block-backend-io.h |  1 +
 block.c                           |  3 ++-
 block/block-backend.c             | 11 +++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

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
 
diff --git a/block.c b/block.c
index 4f1581cedf..48a17f393c 100644
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
-- 
2.51.1


