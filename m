Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F3C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6ID-000841-0T; Thu, 23 Jul 2026 23:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IA-0007yA-Gf; Thu, 23 Jul 2026 23:09:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6I8-0008T5-IK; Thu, 23 Jul 2026 23:09:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLgAse4108956; Fri, 24 Jul 2026 03:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7N73A6PcD+EWNkKQv
 ereu8k9K4k0YmjNl10M8genbuk=; b=VpSg0JJ80MMS4uE6aMoAVJFBK/XjmvyRM
 QZLFhETPPI64vtHHtp3fAW4NAAb5CgoMf+8mMhjIE5tCFu7JcDTXUxSmNGPyYupA
 YfGy60MILwfQicT7viq4DZW/qj/rgpQcAcJ2WDEWWuAxjLrZjwuOMjHtJIvzAb5g
 e4wIb7TZQfU1NG20hM1uZksRpdDtzRwsjU7mH1+G4vk3Bh8ImpwmfIMXtLoMybMP
 K9NQL9mizN+LM1LJpRwd3guSc5Ie5LTws8rEj+wNqfTq9I5YwbStP0mCndCsdubN
 LOR7vuFiDHkq15VkEicetuwSEThj9mMwl8QlakmZYYRe9yrtjFxHA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kj4u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O34gB7017585;
 Fri, 24 Jul 2026 03:09:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk761w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O39Zgr918170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46C6258043;
 Fri, 24 Jul 2026 03:09:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB62F58061;
 Fri, 24 Jul 2026 03:09:34 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:34 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 05/15] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu, 23 Jul 2026 22:09:09 -0500
Message-Id: <20260724030919.123733-6-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030919.123733-1-kshk@linux.ibm.com>
References: <20260724030919.123733-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a62d771 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=frKy0Gi9Nncm8Rs_nZ4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX1V465Bj6ma+k
 UPLS5EGcCtP1BYERJfgg1jQaTeGL+pQ0y2/d2ZUGtoge02/9m0q1BYOqMHiXwfFCirSbPXDwrM1
 bJpjzCjvWGUdYomva0VLuvjS9mrm17z5cLl6rKnNmaLk2Sn7fIb6EP37Oxd7lSXUMmJYLfNE8e5
 kvYzm9BPANCwfXwwFnkcDRtqO7UKlNUgqsM0eBuPGOgxl3czwJxpGcpY5uqd8vY1hoxjwESZaLG
 Sh0GPG2RQVaPA1x03PpsKtSUssEi0kBSyleO1o32liyUdmn56RkHQBeB2SfSNcQ3JrKsQCfuatQ
 qtYd6DDYbMxsrD8HC0J5yuSTEx3FY9+J8vvMZnV1zx535X4+6h9G8G4UlXoWE10uR6p3rXlhplq
 R+BlW26l6vrxA3JiUeSzQtKSL1Ubc54aANKRhLi4JwcAcdim610yiSfqqvs2KxU1JDdoQ8XNURZ
 UH1CTfiM3KkL49QW+4A==
X-Proofpoint-ORIG-GUID: RyUF4df_gWUn10E_sB1T9gwxVVUVax-8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX/S+Yl6+iXLZf
 ExFHmZr2Ew48y3KqBMWgECq30BUNEmvN7iJ/7f/l/QhmO41YI8AKcd85iPhKkgf4idQ+uFr6UY4
 dPFYdObx0yBtma0BTCxNYELNg4/kdZA=
X-Proofpoint-GUID: RyUF4df_gWUn10E_sB1T9gwxVVUVax-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240022
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
 hw/s390x/s390-pci-inst.c        |  6 +++---
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5c551196bf..a08f226ef8 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -570,7 +570,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         goto err;
     }
 
-    entry = g_hash_table_lookup(iommu->iotlb, &iova);
+    entry = g_hash_table_lookup(pbdev->iotlb, &iova);
     if (entry) {
         ret.iova = entry->iova;
         ret.translated_addr = entry->translated_addr;
@@ -682,8 +682,6 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         PCI_FUNC(devfn));
         memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
         address_space_init(&iommu->as, &iommu->mr, as_name);
-        iommu->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
-                                             NULL, g_free);
         table->iommu[PCI_SLOT(devfn)] = iommu;
 
         g_free(mr_name);
@@ -818,7 +816,7 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
-    g_hash_table_remove_all(iommu->iotlb);
+    g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
         object_unparent(OBJECT(pbdev->dm_mr));
@@ -842,7 +840,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     }
 
     table->iommu[PCI_SLOT(devfn)] = NULL;
-    g_hash_table_destroy(iommu->iotlb);
     /*
      * An attached PCI device may have memory listeners, eg. VFIO PCI.
      * The associated subregion will already have been unmapped in
@@ -1264,6 +1261,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         /* the allocated idx is actually getting used */
         s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
         pbdev->fh = pbdev->idx;
+        pbdev->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                             NULL, g_free);
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
     } else {
@@ -1306,6 +1305,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         if (pbdev->iommu && pbdev->iommu->dma_limit) {
             s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
         }
+        g_hash_table_destroy(pbdev->iotlb);
         qdev_unrealize(dev);
     }
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 582e93a741..f648afb401 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -634,7 +634,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
+    S390IOTLBEntry *cache = g_hash_table_lookup(pbdev->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
         .entry = {
@@ -650,7 +650,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         if (!cache) {
             goto out;
         }
-        g_hash_table_remove(iommu->iotlb, &entry->iova);
+        g_hash_table_remove(pbdev->iotlb, &entry->iova);
         inc_dma_avail(iommu);
         /* Don't notify the iommu yet, maybe we can bundle contiguous unmaps */
         goto out;
@@ -673,7 +673,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         cache->translated_addr = entry->translated_addr;
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
-        g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
+        g_hash_table_replace(pbdev->iotlb, &cache->iova, cache);
         dec_dma_avail(iommu);
     }
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index f310672584..d9bafd6859 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -281,7 +281,6 @@ struct S390PCIIOMMU {
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
-    GHashTable *iotlb;
     S390PCIDMACount *dma_limit;
 };
 
@@ -354,6 +353,7 @@ struct S390PCIBusDevice {
     S390PCIIOMMU *iommu;
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
+    GHashTable *iotlb;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
-- 
2.34.1


