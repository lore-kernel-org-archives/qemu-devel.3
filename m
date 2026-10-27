Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZW89oBnW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnz1-0001Ul-7b; Tue, 27 Oct 2026 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny4-0000rf-Uv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny0-0001Z4-QF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLSSlJ1CgpTt9MxuxIIYC5FXdpNjI621JSB6rwqUW9k=;
 b=ZW89oBnWbjG2Gfly91FvcUg7p2A4eSiUaUrrUC+lZEc+3xdTQokdhgfW2G/ZwTuJxTzD85
 B7qNAtEI2871P7KnXoLyrLcsPw9GlJxqUGrvloE0Gj6YUhnf+QZKihlRq5oU9NyIV7qY0E
 7XXwlS/nTJIQZteJ9UQGUlqICvg5Jjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-BM-rGxJIPVyaagOsaoygnw-1; Tue,
 27 Oct 2026 16:39:52 -0400
X-MC-Unique: BM-rGxJIPVyaagOsaoygnw-1
X-Mimecast-MFC-AGG-ID: BM-rGxJIPVyaagOsaoygnw_1793133583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A549919541B4; Tue, 27 Oct 2026 20:39:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B31C19560AB; Tue, 27 Oct 2026 20:39:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 03/15] block: add a helper for the index of the zone an offset
 falls in
Date: Tue, 27 Oct 2026 16:39:21 -0400
Message-ID: <20261027203933.1066759-4-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Niklas Cassel <cassel@kernel.org>

Deriving the zone that an offset belongs to is open coded in five places,
in two files, as a division of the offset by BlockLimits.zone_size.

The zone size of a zoned device is always a power of two. Linux requires
that of every zoned device it accepts, in blk_revalidate_disk_zones() and
in each of the drivers that report one, and qcow2 rejects an image whose
header says otherwise. So the division is a shift, and the shift is worth
deriving once rather than at every use: record it in BlockLimits as
zone_size_bits, next to the size it comes from, and assert the property
that it relies on where it is computed.

Add bdrv_zone_index() and use it. No functional change; the count of zones
that a management operation spans stays a division, since it is a length
rather than an offset.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Message-id: 20260921142819.2916043-4-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-io.h         |  2 ++
 include/block/block_int-common.h |  7 +++++++
 block/file-posix.c               |  8 ++++----
 block/io.c                       | 12 ++++++++++++
 hw/block/virtio-blk.c            |  2 +-
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index d34d846bb2a..9d1c0eb7fbc 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -126,6 +126,8 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   int64_t *offset,
                                                   QEMUIOVector *qiov,
                                                   BdrvRequestFlags flags);
+/* The index of the zone that @offset falls in. */
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index b227ff34a18..3b18020b0e2 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -904,6 +904,13 @@ typedef struct BlockLimits {
     /* zone size expressed in bytes */
     uint64_t zone_size;
 
+    /*
+     * log2 of zone_size, derived by bdrv_refresh_limits(). A zoned device
+     * always has a zone size that is a power of two, so the zone an offset
+     * falls in is a shift rather than a division. See bdrv_zone_index().
+     */
+    uint32_t zone_size_bits;
+
     /* total number of zones */
     uint32_t nr_zones;
 
diff --git a/block/file-posix.c b/block/file-posix.c
index df8ca4e88fa..48ae785639e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1379,7 +1379,7 @@ static int get_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
     size_t rep_size;
     uint64_t sector = offset >> BDRV_SECTOR_BITS;
     BlockZoneWps *wps = bs->wps;
-    unsigned int j = offset / bs->bl.zone_size;
+    unsigned int j = bdrv_zone_index(bs, offset);
     unsigned int n = 0, i = 0;
     int ret;
     rep_size = sizeof(struct blk_zone_report) + nrz * sizeof(struct blk_zone);
@@ -2579,7 +2579,7 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
         bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
         if (type & QEMU_AIO_ZONE_APPEND) {
-            int index = offset / bs->bl.zone_size;
+            int index = bdrv_zone_index(bs, offset);
             offset = bs->wps->wp[index];
         }
     }
@@ -2634,7 +2634,7 @@ out:
         bs->bl.zoned != BLK_Z_NONE) {
         BlockZoneWps *wps = bs->wps;
         if (ret == 0) {
-            uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
+            uint64_t *wp = &wps->wp[bdrv_zone_index(bs, offset)];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
                     *offset_ptr = *wp;
@@ -3532,7 +3532,7 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
         return -EINVAL;
     }
 
-    uint32_t i = offset / bs->bl.zone_size;
+    uint32_t i = bdrv_zone_index(bs, offset);
     uint32_t nrz = len / bs->bl.zone_size;
     uint64_t *wp = &wps->wp[i];
     if (BDRV_ZT_IS_CONV(*wp) && len != capacity) {
diff --git a/block/io.c b/block/io.c
index 1c05dd106d6..8ba0b3c9626 100644
--- a/block/io.c
+++ b/block/io.c
@@ -230,6 +230,11 @@ void bdrv_refresh_limits(BlockDriverState *bs, Transaction *tran, Error **errp)
         }
     }
 
+    if (bs->bl.zone_size) {
+        assert(is_power_of_2(bs->bl.zone_size));
+        bs->bl.zone_size_bits = ctz64(bs->bl.zone_size);
+    }
+
     if (bs->bl.request_alignment > BDRV_MAX_ALIGNMENT) {
         error_setg(errp, "Driver requires too large request alignment");
     }
@@ -3366,6 +3371,13 @@ out:
     return co.ret;
 }
 
+uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
+{
+    IO_CODE();
+
+    return offset >> bs->bl.zone_size_bits;
+}
+
 void *qemu_blockalign(BlockDriverState *bs, size_t size)
 {
     IO_CODE();
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 1b93364b241..6e4a7a4076c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -523,7 +523,7 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
             }
         }
 
-        index = offset / bs->bl.zone_size;
+        index = bdrv_zone_index(bs, offset);
         if (BDRV_ZT_IS_CONV(bs->wps->wp[index])) {
             *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
             return false;
-- 
2.56.0


