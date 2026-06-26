Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335FFCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eL-0007sr-5Z; Fri, 26 Jun 2026 06:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dq-0007LS-Bc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dn-0005BY-01
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRDoIIHI0iG+p6GAMRLZ6L4UMThvOSl8GSRYPnDHN5g=;
 b=aciaGw08d80AnUh+/1NGaOALCgYwAVc4Divpdf0wgr+7OVW8c0ZwWppiAGgNrardCNSJ2D
 vc3ZwK/VfREV3rk5XmJvGmqBt+rL7WTWOsD+4hLgVfT9+kYylnwaL4lAdxHlj1RFl4A1wY
 y1wIvNOTpgcsWghZR65u3L1SwG65iD0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-BllTUYpMPNeh94R935q4iQ-1; Fri, 26 Jun 2026 06:18:29 -0400
X-MC-Unique: BllTUYpMPNeh94R935q4iQ-1
X-Mimecast-MFC-AGG-ID: BllTUYpMPNeh94R935q4iQ_1782469108
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so11098055e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469108; x=1783073908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRDoIIHI0iG+p6GAMRLZ6L4UMThvOSl8GSRYPnDHN5g=;
 b=nT2EeY7TBL+YrnO8kNe/AWFftiCpX6SebZH/IhgfUlFBcoBJglgExmfqwQRk/f9W3l
 mX30lfklz9/iXMjlboO6U8sS/WULDDNvLu9FTrtZcUEfw4nT/G9nbINhDF5V2uCN/MUX
 6U37uuRxU4iJgnkTWYjTYJFirI3AeeVcj8YGzQj71X7fwbUSVUvFjKw9e8mqpy5WnI0t
 bITBiTfAAr6nQ4Uj+IdpVOPdbimCylguPi/whDWCb/EKsUGmAremOPArJuykainOz+xT
 yfS53AdqchjU61WrWK/q5luE7tHecCC9UPbILwnuvdFGc0WUPrqweE9sXDfqkWQ/4Urb
 tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469108; x=1783073908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yRDoIIHI0iG+p6GAMRLZ6L4UMThvOSl8GSRYPnDHN5g=;
 b=P4D2IdOKBJkoMOh9OLTSNcvHRvkirLEPGcPgATtbEUNqvlTzF1F9tvn0arnEx5GKxl
 EYYcngSorzWv8p32Y8ifZICmM4drv62s4fTyeNtJh8NuZQc9aPZAQ6YUyamT5L21uXS2
 cGguL3KNDGkLSUIkfGdzxJ1KMp+ZfRE3pLv3/B1yfH7ixQ3OaQGWNcYKB04Rdsm5zWZJ
 RNI9Vl+c7hJdNlVVUO9SlAe8je+A8XRzqIdX4Jasz+FhgO3v7AoIxCeGaI80xfRIU4HG
 hoNTsU71rmx98RCsSVg24LXFSZ1uY7HHQYJeT3ThaP9mP5ue94l0zYeoZV/IWbq7hYu2
 /Tgg==
X-Gm-Message-State: AOJu0Yxna6gEJSczKyWMgwSdmmdcZCrpUcET9V9/d3cPHs4enUeiI9e9
 qWjMuV3yLjHs5GwOQrGzUdkRXXabwjPW/6Tn5YFoEU9YWVPvUIXtod5p+qrOEZlwqhPUh0q+mtH
 znU831WLC95v52Z4ilB8pRnvlFGhLSEScokmmIqQr2YJgaSwuCUujNwM2JpF1YUk8we5mKgMkzN
 zmOLuGyXSAEO6BAYpXsRiw59lu09bVFOt6JxTVWNlh
X-Gm-Gg: AfdE7ck7dW1xKv1wDCUNCZAd2LgDklKKT+Bvk1DKkrYlDQb7ZTUoaV5TM/iXqvys3+K
 4uNU0hBBEuyyueVyTqThHMeMy4Qvm9VJSwfDoGnivxkjs00rBs4Ao/VXuWJmRtXpaZ6jbpSh8xG
 UN48SNhTds7w9rBnwwpNKzf8mzzCYH+3QCfAW+cPBMo/nTz1NtJd4vdgC7d0dT2z12C1Aa4KWRH
 2/ff80zZYlo0AMTjvhZuThwsfJWO7dXtcJ1FPhEy9ymVSmIJvmJik/dpTB+0q1Bk/OtH80/aJL4
 S7VEcTLFcz8Nw1lD4/ciU8ounfi6yBIbiX1XmSB+CdYm35X3c9jHuMOIyef0C7PHcraYiFhDHW5
 XKC4mWFn2O9GflsIshyjek14Y6To7czNBI3U6KUu/dIKVHzvQ0zPwvcoo0gCwgBK/+DfpTY2okB
 qX9OfCwyEWNbjVmemV
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-492664241a4mr79260215e9.13.1782469107673; 
 Fri, 26 Jun 2026 03:18:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-492664241a4mr79259525e9.13.1782469107027; 
 Fri, 26 Jun 2026 03:18:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690988e0sm71825775e9.14.2026.06.26.03.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 13/45] accel/accel-irq: add AccelRouteChange abstraction
Date: Fri, 26 Jun 2026 12:17:16 +0200
Message-ID: <20260626101748.1728079-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The accelerated irqchip routines use a record of changes to batch
changes when programming routes.

Currently this mechanism is coupled to the KVM accelerator, this change
introduces an abstraction that replaces KVMRouteChange and keeps a
pointer to an abstract AccelState instead of the concrete type,
converting the state where necessary.

