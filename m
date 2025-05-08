Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6218FC3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCp4p-0006zm-Im; Wed, 07 May 2025 20:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4l-0006rd-5Q
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uCp4i-0007gO-Gs
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746663919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQdRYdv1hJr4DYNXk5+/7v7Oi6dfRnQTQtwpKu8K5hg=;
 b=ddV5vsoFdze0ck6W6TgtMH3Lgyd7asML2GaxBJiYMLaEwYPxSLOd6HM2U8km+g4UOPh4Cy
 6vL0b9H5lBQ87bTkxmD2yEuGsz0KbA0+eNaUH4R9jESBKVWtQJuEtv7slWB9O/uOFvYfFH
 eLtS20UWHIcogESfT1GgTs8qBqKyoHw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-_LMn4GuoOOuKFYJuEFVSpg-1; Wed,
 07 May 2025 20:25:16 -0400
X-MC-Unique: _LMn4GuoOOuKFYJuEFVSpg-1
X-Mimecast-MFC-AGG-ID: _LMn4GuoOOuKFYJuEFVSpg_1746663915
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7EDB1955DC5; Thu,  8 May 2025 00:25:14 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C589819560A7; Thu,  8 May 2025 00:25:07 +0000 (UTC)
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
Subject: [RFC 3/4] vhost-user-blk: Add VIRTIO_BLK_T_OUT_FUA command support
Date: Thu,  8 May 2025 01:24:39 +0100
Message-ID: <20250508002440.423776-4-afaria@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 block/export/vhost-user-blk-server.c    |  1 +
 contrib/vhost-user-blk/vhost-user-blk.c | 16 +++++--
 hw/block/vhost-user-blk.c               |  3 ++
 hw/core/machine.c                       |  1 +
 tests/qtest/vhost-user-blk-test.c       | 56 +++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index d9d2014d9b7..fad9560b219 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -125,6 +125,7 @@ static uint64_t vu_blk_get_features(VuDev *dev)
                1ull << VIRTIO_BLK_F_FLUSH |
                1ull << VIRTIO_BLK_F_DISCARD |
                1ull << VIRTIO_BLK_F_WRITE_ZEROES |
+               1ull << VIRTIO_BLK_F_OUT_FUA |
                1ull << VIRTIO_BLK_F_CONFIG_WCE |
                1ull << VIRTIO_BLK_F_MQ |
                1ull << VIRTIO_F_VERSION_1 |
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 6cc18a1c04f..8d732bbe468 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -154,7 +154,7 @@ vub_readv(VubReq *req, struct iovec *iov, uint32_t iovcnt)
 }
 
 static ssize_t
-vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt)
+vub_writev(VubReq *req, struct iovec *iov, uint32_t iovcnt, int flags)
 {
     VubDev *vdev_blk = req->vdev_blk;
     ssize_t rc;
@@ -271,12 +271,19 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
     type = le32_to_cpu(req->out->type);
     switch (type & ~VIRTIO_BLK_T_BARRIER) {
     case VIRTIO_BLK_T_IN:
-    case VIRTIO_BLK_T_OUT: {
+    case VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_OUT_FUA: {
         ssize_t ret = 0;
         bool is_write = type & VIRTIO_BLK_T_OUT;
+        int flags = 0;
         req->sector_num = le64_to_cpu(req->out->sector);
         if (is_write) {
-            ret  = vub_writev(req, &elem->out_sg[1], out_num);
+            #ifdef RWF_SYNC
+            if (type == VIRTIO_BLK_T_OUT_FUA) {
+                flags |= RWF_SYNC;
+            }
+            #endif
+            ret  = vub_writev(req, &elem->out_sg[1], out_num, flags);
         } else {
             ret = vub_readv(req, &elem->in_sg[0], in_num);
         }
@@ -379,6 +386,9 @@ vub_get_features(VuDev *dev)
                1ull << VIRTIO_BLK_F_DISCARD |
                1ull << VIRTIO_BLK_F_WRITE_ZEROES |
                #endif
+               #ifdef RWF_SYNC
+               1ull << VIRTIO_BLK_F_OUT_FUA |
+               #endif
                1ull << VIRTIO_BLK_F_CONFIG_WCE;
 
     if (vdev_blk->enable_ro) {
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 4bb5ed299e7..988be625969 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -44,6 +44,7 @@ static const int user_feature_bits[] = {
     VIRTIO_BLK_F_CONFIG_WCE,
     VIRTIO_BLK_F_DISCARD,
     VIRTIO_BLK_F_WRITE_ZEROES,
+    VIRTIO_BLK_F_OUT_FUA,
     VIRTIO_F_VERSION_1,
     VIRTIO_RING_F_INDIRECT_DESC,
     VIRTIO_RING_F_EVENT_IDX,
@@ -581,6 +582,8 @@ static const Property vhost_user_blk_properties[] = {
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BIT64("write-zeroes", VHostUserBlk, parent_obj.host_features,
                       VIRTIO_BLK_F_WRITE_ZEROES, true),
+    DEFINE_PROP_BIT64("fua-write", VHostUserBlk, parent_obj.host_features,
+                      VIRTIO_BLK_F_OUT_FUA, true),
 };
 
 static void vhost_user_blk_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8439b094904..bcf4f3423cb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@
 
 GlobalProperty hw_compat_10_0[] = {
     { "virtio-blk-device", "fua-write", "false" },
+    { "vhost-user-blk", "fua-write", "false" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index ea90d41232e..4c68702e0b0 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -72,6 +72,7 @@ static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,
     switch (req->type) {
     case VIRTIO_BLK_T_IN:
     case VIRTIO_BLK_T_OUT:
+    case VIRTIO_BLK_T_OUT_FUA:
         g_assert_cmpuint(data_size % 512, ==, 0);
         break;
     case VIRTIO_BLK_T_DISCARD:
@@ -389,6 +390,61 @@ static QVirtQueue *test_basic(QVirtioDevice *dev, QGuestAllocator *alloc)
                                           VIRTIO_BLK_T_DISCARD);
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
+        qtest_memread(qts, req_addr + 16, data, 512);
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


