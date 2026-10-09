Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB2CCA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKh-0000Pl-B9; Fri, 09 Oct 2026 14:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKf-0000OV-6A; Fri, 09 Oct 2026 14:28:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKd-0001eH-Ce; Fri, 09 Oct 2026 14:28:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha5Rn592884; Fri, 9 Oct 2026 18:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=27yIzJ88BlNfQtGow
 HvDle4zbV1oDjba31jt/1ZynH4=; b=j4lJUxlxr8wepuufw+onepx51mTTJdJJI
 HHJrSy68ImdzS0duwFovepz1OCAYaiuDz4JknNwYP9hz7KvXerzdLRU8QloA9Qfu
 a2C+JX4IY/yric+PLO13m/CVi3hf7nWM6jzlwPI0zqwSdsqdt1WsrST1Q/D9pmXS
 XWIqTwHBbpahz0oNz4OmAk65yORUlLmG9CJ0lMq4hTyLYh8pGiT2eKnVqdMG5QYk
 f8gKkwuUs4lj6aWrgsqqQDsCEvRlkqqfJTn/Jftb+zWUZqHvjzS0Kvm06RdlQseV
 YPcKxVE5Fi1j68hN0vap6AdPns7db/xTv9D43EkY+fCRKMEM0qTxA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg8av-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HN8iS1169766; Fri, 9 Oct 2026 18:28:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s351wpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISWEM13828822
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B26D5805A;
 Fri,  9 Oct 2026 18:28:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BC0558054;
 Fri,  9 Oct 2026 18:28:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:31 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 04/19] s390x/pci: Move dm_mr from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri,  9 Oct 2026 14:28:10 -0400
Message-ID: <20261009182825.148054-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX5E8KqHvJsU5M
 cw23bJxDdyc9kVwRROSLUkA9xWaFbjG4aHtTEVFXyuiFU13Z2n5chJdq/BHjVoPJkyPhpp4Ni04
 emyGnqroJ0cc92uRZuEt5cXpq7W8tZO1Drp3GBGj1L4rZa8AYZCVs6sYjZ8piG8BnsLc69ai1q+
 8eq2KDH2YPgdHN1z2dbBMaeYNzFWWUSe/F7ex5MAcws4TPdzCKWKVcSzlPR5awn5xOYIndVkJ8R
 eVHl8qXMcP4mRoRJr27LR1xW+MjTNO8+vNRkOR9u04YXsf7SGua8s4GMk3eEwLvVdHv3VVE7/ZQ
 7IeNVaKsS2KEQ3/+HgTo8ys56pkz9QhCV3Mh4f9lxo81wPCu5EjJEm5eE+vjtfoSBqE5Lnq2tze
 0hEViPtrGJGYEicbSFkguatXHVa003JdjgApw/g55iMy1jZ3Bv7tUOFp+IdLQpsQAcJwoJJEp0V
 qhbyFSZUPxYZOzaUgdg==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93252 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jDWEBKAz6ZLYevfwb9sA:9
X-Proofpoint-GUID: ASgU2g5N7sqKo34_Qa0x-CRsBiOjYu8J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX5YRfTYJgUyJZ
 tKxYZ2pwXsu8wX6EQKSblax+5XIHMlwyF+AEq9wQmkNoSQRr5UUU8wHTBVDAyK5kHJpgyMW8L7/
 4auMwOJDQ7FDkK+nX+X3nq25UjxKwZg=
X-Proofpoint-ORIG-GUID: ASgU2g5N7sqKo34_Qa0x-CRsBiOjYu8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify to simplify S390PCIIOMMU towards a structure that
contains only the IOMMU container information needed by the PCI layer for
a given slot.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-5-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 21 +++++++++++----------
 hw/s390x/s390-pci-inst.c        |  2 +-
 include/hw/s390x/s390-pci-bus.h |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e709d6e478..99122716d7 100644
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
@@ -801,8 +801,9 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     g_free(name);
 }
 
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 {
+    S390PCIIOMMU *iommu = pbdev->iommu;
     MachineState *ms = MACHINE(qdev_get_machine());
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(ms);
 
@@ -814,13 +815,13 @@ void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu)
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
@@ -828,11 +829,11 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
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
index 50514d02a6..f9907c7d5c 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1082,7 +1082,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     if (t) {
         s390_pci_iommu_enable(pbdev);
     } else {
-        s390_pci_iommu_direct_map_enable(iommu);
+        s390_pci_iommu_direct_map_enable(pbdev);
     }
 
     return 0;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 74f559deaf..b74cc654bb 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -277,7 +277,6 @@ struct S390PCIIOMMU {
     S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
-    MemoryRegion *dm_mr;
     bool enabled;
     uint64_t g_iota;
     uint64_t pba;
@@ -355,6 +354,7 @@ struct S390PCIBusDevice {
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
     IOMMUMemoryRegion iommu_mr;
+    MemoryRegion *dm_mr;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
     IndAddr *indicator;
@@ -393,7 +393,7 @@ void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
 bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIBusDevice *pbdev);
-void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
+void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev);
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev);
 void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
                                    uint64_t faddr, uint32_t e);
-- 
2.56.0


