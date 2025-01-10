Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A835E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIVG-0006oe-7k; Fri, 10 Jan 2025 12:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVD-0006ng-5a
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVB-00055w-2O
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:54 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENhuW007304;
 Fri, 10 Jan 2025 17:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=jJG0c
 axPU8cnGnsYt8aHP7FSNtVuznZpAH0g/XMGUW4=; b=fWcCgGoVYDbV7240DXezM
 eaOwI7NqrCxI5WRF4AQ/rG6Ql8DfHNiLrFfw1ya6yTHVM2TFnRtKdcE4RJGTSlI4
 KHg4lTS2BtqD1Tb9TAiIzN30ik4hGKMdUG1L+cejFwBP5lJ27Qnpwp/XSa6LgQuE
 31PBSSxfjzkQqG8tjR/oHcK9X0kRqDGtYXh/Kuqqu93phKnf4rXXSyWbOqDNb3Y/
 sQfBlpC+v0oF+tFt7FNzlgdhpUWnjzVX2KMsKcXa1EwWZ0cQflDD6WsxIqChXY/Y
 QRmN1DzL9mmPLqD0KYQ8lWg3622ayvbZDL1HHzchSvsfN7ynz3uMy8+pV0AeqGqP
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4427jpk83w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AGHCDp005499; Fri, 10 Jan 2025 17:08:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecp0tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50AH1lkO031831;
 Fri, 10 Jan 2025 17:08:46 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-193-76.vpn.oracle.com
 [10.39.193.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xuecp0qc-2; Fri, 10 Jan 2025 17:08:46 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 1/5] vhost-vdpa: Decouple the IOVA allocator
Date: Fri, 10 Jan 2025 12:08:30 -0500
Message-ID: <20250110170837.2747532-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250110170837.2747532-1-jonah.palmer@oracle.com>
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_07,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100134
X-Proofpoint-ORIG-GUID: 6bsGfwwxvc6R7a_LdCUx62cnRgqCihBc
X-Proofpoint-GUID: 6bsGfwwxvc6R7a_LdCUx62cnRgqCihBc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.369,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Decouples the IOVA allocator from the full IOVA->HVA tree to support a
SVQ IOVA->HVA tree for host-only memory mappings.

The IOVA allocator still allocates an IOVA range but instead adds this
range to an IOVA-only tree (iova_map) that keeps track of allocated IOVA
ranges for both guest & host-only memory mappings.

A new API function vhost_iova_tree_insert() is also created for adding
IOVA->HVA mappings into the SVQ IOVA->HVA tree, since the allocator is
no longer doing that.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c | 35 +++++++++++++++++++++++++++++++----
 hw/virtio/vhost-iova-tree.h |  1 +
 hw/virtio/vhost-vdpa.c      | 21 ++++++++++++++++-----
 net/vhost-vdpa.c            | 13 +++++++++++--
 4 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 3d03395a77..b1cfd17843 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -28,12 +28,15 @@ struct VhostIOVATree {
 
     /* IOVA address to qemu memory maps. */
     IOVATree *iova_taddr_map;
+
+    /* Allocated IOVA addresses */
+    IOVATree *iova_map;
 };
 
 /**
- * Create a new IOVA tree
+ * Create a new VhostIOVATree
  *
- * Returns the new IOVA tree
+ * Returns the new VhostIOVATree
  */
 VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 {
@@ -44,15 +47,17 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
     tree->iova_last = iova_last;
 
     tree->iova_taddr_map = iova_tree_new();
+    tree->iova_map = iova_tree_new();
     return tree;
 }
 
 /**
- * Delete an iova tree
+ * Delete a VhostIOVATree
  */
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
+    iova_tree_destroy(iova_tree->iova_map);
     g_free(iova_tree);
 }
 
@@ -94,7 +99,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
     }
 
     /* Allocate a node in IOVA address */
-    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
+    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
                                tree->iova_last);
 }
 
@@ -107,4 +112,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
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
+ * @map: The IOVA->HVA mapping
+ *
+ * Returns:
+ * - IOVA_OK if the map fits in the container
+ * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow)
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
index 3cdaa12ed5..f5803f35f4 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1142,18 +1142,29 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
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
 
+    /* Allocate an IOVA range in the IOVA tree */
     r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
     if (unlikely(r != IOVA_OK)) {
         error_setg(errp, "Cannot allocate iova (%d)", r);
         return false;
     }
+    needle->translated_addr = taddr;
+
+    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
+    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
+    if (unlikely(r != IOVA_OK)) {
+        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
+        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
+        return false;
+    }
 
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
                            needle->size + 1,
@@ -1192,11 +1203,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
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
@@ -1206,11 +1217,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
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
index 231b45246c..1ef555e04e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -512,14 +512,23 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
     DMAMap map = {};
     int r;
 
-    map.translated_addr = (hwaddr)(uintptr_t)buf;
     map.size = size - 1;
     map.perm = write ? IOMMU_RW : IOMMU_RO,
+
+    /* Allocate an IOVA range in the IOVA tree */
     r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
     if (unlikely(r != IOVA_OK)) {
-        error_report("Cannot map injected element");
+        error_report("Cannot allocate IOVA range for injected element");
         return r;
     }
+    map.translated_addr = (hwaddr)(uintptr_t)buf;
+
+    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
+    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
+    if (unlikely(r != IOVA_OK)) {
+        error_report("Cannot map injected element into IOVA->HVA tree");
+        goto dma_map_err;
+    }
 
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
                            vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
-- 
2.43.5


