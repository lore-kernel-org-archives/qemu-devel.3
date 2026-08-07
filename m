Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A613C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO3Z-0003d1-CQ; Fri, 07 Aug 2026 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3W-0003Vd-Vn; Fri, 07 Aug 2026 13:08:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3U-0000wY-On; Fri, 07 Aug 2026 13:08:26 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GlroF1937426; Fri, 7 Aug 2026 17:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=H4xQAIQokoZki0hhp
 bWhZgArYxp6R5Y5mllNCEWWDTc=; b=jW/WX+7NBL98F5EWpYVn+k0NtjcCwIN0J
 AOmpefnTNQZ6fpz5ht+MEE3cNauKG+DXCJdZjDbY+5cukQRZR28wWAj55hPKj6as
 n2RL8j9npqaZhhlZ5ze54C1Zcaa0tasHVxYHoCm052JPsKFAK5T/2FJNy0WCrLzO
 GZua9cXy67isOXsWm3rONESa5m7sZBteslZsktchnJs5oY3oKdAHEn3m8z0ft1I6
 jWIx07ZYQEP57+gv3co9SjXoGKQ3Yd8PkALOqQPpjVlLUU6sFVw24ljdvR1VXih3
 2TN7Fs+IzNzKADAUd0GCRWzEpNaB4pK9Ae0oOJUsW5nCq0N5OycvA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy024u77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuLqM025991;
 Fri, 7 Aug 2026 17:08:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu00by3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677H8HIv15139568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 17:08:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DC3458056;
 Fri,  7 Aug 2026 17:08:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5521F58061;
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
Subject: [PATCH v6 06/15] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
Date: Fri,  7 Aug 2026 12:08:03 -0500
Message-Id: <20260807170812.658820-7-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807170812.658820-1-kshk@linux.ibm.com>
References: <20260807170812.658820-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YMT1DQKcU8QZ_RzXAjvGNY25EpM9WsrU
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a761104 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yINFAIt2aqTEABBYJGoA:9
X-Proofpoint-GUID: YMT1DQKcU8QZ_RzXAjvGNY25EpM9WsrU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0fixlHGLXgQe
 IY/gb92cryZf2U+IdJjczb0Oo+VgyvxQVfAJmjTyP6zsGeemE5C2UU5LgQlxCzOHeRe9cmAojIG
 HggfCNB0vzFyps2XaROSZ1ac7xJ5U98lJwRJ0rZDPuOlxOLSPlVRtecVd70kLnrGYs694CL0DrV
 3jAkDeiqM0PjOpI7Qiyr1qHFr+STetDd9E3hQ0AwtocEgPgNv3//X6CgQWcsaHmIhuCzBmchHKn
 NQTSig2HRBt/xJOz2Y9NMzKA9V5Fh+NmyLrnN7RkxfT3jG678XSpBZ2T/ErEqN9GqHuWQFxaasL
 TCr+zENYBV2fH9Rt2CVm1hJq9XGM/hr2mjtJVgZl5x+uK2o+ZLL7BrwQrsGBpB+iSeDX8pmwdGN
 dg6AqnI2ea+UkNTk+pTN+KE7Nxp4Usdw4K/gqdYhBpAXHyk3mLCvk05+9YQPM/JgSd/1pjGmOcO
 KVDqXpEdG+CycaGWD4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX70hRXZQUQixX
 DlpXObGoz89F2+U+XjCyM99V4bpeL/bJJ/XJt7Lpwxj22UxsiGHcw/V9yDdKS1rA2fgrBH/AftL
 HDRtp34yH376V/5q/chlV5ZMTDwOa58=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
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

This pointer is no longer used, after fields were moved from S390PCIIOMMU
to S390PCIBusDevice.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 15 +++++++--------
 include/hw/s390x/s390-pci-bus.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index a08f226ef8..d2abbdab7f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -552,7 +552,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    switch (iommu->pbdev->state) {
+    switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
         if (!iommu->enabled) {
@@ -587,9 +587,9 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
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
@@ -780,7 +780,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
      * so the smallest IOMMU region we can define runs from 0 to the end
      * of the PCI address space.
      */
-    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
@@ -801,14 +801,14 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
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
 
@@ -1200,7 +1200,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
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


