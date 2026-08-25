Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9EAC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqv-0005lN-Nm; Tue, 25 Aug 2026 17:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqt-0005jo-4m; Tue, 25 Aug 2026 17:38:39 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqq-0004zW-K1; Tue, 25 Aug 2026 17:38:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0507D80BD3;
 Wed, 26 Aug 2026 00:38:34 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-QaZNLQMv; Wed, 26 Aug 2026 00:38:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693913;
 bh=BpP/j5/dSMdKrZHMQJTDTf7onni9P7nIBpSBhvnd+uc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iohPVbKcgE1AWhZdT8gf/tNOeYT+JPfbpsqqnkYE6vABZDUJZibPXoh59LC0Hrcv1
 wV5jDpgLGa/EFyHnqblW7R2uN3PYqVwcFd+3GJYFARtSKMbLyDendGkl2cQbohHVtS
 mOpGvgQ+zhas2rq90IMm360vFmZJTRd0LMsbKb8w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:virtio-ccw)
Subject: [PATCH 04/30] hw/virtio: config save/load: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:44 +0300
Message-ID: <20260825213811.3725682-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stop ignoring the error on save path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pci.c                   | 27 +++++++++++----------------
 hw/s390x/virtio-ccw.c          | 19 ++++---------------
 hw/virtio/virtio-mmio.c        | 10 +++++++---
 hw/virtio/virtio-pci.c         | 24 +++++++++++++++---------
 hw/virtio/virtio.c             | 11 +++++++----
 include/hw/pci/pci.h           |  4 ++--
 include/hw/virtio/virtio-bus.h |  4 ++--
 7 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e28..76d006fa1d7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -940,37 +940,32 @@ const VMStateDescription vmstate_pci_device = {
 };
 
 
