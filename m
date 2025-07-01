Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC5AC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWenP-0002wz-PU; Tue, 01 Jul 2025 13:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWenL-0002us-DI
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:23 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWenH-0006Yp-RJ
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:29:23 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id D359B2112221;
 Tue,  1 Jul 2025 10:29:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D359B2112221
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390958;
 bh=jLJRI9UQwPQ7QvAFK4jr1bU+zUCcMtzt90fSPxsEtvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LxWDnhO+NNXBZF1fBxlpvI+0D3dT4+gIHIS2VodDiCv6/NjDmGlQD7XAn+RJ9AdPL
 rm0DMjSnhtd1DehUeyI4pjYzCE+sWE6Pn6Y18UIzJgl36pJ3E0EB2pWCzQz+/j8ytt
 djwj2kaCjJNNFwrC04eyYGLcp5EpqmxxyNC0DaIE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/27] hw/intc: Generalize APIC helper names from kvm_* to
 accel_*
Date: Tue,  1 Jul 2025 19:28:11 +0200
Message-Id: <20250701172834.44849-5-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Rename APIC helper functions to use an accel_* prefix instead of kvm_*
to support use by accelerators other than KVM. This is a preparatory
step for integrating MSHV support with common APIC logic.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c          | 95 ++++++++++++++++++++++++++++++++++++++
 accel/meson.build          |  2 +-
 hw/intc/ioapic.c           | 20 +++++---
 hw/virtio/virtio-pci.c     | 21 +++++----
 include/system/accel-irq.h | 26 +++++++++++
 include/system/mshv.h      | 21 +++++++++
 6 files changed, 167 insertions(+), 18 deletions(-)
 create mode 100644 accel/accel-irq.c
 create mode 100644 include/system/accel-irq.h

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
new file mode 100644
index 0000000000..63f8ed260a
--- /dev/null
+++ b/accel/accel-irq.c
@@ -0,0 +1,95 @@
+#include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+
+#include "system/kvm.h"
+#include "system/mshv.h"
+#include "system/accel-irq.h"
+
+int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return mshv_irqchip_add_msi_route(vector, dev);
+    }
+#endif
+    if (kvm_enabled()) {
+        return kvm_irqchip_add_msi_route(c, vector, dev);
+    }
+    return -ENOSYS;
+}
+
+int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return mshv_irqchip_update_msi_route(vector, msg, dev);
+    }
+#endif
+    if (kvm_enabled()) {
+        return kvm_irqchip_update_msi_route(kvm_state, vector, msg, dev);
+    }
+    return -ENOSYS;
+}
+
+void accel_irqchip_commit_route_changes(KVMRouteChange *c)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        mshv_irqchip_commit_routes();
+    }
+#endif
+    if (kvm_enabled()) {
+        kvm_irqchip_commit_route_changes(c);
+    }
+}
+
+void accel_irqchip_commit_routes(void)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        mshv_irqchip_commit_routes();
+    }
+#endif
+    if (kvm_enabled()) {
+        kvm_irqchip_commit_routes(kvm_state);
+    }
+}
+
+void accel_irqchip_release_virq(int virq)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        mshv_irqchip_release_virq(virq);
+    }
+#endif
+    if (kvm_enabled()) {
+        kvm_irqchip_release_virq(kvm_state, virq);
+    }
+}
+
+int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
+                                         int virq)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return mshv_irqchip_add_irqfd_notifier_gsi(n, rn, virq);
+    }
+#endif
+    if (kvm_enabled()) {
+        return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, rn, virq);
+    }
+    return -ENOSYS;
+}
+
+int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return mshv_irqchip_remove_irqfd_notifier_gsi(n, virq);
+    }
+#endif
+    if (kvm_enabled()) {
+        return kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, virq);
+    }
+    return -ENOSYS;
+}
diff --git a/accel/meson.build b/accel/meson.build
index 52909314bf..d5e982d152 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,6 +1,6 @@
 common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
-system_ss.add(files('accel-system.c', 'accel-blocker.c'))
+system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 133bef852d..e431d00311 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -30,12 +30,18 @@
 #include "hw/intc/ioapic_internal.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "system/system.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 #include "trace.h"
 
+
+#if defined(CONFIG_KVM) || defined(CONFIG_MSHV)
+#define ACCEL_GSI_IRQFD_POSSIBLE
+#endif
+
 #define APIC_DELIVERY_MODE_SHIFT 8
 #define APIC_POLARITY_SHIFT 14
 #define APIC_TRIG_MODE_SHIFT 15
