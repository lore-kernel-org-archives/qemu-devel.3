Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D90C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2RU-0005i1-Vk; Mon, 17 Feb 2025 09:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RU-0005hl-1s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1tk2RP-0005Ev-OY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:49:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HEMYmm023149;
 Mon, 17 Feb 2025 14:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Fty/aPVQz0O7yPYDI6V0DImoAmHMCM2vyzvaxLDayt4=; b=
 PkdT88YNcW207/p1Tx775Ekj+YHba0Zjy1/o6aooh5bAKjxAFZdisJmwZBLF75Rz
 5NHMvwSB35yIWDs1EvgPovPFGwzy8xWwuCvnOqercWO8NVp45UOigrt3CqgEpmCv
 23tLp9fIrKPEwL7ClXvn1E4nnz2E2fwpUhqEzJ3+fyQEttXKqLt9tbbCYWJJ+rFh
 HSii/r4cwGVtpuL2hKVXW+voMPClp77pLAY+pozWmYYwRgFZ2Rg8rI6S52sfxBIk
 TWUkfo8b4hc/y7RGU1Xy7jM8UrFmAbiddMU56BuuyWCLD62vopWjP2Xxq4yDhil9
 5YLidvSLUCY9HZWQAhnc5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tjhscfwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51HD61XD024829; Mon, 17 Feb 2025 14:49:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44thc80386-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 14:49:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51HEndFc020797;
 Mon, 17 Feb 2025 14:49:45 GMT
Received: from jonah-ol8.us.oracle.com
 (dhcp-10-43-68-193.usdhcp.oraclecorp.com [10.43.68.193])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 44thc8033q-3; Mon, 17 Feb 2025 14:49:44 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: eperezma@redhat.com, mst@redhat.com, leiyang@redhat.com, peterx@redhat.com,
 dtatulea@nvidia.com, jasowang@redhat.com, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com, jonah.palmer@oracle.com
Subject: [PATCH v2 2/3] vhost-iova-tree,
 svq: Implement GPA->IOVA & partial IOVA->HVA trees
Date: Mon, 17 Feb 2025 09:49:33 -0500
Message-ID: <20250217144936.3589907-3-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250217144936.3589907-1-jonah.palmer@oracle.com>
References: <20250217144936.3589907-1-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502170125
X-Proofpoint-GUID: Kq4rpJP-uBgrDvB2c_jKpHhoEZRa1exr
X-Proofpoint-ORIG-GUID: Kq4rpJP-uBgrDvB2c_jKpHhoEZRa1exr
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

Also propagates the GPAs (in_addr/out_addr) of a VirtQueueElement to
vhost_svq_translate_addr() to translate GPAs to IOVAs via the GPA->IOVA
tree (when descriptors are backed by guest memory). For descriptors
backed by host-only memory, the existing partial SVQ IOVA->HVA tree is
used.

GPAs are unique in the guest's address space, ensuring unambiguous IOVA
translations. This avoids the issue where different GPAs map to the same
HVA, causing the original HVA->IOVA translation to potentially return an
IOVA associated with the wrong intended GPA.

Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-iova-tree.c        | 67 ++++++++++++++++++++++++++++++
 hw/virtio/vhost-iova-tree.h        |  5 +++
 hw/virtio/vhost-shadow-virtqueue.c | 55 ++++++++++++++++--------
 hw/virtio/vhost-shadow-virtqueue.h |  5 ++-
 hw/virtio/vhost-vdpa.c             | 19 ++++-----
 include/qemu/iova-tree.h           | 22 ++++++++++
 net/vhost-vdpa.c                   |  2 +-
 util/iova-tree.c                   | 46 ++++++++++++++++++++
 8 files changed, 190 insertions(+), 31 deletions(-)

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
index 37aca8b431..30ba565f03 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -78,24 +78,39 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
  * @vaddr: Translated IOVA addresses
  * @iovec: Source qemu's VA addresses
  * @num: Length of iovec and minimum length of vaddr
