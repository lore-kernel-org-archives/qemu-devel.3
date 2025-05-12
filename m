Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC409C3ABD7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVAD-0005ll-38; Mon, 12 May 2025 11:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9n-0004jq-VM
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9k-0006hg-52
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:31 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9wpl027445;
 Mon, 12 May 2025 15:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=15hJR2NU0oF7LoMnpaAHvXwJczWmb47bi3x16tmzxwI=; b=
 pcvGRcrv3d4zGV9cREIZUkRIrocsAxm40hVzOWSchd+OnIt/8lauJagGnEVv6Wvx
 B1cLkvWprtedVQnSnRhh4gQ2+dc7qBubl6PXBym+y/8mxblefPwTDcLw4Be9dFuX
 B4IjxNGGSExhUaNZXn5IpQY0M++dYUrvLXS/ZCKSo3CBQGrwtowvU4IMGhU3WqWc
 EkmEQRFYZKMu2g+7Ei0GZwM7cXf0ROeGqBi7Mdj/prcKDt5rdEwU0MsK8vvhx1oa
 gxT4CDLX+S3yYJIMiLGmX40JAEtzXBc1Nhbfp5U4L8DEgB+/GRdyT8xKImvV0f6x
 u0ZgRe/4rfirmzu4K/5YZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1662usk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE51tv002379; Mon, 12 May 2025 15:33:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5U030605;
 Mon, 12 May 2025 15:33:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-27; Mon, 12 May 2025 15:33:14 +0000
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
Subject: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
Date: Mon, 12 May 2025 08:32:37 -0700
Message-Id: <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX4kSZ/HQKOgh3
 t4HU8DdreURDh3uUv2zukxlZUGnZMN3MAF9Z96Uc0dt2VsJ4fu4rajFENPKi1xgMoh5LybCVCZ1
 w+lLoI1vDDjD5L6OQpxqZX6isVUS32hvIjQWZG2863t2rp1KYSLO4FzLGurcpMdvHx7Z42ud0Xa
 lhKS1RqEufYjhKimM3S1fYcTP51QY2ci/Bi0ImVgFsUPLpkvm60j+AmmGAppXxWN+M8NduRQ7xq
 vJeQahssEtNmFBLt9i1Im6VKytJ4/CDE4xIAHLQwJGvjcz4FinR+pYmpgsU3uq4l3cowfxc8xj9
 yRv2LmeZwYjq5X4PwnaZouP0t2KFiiG5WFiURNLwpuMAwgS3g/nNtIVMDMQfQpphLYKpo0eFSbh
 WYS8DRS1OS0K9Hji+Tv5ZnXJMQcN61vBYdUsJ7MnHUHv1/nLrdPHK6t9gPX9LhJVuV5aphYS
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682214bb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=LD-bTVk_YcQ43CFCkRcA:9
X-Proofpoint-ORIG-GUID: kLN_unYUxwymqxy2c2h5sq-Jci-wIt1v
X-Proofpoint-GUID: kLN_unYUxwymqxy2c2h5sq-Jci-wIt1v
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
region that the translated address is found in.  This will be needed by
CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.

Also return the xlat offset, so we can simplify the interface by removing
the out parameters that can be trivially derived from mr and xlat.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/listener.c      | 29 +++++++++++++++++++----------
 hw/virtio/vhost-vdpa.c  |  8 ++++++--
 include/system/memory.h | 16 +++++++---------
 system/memory.c         | 25 ++++---------------------
 4 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e86ffcf..87b7a3c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
            section->offset_within_address_space & (1ULL << 63);
 }
 
-/* Called with rcu_read_lock held.  */
-static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+/*
+ * Called with rcu_read_lock held.
+ * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
+ */
+static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                               hwaddr *xlat_p, Error **errp)
 {
-    bool ret, mr_has_discard_manager;
+    bool ret;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
+    ret = memory_get_xlat_addr(iotlb, mr_p, xlat_p, errp);
+    if (ret && memory_region_has_ram_discard_manager(*mr_p)) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
          * pages will remain pinned inside vfio until unmapped, resulting in a
@@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mr;
+    hwaddr xlat;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,10 +153,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
             error_report_err(local_err);
             goto out;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
@@ -1047,6 +1053,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     ram_addr_t translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
+    MemoryRegion *mr;
+    ram_addr_t xlat;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
@@ -1058,9 +1066,10 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
         goto out_unlock;
     }
+    translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11..f191360 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     int ret;
     Int128 llend;
     Error *local_err = NULL;
+    MemoryRegion *mr;
+    hwaddr xlat;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
-                                  &local_err)) {
+        if (!memory_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
             error_report_err(local_err);
             return;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf..d743214 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -738,21 +738,19 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
 /**
- * memory_get_xlat_addr: Extract addresses from a TLB entry
+ * memory_get_xlat_addr: Extract addresses from a TLB entry.
+ *                       Called with rcu_read_lock held.
  *
  * @iotlb: pointer to an #IOMMUTLBEntry
- * @vaddr: virtual address
- * @ram_addr: RAM address
- * @read_only: indicates if writes are allowed
- * @mr_has_discard_manager: indicates memory is controlled by a
- *                          RamDiscardManager
+ * @mr_p: return the MemoryRegion containing the @iotlb translated addr.
+ *        The MemoryRegion must not be accessed after rcu_read_unlock.
+ * @xlat_p: return the offset of the entry from the start of @mr_p
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                          hwaddr *xlat_p, Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/system/memory.c b/system/memory.c
index 63b983e..4894c0d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 }
 
 /* Called with rcu_read_lock held.  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                          hwaddr *xlat_p, Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
     hwaddr len = iotlb->addr_mask + 1;
     bool writable = iotlb->perm & IOMMU_WO;
 
-    if (mr_has_discard_manager) {
-        *mr_has_discard_manager = false;
-    }
     /*
      * The IOMMU TLB entry we have just covers translation through
      * this IOMMU to its immediate target.  We need to translate
@@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             .offset_within_region = xlat,
             .size = int128_make64(len),
         };
-        if (mr_has_discard_manager) {
-            *mr_has_discard_manager = true;
-        }
         /*
          * Malicious VMs can map memory into the IOMMU, which is expected
          * to remain discarded. vfio will pin all pages, populating memory.
@@ -2229,18 +2222,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         return false;
     }
 
-    if (vaddr) {
-        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    }
-
-    if (ram_addr) {
-        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
-    }
-
-    if (read_only) {
-        *read_only = !writable || mr->readonly;
-    }
-
+    *xlat_p = xlat;
+    *mr_p = mr;
     return true;
 }
 
-- 
1.8.3.1


