Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95334C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95O2-0008VH-Kt; Tue, 22 Sep 2026 14:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mn-0007ag-NM; Tue, 22 Sep 2026 14:37:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Ma-0005vY-Pe; Tue, 22 Sep 2026 14:37:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7boP1129503; Tue, 22 Sep 2026 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Mkz/yDDmhQPp29Ok9
 p/9oSsXjFEyn86PqLErF/k+nuQ=; b=padLEvRjsS13zgnfMZUkEkkRhqLlDQEak
 wxdE7ko2guNgfhXgs0Ox0NmBmAxUkSV7MHAzGIwrbXu8szYu6NYfjaCQREB6yry4
 jqlnlfVucbkCVH+tg8bx+oBZyPhcchzrw9WCYO/dnLfl4Un4n1lcmKMF+oRZ2mpx
 GR7nE9Vnd2WvLrBJrUIZT7JiVQ2thMbPSl4Leu4R9uyxmedsCU0rbWMAvx7UnM0G
 Kg+F/O1MXe0zDlxK6rte5OQM/tLlUKyJ31QbC8rqn1/fAX3a8HZrp0Ybm4r+O/N7
 /L8PkYAggCp2ZcuuazZ+3VTauiy0yLJ+ziXFG9hwXzDs4yEy60JzA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs7dk5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHYJ33220300; Tue, 22 Sep 2026 18:37:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vk3vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIaxha32899584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:36:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07B0258056;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0F1A5805D;
 Tue, 22 Sep 2026 18:36:58 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:36:58 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 09/16] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
Date: Tue, 22 Sep 2026 13:36:47 -0500
Message-Id: <20260922183654.798470-10-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2cacd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=eCYPC3wdSG4xViznilUA:9
X-Proofpoint-ORIG-GUID: 12JI5aZUwlay1RBZ7bu09bHwWruxjV4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX0w0Xw3evBEPl
 ywIdb4dJib3CaPlUzJjseo2KxBYM7JlVdvPSR3tvzOu3NMbeHekAfDqQDDXx06AvYfH4N1gyefT
 pz+si3niZULDgU7PBOIZcZTeh5dQ1JMp7qhygLeEunuD1YFiSquYt245cSxsvflPol4A+d4F5mU
 3Q6Icn7AJXSL9KBbclLAEenQsEmhnP9doqVqOXh+/uuaolF+newJCRNs9QMWFYe5Lq0oMMGj61U
 L8MQeIcVzGwpniu39exO8kjk6vXEcwgVe7tgTcXdyo25z3+ORFT/kDtoQhfSoi7cjwKQYHv6AWi
 wAiDnY6DyrY2j3z7t8mKj9w5qGvD31wEfxdbImVMRP7wmdMCCun1/wYTbqeLLNNuhrlYhiYfFY8
 nSfBvF16p4aYNIKxPca8CuWDXkznRjvyQJENpWDaIuySMoo+cPVzjQjbGLYvigQaXjpGtIAgMCB
 W8F/JrMBvWTNvEcJImQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX+rRY8B1AHQiN
 mUPrbaQnHJ/j8ACIg4MMsIqXGVt8su+MMBWuYRnhKzJkM3CRYVfiyS6U/hicAzPp9gHs/K4jTD4
 erpvACKUg4HmaweZRAZs28ab9RDYmsY=
X-Proofpoint-GUID: 12JI5aZUwlay1RBZ7bu09bHwWruxjV4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220273
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


