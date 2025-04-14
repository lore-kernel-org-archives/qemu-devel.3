Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECEBC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Aq-0007GN-QF; Sun, 13 Apr 2025 22:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ag-0007CA-9t
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ae-0007Sd-8d
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E0qekg024617;
 Mon, 14 Apr 2025 02:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=A4kon
 xKcA+VMMC6VTX9mApCmXmj3IM7Fb7BGS3znz1Y=; b=GlwkW2jt38o8oGKyPuVWA
 GpbnC42FvjY7LlBmwJCV2XvIO7yLrqQmzX3WIqSecQKSzN/fV5pwbNPDuQsuwbOc
 U7df+kDcFNtRRMeMbON+e02Of0W4I2+BQb/FOrrnX2BU9dN0FdbRqz9TeOEbPkzj
 JG5QEDYy2njW9RBYd7/oGJ9O5gaI1aDrVoSSx57XYPJ8yfEy2Nu6iEW6V5Qb14Nt
 9YYdSae9OfKATUdsLfwxIJt9knWmILsy4tD/mOlIlYJUz4zCnQ0cysadvyRekddS
 MnFKWq84EK400mShsmzWOW/S301NheZQ09vJzjIh42TR5IwSY3FIVJMFenXnpLPR
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460r6qg1tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DMo8Mm009250; Mon, 14 Apr 2025 02:03:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYW035550;
 Mon, 14 Apr 2025 02:03:30 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-6; Mon, 14 Apr 2025 02:03:29 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 05/18] amd_iommu: Toggle memory regions based on address
 translation mode
Date: Mon, 14 Apr 2025 02:02:40 +0000
Message-ID: <20250414020253.443831-6-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: d2F-NgQLv4vL3_2-u_TprGUGpDfSgqYG
X-Proofpoint-ORIG-GUID: d2F-NgQLv4vL3_2-u_TprGUGpDfSgqYG
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

Enable the appropriate memory region for an address space depending on
the address translation mode selected for it. This is currently based on
a generic x86 IOMMMU property, and only done during the address space
initialization. Extract the code into a helper and toggle the regions
based on whether DMA remapping is available as a global capability, and
if the specific address space is using address translation.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ad5869e72fdc..3f9aa2cc8d31 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1529,13 +1529,31 @@ static const MemoryRegionOps amdvi_ir_ops = {
     }
 };
 
+/*
+ * Toggle between address translation and passthrough modes by enabling the
+ * corresponding memory regions.
+ */
+static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
+{
+    AMDVIState *s = amdvi_as->iommu_state;
+
+    if (s->dma_remap && amdvi_as->addr_translation) {
+        /* Enabling DMA region */
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
+    } else {
+        /* Disabling DMA region, using passthrough */
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
+    }
+}
+
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1595,15 +1613,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        amdvi_switch_address_space(amdvi_dev_as);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.43.5


