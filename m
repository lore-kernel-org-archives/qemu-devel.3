Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bwnh8EDC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyR-000141-87; Tue, 27 Oct 2026 16:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLny4-0000rg-VQ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxs-0001Na-2G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmqnVsaVzUez9WDXuytLRKh1lphInebJt2AXIrdlFoo=;
 b=bwnh8EDCD2zGpmXCMToQdebmq0pU9Cb8Bt8Tg/AOTuLrlZ+unAPBNxJ9jOrL0sSm3pmlVw
 4e0324RVOBtyWwSciKYd7QjxY3wgwoH0DwWKkD/mfWrKWppXAaTH5wrhxPPz7pw1JayiH5
 jDx8r/00kp63HCN9A3Y+Gn9vfixEvNA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-sCnYy63CNVKDYnArV4932w-1; Tue,
 27 Oct 2026 16:40:00 -0400
X-MC-Unique: sCnYy63CNVKDYnArV4932w-1
X-Mimecast-MFC-AGG-ID: sCnYy63CNVKDYnArV4932w_1793133599
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E132018005B2; Tue, 27 Oct 2026 20:39:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3688D1955F01; Tue, 27 Oct 2026 20:39:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: [PULL 14/15] file-posix: reject a zone append to a full or
 conventional zone
Date: Tue, 27 Oct 2026 16:39:32 -0400
Message-ID: <20261027203933.1066759-15-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-id: 20260921142819.2916043-15-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-io.h |  6 ++++++
 block/file-posix.c       | 23 ++++++++++++++++++++++-
 block/io.c               |  9 +++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index e469df70610..f671476f08a 100644
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
 
diff --git a/block/file-posix.c b/block/file-posix.c
index f87afffa40d..bad7ccdb733 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2574,7 +2574,28 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
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
index eaca8850d01..c86f96bd612 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3407,6 +3407,15 @@ bool bdrv_zone_is_conv(BlockDriverState *bs, uint32_t index)
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
-- 
2.56.0


