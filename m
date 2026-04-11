Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DBEF45A12
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBO3x-00029c-T5; Fri, 10 Apr 2026 22:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3w-00028J-EO; Fri, 10 Apr 2026 22:27:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3u-0000OX-I1; Fri, 10 Apr 2026 22:27:08 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AEeCal2590966; Sat, 11 Apr 2026 02:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NrGCf/8bYetSxN9UU
 Picau0uFbfmC6ccfpRPRtmpOxo=; b=KD8i1jlK9gIH+GjMs02sxR3xCbHDWKGc8
 9TQ+mK+NvIPQACrYTa2ZE9y8VXoXoKJuk5HYKvF6iS45rJxHML5Pm30m7Pp6ekL7
 aW8dG4zrsCB8Q6IpxIjdUPNAo+IQVfSZYf0Rrw8X0ujXgTuZPD9k1kFXqCnczqHz
 4pdNUwQZFLtCNETeWm3hvAhQZjDKIXS03g4axtdtUQ58QKxAwktbqv/OFiNi5Kp/
 nmrMEoPSb+ifkqsdOXoUVWx+ULMbLQamhlXS+GkZOWbkrPO1Mk11c2jz4iqanFiD
 g+6Mx2PXBVmpHFg3RbItLBOAevXB/WfrDT4M8A8gNiapq61iEA7pw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2en5d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B16nlZ030068;
 Sat, 11 Apr 2026 02:27:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7u2a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:27:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63B2Qwvk27460308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Apr 2026 02:26:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABC185805A;
 Sat, 11 Apr 2026 02:26:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 209865805D;
 Sat, 11 Apr 2026 02:26:58 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Apr 2026 02:26:58 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2 11/15] s390x/pci: Move pal from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 10 Apr 2026 21:26:14 -0500
Message-Id: <20260411022618.2136588-12-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411022618.2136588-1-kshk@linux.ibm.com>
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8jIQ17iDpjyJtRssB4Xt4N1RkHU6_T7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX4SnXEqUV/7oN
 +tf8e885RQJ4vlkh2kKJARVHS12Ocm3dg6IdRpxgkEW7sY6uYYCx5q9O3bVAI7ABKNNGh3Pezd6
 Mu5n/Q93Fp0GegbOjF8Vffl6cpsJH2FzEFgY8df3yLjBIuaioQghRB6kH9nNtB9irqTg+AQtGS3
 yEyu6qmpBWu4GUPCBagEWrvduNKfcEe48G2OAXR7ClVdkKF12ktRhP19Dvz2MMhxoJxvCnIsXZY
 cCRmw/FZ5Mg6ORqiQDKf+izxPK63cZ6KRICg/3ruJyrkORPG1kV3BygEtypKDG+TElJUPd9QjAY
 ++MfG0UKVxg726yLnXkF18ggPR9oRolAPqimHrMMzpBGSOGyPSZkRinMKZVs6CafGX4iWhQrUKY
 yeOHS5fNxu3jdMaKMcKsKS7XCYvrAko9gSd/bevMfvBiRC1QggX9P9z4b6qhFr2sKR/agaiwyXE
 GTar1Bq0gDWNidS8BHA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d9b175 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=WfwOUNX5pORHP_P-vIkA:9
X-Proofpoint-GUID: 8jIQ17iDpjyJtRssB4Xt4N1RkHU6_T7o
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

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  8 +++-----
 hw/s390x/s390-pci-inst.c        | 12 ++++--------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 734af3a307..f339a0fd94 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -539,7 +539,6 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
                                           IOMMUAccessFlags flag, int iommu_idx)
 {
     S390PCIBusDevice *pbdev = container_of(mr, S390PCIBusDevice, iommu_mr);
-    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *entry;
     uint64_t iova = addr & TARGET_PAGE_MASK;
     uint16_t error = 0;
@@ -564,7 +563,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 
     trace_s390_pci_iommu_xlate(addr);
 
-    if (addr < pbdev->pba || addr > iommu->pal) {
+    if (addr < pbdev->pba || addr > pbdev->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -599,10 +598,9 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     uint16_t error = 0;
     uint32_t dma_avail;
     hwaddr curr, end;
-    S390PCIIOMMU *iommu = pbdev->iommu;
 
     curr = pbdev->pba;
-    end = iommu->pal;
+    end = pbdev->pal;
 
     if (pbdev->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
@@ -770,7 +768,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal + 1);
+                             name, pbdev->pal + 1);
     pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 7680d87080..191f549ba7 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -700,7 +700,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     uint32_t fh;
     uint16_t error = 0;
     S390PCIBusDevice *pbdev;
-    S390PCIIOMMU *iommu;
     S390IOTLBEntry entry;
     hwaddr start, end, sstart;
     uint32_t dma_avail;
@@ -742,7 +741,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         break;
     }
 
-    iommu = pbdev->iommu;
     if (pbdev->dma_limit) {
         dma_avail = pbdev->dma_limit->avail;
     } else {
@@ -753,7 +751,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < pbdev->pba || start > iommu->pal) {
+    if (end < pbdev->pba || start > pbdev->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -1001,7 +999,6 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     uint64_t pba = ldq_be_p(&fib.pba);
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
@@ -1027,7 +1024,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     pbdev->pba = pba;
-    iommu->pal = pal;
+    pbdev->pal = pal;
     pbdev->g_iota = g_iota;
 
     if (t) {
@@ -1041,10 +1038,9 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
 void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
     pbdev->pba = 0;
-    iommu->pal = 0;
+    pbdev->pal = 0;
     pbdev->g_iota = 0;
 }
 
@@ -1417,7 +1413,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     }
 
     stq_be_p(&fib.pba, pbdev->pba);
-    stq_be_p(&fib.pal, pbdev->iommu->pal);
+    stq_be_p(&fib.pal, pbdev->pal);
     stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_be_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 42f39a5cf0..1f5d8d4bd4 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t pal;
     uint64_t max_dma_limit;
 };
 
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     GHashTable *iotlb;
     uint64_t g_iota;
     uint64_t pba;
+    uint64_t pal;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


