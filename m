Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D722C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnO9C-0004tK-Kz; Fri, 24 Jul 2026 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnO95-0004sA-DU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnO93-0007EP-6h
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 18:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784931207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=u1Cm+qfOAAHo9M4KiTd71sdAhsgdzF9PbNatD46kC0Q=;
 b=fyNF3HnWUI7zXYeW4LExWvejwK+gjy6OqODs448nLKR0k2pPPpuQJfZHqrAGzhV5Nbv+d0
 a/QxtzowOOMYDgmV2u4wAnLiIbKXwC219Jx/WoFmioav7TKewrPi89jXEuJPyPi6w1VOsY
 vC3y1/XVBaAdhWqeDLcTrie42RHOuPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-iNV0yUtpNNChHT5S4ULzZA-1; Fri, 24 Jul 2026 18:13:26 -0400
X-MC-Unique: iNV0yUtpNNChHT5S4ULzZA-1
X-Mimecast-MFC-AGG-ID: iNV0yUtpNNChHT5S4ULzZA_1784931205
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso5266705e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784931205; x=1785536005; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u1Cm+qfOAAHo9M4KiTd71sdAhsgdzF9PbNatD46kC0Q=;
 b=AGodGJ2ygRAUqNXbqh6p4N5TozTjF5fUrDvqZPsVM9eQh4HCjrxb6cWEC4PjL7zB/P
 4KjlkYtDbkJYOKJsLFkCesikZ/dCTkLufBj6iAupn4V1CjNygJMZtFjHhKIif3S0hgFg
 4JttbDavmXI/YWId9lSoNl+of6drsDr3NnkwxhLOAi4ichE1uCvLkq5pm+KpXMgJH9y3
 f0T3JV20oO1HBQfPJ2M5Fw3v5UmvBZGvm/gWJAec0L4Zf5/m/sswd8zcQJHyTIMiySbv
 ZjmvUkS8FB1f/4lKxg5IT36WG+k88f5iJxv9GYS0+Ij+WPO5i/cRi8E5jTsK6I0K9APP
 lqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784931205; x=1785536005;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u1Cm+qfOAAHo9M4KiTd71sdAhsgdzF9PbNatD46kC0Q=;
 b=PNRPOpNo4bgfdVgE1yYN5gK9PcijNMsGMmylVkL+TSBVtTc3Pgb7LiFNf06JwIYSqC
 adJhKoBbX9wT2XOLz6j7Lo0gehGVrMfGp3DZJCa+HvI3D754WuEb5aH7aNRDJH389dWO
 M2tWn6yqC1cmdZrTQqZXf47nevrKW3avBEicaTZ7OBNV38c8MwlemXCJMjLVYYjscSz5
 aFe+4Busy2VnJucwx/QQ9ET5vo5f+h+vRGbY7BDgCme/PNEpzVPZ4ZnZwYg/biJ3Lvjs
 fwQ2HT+YCJSr+QnFVeKjwWwP/SIfDDeXfcRCwbAcB6Lr8m0Tw8n0yVahlCK2MImDfnLh
 keRQ==
X-Gm-Message-State: AOJu0YyJWqVFki9PfsPDj2t10Z0m+g0o+prylq6lgjlQ4UiwlRURv0W7
 a9w5RNbFwKnQneSWXD0Un9lZr96bJTdvLHrohD8snwpNDnA4wRDrSe3bxBCaFMVBk+EwloJWhxt
 gP8obMAWAntQbmkN0OMNrQQ0NOATpajBnpV6ffCn+RCBJhOlj0F+GRl3AhvXaT5Wp+oW1ipCjVc
 d6zZw64ZLZwj9aw5SFk2Jw+Sw1lQoqF082jw==
