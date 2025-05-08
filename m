Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AE2C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3zu-0005yD-CC; Thu, 08 May 2025 12:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD3zs-0005xY-E3
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uD3zq-0008ES-Ew
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746721277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Qq3YKdZsc9sry+zhS63m6B1y/hN+kV7Be0zcTtUB5A=;
 b=Hwi/gYyjHyl6wpK8ntoSKucdIi8vGbbODPNT7z+lRiyPpjxJqyW4Vs3VPHcXIsyJWhsuPz
 SnhCAEG/Q/TnSBgNYGEAYDLIO43wglEHIE2JuGov3WUsqTNU0m47BT2hsNyakj7bkl5+Ci
 CUjxuYO276jWPaR+NHrby05SrhqdDbk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-dS3CCbLiNMOohBuv7AJ8bg-1; Thu,
 08 May 2025 12:21:12 -0400
X-MC-Unique: dS3CCbLiNMOohBuv7AJ8bg-1
X-Mimecast-MFC-AGG-ID: dS3CCbLiNMOohBuv7AJ8bg_1746721269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F861800446; Thu,  8 May 2025 16:21:09 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.225.1])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98537180049D; Thu,  8 May 2025 16:21:02 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael@enfabrica.net>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Alberto Faria <afaria@redhat.com>
Subject: [RFC v2 2/4] virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Date: Thu,  8 May 2025 17:20:42 +0100
Message-ID: <20250508162044.857655-3-afaria@redhat.com>
In-Reply-To: <20250508162044.857655-1-afaria@redhat.com>
References: <20250508162044.857655-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 block/export/virtio-blk-handler.c |  7 ++--
 hw/block/virtio-blk.c             | 41 +++++++++++-----------
 hw/core/machine.c                 |  4 ++-
 hw/virtio/virtio-qmp.c            |  2 ++
 include/hw/virtio/virtio-blk.h    |  1 +
 tests/qtest/virtio-blk-test.c     | 56 +++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 23 deletions(-)

