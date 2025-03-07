Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6693AC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWHF-0002QW-Gg; Fri, 07 Mar 2025 06:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWHD-0002PX-D5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWHB-0000ND-Ar
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdZJenEy80PQuP0HMGPq24Ow0Y3p5xVvgW0zoHhCcBY=;
 b=jV4zRsdfL+MSfJ9jVaVKfbWsQcZO11/U8ttObyng4g+FMlJT2AKk2ZHCd3ohbKQyzPf/u/
 O5t8AxgnwQJOYp04tmVEYdtyNCaK8HsVd4NrL11ejI/g/ZpkUrntMXnx3Lfo3KLh664Sts
 ttOn7hCfJOXTXx8xxhTmeNm9mjUc7CM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-qmyjsjg5NY6uGvuk_Kvt6Q-1; Fri,
 07 Mar 2025 06:53:59 -0500
X-MC-Unique: qmyjsjg5NY6uGvuk_Kvt6Q-1
X-Mimecast-MFC-AGG-ID: qmyjsjg5NY6uGvuk_Kvt6Q_1741348438
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DC58180AF52; Fri,  7 Mar 2025 11:53:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A2501944F2E; Fri,  7 Mar 2025 11:53:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 14/15] s390x/pci: add support for guests that request direct
 mapping
Date: Fri,  7 Mar 2025 12:53:13 +0100
Message-ID: <20250307115314.1096373-15-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
bit set, treat this as a request to perform direct mapping instead of
address translation.  In order to facilitate this, pin the entirety of
guest memory into the host iommu.

Pinning for the direct mapping case is handled via vfio and its memory
listener.  Additionally, ram discard settings are inherited from vfio:
coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
discards (e.g. virtio-balloon) are disabled.

Subsequent guest DMA operations are all expected to be of the format
guest_phys+sdma, allowing them to be used as lookup into the host
iommu table.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20250226210013.238349-2-mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-pci-bus.h |  3 +++
 hw/s390x/s390-pci-bus.c         | 39 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        | 13 +++++++++--
 hw/s390x/s390-pci-vfio.c        | 23 +++++++++++++++----
 hw/s390x/s390-virtio-ccw.c      |  5 +++++
 5 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2c43ea123f0..04944d4fed7 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -277,6 +277,7 @@ struct S390PCIIOMMU {
     AddressSpace as;
     MemoryRegion mr;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
     uint64_t pba;
@@ -362,6 +363,7 @@ struct S390PCIBusDevice {
     bool interp;
     bool forwarding_assist;
     bool aif;
+    bool rtr_avail;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
@@ -389,6 +391,7 @@ int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 913d72cc748..9d7b0f75407 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -18,6 +18,8 @@
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-vfio.h"
+#include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
@@ -724,12 +726,42 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
     g_free(name);
 }
 
+void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
+
+    /*
+     * For direct-mapping we must map the entire guest address space.  Rather
+     * than using an iommu, create a memory region alias that maps GPA X to
+     * IOVA X + SDMA.  VFIO will handle pinning via its memory listener.
+     */
+    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
+                                            iommu->pbdev->uid);
+
+    iommu->dm_mr = g_malloc0(sizeof(*iommu->dm_mr));
+    memory_region_init_alias(iommu->dm_mr, OBJECT(&iommu->mr), name,
+                             get_system_memory(), 0,
+                             s390_get_memory_limit(s390ms));
+    iommu->enabled = true;
+    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
+                                iommu->dm_mr);
+}
+
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
-    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
-    object_unparent(OBJECT(&iommu->iommu_mr));
+    if (iommu->dm_mr) {
+        memory_region_del_subregion(&iommu->mr, iommu->dm_mr);
+        object_unparent(OBJECT(iommu->dm_mr));
+        g_free(iommu->dm_mr);
+        iommu->dm_mr = NULL;
+    } else {
+        memory_region_del_subregion(&iommu->mr,
+                                    MEMORY_REGION(&iommu->iommu_mr));
+        object_unparent(OBJECT(&iommu->iommu_mr));
+    }
 }
 
 static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
@@ -1145,6 +1177,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             /* Always intercept emulated devices */
             pbdev->interp = false;
             pbdev->forwarding_assist = false;
+            pbdev->rtr_avail = false;
         }
 
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
@@ -1510,6 +1543,8 @@ static const Property s390_pci_device_properties[] = {
     DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
     DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
                      true),
+    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_avail,
+                     true),
 };
 
 static const VMStateDescription s390_pci_device_vmstate = {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index e386d75d58c..8cdeb6cb7f7 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -16,6 +16,7 @@
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 #include "system/hw_accel.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     /* currently we only support designation type 1 with translation */
-    if (!(dt == ZPCI_IOTA_RTTO && t)) {
+    if (t && dt != ZPCI_IOTA_RTTO) {
         error_report("unsupported ioat dt %d t %d", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
+    } else if (!t && !pbdev->rtr_avail) {
+        error_report("relaxed translation not allowed");
+        s390_program_interrupt(env, PGM_OPERAND, ra);
+        return -EINVAL;
     }
 
     iommu->pba = pba;
     iommu->pal = pal;
     iommu->g_iota = g_iota;
 
-    s390_pci_iommu_enable(iommu);
+    if (t) {
+        s390_pci_iommu_enable(iommu);
+    } else {
+        s390_pci_iommu_direct_map_enable(iommu);
+    }
 
     return 0;
 }
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7dbbc76823a..443e2229127 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -131,13 +131,28 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
+    /*
+     * If the device is a passthrough ISM device, disallow relaxed
+     * translation.
+     */
+    if (pbdev->pft == ZPCI_PFT_ISM) {
+        pbdev->rtr_avail = false;
+    }
+
     /*
      * If appropriate, reduce the size of the supported DMA aperture reported
-     * to the guest based upon the vfio DMA limit.
+     * to the guest based upon the vfio DMA limit.  This is applicable for
+     * devices that are guaranteed to not use relaxed translation.  If the
+     * device is capable of relaxed translation then we must advertise the
+     * full aperture.  In this case, if translation is used then we will
+     * rely on the vfio DMA limit counting and use RPCIT CC1 / status 16
+     * to request that the guest free DMA mappings as necessary.
      */
-    vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
-    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
-        pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
+    if (!pbdev->rtr_avail) {
+        vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
+        if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
+            pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
+        }
     }
 }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 51ae0c133d8..a9b3db19f63 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -936,8 +936,13 @@ static void ccw_machine_9_2_instance_options(MachineState *machine)
 
 static void ccw_machine_9_2_class_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] = {
+        { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
+    };
+
     ccw_machine_10_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(9, 2);
 
-- 
2.48.1


