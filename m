Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5A4C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZN-0007UE-Ed; Tue, 18 Aug 2026 13:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZH-0007OX-UR; Tue, 18 Aug 2026 13:25:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZG-000333-0R; Tue, 18 Aug 2026 13:25:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3xo7505700; Tue, 18 Aug 2026 17:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gf4DW/GjxGSLymiob
 Q9NFUw0/HK3IQkk/lwMTZcQD7k=; b=P7SoRmURgZ2Bbxc4k9ULk6u1P2IqbsJ9q
 K0DXdxWrpxEGaMzF47lJdrI2FwDvVsWtaJiMGCr2UJaDbKLnUM+18864AGzXOYlN
 FPcXwqniXu4Gp7NqwJALFbGjFwJJwPO9E0lwaQM3sTN1mNi1IAeMG7q9Cxdml5d9
 ekcW5Ev7D15AcGiDV9YqqhmSA5pji9vvN4coxBaHfgqrQYnwWWXYIefHjbx93SoK
 5R92Bsk2iAvur5VbQuPX+QDaoT+FtDcbOalfy/rZKBrzfw5uRN97C3GhIK4fsD5g
 fZT3pBPdQvsh5yxWoJ6FJVzcilui6mC23T4B4vWE41v39rBVnlhsw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4ssyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDkk4030506;
 Tue, 18 Aug 2026 17:25:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh4ecp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHPahG22610442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:25:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49D0D5805B;
 Tue, 18 Aug 2026 17:25:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC29458059;
 Tue, 18 Aug 2026 17:25:35 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:35 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 05/15] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
Date: Tue, 18 Aug 2026 12:25:11 -0500
Message-Id: <20260818172521.223460-6-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818172521.223460-1-kshk@linux.ibm.com>
References: <20260818172521.223460-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qYVt3MgSrFEy-hGojQ4RtiI--IfZS7Df
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a849592 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=frKy0Gi9Nncm8Rs_nZ4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX/YXv8J7eS3tI
 oRZ7ObE/G2XPMGWhjNCJsN3brtbmP1PmWXBjtwSsKTEiphdCzkxFcygMk3imtXO0mR/H7MYkjF3
 JxrKPmfGOwc0+uonImhYjNKnhERuTKo=
X-Proofpoint-ORIG-GUID: qYVt3MgSrFEy-hGojQ4RtiI--IfZS7Df
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX5L47KV15F6qA
 WlAhc0l4i/mTUGxkpg9zwjfao7umRcjdpAg33ZWdy43wYWetmzDlRAUsfNLWll0CmIg+HHYXhzn
 e+4V9+LiwHDaxunWcYR7wq+sn3c9LBgYT4SA/5qvjUB/mk1kEB4lP19PTwDC7wE8GBJZN2cDeeE
 o9DrlJkM8DRRocu6k2xnOdRasamMxTBAli0us5Js+2QPWZxX0YEABlswt+X0Yv9NuqBSZgPYtSu
 5J7D8aBsvkXnIWroghFI2jIfJlWhgTXt5kMoAELfkIVKRJCy/6Tnia0El174Ft68eG5pBDqT2NL
 1N0Vcu2WWehzR0ipP4L6gvSh3eQoPM1zCjRbOC/ZNykQvi6LxQt9lESaOKXNAqXVexrLoH1Ldiz
 TO/rEswSgzDLZmuQ6Ine7iq9vpE46VBPL/nmqhgSQUiAYgYeNbHeDiYUxK/m1sxCT5dseDP4bxh
 c/8di7wgr7wha5LHrsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
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
there to simplify S390PCIIOMMU which purpose is just to store the "root"
AddressSpace.

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
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


