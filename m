Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDF61112276
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pG-0004Ym-Co; Wed, 01 Apr 2026 22:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87oq-0004DW-Tt; Wed, 01 Apr 2026 22:30:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87oo-0001ki-3S; Wed, 01 Apr 2026 22:30:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631HE4Tl2879954; Thu, 2 Apr 2026 02:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wxsDkoxMgmqPvy/Tm
 rdPLZWJFFKC712PZ5X5MHIUL4o=; b=WmuVyNnhBQ+FR3oMFwLTRMdOLRferB2Mo
 JsYmO2ydd+t3Q9R7M7VsJHrIhJRhCx/SPlIXm1txPt6Jv4gCA/JL6KwimGl8AksY
 n/LOQQUg8sl/sXWdt5rQxx/2c3EMUW5tfvza+XxMdjYg42ZmIT+0UVnoFeuWyB8C
 q49TD4SZkBWrV8vNyrnqdlfJW24+BcBdU5Veh/WoxJgZhCbqJCcIchJYpIq+ixYy
 hnnSxilKXWTRVSqLhm8GY0qR3t0wyS9n5JMfQKhm83iDAzla380FlNDn1LlgujT2
 PGv1l/wBDTULUj9onV2w6bacShwT0wKvrMkerna5z/eVqtJhl4Jpw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q3axxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6320GNVr022271;
 Thu, 2 Apr 2026 02:29:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan8a7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:56 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322Ttd854985014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 014CA580F4;
 Thu,  2 Apr 2026 02:29:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CE93580F6;
 Thu,  2 Apr 2026 02:29:54 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:54 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 05/15] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed,  1 Apr 2026 21:29:11 -0500
Message-Id: <20260402022921.298818-6-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DWhswv_bvJhkxzrkDy0MrduW2Z-ik0MK
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cdd4a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=frKy0Gi9Nncm8Rs_nZ4A:9
X-Proofpoint-ORIG-GUID: DWhswv_bvJhkxzrkDy0MrduW2Z-ik0MK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfX5ncLkFSNcdA7
 1HRVF6jP61D5L4/dzqr319xyAcbQPtsb6oxJXLEbPDK/wccYalrCupHktBV5vGdkldjWPMuy5Y/
 p4PqdcgDqrbg0It8zG6E9f3D3kxt2OSKGI7nB2d00nBoxSyac3hrRCcn529EjJbDpKIipKCsaAy
 rbaXWH6EFZ+p0kiSSOP0nOKUBdTgcHPiIVu+Zi06GYtIhNp2MIS4xrDeFoP434LxnbfHlIqoUhE
 yA2F/MSb8iPXpQHvhy4T9WOHfr0UH9ye2/Q9C5lhuE3/g0Yrj3kJfj4oiu215MISGpRHHs35q2b
 f5N1dAdoRnTz1316+kOZiJ/iJKxYoC8jOPdlYKJ5DdP1G+TttjZ8rJhbvYMD8lfvIYmohip5laR
 OeAGZr/RKXoJjAakZmTOJWs8fdaarBswmsXjMMjxP4iZNQZO0YjqQGTSlhGIVt8obTgZkMY+QRu
 zsc6IyKYUgb2OFMUbWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 117fd8136e..3f3123e62a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -569,7 +569,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         goto err;
     }
 
-    entry = g_hash_table_lookup(iommu->iotlb, &iova);
+    entry = g_hash_table_lookup(pbdev->iotlb, &iova);
     if (entry) {
         ret.iova = entry->iova;
         ret.translated_addr = entry->translated_addr;
@@ -669,8 +669,6 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         PCI_FUNC(devfn));
         memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
         address_space_init(&iommu->as, &iommu->mr, as_name);
-        iommu->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
-                                             NULL, g_free);
         table->iommu[PCI_SLOT(devfn)] = iommu;
 
         g_free(mr_name);
@@ -805,7 +803,7 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
-    g_hash_table_remove_all(iommu->iotlb);
+    g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
         object_unparent(OBJECT(pbdev->dm_mr));
@@ -829,7 +827,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     }
 
     table->iommu[PCI_SLOT(devfn)] = NULL;
-    g_hash_table_destroy(iommu->iotlb);
     /*
      * An attached PCI device may have memory listeners, eg. VFIO PCI.
      * The associated subregion will already have been unmapped in
@@ -1251,6 +1248,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         /* the allocated idx is actually getting used */
         s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
         pbdev->fh = pbdev->idx;
+        pbdev->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                             NULL, g_free);
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
     } else {
@@ -1293,6 +1292,7 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         if (pbdev->iommu && pbdev->iommu->dma_limit) {
             s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
         }
+        g_hash_table_destroy(pbdev->iotlb);
         qdev_unrealize(dev);
     }
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 834a0aec95..8349b44dd4 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -617,7 +617,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
                                S390IOTLBEntry *entry)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
+    S390IOTLBEntry *cache = g_hash_table_lookup(pbdev->iotlb, &entry->iova);
     IOMMUTLBEvent event = {
         .type = entry->perm ? IOMMU_NOTIFIER_MAP : IOMMU_NOTIFIER_UNMAP,
         .entry = {
@@ -633,7 +633,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         if (!cache) {
             goto out;
         }
-        g_hash_table_remove(iommu->iotlb, &entry->iova);
+        g_hash_table_remove(pbdev->iotlb, &entry->iova);
         inc_dma_avail(iommu);
         /* Don't notify the iommu yet, maybe we can bundle contiguous unmaps */
         goto out;
@@ -656,7 +656,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
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


