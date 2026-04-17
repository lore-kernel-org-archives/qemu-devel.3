Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DADF4368E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgsU-0000N5-UB; Fri, 17 Apr 2026 06:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgsT-0000Mp-A0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:56:49 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgsR-0001XG-OI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:56:49 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 063B620B7128;
 Fri, 17 Apr 2026 03:56:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 063B620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423406;
 bh=/agQnXNBT1WkQmDfzU3UPBeR7shsVTN7r5KTnFUfoDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kE/Mp9sglD4u3Y+T7H/EYSbuNQFxkKd9hWWVFtf9UaBFTMOGGk8kPeFwc3cASeQVf
 IcXb1/vF4mER7Hz+UZ3tc+VMjCU6Y24E4PfPYoU4ahASH3ixljrQ8sCaCXapsp4F90
 MyYNNc/RfIBbZ5Tmsr/oXhEqB7MZnQIlbAyMdicg=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 06/34] accel/accel-irq: add generic commit_route_changes
Date: Fri, 17 Apr 2026 12:55:50 +0200
Message-Id: <20260417105618.3621-7-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
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

A generic accel_irqchip_commit_route_changes() fn has been introduced for
usage in the MSHV accelerator. The respective kvm_ fn can be removed
since we handle the commit op in a generic way.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c     | 10 +++-------
 hw/misc/ivshmem-pci.c |  2 +-
 hw/vfio/pci.c         |  4 ++--
 include/system/kvm.h  |  8 --------
 target/i386/kvm/kvm.c |  2 +-
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 3815f6727c..7e71b52555 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -45,13 +45,9 @@ int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
 
 void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
-    if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
-    }
-#endif
-    if (kvm_enabled()) {
-        kvm_irqchip_commit_route_changes(c);
+    if (c->changes) {
+        accel_irqchip_commit_routes();
+        c->changes = 0;
     }
 }
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index fa23562886..536475e9de 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -436,7 +436,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
         error_setg(errp, "kvm_irqchip_add_msi_route failed");
         return;
     }
-    kvm_irqchip_commit_route_changes(&c);
+    accel_irqchip_commit_route_changes(&c);
 
     s->msi_vectors[vector].virq = ret;
     s->msi_vectors[vector].pdev = pdev;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 35b4545482..fb20902412 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -695,7 +695,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             } else {
                 vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
-                kvm_irqchip_commit_route_changes(&vfio_route_change);
+                accel_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
             }
         }
@@ -804,7 +804,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     assert(vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = false;
 
-    kvm_irqchip_commit_route_changes(&vfio_route_change);
+    accel_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index fec24d2135..cdd1856ac5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -476,14 +476,6 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
-{
-    if (c->changes) {
-        kvm_irqchip_commit_routes(KVM_STATE(c->accel));
-        c->changes = 0;
-    }
-}
-
 int kvm_irqchip_get_virq(KVMState *s);
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 03312922d5..64cc421abe 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6690,7 +6690,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
                 exit(1);
             }
         }
-        kvm_irqchip_commit_route_changes(&c);
+        accel_irqchip_commit_route_changes(&c);
     }
 }
 
-- 
2.34.1


