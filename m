Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD65C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27P-000231-Q1; Tue, 10 Jun 2025 12:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP155-0004L0-JT
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP153-00066K-GE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:07 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXhFv003474;
 Tue, 10 Jun 2025 15:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=TGdgbhbw+gjdR3rxNiYgbPBijyVvtbeEpfVISlZwIfw=; b=
 rOMGWo86hbJEIGXyFBiXFhycLDRIZBA7O4+RUgAse5X3VXz4B8MPBRN+wcZD9Y5I
 JL6gIF3T5KJjpCqfB5mf66aveS+B/92wy/HIESvl3gJ1eywcTFAFxKES+f1Vkuf5
 MBOMOElsCHnTECupbUABscL7Q9v1vZIaWtVHdjnofy32JiZewwwYOiLJLJyw8na0
 r+Fht4h9+UO5OHO76y6EBWTZ/kBiTtJmCoD8UkDgGo1DoSSWF8EroC3NyjhICihP
 xRK+M1TlKnJB2gVHFDnCIRBCPB1udzzuZDaeHszM4WRP0vkLG5eoeQLVyzWrrszp
 NXEGH3YQinwfBddxZU7CSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf4hww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEn3EL003965; Tue, 10 Jun 2025 15:40:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wara-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfJ028825;
 Tue, 10 Jun 2025 15:40:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-7; Tue, 10 Jun 2025 15:40:01 +0000
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
Subject: [PATCH V5 06/38] vfio/container: restore DMA vaddr
Date: Tue, 10 Jun 2025 08:39:19 -0700
Message-Id: <1749569991-25171-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=684851d2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=626zc_ahws52PzRrjaMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: 7jQzU-Own2fEckjTBJK_M9-rC6pygnU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX1ZiytNolkF1a
 WAT6YYEx9YCgNBLcAjqg8M5jFvcGx1Ki1ry4QkkiMF/1oVRjg1ieghU7lLi6QOrak9M/5j/40v0
 DPN1t80sOg2Xu/JPL/y8B2bh9EPpbfRGNkpTOfYfJee4v16e3uG5178AN8yWVBhLkFjrRY9KTst
 KMRCxQtmH31iHU3k3TXG3wi9DjQbgctQyEXP/aTfQRh9WLmGRovVdE4xW6QBVm+65XXfiw0kJOr
 PvtngZaQwEOuDP5ccqALUbN0wMMAI2ZSerPqZkfMnhMdQr1HtM7SOjHoEJirHgC6SC67vQGob9n
 /og7pTvPJAAD02PKsgA2GnwRjeA0MKJL+3oSpL7P52etkiwMRQBX4TWMqQ5IELYytrcyDmx3Gl7
 UO3ykXHm9NUh84bUXjT+eaBVqNANm/EIbib5XlhsPo4TqsB5/Rq1svBmfY5YiZQEEiLcR9Gh
X-Proofpoint-ORIG-GUID: 7jQzU-Own2fEckjTBJK_M9-rC6pygnU8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
index 5caae4c..936ce37 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -136,6 +136,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
+    g_assert(!cpr_is_incoming());
+
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -690,8 +692,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
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
index ef106d0..2fd8348 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -9,11 +9,13 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-container.h"
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
@@ -30,6 +32,32 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
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
@@ -58,11 +86,34 @@ static int vfio_container_pre_save(void *opaque)
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
@@ -85,6 +136,12 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
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


