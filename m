Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BA4CFA773
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhg2-0004Wd-0e; Fri, 04 Oct 2024 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhg0-0004Vl-3T
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1swhfy-0005EU-9k
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:44:55 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CMZbO000873;
 Fri, 4 Oct 2024 12:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=x
 tR5OwVYJBoZ58v61LyRSYl31KA/FDiR+Fq3tzLMaJQ=; b=PMFf/lE0kQXkO8IxU
 LE2qjUT87PgfV50EUBug7cRpE/19FSRVqaGWjQtNzOhKGv1Ry9B2CshOjV1nPysn
 vBa4g38a0uB80y81WN4DTcFlxyR7G1nYEtF+LaSZKsQLQ8g0NpAn4fZfLBw30xum
 owm8sdUgwi8mfpSZuUK8Qa56cBK9vA3GX2R+WaEKke41aGxH0rRkRWb2w5VfitOW
 GODghon/qaNA7mYilM/xE9W7us90g8u3tjQZtj5B0bHrBI9Hwb18n1GUgiD9yF87
 8c/qpdYSBH7ocfb98q03E9IQdMVmQea7wAGRBOAHV5SWGhGxRHIx/ZHPmKp6GwFu
 X3HUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b1hnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 494BDCwF005916; Fri, 4 Oct 2024 12:44:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422056fcfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Oct 2024 12:44:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494Cimo4020535;
 Fri, 4 Oct 2024 12:44:49 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-167-128.vpn.oracle.com
 [10.65.167.128])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 422056fce8-2; Fri, 04 Oct 2024 12:44:49 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
Date: Fri,  4 Oct 2024 08:44:41 -0400
Message-ID: <20241004124445.3802090-2-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241004124445.3802090-1-jonah.palmer@oracle.com>
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040093
X-Proofpoint-ORIG-GUID: L0fH6H537sOoxBFpvsDQyAMpYkqJuyaZ
X-Proofpoint-GUID: L0fH6H537sOoxBFpvsDQyAMpYkqJuyaZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implements the IOVA->GPA tree for handling mapping, unmapping, and
translations for guest memory regions.

When the guest has overlapping memory regions, an HVA to IOVA translation
may return an incorrect IOVA when searching the IOVA->HVA tree. This is
due to one HVA range being contained (overlapping) in another HVA range
in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
translate and find the correct IOVA for guest memory regions.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
---
 hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++--
 hw/virtio/vhost-iova-tree.h |  5 +++
 hw/virtio/vhost-vdpa.c      | 20 ++++++----
 3 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index 3d03395a77..e33fd56225 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -28,12 +28,15 @@ struct VhostIOVATree {
 
     /* IOVA address to qemu memory maps. */
     IOVATree *iova_taddr_map;
+
+    /* IOVA address to guest memory maps. */
+    IOVATree *iova_gpa_map;
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
@@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
     tree->iova_last = iova_last;
 
     tree->iova_taddr_map = iova_tree_new();
+    tree->iova_gpa_map = iova_tree_new();
     return tree;
 }
 
@@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
 void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
 {
     iova_tree_destroy(iova_tree->iova_taddr_map);
+    iova_tree_destroy(iova_tree->iova_gpa_map);
     g_free(iova_tree);
 }
 
@@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
 }
 
 /**
- * Allocate a new mapping
+ * Allocate a new mapping in the IOVA->HVA tree
  *
  * @tree: The iova tree
  * @map: The iova map
@@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
 {
     iova_tree_remove(iova_tree->iova_taddr_map, map);
 }
+
+/**
+ * Find the IOVA address stored from a guest memory address
+ *
+ * @tree: The VhostIOVATree
+ * @map: The map with the guest memory address
+ *
+ * Return the stored mapping, or NULL if not found.
+ */
+const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree,
+                                            const DMAMap *map)
+{
+    return iova_tree_find_iova(tree->iova_gpa_map, map);
+}
+
+/**
+ * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
+ *
+ * @tree: The VhostIOVATree
+ * @map: The iova map
+ * @gpa: The guest physical address (GPA)
+ *
+ * Returns:
+ * - IOVA_OK if the map fits both containers
+ * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
+ * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
+ *
+ * It returns an assigned iova in map->iova if return value is IOVA_OK.
+ */
+int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwaddr gpa)
+{
+    int ret;
+
+    /* Some vhost devices don't like addr 0. Skip first page */
+    hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
+
+    if (map->translated_addr + map->size < map->translated_addr ||
+        map->perm == IOMMU_NONE) {
+        return IOVA_ERR_INVALID;
+    }
+
+    /* Allocate a node in the IOVA->HVA tree */
+    ret = iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
+                              tree->iova_last);
+    if (unlikely(ret != IOVA_OK)) {
+        return ret;
+    }
+
+    /* Insert a node in the IOVA->GPA tree */
+    map->translated_addr = gpa;
+    return iova_tree_insert(tree->iova_gpa_map, map);
+}
+
+/**
+ * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
+ *
+ * @iova_tree: The VhostIOVATree
+ * @map: The map to remove
+ */
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
+{
+    /* Remove the existing mapping from the IOVA->GPA tree */
+    iova_tree_remove(iova_tree->iova_gpa_map, map);
+
+    /* Remove the corresponding mapping from the IOVA->HVA tree */
+    iova_tree_remove(iova_tree->iova_taddr_map, map);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 4adfd79ff0..511c6d18ae 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
                                         const DMAMap *map);
 int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
 void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
+const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
+                                            const DMAMap *map);
+int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
+                                  hwaddr gpa);
+void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
 
 #endif
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..591ff426e7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
         mem_region.size = int128_get64(llsize) - 1,
         mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
 
-        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
+        r = vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region,
+                                          section->offset_within_address_space);
         if (unlikely(r != IOVA_OK)) {
             error_report("Can't allocate a mapping (%d)", r);
+
+            /* Insertion to IOVA->GPA tree failed */
+            if (mem_region.translated_addr ==
+                section->offset_within_address_space) {
+                goto fail_map;
+            }
             goto fail;
         }
 
@@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
 fail_map:
     if (s->shadow_data) {
-        vhost_iova_tree_remove(s->iova_tree, mem_region);
+        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
     }
 
 fail:
@@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
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
+        result = vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_region);
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
-- 
2.43.5


