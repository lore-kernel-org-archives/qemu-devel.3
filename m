Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B8DC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nlp-0007zW-Sn; Wed, 23 Sep 2026 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nl6-0007iU-QQ; Wed, 23 Sep 2026 10:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nl2-0005ws-FS; Wed, 23 Sep 2026 10:15:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Zqrm2909163; Wed, 23 Sep 2026 14:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5msSFBZFSz3QiEZHq
 quXq9/jt6MRDepF1uzVOiQ7gzw=; b=EQl30WtOn0AY3bT4ndNFzOL0n+r0cZNC9
 TU794kwRC09GcM0ucUlUsIrtoKVbUIQjQn0pQhcIb15xadpyFVx8lElMaBhgVD8j
 oX9CwP1icpFxPTc9ybXj0qljZTL0IDHzgb/b5IaSBrJQBwxYxaGBOUM8Zeln31Y1
 dFcyaAiZJIcXAewsfpnYI+3IViAEFH457uHwRZG51e6YyTXrcR4MBoa5ev3vamed
 /xJssOw7a83fk50wGrXt6zSGf8ayJRldAUsNtnkCJrbNNN9XMhsJH4ZRLx08qt9/
 Hb63kVJ9aAXtau63FXmbmmIzdrN10gs9dqRnw+iM6Dxj1KECYIHRg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2ktss-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ND0IIh006054; Wed, 23 Sep 2026 14:15:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8s78m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFUqU28967492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D8445805B;
 Wed, 23 Sep 2026 14:15:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E3175805D;
 Wed, 23 Sep 2026 14:15:29 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:29 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 10/16] s390x/pci: Move pba from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 23 Sep 2026 09:15:12 -0500
Message-Id: <20260923141518.960364-11-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: twLXKwjVFoBrqBtkgGN6Kt19Az0DJfnL
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab3df04 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=THYS1zffzJpO_GefUMYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXxDxt30/PzDiW
 iAyGFKT/vMI9NkUIa1LUab27d0rH7WiirNPOQFM+zrRWXknBPpJNfZOBhaQl/7cifE/F35fWhyG
 9UQZCXVZYxj225Rq+PK+X1SMXj04no5h4EOhrTVjYVkAYkO+q6frGXizrF8x6w7hSqz21H8FmPa
 GMpBkg0MvIikdy6QVK6hTiNtmLlwvFegO/NGMoa1OisZHHoFisG760m6oOR1fJ13nxilOOMKdf/
 WiEnja6TXwpbR5M7nOYdNTxL6fn5aa81yHq7mp2gCtpugaXkpnCuke0oRJEm451VQdxOcWNniVI
 peez2R7/6B4uJPTr5IoEgQAP+EMv8Ki1NmuAkSGT4gXq+7vIaa9u1dgqLIKcJyKJDKGYDX1r8PN
 3M+0md7ZMiUWAYaFLprni4AtmRSDZZbSol8a5863/Ix9j0ciDioxWplE0LJqnXUiXieUc3BG09E
 qJAn8tbV4mUfDfNxH0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX7fUVYNcvII4n
 62XnqojKCUkSUGDIzc+6cFfM533uMLcqzPwPDHCd8qJohA5SwRPC5RA3sXHKqRpI0DA8D6UuAxs
 0zt7VV5wgdgrl/kJFAGKs35Z72cdkBw=
X-Proofpoint-GUID: twLXKwjVFoBrqBtkgGN6Kt19Az0DJfnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
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
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ec54eb64a6..6cf54b8ab6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -565,7 +565,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 
     trace_s390_pci_iommu_xlate(addr);
 
-    if (addr < iommu->pba || addr > iommu->pal) {
+    if (addr < pbdev->pba || addr > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -602,7 +602,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     hwaddr curr, end;
     S390PCIIOMMU *iommu = pbdev->iommu;
 
-    curr = iommu->pba;
+    curr = pbdev->pba;
     end = iommu->pal;
 
     if (pbdev->dm_mr) {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 22b477ab38..aa2bc98254 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -770,7 +770,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < start || end < iommu->pba || start > iommu->pal) {
+    if (end < start || end < pbdev->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -778,7 +778,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
      * If the specified range at least partially overlaps the registered
      * aperture, clamp the request to the aperture and ignore the rest.
      */
-    sstart = MAX(start, iommu->pba);
+    sstart = MAX(start, pbdev->pba);
     end = MIN(end, iommu->pal + 1);
 
  retry:
@@ -1054,7 +1054,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
-    iommu->pba = pba;
+    pbdev->pba = pba;
     iommu->pal = pal;
     pbdev->g_iota = g_iota;
 
@@ -1071,7 +1071,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
-    iommu->pba = 0;
+    pbdev->pba = 0;
     iommu->pal = 0;
     pbdev->g_iota = 0;
 }
@@ -1444,7 +1444,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         return 0;
     }
 
-    stq_be_p(&fib.pba, pbdev->iommu->pba);
+    stq_be_p(&fib.pba, pbdev->pba);
     stq_be_p(&fib.pal, pbdev->iommu->pal);
     stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index a7d1f1ade2..42f39a5cf0 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
 };
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
     uint64_t g_iota;
+    uint64_t pba;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


