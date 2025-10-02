Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC34ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvf-00016j-Vh; Thu, 02 Oct 2025 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mue-0000b3-Uj
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuP-0005fL-DY
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=seTBrfyi/DDrrV1xDxXkPnrvQGhZFDqQgQXZovjNWnw=;
 b=PMbSwXDgY5ULSJ5Ih7AJ/A9zEHpa0+X0y8AoLHA/eAzXWx9P5HcMr2jRUFfvPqvNa9+lb3
 HEKN4dQ+g3bQACAE1SzGxQNJrxnl4ffL5X3a2GTmhKMh3etKHaYLX+WCb7RzH+x3YKtMHi
 CdFq6D6frUgzRZ+ryeNReIAdqqMeNVg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-u-wiaJfYMFyBhUUA3ZPRbQ-1; Thu, 02 Oct 2025 13:15:50 -0400
X-MC-Unique: u-wiaJfYMFyBhUUA3ZPRbQ-1
X-Mimecast-MFC-AGG-ID: u-wiaJfYMFyBhUUA3ZPRbQ_1759425350
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-638f4eaf806so168373a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425349; x=1760030149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seTBrfyi/DDrrV1xDxXkPnrvQGhZFDqQgQXZovjNWnw=;
 b=V0q0kXT8sdmtdZ/qhv0cyWE4e1NicsYQhRlH+eyU8WjIclEiPx86dhwoDvnarcmaoE
 7TReyhVtp1s3WpNV1xWGhuyGkF8FqmTsshNx1AdHsy08jb6NHKHyHzNb58pxZcbU32yX
 kNGoiWSaennQsMpRacKxfdzMVacgm+uc3LlIZEFswC+K2hmcN2kSkiMHnwgUPMyCRTJj
 /+BiQC5JhYRXPSYUD7LN1KXJhTCHPaUamg/KTNDW12gqdhscqcn3DN7CHoFKLMu2cpic
 G7Ziu9gUCgNf9lOfJFrKi0SaNDtVNINXwQRonz7EKb2CvEwYPL2tKw7gSqXK6FXndy2i
 wVpw==
X-Gm-Message-State: AOJu0YxlB9+aT3I+5qOjGWbyGf1XU/99QTc24mew2QLW/IxtDrEptCzR
 kBOvng4m6r1RsTFBhXsEyod1cKWOPI1StPdqsCqkkp/hspIjRq0CDjac+surXZWcMo1IDF8JS8y
 z2so8Ua6V5TptcMnwiidir0eYAiIkxBKMrSczlaHfmYE8Dt1oPpTwAP8LEkd1ijZFdNFn5fSTjO
 B+RwVOPGR7ZqBL1/6LOJ0Kz8S1d1PYIQQCawTd6WF/
X-Gm-Gg: ASbGncuAq0/ZNPRUwEe12Wv1Q9qtwYNRTNWX4xdEU5xkRIE0KO72kU6OHzdcfSy2mQk
 nlRJkEnTQShMpSvHb/2Y1bq37oetRMQmhT2XQVHV/9q7+FSwTe0FhYxEk0huApwDI29e0C5A6lq
 MqxnvhKLnzKGPSO8dewXLPI1BPzs74JHkoW1j4pz0uczKswviEnn5bGny0O9OMpqkWA2CYU9+n0
 arOh3D7ooRFPanc4Ol4t8j+jZgEvIPzOtpDExUeaIun2stw5AB28cfxktqDgLYHVhKyWdAxkcCY
 3b2zApZjdNq4Vb7vm8ZcVK+gFJ4og+wpUKmPR27aKsYOwMv36TJCjc2XwPDp4wfzo4ihb3tMfSL
 0rgK9fgcSi+uhJ9WkQUpYNfRhOvSGwZzAU7P1haXY1/KWSiPA
X-Received: by 2002:a05:6402:1e8a:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-63874dcd131mr928655a12.34.1759425348540; 
 Thu, 02 Oct 2025 10:15:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0XRLUdph4An6lKdwrSTORcwew/izFQmAnepuUkJ8XwxIVjp0fhwimYJkfnNZ4jKAEEiQGGg==
X-Received: by 2002:a05:6402:1e8a:b0:638:74dc:cf78 with SMTP id
 4fb4d7f45d1cf-63874dcd131mr928606a12.34.1759425347912; 
 Thu, 02 Oct 2025 10:15:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-637714115bfsm2181847a12.20.2025.10.02.10.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 04/27] hw/intc: Generalize APIC helper names from kvm_* to
 accel_*