diff --git a/block/export/virtio-blk-handler.c b/block/export/virtio-blk-handler.c
index bc1cec67570..db40529fa68 100644
--- a/block/export/virtio-blk-handler.c
+++ b/block/export/virtio-blk-handler.c
@@ -169,11 +169,13 @@ int coroutine_fn virtio_blk_process_req(VirtioBlkHandler *handler,
     type = le32_to_cpu(out.type);
     switch (type & ~VIRTIO_BLK_T_BARRIER) {
     case VIRTIO_BLK_T_IN:
-    case VIRTIO_BLK_T_OUT: {
+    case VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_OUT_FUA: {
         QEMUIOVector qiov;
         int64_t offset;
         ssize_t ret = 0;
         bool is_write = type & VIRTIO_BLK_T_OUT;
+        bool is_fua = type == VIRTIO_BLK_T_OUT_FUA;
         int64_t sector_num = le64_to_cpu(out.sector);
 
         if (is_write && !handler->writable) {
@@ -197,7 +199,8 @@ int coroutine_fn virtio_blk_process_req(VirtioBlkHandler *handler,
         offset = sector_num << VIRTIO_BLK_SECTOR_BITS;
 
         if (is_write) {
-            ret = blk_co_pwritev(blk, offset, qiov.size, &qiov, 0);
+            ret = blk_co_pwritev(blk, offset, qiov.size, &qiov,
+                                 is_fua ? BDRV_REQ_FUA : 0);
         } else {
             ret = blk_co_preadv(blk, offset, qiov.size, &qiov, 0);
         }
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index b54d01d3a24..48eb468f3bd 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -220,6 +220,7 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     QEMUIOVector *qiov = &mrb->reqs[start]->qiov;
     int64_t sector_num = mrb->reqs[start]->sector_num;
     bool is_write = mrb->is_write;
+    bool is_fua = mrb->is_fua;
     BdrvRequestFlags flags = 0;
 
     if (num_reqs > 1) {
@@ -256,6 +257,9 @@ static inline void submit_requests(VirtIOBlock *s, MultiReqBuffer *mrb,
     }
 
     if (is_write) {
+        if (is_fua) {
+            flags |= BDRV_REQ_FUA;
+        }
         blk_aio_pwritev(blk, sector_num << BDRV_SECTOR_BITS, qiov,
                         flags, virtio_blk_rw_complete,
                         mrb->reqs[start]);
@@ -828,13 +832,16 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
 
     type = virtio_ldl_p(vdev, &req->out.type);
 
-    /* VIRTIO_BLK_T_OUT defines the command direction. VIRTIO_BLK_T_BARRIER
-     * is an optional flag. Although a guest should not send this flag if
-     * not negotiated we ignored it in the past. So keep ignoring it. */
-    switch (type & ~(VIRTIO_BLK_T_OUT | VIRTIO_BLK_T_BARRIER)) {
+    /* VIRTIO_BLK_T_BARRIER is an optional flag. Although a guest should not
+     * send this flag if not negotiated we ignored it in the past. So keep
+     * ignoring it. */
+    switch (type & ~VIRTIO_BLK_T_BARRIER) {
     case VIRTIO_BLK_T_IN:
+    case VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_OUT_FUA:
     {
         bool is_write = type & VIRTIO_BLK_T_OUT;
+        bool is_fua = (type & ~VIRTIO_BLK_T_BARRIER) == VIRTIO_BLK_T_OUT_FUA;
         req->sector_num = virtio_ldq_p(vdev, &req->out.sector);
 
         if (is_write) {
@@ -858,10 +865,10 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         block_acct_start(blk_get_stats(s->blk), &req->acct, req->qiov.size,
                          is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ);
 
-        /* merge would exceed maximum number of requests or IO direction
-         * changes */
+        /* merge would exceed maximum number of requests or type changes */
         if (mrb->num_reqs > 0 && (mrb->num_reqs == VIRTIO_BLK_MAX_MERGE_REQS ||
                                   is_write != mrb->is_write ||
+                                  is_fua != mrb->is_fua ||
                                   !s->conf.request_merging)) {
             virtio_blk_submit_multireq(s, mrb);
         }
@@ -869,6 +876,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         assert(mrb->num_reqs < VIRTIO_BLK_MAX_MERGE_REQS);
         mrb->reqs[mrb->num_reqs++] = req;
         mrb->is_write = is_write;
+        mrb->is_fua = is_fua;
         break;
     }
     case VIRTIO_BLK_T_FLUSH:
@@ -910,7 +918,7 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
         g_free(req);
         break;
     }
-    case VIRTIO_BLK_T_ZONE_APPEND & ~VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_ZONE_APPEND:
         /*
          * Passing out_iov/out_num and in_iov/in_num is not safe
          * to access req->elem.out_sg directly because it may be
@@ -918,13 +926,8 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
          */
         virtio_blk_handle_zone_append(req, out_iov, in_iov, out_num, in_num);
         break;
-    /*
-     * VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES are defined with
-     * VIRTIO_BLK_T_OUT flag set. We masked this flag in the switch statement,
-     * so we must mask it for these requests, then we will check if it is set.
-     */
-    case VIRTIO_BLK_T_DISCARD & ~VIRTIO_BLK_T_OUT:
-    case VIRTIO_BLK_T_WRITE_ZEROES & ~VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_DISCARD:
+    case VIRTIO_BLK_T_WRITE_ZEROES:
     {
         struct virtio_blk_discard_write_zeroes dwz_hdr;
         size_t out_len = iov_size(out_iov, out_num);
@@ -932,12 +935,8 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
                                VIRTIO_BLK_T_WRITE_ZEROES;
         uint8_t err_status;
 
-        /*
-         * Unsupported if VIRTIO_BLK_T_OUT is not set or the request contains
-         * more than one segment.
-         */
-        if (unlikely(!(type & VIRTIO_BLK_T_OUT) ||
-                     out_len > sizeof(dwz_hdr))) {
+        /* Unsupported if the request contains more than one segment. */
+        if (unlikely(out_len > sizeof(dwz_hdr))) {
             virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
             g_free(req);
             return 0;
@@ -1882,6 +1881,8 @@ static const Property virtio_blk_properties[] = {
                        conf.max_discard_sectors, BDRV_REQUEST_MAX_SECTORS),
     DEFINE_PROP_UINT32("max-write-zeroes-sectors", VirtIOBlock,
                        conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
+    DEFINE_PROP_BIT64("fua-write", VirtIOBlock, host_features,
+                      VIRTIO_BLK_F_OUT_FUA, true),
     DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
                      conf.x_enable_wce_if_config_wce, true),
 };
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed01798d37c..8439b094904 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,7 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_10_0[] = {};
+GlobalProperty hw_compat_10_0[] = {
+    { "virtio-blk-device", "fua-write", "false" },
+};
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
 GlobalProperty hw_compat_9_2[] = {
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3b6377cf0d2..9cbdd543623 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -173,6 +173,8 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
             "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
     FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
             "VIRTIO_BLK_F_ZONED: Zoned block devices"),
+    FEATURE_ENTRY(VIRTIO_BLK_F_OUT_FUA, \
+            "VIRTIO_BLK_F_OUT_FUA: FUA write command supported"),
 #ifndef VIRTIO_BLK_NO_LEGACY
     FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
             "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 3d8dee7ec15..916df26b6f0 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -98,6 +98,7 @@ typedef struct MultiReqBuffer {
     VirtIOBlockReq *reqs[VIRTIO_BLK_MAX_MERGE_REQS];
     unsigned int num_reqs;
     bool is_write;
+    bool is_fua;
 } MultiReqBuffer;
 
 typedef struct VirtIOBlkClass {
diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 98c906ebb4a..a90838b8912 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -88,6 +88,7 @@ static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,
     switch (req->type) {
     case VIRTIO_BLK_T_IN:
     case VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_OUT_FUA:
         g_assert_cmpuint(data_size % 512, ==, 0);
         break;
     case VIRTIO_BLK_T_DISCARD:
@@ -280,6 +281,61 @@ static QVirtQueue *test_basic(QVirtioDevice *dev, QGuestAllocator *alloc)
         guest_free(alloc, req_addr);
     }
 
+    if (features & (1u << VIRTIO_BLK_F_OUT_FUA)) {
+        /* FUA write and read with 3 descriptor layout */
+        /* FUA write request */
+        req.type = VIRTIO_BLK_T_OUT_FUA;
+        req.ioprio = 1;
+        req.sector = 0;
+        req.data = g_malloc0(512);
+        strcpy(req.data, "test");
+
+        req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                            QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 528);
+        g_assert_cmpint(status, ==, 0);
+
+        guest_free(alloc, req_addr);
+
+        /* Read request */
+        req.type = VIRTIO_BLK_T_IN;
+        req.ioprio = 1;
+        req.sector = 0;
+        req.data = g_malloc0(512);
+
+        req_addr = virtio_blk_request(alloc, dev, &req, 512);
+
+        g_free(req.data);
+
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+
+        qvirtqueue_kick(qts, dev, vq, free_head);
+
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                            QVIRTIO_BLK_TIMEOUT_US);
+        status = readb(req_addr + 528);
+        g_assert_cmpint(status, ==, 0);
+
+        data = g_malloc0(512);
+        memread(req_addr + 16, data, 512);
+        g_assert_cmpstr(data, ==, "test");
+        g_free(data);
+
+        guest_free(alloc, req_addr);
+    }
+
     if (features & (1u << VIRTIO_F_ANY_LAYOUT)) {
         /* Write and read with 2 descriptor layout */
         /* Write request */
-- 
2.49.0


