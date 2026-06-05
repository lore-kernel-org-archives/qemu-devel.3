Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A457CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK82-0005L0-Ai; Thu, 04 Jun 2026 22:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK80-0005He-5w; Thu, 04 Jun 2026 22:17:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7x-0001lx-K9; Thu, 04 Jun 2026 22:17:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654G9DGn2841744; Fri, 5 Jun 2026 02:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=S/tTamghUevwWDC6r
 cH4H69UqETHLaclMR2oHQE2rNY=; b=VRA6TSMhddYwWewkAdeP5iQGn98uDYTK0
 qZujjQ0hU1rhhW/xmjF7utbpB6ZP06BkOjMFvg1yJ5U0MFyH43S3ZKNpcjaexOlD
 uBJ/dq8JweDXQkKmjPE5qSmDs3288NNKa8CrtnQVqhZamp05iFsIGT3nKVfZNoMz
 PLWTrs4WZHaYYulnWdiy7wPPKytv0vT39nG07XCLI1+RliBcqE6dwaNHi3xiXQ5K
 sME32mnBZ7evE9CjrpeSHQmvNWU4KkmYFBDnvrPhP9GSz7iULwwXLigWcZSngWy1
 yrPrWXtYKj8YXebsAhiHNYRgVBPc5ZvqqPyBrZc/aOo2ErGH5f9aQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj21ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65529D5a029852;
 Fri, 5 Jun 2026 02:17:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyqdwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HY0W24838678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F49B58052;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3544C5805D;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:34 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 06/15] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
Date: Thu,  4 Jun 2026 21:17:19 -0500
Message-Id: <20260605021728.1125090-7-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfX5xEMXJjC+eqe
 nQqx2dv59k/Vo9Ck8Au2q+qP55lQ6UTYiw+nN3lCtvvMXra81XeAlV5w8GS3ef/tEWG2CVDTBYm
 wB+ee7B7x6LQtnDUGZbtTUVMB1M6lmdgcCCApfRyTe5k9D91E+feZxwgor1EswTYezWl7LEDokB
 TGqsjy6PjuBW/cvm3A8Hlm4zJJyINL82HVSFrT+WT155Nki4hHPq/26okW2aQZrFT650JBLbQnV
 B5h8nscsOVCnxevN+8Wqycya6+n3UD+xYG8kNjz9ubNYtO6nr4u6ujQgfr+OrSNpj5/QYD9iMBc
 xD9mcwwF7z20ZeK201z+8FiIK5e+dsKT8eWAbY5YbuyH4s7erCDhXm5oSHmY5ptpMwW5d5k9UF/
 ZSipH+RwyJF0qbEaJfi2QmeDZidyKXIc0g4YnQgPmPVmwAOy4KDrVm6yxZUYQj6UDzuNc7oun5X
 0N1v1VwyBAvJJO6uxQA==
X-Proofpoint-ORIG-GUID: QUH_-Al4c59Q_V-l_cVhBQDwwM456-QN
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a2231c0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yINFAIt2aqTEABBYJGoA:9
X-Proofpoint-GUID: QUH_-Al4c59Q_V-l_cVhBQDwwM456-QN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
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

This pointer is no longer used, after fields were moved from S390PCIIOMMU
to S390PCIBusDevice.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 15 +++++++--------
 include/hw/s390x/s390-pci-bus.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 34dcc7c3bd..21455d9233 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -551,7 +551,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    switch (iommu->pbdev->state) {
+    switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
         if (!iommu->enabled) {
@@ -586,9 +586,9 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     }
 err:
     if (error) {
-        iommu->pbdev->state = ZPCI_FS_ERROR;
-        s390_pci_generate_error_event(error, iommu->pbdev->fh,
-                                      iommu->pbdev->fid, addr, 0);
+        pbdev->state = ZPCI_FS_ERROR;
+        s390_pci_generate_error_event(error, pbdev->fh,
+                                      pbdev->fid, addr, 0);
     }
     return ret;
 }
@@ -779,7 +779,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
      * so the smallest IOMMU region we can define runs from 0 to the end
      * of the PCI address space.
      */
-    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
@@ -800,14 +800,14 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
      * IOVA X + SDMA.  VFIO will handle pinning via its memory listener.
      */
     g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
-                                            iommu->pbdev->uid);
+                                            pbdev->uid);
 
     pbdev->dm_mr = g_malloc0(sizeof(*pbdev->dm_mr));
     memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
     iommu->enabled = true;
-    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
+    memory_region_add_subregion(&iommu->mr, pbdev->zpci_fn.sdma,
                                 pbdev->dm_mr);
 }
 
@@ -1199,7 +1199,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev->pdev = pdev;
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index d9bafd6859..fcaaf19512 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -273,7 +273,6 @@ typedef struct S390PCIDMACount {
 
 struct S390PCIIOMMU {
     Object parent_obj;
-    S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
     bool enabled;
-- 
2.34.1


