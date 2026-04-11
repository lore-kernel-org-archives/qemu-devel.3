Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE7EF45A18
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 02:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBO3u-00026O-HV; Fri, 10 Apr 2026 22:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3t-00024E-2v; Fri, 10 Apr 2026 22:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wBO3r-0000Mo-3R; Fri, 10 Apr 2026 22:27:04 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B1PvYf2331673; Sat, 11 Apr 2026 02:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=G+mRZ7G+wFrg4KfVX
 4SGQUu69NmYqkiVfXmLRl4uDEw=; b=XiMe2CZAtck/1cp0Y/GHGDChwajGBC7+Q
 0RHU4c1ot6k2rDI7IQh4SVteaUqhH6nTdU2MzEKUykEvMuSlqn2H1zMfTWHaZFzu
 eGZmHCjXwO2XMtdAcZ/LfMUfxOAusZinO/lT4zdtHgmn0QdbI8mEML0TZJHtISdF
 aVfCgCbXuVb4oD/5J3ABxabowJRClnm2HNDpS5z5//1pPuurDOckvFyDqAp5cGrQ
 2iuqILbWBQKWTy2z6c6vi8d98DJ6fJODyme0ohEMgnB1TAreHFpGn6C7Ost01XPh
 iRtCCQn/xaBLEzyZJ0uB7iphrsrh17UpgVJiJkwDGwJJ6bGI3LAmg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2gbwex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:26:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63B0Z4Qv026655;
 Sat, 11 Apr 2026 02:26:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg8ayxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Apr 2026 02:26:57 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63B2QueZ22872686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Apr 2026 02:26:56 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12C3E5805A;
 Sat, 11 Apr 2026 02:26:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BE6458054;
 Sat, 11 Apr 2026 02:26:55 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.252.248])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Apr 2026 02:26:55 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v2 07/15] s390x/pci: Move/rename enabled from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri, 10 Apr 2026 21:26:10 -0500
Message-Id: <20260411022618.2136588-8-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411022618.2136588-1-kshk@linux.ibm.com>
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d9b172 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=i0DCopz73FH-yKe2uwYA:9
X-Proofpoint-ORIG-GUID: 7EOce1iQ9pq5O8SzyIES5C1wCxwybEu9
X-Proofpoint-GUID: 7EOce1iQ9pq5O8SzyIES5C1wCxwybEu9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAxNiBTYWx0ZWRfX+4Ir+1BkUSmq
 nddOL38xC1ZL35SJCwPS1WfAx6ZnjWXL46fIlSsVpUXttWwIldJcHglSvIJU/aGjHRac5IDrcWo
 XnIJHptFOwtCOkqjQwuBehthfttVK+Q058/vkSUnu7gBs0RFCytAejkhzIL0Yhw5a8gYhdZ7X4g
 bNxW/K/MG+UwxhL18NhVOOLQpij7CKBSsaiPa1THsY2FGN8AI07ftP+rq0mJZ+XYo2ThQGGGNoq
 kzWL0PytymZ6BYs5XtiLZrxyQ/4o8PpkyxRQYlkSTtX0g7aX5zpv/UWbGlhdu775+Ei0x1Daulq
 iomPz2v6P7PjgkVGbZVrxLgs91XMoG3o0/eL1lTjx9CO/g/WukVDXYAj1rlK11I/u/kfyzAY1b+
 mL34lnFomDpRgeuzWkaUafJPApH1NAXlJEFJnmlgItzc/96Ui0KZ0tAwrpgfkwpjHtDGgMDM/O+
 eNexYXfdfykLJnavjow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110016
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/s390x/s390-pci-bus.c         | 14 +++++++-------
 hw/s390x/s390-pci-inst.c        |  8 ++++----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 83e9ca99f3..27ba3c801c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -205,7 +205,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
         } else if (pbdev->summary_ind) {
             pci_dereg_irqs(pbdev);
         }
-        if (pbdev->iommu->enabled) {
+        if (pbdev->iommu_enabled) {
             pci_dereg_ioat(pbdev);
         }
         pbdev->state = ZPCI_FS_STANDBY;
@@ -554,7 +554,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
-        if (!iommu->enabled) {
+        if (!pbdev->iommu_enabled) {
             return ret;
         }
         break;
@@ -771,7 +771,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
 }
@@ -794,7 +794,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
     memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, pbdev->zpci_fn.sdma,
                                 pbdev->dm_mr);
 }
@@ -802,7 +802,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    iommu->enabled = false;
+    pbdev->iommu_enabled = false;
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
@@ -1411,7 +1411,7 @@ static void s390_pcihost_reset(DeviceState *dev)
             } else if (pbdev->summary_ind) {
                 pci_dereg_irqs(pbdev);
             }
-            if (pbdev->iommu->enabled) {
+            if (pbdev->iommu_enabled) {
                 pci_dereg_ioat(pbdev);
             }
             pbdev->state = ZPCI_FS_STANDBY;
@@ -1552,7 +1552,7 @@ static void s390_pci_device_reset(DeviceState *dev)
     } else if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
-    if (pbdev->iommu->enabled) {
+    if (pbdev->iommu_enabled) {
         pci_dereg_ioat(pbdev);
     }
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8349b44dd4..4458eae681 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1251,7 +1251,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (pbdev->iommu->enabled) {
+        } else if (pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else if (reg_ioat(env, pbdev, fib, ra)) {
@@ -1263,7 +1263,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1274,7 +1274,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1404,7 +1404,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         /* fallthrough */
     case ZPCI_FS_ENABLED:
         fib.fc |= 0x80;
-        if (pbdev->iommu->enabled) {
+        if (pbdev->iommu_enabled) {
             fib.fc |= 0x10;
         }
         if (!(fh & FH_MASK_ENABLE)) {
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index fcaaf19512..24f6e60786 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    bool enabled;
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
@@ -350,6 +349,7 @@ struct S390PCIBusDevice {
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
+    bool iommu_enabled;
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
-- 
2.34.1


