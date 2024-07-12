Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0ABC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGr2-0001Gc-7W; Fri, 12 Jul 2024 10:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqv-0000wR-KU
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqt-0005vk-Po
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:25 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILap014304;
 Fri, 12 Jul 2024 14:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=uprx7b42zMa86CF2fZVDrRfXE9oASXgLY0ct8yWJsOE=; b=
 RMFhAFae6duz1UKldOqsGkuO7PgVlsjUeQSj81BzgnjurmOigdbA994LU2z/v5QK
 cToVAf69MiokohKv3U5K/TizjmbmK+C3YgO1wX/yAIb/qkLsurxISwDvh7Hon410
 TTmXSNExZihafWiAy6qxFheb/CXQ6VCV7lhw3z+pRc/y6MVhz3Cq4Z8///O7+Jyb
 AVHpgX/wb7RbwAf9hK59DrYMDDoqwGvIex4Rl5FbhLvrqJPrOudXEsV7kYaTzogA
 1kZD64xF6DEn5ep5qF2mqoao++lH38Fi/Gc+1ZBqo0CURG23o7FK34S6rAn8+6vW
 8uI7ohE4qrAIXqo4QhGTJg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybv2ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CDNu4H010919; Fri, 12 Jul 2024 14:02:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DQ0020438;
 Fri, 12 Jul 2024 14:02:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-7; Fri, 12 Jul 2024 14:02:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 6/7] vdpa/cpr: pass shadow parameter to dma functions
Date: Fri, 12 Jul 2024 07:02:10 -0700
Message-Id: <1720792931-456433-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-GUID: DOAldhxAyZQzGSlr4M7dtTBq0BIqyCuI
X-Proofpoint-ORIG-GUID: DOAldhxAyZQzGSlr4M7dtTBq0BIqyCuI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass a parameter to the dma mapping functions that indicates if the
memory backs rings or buffers for svq's.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/virtio/vhost-vdpa.c         | 19 ++++++++++---------
 include/hw/virtio/vhost-vdpa.h |  4 ++--
 net/vhost-vdpa.c               |  5 +++--
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 9e3f414ac2..d9ebc396b7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -92,7 +92,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
  * This is not an ABI break since it is set to 0 by the initializer anyway.
  */
 int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
-                       hwaddr size, void *vaddr, bool readonly)
+                       hwaddr size, void *vaddr, bool readonly, bool shadow)
 {
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
@@ -124,7 +124,7 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
  * This is not an ABI break since it is set to 0 by the initializer anyway.
  */
 int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
-                         hwaddr size)
+                         hwaddr size, bool shadow)
 {
     struct vhost_msg_v2 msg = {};
     int fd = s->device_fd;
@@ -234,7 +234,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
             return;
         }
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                                 iotlb->addr_mask + 1, vaddr, read_only);
+                                 iotlb->addr_mask + 1, vaddr, read_only, false);
         if (ret) {
             error_report("vhost_vdpa_dma_map(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ", %p) = %d (%m)",
@@ -242,7 +242,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                                   iotlb->addr_mask + 1);
+                                   iotlb->addr_mask + 1, false);
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
                          "0x%" HWADDR_PRIx ") = %d (%m)",
@@ -376,7 +376,8 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
 
     vhost_vdpa_iotlb_batch_begin_once(s);
     ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                             int128_get64(llsize), vaddr, section->readonly);
+                             int128_get64(llsize), vaddr, section->readonly,
+                             false);
     if (ret) {
         error_report("vhost vdpa map fail!");
         goto fail_map;
@@ -463,7 +464,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     if (int128_eq(llsize, int128_2_64())) {
         llsize = int128_rshift(llsize, 1);
         ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                                   int128_get64(llsize));
+                                   int128_get64(llsize), false);
 
         if (ret) {
             error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
@@ -473,7 +474,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
         iova += int128_get64(llsize);
     }
     ret = vhost_vdpa_dma_unmap(s, VHOST_VDPA_GUEST_PA_ASID, iova,
-                               int128_get64(llsize));
+                               int128_get64(llsize), false);
 
     if (ret) {
         error_report("vhost_vdpa_dma_unmap(%p, 0x%" HWADDR_PRIx ", "
@@ -1116,7 +1117,7 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
 
     size = ROUND_UP(result->size, qemu_real_host_page_size());
     r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, result->iova,
-                             size);
+                             size, true);
     if (unlikely(r < 0)) {
         error_report("Unable to unmap SVQ vring: %s (%d)", g_strerror(-r), -r);
         return;
@@ -1159,7 +1160,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
                            needle->size + 1,
                            (void *)(uintptr_t)needle->translated_addr,
-                           needle->perm == IOMMU_RO);
+                           needle->perm == IOMMU_RO, true);
     if (unlikely(r != 0)) {
         error_setg_errno(errp, -r, "Cannot map region to device");
         vhost_iova_tree_remove(v->shared->iova_tree, *needle);
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 427458cfed..aac6ad439c 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -82,9 +82,9 @@ int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova_range);
 int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
 
 int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
-                       hwaddr size, void *vaddr, bool readonly);
+                       hwaddr size, void *vaddr, bool readonly, bool shadow);
 int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
-                         hwaddr size);
+                         hwaddr size, bool shadow);
 
 typedef struct vdpa_iommu {
     VhostVDPAShared *dev_shared;
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6010e8900..e3e861cfcc 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -499,7 +499,7 @@ static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
     }
 
     r = vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova,
-                             map->size + 1);
+                             map->size + 1, true);
     if (unlikely(r != 0)) {
         error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
     }
@@ -524,7 +524,8 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
     }
 
     r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
-                           vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
+                           vhost_vdpa_net_cvq_cmd_page_len(), buf, !write,
+                           true);
     if (unlikely(r < 0)) {
         goto dma_map_err;
     }
-- 
2.39.3


