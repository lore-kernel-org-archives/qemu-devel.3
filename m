Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA12E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIVI-0006pm-0z; Fri, 10 Jan 2025 12:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVE-0006o6-Ro
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tWIVB-000566-2c
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:08:56 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AENiH2000912;
 Fri, 10 Jan 2025 17:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=u2w0X
 cT7jXVXLvlKloXcLIsEqkMBAS2U6ySLTjIsv9o=; b=HBbNreEOUd8PbabKVTfGp
 6HOiYFjuDkYMG3eUjVxJXj8Cwbq7yYSt2vE5W/JZXxo4it4jg+fjCeF4m2Iyp7pP
 JJV/WpXctx1zigHzlio5xC3nSJfIyMgEgPJxqbD6+QwG1BC1m61Ued67aLgkt6nm
 gbuvB1RXOoNR/hUNuuX/dNxpghAKSenKvGID2jVXT7ApNMwzlXSCFEtir7MMaCyJ
 fXH9m6EuEgYNbysTmfPrLWiJCipKJbTF+q+F+yVlJVeVOQYjxBEBN+IAUMMJKszQ
 J0782Y+dg7xw4EFK4feixrbhmhAtg5uVhXogoMQwjF00ryGB/ZHdrHTWqbUYLmSR
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xw1c3ag4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50AF9sQA004767; Fri, 10 Jan 2025 17:08:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xuecp0v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 17:08:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50AH1lkS031831;
 Fri, 10 Jan 2025 17:08:50 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-193-76.vpn.oracle.com
 [10.39.193.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 43xuecp0qc-4; Fri, 10 Jan 2025 17:08:49 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v3 3/5] vhost-vdpa: Implement the GPA->IOVA tree
Date: Fri, 10 Jan 2025 12:08:32 -0500
Message-ID: <20250110170837.2747532-4-jonah.palmer@oracle.com>
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
X-Proofpoint-ORIG-GUID: 4rXeMljEDY-bA6BHBoa4pyQlkt1rKmwm
X-Proofpoint-GUID: 4rXeMljEDY-bA6BHBoa4pyQlkt1rKmwm
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

Implements the GPA->IOVA tree for handling mapping and unmapping for
guest memory. This, alongside the SVQ IOVA->HVA tree & IOVA-only tree
implemented in the previous patches, allows us to handle guest and
host-only memory mapping operations separately via their own respective
trees.

The next patches will implement a method to determine if an incomming
address for translation is backed by guest or host-only memory.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c | 50 +++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-iova-tree.h |  4 +++
 hw/virtio/vhost-vdpa.c      | 22 ++++++++++------
 include/qemu/iova-tree.h    | 22 ++++++++++++++++
 util/iova-tree.c            | 46 ++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index f6a5694857..540bc35660 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -31,6 +31,9 @@ struct VhostIOVATree {
 
     /* Allocated IOVA addresses */
     IOVATree *iova_map;
+
+    /* GPA to IOVA address memory maps */
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
 
@@ -134,3 +139,48 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
 
     return iova_tree_insert(iova_tree->iova_taddr_map, map);
 }
+
+/** Insert a new GPA->IOVA mapping to the GPA->IOVA tree
+ *
+ * @iova_tree: The VhostIOVATree
+ * @map: The GPA->IOVA mapping
+ *
+ * Returns:
+ * - IOVA_OK if the map fits in the container
+ * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow)
+ * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
+ */
+int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map)
+{
+    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    return gpa_tree_insert(iova_tree->gpa_iova_map, map);
+}
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
+ * Remove existing mappings from the GPA->IOVA & IOVA trees
+ *
+ * @iova_tree: The VhostIOVATree
+ * @map: The guest memory address map to remove
+ */
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
+{
+    iova_tree_remove(iova_tree->gpa_iova_map, map);
+    iova_tree_remove(iova_tree->iova_map, map);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 8bf7b64786..3e3dcd04fe 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -24,5 +24,9 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
 int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
 int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
+int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map);
+const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
+                                       const DMAMap *map);
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
 
 #endif
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index f5803f35f4..8587f3f6c8 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
     if (s->shadow_data) {
         int r;
 
-        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
+        /* Allocate an IOVA range in the IOVA tree */
         r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
@@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         }
 
         iova = mem_region.iova;
+        mem_region.translated_addr = section->offset_within_address_space;
+
+        /* Add GPA->IOVA mapping to the GPA->IOVA tree */
+        r = vhost_iova_tree_insert_gpa(s->iova_tree, &mem_region);
+        if (unlikely(r != IOVA_OK)) {
+            error_report("Can't add listener region mapping (%d)", r);
+            goto fail_map;
+        }
     }
 
     vhost_vdpa_iotlb_batch_begin_once(s);
@@ -386,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
 fail_map:
     if (s->shadow_data) {
-        vhost_iova_tree_remove(s->iova_tree, mem_region);
+        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
     }
 
 fail:
@@ -440,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
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
index 44a45931d5..8467912a0b 100644
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
+ * Inserts a GPA range to the GPA->IOVA tree. If there are overlapped
+ * ranges, IOVA_ERR_OVERLAP will be returned.
+ *
+ * Return: 0 if successful, < 0 otherwise.
+ */
+int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
+
 /**
  * iova_tree_insert:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 06295e2755..f45e63c3de 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -55,6 +55,22 @@ static void iova_tree_alloc_args_iterate(struct IOVATreeAllocArgs *args,
     args->this = next;
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
 static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
 {
     const DMAMap *m1 = a, *m2 = b;
@@ -71,6 +87,15 @@ static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
     return 0;
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
 IOVATree *iova_tree_new(void)
 {
     IOVATree *iova_tree = g_new0(IOVATree, 1);
@@ -121,6 +146,27 @@ static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
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
+    if (iova_tree_find(tree,map)) {
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


