Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9y+pCxs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPkV-0003Fn-I2; Wed, 21 Oct 2026 02:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1xJPkQ-0003F3-Mw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1xJPkO-0003h1-C6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792563861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ITQQf4+9OUpXt15a1JuTTXOMTcTV+MZs10sDbYWERXw=;
 b=I9y+pCxsHCPKnXTvmcNFHAwY6eUbUrrb/nOsIj3Z6OqMsBZVk4LQBPA+jyUy+g28Kl3IoY
 ISPn1Pftj+4EZPRSMqBpAbMzPJS9zNKruihq6pavUGZlBQ9qAltnxiW7XHL7IzCUYJtNm2
 PGjQmXsam23J9iTnEFYB+rydhETyOvY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286--a9iRdhpMsOWxIteUR4szA-1; Wed,
 21 Oct 2026 02:23:09 -0400
X-MC-Unique: -a9iRdhpMsOWxIteUR4szA-1
X-Mimecast-MFC-AGG-ID: -a9iRdhpMsOWxIteUR4szA_1792563788
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 674511800611; Wed, 21 Oct 2026 06:23:08 +0000 (UTC)
Received: from desktop (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C81821800446; Wed, 21 Oct 2026 06:23:05 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH 2/2] virtio-blk: Add support for FUA write requests
Date: Wed, 21 Oct 2026 07:22:57 +0100
Message-ID: <20261021062257.735757-3-afaria@redhat.com>
In-Reply-To: <20261021062257.735757-1-afaria@redhat.com>
References: <20261021062257.735757-1-afaria@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 hw/block/virtio-blk.c          | 27 +++++++++++++++++++++++++++
 hw/core/machine.c              |  1 +
 hw/virtio/virtio-qmp.c         |  4 ++++
 include/hw/virtio/virtio-blk.h |  1 +
 4 files changed, 33 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 61c341ce2c..3e01e043bd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -219,6 +219,7 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     QEMUIOVector *qiov = &mrb->reqs[start]->qiov;
     int64_t sector_num = mrb->reqs[start]->sector_num;
     bool is_write = mrb->is_write;
+    bool is_fua = mrb->is_fua;
     BdrvRequestFlags flags = 0;
 
     if (num_reqs > 1) {
@@ -255,6 +256,9 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     }
 
     if (is_write) {
+        if (is_fua) {
+            flags |= BDRV_REQ_FUA;
+        }
         blk_aio_pwritev(blk, sector_num << BDRV_SECTOR_BITS, qiov,
                         flags, virtio_blk_rw_complete,
                         mrb->reqs[start]);
@@ -829,6 +833,7 @@ out:
 static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 {
     uint32_t type;
+    uint32_t flags;
     struct iovec *in_iov = req->elem.in_sg;
     struct iovec *out_iov = req->elem.out_sg;
     unsigned in_num = req->elem.in_num;
@@ -865,6 +870,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                               &req->inhdr_undo);
 
     type = virtio_ldl_p(vdev, &req->out.type);
+    flags = virtio_ldl_p(vdev, &req->out.flags);
 
     /* VIRTIO_BLK_T_OUT defines the command direction. VIRTIO_BLK_T_BARRIER
      * is an optional flag. Although a guest should not send this flag if
@@ -873,6 +879,9 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
     case VIRTIO_BLK_T_IN:
     {
         bool is_write = type & VIRTIO_BLK_T_OUT;
+        bool is_fua = is_write &&
+            virtio_vdev_has_feature(vdev, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA) &&
+            (flags & (1U << VIRTIO_BLK_REQ_FLAG_OUT_FUA));
         req->sector_num = virtio_ldq_p(vdev, &req->out.sector);
 
         if (is_write) {
@@ -900,6 +909,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
          * changes */
         if (mrb->num_reqs > 0 && (mrb->num_reqs == VIRTIO_BLK_MAX_MERGE_REQS ||
                                   is_write != mrb->is_write ||
+                                  is_fua != mrb->is_fua ||
                                   !s->conf.request_merging)) {
             virtio_blk_submit_multireq(s, mrb);
         }
@@ -907,6 +917,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         assert(mrb->num_reqs < VIRTIO_BLK_MAX_MERGE_REQS);
         mrb->reqs[mrb->num_reqs++] = req;
         mrb->is_write = is_write;
+        mrb->is_fua = is_fua;
         break;
     }
     case VIRTIO_BLK_T_FLUSH:
@@ -1283,6 +1294,10 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
     /* Firstly sync all virtio-blk possible supported features */
     features |= s->host_features;
 
+    if (virtio_has_feature(features, VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA)) {
+        virtio_add_feature(&features, VIRTIO_BLK_F_REQ_FLAGS);
+    }
+
     virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
@@ -1308,6 +1323,15 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
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
@@ -1925,6 +1949,8 @@ static const Property virtio_blk_properties[] = {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
+    DEFINE_PROP_BIT64("fua", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA, true),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
 };
@@ -1942,6 +1968,7 @@ static void virtio_blk_class_init(ObjectClass *klass, const void *data)
     vdc->get_config = virtio_blk_update_config;
     vdc->set_config = virtio_blk_set_config;
     vdc->get_features = virtio_blk_get_features;
+    vdc->validate_features = virtio_blk_validate_features;
     vdc->set_status = virtio_blk_set_status;
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d9ac4b419a..7fc1853dab 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "virtio-blk-device", "fua", "off" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 5aaeebdd96..4aaab650c6 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -171,6 +171,10 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
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
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 3d8dee7ec1..916df26b6f 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -98,6 +98,7 @@ typedef struct MultiReqBuffer {
     VirtIOBlockReq *reqs[VIRTIO_BLK_MAX_MERGE_REQS];
     unsigned int num_reqs;
     bool is_write;
+    bool is_fua;
 } MultiReqBuffer;
 
 typedef struct VirtIOBlkClass {
-- 
2.56.0


