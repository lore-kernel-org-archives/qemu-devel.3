Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8FFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxC-0003wg-6p; Thu, 01 May 2025 22:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx8-0003wR-3q
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx6-0007Sg-98
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KehD3002694;
 Fri, 2 May 2025 02:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=BAsTK
 xPJdaBto0oMjG5raGu+WMLLy+UesmJe1bKhmNc=; b=YFtktGis/XMSGvUC+B83I
 TMx0tvG97lxlbLrWRwwmwbep34M0TwaJYYru35E3Tt7X1UL60Q1c5foPdsUMAd4b
 4LKXEJs4jY3K0vEkke3VHs4yiWG6j5CluBt5hPMz+WcHGPcb+jLB1yu5iA7J0WXE
 oK7WAAH7GDRhdw41+QTj/+QR2/71H3ZMXozqVxjon72kAXamkb9W95xH5QXDFucP
 tKDzW85bA1k2iLbWYtyY4myu8NggBL2AwF/WRSrsrrDorSrbLPex5h7v0bc5cJVZ
 Xx59aGqUk1KCbG+Exg+3g/zhwdwEHE0dLLc3HKNbbU7j3RHZMQgetdubQUCUyubt
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umcccp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54224M6h023734; Fri, 2 May 2025 02:16:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh035-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsK011525;
 Fri, 2 May 2025 02:16:17 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-16; Fri, 02 May 2025 02:16:17 +0000
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
Subject: [PATCH v2 15/20] amd_iommu: Toggle memory regions based on address
 translation mode
Date: Fri,  2 May 2025 02:16:00 +0000
Message-ID: <20250502021605.1795985-16-alejandro.j.jimenez@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=68142afe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Ym2Byh7nbDj_XmYuizYA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: 8TWZRzFmq0DuQOTLO6pa3hCjT2W8DbmY
X-Proofpoint-ORIG-GUID: 8TWZRzFmq0DuQOTLO6pa3hCjT2W8DbmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX4yF7EyfCHeDu
 T+BK7wHQjKHQJGyEFYQB/VKMRxkWQ5X95Qf2P6VptyFX2kS6uxUQcxDjGTzVJNfxtVKGwjuHfn+
 3lQLw0UFmKaqxE5d+VFaqhqASqSfCYeTV4mAOkzAAr8bw6HehHQupjX879zDg8iHS2W5j+mlyLX
 ICutI140kkgQ00mlX5QCBOLZ0KzqlvfAWMsZz4gewVqWuCC92ZMBqw8WTUNc9dFKFWpPm1GfWun
 TtbELkSHGHllNvYzcbheHDIP2XPh6+BRkB5HqXxz4vvSPTMCHQTftFpMIGsua7EE2hs9eRcZFSL
 gLv5zAt3paceWyW0duqh8AusMbN4xdzETEwwWtgw0c88ok0WHNw0GsJiQ6TUJ29klSjtqjxiPBC
 tM9o2WxkvDijnHInOoqVWo807I3LyWIWbFXplyOLmwBDbUw7t83x9T/fYEFUNQWO8xv+ecYd
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Enable the appropriate memory region for an address space depending on the
address translation mode selected for it. This is currently based on a
generic x86 IOMMMU property, and only done during the address space
initialization. Extract the code into a helper and toggle the regions based
on whether the specific address space is using address translation (via the
newly introduced addr_translation field). Later, region activation will also
be controlled by availability of DMA remapping capability (via dma-remap
property to be introduced in follow up changes).

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index fa5dbc3cc700..71018d70dd10 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -74,6 +74,8 @@ struct AMDVIAddressSpace {
     QLIST_ENTRY(AMDVIAddressSpace) next;
     /* Record DMA translation ranges */
     IOVATree *iova_tree;
+    /* DMA address translation active */
+    bool addr_translation;
 };
 
 /* AMDVI cache entry */
@@ -943,6 +945,23 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
     }
 }
 
+/*
+ * Toggle between address translation and passthrough modes by enabling the
+ * corresponding memory regions.
+ */
+static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
+{
+    if (amdvi_as->addr_translation) {
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
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -1986,7 +2005,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -2006,6 +2024,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NONE;
         iommu_as[devfn]->iova_tree = iova_tree_new();
+        iommu_as[devfn]->addr_translation = false;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -2048,15 +2067,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
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


