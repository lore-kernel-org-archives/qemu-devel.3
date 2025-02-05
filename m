Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71992C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgrE-0007Zl-3A; Wed, 05 Feb 2025 09:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgrC-0007ZY-PG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tfgr9-0008U3-LG
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:58:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DSWlD023797;
 Wed, 5 Feb 2025 14:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=ucpG2
 p9hvTqQOAU0sxZffSPLFwOEgIzh9mLgyUv4r5w=; b=UfqVBabW2g3M2AcNf4Gwc
 Wlk8uLHjPhGesrPuw9Yvc/ya2OQlFtrlsIekP3/wJVyhH9l2TqozN+/lfLg1heeT
 NCxLW12yHNw2UIcXnxhTy1jEL0RlwOzATMYwZrrBfJM36X65nskFiZkWhDVCFvZR
 BVNHXVNrElJqUc3G6cOHREb+WUPydXUkvVG/ixbgRt4YElTfb7356jR7y/kBkVvV
 xhOdfgqUnxPNxh8wI15lgNhC3uXzy+Xp3aATsen2NU4f3JUqXzMkkWbTzrIkVjKr
 BfbHsvaH+Ka7Jg0u+S9PWqOoUhLtDUMfMAxHew35QT3mKrY9ZSFN0pdp5OYYNCKS
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44m50u8myw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515Efg92022498; Wed, 5 Feb 2025 14:58:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e96bfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 14:58:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 515EwGhB022923;
 Wed, 5 Feb 2025 14:58:19 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-182-246.vpn.oracle.com
 [10.65.182.246])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44j8e96bbx-3; Wed, 05 Feb 2025 14:58:19 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH 2/4] vhost-iova-tree: Implement GPA->IOVA & partial IOVA->HVA
 trees
Date: Wed,  5 Feb 2025 09:58:08 -0500
Message-ID: <20250205145813.394915-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250205145813.394915-1-jonah.palmer@oracle.com>
References: <20250205145813.394915-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502050117
X-Proofpoint-GUID: Yw9UmM6qvbHkQDgy3DxUX7QTrY8lQ2zo
X-Proofpoint-ORIG-GUID: Yw9UmM6qvbHkQDgy3DxUX7QTrY8lQ2zo
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Creates and supports a GPA->IOVA tree and a partial IOVA->HVA tree by
splitting up guest-backed memory maps and host-only memory maps from the
full IOVA->HVA tree. That is, any guest-backed memory maps are now
stored in the GPA->IOVA tree and host-only memory maps stay in the
IOVA->HVA tree.

The qemu_ram_block_from_host() function in vhost_svq_translate_addr() is
used to determine if the HVA (from the iovec) is backed by guest memory
by attempting to infer a RAM block from it. If a valid RAMBlock is
returned, we derive the GPA from it and search the GPA->IOVA tree for
the corresponding IOVA. If an invalid RAMBlock is returned, the HVA is
used to search the IOVA->HVA tree for the corresponding IOVA.

