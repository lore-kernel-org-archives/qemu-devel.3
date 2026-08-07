Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86ACC5AC82
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO3a-0003eK-Lf; Fri, 07 Aug 2026 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3X-0003X9-DI; Fri, 07 Aug 2026 13:08:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3U-0000wf-VZ; Fri, 07 Aug 2026 13:08:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GlsXD1928075; Fri, 7 Aug 2026 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ygYbYG4Lcmy+PKHhp
 497HmAcqh3zrGql0SRH5Z7qpFc=; b=WiajrgIsXr1VP1HidFe8uZjLXq61areMp
 tMORK6oK2/LRH73ltmgsu1TIpKv88+0TPM/SQMmSuia0BT3lLU5sQJB0rYDXI1hs
 LKnp7CZrDGZLwXMReWtWI0X45j3MsSvMfvGH8Csg6QdQBXdbYk8pri/xZJCGwZ88
 ybEOBJG7qnq2lsiO75A8wjWfYO7FRkkan+ADf0BSNfPAYkcmCxGdnUAxwuei61Xi
 QYhHSwLtGG7iqkNpVmU0Ii0YE7Jt1l+6Pcm21N5/JTTwvLh9FGJdKu53eetFvG5L
 tc/VagSh+UEwWvGFEmaqt4usgri9IN52f5+SXLue498NDR3KUIaZA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02cuqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuHJh022403;
 Fri, 7 Aug 2026 17:08:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r0q3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677H8HlB52756736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 17:08:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFC7D5805A;
 Fri,  7 Aug 2026 17:08:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9547058063;
 Fri,  7 Aug 2026 17:08:17 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 17:08:17 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 07/15] s390x/pci: Move/rename enabled from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri,  7 Aug 2026 12:08:04 -0500
Message-Id: <20260807170812.658820-8-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807170812.658820-1-kshk@linux.ibm.com>
References: <20260807170812.658820-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a761104 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=i0DCopz73FH-yKe2uwYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX8+MyW6eqcgnv
 0YJtzFn3ef7RN2ADvJVF8vqdgV58bLwPdAaeLiqCQDV0bzPVJBhCMH46EPErgiMP7DPs59bpOR7
 yhWivg8XmcyweZVKMbC0U7DEWjMI/mkxxole707cJoOjT90bhvrfDo2OD6AgpkSscPIoWbYkXka
 ghIfFj6iy6vbL6Be6Xm7rxCHy2bi9GDEIlu8HSJ8uByqXkWWo80v/HSwEJihSblc4MGXxi2G0AC
 pagf6Sda8lNQ5qP+s/LYHJFFAo2ArZCHtn4+SE+vZ/0T9XkX/j9BWn+JjhiI2U+22R3B3B/JsGQ
 wtUbDnAfGSzbf+pbEhz8jnCtGpQ9+PvqMcdSqpuQHyFRIkIhopLmeawCuvjch4Qurbzf/J9aIbn
 H4fPJ96kC2eQvPuhLUyD+LznPNbbUs0wDgGSJT0JfaNeI79VJFCzdSPHS1IxfM6QwP5/I0DoUNO
 lqy0buK0fYI+fsiX5Xg==
X-Proofpoint-ORIG-GUID: 66bBy1JCU4DnMkUXnfaLJsjAlgJptWdm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX1TkBpTzMeHTD
 c6q66AEOrtV2b7eAar6E1+ol8je7UqZuctIS34CaDiSR1YAG2zS0WYYN9CtGC4ZQ6pLsWtwiUmA
 vFlfX2NaRAIgiFYvIa0N/nD9MoZYZnQ=
X-Proofpoint-GUID: 66bBy1JCU4DnMkUXnfaLJsjAlgJptWdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131
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
 hw/s390x/s390-pci-bus.c         | 14 +++++++-------
 hw/s390x/s390-pci-inst.c        |  8 ++++----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d2abbdab7f..586dafe1e5 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -206,7 +206,7 @@ void s390_pci_sclp_deconfigure(SCCB *sccb)
         } else if (pbdev->summary_ind) {
             pci_dereg_irqs(pbdev);
         }
-        if (pbdev->iommu->enabled) {
+        if (pbdev->iommu_enabled) {
             pci_dereg_ioat(pbdev);
         }
         pbdev->state = ZPCI_FS_STANDBY;
@@ -555,7 +555,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
-        if (!iommu->enabled) {
+        if (!pbdev->iommu_enabled) {
             return ret;
         }
         break;
@@ -784,7 +784,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
 }
@@ -807,7 +807,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
     memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, pbdev->zpci_fn.sdma,
                                 pbdev->dm_mr);
 }
@@ -815,7 +815,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    iommu->enabled = false;
+    pbdev->iommu_enabled = false;
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
@@ -1424,7 +1424,7 @@ static void s390_pcihost_reset(DeviceState *dev)
             } else if (pbdev->summary_ind) {
                 pci_dereg_irqs(pbdev);
             }
-            if (pbdev->iommu->enabled) {
+            if (pbdev->iommu_enabled) {
                 pci_dereg_ioat(pbdev);
             }
             pbdev->state = ZPCI_FS_STANDBY;
@@ -1565,7 +1565,7 @@ static void s390_pci_device_reset(DeviceState *dev)
     } else if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
-    if (pbdev->iommu->enabled) {
+    if (pbdev->iommu_enabled) {
         pci_dereg_ioat(pbdev);
     }
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f648afb401..7081be4619 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1279,7 +1279,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (pbdev->iommu->enabled) {
+        } else if (pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else if (reg_ioat(env, pbdev, fib, ra)) {
@@ -1291,7 +1291,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1302,7 +1302,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1432,7 +1432,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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


