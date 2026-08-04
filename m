Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D536DC55182
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr59W-0005kK-NV; Mon, 03 Aug 2026 22:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59N-0005g4-C0; Mon, 03 Aug 2026 22:45:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59J-0005Dn-P9; Mon, 03 Aug 2026 22:45:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741I0ia3572554; Tue, 4 Aug 2026 02:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2hK24WnXB6VxFKT3Q
 Fo9AHd3o5qFYlYhxda9U5RnhVI=; b=Ip0XvWy7ROwkJ/wCr0Apg6m7fTP9aBL4n
 c2ygtdsKaCPFXdTRXnBbBwaxX2Ty3K4Vx7Z+33MbqkoNSubHRkba38O71p/k2DOY
 VjRxiFOorJAZDher4ECfJZy4nFlp3gVRSmKNob9ay+QgjWDk8lfXIY4uTqgzBf9g
 Ic7Aib1JIeqRLKERmS0OSxEv5j8ITU1/myHuaE74e20MQNTLrhp6TNC89hsh0nX/
 acKVRcI09qbgeKBjE8Tnmfeem5SSAlu30V64Ef4F2I1ZMpQyRmhVz982RDZmbYAb
 nrAKlkR0Mqpb/xlXe7NIfzihZCz2UzCkie+9347CaXWKfGIz4zN5A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hknrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6742fHtv025966;
 Tue, 4 Aug 2026 02:44:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyfukf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6742iuIO21431036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 02:44:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68C515805F;
 Tue,  4 Aug 2026 02:44:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C249E5805E;
 Tue,  4 Aug 2026 02:44:55 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.58])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 02:44:55 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 10/15] s390x/pci: Move pba from S390PCIIOMMU to
 S390PCIBusDevice
Date: Mon,  3 Aug 2026 21:44:38 -0500
Message-Id: <20260804024443.56445-11-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804024443.56445-1-kshk@linux.ibm.com>
References: <20260804024443.56445-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfX0dv30eaeebkA
 OAEGDrnFL041hs52ojt2LRMTZGHrbTfKqk3sEL3PukN5H+mXBNJ+G+oGSETZnU+cFgWLsC91GGS
 Dy9iXfneZDDV7YC2WS2Z6djg2bca1wM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a71522a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=THYS1zffzJpO_GefUMYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfXywXLb0ebbDRs
 0+in3m0qt+GKg+27d3AGIIlVOyhJuYscZG728+iHop9F3QgHWsAQOadM1ataxEpz91KXBkxmj7G
 uNVwrNjDENAEhsagZ2kKl/V0AGYk87Fd5ga2Q2kLPF6PR/7JMACfzTp5sWnIKlfyhuNcQ3Vf1/t
 cyFI9yDQlryW0fLyalyA4O0+kpSLtZYxNqRBZH8tW7OKDdV924tmH++t4cenuF9bIayT4M41/5L
 oda0TySraGusUF3rGjB8ASuG+jUL/HBdmkhR3dZ8M7v6WpWnsKnGSGKTRTvvgJw5VzU500ZWVr0
 2hH4OFMRP/HZukOqUWqzD1Ai+hXOX9/6bPJWIC/M8452pz8xKr6179XN2xZJBS+oJfEpdShSo2l
 0fmjmNnjjGlm/X4INEGqmSDr5MVjdfQo2QrzWC5+Ob0oY6Yxl8U0XbgRFVs3rekI3Kw1AztC2NS
 Vfzo08vsU6DjQQrB/Nw==
X-Proofpoint-ORIG-GUID: PC5Tn2g6lYQXwYffUOOy5bE4VvYz6IOi
X-Proofpoint-GUID: PC5Tn2g6lYQXwYffUOOy5bE4VvYz6IOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  4 ++--
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 5180849518..2309afcfa6 100644
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


