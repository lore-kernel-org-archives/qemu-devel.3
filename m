Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33ABC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZL-0007SJ-JU; Tue, 18 Aug 2026 13:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZK-0007Qx-0L; Tue, 18 Aug 2026 13:25:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZH-00034p-IB; Tue, 18 Aug 2026 13:25:45 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3qOZ401906; Tue, 18 Aug 2026 17:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tBwIMV680Eq1iyHpV
 cVzMCzP6K7Rc9h00aDItYdHsvs=; b=BCDl+4iXu0+q67PRtzzHIqbcAImJrONGF
 O/fFXNJQQeYe8Ab96+ik6YW30l5i/36cqFbiY0wwGuxeIYg6ffCKrlFlMEqBMXwo
 8rhRSKr7xXZhGm5977iDTIGLaYlEr1r7S9nh4GyrZGOnBQ3WkRgDTEklJh9c+ZAO
 6A6XW4QX3RlOFf7U5IeVQ96YeRFaKifaF6S5C209TafncxX8oAUH6XRD+9xXJ0pF
 u54ZmHOU631S2CbGaYO7DIPZQf0whHDwMVQUouZm4UUkj7jezGQHSUPGL75Q3jLS
 BgvznTHatT3fbcFmch1X2SVIOv4TLCo93KnwjRI+JT7UPbVhPEAWg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm1j8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDeNe019485;
 Tue, 18 Aug 2026 17:25:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek4fcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHPcKH13173276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:25:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FE045805D;
 Tue, 18 Aug 2026 17:25:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33EE58059;
 Tue, 18 Aug 2026 17:25:37 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:37 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 08/15] s390x/pci: Move dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Tue, 18 Aug 2026 12:25:14 -0500
Message-Id: <20260818172521.223460-9-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818172521.223460-1-kshk@linux.ibm.com>
References: <20260818172521.223460-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX2ETLjIZM38m3
 yTZfhbb9Bq1NEp1evcJv3jEI5ysx5g5aYGZZX/JAdZDbmyL8NzqVhLXGp06qE8I8eM2r84gXXUF
 NvDtsrBtcKy2VYn1cHrrZRMpz1bgGM8bEBhQrwuYcLsk+BwGjQg7aYQJyrMjo5OMW+qvqkDrpTJ
 pJw/CKekYe3mFDu5hMdc1ur83xzoCOsZN/YOgYDkdnAVTv+dHsZm+5vTifEuIaJ1qcZSaYlBmPL
 1LJLiyYP44xbDA15WXv5KdK6GsxN0meder54y9XU01VSCOHQeLiqOjyb0JobhYy0HYVoboN8tpl
 9oiAZ9Re5HM6cg+iv+1uowMG+mEeJ+r3cG4SIoq5drLfqkxsTkMB+TnIRZaeJIMe3fin1GV6GwP
 JF/zoCq5JjDKXxkvant9lnaHFh7+N3mkHREoxR+qNDK3PRsjjeTavC7Eq8ZSM4QlQ+L6O7bmhjQ
 UcdVowpTAEzGXDh3GAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX3pE2do4ezbJe
 hiovShwvK1myjSqnPwkFfsmYoCz5EikLT62RQbVDFenLv3smCz/5fcaVBmJnaG2SWVsgIQPXH3q
 luEOTSIcn3BRfZL+5IxkPl8ADNhyH5A=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a849594 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=WVqpMwhuJbQVQ5-U79kA:9
X-Proofpoint-ORIG-GUID: xT2u5dnJp-Z8AvgLLqFLFTnVGleluFcM
X-Proofpoint-GUID: xT2u5dnJp-Z8AvgLLqFLFTnVGleluFcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180125
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

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 10 +++++-----
 hw/s390x/s390-pci-inst.c        | 23 +++++++++++------------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 586dafe1e5..04bb0271e6 100644
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
@@ -1223,7 +1223,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     pbdev->forwarding_assist = false;
                 }
             }
-            pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
             if (!pbdev->interp) {
@@ -1301,8 +1301,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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


