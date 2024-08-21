Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8029C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 12:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgksf-0003kN-7J; Wed, 21 Aug 2024 08:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksb-0003jA-7o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:56:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sgksW-0004yr-Nj
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 08:55:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtRLF031722;
 Wed, 21 Aug 2024 12:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=0
 LQEa7498TyMDmmIEdio1sXsd3gmjbCq4DuBSqWdik4=; b=fN4KuZTG+fDNU0fJh
 eWlOQ52N93QJlDe57EcSws/6VOzh1CQcUXssRtuLguQquwe5o7oJ4k85uNLYdbxG
 MI/s/f9Tzo3ZMZK5NIb6l5Um5NX5wrokRzeNymj/2ixMaeP60Pz/LVPAlcDxinmG
 7MPOuAyWkUjQf8zVODB4XeKK8ey5+VtOFeuPOP3wXg/i7uQGQvV0gjespfRieSYY
 wM57Rl6p0edYvpaNaMXHZbNMl+rtQym7yURZsVwMafLqn9QK6MP4QiUy3sWw/iVz
 pLP5Z2+yMsX4i3KA2fy39IRm/Gpm0JazSo4qJrxlOkmX6rpH+AZPQjRyX3FTOM9v
 y9whw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2dfgse-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47LBO408011438; Wed, 21 Aug 2024 12:55:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 415fb23m6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Aug 2024 12:55:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47LCtpoS002465;
 Wed, 21 Aug 2024 12:55:52 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-201-48.vpn.oracle.com
 [10.39.201.48])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 415fb23m55-3; Wed, 21 Aug 2024 12:55:52 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC 2/2] vhost-vdpa: Implement GPA->IOVA & IOVA->SVQ HVA trees
Date: Wed, 21 Aug 2024 08:55:46 -0400
Message-ID: <20240821125548.749143-3-jonah.palmer@oracle.com>
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
X-Proofpoint-GUID: KovVKa32aR9q6P1azJNfVGdSo7WwM3n-
X-Proofpoint-ORIG-GUID: KovVKa32aR9q6P1azJNfVGdSo7WwM3n-
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

Implements a GPA->IOVA and IOVA->SVQ HVA tree for handling mapping,
unmapping, and translations for guest and host-only memory,
respectively.

By splitting up a full IOVA->HVA tree (containing both guest and
host-only memory mappings) into a GPA->IOVA tree (containing only guest
memory mappings) and a IOVA->SVQ HVA tree (containing host-only memory
mappings), we can avoid translating to the wrong IOVA when the guest has
overlapping memory regions where different GPAs lead to the same HVA.

In other words, if the guest has overlapping memory regions, translating
an HVA to an IOVA may result in receiving an incorrect IOVA when
searching the full IOVA->HVA tree. This would be due to one HVA range
being contained (overlapping) in another HVA range in the IOVA->HVA
tree.

To avoid this issue, creating a GPA->IOVA tree and using it to translate
a GPA to an IOVA ensures that the IOVA we receive is the correct one
(instead of relying on a HVA->IOVA translation).

As a byproduct of creating a GPA->IOVA tree, the full IOVA->HVA tree now
becomes a partial IOVA->SVQ HVA tree. That is, since we're moving all
guest memory mappings to the GPA->IOVA tree, the host-only memory
mappings are now the only mappings being put into the IOVA->HVA tree.

Furthermore, as an additional byproduct of splitting up guest and
host-only memory mappings into separate trees, special attention needs
to be paid to vhost_svq_translate_addr() when translating memory buffers
from iovec. The memory buffers from iovec can be backed by guest memory
or host-only memory, which means that we need to figure out who is
backing these buffers and then decide which tree to use for translating
it.

In this patch we determine the backer of this buffer by first checking
if a RAM block can be inferred from the buffer's HVA. That is, we use
qemu_ram_block_from_host() and if a valid RAM block is returned, we know
the buffer's HVA is backed by guest memory. Then we derive the GPA from
it and translate the GPA to an IOVA using the GPA->IOVA tree.

If an invalid RAM block is returned, the buffer's HVA is likely backed
by host-only memory. In this case, we can then simply translate the HVA
to an IOVA using the partial IOVA->SVQ HVA tree.

