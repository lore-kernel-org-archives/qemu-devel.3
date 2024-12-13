Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 22:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMEYf-0001JS-0d; Fri, 13 Dec 2024 17:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEYc-0001IP-T6; Fri, 13 Dec 2024 17:54:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tMEYZ-00017i-G6; Fri, 13 Dec 2024 17:54:50 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfJwB006602;
 Fri, 13 Dec 2024 22:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qlo2jUuDVMfCCoRPQ
 xSth/J2TeHM2JP3SDaMJKAjezs=; b=Z3RMLvmD2OAqmg6tWV6wOM7lRFok5Dg1v
 uEah/hWaw6mIAL0sXacXCLqmNRdfs7IIclBa6ZX7D8Iti/jHSaXUVyxL1ePUoqGP
 kl1HvSp2HKnHF9hzNzS95Wkcx1i7sFDRChakGTJoXLQAwNOTMpgOumbK4Qsc85Vw
 CpKpUAgQI4/9vjepT2KP126cWdwC3qA+pl9I7nv0fepSfoevMqBpW3Y0vuK4+tA2
 ubIPjAHE+qbLh4bzrOF+83bJlglV+zZVN4svJKX937GCWrrlCZvqMg80/pL7TQlI
 sE4Rk+8GhksiWajm2m3BclnuSky1MvU3FYIPJCyCK/7iokc0BpcPQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9nbdgba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:54:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDKPGr4017052;
 Fri, 13 Dec 2024 22:54:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yra6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 22:54:44 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BDMshCU29753874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 22:54:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F3A958056;
 Fri, 13 Dec 2024 22:54:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7149F5803F;
 Fri, 13 Dec 2024 22:54:42 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.107.222]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2024 22:54:42 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] s390x/pci: add support for guests that request direct
 mapping
Date: Fri, 13 Dec 2024 17:54:39 -0500
Message-ID: <20241213225440.571382-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213225440.571382-1-mjrosato@linux.ibm.com>
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8oSKRZWMw_YeLPTBUmVzcaVy_-OHih6C
X-Proofpoint-ORIG-GUID: 8oSKRZWMw_YeLPTBUmVzcaVy_-OHih6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130159
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Subsequent guest DMA operations are all expected to be of the format
guest_phys+sdma, allowing them to be used as lookup into the host
iommu table.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 34 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        | 13 +++++++++++--
 hw/s390x/s390-virtio-ccw.c      |  5 +++++
 include/hw/s390x/s390-pci-bus.h |  4 ++++
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa7..95dbe0c984 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -18,6 +18,7 @@
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-vfio.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
@@ -720,16 +721,43 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
     iommu->enabled = true;
+    iommu->direct_map = false;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
 }
 
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    /*
+     * For direct-mapping we must map the entire guest address space.  Rather
+     * than using an iommu, create a memory region alias that maps GPA X to
+     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
+     */
+    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
+                                            iommu->pbdev->uid);
+    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
+                             0, ms->ram_size);
+    iommu->enabled = true;
+    iommu->direct_map = true;
+    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
+                                &iommu->dm_mr);
+}
+
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
-    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
-    object_unparent(OBJECT(&iommu->iommu_mr));
+    if (iommu->direct_map) {
+        memory_region_del_subregion(&iommu->mr, &iommu->dm_mr);
+        iommu->direct_map = false;
+        object_unparent(OBJECT(&iommu->dm_mr));
+    } else {
+        memory_region_del_subregion(&iommu->mr,
+                                    MEMORY_REGION(&iommu->iommu_mr));
+        object_unparent(OBJECT(&iommu->iommu_mr));
+    }
 }
 
 static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
@@ -1488,6 +1516,8 @@ static Property s390_pci_device_properties[] = {
     DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
     DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
                      true),
+    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_allowed,
+                     true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 41655082da..bb6f83b0c9 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -16,6 +16,7 @@
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 #include "sysemu/hw_accel.h"
+#include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     /* currently we only support designation type 1 with translation */
-    if (!(dt == ZPCI_IOTA_RTTO && t)) {
+    if (t && !(dt == ZPCI_IOTA_RTTO)) {
         error_report("unsupported ioat dt %d t %d", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
+    } else if (!t && !pbdev->rtr_allowed) {
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
+        s390_pci_iommu_dm_enable(iommu);
+    }
 
     return 0;
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 67ae34aead..0334467371 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -865,8 +865,13 @@ static void ccw_machine_9_2_instance_options(MachineState *machine)
 
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
index 2c43ea123f..27732247cf 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -277,7 +277,9 @@ struct S390PCIIOMMU {
     AddressSpace as;
     MemoryRegion mr;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion dm_mr;
     bool enabled;
+    bool direct_map;
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
@@ -362,6 +364,7 @@ struct S390PCIBusDevice {
     bool interp;
     bool forwarding_assist;
     bool aif;
+    bool rtr_allowed;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
@@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.47.1


