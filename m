Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C042D606A933
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnMDo1Qa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvd-0006Um-67; Mon, 02 Nov 2026 11:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvZ-0006Pe-0t
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvW-0002If-Nk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4o6Ia+extGgv0S3g3mEWvnsE4xEsnqZdv/JYdnri3Vs=;
 b=OnMDo1QaYGImP4wPd1rDRHypwOR3xe5cfEfqilMgxlMtxODmWW1s7W4FGGzsmHi46gmkTr
 brY5YTTerMc+mWS01XoR/tUuZXhVFJaWoWIdbMFPaS1cYTa7Qj+/Yk8XDCWF5bLZK44QSS
 3leQmbi4Vy6ysjrIPiGHbgfbCU2gx40=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-ME4V8SgLNFGdtaObVO4IoA-1; Mon,
 02 Nov 2026 11:30:25 -0500
X-MC-Unique: ME4V8SgLNFGdtaObVO4IoA-1
X-Mimecast-MFC-AGG-ID: ME4V8SgLNFGdtaObVO4IoA_1793637024
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32503195609D; Mon,  2 Nov 2026 16:30:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C4D9D195608B; Mon,  2 Nov 2026 16:30:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/17] virtio-blk: Add support for FUA write requests
Date: Mon,  2 Nov 2026 17:29:49 +0100
Message-ID: <20261102162955.268763-12-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alberto Faria <afaria@redhat.com>

Signed-off-by: Alberto Faria <afaria@redhat.com>
Message-ID: <20261021062257.735757-3-afaria@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
[kwolf: Squashed in definitions from spec missing in Linux headers]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  1 +
 hw/block/virtio-blk.c          | 37 ++++++++++++++++++++++++++++++++++
 hw/core/machine.c              |  1 +
 hw/virtio/virtio-qmp.c         | 10 +++++++++
 4 files changed, 49 insertions(+)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 0070ca6ba9c..26e35351d7d 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -99,6 +99,7 @@ typedef struct MultiReqBuffer {
     VirtIOBlockReq *reqs[VIRTIO_BLK_MAX_MERGE_REQS];
     unsigned int num_reqs;
     bool is_write;
+    bool is_fua;
 } MultiReqBuffer;
 
 typedef struct VirtIOBlkClass {
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index eeeb405127c..9b7c84fda6c 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -38,6 +38,16 @@
 #include "hw/virtio/virtio-blk-common.h"
 #include "qemu/coroutine.h"
 
+/* TODO Remove once the Linux headers have caught up */
+#ifndef VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA
+#define VIRTIO_BLK_F_REQ_FLAGS         18      /* Request flags supported */
+#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA 19      /* FUA flag supported */
+
+#define VIRTIO_BLK_REQ_FLAG_OUT_FUA    0
+
+#define VIRTIO_BLK_OUTDHR_FLAGS(out) out.ioprio
+#endif
+
 /* Internal buffer size limit for zone report */
 #define VIRTIO_BLK_MAX_ZONES_PER_BATCH 4096
 
@@ -219,6 +229,7 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     QEMUIOVector *qiov = &mrb->reqs[start]->qiov;
     int64_t sector_num = mrb->reqs[start]->sector_num;
     bool is_write = mrb->is_write;
+    bool is_fua = mrb->is_fua;
     BdrvRequestFlags flags = 0;
 
     if (num_reqs > 1) {
@@ -255,6 +266,9 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     }
 
     if (is_write) {
+        if (is_fua) {
+            flags |= BDRV_REQ_FUA;
+        }
         blk_aio_pwritev(blk, sector_num << BDRV_SECTOR_BITS, qiov,
                         flags, virtio_blk_rw_complete,
                         mrb->reqs[start]);
@@ -895,6 +909,7 @@ out:
 static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 {
     uint32_t type;
+    uint32_t flags;
     struct iovec *in_iov = req->elem.in_sg;
     struct iovec *out_iov = req->elem.out_sg;
     unsigned in_num = req->elem.in_num;
@@ -931,6 +946,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                               &req->inhdr_undo);
 
     type = virtio_ldl_p(vdev, &req->out.type);
+    flags = virtio_ldl_p(vdev, &VIRTIO_BLK_OUTDHR_FLAGS(req->out));
 
     /* VIRTIO_BLK_T_OUT defines the command direction. VIRTIO_BLK_T_BARRIER
      * is an optional flag. Although a guest should not send this flag if
@@ -939,6 +955,9 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
     case VIRTIO_BLK_T_IN:
     {
         bool is_write = type & VIRTIO_BLK_T_OUT;
+        bool is_fua = is_write &&
+            virtio_vdev_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
+            (flags & (1U << VIRTIO_BLK_REQ_FLAG_OUT_FUA));
         req->sector_num = virtio_ldq_p(vdev, &req->out.sector);
 
         if (is_write) {
@@ -975,6 +994,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
          * changes */
         if (mrb->num_reqs > 0 && (mrb->num_reqs == VIRTIO_BLK_MAX_MERGE_REQS ||
                                   is_write != mrb->is_write ||
+                                  is_fua != mrb->is_fua ||
                                   !s->conf.request_merging)) {
             virtio_blk_submit_multireq(s, mrb);
         }
@@ -982,6 +1002,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         assert(mrb->num_reqs < VIRTIO_BLK_MAX_MERGE_REQS);
         mrb->reqs[mrb->num_reqs++] = req;
         mrb->is_write = is_write;
+        mrb->is_fua = is_fua;
         break;
     }
     case VIRTIO_BLK_T_FLUSH:
@@ -1363,6 +1384,10 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     /* Firstly sync all virtio-blk possible supported features */
     features |= s->host_features;
 
+    if (virtio_has_feature(features, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA)) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_REQ_FLAGS);
+    }
+
     virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
@@ -1388,6 +1413,15 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
+static int virtio_blk_validate_features(VirtIODevice *vdev)
+{
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS)) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
 static int virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
@@ -2043,6 +2077,8 @@ static const Property virtio_blk_properties[] = {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
+    DEFINE_PROP_BIT64("fua", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA, true),
     /*
      * Zero is valid, and says that the device does not support zone append,
      * as a ZBC or ZAC disk does not.
@@ -2066,6 +2102,7 @@ static void virtio_blk_class_init(ObjectClass *klass, const void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->validate_features = virtio_blk_validate_features;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4da24f014aa..d8716e37894 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pcie-root-port", "speed", "16" },
+    { "virtio-blk-device", "fua", "off" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 8d190c4c70d..af2f4b73dce 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -33,6 +33,12 @@
 #include "standard-headers/linux/virtio_vsock.h"
 #include "standard-headers/linux/virtio_gpio.h"
 
+/* TODO Remove once the Linux headers have caught up */
+#ifndef VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA
+#define VIRTIO_BLK_F_REQ_FLAGS         18      /* Request flags supported */
+#define VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA 19      /* FUA flag supported */
+#endif
+
 #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
     { .virtio_bit = name, .feature_desc = desc }
 
@@ -171,6 +177,10 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_REQ_FLAGS, \
+            "VIRTIO_BLK_F_REQ_FLAGS: Request flags supported"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA, \
+            "VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA: FUA flag for OUT requests"),
     FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
             "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
-- 
2.56.0


