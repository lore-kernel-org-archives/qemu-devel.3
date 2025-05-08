Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175DDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCp4l-0006rb-8R; Wed, 07 May 2025 20:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4d-0006ZZ-IR
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4b-0007fi-1M
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746663912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWWczabklCDPqPQDUKNXbgGSWHvxgiNMVOXbqlkWiII=;
 b=E+tME/BQT+yZtVirtOLX1BZT2NCTKgbiwLK/VAei2oO+5Vv1roFu63ihW22GprSxTpPAg2
 pFJ+tW53VUUe10qmgGtECQRzeio8BReV+Y4afe9xvjcTQDfURWqZZdIXmWr5ApFdg5R1E0
 xb7QvxSf2k6hSR3IrwzPA2GtEJTKOD8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-zfdTCk1gN7uxUhAFMTz39w-1; Wed,
 07 May 2025 20:25:09 -0400
X-MC-Unique: zfdTCk1gN7uxUhAFMTz39w-1
X-Mimecast-MFC-AGG-ID: zfdTCk1gN7uxUhAFMTz39w_1746663907
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28F721800446; Thu,  8 May 2025 00:25:07 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E14319560A7; Thu,  8 May 2025 00:24:58 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Raphael Norwitz <raphael@enfabrica.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Xie Yongji <xieyongji@bytedance.com>, Yanan Wang <wangyanan55@huawei.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [RFC 2/4] virtio-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Date: Thu,  8 May 2025 01:24:38 +0100
Message-ID: <20250508002440.423776-3-afaria@redhat.com>
In-Reply-To: <20250508002440.423776-1-afaria@redhat.com>
References: <20250508002440.423776-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/block/virtio-blk.c             |  2 ++
 hw/core/machine.c                 |  4 ++-
 hw/virtio/virtio-qmp.c            |  2 ++
 tests/qtest/virtio-blk-test.c     | 56 +++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 3 deletions(-)

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
index b54d01d3a24..611de0fa860 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1882,6 +1882,8 @@ static const Property virtio_blk_properties[] = {
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


