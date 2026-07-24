Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21710C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6IG-0008DE-31; Thu, 23 Jul 2026 23:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6ID-00085C-Ep; Thu, 23 Jul 2026 23:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6IB-0008UF-Nk; Thu, 23 Jul 2026 23:09:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLfkdj4079865; Fri, 24 Jul 2026 03:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vfFDTs6fGdp+EJMIk
 HUid8s5+qzl7qPF/Bm5JSeo7Cw=; b=Sq3R0L5vdRsGHvxHvXY4FWo4Sw3DHtgwn
 lDF8nOngbK9qx0Q0PquKBWx40Nb5G/hjF04vHf9vd5G5DH2Asg//yD0pb6XNnTzU
 pyXWYZ6RRlGPQtfmtOz2OSY93yhO0myQ8++3wod99LGj++O9FcSTToUymIz1qLK2
 VwscwrgiNcRMuMjrB20vg7f3v6ywst0xfZVxLSsSX1udFng0sUAlhmUC3oPDtug0
 B27o2XVEwqBAy0dy9hnj/yBp2sDCWBvnHiBkzY2MyG5gY0cO7oCfb65dL4MLbnKk
 zohujpjKqkubQ+CbSlOoxCn8sChRzySSIS7TrGYJhZlgWOWMFBseQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gj2hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O34e9c020970;
 Fri, 24 Jul 2026 03:09:39 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqfb7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O39c0o14746228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA1A258053;
 Fri, 24 Jul 2026 03:09:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5934B58059;
 Fri, 24 Jul 2026 03:09:37 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:37 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 09/15] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu, 23 Jul 2026 22:09:13 -0500
Message-Id: <20260724030919.123733-10-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030919.123733-1-kshk@linux.ibm.com>
References: <20260724030919.123733-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX62av1oPRoaSW
 hXICsZXqSLCeWyMyXbYFtTs8UhwNmGRJnt18nhog95qniMoDmBiU5VTlqrVfGbUfwmEPu3NDJp2
 1aTBUzrhXlNxI8NhY1EOeBQp/FwzWPqW9+vLww6XzA67C+Ltf1rAfpMF8QShruQwcAJdElNWc6X
 1E19hPGIGPVKmidw+AJYb3xXpuoxFtd61PzCKE+hbIdYoUnvunPX1epERftag5lBZX1LQ9ZSU4n
 3hTBFj5V6jBXDXSxKuisxzW/LHZOo6kFs71Qs5ctaBxwnFjNhnzgSU3IGBhZwzUuyRz4KWZF23u
 fO6oRln14Fnm918mqWmIboDRr9V9pkV4zONFCl6f8ZlTaG8ma2ZWr5k47gN/M3sH2jB5sIyafRJ
 KYyL3nInamGmlQu6sc8ooAUrPKv+y4yPd/yra5ldxKPDO30QqoY1BPye+GqDrCol2hzFWtfvamE
 e2ahViWhIy5jEvqWxog==
X-Proofpoint-GUID: hnA1hqvklHhMwwlSiVyhIuhrquAzRCzU
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a62d774 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=FDQAEqGjsTQLeQouP1gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX3ucUe9936LgM
 C8EmJQ+S01VmCqIM7SLhHRz+rRJpxiLjHjqwwuOnwMaqeAr2D3RBBRNMp0mqz9lqxP47UcldosH
 zD4PMiuOMxs/nUUtMMnCb099nvrankY=
X-Proofpoint-ORIG-GUID: hnA1hqvklHhMwwlSiVyhIuhrquAzRCzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240022
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

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  2 +-
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 04bb0271e6..5180849518 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -617,7 +617,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     }
 
     while (curr < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, curr, &entry);
         if (error) {
             pbdev->state = ZPCI_FS_ERROR;
             s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, curr,
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index dc52da41b5..22b477ab38 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -765,7 +765,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     } else {
         dma_avail = 1;
     }
-    if (!iommu->g_iota) {
+    if (!pbdev->g_iota) {
         error = ERR_EVENT_INVALAS;
         goto err;
     }
@@ -785,7 +785,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     start = sstart;
     again = false;
     while (start < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, start, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, start, &entry);
         if (error) {
             break;
         }
@@ -1056,7 +1056,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     iommu->pba = pba;
     iommu->pal = pal;
-    iommu->g_iota = g_iota;
+    pbdev->g_iota = g_iota;
 
     if (t) {
         s390_pci_iommu_enable(pbdev);
@@ -1073,7 +1073,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
     s390_pci_iommu_disable(pbdev);
     iommu->pba = 0;
     iommu->pal = 0;
-    iommu->g_iota = 0;
+    pbdev->g_iota = 0;
 }
 
 void fmb_timer_free(S390PCIBusDevice *pbdev)
@@ -1446,7 +1446,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 
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