X-Gm-Gg: AR+sD11Nb/FJMURZTxF985KpIRopmRJ5LQZx7lRh60jy5fOnwuJODS3uBlK9WUs9oWv
 qFCW3HExg1v33+YsAqZfiIBzkFoeLeGGIW2t2I0hyfqUs/WjU4vHbxqmnnyVhP9aYy8CuHmB5VM
 jWwSMCtxIWki/UE+cBt5qg5oYxobDXa8KfotmB/C1G86tx3paubeKeC6WQO3JreFppyLgsySw/3
 wgIr5Rm9B+qzrOrsImevIMVNmyliqhlJYsnO+7nGjJziw4RXaYuhLGk+oBTq283qa+EsV/Qoso4
 revjZ1cn+4E6wsAfz7w2NDudab6PMczNh2A/4QyCOwFdcdG2b+h+Fzm78v+YfIrvN+FNgBj4B9b
 FBtObFVaz/xMectI7zWgLGp3fenS/9EA=
X-Received: by 2002:a05:600c:48a3:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-496b56f14ecmr939275e9.17.1784931205277; 
 Fri, 24 Jul 2026 15:13:25 -0700 (PDT)
X-Received: by 2002:a05:600c:48a3:b0:495:6bc9:62b0 with SMTP id
 5b1f17b1804b1-496b56f14ecmr939015e9.17.1784931204742; 
 Fri, 24 Jul 2026 15:13:24 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm26141651f8f.27.2026.07.24.15.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 15:13:23 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:13:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] virtio-mmio: fix QUEUE_NUM_MAX
Message-ID: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
queue, regardless of the size the device passes to virtio_add_queue().

This works by accident because QEMU mostly does not care about the ring
size - the guest is the one allocating memory here.  But this changes
with in-order vqs where qemu is the one allocating resources.
Now, specifying a larger vq than allocated causes an OOB memory access.

To fix:
- for new machine types, report the actual max queue size to guest
- for old machine types, use a compat property to allocate 1k sized
  queues

Fixes: 525d82e323 ("virtio: fix queue size validation against allocated maximum")
Fixes: CVE-2026-50626
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-bus.h  |  1 +
 include/hw/virtio/virtio-mmio.h |  1 +
 hw/core/machine.c               |  1 +
 hw/virtio/virtio-mmio.c         |  7 +++----
 hw/virtio/virtio.c              | 11 +++++++++++
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 1a2d396156..f80fd71424 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -30,6 +30,7 @@
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_BUS "virtio-bus"
+#define VIRTIO_QUEUE_SIZE_OVERRIDE "x-override-queue-size"
 typedef struct VirtioBusClass VirtioBusClass;
 typedef struct VirtioBusState VirtioBusState;
 DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio-mmio.h
index 1644d09810..0a9069868c 100644
--- a/include/hw/virtio/virtio-mmio.h
+++ b/include/hw/virtio/virtio-mmio.h
@@ -69,6 +69,7 @@ struct VirtIOMMIOProxy {
     /* Fields only used for non-legacy (v2) devices */
     uint32_t guest_features[2];
     VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
+    uint16_t override_queue_size;
 };
 
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 805148678d..73b4d82b4a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 #include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
+    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 58c6d46aab..55ceaeef5f 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -172,10 +172,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
                 >> (32 * proxy->host_features_sel);
         }
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
-        if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
-            return 0;
-        }
-        return VIRTQUEUE_MAX_SIZE;
+        return virtio_queue_get_max_num(vdev, vdev->queue_sel);
     case VIRTIO_MMIO_QUEUE_PFN:
         if (!proxy->legacy) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -738,6 +735,8 @@ static const Property virtio_mmio_properties[] = {
     DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
     DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
                     VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT16(VIRTIO_QUEUE_SIZE_OVERRIDE, VirtIOMMIOProxy,
+                       override_queue_size, 0),
 };
 
 static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 340bac2607..35f2a50ddb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2590,6 +2590,17 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
     if (i == VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
         abort();
 
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    if (qbus && qbus->parent &&
+        object_property_find(OBJECT(qbus->parent), VIRTIO_QUEUE_SIZE_OVERRIDE)) {
+        int override = object_property_get_int(OBJECT(qbus->parent),
+                                               VIRTIO_QUEUE_SIZE_OVERRIDE,
+                                               &error_abort);
+        if (override) {
+            queue_size = override;
+        }
+    }
+
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].vring.num_default = queue_size;
     vdev->vq[i].vring.align = VIRTIO_PCI_VRING_ALIGN;
-- 
MST