This method of determining if an HVA is backed by guest memory is far
from optimal, especially for memory buffers backed by host-only memory.
In the next patch, this method will be improved by utilizing the in_addr
and out_addr members of a VirtQueueElement to determine if an incoming
address for translation is backed by guest or host-only memory.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c        | 67 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-iova-tree.h        |  5 +++
 hw/virtio/vhost-shadow-virtqueue.c | 28 ++++++++++---
 hw/virtio/vhost-vdpa.c             | 19 ++++-----
 include/qemu/iova-tree.h           | 22 ++++++++++
 util/iova-tree.c                   | 46 ++++++++++++++++++++
 6 files changed, 171 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 216885aa3c..9d2d6a7af2 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -31,6 +31,9 @@ struct VhostIOVATree {
 
     /* Allocated IOVA addresses */
     IOVATree *iova_map;
+
+    /* GPA->IOVA address memory maps */
+    IOVATree *gpa_iova_map;
 };
 
 /**
@@ -48,6 +51,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 
     tree->iova_taddr_map = iova_tree_new();
     tree->iova_map = iova_tree_new();
+    tree->gpa_iova_map = gpa_tree_new();
     return tree;
 }
 
@@ -58,6 +62,7 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
     iova_tree_destroy(iova_tree->iova_map);
+    iova_tree_destroy(iova_tree->gpa_iova_map);
     g_free(iova_tree);
 }
 
@@ -122,3 +127,65 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
     iova_tree_remove(iova_tree->iova_taddr_map, map);
     iova_tree_remove(iova_tree->iova_map, map);
 }
+
+/**
+ * Find the IOVA address stored from a guest memory address (GPA)
+ *
+ * @tree: The VhostIOVATree
+ * @map: The map with the guest memory address
+ *
+ * Returns the stored GPA->IOVA mapping, or NULL if not found.
+ */
+const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *tree,
+                                       const DMAMap *map)
+{
+    return iova_tree_find_iova(tree->gpa_iova_map, map);
+}
+
+/**
+ * Allocate a new IOVA range and add the mapping to the GPA->IOVA tree
+ *
+ * @tree: The VhostIOVATree
+ * @map: The IOVA mapping
+ * @taddr: The translated address (GPA)
+ *
+ * Returns:
+ * - IOVA_OK if the map fits both containers
+ * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
+ * - IOVA_ERR_NOMEM if the IOVA-only tree cannot allocate more space
+ *
+ * It returns an assigned IOVA in map->iova if the return value is IOVA_OK.
+ */
+int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwaddr taddr)
+{
+    int ret;
+
+    /* Some vhost devices don't like addr 0. Skip first page */
+    hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
+
+    if (taddr + map->size < taddr || map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    /* Allocate a node in the IOVA-only tree */
+    ret = iova_tree_alloc_map(tree->iova_map, map, iova_first, tree->iova_last);
+    if (unlikely(ret != IOVA_OK)) {
+        return ret;
+    }
+
+    /* Insert a node in the GPA->IOVA tree */
+    map->translated_addr = taddr;
+    return gpa_tree_insert(tree->gpa_iova_map, map);
+}
+
+/**
+ * Remove existing mappings from the IOVA-only and GPA->IOVA trees
+ *
+ * @tree: The VhostIOVATree
+ * @map: The map to remove
+ */
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
+{
+    iova_tree_remove(iova_tree->gpa_iova_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 525ce72b1d..0c4ba5abd5 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -24,5 +24,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
 int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map,
                               hwaddr taddr);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
+const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
+                                       const DMAMap *map);
+int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
+                                  hwaddr taddr);
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
 
 #endif
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 37aca8b431..a53492fd36 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
+#include "exec/ramblock.h"
 
 /**
  * Validate the transport device features that both guests can use with the SVQ
@@ -88,14 +89,31 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
     }
 
     for (size_t i = 0; i < num; ++i) {
-        DMAMap needle = {
-            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-            .size = iovec[i].iov_len,
-        };
         Int128 needle_last, map_last;
         size_t off;
+        RAMBlock *rb;
+        hwaddr gpa;
+        ram_addr_t offset;
+        const DMAMap *map;
+        DMAMap needle;
+
+        rb = qemu_ram_block_from_host(iovec[i].iov_base, false, &offset);
+        if (rb) {
+            gpa = rb->offset + offset;
+
+            needle = (DMAMap) {
+                .translated_addr = gpa,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
+        } else {
+            needle = (DMAMap) {
+                .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
+        }
 
-        const DMAMap *map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         /*
          * Map cannot be NULL since iova map contains all guest space and
          * qemu already has a physical address mapped
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 703dcfc929..7efbde3d4c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -360,17 +360,17 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     llsize = int128_sub(llend, int128_make64(iova));
     if (s->shadow_data) {
         int r;
-        hwaddr hw_vaddr = (hwaddr)(uintptr_t)vaddr;
+        hwaddr gpa = section->offset_within_address_space;
 
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region, hw_vaddr);
+        r = vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region, gpa);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
 
-            if (mem_region.translated_addr == hw_vaddr) {
-                error_report("Insertion to IOVA->HVA tree failed");
+            if (mem_region.translated_addr == gpa) {
+                error_report("Insertion to GPA->IOVA tree failed");
                 /* Remove the mapping from the IOVA-only tree */
                 goto fail_map;
             }
