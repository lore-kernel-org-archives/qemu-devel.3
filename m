Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70E7F45A12
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBO3v-000279-GR; Fri, 10 Apr 2026 22:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3t-00024M-4o; Fri, 10 Apr 2026 22:27:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3r-0000Mm-FH; Fri, 10 Apr 2026 22:27:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AFWgak2594681; Sat, 11 Apr 2026 02:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Gt8DeEfDIwQ0aIYf9
 Nv06cYAJNcblIALhEev2YCEqVo=; b=iAkqS6RAyfObAPRYcX4XM8p1S+fpxzaKq
 B6Txgc7PIeLUfdFX3XM7dCyi6LcLV1SQO39w+FplwxOahn2A1zmjkTY2qwL2l8xJ
 7IbZ2ZwvX15VKwM/Gbi/vU6fI+n/QhyX4XNNPr/KethfHUTvZFbQzhuhf5OQo9/i
 cXJjGlH2Hul0ejurlgf/IkJyrVZOrBy0xGWeUnhYe4do9nVqpaVlbDc9FK+9i288
 ybOlcb4COJ8ZfHbhxwd2Ovqn6gddK+C96ik3R3NYoQ5k5DnB+T7Q/cAVYarv2l54
 pgppQKPKSy4xxaAFRJ0TEGUTq7WN0kCL3rVgBfrB6j7Z+bhdUf1bA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2en5d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:26:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B0PKPT013878;
 Sat, 11 Apr 2026 02:26:58 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4k1r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:26:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63B2Quuk29491766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Apr 2026 02:26:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B36225805A;
 Sat, 11 Apr 2026 02:26:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2779E58054;
 Sat, 11 Apr 2026 02:26:56 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Apr 2026 02:26:56 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2 08/15] s390x/pci: Move dma_limit from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 10 Apr 2026 21:26:11 -0500
Message-Id: <20260411022618.2136588-9-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411022618.2136588-1-kshk@linux.ibm.com>
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d7EfHRl2AW2TNHvRvX17bakNsSqo_KAk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfXw/p60DVum2Tk
 XExcGoVG+kATzX+XJdN4XvkPv6KTWNhlbIXWNvkmfI1g5sPSFZ5ZXNbX4iQPey7umVF85doXTIV
 485bhmTt5dRvS+QW6ujynKthfoYKzkKNVCrySGiu7/qyQBrBgka8Nvv1K65BUguYb1/iJoebBUB
 GOQ+eoqMCWm9jt5bM42d/KA3RuRS7X/av/oYa7o19aGl/kCFvFF2fYZqE8XOgVGF0RC5I18CAyA
 Aao41FtHGdOCOYRozNN0uG692igK8hd3W8vHvB/R0vGB0pXI5l3+CTg+1+ijbeiKVqpuGW2ko4/
 WQgRLlN8RJJ1H3a1z+dnMoaMJBK2DZvtpri4O6oHyRoBz5VMnrrqTJgbx4jMCfGW427vvYFSsX7
 I4zALOVaViAWi31kwFpyy03g5IHCoxSUHh77i+qDSVOE644kSXtybBI91EMedTZVw2hu7qSgJBX
 PXxWj5+ECQ4r/fY/yxw==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d9b173 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NXusJeJlOfVlo0NZOjUA:9
X-Proofpoint-GUID: d7EfHRl2AW2TNHvRvX17bakNsSqo_KAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 27ba3c801c..4a0b31b98b 100644
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
@@ -1210,7 +1210,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     pbdev->forwarding_assist = false;
                 }
             }
-            pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
+            pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
             if (!pbdev->interp) {
@@ -1288,8 +1288,8 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
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


