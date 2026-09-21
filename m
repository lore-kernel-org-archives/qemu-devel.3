Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BB8C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2W-0004IU-29; Mon, 21 Sep 2026 10:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f1B-00025k-Fz; Mon, 21 Sep 2026 10:29:17 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f19-0000Oc-Gi; Mon, 21 Sep 2026 10:29:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A713443C24;
 Mon, 21 Sep 2026 14:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1CF1F00893;
 Mon, 21 Sep 2026 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000953;
 bh=9eUY+qoiMmI8f2wHw9jfnOrmp7TtMNfsRoJm1rEUDHQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qlkq0qro4cW87Q1xh7Kc2t8MazZPrBP0SsQmjoZTTOLzMj8why1jICVcFo3zYrgAM
 HLwTSUanZaNSSdsN1M8YmL5xmpS4Lalx5mkr+VpkF7eHlg4mQNRyYoOo8XiEarQWAL
 nt1EeyvwXb0/BvMm/wtJyUWL2vjlgOIBZZg2ju2EkHj8Fo75ksv3zWzh4cnY3n3fvi
 oeXddvmLbIwHQtXBKsxIthI9tWPOpPVaqHKIKLgPM4WvpFwoYGDRI3NAvj+exLTv7G
 tgJCxbZXbMH6zj0OmXdNM6TQcS+F2l1hFWfPjBn7+4lQwF8/IaG66NBJFwHZbojfS6
 zYaHWqAxa4HRQ==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 14/15] file-posix: reject a zone append to a full or
 conventional zone
Date: Mon, 21 Sep 2026 16:28:16 +0200
Message-ID: <20260921142819.2916043-15-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

raw_co_prw() replaces the offset of a zone append with the write pointer
of the addressed zone, which assumes that the stored value names a
position inside that zone. It does not in two cases.

A full zone has its write pointer recorded at the end of the zone, since
get_zones_wp() stores start + len for BLK_ZONE_COND_FULL. That is the
first sector of the following zone, so the append is submitted there. The
kernel accepts it whenever that zone is empty, because it is a legal
write at its write pointer, and the completion path advances the wrong
zone because it recomputes the zone index from the replaced offset. The
data is written to a zone that was never addressed and success is
returned:

  zone 2 finished, then a 4 KiB append to zone 2:
  After zap done, the append sector is 0x180000     <- zone 3
  zone 2: wptr 0x180000, zcond:14 (full)
  zone 3: wptr 0x180008                             <- advanced

A conventional zone has no write pointer at all, and its array entry
carries only the type marker in the top bit, so the offset becomes
negative and the write fails with EINVAL. That is harmless but it reports
nothing about the actual mistake.

Reject both while the write pointer lock is held, since the state has to
be read and acted on atomically. check_zoned_request() in virtio-blk
refuses an append to a conventional zone, so that case needs a caller
that goes to the driver directly, but nothing there examines whether a
zone is full, so a guest can reach the misdirected write.

Fixes: 4751d09adcc3 ("block: introduce zone append write for zoned devices")
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c       | 23 ++++++++++++++++++++++-
 block/io.c               |  9 +++++++++
 include/block/block-io.h |  6 ++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index e1e6a03b25..cd3c9f0fd0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2555,7 +2555,28 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
         bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = bdrv_zone_index(bs, offset);
+            uint32_t index = bdrv_zone_index(bs, offset);
+
+            /*
+             * The write pointer of the addressed zone becomes the offset of
+             * the write, so it has to name a position inside that zone. A
+             * conventional zone has no write pointer, and the pointer of a
+             * full zone is reported at the end of the zone. Either would send
+             * the data to a zone that was never addressed.
+             */
+            if (bdrv_zone_is_conv(bs, index)) {
+                error_report("zone append at offset 0x%" PRIx64 " addresses a "
+                             "conventional zone", offset);
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                return -EINVAL;
+            }
+            if (bdrv_zone_is_full(bs, index)) {
+                error_report("zone append at offset 0x%" PRIx64 " addresses a "
+                             "full zone", offset);
+                qemu_co_mutex_unlock(&bs->wps->colock);
+                return -ENOSPC;
+            }
+
             offset = bs->wps->wp[index];
         }
     }
diff --git a/block/io.c b/block/io.c
index d7c403bc08..a4fb56f799 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3402,6 +3402,15 @@ bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index)
     return BDRV_ZT_IS_CONV(bs->wps->wp[index]);
 }
 
+bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index)
+{
+    uint64_t zone_end = MIN((uint64_t)(index + 1) * bs->bl.zone_size,
+                            (uint64_t)bs->total_sectors << BDRV_SECTOR_BITS);
+    IO_CODE();
+
+    return bs->wps->wp[index] >= zone_end;
+}
+
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
 {
     IO_CODE();
diff --git a/include/block/block-io.h b/include/block/block-io.h
index e469df7061..f671476f08 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -134,6 +134,12 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
  * bdrv_zone_is_full() this does not need the write pointer lock.
  */
 bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index);
+/*
+ * True when the write pointer of a zone has reached the end of the writable
+ * part of that zone, so that nothing more can be written to it until it is
+ * reset. The write pointer lock must be held when called.
+ */
+bool bdrv_zone_is_full(BlockDriverState *bs, uint32_t index);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
-- 
2.55.0


