Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9ECF46120
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fnm-0007yf-6K; Mon, 23 Mar 2026 09:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fnk-0007wA-GC
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:58:40 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fni-0006nH-NY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:58:40 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id AA6F320B7135;
 Mon, 23 Mar 2026 06:58:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA6F320B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274317;
 bh=ZUck8KRzAIHOJZRjiz7XUC9sA5Upd2lSR/QGThC5/Zk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G66Phg8ZIRSknyuAf6SxTBhuI7Pa5PEEyhu4NG/DulcV27GFe6HTGv6wcij1P98mk
 vA5QBuFi2l6cojr9xpbtuo6jIBPhFiYk6A2H6Ciu+/LZjrsJsVXlfbyhla9BEkzzMP
 SqsxJcmqAq2f7SVl87GjNXfYTHwHOs07dSnros5U=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 05/32] accel/accel-irq: add generic begin_route_changes
Date: Mon, 23 Mar 2026 14:57:45 +0100
Message-Id: <20260323135812.383509-6-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A generic accel_irqchip_begin_route_change() fn has been introduced for
usage in the MSHV accelerator. It replaces the respective kvm_ fn.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c          | 21 +++++++++++++++++++++
 hw/misc/ivshmem-pci.c      |  4 ++--
 hw/vfio/pci.c              |  5 +++--
 hw/virtio/virtio-pci.c     |  2 +-
 include/system/accel-irq.h |  1 +
 include/system/kvm.h       |  8 --------
 target/i386/kvm/kvm.c      |  3 ++-
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0aa04c033d..3815f6727c 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/pci/msi.h"
 
 #include "system/kvm.h"
@@ -104,3 +105,23 @@ int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
     }
     return -ENOSYS;
 }
+
+inline AccelRouteChange accel_irqchip_begin_route_changes(void)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return (AccelRouteChange) {
+            .accel = ACCEL(mshv_state),
+            .changes = 0,
+        };
+    }
+#endif
+    if (kvm_enabled()) {
+        return (AccelRouteChange) {
+            .accel = ACCEL(kvm_state),
+            .changes = 0,
+        };
+    }
+    error_report("can't initiate route change, no accel irqchip available");
+    abort();
+}
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index aa8f271755..fa23562886 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -26,7 +26,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "system/kvm.h"
+#include "system/accel-irq.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -430,7 +430,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
     IVSHMEM_DPRINTF("ivshmem_add_kvm_msi_virq vector:%d\n", vector);
     assert(!s->msi_vectors[vector].pdev);
 
-    c = kvm_irqchip_begin_route_changes(kvm_state);
+    c = accel_irqchip_begin_route_changes();
     ret = kvm_irqchip_add_msi_route(&c, vector, pdev);
     if (ret < 0) {
         error_setg(errp, "kvm_irqchip_add_msi_route failed");
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e48f4add4e..6768523147 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "pci.h"
@@ -692,7 +693,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             if (vdev->defer_kvm_irq_routing) {
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
             } else {
-                vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+                vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
@@ -793,7 +794,7 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
-    vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+    vfio_route_change = accel_irqchip_begin_route_changes();
 }
 
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5010572784..faa4a41cca 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -869,7 +869,7 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
     int ret;
 
     if (irqfd->users == 0) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
         if (ret < 0) {
             return ret;
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index a148920711..fc94c54264 100644
--- a/include/system/accel-irq.h
+++ b/include/system/accel-irq.h
@@ -25,6 +25,7 @@ static inline bool accel_irqchip_is_split(void)
     return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
 }
 
+AccelRouteChange accel_irqchip_begin_route_changes(void);
 int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector,
                                 PCIDevice *dev);
 int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ccf90b8341..fec24d2135 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -476,14 +476,6 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline AccelRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
-{
-    return (AccelRouteChange) {
-        .accel = ACCEL(s),
-        .changes = 0,
-    };
-}
-
 static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
 {
     if (c->changes) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9cc41758d7..dc7c495f9c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -32,6 +32,7 @@
 #include "vmsr_energy.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
+#include "system/accel-irq.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
@@ -6680,7 +6681,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.34.1


