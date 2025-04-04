Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C89C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 09:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0dBW-00010R-Rn; Fri, 04 Apr 2025 05:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u0dBV-0000zV-4i; Fri, 04 Apr 2025 05:17:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u0dBO-0008MT-Nu; Fri, 04 Apr 2025 05:17:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341hqq9018440;
 Fri, 4 Apr 2025 09:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZkUsX2DzcPb/ghztCUGrebQztK3HJwQfsJ6UDmAhv
 QE=; b=aWjYLuJlPbY7nNnjRrcB2spDL4Hi2mWL+CFcMZNE/8HoI1Zbs+lsTl0ZC
 qRi7J1nDpgb4fmcodVyhCfoHdf+2LkADajnQTYcBCO2Ce16HlZ8+0CcHDwUmDb1s
 L1xodyOW7MyIqSYp0FAKO8yBUiGvUSiaZB2wJhyqZBvCc+b/K7EklUGz1meHQH02
 hwZ7oZQS9DCuUUZ/T6d9QuZdCuHmujT/cDpEUvqbm9JnT5hB1q3NYrM6mtA4guZi
 31vCHa0UG+4PbZmnTbEGd73qfQjYGliXzsBWi8Rat2SsYd6V9tysag5KFT7Z+Slv
 c8Ea6RrV5+li6FZ7mI+emMjAwTMyA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45t2qb2d1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Apr 2025 09:17:46 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5349DrVs011428;
 Fri, 4 Apr 2025 09:17:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45t2qb2d1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Apr 2025 09:17:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5346g4Rh002750;
 Fri, 4 Apr 2025 09:17:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45t2e6a9mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Apr 2025 09:17:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5349Hfsb37486994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Apr 2025 09:17:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 335F12004D;
 Fri,  4 Apr 2025 09:17:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D46E2004B;
 Fri,  4 Apr 2025 09:17:39 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com.com (unknown
 [9.39.17.133]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Apr 2025 09:17:38 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/spapr: Fix L2 crash with PCI device passthrough with L2
 guest memory > 128G
Date: Fri,  4 Apr 2025 14:47:21 +0530
Message-ID: <20250404091721.2653539-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4sG0DhX3CLmFUs9Tr2JDgzDetxTQsBpI
X-Proofpoint-GUID: 050DjS4mtdfS3V0pWuOffA_2U-6xGvjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504040060
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

An L2 KVM guest fails to boot inside a pSeries LPAR when booted with a
memory more than 128 GB and PCI device passthrough. The L2 guest also
crashes when it is booted with a memory greater than 128 GB and a PCI
device is hotplugged later.

The issue arises from a conditional check for `levels > 1` in
`spapr_tce_create_table()` within L1 KVM. This check is meant to prevent
multi-level TCEs, which are not supported by the PowerVM hypervisor. As
a result, when QEMU makes a `VFIO_IOMMU_SPAPR_TCE_CREATE` ioctl call
with `levels > 1`, it triggers the conditional check and returns
`EINVAL`, causing the guest to crash with the following errors:

 2025-03-04T06:36:36.133117Z qemu-system-ppc64: Failed to create a window, ret = -1 (Invalid argument)
 2025-03-04T06:36:36.133176Z qemu-system-ppc64: Failed to create SPAPR window: Invalid argument
 qemu: hardware error: vfio: DMA mapping failed, unable to continue

Fix this by checking the supported DDW "levels" returned by the
VFIO_IOMMU_SPAPR_TCE_GET_INFO ioctl before attempting the TCE create
ioctl in KVM.

The patch has been tested on KVM guests with memory configurations of up
to 390GB, and 450GB on PowerVM and bare-metal environments respectively.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/vfio/spapr.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 1a5d1611f2cd..07498218fea9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -26,6 +26,7 @@ typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+    unsigned int levels;
 } VFIOSpaprContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
@@ -236,9 +237,11 @@ static int vfio_spapr_create_window(VFIOContainer *container,
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
-    unsigned entries, bits_total, bits_per_level, max_levels;
+    unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
     long rampagesize = qemu_minrampagesize();
 
@@ -291,16 +294,28 @@ static int vfio_spapr_create_window(VFIOContainer *container,
      */
     bits_per_level = ctz64(qemu_real_host_page_size()) + 8;
     create.levels = bits_total / bits_per_level;
-    if (bits_total % bits_per_level) {
-        ++create.levels;
-    }
-    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
-    for ( ; create.levels <= max_levels; ++create.levels) {
-        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-        if (!ret) {
-            break;
+
+    ddw_levels = scontainer->levels;
+    if (ddw_levels > 1) {
+        if (bits_total % bits_per_level) {
+            ++create.levels;
         }
+        max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
+        for ( ; create.levels <= max_levels; ++create.levels) {
+            ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+            if (!ret) {
+                break;
+            }
+        }
+    } else { /* ddw_levels == 1 */
+        if (create.levels > ddw_levels) {
+            error_report("Host doesn't support multi-level TCE tables. "
+                         "Use larger IO page size. Supported mask is 0x%lx",
+                         bcontainer->pgsizes);
+        }
+        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
     }
+
     if (ret) {
         error_report("Failed to create a window, ret = %d (%m)", ret);
         return -errno;
@@ -502,6 +517,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         goto listener_unregister_exit;
     }
 
+    scontainer->levels = info.ddw.levels;
+
     if (v2) {
         bcontainer->pgsizes = info.ddw.pgsizes;
         /*

base-commit: 0adf626718bc0ca9c46550249a76047f8e45da15
-- 
2.49.0