@@ -191,10 +197,10 @@ static void ioapic_set_irq(void *opaque, int vector, int level)
 
 static void ioapic_update_kvm_routes(IOAPICCommonState *s)
 {
-#ifdef CONFIG_KVM
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
     int i;
 
-    if (kvm_irqchip_is_split()) {
+    if (accel_irqchip_is_split()) {
         for (i = 0; i < IOAPIC_NUM_PINS; i++) {
             MSIMessage msg;
             struct ioapic_entry_info info;
@@ -202,15 +208,15 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
             if (!info.masked) {
                 msg.address = info.addr;
                 msg.data = info.data;
-                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
+                accel_irqchip_update_msi_route(i, msg, NULL);
             }
         }
-        kvm_irqchip_commit_routes(kvm_state);
+        accel_irqchip_commit_routes();
     }
 #endif
 }
 
-#ifdef CONFIG_KVM
+#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
 static void ioapic_iec_notifier(void *private, bool global,
                                 uint32_t index, uint32_t mask)
 {
@@ -428,11 +434,11 @@ static const MemoryRegionOps ioapic_io_ops = {
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 {
-#ifdef CONFIG_KVM
+#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
 
-    if (kvm_irqchip_is_split()) {
+    if (accel_irqchip_is_split()) {
         X86IOMMUState *iommu = x86_iommu_get_default();
         if (iommu) {
             /* Register this IOAPIC with IOMMU IEC notifier, so that
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fba2372c93..a582bb082d 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -33,6 +33,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qemu/range.h"
@@ -824,11 +825,11 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
 
     if (irqfd->users == 0) {
         KVMRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
-        ret = kvm_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
+        ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
         if (ret < 0) {
             return ret;
         }
-        kvm_irqchip_commit_route_changes(&c);
+        accel_irqchip_commit_route_changes(&c);
         irqfd->virq = ret;
     }
     irqfd->users++;
@@ -840,7 +841,7 @@ static void kvm_virtio_pci_vq_vector_release(VirtIOPCIProxy *proxy,
 {
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
     if (--irqfd->users == 0) {
-        kvm_irqchip_release_virq(kvm_state, irqfd->virq);
+        accel_irqchip_release_virq(irqfd->virq);
     }
 }
 
@@ -849,7 +850,7 @@ static int kvm_virtio_pci_irqfd_use(VirtIOPCIProxy *proxy,
                                  unsigned int vector)
 {
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
-    return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, irqfd->virq);
+    return accel_irqchip_add_irqfd_notifier_gsi(n, NULL, irqfd->virq);
 }
 
 static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
@@ -859,7 +860,7 @@ static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
     int ret;
 
-    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, irqfd->virq);
+    ret = accel_irqchip_remove_irqfd_notifier_gsi(n, irqfd->virq);
     assert(ret == 0);
 }
 static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
@@ -994,12 +995,12 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
     if (proxy->vector_irqfd) {
         irqfd = &proxy->vector_irqfd[vector];
         if (irqfd->msg.data != msg.data || irqfd->msg.address != msg.address) {
-            ret = kvm_irqchip_update_msi_route(kvm_state, irqfd->virq, msg,
-                                               &proxy->pci_dev);
+            ret = accel_irqchip_update_msi_route(irqfd->virq, msg,
+                                                 &proxy->pci_dev);
             if (ret < 0) {
                 return ret;
             }
-            kvm_irqchip_commit_routes(kvm_state);
+            accel_irqchip_commit_routes();
         }
     }
 
@@ -1228,7 +1229,7 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     int r, n;
     bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
-        kvm_msi_via_irqfd_enabled();
+        accel_msi_via_irqfd_enabled() ;
 
     nvqs = MIN(nvqs, VIRTIO_QUEUE_MAX);
 
@@ -1432,7 +1433,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
                                   uint16_t new_vector)
 {
     bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
-        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
+        msix_enabled(&proxy->pci_dev) && accel_msi_via_irqfd_enabled();
 
     if (new_vector == old_vector) {
         return;
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
new file mode 100644
index 0000000000..8d17fe45ea
--- /dev/null
+++ b/include/system/accel-irq.h
@@ -0,0 +1,26 @@
+#ifndef SYSEMU_ACCEL_H
+#define SYSEMU_ACCEL_H
+#include "hw/pci/msi.h"
+#include "qemu/osdep.h"
+#include "system/kvm.h"
+#include "system/mshv.h"
+
+static inline bool accel_msi_via_irqfd_enabled(void)
+{
+  return mshv_msi_via_irqfd_enabled() || kvm_msi_via_irqfd_enabled();
+}
+
+static inline bool accel_irqchip_is_split(void)
+{
+  return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
+}
+
+int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
+int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
+void accel_irqchip_commit_route_changes(KVMRouteChange *c);
+void accel_irqchip_commit_routes(void);
+void accel_irqchip_release_virq(int virq);
+int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
+                                         int virq);
+int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq);
+#endif
diff --git a/include/system/mshv.h b/include/system/mshv.h
index a971982b52..a358691428 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -22,4 +22,25 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+extern bool mshv_allowed;
+#define mshv_enabled() (mshv_allowed)
+#else /* CONFIG_MSHV_IS_POSSIBLE */
+#define mshv_enabled() false
+#endif
+#ifdef MSHV_USE_KERNEL_GSI_IRQFD
+#define mshv_msi_via_irqfd_enabled() mshv_enabled()
+#else
+#define mshv_msi_via_irqfd_enabled() false
+#endif
+
+/* interrupt */
+int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
+int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
+void mshv_irqchip_commit_routes(void);
+void mshv_irqchip_release_virq(int virq);
+int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
+                                        const EventNotifier *rn, int virq);
+int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
+
 #endif
-- 
2.34.1


