Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D8CC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2A-0002jf-FJ; Mon, 21 Sep 2026 10:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0l-0001vu-Vq; Mon, 21 Sep 2026 10:28:55 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0j-00007k-5s; Mon, 21 Sep 2026 10:28:51 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65C9A43583;
 Mon, 21 Sep 2026 14:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED41F000FF;
 Mon, 21 Sep 2026 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000927;
 bh=PTZ+yrhR+/MJNKDSkwD+F+glze+MmD3SwdgrHQBQnJY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=K48At27Dad9lwj18HOVAIVwiNc+RQtvLkLX/NCVvKMV1KzHA4kNOY/4IfqhSfTXrl
 c2ARDgZscliOcmFp9t8bLJtXtS5rp5jveKcxIeNRnmIEP8xWn4THwYeFYtfLklDRXr
 w72xsx+dj1+LLTMSgx8KO9V4vAMCHd+nrhH+WRPNzK0KmoHF6+2oXkeLzQQfZ+uaxO
 Lu73NN2HoR/0+JdKnn+W4B4BS6sgeFSZThAhnKiAENr2fII1R7mJC/baTCBmgK8fZx
 +W77x2SOUoCOWHH8R4YFkCHslrXmFbB9CdlS8kBVqJJ7RGUMxhDkMXl614dzaOm1s2
 L2dB/UoBntPkw==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 04/15] block: add a helper to check if a zone is
 conventional
Date: Mon, 21 Sep 2026 16:28:06 +0200
Message-ID: <20260921142819.2916043-5-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
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

Whether a zone is conventional is encoded in the most significant bit of
the write pointer that the block layer keeps for it, so a caller that
wants to know has to reach into bs->wps->wp[] and apply BDRV_ZT_IS_CONV()
to the raw value. virtio-blk does that, which means a device model both
knows how a block driver stores its write pointers and knows what one of
the bits of a write pointer means.

Add an accessor next to bdrv_zone_index() and use it there, so that the
encoding stays with the code that chose it.

Unlike bdrv_zone_is_full(), this does not need the write pointer lock.
get_zones_wp() only ever sets the bit for a conventional zone and never
clears it, and a zone does not change type, so the answer cannot become
stale. The rest of the word does change, on every write, which is what
the lock is there for.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/io.c               | 7 +++++++
 hw/block/virtio-blk.c    | 2 +-
 include/block/block-io.h | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index cef23ee5bc..da61e641ac 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3373,6 +3373,13 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
     return offset >> bs->bl.zone_size_bits;
 }
 
+bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index)
+{
+    IO_CODE();
+
+    return BDRV_ZT_IS_CONV(bs->wps->wp[index]);
+}
+
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
 {
     IO_CODE();
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6e4a7a4076..dd69d81532 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -524,7 +524,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
         }
 
         index = bdrv_zone_index(bs, offset);
-        if (BDRV_ZT_IS_CONV(bs->wps->wp[index])) {
+        if (bdrv_zone_is_conv(bs, index)) {
             *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
             return false;
         }
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 9d1c0eb7fb..e469df7061 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -128,6 +128,12 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   BdrvRequestFlags flags);
 /* The index of the zone that @offset falls in. */
 uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
+/*
+ * True if the zone at @index is a conventional zone, which can be written
+ * anywhere in any order. The type of a zone does not change, so unlike
+ * bdrv_zone_is_full() this does not need the write pointer lock.
+ */
+bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
-- 
2.55.0


