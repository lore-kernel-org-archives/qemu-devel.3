Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBB4CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK86-0005QF-S7; Thu, 04 Jun 2026 22:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK83-0005MZ-Db; Thu, 04 Jun 2026 22:17:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7z-0001mv-F8; Thu, 04 Jun 2026 22:17:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Gohsq569575; Fri, 5 Jun 2026 02:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2+5lWx+qr0Jqf2r2E
 +XX+jWd3PfpTQSq5ezvrZXEdVo=; b=Bs9yiT8zFqZN3KJ7NzWFTxSR70KPXPiTF
 f1tNCU9/BRo6oC5x30XzEs/Y4oNwVxzR5cVMsQVBL7hu2/puLzBBCKPzbsvm81ez
 8NJEFe57p8xZGZZgGnZJJWqluqcK3TU+p+ZEObpnW0rQqvwPYwi9RE2Mmxfwbvoy
 vG9/XaUgoyfJxr5AlqaW5PV+YJ3hFjniRV6xV1V9HYGvuI72jIFpfqNZZ2CIPFk1
 VEwJxKYOMXpdODIEyXlftsSOlXor1ftzxDMq01I56Zf0HvA44m72+vJ/cPwFmvzO
 H8Rn2GtwuzXXlLyPcn+X7IEXML+Ii8NMY4PwVmpSY4S5HTtGXPIcg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4jkhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65529BRP029835;
 Fri, 5 Jun 2026 02:17:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyqdx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HZBB14746350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F215A58052;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C734558056;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 09/15] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu,  4 Jun 2026 21:17:22 -0500
Message-Id: <20260605021728.1125090-10-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfX4Or0oVehERJK
 b2PA5mcU8kDKY9+x3/tuJsqditRoplU2DJZwXn5WZeO+f/rqs9ydjy2XvSU77LnlsKG/+f/ucc+
 Y9SgSFIJj4+Gtima0u0QglXWAXBUki0ARURXyQsqdgOjBKe/8Ft0MGWbFyznxU1yU1ohoefPfyR
 V3Oi9njxmCsXVmTvV11CKu4edX8GSeF8Icafe7yUxpnqdQGBym5MGgqBnuIM127UaL8lcd/5IJl
 4ibVpzGYwa5SjvCWYfiQuPjYwPCW8OB/2+YIsHw5Mdaxzs9RpzAK34J/urMlM2Cx8aVjcOfG64g
 FkL8guY0Ju6geZYBcZijq4aQ0ktc7VgJPG0KvHoNctRXXbWsQQv6UqWZwyrRQkXIoFlUecOqe8V
 QShod87TtHDgw2OCcApseE6naKhiQfIPPAXQI2FkpLmtTRm06UrZofqeHNtCVa0/MfPisfg7Lr8
 ZRr6pz4hhfO/RkGWbvQ==
X-Proofpoint-GUID: Ab7YQJT5wxbHvFPslVMAeWPiZC8j7pV1
X-Proofpoint-ORIG-GUID: Ab7YQJT5wxbHvFPslVMAeWPiZC8j7pV1
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2231c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=FDQAEqGjsTQLeQouP1gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
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

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  2 +-
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f70aaf4425..3acd15ee0a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -616,7 +616,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     }
 
     while (curr < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, curr, &entry);
         if (error) {
             pbdev->state = ZPCI_FS_ERROR;
             s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, curr,
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index ac4e7f412d..f4ec299614 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -748,7 +748,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     } else {
         dma_avail = 1;
     }
-    if (!iommu->g_iota) {
+    if (!pbdev->g_iota) {
         error = ERR_EVENT_INVALAS;
         goto err;
     }
@@ -762,7 +762,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     start = sstart;
     again = false;
     while (start < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, start, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, start, &entry);
         if (error) {
             break;
         }
@@ -1028,7 +1028,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     iommu->pba = pba;
     iommu->pal = pal;
-    iommu->g_iota = g_iota;
+    pbdev->g_iota = g_iota;
 
     if (t) {
         s390_pci_iommu_enable(pbdev);
@@ -1045,7 +1045,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
     s390_pci_iommu_disable(pbdev);
     iommu->pba = 0;
     iommu->pal = 0;
-    iommu->g_iota = 0;
+    pbdev->g_iota = 0;
 }
 
 void fmb_timer_free(S390PCIBusDevice *pbdev)
@@ -1418,7 +1418,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 
     stq_be_p(&fib.pba, pbdev->iommu->pba);
     stq_be_p(&fib.pal, pbdev->iommu->pal);
-    stq_be_p(&fib.iota, pbdev->iommu->g_iota);
+    stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_be_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
     stq_be_p(&fib.fmb_addr, pbdev->fmb_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 126a50c98b..a7d1f1ade2 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
+    uint64_t g_iota;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


