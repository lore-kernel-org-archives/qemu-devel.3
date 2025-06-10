Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1871BC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP279-0001wD-JD; Tue, 10 Jun 2025 12:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP157-0004Lz-W1
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP155-00068u-V3
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:09 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdpX006986;
 Tue, 10 Jun 2025 15:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=QUU0fKUJ7eNNO48YhuYUW7qhsp8+PgVI/Q0OcQpjfqI=; b=
 r4XODh20IZdXrMQTSDqEZjVaRjIDd47Hv+mKEBrRAQAYzf0pqFnlwbRbBv8g2Oow
 XzLrMoun67UFtQzh0fY/EHFgAPWwZpQiZ+wCSWUVjHfFwy0B+IMpLQe1HCTBQyn8
 6QAqdJrRsGOQTLB2PUC3fJQS2BUYSVL4QptafU4vY2FwjHSXTmchNlW3RPeFyLB1
 yNf6N/CUcW+qjcjwclbdwAyeKjuxg9LvBlYVeQZqXYN+frOpbMMHO1o5fB3U54T0
 Vl+GHGAOwinGgAqweXKSOphT44S/h4TP1e6MI3cFphUmnwe+/rQPFOcx9yh0/0Ju
 4YgNKPRP1VKiOzCWm3vxDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74vjq7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEQr8j004067; Tue, 10 Jun 2025 15:40:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8waty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:04 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfN028825;
 Tue, 10 Jun 2025 15:40:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-9; Tue, 10 Jun 2025 15:40:03 +0000
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
Subject: [PATCH V5 08/38] vfio/container: recover from unmap-all-vaddr failure
Date: Tue, 10 Jun 2025 08:39:21 -0700
Message-Id: <1749569991-25171-9-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684851d5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=bXQ6ZcJOO1ukfLjjEFYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: g_iLs4awUVLYLUVocTkLYb4eayf8aNwK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX9f5NqtiM2aTp
 PwzAg2jOBGWvo4mKFzA0ZGlAQOB0LBIoiEtV8iltinZ/aKN3u14fvXQ5cItKXN5/5zlQRtJSanI
 Q+bqAI4Ujyi++Lq2qDAPbpdrTngiaSzY0Mf39NM7Hh73+drNpZM12cl46RHUAPHle0jAmvgN59u
 2jZAVfHHoT1KYWPwjt7BX3c+CtaEoIGoEEikmpoYLusnfAVUKvk9bRu3LRifa+u54M3CoTZU0KA
 ymKKmf9+rVAaLztKn9Adehx3wfL68cgpQE/eOc7GRpSnHadYEwSAG6dWi3nh4WNIhF/SzYera+2
 ppp/+vG286Y8mHr/lSfQhrhfH70bb00wofSMKKshxS+4G0KzV1l0ez8ff6c1k4Gbdg/Z9EcChAt
 2nyFti5SzhcAW0yw7E0cHT7+pSWS0ysJF1OAuAr7ZhAnx69V9STPAXTrSPXyIFurzrvH2wq7
X-Proofpoint-GUID: g_iLs4awUVLYLUVocTkLYb4eayf8aNwK
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

If there are multiple containers and unmap-all fails for some container, we
need to remap vaddr for the other containers for which unmap-all succeeded.
Recover by walking all address ranges of all containers to restore the vaddr
for each.  Do so by invoking the vfio listener callback, and passing a new
"remap" flag that tells it to restore a mapping without re-allocating new
userland data structures.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  3 ++
 include/hw/vfio/vfio-cpr.h            | 10 ++++
 hw/vfio/cpr-legacy.c                  | 91 +++++++++++++++++++++++++++++++++++
 hw/vfio/listener.c                    | 19 +++++++-
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9d37f86..f023265 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -256,4 +256,7 @@ struct VFIOIOMMUClass {
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section, bool cpr_remap);
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index b83dd42..56ede04 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -10,6 +10,7 @@
 #define HW_VFIO_VFIO_CPR_H
 
 #include "migration/misc.h"
+#include "system/memory.h"
 
 struct VFIOContainer;
 struct VFIOContainerBase;
@@ -17,6 +18,9 @@ struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    bool vaddr_unmapped;
+    NotifierWithReturn transfer_notifier;
+    MemoryListener remap_listener;
     int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
                          hwaddr iova, ram_addr_t size,
                          void *vaddr, bool readonly, MemoryRegion *mr);
