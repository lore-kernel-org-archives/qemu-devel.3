Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504FBD3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 11:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSZRx-0004zA-A6; Mon, 08 Dec 2025 06:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vSZRl-0004xZ-B0
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 06:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vSZRg-0002zq-KX
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 06:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765193420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eA9M4bUUTwdhIFdwPqMQzMGX27jCw7d5GGHwnwX8YyY=;
 b=e6CAQI8Tq/oETalSMSZ67HccDLgst0msZJcHeHD3pdsd0eq8fxr33aFWqAnhm/mM7v1mR4
 hwx/8haWmmZQs0fPgvUQxppTwZbS51SBEZ8UWP8inF2ATaROJp6cH74f3B5W4gPOPxaxfm
 J1znFogCm+g66cMn29TWVrIpLF6iLS8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-hU7ub04TPl-RvL2dM9YGWg-1; Mon, 08 Dec 2025 06:30:19 -0500
X-MC-Unique: hU7ub04TPl-RvL2dM9YGWg-1
X-Mimecast-MFC-AGG-ID: hU7ub04TPl-RvL2dM9YGWg_1765193418
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47799717212so28254485e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765193417; x=1765798217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eA9M4bUUTwdhIFdwPqMQzMGX27jCw7d5GGHwnwX8YyY=;
 b=ShnD8GivqhiI7mnvnVm2PlJCU9QGde7hit1XtFC8Dm+q49ZtTvHvCoYwO2Ab1RFWFy
 g+lYu5j00UFUmiy2wU1px5vQTPdG0TW/rVdVZPx7jIfhhE8FXEWAA2/yBNChvIr7GkwN
 gb7e2GmKq22epGEfCNM8Yo6xzES0pKUyo4DnCDACGR6Fg+MCPUsI9PDPo+Yj8vcqZYyL
 1aBtcxqfb0iwXjhYg0AKNl8plTu6AnrkGnTzZot0c0uXs2x4Xen7rW8B0bXwUh3wvGNZ
 ditVX+9u/cIMoK/XI3s0/YjZVgfKxSawUu1qAH32qbb/3Sht55G8G7Vygsoamd+pGY4F
 WV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765193417; x=1765798217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA9M4bUUTwdhIFdwPqMQzMGX27jCw7d5GGHwnwX8YyY=;
 b=CRQNRwRy41y3hM4JH8wvWP1SHJUJ2hx1zRKNmO53RPfG3l5v4020iuoQ0QkC0MIOwM
 fiVv574I8hkXTQ4nermRo7D3Ut4Ae69EKhAiRXHy91BwaE4Rn8JOP9zsYMtO+3dzMge0
 NT8HoAgLC3dINA6/U2kbeNLMA0wFW/l0I/hFQdAKyWYxSJ4XjjX7g0e0K7FxDDD6KfM0
 ie2Pnai7ImD1lGrqY/xwMRkmf9JlMhknshnYhT/9mDVIJR0wJjy/E/NQ5/WI977IRXgN
 yExtua1zlwKBo+WPJnskoWrrUVjRjq0o6Jo6DG9vMuLDs2I/kTFyJLuCWLJJuMiw4jad
 zQBQ==
X-Gm-Message-State: AOJu0YzWgaqC4MLgUwyRJPRREP5o1sphOLL6oMOTx8Uac2vYN5VW+Io2
 +At9/TKm0gwVNSi1LEPcjmMrlZwjtRZLT+agdkxNe+HhuO3YDo4yYC10fsHsOTxWRtJd/q9dGlv
 Zpt1+WbQEDzzN5Ezwvy/+P1aLhyyNTFd6GNAN9PWLt3pfKhrE0SssJ7FIRzhhgBFo7qfFH5hqsJ
 0loD1EVSasF7CnrxdGnM67LV9evXinX+7Ee2DaCw==
X-Gm-Gg: ASbGncsxAA76/HNjM9QvmaKXYiLJ9R3+lu81A6hEpLLZ2gRxYHVvPQV91q9AEavzvvN
 wbOuq9kYpi7Q4zNfTCbTMgJZ99QxHQht3L3WzO/ictAXK244o0Q03FihPc/B8tpGra/Gayt06a9
 8yVv39vba11igZa+pDd6N607qNoz0rvtc5ORgNdJI2oxnFejCh391GEptwwyilQ2+1cyR58OUbd
 CwwFKh4okle9ZiCePYPEiZL0FJ674wgLkBoyrn5tzddJ688wjBg7mVnpEkhuvx6yBve/6Gon3wx
 /RV/Jehgd+XtOW1JMLPvOJ7hqKofWjgvOJXpCuoAfsfDZuDi3yHChWuSHTZ3vdpzN+j291g7BTw
 OwEu9Oy++LKhrtUERHtBuX0fw1bHy/bor1FAGRIRCEQL7NASZi9xIOKUZtJ7hwERATNM=
