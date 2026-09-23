Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1266C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NlE-0007ks-VI; Wed, 23 Sep 2026 10:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nky-0007fd-NR; Wed, 23 Sep 2026 10:15:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nkw-0005vS-SW; Wed, 23 Sep 2026 10:15:32 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8aExj2908183; Wed, 23 Sep 2026 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Qsv22XMFOF5yhoG8R
 eOO9gO1TPfKC3by84RZhK3tG88=; b=UXSHTG5mirjrfaqrPVb45+Dak9wEYLtbu
 mWzepYewfD7ocR72M+KK9L8zFjZwYov0kFZln3AzPbqGlJS4V79OZ3TlX6Sz0JP9
 U5RSeegv+FmwLMRt13TL+4V64BPVonKY1iACDeoNFYbtI8uPOFwG4zaAECEejKEu
 aHQqUxFoZyz/uNqbvqA9CJbiekeYmBtRS6DVah9T8HssyFYNFrMSMRexfEHpeLVh
 UJB91CNS8JYWOOM9YEMbAiQZ0/jl+ww8lWvX7utHBj8YYJiIOjvvHV18ZTfJToYZ
 Rfb1/osBAdVZ26j0fX3dwEed5Zoh7RquqX8CIC6nSQa39Dv6n3/eg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsbrpm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCpc6K007699; Wed, 23 Sep 2026 14:15:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2s7gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFP4g56295840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4408B58059;
 Wed, 23 Sep 2026 14:15:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 938EB58058;
 Wed, 23 Sep 2026 14:15:24 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:24 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 05/16] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 23 Sep 2026 09:15:07 -0500
Message-Id: <20260923141518.960364-6-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab3deff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=aa0cxrGLn-JNQd9UaooA:9
X-Proofpoint-ORIG-GUID: bvm3NPdi73kHoPNgk8fLuWiFriYunMvT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXznstAyH0f7aQ
 MeBSs6uUjCq9NO3BKrBhUnFMPiwCZ0pEfuw8h8TB4T59Zuya8XNFXZBp6bdoHtMvb+fWcd/ca6r
 BjDPNUoLMBhR8jLEAvRyHmFGNUosp/VnGbNw64A/c6f2j32MN2UqEZ6D6sG0d2A1bHHP2YiudTL
 MNNH0Z3zsa4QudOfhpka1OjD01Eeer9fQ8cZlJgPfEzd5ttoWnag2PL/Y9oz5kRktCSVRqaUXmd
 H1CVnTLNcqGC27lmJgvuFlYVwXPO8zIHiw2JA5eNYuHljvS0NqudhLItFHiQd0PeFSY8l3GYA56
 jKZFkyJYiWgZA+ZpKNR19qnlWOjnEKB/zQpxf2Vw0BWPSPVBcJAGa4PtyCfKLYyE8rUji9UFUqD
 v5BD0sGF2BE8FWutCRBzpVholBOxzfIBO992txP8c1Qbhu/okmdJ+WJTR9j0Fv6PxMTkuNnTzjM
 suAa8YJS21G/NFC5fqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX1ayLvUkn2y7D
 4z9ohCh3qzIwSpPm0/pAVzIWlv2pLQ5USFFwT+iBUKH7ClGtNDJHbieG5A5o9rVwPVfw7VioUOC
 ctOuxZteG5HjrxQ2wRr5lLS8Sd7cu+o=
X-Proofpoint-GUID: bvm3NPdi73kHoPNgk8fLuWiFriYunMvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
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
 hw/s390x/s390-pci-inst.c        |  6 +++---
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e1b47f3914..7c1aa260be 100644
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
@@ -687,8 +687,6 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         PCI_FUNC(devfn));
         memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
         address_space_init(&iommu->as, &iommu->mr, as_name);
-        iommu->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
-                                             NULL, g_free);
         table->iommu[PCI_SLOT(devfn)] = iommu;
 
         g_free(mr_name);
@@ -823,7 +821,7 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
-    g_hash_table_remove_all(iommu->iotlb);
+    g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
         object_unparent(OBJECT(pbdev->dm_mr));
@@ -847,7 +845,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     }
 
     table->iommu[PCI_SLOT(devfn)] = NULL;
-    g_hash_table_destroy(iommu->iotlb);
     /*
      * An attached PCI device may have memory listeners, eg. VFIO PCI.
      * The associated subregion will already have been unmapped in
@@ -1269,6 +1266,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         /* the allocated idx is actually getting used */
         s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
         pbdev->fh = pbdev->idx;
+        pbdev->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                             NULL, g_free);
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
     } else {
@@ -1311,6 +1310,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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


