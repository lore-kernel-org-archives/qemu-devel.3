Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05615CA5FF5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDstH-000597-Hv; Mon, 05 Oct 2026 20:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrn-000404-Bq; Mon, 05 Oct 2026 20:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrg-0001Gn-Sb; Mon, 05 Oct 2026 20:17:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZQ8S3658125; Tue, 6 Oct 2026 00:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4yC9t9JwTWXcVjOaF
 XgEWGY22qSFMwA6UhjVugoizJ0=; b=BhrC4WFDnSyXTCwfIqBRJBREBePkqTsI3
 Drm4SkCSeyWUY+wRYAnGrf+hZTk0jTz2JgVu3kLeyhafF6AHyEeJtXavK1DWEPEc
 dkfZA2sYjyoa7gOB0M2LIDGGfllLw0fVMUrtYEMeyWvyoNmbXcPORfG2Cm6iT6r8
 nBn0qziOgefKVY4AzwSPyI6arLmqjeY5Jqk6V7QWVuB6oq1G5fgbNP0HunBagOqg
 brhAepljhUTblW6GBOdbFlNmzl70eWBpoHFOotgutKcr/2VD3cn6+QAhr6zweiF+
 6gTYmGp7URODrhC2zNWX7trrWGHd0yJyN7x6G8Awkuh8RyremQYwg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrd3w1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695LonoU3214862; Tue, 6 Oct 2026 00:17:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jqqws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960GxMC51380580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:16:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4F8A58043;
 Tue,  6 Oct 2026 00:16:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E53E258053;
 Tue,  6 Oct 2026 00:16:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:16:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 11/17] s390x/pci: Move pal from S390PCIIOMMU to
 S390PCIBusDevice
Date: Mon,  5 Oct 2026 19:16:37 -0500
Message-Id: <20261006001643.420929-12-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
References: <20261006001643.420929-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfXzEyJCx4Ta3/s
 aidpSDmWW6sceciEYYBxGg5HBH4gOYnNO/SUEm0JbGmulyX2FnDukEB5z30f1fKPQzXedNaHRi2
 ASJzMvgNL43r8XH9vp2IVv0cyw6iOgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX7Uuyl9InYG1Y
 6BUW9cH2PjhAXlOLjpeo8xgNVysKUY4NeuVuXnH+m34F7gUyQGKyX7GyvstFQykGF4G2m60l4tY
 MJ89koMaWHsJHgvcjofsIIXFeu2FAmHwW/+2/NOqfqivVQIfcyFiVfXvtvHfZIyM4/rfWoxCNWg
 AaMyGncqdGK1HhtCMg+0Zzgv4JEkNSD8MlARS2XlajA22BnYVr8Q1JVOr7oHZ5eJqJJEAltirpa
 TSyvD+ziNSchW5dU2NRQ8B4h202evb7nHByVKAdSvD4UsbuLj/dPdZSkO/Nu73wPmx52QdyiK7e
 IY7ndCvaFXRDAd5ksjO6OqnjMNi1e1QIs4TZjouCVWBVufDTMmNqjbUhfj8ica8vwj6KKwTYhSK
 6GjIcGZeU9vdukpEwXgAY2pFHB9oxguvibIpBxk/DVVyFI70rAOMgr2IgtbJe+NXwbz7h7Lf1Yh
 JAEWYY2oPPXFs1P6dmg==
X-Proofpoint-GUID: zXKDsK3GX826OBt8DQZwTI34V30z2yHq
X-Proofpoint-ORIG-GUID: zXKDsK3GX826OBt8DQZwTI34V30z2yHq
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac43dfd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=WfwOUNX5pORHP_P-vIkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060000
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
index b0aaea49cf..799e596fec 100644
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
@@ -793,7 +791,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal + 1);
+                             name, pbdev->pal + 1);
     pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 1006b409e4..98380526d1 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -720,7 +720,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     uint32_t fh;
     uint16_t error = 0;
     S390PCIBusDevice *pbdev;
-    S390PCIIOMMU *iommu;
     S390IOTLBEntry entry;
     hwaddr start, end, sstart;
     uint32_t dma_avail;
@@ -762,7 +761,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         break;
     }
 
-    iommu = pbdev->iommu;
     if (pbdev->dma_limit) {
         dma_avail = pbdev->dma_limit->avail;
     } else {
@@ -773,7 +771,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < start || end < pbdev->pba || start > iommu->pal) {
+    if (end < start || end < pbdev->pba || start > pbdev->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -782,7 +780,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
      * aperture, clamp the request to the aperture and ignore the rest.
      */
     sstart = MAX(start, pbdev->pba);
-    end = MIN(end, iommu->pal + 1);
+    end = MIN(end, pbdev->pal + 1);
 
  retry:
     start = sstart;
@@ -1033,7 +1031,6 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     uint64_t pba = ldq_be_p(&fib.pba);
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
@@ -1075,7 +1072,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     }
 
     pbdev->pba = pba;
-    iommu->pal = pal;
+    pbdev->pal = pal;
     pbdev->g_iota = g_iota;
 
     if (t) {
@@ -1089,10 +1086,9 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
 void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
-    S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
     pbdev->pba = 0;
-    iommu->pal = 0;
+    pbdev->pal = 0;
     pbdev->g_iota = 0;
 }
 
@@ -1465,7 +1461,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     }
 
     stq_be_p(&fib.pba, pbdev->pba);
-    stq_be_p(&fib.pal, pbdev->iommu->pal);
+    stq_be_p(&fib.pal, pbdev->pal);
     stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_be_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 82e79885e4..9332763522 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t pal;
     uint64_t max_dma_limit;
 };
 
@@ -353,6 +352,7 @@ struct S390PCIBusDevice {
     GHashTable *iotlb;
     uint64_t g_iota;
     uint64_t pba;
+    uint64_t pal;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


