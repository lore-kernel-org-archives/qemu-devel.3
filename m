Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A06CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvgT-0001QU-MO; Wed, 30 Sep 2026 10:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgE-0000u3-0f; Wed, 30 Sep 2026 10:53:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgC-0006cK-3k; Wed, 30 Sep 2026 10:53:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5dhX2986748; Wed, 30 Sep 2026 14:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=j43fAZW+JSXXoGRxf
 zdkQG2KlDqc4UYyF7pHXwB70Rc=; b=fVVyEP/+cj63XNmKFfG7jfTQpmR2BtnAc
 8hZHdumRDfl5sHEKaC1IeLyJIn9bXra3dCFuBUb6JU0ASk+I7cXgumNxiEGOyNKR
 V/AeYmwYV9iM1p01dshxmiFpMqC4uAXrvgLP1Ju2t024ZTL0Mb+jt58yTEo3DCW0
 ebalPE+bILWcRlAkhO1qb+CKy8a5r+H3s9LnysCCb09WWqiFp/e6qu6ouqMsHvhy
 nmcQVs0fCBJT2rgHNZhlL+61N03yugatwT1czfkAl26sDN4ydVEB3R5d5TgbLoJH
 0g7vt1azPWOzyo/gbLyoqGvZz4ZqFKqMINOnBaW8NkjoqTxSWZfLA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkd2e7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEHuL73569204; Wed, 30 Sep 2026 14:53:04 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9gnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEr2Gb32899360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:53:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E1D258063;
 Wed, 30 Sep 2026 14:53:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF98A5804B;
 Wed, 30 Sep 2026 14:53:01 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:53:01 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v11 07/16] s390x/pci: Move/rename enabled from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed, 30 Sep 2026 09:52:46 -0500
Message-Id: <20260930145255.140164-8-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145255.140164-1-kshk@linux.ibm.com>
References: <20260930145255.140164-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wO-4PihOus0hfsUDjZx8fKt-n6TW0H6a
X-Proofpoint-GUID: wO-4PihOus0hfsUDjZx8fKt-n6TW0H6a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX3WWRhLlfUFr0
 UOrZm87RaInYFAb3Fv/AHV+6Gw21+qog67eJJf/5purDFY2cffIKhvw5BZC7jOHks/U3lRRqYy1
 KgVRZEyiisRMLGhIQxidLu/rvq97RQA=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd2250 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=i0DCopz73FH-yKe2uwYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX0BbmSIUSYbta
 AVGOjvIxkLwZbIWB7ajJ7JAPwbk3LbG5pEg32i7dfLB64ImDjg+fGPc5lTxLI6nyzLyWlGiulRd
 Ngy8fTzsSCKetvio+iDKZPRH3pkKnpA26r7464qo2jVKrd8mTONWY8mOUQmchi1o6HiiQAaJ4D/
 Jrk/xEXU7RT/cIBZL+G1Y3MAxzwYDFfBvSN3B5p4NqckEm0zu3HiqzJKgRQiK/VMGfXS8pvcTMk
 9qJZRn0/yGXX+NmHbygONvhJDsVEXbTWhJXuaB7o9LsMONgLcLsAI306wpzwxGyOXT+ktoIrDh0
 0kYMM/LOh03LH1GVSQWBjGqlb8ZwDhRNDyW1Yun8IgBVbr0plYIA1xHtNRjYeYrw9HRMJhsLPFC
 a8BWgC7433hmet3HJfBThwmdDe3yoe6sbkNw+KPNMVnki5lW0IhDGz3SvMqxPh/Yiq4dB0uhlAK
 ncXn/cyxZWj8/sBgR9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300058
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
there to simplify S390PCIIOMMU towards a structure that contains only the IOMMU
container information needed by the PCI layer for a given slot.

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 14 +++++++-------
 hw/s390x/s390-pci-inst.c        |  8 ++++----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index d74d0c4925..3a071eab54 100644
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
@@ -794,7 +794,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&pbdev->iommu_mr));
     g_free(name);
 }
@@ -817,7 +817,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
     memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
-    iommu->enabled = true;
+    pbdev->iommu_enabled = true;
     memory_region_add_subregion(&iommu->mr, pbdev->zpci_fn.sdma,
                                 pbdev->dm_mr);
 }
@@ -825,7 +825,7 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
-    iommu->enabled = false;
+    pbdev->iommu_enabled = false;
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
@@ -1434,7 +1434,7 @@ static void s390_pcihost_reset(DeviceState *dev)
             } else if (pbdev->summary_ind) {
                 pci_dereg_irqs(pbdev);
             }
-            if (pbdev->iommu->enabled) {
+            if (pbdev->iommu_enabled) {
                 pci_dereg_ioat(pbdev);
             }
             pbdev->state = ZPCI_FS_STANDBY;
@@ -1575,7 +1575,7 @@ static void s390_pci_device_reset(DeviceState *dev)
     } else if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
-    if (pbdev->iommu->enabled) {
+    if (pbdev->iommu_enabled) {
         pci_dereg_ioat(pbdev);
     }
 
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 30114abd43..c1d9be232a 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1299,7 +1299,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (pbdev->iommu->enabled) {
+        } else if (pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else if (reg_ioat(env, pbdev, fib, ra)) {
@@ -1311,7 +1311,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1322,7 +1322,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         if (dmaas != 0) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_DMAAS_INVAL);
-        } else if (!pbdev->iommu->enabled) {
+        } else if (!pbdev->iommu_enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
@@ -1452,7 +1452,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
         /* fallthrough */
     case ZPCI_FS_ENABLED:
         fib.fc |= 0x80;
-        if (pbdev->iommu->enabled) {
+        if (pbdev->iommu_enabled) {
             fib.fc |= 0x10;
         }
         if (!(fh & FH_MASK_ENABLE)) {
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index d67daeb34d..b851295b44 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -276,7 +276,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    bool enabled;
     uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
@@ -351,6 +350,7 @@ struct S390PCIBusDevice {
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
+    bool iommu_enabled;
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
-- 
2.34.1


