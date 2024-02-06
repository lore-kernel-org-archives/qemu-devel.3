Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F257C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXM4Q-0006It-9E; Tue, 06 Feb 2024 09:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXM4O-0006Ih-EF
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXM4H-0007xO-UX
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707228297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DLnm9359RtEaFIj/Q32RaRZJDSzgP8Uz5xRtAXHvkSo=;
 b=JEN0y7P5Y0G4BDjbTlLEj+VmnLkargkAD6VlhPt5cfET1PZaOKGGU3BXCX7fPWq8x2KFJ9
 Kaoiz5YwjDmsyuPHkHwDcWUrJ4+ZGwkX32RAqDHun+gHCo6BsVzu638B1rDwoDcIEiQI73
 IrJ9F2DE/2TDMc1KUzptQgxrvnwk/4Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-iFVumHB-O4SL0mtAHdPc4A-1; Tue,
 06 Feb 2024 09:04:56 -0500
X-MC-Unique: iFVumHB-O4SL0mtAHdPc4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A391D3CBDF65;
 Tue,  6 Feb 2024 14:04:55 +0000 (UTC)
Received: from localhost (unknown [10.39.195.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DF1D2166B31;
 Tue,  6 Feb 2024 14:04:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] virtio-blk: do not use C99 mixed declarations
Date: Tue,  6 Feb 2024 09:04:09 -0500
Message-ID: <20240206140410.65650-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QEMU's coding style generally forbids C99 mixed declarations.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..f6009cd9b3 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -661,16 +661,16 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
     int64_t zrp_size, n, j = 0;
     int64_t nz = data->zone_report_data.nr_zones;
     int8_t err_status = VIRTIO_BLK_S_OK;
-
-    trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
-    if (ret) {
-        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
-        goto out;
-    }
-
     struct virtio_blk_zone_report zrp_hdr = (struct virtio_blk_zone_report) {
         .nr_zones = cpu_to_le64(nz),
     };
+
+    trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
+    if (ret) {
+        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        goto out;
+    }
+
     zrp_size = sizeof(struct virtio_blk_zone_report)
                + sizeof(struct virtio_blk_zone_descriptor) * nz;
     n = iov_from_buf(in_iov, in_num, 0, &zrp_hdr, sizeof(zrp_hdr));
@@ -898,13 +898,14 @@ static int virtio_blk_handle_zone_append(VirtIOBlockReq *req,
 
     int64_t offset = virtio_ldq_p(vdev, &req->out.sector) << BDRV_SECTOR_BITS;
     int64_t len = iov_size(out_iov, out_num);
+    ZoneCmdData *data;
 
     trace_virtio_blk_handle_zone_append(vdev, req, offset >> BDRV_SECTOR_BITS);
     if (!check_zoned_request(s, offset, len, true, &err_status)) {
         goto out;
     }
 
-    ZoneCmdData *data = g_malloc(sizeof(ZoneCmdData));
+    data = g_malloc(sizeof(ZoneCmdData));
     data->req = req;
     data->in_iov = in_iov;
     data->in_num = in_num;
@@ -1191,14 +1192,15 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
 {
     VirtIOBlock *s = opaque;
     uint16_t num_queues = s->conf.num_queues;
+    g_autofree VirtIOBlockReq **vq_rq = NULL;
+    VirtIOBlockReq *rq;
 
     if (!running) {
         return;
     }
 
     /* Split the device-wide s->rq request list into per-vq request lists */
-    g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
-    VirtIOBlockReq *rq;
+    vq_rq = g_new0(VirtIOBlockReq *, num_queues);
 
     WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
         rq = s->rq;
@@ -1924,6 +1926,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
+    BlockDriverState *bs;
     Error *err = NULL;
     unsigned i;
 
@@ -1969,7 +1972,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    BlockDriverState *bs = blk_bs(conf->conf.blk);
+    bs = blk_bs(conf->conf.blk);
     if (bs->bl.zoned != BLK_Z_NONE) {
         virtio_add_feature(&s->host_features, VIRTIO_BLK_F_ZONED);
         if (bs->bl.zoned == BLK_Z_HM) {
-- 
2.43.0


