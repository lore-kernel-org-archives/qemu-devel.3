Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD60BC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwT0-0004XR-2x; Fri, 14 Feb 2025 09:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSy-0004Qe-1J
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSw-0004Sz-8R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:51 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECuZE8002760;
 Fri, 14 Feb 2025 14:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=6nVQvnw1f40pgwFP/V5go6owNUca75t/z4U59Azj1a4=; b=
 HebwY+Z77Toc773AjhjM5Wrn2yzzKlZ2h0tUiTNNEUc4t6VkdzHVbAxOOPAp6y/c
 yPDI01KLDcOMDc6LPv5ziJopyuvNdQSMnhs/pEyXae4GtnsiyUOllF6vThJYTd1/
 E284CJu+0Eqct/mZKkTsVNuMRiIlpqyy1331CyIA2ddkhv7CGqE4IClU4flxUXpO
 lhjbV7of2j5r5CN4oWad4mLX5K/9uXOIy0hZpMb5tWyVxbI/fVialy81sBqdeQGd
 T+vBS4tG3v9gTT1st5r8l/ON7YoHFBvm34LmxY7X8zetiAsO2lFos9acz9Kpp7ny
 3dJKHwDV/9af2jJNY226kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2kruq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECuXh5025256; Fri, 14 Feb 2025 14:14:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksga9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPb006920;
 Fri, 14 Feb 2025 14:14:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-13; Fri, 14 Feb 2025 14:14:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 12/45] vfio/container: restore DMA vaddr
Date: Fri, 14 Feb 2025 06:13:54 -0800
Message-Id: <1739542467-226739-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: ZV2R_LX7S_QXfTDOxPGvj-iqSSW1_nAE
X-Proofpoint-ORIG-GUID: ZV2R_LX7S_QXfTDOxPGvj-iqSSW1_nAE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

In new QEMU, do not register the memory listener at device creation time.
Register it later, in the container post_load handler, after all vmstate
that may affect regions and mapping boundaries has been loaded.  The
post_load registration will cause the listener to invoke its callback on
each flat section, and the calls will match the mappings remembered by the
kernel.

The listener calls a special dma_map handler that passes the new VA of each
section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
handler at the end.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c  | 15 +++++++++++++--
 hw/vfio/cpr-legacy.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 931c435..d26f78e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -133,6 +133,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    assert(!container->cpr.reused);
+
     if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -688,8 +690,17 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
     group_was_added = true;
 
-    bcontainer->listener = vfio_memory_listener;
-    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+    /*
+     * If reused, register the listener later, after all state that may
+     * affect regions and mapping boundaries has been cpr load'ed.  Later,
+     * the listener will invoke its callback on each flat section and call
+     * dma_map to supply the new vaddr, and the calls will match the mappings
+     * remembered by the kernel.
+     */
+    if (!cpr_reused) {
+        bcontainer->listener = vfio_memory_listener;
+        memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+    }
 
     if (bcontainer->error) {
         error_propagate_prepend(errp, bcontainer->error,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 97a64e7..bb5f802 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -14,6 +14,7 @@
 #include "migration/migration.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 
 static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
 {
@@ -30,6 +31,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
     return true;
 }
 
+/*
+ * Set the new @vaddr for any mappings registered during cpr load.
+ * Reused is cleared thereafter.
+ */
+static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   bool readonly)
+{
+    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                                  bcontainer);
+    struct vfio_iommu_type1_dma_map map = {
+        .argsz = sizeof(map),
+        .flags = VFIO_DMA_MAP_FLAG_VADDR,
+        .vaddr = (__u64)(uintptr_t)vaddr,
+        .iova = iova,
+        .size = size,
+    };
+
+    assert(container->cpr.reused);
+
+    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
+        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
+                     iova, size, vaddr, strerror(errno));
+        return -errno;
+    }
+
+    return 0;
+}
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
@@ -61,12 +90,20 @@ static int vfio_container_pre_save(void *opaque)
 static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOGroup *group;
     VFIODevice *vbasedev;
 
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
     container->cpr.reused = false;
 
     QLIST_FOREACH(group, &container->group_list, container_next) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+        /* Restore original dma_map function */
+        vioc->dma_map = vfio_legacy_dma_map;
+
         QLIST_FOREACH(vbasedev, &group->device_list, next) {
             vbasedev->cpr.reused = false;
         }
@@ -78,6 +115,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
@@ -102,6 +140,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    /* During incoming CPR, divert calls to dma_map. */
+    if (container->cpr.reused) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+    }
     return true;
 }
 
-- 
1.8.3.1


