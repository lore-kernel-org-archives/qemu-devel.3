Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC82CC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx5-0003uo-E3; Thu, 01 May 2025 22:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwx-0003ry-Du
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwv-0007QR-FZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:27 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeMYo024913;
 Fri, 2 May 2025 02:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=lkm/p
 AkVVKxVt7VYltQtcSibScquilHa4q4bpYTiKfE=; b=pGyEmUSz9tZVLONVN6E7e
 tF/RqvS8prGHIHTkWRB1U+6zhviNU+iV35jnItfKPxtBV68QtkolvS51sLWsY0bI
 25JVHcgRtu2GmUT00JIsZMSpxTu6ppHRbBIuufEIIp3Lzunwshi9kK9RiRzrmNo6
 s6VZjTrPJ9m2MIwEPNCsVj7KuTngoeLOMUHK/Gz4UT68lB+FElHFMdCaEEJ9Uc7P
 s66oWde5WWQwwfXvJXVtkq/bclbCats05BjLXXjqLXnq/HGNxNRBDyOD4TKAuGZK
 w2spAyYrPnSOmtP4eV16WMBXM/WPyUxiK3UFN2ATxOomX4C25ht/sEaIMSftx4Sa
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmcp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NiQwp023819; Fri, 2 May 2025 02:16:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh010-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEs8011525;
 Fri, 2 May 2025 02:16:13 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-10; Fri, 02 May 2025 02:16:13 +0000
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
Subject: [PATCH v2 09/20] amd_iommu: Add basic structure to support IOMMU
 notifier updates
Date: Fri,  2 May 2025 02:15:54 +0000
Message-ID: <20250502021605.1795985-10-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: Ws6OJXfLcCgLEGUNHUAoIg-rmLLXCRc0
X-Proofpoint-GUID: Ws6OJXfLcCgLEGUNHUAoIg-rmLLXCRc0
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68142aef b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=DMbGAvdIka4_Ax_3_vgA:9 cc=ntf
 awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfXwwBsIpvjZnvn
 tpuyjEAWOIybaj0sq5goB/QSQnJzRNwiLTvNFw28TVM9y4sUqciJKGNG4PUxJAfkafB7O4AWSn+
 qVJBNx9MThqoFsLMb2OxwmoyF7Rxl1M0ea3KpjI4i7wN0ruvmBrHtHUWJSxbJZgg38gEqO1H9MB
 +R/gadyY9mE5aVWBoiAtLzGbb2pe4lXEMqtJcxIzofRZe9ZTfA/irKNacC1TsN9JZaI7yfdhJNZ
 EZ2Seeb76ecZ1jtKcbGob7U6qbI1kAksyiVvD0SRypWtYpHlxq/1M7Q0g1LIPopw7zooXOMODZb
 W5dqZFo6380ekZ1ZmdXCKgXff4pf/FyrZgUvP3klDltG6KDSnyG3npUanSG7JXxokYoJCFybwLg
 yT2WEJfZa39dtHR2eh8ReoBqSMy/lfcF2jMwFjlDExlrNeGCXhn7MaSPF90ht3H+LDpd7F5O
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

Add the minimal data structures required to maintain a list of address
spaces (i.e. devices) with registered notifiers, and to update the type of
events that require notifications.
Note that the ability to register for MAP notifications is not available.
It will be unblocked by following changes that enable the synchronization of
guest I/O page tables with host IOMMU state, at which point an amd-iommu
device property will be introduced to control this capability.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 26 +++++++++++++++++++++++---
 hw/i386/amd_iommu.h |  3 +++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6a2ba878dfa7..2f69459ab68d 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -66,6 +66,11 @@ struct AMDVIAddressSpace {
     MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
+
+    /* DMA address translation support */
+    IOMMUNotifierFlag notifier_flags;
+    /* entry in list of Address spaces with registered notifiers */
+    QLIST_ENTRY(AMDVIAddressSpace) next;
 };
 
 /* AMDVI cache entry */
@@ -1711,6 +1716,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
+        iommu_as[devfn]->notifier_flags = IOMMU_NONE;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -1791,14 +1797,28 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                            Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
+    AMDVIState *s = as->iommu_state;
 
     if (new & IOMMU_NOTIFIER_MAP) {
         error_setg(errp,
-                   "device %02x.%02x.%x requires iommu notifier which is not "
-                   "currently supported", as->bus_num, PCI_SLOT(as->devfn),
-                   PCI_FUNC(as->devfn));
+                "device %02x.%02x.%x requires iommu notifier which is not "
+                "currently supported", as->bus_num, PCI_SLOT(as->devfn),
+                PCI_FUNC(as->devfn));
         return -EINVAL;
     }
+
+    /*
+     * Update notifier flags for address space and the list of address spaces
+     * with registered notifiers.
+     */
+    as->notifier_flags = new;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(as, next);
+    }
+
     return 0;
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 5e35d4b15167..a7462b2adb79 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -411,6 +411,9 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of address spaces with registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
-- 
2.43.5


