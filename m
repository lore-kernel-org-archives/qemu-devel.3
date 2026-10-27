Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA1606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZSWoXRV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyz-0001PT-FI; Tue, 27 Oct 2026 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxr-0000pI-Ti
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxe-0001Ll-4Z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yl1/L+LrMZiPUlKrujB3h30/6c8TEokqGisM1A3PNRQ=;
 b=QZSWoXRVLvA93Ia5JWC3/eKSqrIrCVlf9N3N/l2x1NQ5jF3x6A37QIOV5XxM0+hJ1Z9MRT
 VqK67iI4Z4ixpwHKLGLCofQwB0AxLcOCAcwaVBuMYQs993bpMGyDE19GxNtpj0+ktOZaT1
 tesRc7t5z/fPkDgT6LBoWIoq6fo1eLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-3EWI2mV5OdmlAzK3pM7abA-1; Tue,
 27 Oct 2026 16:39:50 -0400
X-MC-Unique: 3EWI2mV5OdmlAzK3pM7abA-1
X-Mimecast-MFC-AGG-ID: 3EWI2mV5OdmlAzK3pM7abA_1793133589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3660B195421E; Tue, 27 Oct 2026 20:39:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BD00300019F; Tue, 27 Oct 2026 20:39:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 07/15] hw/block: reject a zoned device that the block sizes
 cannot address
Date: Tue, 27 Oct 2026 16:39:25 -0400
Message-ID: <20261027203933.1066759-8-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

The write granularity that a frontend reports is derived from the logical
and the physical block size, which are properties of the device model,
while the granularity that the medium requires and the write pointers
that it holds belong to the backend. Nothing ties them together, and
where they disagree a guest is told about a device it cannot use.

A backend can require a coarser granularity than the block sizes express.
A 512e host managed disk has a logical block size of 512 and requires
writes to a sequential zone to be a multiple of 4096, so attaching it
with a finer physical block size reports a granularity that the disk will
not accept, and the guest is given a plain I/O error for a request that
it was told was valid.

The write pointers can disagree in the same way. They outlive any
particular use of the device, while the block sizes are chosen afresh
every time it is attached, so a zone written with logical_block_size=512
leaves a write pointer that logical_block_size=4096 cannot address. A
zone report expresses it in 512 byte sectors, so the guest is told about
a position that does not fall on a logical block boundary, which it can
neither read nor write, and the zone can then only be recovered by
resetting it. The reverse is harmless: a pointer laid down with a larger
logical block size is still a multiple of a smaller one.

Check both at realize time, along with the zone size and the zone
capacity, and refuse to start otherwise. The write pointers are already
held in memory by the driver, so this costs no I/O.

The check uses blkconf_zone_write_granularity(), the same value that a
frontend reports to its guest and validates requests against, so the
three cannot disagree.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-8-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/block/block.h |  1 +
 hw/block/block.c         | 63 ++++++++++++++++++++++++++++++++++++++++
 hw/block/virtio-blk.c    |  4 +++
 3 files changed, 68 insertions(+)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index c769b1297d0..c0a8b84df1f 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -127,6 +127,7 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp);
  * physical block size, so this is the physical block size in practice.
  */
 uint32_t blkconf_zone_write_granularity(BlockConf *conf);
+bool blkconf_check_zoned_geometry(BlockConf *conf, Error **errp);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
diff --git a/hw/block/block.c b/hw/block/block.c
index 79b0a67ceac..3bb8121e9e4 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -206,6 +206,69 @@ uint32_t blkconf_zone_write_granularity(BlockConf *conf)
     return MAX(conf->logical_block_size, conf->physical_block_size);
 }
 
+bool blkconf_check_zoned_geometry(BlockConf *conf, Error **errp)
+{
+    BlockDriverState *bs = blk_bs(conf->blk);
+    uint32_t wg;
+
+    if (bs->bl.zoned == BLK_Z_NONE) {
+        return true;
+    }
+
+    wg = blkconf_zone_write_granularity(conf);
+
+    /*
+     * A backend that requires a coarser granularity than the one that is about
+     * to be reported would reject writes that the guest has been told are
+     * valid, leaving it with a plain I/O error.
+     */
+    if (bs->bl.write_granularity > wg) {
+        error_setg(errp, "the backend requires writes to sequential zones to "
+                   "be a multiple of %" PRIu32 " bytes, which is coarser than "
+                   "the zone write granularity %" PRIu32 " that would be "
+                   "reported", bs->bl.write_granularity, wg);
+        error_append_hint(errp, "Set physical_block_size=%" PRIu32 ".\n",
+                          bs->bl.write_granularity);
+        return false;
+    }
+
+    if (!QEMU_IS_ALIGNED(bs->bl.zone_size, wg)) {
+        error_setg(errp, "zone size %" PRIu64 " is not a multiple of the zone "
+                   "write granularity %" PRIu32, bs->bl.zone_size, wg);
+        return false;
+    }
+
+    /*
+     * A write pointer that is not a multiple of the write granularity does not
+     * fall on a logical block boundary, so the guest can neither read nor write
+     * at it and the zone can only be recovered by resetting it. A backend that
+     * records its write pointers, rather than reading them back from a device,
+     * can hand us such a pointer when the zones were written while the device
+     * was configured with a smaller logical block size.
+     */
+    for (uint32_t i = 0; i < bs->bl.nr_zones; i++) {
+        uint64_t wp;
+
+        if (bdrv_zone_is_conv(bs, i)) {
+            continue;
+        }
+
+        wp = bs->wps->wp[i];
+        if (!QEMU_IS_ALIGNED(wp, wg)) {
+            error_setg(errp, "write pointer 0x%" PRIx64 " of zone %" PRIu32
+                       " is not a multiple of the zone write granularity %"
+                       PRIu32, wp, i, wg);
+            error_append_hint(errp, "The zones were written with a finer zone "
+                              "write granularity. Reset them, or attach the "
+                              "device with the block sizes that they were "
+                              "written with.\n");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 449de307b48..74bd08b0ec1 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1840,6 +1840,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!blkconf_check_zoned_geometry(&conf->conf, errp)) {
+        return;
+    }
+
     bs = blk_bs(conf->conf.blk);
     if (bs->bl.zoned != BLK_Z_NONE) {
         virtio_add_feature(&s->host_features, VIRTIO_BLK_F_ZONED);
-- 
2.56.0


