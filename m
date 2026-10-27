Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586C606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnwcWIkf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyM-000137-Sb; Tue, 27 Oct 2026 16:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxa-0000mF-HV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:39:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxW-0001Kx-JL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lk5+7UNA+reYS/eYjIEoN9VAHU4As+vDYwlwHo+VTic=;
 b=OnwcWIkfvp4ZJp3TLiLGx4AWZl3un+4ZX6QVRWYwgzuv/b1nwOi5C8Rm9ixzWchgrL34Lx
 esqkTKTxON2ve58JsAEkWR0TcBNUVgKAgk+DypKmEq7odqbpppB68au4nXOHIA0eQ/7xoX
 fedMCDDIgYELAKn7MjwG38wAmmfjN9I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-v_lb7_pKPsuXyGKIxjZzSw-1; Tue,
 27 Oct 2026 16:39:45 -0400
X-MC-Unique: v_lb7_pKPsuXyGKIxjZzSw-1
X-Mimecast-MFC-AGG-ID: v_lb7_pKPsuXyGKIxjZzSw_1793133584
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC6D1180058F; Tue, 27 Oct 2026 20:39:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8759E410; Tue, 27 Oct 2026 20:39:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 04/15] block: add a helper to check if a zone is conventional
Date: Tue, 27 Oct 2026 16:39:22 -0400
Message-ID: <20261027203933.1066759-5-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-5-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-io.h | 6 ++++++
 block/io.c               | 7 +++++++
 hw/block/virtio-blk.c    | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 9d1c0eb7fbc..e469df70610 100644
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
 
diff --git a/block/io.c b/block/io.c
index 8ba0b3c9626..d08956105c2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3378,6 +3378,13 @@ uint32_t bdrv_zone_index(BlockDriverState *bs, uint64_t offset)
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
index 6e4a7a4076c..dd69d81532b 100644
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
-- 
2.56.0


