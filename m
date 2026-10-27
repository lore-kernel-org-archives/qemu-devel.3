Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A924606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WYowhQQ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLnyy-0001Kx-0j; Tue, 27 Oct 2026 16:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxg-0000n8-Bb
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xLnxa-0001LU-Bf
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 16:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793133592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcIFDcxpLOa3PWGu17Hawki8OcyS3NYrE1SmCG+JiY4=;
 b=WYowhQQ327kvFJjpNTgkXMpVl9+xxVZQqezz+L9zufKdpeYlfYIVYnakzB3X+bdWKyGpw1
 gDlx4/LTOq3U6y67AM3TnN82SFvaiXCB8frVxEao+7BUCv9zU/ByTBDUowyKRxGM7k03yb
 IT/vwmabU2ZF95x5NlOqoQ4rY4OtXuI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-UZeXVWDrN9eYswMQxrSMcg-1; Tue,
 27 Oct 2026 16:39:47 -0400
X-MC-Unique: UZeXVWDrN9eYswMQxrSMcg-1
X-Mimecast-MFC-AGG-ID: UZeXVWDrN9eYswMQxrSMcg_1793133586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B56FE1805A11; Tue, 27 Oct 2026 20:39:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07B2E1803A55; Tue, 27 Oct 2026 20:39:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: [PULL 05/15] hw/block: derive the zone write granularity from the
 block sizes
Date: Tue, 27 Oct 2026 16:39:23 -0400
Message-ID: <20261027203933.1066759-6-stefanha@redhat.com>
In-Reply-To: <20261027203933.1066759-1-stefanha@redhat.com>
References: <20261027203933.1066759-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For ZBC/ZAC devices the write granularity is the physical block size, so
a 512e SMR disk exposed through a host_device backend has a logical block
size of 512 and a zone write granularity of 4096. We told the guest
driver 512 while raw_co_zone_append() rejects anything that is not 4096
byte aligned, so the driver saw a plain I/O error for a request it had
been told was valid.

Report the larger of the logical and the physical block size instead.
Both are properties of the device model, so the value that a guest is
given does not change when it is migrated to a host whose disks differ,
which a value taken from BlockLimits would. It is also what a guest
derives for itself: blk_validate_zoned_limits() raises
zone_write_granularity to the logical block size, and for a SCSI disk
sd_zbc_read_zones() takes it from the physical block size.

blkconf_blocksizes() rejects a logical block size larger than the
physical block size, so this is the physical block size in practice. It
is expressed as the larger of the two because that is the constraint
which applies: a guest cannot issue a write finer than the logical block
size, and the medium cannot take one finer than the physical block size.

Add it as a helper next to blkconf_blocksizes(), since it is derived from
a BlockConf, and use it for the zone append offset check in
check_zoned_request(), which validated against bs->bl.write_granularity.
The value reported to the driver and the value that requests are
validated against then cannot drift apart. The helper cannot return zero
because blkconf_blocksizes() always leaves a logical block size behind,
so the check no longer needs to guard against an unset granularity.

Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20260921142819.2916043-6-cassel@kernel.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h |  7 +++++++
 include/hw/block/block.h         | 13 +++++++++++++
 hw/block/block.c                 |  5 +++++
 hw/block/virtio-blk.c            | 13 +++++++------
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 3b18020b0e2..6bfdcbfe86b 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -923,6 +923,13 @@ typedef struct BlockLimits {
     /* maximum number of active zones */
     uint32_t max_active_zones;
 
+    /*
+     * The granularity that the backend requires of a write to a sequential
+     * zone, in bytes, or zero if it has none. This describes the host, so it
+     * must not be reported to a guest: a frontend reports
+     * blkconf_zone_write_granularity() and checks this against it when the
+     * device is realized.
+     */
     uint32_t write_granularity;
 } BlockLimits;
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f2..c769b1297d0 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -114,6 +114,19 @@ bool blkconf_geometry(BlockConf *conf, int *trans,
                       unsigned cyls_max, unsigned heads_max, unsigned secs_max,
                       Error **errp);
 bool blkconf_blocksizes(BlockConf *conf, Error **errp);
+/*
+ * The alignment constraint that applies to writes to a sequential zone. A guest
+ * cannot issue a write finer than the logical block size, and the medium cannot
+ * take one finer than the physical block size, so the constraint that applies
+ * is the larger of the two. A frontend must report this value to its guest and
+ * validate requests against it.
+ *
+ * It is derived from the configuration and not from the backend, so that a
+ * guest is not given a property of the host, which would differ after
+ * migration. blkconf_blocksizes() rejects a logical block size larger than the
+ * physical block size, so this is the physical block size in practice.
+ */
+uint32_t blkconf_zone_write_granularity(BlockConf *conf);
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp);
 
diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d0..79b0a67ceac 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -201,6 +201,11 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
     return true;
 }
 
+uint32_t blkconf_zone_write_granularity(BlockConf *conf)
+{
+    return MAX(conf->logical_block_size, conf->physical_block_size);
+}
+
 bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                                    bool resizable, Error **errp)
 {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index dd69d81532b..6bf1049aea3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -516,11 +516,11 @@ static bool check_zoned_request(VirtIOBlock *s, int64_t offset, int64_t len,
     }
 
     if (append) {
-        if (bs->bl.write_granularity) {
-            if ((offset % bs->bl.write_granularity) != 0) {
-                *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
-                return false;
-            }
+        uint32_t wg_mask = blkconf_zone_write_granularity(&s->conf.conf) - 1;
+
+        if (offset & wg_mask) {
+            *status = VIRTIO_BLK_S_ZONE_UNALIGNED_WP;
+            return false;
         }
 
         index = bdrv_zone_index(bs, offset);
@@ -1276,7 +1276,8 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
                      bs->bl.max_active_zones);
         virtio_stl_p(vdev, &blkcfg.zoned.max_open_zones,
                      bs->bl.max_open_zones);
-        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity, blk_size);
+        virtio_stl_p(vdev, &blkcfg.zoned.write_granularity,
+                     blkconf_zone_write_granularity(conf));
         virtio_stl_p(vdev, &blkcfg.zoned.max_append_sectors,
                      bs->bl.max_append_sectors);
     } else {
-- 
2.56.0


