Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C78C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXpu7-00078u-6B; Wed, 07 Feb 2024 16:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu5-00076b-Fv
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rXpu3-0007df-Ss
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 16:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707342983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BQqB4BeiIyhQrJc8xaOLSyDo++SAOO6jR1bmPek5CY=;
 b=iycHx7EaiulMzmISBWS8GB1+zvZamV75R8NpH0E8E2lB3P+4tafnVqKVw6ilwVwRobkx3Z
 vVKjZtI4kgG0AW5kMlaI9kAUoCtlCTiuiCqX9C/8r7j1Nsh7pFa4MPFK+dcZ9vulpyZXx5
 bfg2aQ0UhdGeut/tHV8cMoQvYqR5H9Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-b2GkzHU4P62f4D1f6XwLGA-1; Wed, 07 Feb 2024 16:56:19 -0500
X-MC-Unique: b2GkzHU4P62f4D1f6XwLGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A35A985A58C;
 Wed,  7 Feb 2024 21:56:19 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 172EC492BC6;
 Wed,  7 Feb 2024 21:56:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/16] virtio-blk: do not use C99 mixed declarations
Date: Wed,  7 Feb 2024 22:56:00 +0100
Message-ID: <20240207215606.206038-11-kwolf@redhat.com>
In-Reply-To: <20240207215606.206038-1-kwolf@redhat.com>
References: <20240207215606.206038-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

QEMU's coding style generally forbids C99 mixed declarations.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240206140410.65650-1-stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/virtio-blk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 31212506ca..bda5c117d4 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -661,6 +661,9 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
     int64_t zrp_size, n, j = 0;
     int64_t nz = data->zone_report_data.nr_zones;
     int8_t err_status = VIRTIO_BLK_S_OK;
+    struct virtio_blk_zone_report zrp_hdr = (struct virtio_blk_zone_report) {
+        .nr_zones = cpu_to_le64(nz),
+    };
 
     trace_virtio_blk_zone_report_complete(vdev, req, nz, ret);
     if (ret) {
@@ -668,9 +671,6 @@ static void virtio_blk_zone_report_complete(void *opaque, int ret)
         goto out;
     }
 
-    struct virtio_blk_zone_report zrp_hdr = (struct virtio_blk_zone_report) {
-        .nr_zones = cpu_to_le64(nz),
-    };
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
@@ -1961,6 +1963,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOBlock *s = VIRTIO_BLK(dev);
     VirtIOBlkConf *conf = &s->conf;
+    BlockDriverState *bs;
     Error *err = NULL;
     unsigned i;
 
@@ -2006,7 +2009,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    BlockDriverState *bs = blk_bs(conf->conf.blk);
+    bs = blk_bs(conf->conf.blk);
     if (bs->bl.zoned != BLK_Z_NONE) {
         virtio_add_feature(&s->host_features, VIRTIO_BLK_F_ZONED);
         if (bs->bl.zoned == BLK_Z_HM) {
-- 
2.43.0