-void pci_device_save(PCIDevice *s, QEMUFile *f)
+bool pci_device_save(PCIDevice *s, QEMUFile *f, Error **errp)
 {
-    Error *local_err = NULL;
-    int ret;
+    bool ok;
 
     /* Clear interrupt status bit: it is implicit
      * in irq_state which we are saving.
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+
+    ok = vmstate_save_vmsd(f, &vmstate_pci_device, s, NULL, errp);
+
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
+
+    return ok;
 }
 
-int pci_device_load(PCIDevice *s, QEMUFile *f)
+bool pci_device_load(PCIDevice *s, QEMUFile *f, Error **errp)
 {
-    Error *local_err = NULL;
-    int ret;
+    bool ok = vmstate_load_vmsd(f, &vmstate_pci_device, s, s->version_id, errp);
 
-    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
-                             &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
-    return ret;
+
+    return ok;
 }
 
 static void pci_set_default_subsystem_id(PCIDevice *pci_dev)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d82874ed27e..848ed09e94b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1129,29 +1129,18 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
     return 0;
 }
 
-static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
+static bool virtio_ccw_save_config(DeviceState *d, QEMUFile *f, Error **errp)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    return vmstate_save_vmsd(f, &vmstate_virtio_ccw_dev, dev, NULL, errp);
 }
 
-static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
+static bool virtio_ccw_load_config(DeviceState *d, QEMUFile *f, Error **errp)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-    return ret;
+    return vmstate_load_vmsd(f, &vmstate_virtio_ccw_dev, dev, 1, errp);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 559363e4438..ef34b76913e 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -547,23 +547,27 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
     qemu_set_irq(proxy->irq, level);
 }
 
-static int virtio_mmio_load_config(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_load_config(DeviceState *opaque, QEMUFile *f,
+                                    Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
     proxy->host_features_sel = qemu_get_be32(f);
     proxy->guest_features_sel = qemu_get_be32(f);
     proxy->guest_page_shift = qemu_get_be32(f);
-    return 0;
+    return true;
 }
 
-static void virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f,
+                                    Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
     qemu_put_be32(f, proxy->host_features_sel);
     qemu_put_be32(f, proxy->guest_features_sel);
     qemu_put_be32(f, proxy->guest_page_shift);
+
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_mmio_queue_state = {
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7a5d4f35e33..07941319be2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -84,15 +84,21 @@ static void virtio_pci_notify(DeviceState *d, uint16_t vector)
     }
 }
 
-static void virtio_pci_save_config(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_save_config(DeviceState *d, QEMUFile *f, Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    pci_device_save(&proxy->pci_dev, f);
+    if (!pci_device_save(&proxy->pci_dev, f, errp)) {
+        return false;
+    }
+
     msix_save(&proxy->pci_dev, f);
-    if (msix_present(&proxy->pci_dev))
+    if (msix_present(&proxy->pci_dev)) {
         qemu_put_be16(f, vdev->config_vector);
+    }
+
+    return true;
 }
 
 static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
@@ -209,24 +215,24 @@ static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
         qemu_put_be16(f, virtio_queue_vector(vdev, n));
 }
 
-static int virtio_pci_load_config(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_load_config(DeviceState *d, QEMUFile *f, Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     uint16_t vector;
 
-    int ret;
-    ret = pci_device_load(&proxy->pci_dev, f);
-    if (ret) {
-        return ret;
+    if (!pci_device_load(&proxy->pci_dev, f, errp)) {
+        return false;
     }
+
     msix_unuse_all_vectors(&proxy->pci_dev);
     msix_load(&proxy->pci_dev, f);
     if (msix_present(&proxy->pci_dev)) {
         qemu_get_be16s(f, &vector);
 
         if (vector != VIRTIO_NO_VECTOR && vector >= proxy->nvectors) {
-            return -EINVAL;
+            error_setg(errp, "load config: unexpected vector %" PRIu16, vector);
+            return false;
         }
     } else {
         vector = VIRTIO_NO_VECTOR;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8230a383aff..0f7c8acead0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3077,7 +3077,10 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     Error *local_err = NULL;
 
     if (k->save_config) {
-        k->save_config(qbus->parent, f);
+        if (!k->save_config(qbus->parent, f, &local_err)) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
     }
 
     qemu_put_8s(f, &vdev->status);
@@ -3526,9 +3529,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     vdev->device_endian = VIRTIO_DEVICE_ENDIAN_UNKNOWN;
 
     if (k->load_config) {
-        ret = k->load_config(qbus->parent, f);
-        if (ret)
-            return ret;
+        if (!k->load_config(qbus->parent, f, &local_err)) {
+            return -EINVAL;
+        }
     }
 
     qemu_get_8s(f, &vdev->status);
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f2448e941a0..7c3fdc05630 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -270,8 +270,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
 void pci_default_write_config(PCIDevice *d,
                               uint32_t address, uint32_t val, int len);
-void pci_device_save(PCIDevice *s, QEMUFile *f);
-int pci_device_load(PCIDevice *s, QEMUFile *f);
+bool pci_device_save(PCIDevice *s, QEMUFile *f, Error **errp);
+bool pci_device_load(PCIDevice *s, QEMUFile *f, Error **errp);
 MemoryRegion *pci_address_space(PCIDevice *dev);
 MemoryRegion *pci_address_space_io(PCIDevice *dev);
 
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 255ecb2fcb2..1b9867002b8 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -41,10 +41,10 @@ struct VirtioBusClass {
     /* This is what a VirtioBus must implement */
     BusClass parent;
     void (*notify)(DeviceState *d, uint16_t vector);
-    void (*save_config)(DeviceState *d, QEMUFile *f);
+    bool (*save_config)(DeviceState *d, QEMUFile *f, Error **errp);
     void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
     bool (*save_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
-    int (*load_config)(DeviceState *d, QEMUFile *f);
+    bool (*load_config)(DeviceState *d, QEMUFile *f, Error **errp);
     int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
     int (*load_done)(DeviceState *d, QEMUFile *f);
     bool (*load_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
-- 
2.43.0


