Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA993C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgksj-0003u5-A2; Wed, 21 Aug 2024 08:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksf-0003lg-Ii
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:56:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksd-0004yk-LA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:56:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtVvF031794;
 Wed, 21 Aug 2024 12:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=f
 volAmoI3nPEtnlPEK3w/T9QeHCWGdSJuteACSwhOCc=; b=ROwKJmObeoK73xvdc
 HSvL2CDU+G7t2mK1kmWqMXruu8l64Hu36U3+4VtrqIUPFGiXBRSvOfzc8mZGRG70
 Y1LdD4pp5AxGS+YTU5bdlUPeVzmH0qpbs/5vA8taoEvRxLtkN4K6lICAEca1/B4y
 gtbU7Dci5J/xkB5Sx9o2NHRx0kbC9CO/aEMyAgv3DM+8091X7UV6k0hw+02YKJBr
 n/OzKmI5X1lyGZ0K3oYZtZpOKmIPJgFRYpNspzzdWPzwBBf5ra2LnSGW5rG5wxej
 1Rgtr0Mg/diue/aOf8KO7hvpnCgeLYRyzNsC9wY5OKi2dthUFD//PgoouScllpzP
 BOj4Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dfgsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47LBNxTa011277; Wed, 21 Aug 2024 12:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 415fb23m62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:52 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47LCtpoQ002465;
 Wed, 21 Aug 2024 12:55:52 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-201-48.vpn.oracle.com
 [10.39.201.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 415fb23m55-2; Wed, 21 Aug 2024 12:55:52 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
Date: Wed, 21 Aug 2024 08:55:45 -0400
Message-ID: <20240821125548.749143-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821125548.749143-1-jonah.palmer@oracle.com>
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210094
X-Proofpoint-GUID: lyrnDbKEUTbL36xAziOo72mTThDazO5N
X-Proofpoint-ORIG-GUID: lyrnDbKEUTbL36xAziOo72mTThDazO5N
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
will hold all IOVA ranges that have been allocated (e.g. in the
IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.

A new API function vhost_iova_tree_insert() is also created to add a
IOVA->HVA mapping into the IOVA->HVA tree.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
 hw/virtio/vhost-iova-tree.h |  1 +
 hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
 net/vhost-vdpa.c            | 13 +++++++++++--
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 3d03395a77..32c03db2f5 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -28,12 +28,17 @@ struct VhostIOVATree {
 
     /* IOVA address to qemu memory maps. */
     IOVATree *iova_taddr_map;
+
+    /* IOVA tree (IOVA allocator) */
+    IOVATree *iova_map;
 };
 
 /**
- * Create a new IOVA tree
+ * Create a new VhostIOVATree with a new set of IOVATree's:
+ * - IOVA allocator (iova_map)
+ * - IOVA->HVA tree (iova_taddr_map)
  *
- * Returns the new IOVA tree
+ * Returns the new VhostIOVATree
  */
 VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 {
@@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
     tree->iova_last = iova_last;
 
     tree->iova_taddr_map = iova_tree_new();
+    tree->iova_map = iova_tree_new();
     return tree;
 }
 
@@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
+    iova_tree_destroy(iova_tree->iova_map);
     g_free(iova_tree);
 }
 
@@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
     /* Some vhost devices do not like addr 0. Skip first page */
     hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
 
-    if (map->translated_addr + map->size < map->translated_addr ||
-        map->perm == IOMMU_NONE) {
+    if (map->perm == IOMMU_NONE) {
         return IOVA_ERR_INVALID;
     }
 
     /* Allocate a node in IOVA address */
-    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
+    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
                                tree->iova_last);
 }
 
@@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
 {
     iova_tree_remove(iova_tree->iova_taddr_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
+}
+
+/**
+ * Insert a new mapping to the IOVA->HVA tree
+ *
+ * @tree: The VhostIOVATree
+ * @map: The iova map
+ *
+ * Returns:
+ * - IOVA_OK if the map fits in the container
+ * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
+ * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
+ */
+int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
+{
+    if (map->translated_addr + map->size < map->translated_addr ||
+        map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    return iova_tree_insert(iova_tree->iova_taddr_map, map);
 }
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 4adfd79ff0..8bf7b64786 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
                                         const DMAMap *map);
 int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
+int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
 
 #endif
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..6702459065 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     if (s->shadow_data) {
         int r;
 
-        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
+        /* Allocate IOVA range and add the mapping to the IOVA tree */
         r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
@@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         }
 
         iova = mem_region.iova;
+
+        /* Add mapping to the IOVA->HVA tree */
+        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
+        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
+        if (unlikely(r != IOVA_OK)) {
+            error_report("Can't add listener region mapping (%d)", r);
+            goto fail_map;
+        }
     }
 
     vhost_vdpa_iotlb_batch_begin_once(s);
@@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
  *
  * @v: Vhost-vdpa device
  * @needle: The area to search iova
+ * @taddr: The translated address (SVQ HVA)
  * @errorp: Error pointer
  */
 static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
-                                    Error **errp)
+                                    hwaddr taddr, Error **errp)
 {
     int r;
 
+    /* Allocate IOVA range and add the mapping to the IOVA tree */
     r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
     if (unlikely(r != IOVA_OK)) {
         error_setg(errp, "Cannot allocate iova (%d)", r);
         return false;
     }
 
+    /* Add mapping to the IOVA->HVA tree */
+    needle->translated_addr = taddr;
+    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
+    if (unlikely(r != IOVA_OK)) {
+        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
+        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
+        return false;
+    }
+
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
                            needle->size + 1,
                            (void *)(uintptr_t)needle->translated_addr,
@@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     vhost_svq_get_vring_addr(svq, &svq_addr);
 
     driver_region = (DMAMap) {
-        .translated_addr = svq_addr.desc_user_addr,
         .size = driver_size - 1,
         .perm = IOMMU_RO,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq driver region: ");
         return false;
@@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
     addr->avail_user_addr = driver_region.iova + avail_offset;
 
     device_region = (DMAMap) {
-        .translated_addr = svq_addr.used_user_addr,
         .size = device_size - 1,
         .perm = IOMMU_RW,
     };
-    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
+    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
+                                 errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq device region: ");
         vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 03457ead66..81da956b92 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
     DMAMap map = {};
     int r;
 
-    map.translated_addr = (hwaddr)(uintptr_t)buf;
     map.size = size - 1;
     map.perm = write ? IOMMU_RW : IOMMU_RO,
+
+    /* Allocate IOVA range and add the mapping to the IOVA tree */
     r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
     if (unlikely(r != IOVA_OK)) {
-        error_report("Cannot map injected element");
+        error_report("Cannot allocate IOVA range for injected element");
         return r;
     }
 
+    /* Add mapping to the IOVA->HVA tree */
+    map.translated_addr = (hwaddr)(uintptr_t)buf;
+    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
+    if (unlikely(r != IOVA_OK)) {
+        error_report("Cannot map injected element into IOVA->HVA tree");
+        goto dma_map_err;
+    }
+
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
                            vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
     if (unlikely(r < 0)) {
-- 
2.43.5


