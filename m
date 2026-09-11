Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C63C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534v-0008N0-WD; Fri, 11 Sep 2026 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534k-000860-Vf; Fri, 11 Sep 2026 11:22:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534Z-0004ln-Uf; Fri, 11 Sep 2026 11:21:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1laE2110298; Fri, 11 Sep 2026 15:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pltYl5lwWV7V/bm42
 aAWVKyb7sYVZXFX0MS9y26rjI0=; b=jo8Az/BMMhTFbJ9G26FYJEsg1/XjnLsLr
 5YZ3qnMNlBj/B/dTtxzbFnUT1bz6M50k9Dl7aJkBNMCaBflN5i8QcSOWD0WWNb9P
 6HPb7AmxsoFteYO1aRUAgaC2XP9XohtKP/NixDy2izSy73CIok2y+bdl3PbhoTWq
 SgtLLvXQXtTD+hw/P26PYYPkJncZ0Y/j9AMc6MHSdDtVTFLskfam2b9uN59+Ebs2
 LEVl1IswcZJAmWEYDazCYW7u5msaK5Nxaf1lHryfMyhmMM9MVC8B//KYgBLEPrat
 FkqhkKFnrFL/2ULrjmhjX1Whc3DL1+KC5t5RDRXFGodwiP8lfPAXw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pvcy8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo72w1834064; Fri, 11 Sep 2026 15:21:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhq3fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLfhU20972094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4EFF58058;
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DEB858063;
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 08/16] s390x/pci: Move dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 11 Sep 2026 10:21:29 -0500
Message-Id: <20260911152137.676602-9-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa41c87 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WVqpMwhuJbQVQ5-U79kA:9
X-Proofpoint-ORIG-GUID: bKOzPgoE8wLtt9THHDhUatLDB5g9flzd
X-Proofpoint-GUID: bKOzPgoE8wLtt9THHDhUatLDB5g9flzd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX7W8niPjIUJw2
 d766KRW6cRrxmMMMmb/2+NJeXZ6AwJgk0LQV9HLC/t85QhyNJi65k4+ewC6k3OeicDgmMcftTgP
 QVVsy5cdUljw/ror+atWjKv4FEVZWSw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX9GgO2l57QeIL
 1t4StIXteEIhhh1yxQpgujYGJTG0umfHGXFr/urQF7+k1NmNd2WDKQYb6RsvzfS818tY/5ExtZh
 U3BGrSHENBA4OS3L2a1S38IS9VzJuNW0YRAhtYt0wrpuKMqx7IaqXtrUNNBtx5eMlfzJqTFA4u+
 pwe3TMhuOFnOFKBemyRqi08RxCAIy2fjk3y8qZbRXhrSeTWaJIRT+zL/IzbDV7GbvWih68y9yAO
 KyIXdbg3hsOoe0geHZXrOiZyPPfyn+laS2YhRVQduspn3AVG5p08oipR+wd2aP36adwhLR6pS2l
 89X4A0q817CJJAiFKrNzXMVRS/olWsVok0WUIPHrJi5jIDcQbiujpbSoxejzY0fJqVMm/miWFnR
 2hoipKlC4pM7mggUmOUiH0DYCYuXCYZ/eANDg0x/JZTf2j8WGUk2sA3Cg1CFpxGsFC0V8/MAmRg
 9EFLKFcVT+cDRPDjWTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
there to simplify S390PCIIOMMU towards a structure that contains only the
IOMMU container information needed by the PCI layer for a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 10 +++++-----
 hw/s390x/s390-pci-inst.c        | 23 +++++++++++------------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ee05447084..ad4f527430 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -610,8 +610,8 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
         return;
     }
 
-    if (iommu->dma_limit) {
-        dma_avail = iommu->dma_limit->avail;
+    if (pbdev->dma_limit) {
+        dma_avail = pbdev->dma_limit->avail;
     } else {
         dma_avail = 1;
     }
@@ -1228,7 +1228,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     pbdev->forwarding_assist = false;
                 }
             }
-            pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
             if (!pbdev->interp) {
@@ -1306,8 +1306,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
index 7081be4619..dc52da41b5 100644
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
 
@@ -633,7 +633,6 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *cache = g_hash_table_lookup(pbdev->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
@@ -651,7 +650,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
             goto out;
         }
         g_hash_table_remove(pbdev->iotlb, &entry->iova);
-        inc_dma_avail(iommu);
+        inc_dma_avail(pbdev);
         /* Don't notify the iommu yet, maybe we can bundle contiguous unmaps */
         goto out;
     } else {
@@ -674,7 +673,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
         g_hash_table_replace(pbdev->iotlb, &cache->iova, cache);
-        dec_dma_avail(iommu);
+        dec_dma_avail(pbdev);
     }
 
     /*
@@ -684,7 +683,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
     memory_region_notify_iommu(&pbdev->iommu_mr, 0, event);
 
 out:
-    return iommu->dma_limit ? iommu->dma_limit->avail : 1;
+    return pbdev->dma_limit ? pbdev->dma_limit->avail : 1;
 }
 
 static void s390_pci_batch_unmap(S390PCIBusDevice *pbdev, uint64_t iova,
@@ -761,8 +760,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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


