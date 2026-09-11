Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C74C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534r-0008G6-FB; Fri, 11 Sep 2026 11:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534d-0007yX-Ef; Fri, 11 Sep 2026 11:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534W-0004k6-1P; Fri, 11 Sep 2026 11:21:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1hHa1973594; Fri, 11 Sep 2026 15:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=370oi7erpzbA5pBwt
 zgl9MF+hjpJBIEDmH4vLh3CXKY=; b=Nox8WTfwqvekh1x+Fu/ryKUqZLc4nJoSz
 Pdo6XEkPbjJHP8ToPBsDZKDn6GNsD1yGENvjEO1OSOFjzSHqWP4fZaM53eNa+c5h
 fnXa8tfBRWlZMRifIBQXT0rdWRl2jIduvdfG5yLxsYtulVJGt3CFzijVdC+3Achk
 d3YdFree/1R0e0Hwek81ICDMVANZS/fruVW8VL/JudGqAQmE0EToxYBi9IhqbdOx
 K1x8nn4qNI8xDAQDOuXkJKoMkR+Be9TuSC0kRhWX+rEbRVAO5PEcgVTNgjPo8gym
 4FiEvT105Ht8UafjRSSbEuVQ62p9zRESRZrWv4K2EX8c7O7lHRIDw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sc7v6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEoApm1789344; Fri, 11 Sep 2026 15:21:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk71sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLeGC27656760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:40 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7FF658059;
 Fri, 11 Sep 2026 15:21:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92CF95805D;
 Fri, 11 Sep 2026 15:21:40 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:40 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 04/16] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 11 Sep 2026 10:21:25 -0500
Message-Id: <20260911152137.676602-5-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u-PqGKNTS5070_CT0t5BZnwc6bsjEDq8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX9qrM+TRnLchL
 TuZp56mytanJn9jn6YnFh0NBJH/OuqtGMiomDLrGxkZqyc9ghKaXqxDoiEx8L1nFGpaf/clmTOQ
 MdQUuwyUI5zjyNK6cDTwOivREwQPuSQwr0a8apuxx92b7rQQtdDMpsZavjZy90oMU3nQrSeT557
 mdk2TUWcsNEgHNAEvsH3uvwBhP0wRn+wUwi2oGc0Sk7xvXc04yum9wtz18OgE+18TWMiwzXrrdj
 6n5WiYlV0QnLppNAuGRM4yHnorsWO2yF5b8aTpOmfAvZhqZIYKtkrztW1L6QwQuYUtoBTrO4qxZ
 jnI/hTKDyfbQcKge7ALgC8iltOblu7ObqU1L+r5zCpDy2coy1J9nYa6GEtJyDPr2YZ3LpDcifpn
 OuG+5RkRyNeJPLFCL01EX8Pq7eoScqSIjx/M+S7S9kjXp2bmFD8iz/MOXBntbnmhmqtvSUzaRV0
 Fqp9qQj3sHgHAXygW9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX4njmwpVRK57D
 20b5nLX2wnE9cDisQbTFBl04Pigk8RDfTzKbnopp9to4WJpywW3t6cNstYtO1wNa2RpXDmxLysj
 h2lPK/nHoIsFGON08e4FwTJh03FENVQ=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa41c86 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jDWEBKAz6ZLYevfwb9sA:9
X-Proofpoint-GUID: u-PqGKNTS5070_CT0t5BZnwc6bsjEDq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
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
there to simplify to simplify S390PCIIOMMU towards a structure that
contains only the IOMMU container information needed by the PCI layer for
a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
 hw/s390x/s390-pci-inst.c        |  2 +-
 include/hw/s390x/s390-pci-bus.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b6a03bcc6a..e1b47f3914 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -605,7 +605,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     curr = iommu->pba;
     end = iommu->pal;
 
-    if (iommu->dm_mr) {
+    if (pbdev->dm_mr) {
         /* If direct mapping is used, there are no guest tables to replay */
         return;
     }
@@ -796,8 +796,9 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     g_free(name);
 }
 
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     MachineState *ms = MACHINE(qdev_get_machine());
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
 
@@ -809,13 +810,13 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
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
@@ -823,11 +824,11 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
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
index 0772f04cc2..582e93a741 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1062,7 +1062,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
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