This is done to further align the irqchip programming in the MSHV
accelerator with the existing KVM code in QEMU. Subsequent commits will
introduce AccelRouteChange to the MSHV accelerator code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-5-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/accel/accel-route.h | 17 +++++++++++++++++
 include/system/accel-irq.h  |  5 +++--
 include/system/kvm.h        | 21 ++++++++++-----------
 include/system/mshv.h       |  1 +
 accel/accel-irq.c           |  4 ++--
 accel/kvm/kvm-all.c         |  6 +++---
 accel/stubs/kvm-stub.c      |  2 +-
 hw/misc/ivshmem-pci.c       |  2 +-
 hw/vfio/pci.c               |  2 +-
 hw/virtio/virtio-pci.c      |  3 +--
 target/i386/kvm/kvm.c       |  2 +-
 11 files changed, 41 insertions(+), 24 deletions(-)
 create mode 100644 include/accel/accel-route.h

diff --git a/include/accel/accel-route.h b/include/accel/accel-route.h
new file mode 100644
index 00000000000..07fac27e2a7
--- /dev/null
+++ b/include/accel/accel-route.h
@@ -0,0 +1,17 @@
+/*
+ * Accelerator MSI route change tracking
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_ROUTE_H
+#define ACCEL_ROUTE_H
+
+#include "qemu/accel.h"
+
+typedef struct AccelRouteChange {
+    AccelState *accel;
+    int changes;
+} AccelRouteChange;
+
+#endif /* ACCEL_ROUTE_H */
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index a2caa06f547..a1489207113 100644
--- a/include/system/accel-irq.h
+++ b/include/system/accel-irq.h
@@ -25,9 +25,10 @@ static inline bool accel_irqchip_is_split(void)
     return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
 }
 
-int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
+int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector,
+                                PCIDevice *dev);
 int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
-void accel_irqchip_commit_route_changes(KVMRouteChange *c);
+void accel_irqchip_commit_route_changes(AccelRouteChange *c);
 void accel_irqchip_commit_routes(void);
 void accel_irqchip_release_virq(int virq);
 int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda3..ccf90b83416 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -18,6 +18,7 @@
 
 #include "exec/memattrs.h"
 #include "qemu/accel.h"
+#include "accel/accel-route.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
@@ -183,11 +184,6 @@ extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
 typedef struct NotifierWithReturn NotifierWithReturn;
 
-typedef struct KVMRouteChange {
-     KVMState *s;
-     int changes;
-} KVMRouteChange;
-
 /* external API */
 
 unsigned int kvm_get_max_memslots(void);
@@ -466,7 +462,7 @@ void kvm_init_cpu_signals(CPUState *cpu);
 
 /**
  * kvm_irqchip_add_msi_route - Add MSI route for specific vector
- * @c:      KVMRouteChange instance.
+ * @c:      AccelRouteChange instance.
  * @vector: which vector to add. This can be either MSI/MSIX
  *          vector. The function will automatically detect whether
  *          MSI/MSIX is enabled, and fetch corresponding MSI
@@ -475,20 +471,23 @@ void kvm_init_cpu_signals(CPUState *cpu);
  *          as @NULL, an empty MSI message will be inited.
  * @return: virq (>=0) when success, errno (<0) when failed.
  */
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline KVMRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
+static inline AccelRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
 {
-    return (KVMRouteChange) { .s = s, .changes = 0 };
+    return (AccelRouteChange) {
+        .accel = ACCEL(s),
+        .changes = 0,
+    };
 }
 
-static inline void kvm_irqchip_commit_route_changes(KVMRouteChange *c)
+static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
 {
     if (c->changes) {
-        kvm_irqchip_commit_routes(c->s);
+        kvm_irqchip_commit_routes(KVM_STATE(c->accel));
         c->changes = 0;
     }
 }
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 51b04207358..8dd77a76241 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -21,6 +21,7 @@
 #include "qapi/qapi-types-common.h"
 #include "system/memory.h"
 #include "accel/accel-ops.h"
+#include "accel/accel-route.h"
 
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 7f864e35c4e..0aa04c033d4 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -16,7 +16,7 @@
 #include "system/mshv.h"
 #include "system/accel-irq.h"
 
-int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
@@ -42,7 +42,7 @@ int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void accel_irqchip_commit_route_changes(KVMRouteChange *c)
+void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f4f0e64fbd0..7217baf8d40 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2359,11 +2359,11 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
     return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     struct kvm_irq_routing_entry kroute = {};
     int virq;
-    KVMState *s = c->s;
+    KVMState *s = KVM_STATE(c->accel);
     MSIMessage msg = {0, 0};
 
     if (pci_available && dev) {
@@ -2506,7 +2506,7 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
     abort();
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6b..32b4b074035 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -44,7 +44,7 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index c987eebb983..aa8f2717555 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -424,7 +424,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
                                      Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(s);
-    KVMRouteChange c;
+    AccelRouteChange c;
     int ret;
 
     IVSHMEM_DPRINTF("ivshmem_add_kvm_msi_virq vector:%d\n", vector);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e637..1817f39cde7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -50,7 +50,7 @@
 #include "vfio-helpers.h"
 
 /* Protected by BQL */
-static KVMRouteChange vfio_route_change;
+static AccelRouteChange vfio_route_change;
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fd9719547f9..90df7bf3a1a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -869,7 +869,7 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
     int ret;
 
     if (irqfd->users == 0) {
-        KVMRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
+        AccelRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
         ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
         if (ret < 0) {
             return ret;
@@ -2669,4 +2669,3 @@ static void virtio_pci_register_types(void)
 }
 
 type_init(virtio_pci_register_types)
-
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8c..478a5573cd2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6678,7 +6678,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        KVMRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.54.0