+ * @gpas: Descriptors' GPAs, if backed by guest memory
  */
 static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
                                      hwaddr *addrs, const struct iovec *iovec,
-                                     size_t num)
+                                     size_t num, const hwaddr *gpas)
 {
     if (num == 0) {
         return true;
     }
 
     for (size_t i = 0; i < num; ++i) {
-        DMAMap needle = {
-            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-            .size = iovec[i].iov_len,
-        };
         Int128 needle_last, map_last;
         size_t off;
+        const DMAMap *map;
+        DMAMap needle;
+
+        /* Check if the descriptor is backed by guest memory  */
+        if (gpas) {
+            /* Search the GPA->IOVA tree */
+            needle = (DMAMap) {
+                .translated_addr = gpas[i],
+                .size = iovec[i].iov_len,
+            };
+            map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
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
@@ -130,6 +145,7 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  * @sg: Cache for hwaddr
  * @iovec: The iovec from the guest
  * @num: iovec length
+ * @addr: Descriptors' GPAs, if backed by guest memory
  * @more_descs: True if more descriptors come in the chain
  * @write: True if they are writeable descriptors
  *
@@ -137,7 +153,8 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
  */
 static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
                                         const struct iovec *iovec, size_t num,
-                                        bool more_descs, bool write)
+                                        const hwaddr *addr, bool more_descs,
+                                        bool write)
 {
     uint16_t i = svq->free_head, last = svq->free_head;
     unsigned n;
@@ -149,7 +166,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         return true;
     }
 
-    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
     if (unlikely(!ok)) {
         return false;
     }
@@ -174,8 +191,9 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
 
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
+                                const hwaddr *out_addr,
                                 const struct iovec *in_sg, size_t in_num,
-                                unsigned *head)
+                                const hwaddr *in_addr, unsigned *head)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
@@ -191,13 +209,14 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
-                                     false);
+    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                     in_num > 0, false);
     if (unlikely(!ok)) {
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
+    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
+                                     true);
     if (unlikely(!ok)) {
         return false;
     }
@@ -247,8 +266,9 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
  * Return -EINVAL if element is invalid, -ENOSPC if dev queue is full
  */
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
-                  size_t out_num, const struct iovec *in_sg, size_t in_num,
-                  VirtQueueElement *elem)
+                  size_t out_num, const hwaddr *out_addr,
+                  const struct iovec *in_sg, size_t in_num,
+                  const hwaddr *in_addr, VirtQueueElement *elem)
 {
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
@@ -258,7 +278,8 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -ENOSPC;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
+    ok = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
+                             in_addr, &qemu_head);
     if (unlikely(!ok)) {
         return -EINVAL;
     }
@@ -274,8 +295,8 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
 static int vhost_svq_add_element(VhostShadowVirtqueue *svq,
                                  VirtQueueElement *elem)
 {
-    return vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->in_sg,
-                         elem->in_num, elem);
+    return vhost_svq_add(svq, elem->out_sg, elem->out_num, elem->out_addr,
+                         elem->in_sg, elem->in_num, elem->in_addr, elem);
 }
 
 /**
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 19c842a15b..9c273739d6 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -118,8 +118,9 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
-                  size_t out_num, const struct iovec *in_sg, size_t in_num,
-                  VirtQueueElement *elem);
+                  size_t out_num, const hwaddr *out_addr,
+                  const struct iovec *in_sg, size_t in_num,
+                  const hwaddr *in_addr, VirtQueueElement *elem);
 size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
 
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
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
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5a3a57203d..bd01866878 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -649,7 +649,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
     VhostShadowVirtqueue *svq = g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
     int r;
 
-    r = vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
+    r = vhost_svq_add(svq, out_sg, out_num, NULL, in_sg, in_num, NULL, NULL);
     if (unlikely(r != 0)) {
         if (unlikely(r == -ENOSPC)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device queue\n",
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


