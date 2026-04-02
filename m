Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374A41112259
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pQ-0004hn-C2; Wed, 01 Apr 2026 22:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87op-0004DG-D0; Wed, 01 Apr 2026 22:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87om-0001kb-SM; Wed, 01 Apr 2026 22:30:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631HURcs2903666; Thu, 2 Apr 2026 02:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iYqDdV/mpZmonzLAu
 Q89glCnUvTOWOki0Kn+55r82Bc=; b=YguJH+ubZ/b/OUUErwKJ8rg8gUklo4pp3
 6WVljUGD44m2lvxEVTwjW8xr9WKulnldzbzdZfS+BSgLHOQWqWSnIpT+0MfMmVg8
 Z7+kHHgpY2GXou91pfOGYv8ZmvGvi1inB1GFEwpllECU5Arg92mjkn/gJn0AHXkW
 LS5zLRgNErHzmXmIOENSyUo+vUquO27drpX3T43V1nWeEuElSyxrhZQ0OLjphlP4
 xkF2ZV+E9hq4jurxoiZza1T+JZhieeAlex8SMty2Ds8roTIIwtP0iuWBH56NEkea
 r/jJUdQQ1K8gz3UPjSA7pGb39E4F1Y8olo4TDWdG3HcSp9dZqtD2A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nntyej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631Mjbaa021665;
 Thu, 2 Apr 2026 02:29:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasrgdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:55 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322TUbN28705426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58DD3580F4;
 Thu,  2 Apr 2026 02:29:54 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C42F3580F7;
 Thu,  2 Apr 2026 02:29:53 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:53 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 04/15] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed,  1 Apr 2026 21:29:10 -0500
Message-Id: <20260402022921.298818-5-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RuycDLoCWw2EmUJg1T-G4jL2WwGXGD-H
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cdd4a4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jDWEBKAz6ZLYevfwb9sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfX7o+jL28rPusT
 a2viW9BlQlkrqCCQ4R+fOyWBZ1f/KK+l5EtqEb24etgvxfulNmUAWficiwS7J4VYnB3+0GdtPNZ
 LNOXLnxATm9K6510V1+vwCdzbTBZlWBTGYJhWEqA9fPYHx8P10AY+tW+sTxPsY72wTyWbnN69Ni
 wDhCekvQV0+Pld1WoWHZc/YAJFtQqXBzD+T8hzA7zPmRV++/Z4WNwoWPvDJ3SXhh4eNBUAuTnQu
 TlxKbe8KknAiBQP1Og4pPw3DvR2P3qWvzZvGqcYuEIMyUT9xR8O1bQK1QpoBim2wdC3PrZBahs2
 H1cL/oaIpgsdimXdpUo8/bDa+zm2CFx3ZWlOmFX5MZj4zKmzYTCJHT8D7bRUj3rtSW9cygfrII1
 Hic2Jvp2d8QeRrC+RcG2Wlab/NUchpEafcKhMo4/ROoYxD4cHLM3qxLyDfvY52LuQ4U1DRgABWW
 sEhEeDQ74xyUQmx/ZSw==
X-Proofpoint-ORIG-GUID: RuycDLoCWw2EmUJg1T-G4jL2WwGXGD-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
 hw/s390x/s390-pci-inst.c        |  2 +-
 include/hw/s390x/s390-pci-bus.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 99d503e85e..117fd8136e 100644
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
@@ -778,8 +778,9 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     g_free(name);
 }
 
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     MachineState *ms = MACHINE(qdev_get_machine());
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
 
@@ -791,13 +792,13 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
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
@@ -805,11 +806,11 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
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


