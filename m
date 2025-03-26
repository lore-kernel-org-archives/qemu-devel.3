Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634BCC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 08:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txM6O-0006mu-P5; Wed, 26 Mar 2025 04:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1txM6M-0006lA-UX; Wed, 26 Mar 2025 04:27:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1txM6K-0002mK-PR; Wed, 26 Mar 2025 04:27:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22401f4d35aso136626745ad.2; 
 Wed, 26 Mar 2025 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742977622; x=1743582422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4NaOoSwFE4VLCqnsvKKUjd9++CO5m11fu4UvHdZ092Y=;
 b=QbqJLQVCRnAVz57fhmU9zzw0RIhraAQoW4rIJhKet0D/oAOuyhucUwt1gvB+6YYDmd
 Y8U/4/UBCnWkHFixbn79s8U1VrdDhfNsUI3nJ8cevpRajYzv4C4IWLXmJvPxB+UKIiaF
 96TqyTsM4ZUf6R646Fh76l65gxDVSQXvfJiWLoCrX/8EgxDK2ezC904Vucu4QHOMQwoc
 EFj/ITbE+7LUBQrv/NZQH+TXsXbdgG85auEs5PdHBR1uplmPbU3tTBCTS9RUe1nqp4C8
 AAvdFVyJzr7Pb8ULaW10/oMxfse8FBQe5ho+BQp/A8nRtdx6QpJht7dng0UKYD5tU8Gf
 Urmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742977622; x=1743582422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NaOoSwFE4VLCqnsvKKUjd9++CO5m11fu4UvHdZ092Y=;
 b=Hjq2iwwuGMpS1hT7Xo1sZf9dcW5JeGU5hqJFmL2KD53avytiVroSZKQxowDkbnfBGt
 c8CyqUZIm9nSsuuInhnX0ZEEdfyBEQTYZbxTBftMNqqkCiPh2hxciU93i3FZ81yjo5k8
 P0YLOgeU5kYHHJtlGBwl6+Ofx+v08Ttlsnf762MEd9cyIGp76XOa6U0++s74Nr1n0ONs
 fpEiifr2ojKjgzdpwcHrEnh7HU9vxNXVB7ncogGQuFMaa66crHsRkJFbyFpDXwQo9Sfb
 9RpCV3T/dqOu98Tn9b4InBwD2ROsliv0J2/JFyzUhCN+Dd71EpcmRo2QgTMSdBOKjbj4
 Louw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeWAIE17UQcP6QuY6wQdKOqJMqNIIIo8xv5whjNVCEDQOTfK4TKWCLCvWwgXHwNH/MovgeITgaPuEt+Q==@nongnu.org
X-Gm-Message-State: AOJu0YyXkH6d4gLW12elFdH3DYIpW05Hhhmgrkno2p5RU2iWraZh+KtN
 7UZPi2IfVFXuQImFtA8AuF1w2gcgszctawsQ7sIpcb0n/uLIvuaq
X-Gm-Gg: ASbGncsYjBmwmz2r1Pp5fPp4y9Oh+dhTmTdW3H7oYhSaqJVWtrd8uRHkdZvlYjioXTj
 BDZy4uaQBsh6rfPtTb3lSgjx9EF4OW/YRyAUrIqTmIErlQ+DW5iAKI7qrQdmJ9wDrlxe+jj9kiu
 56Fb//iiTcfbf+PenTCWLnaD8h+1JGJmzOfjKYZA7U6Tin0bnMiot/rFQ8jAFkW3wRqysLZao9H
 6lzAyOy7ULFJwxVUpJHxDhFSdgiz8cMezZFqE1p+u9jTlEaAAYrx81WH9WgKy+QDIBrgkbuHtN2
 Vt3e7AC6i4vIhI+ERyNs6kpMCxTLg+oCv+cApYjLJIt95xCBET4CBI2v/uV9nNVBbKO5XBCSfgz
 awQWlOsooBZcafxo9OBrcRfw/c7I=
X-Google-Smtp-Source: AGHT+IFOtzWesnc1GgzefI3Ds0doREgAbum0EHaMoB/LMGHZS/8g3c1QtSG7p0HtaTOulaTat+NDuw==
X-Received: by 2002:a17:902:c951:b0:223:42ca:10ef with SMTP id
 d9443c01a7336-22780e23682mr324703445ad.43.1742977621561; 
 Wed, 26 Mar 2025 01:27:01 -0700 (PDT)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f39758sm104046795ad.35.2025.03.26.01.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 01:27:00 -0700 (PDT)
