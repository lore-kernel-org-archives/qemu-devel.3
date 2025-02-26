Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17764C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOWT-0006tJ-OD; Wed, 26 Feb 2025 16:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOW7-0006h6-HG; Wed, 26 Feb 2025 16:00:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOW2-0002xp-0j; Wed, 26 Feb 2025 16:00:29 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QD7dko011682;
 Wed, 26 Feb 2025 21:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LSKm+AdxxlY7tEDmT
 t/p2pOHReWOutZQEpxp2cGXeJU=; b=a4GgEmx2WB0arDzGW4Ef3fGw5+jp2Syjv
 f5QirWgc/t0HBxPY5VKZ6UgUi0y1Zkakr+nOsktwhHHX4opof3d8wN+SKnkxlsl+
 Uza+mcA9OF176VVx9PeNAycfiNqMRaWt/2lcFlvtxnYQldXA2Bs5qU2oSIdA+Ih6
 95CcwA8FImUwbEbQ4qHUu8Srp9Z8QAKTv3btfi0Uc0nar2KAn1thXhGDLc01nN65
 U3BV4qxYX9v/boNSX/w2wchZ8EvVKYPzZwrfCM7vLoxiPQILOYs4Zb0vWGNo9Pjx
 8BFfR4QhnOgeSkI3Szo+raH68+2JacOeI6fKkZXk0/uiH6JU0xqOw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s19da1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:00:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJGVUU002548;
 Wed, 26 Feb 2025 21:00:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jvkgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:00:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51QL0GDI3474048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 21:00:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E505806A;
 Wed, 26 Feb 2025 21:00:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16C0158061;
 Wed, 26 Feb 2025 21:00:15 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.46.135]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2025 21:00:14 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] s390x/pci: add support for guests that request direct
 mapping
Date: Wed, 26 Feb 2025 16:00:12 -0500
Message-ID: <20250226210013.238349-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226210013.238349-1-mjrosato@linux.ibm.com>
References: <20250226210013.238349-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ItoOwgFNLxE7aSn5NYVF6SHS-_uQmIPI
X-Proofpoint-ORIG-GUID: ItoOwgFNLxE7aSn5NYVF6SHS-_uQmIPI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260163
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
 hw/s390x/s390-pci-bus.c         | 39 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        | 13 +++++++++--
 hw/s390x/s390-pci-vfio.c        | 23 +++++++++++++++----
 hw/s390x/s390-virtio-ccw.c      |  5 +++++
 include/hw/s390x/s390-pci-bus.h |  3 +++
 5 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 913d72cc74..9d7b0f7540 100644
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
index e386d75d58..8cdeb6cb7f 100644
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
index 7dbbc76823..443e222912 100644
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
index 51ae0c133d..a9b3db19f6 100644
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
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2c43ea123f..04944d4fed 100644
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
-- 
2.48.1