However, this method is sub-optimal, especially for memory buffers
backed by host-only memory, due to needing to iterate over some (if not
all) RAMBlock structures and then searching either the GPA->IOVA tree or
the IOVA->SVQ HVA tree. Optimizations to improve performance in this
area should be revisited at some point.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c        | 53 +++++++++++++++++++++++++++++-
 hw/virtio/vhost-iova-tree.h        |  5 ++-
 hw/virtio/vhost-shadow-virtqueue.c | 48 +++++++++++++++++++++++----
 hw/virtio/vhost-vdpa.c             | 18 +++++-----
 include/qemu/iova-tree.h           | 22 +++++++++++++
 util/iova-tree.c                   | 46 ++++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 32c03db2f5..5a3f6b5cd9 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -26,15 +26,19 @@ struct VhostIOVATree {
     /* Last addressable iova address in the device */
     uint64_t iova_last;
 
-    /* IOVA address to qemu memory maps. */
+    /* IOVA address to qemu SVQ memory maps. */
     IOVATree *iova_taddr_map;
 
     /* IOVA tree (IOVA allocator) */
     IOVATree *iova_map;
+
+    /* GPA->IOVA tree */
+    IOVATree *gpa_map;
 };
 
 /**
  * Create a new VhostIOVATree with a new set of IOVATree's:
+ * - GPA->IOVA tree (gpa_map)
  * - IOVA allocator (iova_map)
  * - IOVA->HVA tree (iova_taddr_map)
  *
@@ -50,6 +54,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 
     tree->iova_taddr_map = iova_tree_new();
     tree->iova_map = iova_tree_new();
+    tree->gpa_map = gpa_tree_new();
     return tree;
 }
 
@@ -136,3 +141,49 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
 
     return iova_tree_insert(iova_tree->iova_taddr_map, map);
 }
+
+/**
+ * Insert a new GPA->IOVA mapping to the GPA->IOVA tree
+ *
+ * @iova_tree: The VhostIOVATree
+ * @map: The GPA->IOVA mapping
+ *
+ * Returns:
+ * - IOVA_OK if the map fits in the container
+ * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
+ * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
+ */
+int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
+{
+    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    return gpa_tree_insert(iova_tree->gpa_map, map);
+}
+
+/**
+ * Find the IOVA address stored from a guest memory address (GPA)
+ *
+ * @tree: The VhostIOVATree
+ * @map: The map with the guest memory address
+ *
+ * Return the stored mapping, or NULL if not found.
+ */
+const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *tree,
+                                       const DMAMap *map)
+{
+    return iova_tree_find_iova(tree->gpa_map, map);
+}
+
+/**
+ * Remove existing mappings from the GPA->IOVA tree and IOVA tree
+ *
+ * @iova_tree: The VhostIOVATree
+ * @map: The map to remove
+ */
+void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
+{
+    iova_tree_remove(iova_tree->gpa_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 8bf7b64786..c22941db4f 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -24,5 +24,8 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
 int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
 int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
-
+int vhost_gpa_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
+const DMAMap *vhost_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
+                                       const DMAMap *map);
+void vhost_gpa_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
 #endif
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index fc5f408f77..12eabddaa6 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
+#include "exec/ramblock.h"
 
 /**
  * Validate the transport device features that both guests can use with the SVQ
@@ -88,14 +89,45 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
     }
 
     for (size_t i = 0; i < num; ++i) {
-        DMAMap needle = {
-            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-            .size = iovec[i].iov_len,
-        };
-        Int128 needle_last, map_last;
-        size_t off;
+        RAMBlock *rb;
+        hwaddr gpa;
+        ram_addr_t offset;
+        const DMAMap *map;
+        DMAMap needle;
+
+        /*
+         * Determine if this HVA is backed by guest memory by attempting to
+         * infer a RAM block from it. If a valid RAM block is returned, the
+         * VA is backed by guest memory and we can derive the GPA from it.
+         * Then search the GPA->IOVA tree for the corresponding IOVA.
+         *
+         * If the RAM block is invalid, the HVA is likely backed by host-only
+         * memory. Use the HVA to search the IOVA->HVA tree for the
+         * corresponding IOVA.
+         *
+         * TODO: This additional second lookup is sub-optimal when the HVA
+         *       is backed by host-only memory. Find optimizations for this
+         *       (e.g. using an HVA->IOVA tree).
+         */
+        rb = qemu_ram_block_from_host(iovec[i].iov_base, false, &offset);
+        if (rb) {
+            gpa = rb->offset + offset;
+
+            /* Search the GPA->IOVA tree */
+            needle = (DMAMap) {
+                .translated_addr = gpa,
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_gpa_tree_find_iova(svq->iova_tree, &needle);
+        } else {
+            /* Search the IOVA->HVA tree */
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
@@ -106,6 +138,8 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
                           needle.translated_addr);
             return false;
         }
+        Int128 needle_last, map_last;
+        size_t off;
 
         off = needle.translated_addr - map->translated_addr;
         addrs[i] = map->iova + off;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 6702459065..0da0a117dc 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -373,9 +373,9 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
         iova = mem_region.iova;
 
-        /* Add mapping to the IOVA->HVA tree */
-        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
-        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
+        /* Add mapping to the GPA->IOVA tree */
+        mem_region.translated_addr = section->offset_within_address_space;
+        r = vhost_gpa_tree_insert(s->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't add listener region mapping (%d)", r);
             goto fail_map;
@@ -394,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
 fail_map:
     if (s->shadow_data) {
-        vhost_iova_tree_remove(s->iova_tree, mem_region);
+        vhost_gpa_tree_remove(s->iova_tree, mem_region);
     }
 
 fail:
@@ -448,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
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
+        /* Search the GPA->IOVA tree */
+        result = vhost_gpa_tree_find_iova(s->iova_tree, &mem_region);
         if (!result) {
             /* The memory listener map wasn't mapped */
             return;
         }
         iova = result->iova;
-        vhost_iova_tree_remove(s->iova_tree, *result);
+        vhost_gpa_tree_remove(s->iova_tree, *result);
     }
     vhost_vdpa_iotlb_batch_begin_once(s);
     /*
diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 2a10a7052e..57cfc63d33 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -40,6 +40,15 @@ typedef struct DMAMap {
 } QEMU_PACKED DMAMap;
 typedef gboolean (*iova_tree_iterator)(DMAMap *map);
 
+/**
+ * gpa_tree_new:
+ *
+ * Create a new GPA->IOVA tree.
+ *
+ * Returns: the tree pointer on success, or NULL otherwise.
+ */
+IOVATree *gpa_tree_new(void);
+
 /**
  * iova_tree_new:
  *
@@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map);
  */
 IOVATree *iova_tree_new(void);
 
+/**
+ * gpa_tree_insert:
+ *
+ * @tree: The GPA->IOVA tree we're inserting the mapping to
+ * @map: The GPA->IOVA mapping to insert
+ *
+ * Insert a GPA range to the GPA->IOVA tree. If there are overlapped
+ * ranges, IOVA_ERR_OVERLAP will be returned.
+ *
+ * Return: 0 if success, or < 0 if error.
+ */
+int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
+
 /**
  * iova_tree_insert:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 536789797e..e3f50fbf5c 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -71,6 +71,22 @@ static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
     return 0;
 }
 
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
 IOVATree *iova_tree_new(void)
 {
     IOVATree *iova_tree = g_new0(IOVATree, 1);
@@ -81,6 +97,15 @@ IOVATree *iova_tree_new(void)
     return iova_tree;
 }
 
+IOVATree *gpa_tree_new(void)
+{
+    IOVATree *gpa_tree = g_new0(IOVATree, 1);
+
+    gpa_tree->tree = g_tree_new_full(gpa_tree_compare, NULL, g_free, NULL);
+
+    return gpa_tree;
+}
+
 const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map)
 {
     return g_tree_lookup(tree->tree, map);
@@ -128,6 +153,27 @@ static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
     g_tree_insert(gtree, range, range);
 }
 
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
+
 int iova_tree_insert(IOVATree *tree, const DMAMap *map)
 {
     DMAMap *new;
-- 
2.43.5


