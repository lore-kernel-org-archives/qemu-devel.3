Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FADE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjRu-0004g3-EM; Mon, 09 Dec 2024 14:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKjRr-0004dZ-Jv; Mon, 09 Dec 2024 14:29:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKjRo-0004Dh-4e; Mon, 09 Dec 2024 14:29:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9BmXbc022771;
 Mon, 9 Dec 2024 19:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gTByy7zFBVhyZ2vuN
 UQHRaNcrRnbpVOOX43HcFMs2jc=; b=IXc1zqTin/jp4DJMw8d/n2eGjYojsV5e3
 YnOKoGK9kVqnPuunP36984qDenThaq0ib6TEUi35wvh6w0kkD5IuuP8Qys5MQIeH
 5GLW0iTRbdRriZIgDBebdf7g1oSNRVyr9fxo/IXu69xER9e3Rl4HKCMp+fOSW+7T
 Yey6ao6Js3jMYEOrBFUW01tlfjN0GjNoXozHvtzggog7eGdCF4ANcp8ys1PC1ujV
 /ykbUvhVrqYA3QnclKT2/Eos5ql/E5Xpool1TV/a+PaW82pCmJccMZdfbSjCzZL9
 Chg+z6P53fJml1cK7X3R39EqnTNoTWb90PcK0n+mqncRisbsVdIhA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8k85r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 19:29:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IQvRF000572;
 Mon, 9 Dec 2024 19:29:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn02x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 19:29:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9JTUvJ53346752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 19:29:30 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57A0458056;
 Mon,  9 Dec 2024 19:29:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E92258052;
 Mon,  9 Dec 2024 19:29:29 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.107.222]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 19:29:29 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/2] s390x/pci: add support for guests that request direct
 mapping
Date: Mon,  9 Dec 2024 14:29:26 -0500
Message-ID: <20241209192927.107503-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192927.107503-1-mjrosato@linux.ibm.com>
References: <20241209192927.107503-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0rWHq0_BQSJEYfDna_A_IrjqGAdDhuP4
X-Proofpoint-ORIG-GUID: 0rWHq0_BQSJEYfDna_A_IrjqGAdDhuP4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
address translation.  In order to facilitiate this, pin the entirety of
guest memory into the host iommu.

Subsequent guest DMA operations are all expected to be of the format
guest_phys+sdma, allowing them to be used as lookup into the host
iommu table.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 23 ++++++++++++++++++
 hw/s390x/s390-pci-inst.c        | 42 +++++++++++++++++++++++++++++++--
 include/hw/s390x/s390-pci-bus.h |  2 ++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 40b2567aa7..8d4224e032 100644
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
@@ -720,6 +721,27 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
     iommu->enabled = true;
+    iommu->direct_map = false;
+    memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
+    g_free(name);
+}
+
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    /*
+     * For direct-mapping we must map the entire guest address space.  Because
+     * the mappings are contiguous we are not restricted to individual 4K
+     * mappings via vfio, so let's not worry about the DMA limit when
+     * calculating the range.
+     */
+    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
+                             TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
+                             name, iommu->pba + ms->ram_size);
+    iommu->enabled = true;
+    iommu->direct_map = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
 }
@@ -727,6 +749,7 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
 {
     iommu->enabled = false;
+    iommu->direct_map = false;
     g_hash_table_remove_all(iommu->iotlb);
     memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
     object_unparent(OBJECT(&iommu->iommu_mr));
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 41655082da..f4d8fe8fe8 100644
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
@@ -990,6 +991,33 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     return 0;
 }
 
+static void s390_pci_setup_stage2_map(S390PCIIOMMU *iommu)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint64_t remain = ms->ram_size, start = iommu->pba, mask, size, curr = 0;
+    uint64_t end = start + remain - 1;
+    IOMMUTLBEvent event = {
+        .type = IOMMU_NOTIFIER_MAP,
+        .entry = {
+            .target_as = &address_space_memory,
+            .translated_addr = 0,
+            .perm = IOMMU_RW,
+        },
+    };
+
+    while (remain >= TARGET_PAGE_SIZE) {
+        mask = dma_aligned_pow2_mask(start, end, 64);
+        size = mask + 1;
+        event.entry.iova = start;
+        event.entry.addr_mask = mask;
+        event.entry.translated_addr = curr;
+        memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
+        start += size;
+        curr += size;
+        remain -= size;
+    }
+}
+
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
@@ -1008,7 +1036,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     /* currently we only support designation type 1 with translation */
-    if (!(dt == ZPCI_IOTA_RTTO && t)) {
+    if (t && !(dt == ZPCI_IOTA_RTTO)) {
         error_report("unsupported ioat dt %d t %d", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
@@ -1018,13 +1046,23 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     iommu->pal = pal;
     iommu->g_iota = g_iota;
 
-    s390_pci_iommu_enable(iommu);
+    if (t) {
+        s390_pci_iommu_enable(iommu);
+    } else {
+        s390_pci_iommu_dm_enable(iommu);
+        /* If not translating, map everything now */
+        s390_pci_setup_stage2_map(iommu);
+    }
 
     return 0;
 }
 
 void pci_dereg_ioat(S390PCIIOMMU *iommu)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    if (iommu->direct_map) {
+        s390_pci_batch_unmap(iommu, iommu->pba, ms->ram_size);
+    }
     s390_pci_iommu_disable(iommu);
     iommu->pba = 0;
     iommu->pal = 0;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 2c43ea123f..2aa55e3fd0 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -278,6 +278,7 @@ struct S390PCIIOMMU {
     MemoryRegion mr;
     IOMMUMemoryRegion iommu_mr;
     bool enabled;
+    bool direct_map;
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
@@ -389,6 +390,7 @@ int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.47.0


