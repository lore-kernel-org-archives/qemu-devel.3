Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF30C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534q-0008DY-6u; Fri, 11 Sep 2026 11:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534e-00080D-Op; Fri, 11 Sep 2026 11:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534Z-0004ku-Rk; Fri, 11 Sep 2026 11:21:56 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1PSS2126785; Fri, 11 Sep 2026 15:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Mkz/yDDmhQPp29Ok9
 p/9oSsXjFEyn86PqLErF/k+nuQ=; b=b5164UBo2xsKMZHsYwUJcZlp711MW7Jkg
 J3D33PeY8S0J9TbUz0XsTktse1giGrNB5Z6LP6rUHAp+rWNIPRNs6avY8NOEs22n
 exJ4MWyEwbG6UpRbIz/xr+kOYAVgtL506xUCFlrCXuojsjZUPD+WCP0NKqvDuyFq
 lMdmKc1lQsJ3AbQWIKl1zc5RT5B1Xrg18JsxiG8NyI1/tnnAziFFJFbu0+EptLnu
 1AaY/xHq9EWbB/vsxjmNWiF0oPURiZJnmou+NEEZtbbP1KqVJ8HMkXzAxaQa9nT1
 zhVWMYTblnmlKKFkoHrRfq9IquZRfXMsptVCMNRGRL/TrSi1xRI/Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qvbay-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo8p81789313; Fri, 11 Sep 2026 15:21:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk71sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLglC59572544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07D3058058;
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE34A58062;
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 09/16] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 11 Sep 2026 10:21:30 -0500
Message-Id: <20260911152137.676602-10-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa41c88 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=eCYPC3wdSG4xViznilUA:9
X-Proofpoint-ORIG-GUID: -niVpGQEETr1tVmhxpLe8py1loBbvvqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfXygHfMbPxBEy1
 OToPtUgobUJg4NnC7qiThhi5PH8jBW+UoN7L6Pmi2aV05Lxsa5DmWR0klbSz1KEUQb9gpvzjBD1
 Zr1a65dnNhlSd3GZYBOnNDygCHWgPqYp6mFGxeqVQVJBGLyM1aBkI/zOqs215nwi7ww+BrY2M1u
 1RMvEJpKQr1/254utcgJL33kXEdjeVXbjJ+Ya4KrN6qNiK7+1ekXghXByqy51rZxSJhnkwmezhL
 THJjvp0yhQs2ag1fAzD//AkWo8mA7cM/hOxP3idOgxYeNT0SX/zYs9z1IN23Lt99C3gpr0928CK
 KfPXMhW2ACuMC/OohYX7UtgQoldpgL24M9FZKwIlXNDnzuedWS6eeWNIHYQ1Yp9F0rUPF62OFAU
 DnVzk/5bSujdXekqXuhw5Q0+Vjt/SCnMiTWYCqogmbsBlsCogDFygaycmhr6y+ScQMcR4/q1EXS
 H59iwNRDBwAIWMQIDEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX9UEWS2Cbx1P9
 87cU8pkgZTVfetfJC2Cb73wPYT4h989oJPnEPBM42MDMMTsncJeDPuadCH/xK0trQb9DRZe/LIV
 W8ull8TaXjZcOCQHmaJYniswDkuivl4=
X-Proofpoint-GUID: -niVpGQEETr1tVmhxpLe8py1loBbvvqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
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
 hw/s390x/s390-pci-bus.c         |  2 +-
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ad4f527430..ec54eb64a6 100644
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


