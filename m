Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A8C369A2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1nOr-0002OM-8G; Mon, 07 Apr 2025 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nOo-0002NZ-TF; Mon, 07 Apr 2025 10:24:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nOm-0006Gj-Th; Mon, 07 Apr 2025 10:24:30 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537E3KRx025701;
 Mon, 7 Apr 2025 14:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=j0YNjLcDk0NRiIQUZ
 xwqcNOWVPq4sBssI5WzUs3fHYc=; b=i+f/cZ35OCC8XFqNz7FxRlOl31moZGeem
 JqgbPLoKqxyRwoRz33FSohE1Khb5vw+ZI6gCGi5v45p2EuhNP2T5flYxdkKQslNF
 HC6PyOCUaHYZ5HYL2DD9LN8eysMIXuOBz414O0jNghTiE0K/2XlW+Eqc9mu3uMYc
 vovc2K/pgEXTHjp34eDY/OQAFQ8pNXEt8g1ub6O9fnjy0CFmE3P2VKLrlBVOzQzT
 vYN4s4Y23ux05Rfl2R0ukQQfjjSurk2tEaR5d1yAGRophDveyDS0SVSe9KNLNQL+
 eaDCCd+JPJ+7GHLUszNYi/j9gMJ2ivtDCM9n8Vo2XKzDuTITV9CTQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vg4q83aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 537E3SYI026019;
 Mon, 7 Apr 2025 14:24:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vg4q83at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537BJIHk018451;
 Mon, 7 Apr 2025 14:24:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kdye6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:24:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 537EOLHh42336538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 14:24:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30E5920040;
 Mon,  7 Apr 2025 14:24:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEDC62004B;
 Mon,  7 Apr 2025 14:24:18 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com.com (unknown
 [9.124.220.105])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Apr 2025 14:24:18 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] vfio/spapr: Fix L2 crash with PCI device passthrough with
 L2 guest 1memory > 128G
Date: Mon,  7 Apr 2025 19:53:37 +0530
Message-ID: <20250407142337.1272599-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407142337.1272599-1-amachhiw@linux.ibm.com>
References: <20250407142337.1272599-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jY1Xtel0plJEBqnZDYoxYKOcwODoANdO
X-Proofpoint-GUID: 1N3GXrOy8Qp4Qjjhq9qIQ9cxWJr6QZBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070098
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Link: https://lore.kernel.org/qemu-devel/20250404091721.2653539-1-amachhiw@linux.ibm.com/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/vfio/spapr.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4f2858b43f36..bcc6fe56e76e 100644
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
 
@@ -291,16 +294,29 @@ static int vfio_spapr_create_window(VFIOContainer *container,
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
+            error_setg(errp, "Host doesn't support multi-level TCE tables"
+                       ". Use larger IO page size. Supported mask is 0x%lx",
+                       bcontainer->pgsizes);
+            return -EINVAL;
+        }
+        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
     }
+
     if (ret) {
         error_setg_errno(errp, -ret, "Failed to create a window, ret = %d (%m)", ret);
         return -errno;
@@ -503,6 +519,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         goto listener_unregister_exit;
     }
 
+    scontainer->levels = info.ddw.levels;
+
     if (v2) {
         bcontainer->pgsizes = info.ddw.pgsizes;
         /*
-- 
2.49.0


