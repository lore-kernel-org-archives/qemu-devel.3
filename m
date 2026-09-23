Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FDDC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nlq-00080F-1L; Wed, 23 Sep 2026 10:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9NlF-0007lF-Hf; Wed, 23 Sep 2026 10:15:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nl3-0005x8-KE; Wed, 23 Sep 2026 10:15:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZX7d2907145; Wed, 23 Sep 2026 14:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=OiYmCo37OvfJw+al7
 hdGi1UbPHqW0rJGezY3AISwDj8=; b=VI7qM7wpc9KRxZSYPQDOm09QD7vishn8k
 pmpW3mLgPRbbWpDXEZU0xF9Edc96V2jN6uKbJGg1CWzj8mSDa134P2l2IL5jFXkv
 SYWqoULIdjm07tAQfmfy1PoNsShoffZuy8JRo57+niydeh5vmueQ9JYMkvzHmObM
 7V/aV/sx0TNxRi0GWlXcbj+9Z67186bwOdKiy2d1Hs3r/5KqovKQLuyhELeeylJM
 lUbeBUilQwuRjyh0BxMmJBtS/blowBiJVa9PEOXKggZOk/lVJ4G78+6gtTiLkusq
 m5SE0A/6zyH9Ih7fwkKxOM2jEvsu9tYmH6viw2zUjR5r+dQdZ7OHQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsbrq2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCLick008504; Wed, 23 Sep 2026 14:15:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jsbfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFVnC28705404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 036F65805E;
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5403B5805D;
 Wed, 23 Sep 2026 14:15:30 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:30 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 11/16] s390x/pci: Move pal from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 23 Sep 2026 09:15:13 -0500
Message-Id: <20260923141518.960364-12-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab3df05 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WfwOUNX5pORHP_P-vIkA:9
X-Proofpoint-ORIG-GUID: 3b1IICAId6i-LRrS8r2VUWKWdhF37zWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX2Lh8hWg9j+Q5
 ELjhu5ZWRKGDcyhS4+V0vgiIp3KYPQRhauZ/DEX/80RXnhk+Un59tNBIz5lKMZD8Ghd1cA314O8
 XZ8N1Y1ksdbsDZNOrIWzHMMN7Gt8DVR4fIa/anTWLcbWXyi6mh7Fsc3pgAJbFQMTnQdc79QKWt8
 qE93rsnF/FsSHsa0Bamtjznzid9nzMTrU+m/4fnGixVIjTerkxgcMd3hH3AvRqawhSn6SEqsv1H
 oex1RiiDhJjiMTh9xAvzPhp9Z6MgjvIGWnTF+MeVZsG1TyIdhUidj+x74LpcQ9YzgcTzDsgHQlB
 EJabiXRdCxV2/PnVf7t09lGoldjsKs4poajPf7gt0ABZJpPVmYHoyyFvhE7kjX8x72jzFgNL2Nh
 pcUmaDoj0JMvbwF6zx2Lp72d+4UfD2gn6zJZdeFKcHeTWokosGYEjLm0Juotny6Taggr1BiWSue
 YN+AKdd6nLgnT76XwIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXw2u6Tt5HABIE
 a53XKd9xAzfBa5ZllW5StcyNvJtgUToXGu53BzqHPgeL9HTsgX+dFdW3rBleagRldXTMYy0g5Wh
 7G64ltt7qyPfqYiHtlmVME4wkpzoVIE=
X-Proofpoint-GUID: 3b1IICAId6i-LRrS8r2VUWKWdhF37zWE
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

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  8 +++-----
 hw/s390x/s390-pci-inst.c        | 14 +++++---------
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 6cf54b8ab6..79bef96c4d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -540,7 +540,6 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
                                           IOMMUAccessFlags flag, int iommu_idx)
 {
     S390PCIBusDevice *pbdev = container_of(mr, S390PCIBusDevice, iommu_mr);
-    S390PCIIOMMU *iommu = pbdev->iommu;
     S390IOTLBEntry *entry;
     uint64_t iova = addr & TARGET_PAGE_MASK;
     uint16_t error = 0;
@@ -565,7 +564,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 
     trace_s390_pci_iommu_xlate(addr);
 
-    if (addr < pbdev->pba || addr > iommu->pal) {
+    if (addr < pbdev->pba || addr > pbdev->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -600,10 +599,9 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     uint16_t error = 0;
     uint32_t dma_avail;
     hwaddr curr, end;
-    S390PCIIOMMU *iommu = pbdev->iommu;
 
     curr = pbdev->pba;
-    end = iommu->pal;
+    end = pbdev->pal;
 
     if (pbdev->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
@@ -788,7 +786,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal + 1);
+                             name, pbdev->pal + 1);
     pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index aa2bc98254..f93db10c81 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -717,7 +717,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     uint32_t fh;
     uint16_t error = 0;
     S390PCIBusDevice *pbdev;
-    S390PCIIOMMU *iommu;
     S390IOTLBEntry entry;
     hwaddr start, end, sstart;
     uint32_t dma_avail;
@@ -759,7 +758,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         break;
     }
 
-    iommu = pbdev->iommu;
     if (pbdev->dma_limit) {
         dma_avail = pbdev->dma_limit->avail;
     } else {
@@ -770,7 +768,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < start || end < pbdev->pba || start > iommu->pal) {
+    if (end < start || end < pbdev->pba || start > pbdev->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -779,7 +777,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
      * aperture, clamp the request to the aperture and ignore the rest.
      */
     sstart = MAX(start, pbdev->pba);
-    end = MIN(end, iommu->pal + 1);
+    end = MIN(end, pbdev->pal + 1);
 
  retry:
     start = sstart;
@@ -1029,7 +1027,6 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     uint64_t pba = ldq_be_p(&fib.pba);
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
@@ -1055,7 +1052,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     pbdev->pba = pba;
-    iommu->pal = pal;
+    pbdev->pal = pal;
     pbdev->g_iota = g_iota;
 
     if (t) {
@@ -1069,10 +1066,9 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
 void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
     pbdev->pba = 0;
-    iommu->pal = 0;
+    pbdev->pal = 0;
     pbdev->g_iota = 0;
 }
 
@@ -1445,7 +1441,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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