X-Received: by 2002:a05:600c:45c7:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-47939deaa4fmr66842805e9.6.1765193417140; 
 Mon, 08 Dec 2025 03:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXqZkQllJkzoINa5hXPZYfTxm8LtkJrl5GNxExWBVILtcG+HEBJbT0/WOs6LVw9JSozRGJfw==
X-Received: by 2002:a05:600c:45c7:b0:477:3543:3a3b with SMTP id
 5b1f17b1804b1-47939deaa4fmr66842565e9.6.1765193416680; 
 Mon, 08 Dec 2025 03:30:16 -0800 (PST)
Received: from localhost
 (p200300cfd7171fc04a21127b08cb8133.dip0.t-ipconnect.de.
 [2003:cf:d717:1fc0:4a21:127b:8cb:8133])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311ece7asm234908415e9.12.2025.12.08.03.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 03:30:15 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: Always initialize cached vring data
Date: Mon,  8 Dec 2025 12:30:08 +0100
Message-ID: <20251208113008.153249-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vhost_virtqueue_start() can exit early if the descriptor ring address is
0, assuming the virtqueue isn’t ready to start.

In this case, all cached vring information (size, physical address,
pointer) is left as-is.  This is OK at first startup, when that info is
still initialized to 0, but after a reset, it will retain old (outdated)
information.

vhost_virtqueue_start() must make sure these values are (re-)set
properly before exiting.

(When using an IOMMU, these outdated values can stall the device:
vhost_dev_start() deliberately produces an IOMMU miss event for each
used vring.  If used_phys contains an outdated value, the resulting
lookup may fail, forcing the device to be stopped.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/vhost.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a..e654ea468a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1261,7 +1261,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
-    hwaddr s, l, a;
+    hwaddr l;
     int r;
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_file file = {
@@ -1272,8 +1272,17 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
-    a = virtio_queue_get_desc_addr(vdev, idx);
-    if (a == 0) {
+    vq->desc_size = virtio_queue_get_desc_size(vdev, idx);
+    vq->desc_phys = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc = NULL;
+    vq->avail_size = virtio_queue_get_avail_size(vdev, idx);
+    vq->avail_phys = virtio_queue_get_avail_addr(vdev, idx);
+    vq->avail = NULL;
+    vq->used_size = virtio_queue_get_used_size(vdev, idx);
+    vq->used_phys = virtio_queue_get_used_addr(vdev, idx);
+    vq->used = NULL;
+
+    if (vq->desc_phys == 0) {
         /* Queue might not be ready for start */
         return 0;
     }
@@ -1301,24 +1310,23 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         }
     }
 
-    vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = a;
-    vq->desc = vhost_memory_map(dev, a, &l, false);
-    if (!vq->desc || l != s) {
+    l = vq->desc_size;
+    vq->desc = vhost_memory_map(dev, vq->desc_phys, &l, false);
+    if (!vq->desc || l != vq->desc_size) {
         r = -ENOMEM;
         goto fail_alloc_desc;
     }
-    vq->avail_size = s = l = virtio_queue_get_avail_size(vdev, idx);
-    vq->avail_phys = a = virtio_queue_get_avail_addr(vdev, idx);
-    vq->avail = vhost_memory_map(dev, a, &l, false);
-    if (!vq->avail || l != s) {
+
+    l = vq->avail_size;
+    vq->avail = vhost_memory_map(dev, vq->avail_phys, &l, false);
+    if (!vq->avail || l != vq->avail_size) {
         r = -ENOMEM;
         goto fail_alloc_avail;
     }
-    vq->used_size = s = l = virtio_queue_get_used_size(vdev, idx);
-    vq->used_phys = a = virtio_queue_get_used_addr(vdev, idx);
-    vq->used = vhost_memory_map(dev, a, &l, true);
-    if (!vq->used || l != s) {
+
+    l = vq->used_size;
+    vq->used = vhost_memory_map(dev, vq->used_phys, &l, true);
+    if (!vq->used || l != vq->used_size) {
         r = -ENOMEM;
         goto fail_alloc_used;
     }
-- 
2.52.0


