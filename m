Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C040CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK82-0005LP-QB; Thu, 04 Jun 2026 22:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK81-0005Jj-IJ; Thu, 04 Jun 2026 22:17:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7y-0001mP-JY; Thu, 04 Jun 2026 22:17:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654KG4Qa2665699; Fri, 5 Jun 2026 02:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/8719CYMB7cCjlmQa
 PPooZc+MU3l/kHaf/Ric8dTqZU=; b=e6idUXGcQmyBxWmG//QNOUhMl/+ldZo7r
 Jz2dXCubE5SbUG7NdQ7KquA0Nyu3+YRhQoJU935HxkYeC4Q0D40deKMKfwpQvkzp
 S3wN404T4+h/ENzTzinV0dIrkZn3s3dAWsJlD3O6j94tq/HVOO+Hd5S7J0uYnurn
 qgT3VH45poJ7ibmOBDo0vxlXDKH3NS60fxySW+0QC+r5mZio5XDNwg3GeOKEcOcj
 ACfxIxDDK3kEwZEwCBMlZbcT8drn0n/gCfruCkb2YOxDO6nb/gMg0DPCPNfcm+Jo
 aQjgLgIUH0YpGeynWlhAesZ7Tqzo378Jerwh9Amgi1aDiMJ+nZDYQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtht0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65529C7u009455;
 Fri, 5 Jun 2026 02:17:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhqncf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HYnK24838682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1AE958052;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 958B75805D;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 08/15] s390x/pci: Move dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu,  4 Jun 2026 21:17:21 -0500
Message-Id: <20260605021728.1125090-9-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MTiidoZ38NgrsEzdTn-lu7MLfXkPAUwG
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a2231c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=NXusJeJlOfVlo0NZOjUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfXzuY6D0GX1BPL
 5ATzesk1Qcgq0pLVkzOUgdTG1x/EeEjHcr+e3do/ZhHdD2Nv1SH5hS2WjyzUkP/A0tC3yd4AyhD
 LjDqoRbYmmlH0pHvFfrLGJ6bWvmqeN4TULUcYtRu/SSPNBFv3DECBw0vbeyftzAQ4nd67YbVyP0
 Qf9o/nGl4E+EKj2VAh2+5cjMAIDfEuJ5fYArzTEpIsPzpxhC0kGT9uNgQh/b/Pjr0/7svWP7AEE
 EGmWcUXEqY20FmKSvOtNFzcYjOtpVJ0cb5GtnS9acWqz1IYlNRjLfh1WW0Ifkt5VupfNvLfKTgg
 2I1Ftl/9KQ5DUooHAf43z+NYP8psfDKlnqnLlXVUCYBZrHYEpHahaRW6t7ubU0ms0eGicTrk+uJ
 X7tvSCmKbChqeGiXRSm9B+fzNaCZiHqzy/YX7cTrdxkDy+vxV9PEB36/7YjDCLPPQKK8JGTVk/9
 29HTcggbUlCtixK4bTA==
X-Proofpoint-ORIG-GUID: MTiidoZ38NgrsEzdTn-lu7MLfXkPAUwG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU which purpose is just to store the "root"
AddressSpace.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 10 +++++-----
 hw/s390x/s390-pci-inst.c        | 23 +++++++++++------------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ccbccc8972..f70aaf4425 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -609,8 +609,8 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
         return;
     }
 
-    if (iommu->dma_limit) {
-        dma_avail = iommu->dma_limit->avail;
+    if (pbdev->dma_limit) {
+        dma_avail = pbdev->dma_limit->avail;
     } else {
         dma_avail = 1;
     }
@@ -1222,7 +1222,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     pbdev->forwarding_assist = false;
                 }
             }
-            pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
             if (!pbdev->interp) {
@@ -1300,8 +1300,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->fid = 0;
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
-        if (pbdev->iommu && pbdev->iommu->dma_limit) {
-            s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
+        if (pbdev->dma_limit) {
+            s390_pci_end_dma_count(s, pbdev->dma_limit);
         }
         g_hash_table_destroy(pbdev->iotlb);
         qdev_unrealize(dev);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 4458eae681..ac4e7f412d 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -28,17 +28,17 @@
 
 #include "trace.h"
 
-static inline void inc_dma_avail(S390PCIIOMMU *iommu)
+static inline void inc_dma_avail(S390PCIBusDevice *pbdev)
 {
-    if (iommu->dma_limit) {
-        iommu->dma_limit->avail++;
+    if (pbdev->dma_limit) {
+        pbdev->dma_limit->avail++;
     }
 }
 
-static inline void dec_dma_avail(S390PCIIOMMU *iommu)
+static inline void dec_dma_avail(S390PCIBusDevice *pbdev)
 {
-    if (iommu->dma_limit) {
-        iommu->dma_limit->avail--;
+    if (pbdev->dma_limit) {
+        pbdev->dma_limit->avail--;
     }
 }
 
@@ -616,7 +616,6 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *cache = g_hash_table_lookup(pbdev->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
@@ -634,7 +633,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
             goto out;
         }
         g_hash_table_remove(pbdev->iotlb, &entry->iova);
-        inc_dma_avail(iommu);
+        inc_dma_avail(pbdev);
         /* Don't notify the iommu yet, maybe we can bundle contiguous unmaps */
         goto out;
     } else {
@@ -657,7 +656,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(pbdev->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
+        dec_dma_avail(pbdev);
     }
 
     /*
@@ -667,7 +666,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
     memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
 
 out:
-    return iommu->dma_limit ? iommu->dma_limit->avail : 1;
+    return pbdev->dma_limit ? pbdev->dma_limit->avail : 1;
 }
 
 static void s390_pci_batch_unmap(S390PCIBusDevice *pbdev, uint64_t iova,
@@ -744,8 +743,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     }
 
     iommu = pbdev->iommu;
-    if (iommu->dma_limit) {
-        dma_avail = iommu->dma_limit->avail;
+    if (pbdev->dma_limit) {
+        dma_avail = pbdev->dma_limit->avail;
     } else {
         dma_avail = 1;
     }
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 24f6e60786..126a50c98b 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -279,7 +279,6 @@ struct S390PCIIOMMU {
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
-    S390PCIDMACount *dma_limit;
 };
 
 typedef struct S390PCIIOMMUTable {
@@ -353,6 +352,7 @@ struct S390PCIBusDevice {
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
+    S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
-- 
2.34.1


