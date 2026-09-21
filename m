Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844D1C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2N-0003bX-B5; Mon, 21 Sep 2026 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0t-0001xB-SC; Mon, 21 Sep 2026 10:29:03 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0r-000093-2Q; Mon, 21 Sep 2026 10:28:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29B80600C8;
 Mon, 21 Sep 2026 14:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700A71F000FF;
 Mon, 21 Sep 2026 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000935;
 bh=HE4fbtBVZ7BN13xy8oo7npZAX2OBj52IgG8zDIJZros=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XzkZaf/LzgCyfuzUeA0rS9nbFGmxKAUUxR/szwPs6FRJ7SyBWdTSgyecwV7+B+Fnp
 S3j+KwjSK6owK6uE+sIodhT2g0g2TmBDseyHi1FUGxThigYbqD974T/XnhStjTFF+m
 hzAoZ2fw19VoXkMYPYSD5j2wg3ilbG5U+mT+LXev18LRFDHTxyivJFNOPvigiUbUK6
 tA0ztRdZH2fqo4gG4JYC8RxcDe56UurR6z8N6QabzP8unN1lWIQIsd404k6cIibH82
 lfuek8HxnwU11V3bCgpxjdt6KZcLuFkfWzfl5xAU6HmczsEHuLxX+xvct5qmtnWquo
 y1TpsIh+l9ZNg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 07/15] hw/block: reject a zoned device that the block sizes
 cannot address
Date: Mon, 21 Sep 2026 16:28:09 +0200
Message-ID: <20260921142819.2916043-8-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921142819.2916043-1-cassel@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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
---
 hw/block/block.c         | 63 ++++++++++++++++++++++++++++++++++++++++
 hw/block/virtio-blk.c    |  4 +++
 include/hw/block/block.h |  1 +
 3 files changed, 68 insertions(+)

diff --git a/hw/block/block.c b/hw/block/block.c
index 79b0a67cea..3bb8121e9e 100644
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
index 449de307b4..74bd08b0ec 100644
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
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index c769b1297d..c0a8b84df1 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -127,6 +127,7 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp);
  * physical block size, so this is the physical block size in practice.
  */
 uint32_t blkconf_zone_write_granularity(BlockConf *conf);
+bool blkconf_check_zoned_geometry(BlockConf *conf, Error **errp);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
-- 
2.55.0


