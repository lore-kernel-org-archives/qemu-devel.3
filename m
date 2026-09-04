Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D04C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Wck-0000yp-8J; Fri, 04 Sep 2026 12:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2Wcg-0000tB-Ag; Fri, 04 Sep 2026 12:18:38 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2Wce-0001S1-EV; Fri, 04 Sep 2026 12:18:38 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EC9E41297;
 Fri,  4 Sep 2026 16:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A0A1F00A3D;
 Fri,  4 Sep 2026 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788538715;
 bh=INhRDGryIWAEOCUCswXAzB5E6RNbqQ307E4XesVgWxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YVnVE7InIOp2BJ8ZWF/P/Q4hqY8tUs730icyTTkwe0cvkShs/EjZSf9H4vj9NvkE5
 Znf+GIsYAZdK+9J/b8xCydnwgoMm5lZJcJftRp35gNnJ1ie3EAnYnerZSPSpVYRFw0
 2x69HVzn+D/fcqxP9/3lhU4jD7rddBBmUnXrOje7IqHZc8NU75shD2yYC06gljGq0k
 5nPS09/3c4SvFyKLOZ8i/Dl1YOkHmt8dHs0QMAc5jfHNnIM/nAIZ5QzVYsqsDOs0u5
 xgteypmCaA37JuoxkijuOVXMk0h4sNCyyPCaluBgh7lJBWdJIrSceBwrRx6TSc6vwg
 kqhsHLF7wu2LA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] virtio-blk: derive the maximum zone append size
Date: Fri,  4 Sep 2026 18:17:58 +0200
Message-ID: <20260904161801.1568841-11-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904161801.1568841-1-cassel@kernel.org>
References: <20260904161801.1568841-1-cassel@kernel.org>
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

The max_append_sectors field of virtio_blk_zoned_characteristics must be
set by the device to the largest zone append request that can be issued
to it, and a value of zero tells the guest driver that zone append is not
supported at all (virtio 1.4, 5.2.5.2). Linux refuses to attach a zoned
device that reports zero.

We pass BlockLimits.max_append_sectors straight through, which makes that
field mean "zone append unsupported" when it is unset, rather than "this
backend imposes no limit of its own". Only a backend that has a limit of
its own has anything to put there.

Derive the value instead. A backend limit is honoured when there is one,
and otherwise the request is bounded by the zone size, since an append
cannot cross a zone boundary, and by the largest request the block layer
can carry. The result cannot be zero.

A backend that carries out an append itself, rather than passing it to a
device that has a limit of its own, is the one that knows how large a
request its implementation can take, so it reports that in
BlockLimits.max_append_sectors and this does not have to guess at it.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/block/virtio-blk.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index c2acf59c6d..131516a167 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -525,6 +525,27 @@ typedef struct ZoneCmdData {
     };
 } ZoneCmdData;
 
+/*
+ * The maximum zone append data size that the device reports to the driver in
+ * virtio_blk_zoned_characteristics, in 512 byte sectors.
+ *
+ * A backend that has no limit of its own leaves BlockLimits.max_append_sectors
+ * at zero, in which case the limit is whatever else bounds the request: an
+ * append cannot cross a zone boundary, and the block layer cannot carry a
+ * larger one. The result is never zero, which the driver would read as zone
+ * append not being supported at all.
+ */
+static uint32_t virtio_blk_max_append_sectors(VirtIOBlock *s)
+{
+    BlockDriverState *bs = blk_bs(s->blk);
+    uint64_t sectors;
+
+    sectors = MIN_NON_ZERO(bs->bl.zone_size >> BDRV_SECTOR_BITS,
+                           bs->bl.max_append_sectors);
+
+    return MIN_NON_ZERO(sectors, BDRV_REQUEST_MAX_SECTORS);
+}
+
 /*
  * check zoned_request: error checking before issuing requests. If all checks
  * passed, return true.
@@ -560,12 +581,8 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
             return false;
         }
 
-        if (len / 512 > bs->bl.max_append_sectors) {
-            if (bs->bl.max_append_sectors == 0) {
-                *status = VIRTIO_BLK_S_UNSUPP;
-            } else {
-                *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
-            }
+        if ((len >> BDRV_SECTOR_BITS) > virtio_blk_max_append_sectors(s)) {
+            *status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
             return false;
         }
     }
@@ -1313,7 +1330,7 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
         virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
                      blkconf_zone_write_granularity(conf));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
-                     bs->bl.max_append_sectors);
+                     virtio_blk_max_append_sectors(s));
     } else {
         blkcfg.zoned.model = VIRTIO_BLK_Z_NONE;
     }
-- 
2.55.0


