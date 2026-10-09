Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C33CA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKl-0000Ss-0N; Fri, 09 Oct 2026 14:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKj-0000SD-BR; Fri, 09 Oct 2026 14:28:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKh-0001fA-DK; Fri, 09 Oct 2026 14:28:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZtUe592640; Fri, 9 Oct 2026 18:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/R1jV4bvhICiNXxcx
 u5gq03iIy7JoIeiYQZy5TolR+Y=; b=OylqPIM4CVkQVQsBOa/w/zq7kk+JXYQ6l
 K2UDHdhAiXd3ryaTvkUASJR6cy+hjnZcV2QzGFINC6zfybgkCLyduV/SQ8Y0l1nE
 dWJoFyaF+I+qUuQpUpgq+BKt4Zerp8M6dfJJ3NIHPXNgctHpjvGG1giP4wZQ3RG9
 gT2HoeQVgsaL+Thor7H5aup+uQw88dCsl7Pl62pAr8hPNhPGZq/9IdyQHjAPnHUe
 MJK1VlMOFUzEId4nYK6QD3rHp6v6ok/MHpS/oOcNly+a7f9hm6EZpWoUE0/fXF0b
 2okJPbADxTYi8wCEb+bJWJR+E4oLn1f/byL8xCUiiUpAWkmyWCj8g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg8b1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8OsO1207063; Fri, 9 Oct 2026 18:28:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnm7nn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISaej12387062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 049C25805D;
 Fri,  9 Oct 2026 18:28:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B8885805A;
 Fri,  9 Oct 2026 18:28:35 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:34 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/19] s390x/pci: Move/rename enabled from S390PCIIOMMU to
 S390PCIBusDevice
Date: Fri,  9 Oct 2026 14:28:13 -0400
Message-ID: <20261009182825.148054-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3I3DTTSxPhT1
 V8c4qyqguAEx5xi9PbX1Nl2lHXF4DMWfTjju4V9VGxZCn4pcUBUzaBx2aRRhtTlueeIR3YuUFV9
 BACDtNykaBLu4bo7hKMYBZ9AvkVi1kwo/A7O0IQ4XuTyOE6rwaAPYWbzEhrc+tIkG0xG721rcCa
 TKwF7e2cX1sI9TAI0HK4nXabSEKbPa26Xv2mrQUEMndYqNdj/3crWuCQ1I5ZlzZNheLfO/DGBhg
 dcCsCEti/UtbyV6FhfuXGbhb83EDnyk2EOq3A8afcb/Y5jfZbgE6RmweCEiSuxuXJZB800G8OBa
 i7ay6DL2nwxee6P9tY+KSCpetbjlNCe62hVYp1uhXHF9SdrsYljhwi1K3D9Ex+RJx+ISsMxaoBJ
 D2p0uRQnR7OJQQ2tS/u2IeYMlw0KIxgaFCN/lfqsk46Xg2b1fLqjBIQUxECPaOUKxX0eR3dTL71
 1YP+fXU121olKFUmjMw==
X-Authority-Analysis: v=2.4 cv=FqWQbGrq c=1 sm=1 tr=0 ts=6ac93256 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i0DCopz73FH-yKe2uwYA:9
X-Proofpoint-GUID: s0zYXpoLDsFYTPHVfSAUG1U9Y-IHBYbh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXy4F1U+Q+GidC
 LNxNKYGBWsP2OzV7QEQk/EP9TFfu/1KMU0bASA71SNyKm+ZTnTMr+Z684jguv8lWorQ4KE6w0V1
 tDa6sJHgREQObbia7hDfjrVYXzdh+5A=
X-Proofpoint-ORIG-GUID: s0zYXpoLDsFYTPHVfSAUG1U9Y-IHBYbh
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
there to simplify S390PCIIOMMU towards a structure that contains only the IOMMU
container information needed by the PCI layer for a given slot.

This also allows to save/restore this field during migration.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-8-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
2.56.0


