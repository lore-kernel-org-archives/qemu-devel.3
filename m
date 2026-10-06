Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2965CA5FF5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDst3-0004DS-BG; Mon, 05 Oct 2026 20:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrc-0003xw-Fj; Mon, 05 Oct 2026 20:17:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsra-0001FV-8P; Mon, 05 Oct 2026 20:17:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZhFk058216; Tue, 6 Oct 2026 00:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QGsaNCKuSazr87C49
 FLWK30VwoVlstUxfAAAhb29GDg=; b=sEo6bgTccJmk1QuEDcsm4fQvEcxdJUfos
 1crta6r92gQvVK4+1tmHXe7eGgim4cgK6ildi9eHsTwxvam2PCDCWYJQv9oHqvjZ
 4WptuA9JbiGwBzrITigdNrRjxXI0gBs8Wr6hbSWHhAvYy4ot6zJE+wNFaKTJr1Y8
 wQSMtdWB57Z/Oq58UEsWWB1SxMOvsiS8OHzAmG3VFi01z8+WfoEMXRQbk6aJZ4qM
 CDQ0/gDVKzv7GOgV5e+LOHaQ3lnBiacA3Hvpuf6u/E7TMrCZP5pNurGKJGfXIalR
 ICk1Z3HWOikXqJcCOHcUxF2mfTzn1lrvO0Z0lBFol75lmbKsBEy+g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fvgga-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695LsAIa3280687; Tue, 6 Oct 2026 00:16:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgqnkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960Gr8M7799748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:16:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECBBE58043;
 Tue,  6 Oct 2026 00:16:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE3DD58053;
 Tue,  6 Oct 2026 00:16:51 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:16:51 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 05/17] s390x/pci: Move iotlb from S390PCIIOMMU to
 S390PCIBusDevice
Date: Mon,  5 Oct 2026 19:16:31 -0500
Message-Id: <20261006001643.420929-6-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
References: <20261006001643.420929-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac43df6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=aa0cxrGLn-JNQd9UaooA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX2NU9hTyY7m0B
 xa6Ucz0zDRJ2B4uLb86pv63FCGILCMDo37YT6mEwTIDqMRHlZrvfiqDvy5uyZSwDBc3/PMAD9Xo
 H2YwlOmcxhI+mxQATYKd5Migm23moojPZQptZ9/RMg0uCNZrQl0hSKDs1xzuA3DcGadGzA0ieJ6
 BUup7Xiprr9yVub2X0lOo1mxS6d58G8vIxB/l9d8QshWOy/8HxlK5nQW5nW8HFB2WX0L7Kwywq9
 +LrQhm9DMnWuGSvJ3cvQaHgVnR/fXwzj6GZdg+BmNyVdHm8toTUWYT8jZ1RO+36BzvKs+TLN8k6
 AFmAOrNYPP0GR5Vo+iea0sdQqViV03/JlXUBm3F2Yd6dMfSKQeXGrg9RBGXveZ1wy15BtvccCLn
 uDvKliqEjGn9D3fQS2Ka6qckaE51YE0+gnGTwr1v+N3jMqWniIg7TOKaiU8QIIvcNbFGYucfgKo
 hmvWcmPnm0GOaRWMUBA==
X-Proofpoint-GUID: 1aApnW4wQUzS8oeXEgdekULomoCp5Gq8
X-Proofpoint-ORIG-GUID: 1aApnW4wQUzS8oeXEgdekULomoCp5Gq8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX306pfRgUH2t5
 s69B55p4ekodWuZspTGFu2l1ynzd/b7M6Y/KSxPMeoWvm92UoOyYjxjwWaoLQ+aD7fCiWiN40Yr
 /vqnN9sSwgisy85zujeNXQtx/pNj0FQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060000
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
index 99122716d7..850b4452a5 100644
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
@@ -692,8 +692,6 @@ static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
                                         PCI_FUNC(devfn));
         memory_region_init(&iommu->mr, OBJECT(iommu), mr_name, UINT64_MAX);
         address_space_init(&iommu->as, &iommu->mr, as_name);
-        iommu->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
-                                             NULL, g_free);
         table->iommu[PCI_SLOT(devfn)] = iommu;
 
         g_free(mr_name);
@@ -828,7 +826,7 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
-    g_hash_table_remove_all(iommu->iotlb);
+    g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
         object_unparent(OBJECT(pbdev->dm_mr));
@@ -852,7 +850,6 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     }
 
     table->iommu[PCI_SLOT(devfn)] = NULL;
-    g_hash_table_destroy(iommu->iotlb);
     /*
      * An attached PCI device may have memory listeners, eg. VFIO PCI.
      * The associated subregion will already have been unmapped in
@@ -1274,6 +1271,8 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
         /* the allocated idx is actually getting used */
         s->next_idx = (pbdev->idx + 1) & FH_MASK_INDEX;
         pbdev->fh = pbdev->idx;
+        pbdev->iotlb = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                             NULL, g_free);
         QTAILQ_INSERT_TAIL(&s->zpci_devs, pbdev, link);
         g_hash_table_insert(s->zpci_table, &pbdev->idx, pbdev);
     } else {
@@ -1316,6 +1315,7 @@ static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *
         if (pbdev->iommu && pbdev->iommu->dma_limit) {
             s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
         }
+        g_hash_table_destroy(pbdev->iotlb);
         qdev_unrealize(dev);
     }
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f9907c7d5c..30114abd43 100644
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
@@ -677,7 +677,7 @@ uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev,
         cache->translated_addr = entry->translated_addr;
         cache->len = TARGET_PAGE_SIZE;
         cache->perm = entry->perm;
-        g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
+        g_hash_table_replace(pbdev->iotlb, &cache->iova, cache);
     }
 
     /*
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index b74cc654bb..7fbe80be16 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -282,7 +282,6 @@ struct S390PCIIOMMU {
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
-    GHashTable *iotlb;
     S390PCIDMACount *dma_limit;
 };
 
@@ -355,6 +354,7 @@ struct S390PCIBusDevice {
     S390PCIIOMMU *iommu;
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
+    GHashTable *iotlb;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
-- 
2.34.1