From: oenhan@gmail.com
X-Google-Original-From: hanht2@chinatelecom.cn
To: mst@redhat.com, sgarzare@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, leiyang@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: [PATCH] vhost: Don't set vring call if guest notifier is unused
Date: Wed, 26 Mar 2025 16:25:37 +0800
Message-ID: <20250326082537.379977-1-hanht2@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=oenhan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use msix (e.g., in the
case of virtio pmd), leading to unnecessary CPU overhead for processing
interrupts. The previous patch optimized the condition where msix is enabled
but the queue vector is unset. However, there is a additional case where the
guest interrupt notifier is effectively unused and the vring call fd should
also be cleared: the guest does not use msix and the INTX_DISABLED bit in the PCI
config is set.

Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")

Test result:
https://raw.githubusercontent.com/oenhan/build_log/refs/heads/main/qemu/2503261015/build/meson-logs/testlog.txt

Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
 hw/pci/pci.c                   |  2 +-
 hw/s390x/virtio-ccw.c          |  9 ++++++---
 hw/virtio/vhost.c              |  5 ++---
 hw/virtio/virtio-pci.c         | 15 ++++++++++-----
 include/hw/pci/pci.h           |  1 +
 include/hw/virtio/virtio-bus.h |  2 +-
 6 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec5556..503a897528 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
     pci_update_vga(d);
 }
 
-static inline int pci_irq_disabled(PCIDevice *d)
+int pci_irq_disabled(PCIDevice *d)
 {
     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 43f3b162c8..af482a22cd 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
     }
 }
 
-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
+static bool virtio_ccw_query_guest_notifiers_used(DeviceState *d, int n)
 {
     CcwDevice *dev = CCW_DEVICE(d);
+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
 
-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
 }
 
 static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
@@ -1270,7 +1273,7 @@ static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
     bus_class->max_dev = 1;
     k->notify = virtio_ccw_notify;
     k->vmstate_change = virtio_ccw_vmstate_change;
-    k->query_guest_notifiers = virtio_ccw_query_guest_notifiers;
+    k->query_guest_notifiers_used = virtio_ccw_query_guest_notifiers_used;
     k->set_guest_notifiers = virtio_ccw_set_guest_notifiers;
     k->save_queue = virtio_ccw_save_queue;
     k->load_queue = virtio_ccw_load_queue;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..32634da836 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1341,9 +1341,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         vhost_virtqueue_mask(dev, vdev, idx, false);
     }
 
-    if (k->query_guest_notifiers &&
-        k->query_guest_notifiers(qbus->parent) &&
-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
+    if (k->query_guest_notifiers_used &&
+        !k->query_guest_notifiers_used(qbus->parent, idx)) {
         file.fd = -1;
         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
         if (r) {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3ca3f849d3..25ff869618 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
@@ -1031,7 +1032,7 @@ static void virtio_pci_one_vector_mask(VirtIOPCIProxy *proxy,
 
     /* If guest supports masking, keep irqfd but mask it.
      * Otherwise, clean it up now.
-     */ 
+     */
     if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
         k->guest_notifier_mask(vdev, queue_no, true);
     } else {
@@ -1212,10 +1213,15 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
     return 0;
 }
 
-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
+static bool virtio_pci_query_guest_notifiers_used(DeviceState *d, int n)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return msix_enabled(&proxy->pci_dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (msix_enabled(&proxy->pci_dev))
+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
+    else
+        return !pci_irq_disabled(&proxy->pci_dev);
 }
 
 static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
@@ -2599,7 +2605,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->save_extra_state = virtio_pci_save_extra_state;
     k->load_extra_state = virtio_pci_load_extra_state;
     k->has_extra_state = virtio_pci_has_extra_state;
-    k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
+    k->query_guest_notifiers_used = virtio_pci_query_guest_notifiers_used;
     k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
     k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
     k->vmstate_change = virtio_pci_vmstate_change;
@@ -2630,4 +2636,3 @@ static void virtio_pci_register_types(void)
 }
 
 type_init(virtio_pci_register_types)
-
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 822fbacdf0..de4ab28046 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -256,6 +256,7 @@ void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
 
 uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
 
+int pci_irq_disabled(PCIDevice *d);
 
 uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 7ab8c9dab0..de75a44895 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -48,7 +48,7 @@ struct VirtioBusClass {
     int (*load_done)(DeviceState *d, QEMUFile *f);
     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
     bool (*has_extra_state)(DeviceState *d);
-    bool (*query_guest_notifiers)(DeviceState *d);
+    bool (*query_guest_notifiers_used)(DeviceState *d, int n);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
     int (*set_host_notifier_mr)(DeviceState *d, int n,
                                 MemoryRegion *mr, bool assign);
-- 
2.43.5


