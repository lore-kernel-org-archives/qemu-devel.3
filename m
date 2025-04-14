Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E2CC369B1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49BH-0007QT-43; Sun, 13 Apr 2025 22:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49B4-0007Lu-Fx
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49B2-0007Ut-VF
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:04:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E0t2v8027152;
 Mon, 14 Apr 2025 02:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=vRXuX
 a/ew+L52hSsHAidf/wC0M0bOhpDSSb5ePkSL6c=; b=ivkFECGuVy/JflzhuSxIs
 SHfyL8K8KtiedIN5X1+/FG4YPx/K6Ap5x0aZ1c29Kk2j81VqZNEVaI4NkSEFAMoM
 vqTwi4uNHasuA9VPWfiAHnECllyDkMFQex8woxfl4D8Vp5+mD/fp29CDot/vKEXe
 pE8i8+7bd6BDxEgSmZaqI9X56Hcpm8WZ++kbhRVrpzHr6NOc74NPdaeywq+vreqP
 erHbIWKYwx+S7DcEmVx4x3AnJXTRfwR2KrsYOuKLxJY1Y/UhzZ+ClhNOeXLJOHOj
 inxhGTMQO3XVGm4t2mImYO0wo31HTVdME4RiHFlUd3n442JFAETswMw6MBzaVzY/
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460r6qg1tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN17FB009292; Mon, 14 Apr 2025 02:03:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:44 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYk035550;
 Mon, 14 Apr 2025 02:03:43 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-13; Mon, 14 Apr 2025 02:03:43 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 12/18] amd_iommu: Add replay callback
Date: Mon, 14 Apr 2025 02:02:47 +0000
Message-ID: <20250414020253.443831-13-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-GUID: Mi1OjZil_dPDAY5UG6S38eUMgP1BSYjH
X-Proofpoint-ORIG-GUID: Mi1OjZil_dPDAY5UG6S38eUMgP1BSYjH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

A replay() method is necessary to efficiently synchronize the host page
tables after VFIO registers a notifier for IOMMU events. It is called
to ensure that existing mappings from an IOMMU memory region are
"replayed" to a specified notifier, initializing or updating the shadow
page tables on the host.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index cf83ac607064..e24eab34c9e0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1902,6 +1902,28 @@ static void amdvi_switch_address_space_all(AMDVIState *s)
     }
 }
 
+/*
+ * For every translation present in the IOMMU, construct IOMMUTLBEntry data
+ * and pass it as parameter to notifier callback.
+ */
+static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+{
+    AMDVIAddressSpace *as = container_of(iommu_mr, AMDVIAddressSpace, iommu);
+    uint64_t dte[4] = { 0 };
+
+    if (!(n->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    amdvi_address_space_unmap(as, n);
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
+}
+
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
@@ -2223,6 +2245,7 @@ static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, void *data)
 
     imrc->translate = amdvi_translate;
     imrc->notify_flag_changed = amdvi_iommu_notify_flag_changed;
+    imrc->replay = amdvi_iommu_replay;
 }
 
 static const TypeInfo amdvi_iommu_memory_region_info = {
-- 
2.43.5


