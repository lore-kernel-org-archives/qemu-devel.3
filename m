Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E059C5B543
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisK-000495-4R; Thu, 29 May 2025 15:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisF-00044r-Kl
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisC-0000Di-7M
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsTh031396;
 Thu, 29 May 2025 19:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=5J/B2T5q1oFmmdmJqVyBp34KjchbZpqFO0v45kJDbi4=; b=
 R53lV3psTvOOij7h3xjaZntuX4cX44DiJjc5+ufX+96OcT89S81uvJue2x6Cx4U3
 X3ltxtJ/Vy91O70zKarMq5todjn5Fnf8j6gRg+udELpjXQnfAbgVyDnAoFH12NY9
 b3VgS1f6XjDTYOfuoDx+DZK38PRh98FS2nNmg1aDIU6m2RfYj1nxeFU6VbWATTKV
 hObXky9t4cSkQ9U6LgxB4vfEr51Nhi/w65jhmzjcWPMUzZKRlA7dUE5jChwVdvzw
 /LAy0k7/ucmiriz/xOCt7QLzjBsdAgsfG8WXC82TDA1mg7KAPGav1YUSesjkc8YF
 kBhb/2qgHgh0jEPzGLoCMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0yc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THfAdM020441; Thu, 29 May 2025 19:24:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRB022158;
 Thu, 29 May 2025 19:24:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-13; Thu, 29 May 2025 19:24:50 +0000
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
Subject: [PATCH V4 12/43] vfio/container: restore DMA vaddr
Date: Thu, 29 May 2025 12:24:08 -0700
Message-Id: <1748546679-154091-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX9DX/t4/EGbpT
 w+LbVcJnRvESRGY/DTN1kzT8uJN+sXgvoj0LRd+s3jLPb2FTLOvXrpia4V1/kSIUXFaNpSdu81u
 VX+ZhHBm1+G7mHUxAAFzNagRL04xd9OQniOQNXRTBuyUX4L+/ncY9z7GCRDFba/vxmf0zhJZyjz
 ylP6DKKF7dKTqjDiK8o5gMADF44HI3ue0HwV7m6CaLfLAi4HgmJM3ljX2+0JrdsvPoLj4QXaJ61
 Gj5PQB74hlxsU+dAzOELrXLuvAKpKm9SZy83PyMxGuDo2y8QUE+pBy53QmInEkHxgbOFMbKc7YS
 pcDIRJrOf4rZY8jTWsPV7DKMe1efx1FTaB4aK9bpegVcGeDHAZNlaD5t923Q0upi+0FyhLob+jO
 FB2SBDTb0ekvuiYlBBEmK6BpGSotmoW/DTrg+W8qfyYNwQGN2DdbObkNK8eSge5erxkEZsyH
X-Proofpoint-GUID: rIgLg_Ce4ZvR83N_X-w2xQlB8r1i70P8
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b483 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=626zc_ahws52PzRrjaMA:9
X-Proofpoint-ORIG-GUID: rIgLg_Ce4ZvR83N_X-w2xQlB8r1i70P8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/vfio/vfio-cpr.h |  3 +++
 hw/vfio/container.c        | 15 ++++++++++--
 hw/vfio/cpr-legacy.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 5a2e5f6..0462447 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -17,6 +17,9 @@ struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
+                         hwaddr iova, ram_addr_t size,
+                         void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 798abda..f91f2d5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    g_assert(!cpr_is_incoming());
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     }
     group_was_added = true;
 
-    if (!vfio_listener_register(bcontainer, errp)) {
-        goto fail;
+    /*
+     * If CPR, register the listener later, after all state that may
+     * affect regions and mapping boundaries has been cpr load'ed.  Later,
+     * the listener will invoke its callback on each flat section and call
+     * dma_map to supply the new vaddr, and the calls will match the mappings
+     * remembered by the kernel.
+     */
+    if (!cpr_is_incoming()) {
+        if (!vfio_listener_register(bcontainer, errp)) {
+            goto fail;
+        }
     }
 
     bcontainer->initialized = true;
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index cf80332..512ef41 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -10,11 +10,13 @@
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 
 static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
 {
@@ -31,6 +33,32 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
     return true;
 }
 
+/*
+ * Set the new @vaddr for any mappings registered during cpr load.
+ * The incoming state is cleared thereafter.
+ */
+static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
+                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   bool readonly, MemoryRegion *mr)
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
+    g_assert(cpr_is_incoming());
+
+    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
+        return -errno;
+    }
+
+    return 0;
+}
 
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
@@ -59,11 +87,34 @@ static int vfio_container_pre_save(void *opaque)
     return 0;
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOContainer *container = opaque;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOGroup *group;
+    Error *local_err = NULL;
+
+    if (!vfio_listener_register(bcontainer, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+        /* Restore original dma_map function */
+        vioc->dma_map = container->cpr.saved_dma_map;
+    }
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
+    .post_load = vfio_container_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
@@ -86,6 +137,12 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
+    /* During incoming CPR, divert calls to dma_map. */
+    if (cpr_is_incoming()) {
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        container->cpr.saved_dma_map = vioc->dma_map;
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+    }
     return true;
 }
 
-- 
1.8.3.1


