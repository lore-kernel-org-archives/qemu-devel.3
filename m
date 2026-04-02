Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325CD1112276
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pZ-0004o2-2o; Wed, 01 Apr 2026 22:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87os-0004E6-O1; Wed, 01 Apr 2026 22:30:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87or-0001oT-0e; Wed, 01 Apr 2026 22:30:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631Ju8Oo3941833; Thu, 2 Apr 2026 02:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ju3TdCo9F+qwi0b5K
 e4joOc8d4Yfdtaokv5jWfReqNc=; b=JXI8eCDy+HXx/CkH/39ivl89rJNXr6RyT
 Z935IZnuh8/ySeNSoxYWfYfU3odxoNTZlsbGHqjhOpwrWUlAPzlVq1ZdiWuxQjyK
 Gb9/UuFg11f3Dn2MUWahsCO9I089SNcPdZaxkxeR3+VCMenGcA84BmXi7/WaUGth
 ud3CarfkdtV4sulbbugbnAdnuzFQx2m9nwllVxAr/TsmiYocTGl3KkEH6tWdvwRh
 PM+znNitVlLAk5faiVaysnbxBA6N/tXERCFVvFhpwWoFP/zETWLoqCj7H76l+b1j
 ycmnAZTASMsCb+wdtWsHIHwM+MbskR7U3E3WdW7oWklzZ2Ff1eTOQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msa3tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:30:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63212omo030990;
 Thu, 2 Apr 2026 02:30:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk05j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322TwHX9044658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 313D0580F4;
 Thu,  2 Apr 2026 02:29:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE52580F6;
 Thu,  2 Apr 2026 02:29:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 10/15] s390x/pci: Move pba from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed,  1 Apr 2026 21:29:16 -0500
Message-Id: <20260402022921.298818-11-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cdd4a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=THYS1zffzJpO_GefUMYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfX0aMI4+kJHcRN
 Qs/BOmYaYW1YBLN+e8uN86VPZaaDBUC7pGC/8EdvgC0UW5OkO+crNOvvb9tXVp2Bsn6JzcBQHt4
 CIlbpUHFfCcsSPs6EgJU7x5H95MoHu6K1J8MN3OKo2VVgl4IC79Z94uGXKRY2zOlpmCLgDiFbtc
 YDpgziGvTRTak0i7EPxY3kawT+lEYFGiqZb7GU0+cyDJdO6Cy09gOACZPL0RKlBEA00QeB4+EO1
 QhMrT4DBVOzRgIpJvR2UOdMIQqxgjGcy3r0GaHVWbIl+ifLqYoQpulCO3LouDTRMv9hbG5/zMxs
 uFbAm8R76ZVDtCJ1EO9aS3nNpq+ug8K0u4mFZOahEzbpMS/Cn7oKmrKNQaGwS9QR1QjVi4+hZjx
 XVzUAHBPlcWHYaloxSZq/57BQ+ecAfGNctdYiD5GqIJUUOPRd3SymFZTfMGqj0f2Ev6xB/m9CVV
 4LuE0SchNer4hp1ZAcQ==
X-Proofpoint-GUID: aCmxvNOByQ4d8nyum1RP09cUn3PrBc-e
X-Proofpoint-ORIG-GUID: aCmxvNOByQ4d8nyum1RP09cUn3PrBc-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 4 ++--
 hw/s390x/s390-pci-inst.c        | 8 ++++----
 include/hw/s390x/s390-pci-bus.h | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b784196c9e..734af3a307 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -564,7 +564,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 
     trace_s390_pci_iommu_xlate(addr);
 
-    if (addr < iommu->pba || addr > iommu->pal) {
+    if (addr < pbdev->pba || addr > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -601,7 +601,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     hwaddr curr, end;
     S390PCIIOMMU *iommu = pbdev->iommu;
 
-    curr = iommu->pba;
+    curr = pbdev->pba;
     end = iommu->pal;
 
     if (pbdev->dm_mr) {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f4ec299614..7680d87080 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -753,7 +753,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
         goto err;
     }
 
-    if (end < iommu->pba || start > iommu->pal) {
+    if (end < pbdev->pba || start > iommu->pal) {
         error = ERR_EVENT_OORANGE;
         goto err;
     }
@@ -1026,7 +1026,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
         return -EINVAL;
     }
 
-    iommu->pba = pba;
+    pbdev->pba = pba;
     iommu->pal = pal;
     pbdev->g_iota = g_iota;
 
@@ -1043,7 +1043,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     s390_pci_iommu_disable(pbdev);
-    iommu->pba = 0;
+    pbdev->pba = 0;
     iommu->pal = 0;
     pbdev->g_iota = 0;
 }
@@ -1416,7 +1416,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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


