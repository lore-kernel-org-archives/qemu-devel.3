Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA162C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx7-0003vk-DO; Thu, 01 May 2025 22:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx1-0003tE-0F
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwz-0007RM-0z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeRSn022623;
 Fri, 2 May 2025 02:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=UnbB5
 BpJQd3wr6A0cs//jyZb2f/U7D1aOtqKnVe/+2A=; b=J6GV1TQ/VloQalv2GAl1i
 pPFcdZDQyxU/Tqr4jMAA71PqfL1Slu/dK0l3zSE2gDhNCBHIHXyDiy9JiS4xUepb
 l6lekEhKI4kmIokjwPSLxMgWxLi/lwfIe8RH4lnzbmZG7woxmAQ3oZrVKMlAqwHB
 z/wgWdFuhHe/gxanyQWh1dlLpcUJXeAOR42/BZdwBL80C2XQWHTTKb9jIwtCqbvZ
 BMEkuNQ9m2pH4xvQM4i1NkW6ETBoUhUfNhWRacNB9equ+nWqarOECGJcjHagWeN8
 0TRDIi+4HP5kxqt2TB/Qz0lBtM4UmnqvVPmJO7Xo2Vw/orMG0zeIpgxjwmI9BU/u
 Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uumdb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5420RRqB023842; Fri, 2 May 2025 02:16:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh03n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsO011525;
 Fri, 2 May 2025 02:16:18 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-18; Fri, 02 May 2025 02:16:18 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 17/20] amd_iommu: Add dma-remap property to AMD vIOMMU
 device
Date: Fri,  2 May 2025 02:16:02 +0000
Message-ID: <20250502021605.1795985-18-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfX9otAGuJHGq83
 HlYeu30YhxRRJguLrP3gfyPYA7NSYX+yDxPVnhiqRr9JfxLehKMIQOIIFDLtt8VBBwW1qhAzmXz
 w1dP10eO0sjdrow8TCbrZuBSRjpqSChjZt9z3pThD6aOwPrjxYh3LSh7rWa/P0dCiVmFfZuvSuE
 vr15WUHXy1Yl5ed+UBVbvokFhkUNBqS4WE7FejwtlFBuLe+SQV60pL+oduLilrTt9NN6dqTNteb
 LKKu5x1YKFNR47iE260WZxzjgKDbLrPjkJ7Njke6I1le6OkWwHLPB+EcfMEN9L3OwkVprNRbIQY
 +zymCvSriwtECtVpEzaqYnFbcQE6arWjuZyDnfDXTP+l74ZuKHIpgn1Td+Je9Wp7d70JPZO7jzB
 HA/+CCCXGHiFHWVTRnAeOHw9mQh9pRS8h2XCovCrm1zhuNEsR8z+piveV5un18JgtLaanV1Y
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=68142af4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=lB8vL2C6TGN_h6hMWm0A:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: Qm6uFplSYo40j_ny2x_mrm7PwjvQrVrK
X-Proofpoint-GUID: Qm6uFplSYo40j_ny2x_mrm7PwjvQrVrK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to enable device assignment with IOMMU protection and guest DMA
address translation, IOMMU MAP notifier support is necessary to allow users
like VFIO to synchronize the shadow page tables i.e. to receive
notifications when the guest updates its I/O page tables and replay the
mappings onto host I/O page tables.

Provide a new dma-remap property to govern the ability to register for MAP
notifications, effectively providing global control over the DMA address
translation functionality that was implemented in previous changes.

Note that DMA remapping support also requires the vIOMMU is configured with
the NpCache capability, so a guest driver issues IOMMU invalidations for
both map() and unmap() operations. This capability is already set by default
and written to the configuration in amdvi_pci_realize() as part of
AMDVI_CAPAB_FEATURES.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 24 +++++++++++++++++-------
 hw/i386/amd_iommu.h |  3 +++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 90491367594b..a2df73062bf7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -951,7 +951,9 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
  */
 static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
 {
-    if (amdvi_as->addr_translation) {
+    AMDVIState *s = amdvi_as->iommu_state;
+
+    if (s->dma_remap && amdvi_as->addr_translation) {
         /* Enabling DMA region */
         memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
         memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
@@ -2126,12 +2128,19 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
     AMDVIState *s = as->iommu_state;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_setg(errp,
-                "device %02x.%02x.%x requires iommu notifier which is not "
-                "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                PCI_FUNC(as->devfn));
-        return -EINVAL;
+    /*
+     * Accurate synchronization of the vIOMMU page tables required to support
+     * MAP notifiers is provided by the dma-remap feature. In addition, this
+     * also requires that the vIOMMU presents the NpCache capability, so a guest
+     * driver issues invalidations for both map() and unmap() operations. The
+     * capability is already set by default as part of AMDVI_CAPAB_FEATURES and
+     * written to the configuration in amdvi_pci_realize().
+     */
+    if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
+        error_setg_errno(errp, ENOTSUP,
+                "device %02x.%02x.%x requires dma-remap=1",
+                as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+        return -ENOTSUP;
     }
 
     /*
@@ -2281,6 +2290,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 
 static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_BOOL("dma-remap", AMDVIState, dma_remap, false),
 };
 
 static const VMStateDescription vmstate_amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index a7462b2adb79..fc4d2f7a4575 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -420,6 +420,9 @@ struct AMDVIState {
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
+
+    /* DMA address translation */
+    bool dma_remap;
 };
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s);
-- 
2.43.5