Date: Thu,  2 Oct 2025 19:15:13 +0200
Message-ID: <20251002171536.1460049-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Rename APIC helper functions to use an accel_* prefix instead of kvm_*
to support use by accelerators other than KVM. This is a preparatory
step for integrating MSHV support with common APIC logic.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-5-magnuskulke@linux.microsoft.com
[Remove dead definition of mshv_msi_via_irqfd_enabled. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/accel-irq.h |  37 +++++++++++++
 include/system/mshv.h      |  17 ++++++
 accel/accel-irq.c          | 106 +++++++++++++++++++++++++++++++++++++
 hw/intc/ioapic.c           |  20 ++++---
 hw/virtio/virtio-pci.c     |  21 ++++----
 accel/meson.build          |   2 +-
 6 files changed, 185 insertions(+), 18 deletions(-)
 create mode 100644 include/system/accel-irq.h
 create mode 100644 accel/accel-irq.c

diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
new file mode 100644
index 00000000000..671fb7dfdbb
--- /dev/null
+++ b/include/system/accel-irq.h
@@ -0,0 +1,37 @@
+/*
+ * Accelerated irqchip abstraction
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SYSTEM_ACCEL_IRQ_H
+#define SYSTEM_ACCEL_IRQ_H
+#include "hw/pci/msi.h"
+#include "qemu/osdep.h"
+#include "system/kvm.h"
+#include "system/mshv.h"
+
+static inline bool accel_msi_via_irqfd_enabled(void)
+{
+    return mshv_msi_via_irqfd_enabled() || kvm_msi_via_irqfd_enabled();
+}
+
+static inline bool accel_irqchip_is_split(void)
+{
+    return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
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
index 342f1ef6a98..2a504ed81f2 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -22,4 +22,21 @@
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+extern bool mshv_allowed;
+#define mshv_enabled() (mshv_allowed)
+#else /* CONFIG_MSHV_IS_POSSIBLE */
+#define mshv_enabled() false
+#endif
+#define mshv_msi_via_irqfd_enabled() false
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
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
new file mode 100644
index 00000000000..7f864e35c4e
--- /dev/null
+++ b/accel/accel-irq.c
@@ -0,0 +1,106 @@
+/*
+ * Accelerated irqchip abstraction
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
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
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 133bef852d1..e431d003117 100644
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
index 767216d7959..0cdc16217ff 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -34,6 +34,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/loader.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qemu/range.h"
@@ -825,11 +826,11 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
 
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
@@ -841,7 +842,7 @@ static void kvm_virtio_pci_vq_vector_release(VirtIOPCIProxy *proxy,
 {
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
     if (--irqfd->users == 0) {
-        kvm_irqchip_release_virq(kvm_state, irqfd->virq);
+        accel_irqchip_release_virq(irqfd->virq);
     }
 }
 
@@ -850,7 +851,7 @@ static int kvm_virtio_pci_irqfd_use(VirtIOPCIProxy *proxy,
                                  unsigned int vector)
 {
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
-    return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, irqfd->virq);
+    return accel_irqchip_add_irqfd_notifier_gsi(n, NULL, irqfd->virq);
 }
 
 static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
@@ -860,7 +861,7 @@ static void kvm_virtio_pci_irqfd_release(VirtIOPCIProxy *proxy,
     VirtIOIRQFD *irqfd = &proxy->vector_irqfd[vector];
     int ret;
 
-    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, irqfd->virq);
+    ret = accel_irqchip_remove_irqfd_notifier_gsi(n, irqfd->virq);
     assert(ret == 0);
 }
 static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
@@ -995,12 +996,12 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
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
 
@@ -1229,7 +1230,7 @@ static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     int r, n;
     bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
-        kvm_msi_via_irqfd_enabled();
+        accel_msi_via_irqfd_enabled() ;
 
     nvqs = MIN(nvqs, VIRTIO_QUEUE_MAX);
 
@@ -1433,7 +1434,7 @@ static void virtio_pci_set_vector(VirtIODevice *vdev,
                                   uint16_t new_vector)
 {
     bool kvm_irqfd = (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
-        msix_enabled(&proxy->pci_dev) && kvm_msi_via_irqfd_enabled();
+        msix_enabled(&proxy->pci_dev) && accel_msi_via_irqfd_enabled();
 
     if (new_vector == old_vector) {
         return;
diff --git a/accel/meson.build b/accel/meson.build
index 25b0f100b51..6349efe682f 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,6 +1,6 @@
 common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
-system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c'))
+system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c', 'accel-irq.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.51.0


