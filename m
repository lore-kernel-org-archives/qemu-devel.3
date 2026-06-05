Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A969CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK81-0005Ix-0a; Thu, 04 Jun 2026 22:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7z-0005HG-07; Thu, 04 Jun 2026 22:17:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7w-0001lS-TZ; Thu, 04 Jun 2026 22:17:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654KkAPK1260942; Fri, 5 Jun 2026 02:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UIaylNNXq0cHhJQSA
 tSXdaqx4JW2JxL8EaQybK7BT6I=; b=HOFm5t0pByI/5SiwJLLcrXkbbWGqC27HA
 f0L3HdbzMeq3HcpN0wjUT9v4fMJO/SbJv1peg9/QvHfc8T8zxixBytrbp9ZT1fO5
 cRX+qfeVa/3sOZeGFfKp85A5AimnXdui2g6xiQ8FB0mZJHMRk8ej1HCBojRJ75Nf
 H73VQMk2tbayUND685g5sL/YmpizblkcX2a+a98uYgNbtY5YqBbGjLH3gYLRbsCU
 t6AHhjJ2MaQ+lBU1tKwk65FGnCOaiSFyctRiYProhA32/e9pv1qo0X0eS4w/k2tg
 HCU/g3W+n4hFvjbDSjKLNVE/Mw4gv52GCX3t+t0g4C97s+OOuveLg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4jkhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655296uH029805;
 Fri, 5 Jun 2026 02:17:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyqdwv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HYbR6226668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 012055805D;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C8658068;
 Fri,  5 Jun 2026 02:17:33 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:33 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 04/15] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Thu,  4 Jun 2026 21:17:17 -0500
Message-Id: <20260605021728.1125090-5-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfXwQDE6S06aQ89
 IwQvSEP/ky2erD34EUgfAceqNxXmvPtQGP0l8uoPuS/Cj3OHm1fjkzAce5ygfW8ZxEuN4A5p+Yo
 We8sUzSsXiQsURasno3mFwmxSrYczn/Q65qtmUyspnAGAsQbtEUyq+0jKhDhsjIscSEvPl5oDAJ
 D72f7sa3/PuZJkGTrMAr/ywDCE8yUy7pkOIapzlJ9KcT1Ll16EexsC3sRId6xa+J0sBj2gb/m0L
 JfA28Hd5yRzhbg60mb6lcYgfA7dKqAMbsL1kwWJow4os4/o0gyV9UO8l1LIXLDDefz7VHHug7Ie
 3E68mnl02ASyExJwynkrHKSHuYhPIb9FAJNUxRoFfW5f92XmQYTmUtmAfCZ7r4r1Ze+D/QYIv4m
 fHEsOLtU8Pdd7B8I03NaeIKeBhjdBmztkGdKtWDpd6nMUxjcTdJ2nRZg2spQuu4MzJVFs95y/5C
 sFIRHGR8jIFxvplPa8Q==
X-Proofpoint-GUID: VZI0MhYO9sikhrBfJgRM2X4J0zRHQixb
X-Proofpoint-ORIG-GUID: VZI0MhYO9sikhrBfJgRM2X4J0zRHQixb
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2231bf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jDWEBKAz6ZLYevfwb9sA:9
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

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
 hw/s390x/s390-pci-inst.c        |  2 +-
 include/hw/s390x/s390-pci-bus.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 98f626b57f..f09d85da8f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -604,7 +604,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     curr = iommu->pba;
     end = iommu->pal;
 
-    if (iommu->dm_mr) {
+    if (pbdev->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
         return;
     }
@@ -790,8 +790,9 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     g_free(name);
 }
 
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     MachineState *ms = MACHINE(qdev_get_machine());
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
 
@@ -803,13 +804,13 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
     g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
                                             iommu->pbdev->uid);
 
-    iommu->dm_mr = g_malloc0(sizeof(*iommu->dm_mr));
-    memory_region_init_alias(iommu->dm_mr, OBJECT(&iommu->mr), name,
+    pbdev->dm_mr = g_malloc0(sizeof(*pbdev->dm_mr));
+    memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
     iommu->enabled = true;
     memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
-                                iommu->dm_mr);
+                                pbdev->dm_mr);
 }
 
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
@@ -817,11 +818,11 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
     S390PCIIOMMU *iommu = pbdev->iommu;
     iommu->enabled = false;
     g_hash_table_remove_all(iommu->iotlb);
-    if (iommu->dm_mr) {
-        memory_region_del_subregion(&iommu->mr, iommu->dm_mr);
-        object_unparent(OBJECT(iommu->dm_mr));
-        g_free(iommu->dm_mr);
-        iommu->dm_mr = NULL;
+    if (pbdev->dm_mr) {
+        memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
+        object_unparent(OBJECT(pbdev->dm_mr));
+        g_free(pbdev->dm_mr);
+        pbdev->dm_mr = NULL;
     } else {
         memory_region_del_subregion(&iommu->mr,
                                     MEMORY_REGION(&pbdev->iommu_mr));
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index ed60e6100e..834a0aec95 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1034,7 +1034,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     if (t) {
         s390_pci_iommu_enable(pbdev);
     } else {
-        s390_pci_iommu_direct_map_enable(iommu);
+        s390_pci_iommu_direct_map_enable(pbdev);
     }
 
     return 0;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index a71f562dfc..f310672584 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
-    MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
     uint64_t pba;
@@ -354,6 +353,7 @@ struct S390PCIBusDevice {
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion *dm_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -392,7 +392,7 @@ void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIBusDevice *pbdev);
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev);
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.34.1


