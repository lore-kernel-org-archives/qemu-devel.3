Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610C1CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ea-0000ta-T7; Fri, 26 Jun 2026 06:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ds-0007O1-6I
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dq-0005Bw-3v
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LjjbSWd3wzg6wKy/nHkbp/LpCSoNcT1KOWYYF7ZfsKs=;
 b=H5qus9oMVoTpQR9xMWNLy0P1SDEmF0Z6x82aJxxCkU21lGb/hVBWI1P78LNEtRLugHOY/B
 XBfdbCsJIGS57tbc+Ql4v7jeOJcFQ+CZEQjbnbKFCauXyOtwoomGKI2L7DUyTpCV4kn6Hn
 JZYieds3/67J4AWI7l6x3zuWfoWrHn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-p8fRSnqdMAadhLoUdLvJSA-1; Fri, 26 Jun 2026 06:18:31 -0400
X-MC-Unique: p8fRSnqdMAadhLoUdLvJSA-1
X-Mimecast-MFC-AGG-ID: p8fRSnqdMAadhLoUdLvJSA_1782469110
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49244130073so5949795e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469110; x=1783073910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LjjbSWd3wzg6wKy/nHkbp/LpCSoNcT1KOWYYF7ZfsKs=;
 b=fpv+VquRUo+y600+sy7R7f3EgyG4FXUugbAA++qz6rt9AW+ymXe9k6/AreYu79fcTb
 G72zfJ/dGk1kDVxSYk+K4ul+4gaPxDJUdqyn6YlabMyyoceqrVyfVChy3gC2dqeS6yRj
 FCVbxx8OfuDfNGlQVl9iXQfTvUFmy+UnUPfiOARVGlD0ICSh+BdylcofYHQ9PY/3BKRq
 7Q4ShjwUYlfMdAf2O/ptYP7MhoWoH+gFp3lpy2Gu/fkpiZo9jGK79TLEa9sGRqzwwbiP
 bd/x8WEi2xcGjd/2OFF51sfD/77F/QDfOBZzHqR+awxMtDdypl/FTo2aqrRUpsTDyhYO
 9DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469110; x=1783073910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LjjbSWd3wzg6wKy/nHkbp/LpCSoNcT1KOWYYF7ZfsKs=;
 b=iI9EiHfcIoPP7Ovu4Vyo45/ms+Jm7t0Et+ZTBAG2R9aeOYve4iwqlDsviKiPW82G2v
 UXnzP1QyGUGtFqoWMTJNiQc15yVFZPknHqim1I1AqQckQKHdlCwPsoMrt9/W1tGwiC2E
 Y8vxlMexebtynSpSo8dZ7iIJhWo4MBQEQWn0EU4mKoBm/2yRLMDzxbChXsdE/r0WY+7C
 k1guc5xKNuTY8rHFJQ5ofQx9C2EO0grdIPhWiu3JnNzW5Jpu0pDhfnDhK9yowP80Ze9r
 +D0HewAE//P0NWW1LAGCngYsncRolkMTDRPZ9noyR/n7vakk63p9lk2ogblvaqTfhhA8
 IxBw==
X-Gm-Message-State: AOJu0YxYQg7w1jBnaRDxEpWcigxBllKmK+3wfSDGD78BTAQDX877REGN
 YgAHZD7d04o5YyzxbnBzFM2+bHdCclXaInlQQo+KLt8xFnn3lY70uBkuozHK7n2XrPrO6XdRljw
 NUtnd2wbXU/QTUoZLEY1qSpTnqMHD7zQBBzf1Say92SLVKS1qNj1hvBaQjhQfwNgreXg5ZIBzuo
 ORZuHGRP8hqbp2cKNJ1qHHiM5LMo5hEmeyc18xLX+R
X-Gm-Gg: AfdE7cmak5QauqPaFDYk4bwVt8RUYzai+rOiSLGm7/CujKZ8CuHoZ14jioTH31oRrGZ
 Ugs5a07ZUbTnq4jM7bSH+7gosYDPeB7w223rO7d/q6RoAUDfEJFQz65I7aBUKbijxmzivmqQtQK
 eH4kbV/jzS2nNbdkd3SDp0Er9ti5fWdCVHpsvHG4eGBG8sVyleLDzMkkXdzFaFymP+fUsp7HQD5
 HHoAnwYJWEFPPVS1gzANwf2oa2GUF834UjNd6jc9w/8JmGyah+9oLT1IzzKSodA1IdBF9YJRtMf
 dvK81HlrTONoWStq/1McfpujdjPVC8fWsFP9wr24oViEcAHHOmaRqU7EDBD9hFOPWtOkd4Q7vjB
 0CBismjfacICjHxispEo3Gzx2lyG/clcSsaM5gbe6DFoyzA0X7n7xbS0cfi5fkPuBAitDEuSEpX
 djfvOoY4UsXyr6Nyke
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-492668638c1mr71801195e9.8.1782469110047; 
 Fri, 26 Jun 2026 03:18:30 -0700 (PDT)
X-Received: by 2002:a05:600c:c1d7:10b0:492:4667:8c40 with SMTP id
 5b1f17b1804b1-492668638c1mr71800785e9.8.1782469109593; 
 Fri, 26 Jun 2026 03:18:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93eesm22899912f8f.20.2026.06.26.03.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 14/45] accel/accel-irq: add generic begin_route_changes
Date: Fri, 26 Jun 2026 12:17:17 +0200
Message-ID: <20260626101748.1728079-15-pbonzini@redhat.com>
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

A generic accel_irqchip_begin_route_change() fn has been introduced for
usage in the MSHV accelerator. It replaces the respective kvm_ fn.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-6-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/accel-irq.h |  1 +
 include/system/kvm.h       |  8 --------
 accel/accel-irq.c          | 21 +++++++++++++++++++++
 hw/misc/ivshmem-pci.c      |  4 ++--
 hw/vfio/pci.c              |  5 +++--
 hw/virtio/virtio-pci.c     |  2 +-
 target/i386/kvm/kvm.c      |  3 ++-
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index a1489207113..fc94c54264b 100644
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
index ccf90b83416..fec24d2135a 100644
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
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0aa04c033d4..3815f6727c6 100644
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
index aa8f2717555..fa23562886b 100644
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
index 1817f39cde7..3a6e17c9d77 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -38,6 +38,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "pci.h"
@@ -688,7 +689,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             if (vdev->defer_kvm_irq_routing) {
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
             } else {
-                vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+                vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
@@ -789,7 +790,7 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
-    vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+    vfio_route_change = accel_irqchip_begin_route_changes();
 }
 
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 90df7bf3a1a..6f5db5fc42b 100644
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
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 478a5573cd2..03312922d50 100644
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
@@ -6678,7 +6679,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.54.0