@@ -42,4 +46,10 @@ int vfio_cpr_group_get_device_fd(int d, const char *name);
 bool vfio_cpr_container_match(struct VFIOContainer *container,
                               struct VFIOGroup *group, int fd);
 
+void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section);
+
+bool vfio_cpr_ram_discard_register_listener(
+    struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 2fd8348..a84c324 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -29,6 +29,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
         error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
         return false;
     }
+    container->cpr.vaddr_unmapped = true;
     return true;
 }
 
@@ -59,6 +60,14 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+static void vfio_region_remap(MemoryListener *listener,
+                              MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer,
+                                            cpr.remap_listener);
+    vfio_container_region_add(&container->bcontainer, section, true);
+}
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -120,6 +129,40 @@ static const VMStateDescription vfio_container_vmstate = {
     }
 };
 
+static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    VFIOContainer *container =
+        container_of(notifier, VFIOContainer, cpr.transfer_notifier);
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    if (e->type != MIG_EVENT_PRECOPY_FAILED) {
+        return 0;
+    }
+
+    if (container->cpr.vaddr_unmapped) {
+        /*
+         * Force a call to vfio_region_remap for each mapped section by
+         * temporarily registering a listener, and temporarily diverting
+         * dma_map to vfio_legacy_cpr_dma_map.  The latter restores vaddr.
+         */
+
+        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        vioc->dma_map = vfio_legacy_cpr_dma_map;
+
+        container->cpr.remap_listener = (MemoryListener) {
+            .name = "vfio cpr recover",
+            .region_add = vfio_region_remap
+        };
+        memory_listener_register(&container->cpr.remap_listener,
+                                 bcontainer->space->as);
+        memory_listener_unregister(&container->cpr.remap_listener);
+        container->cpr.vaddr_unmapped = false;
+        vioc->dma_map = container->cpr.saved_dma_map;
+    }
+    return 0;
+}
+
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -142,6 +185,10 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
         container->cpr.saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
     }
+
+    migration_add_notifier_mode(&container->cpr.transfer_notifier,
+                                vfio_cpr_fail_notifier,
+                                MIG_MODE_CPR_TRANSFER);
     return true;
 }
 
@@ -152,6 +199,50 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
+    migration_remove_notifier(&container->cpr.transfer_notifier);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a giommu.
+ *
+ * The giommu already exists.  Find it and replay it, which calls
+ * vfio_legacy_cpr_dma_map further down the stack.
+ */
+void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
+                           MemoryRegionSection *section)
+{
+    VFIOGuestIOMMU *giommu = NULL;
+    hwaddr as_offset = section->offset_within_address_space;
+    hwaddr iommu_offset = as_offset - section->offset_within_region;
+
+    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
+        if (giommu->iommu_mr == IOMMU_MEMORY_REGION(section->mr) &&
+            giommu->iommu_offset == iommu_offset) {
+            break;
+        }
+    }
+    g_assert(giommu);
+    memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
+}
+
+/*
+ * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
+ * succeeding for others, so the latter have lost their vaddr.  Call this
+ * to restore vaddr for a section with a RamDiscardManager.
+ *
+ * The ram discard listener already exists.  Call its populate function
+ * directly, which calls vfio_legacy_cpr_dma_map.
+ */
+bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+                                            MemoryRegionSection *section)
+{
+    VFIORamDiscardListener *vrdl =
+        vfio_find_ram_discard_listener(bcontainer, section);
+
+    g_assert(vrdl);
+    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
 }
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 203ed03..2e57986 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -481,6 +481,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
+    vfio_container_region_add(bcontainer, section, false);
+}
+
+void vfio_container_region_add(VFIOContainerBase *bcontainer,
+                               MemoryRegionSection *section,
+                               bool cpr_remap)
+{
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -516,6 +523,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
         int iommu_idx;
 
         trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
+
+        if (cpr_remap) {
+            vfio_cpr_giommu_remap(bcontainer, section);
+        }
+
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
          * avoid bouncing all map/unmaps through qemu this way, this
@@ -558,7 +570,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
      * about changes.
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
-        vfio_ram_discard_register_listener(bcontainer, section);
+        if (!cpr_remap) {
+            vfio_ram_discard_register_listener(bcontainer, section);
+        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
+                                                           section)) {
+            goto fail;
+        }
         return;
     }
 
-- 
1.8.3.1