@@ -392,7 +392,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
 fail_map:
     if (s->shadow_data) {
-        vhost_iova_tree_remove(s->iova_tree, mem_region);
+        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
     }
 
 fail:
@@ -446,21 +446,18 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     if (s->shadow_data) {
         const DMAMap *result;
-        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
-            section->offset_within_region +
-            (iova - section->offset_within_address_space);
         DMAMap mem_region = {
-            .translated_addr = (hwaddr)(uintptr_t)vaddr,
+            .translated_addr = section->offset_within_address_space,
             .size = int128_get64(llsize) - 1,
         };
 
-        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
+        result = vhost_iova_tree_find_gpa(s->iova_tree, &mem_region);
         if (!result) {
             /* The memory listener map wasn't mapped */
             return;
         }
         iova = result->iova;
-        vhost_iova_tree_remove(s->iova_tree, *result);
+        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
     }
     vhost_vdpa_iotlb_batch_begin_once(s);
     /*
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 44a45931d5..16d354a814 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -40,6 +40,28 @@ typedef struct DMAMap {
 } QEMU_PACKED DMAMap;
 typedef gboolean (*iova_tree_iterator)(DMAMap *map);
 
+/**
+ * gpa_tree_new:
+ *
+ * Create a new GPA->IOVA tree.
+ *
+ * Returns: the tree point on success, or NULL otherwise.
+ */
+IOVATree *gpa_tree_new(void);
+
+/**
+ * gpa_tree_insert:
+ *
+ * @tree: The GPA->IOVA tree we're inserting the mapping to
+ * @map: The GPA->IOVA mapping to insert
+ *
+ * Inserts a GPA range to the GPA->IOVA tree. If there are overlapped
+ * ranges, IOVA_ERR_OVERLAP will be returned.
+ *
+ * Return: 0 if successful, < 0 otherwise.
+ */
+int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
+
 /**
  * iova_tree_new:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 06295e2755..5b0c95ff15 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -257,3 +257,49 @@ void iova_tree_destroy(IOVATree *tree)
     g_tree_destroy(tree->tree);
     g_free(tree);
 }
+
+static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
+{
+    const DMAMap *m1 = a, *m2 = b;
+
+    if (m1->translated_addr > m2->translated_addr + m2->size) {
+        return 1;
+    }
+
+    if (m1->translated_addr + m1->size < m2->translated_addr) {
+        return -1;
+    }
+
+    /* Overlapped */
+    return 0;
+}
+
+IOVATree *gpa_tree_new(void)
+{
+    IOVATree *gpa_tree = g_new0(IOVATree, 1);
+
+    gpa_tree->tree = g_tree_new_full(gpa_tree_compare, NULL, g_free, NULL);
+
+    return gpa_tree;
+}
+
+int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
+{
+    DMAMap *new;
+
+    if (map->translated_addr + map->size < map->translated_addr ||
+        map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    /* We don't allow inserting ranges that overlap with existing ones */
+    if (iova_tree_find(tree, map)) {
+        return IOVA_ERR_OVERLAP;
+    }
+
+    new = g_new0(DMAMap, 1);
+    memcpy(new, map, sizeof(*new));
+    iova_tree_insert_internal(tree->tree, new);
+
+    return IOVA_OK;
+}
-- 
2.43.5


