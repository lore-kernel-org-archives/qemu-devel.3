Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14767C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKis0-0003yP-H7; Thu, 29 May 2025 15:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKiry-0003xF-8u
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirw-0000Be-0o
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfrXV021992;
 Thu, 29 May 2025 19:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ZlJDtYl6em+eHud3dfgoJDEfMZZf/cdWrkfuPElu6Kc=; b=
 IxC1cmaxZY5nWxa31f/T6h89oZsCx83cVku57rspsWe3iCiM2PxEvMGy6PNJAmwF
 +n6c43DsL3eHgTkA9fJTX1Q9VtLbrbRU/aX5gOzSkU2ttXbK/Lpcc8+iKUSp6nCc
 MCuDP3otxntLW3DWDpq+UytkqT4fhC2b0nSkXgfXIm5t1SswKGkXJwd/p+y9nwT0
 DA8BdtdNXcln9+p1JLOborH71I30mukLFaY4xFNsa1NmMaF+wR+wv4QdjTn1zwo+
 esW8XJxy2vIzYmh+XLo4khf/bs03Uh2+tLfNrOeSABJ+iX1/zCV/E7M2pC0qz9fb
 smu5ZtIzRm8ikaLa0tbxWQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12hu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJLPv5020301; Thu, 29 May 2025 19:24:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQp022158;
 Thu, 29 May 2025 19:24:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-3; Thu, 29 May 2025 19:24:42 +0000
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
Subject: [PATCH V4 02/43] vfio: return mr from vfio_get_xlat_addr
Date: Thu, 29 May 2025 12:23:58 -0700
Message-Id: <1748546679-154091-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: G45M86mq9-Pf4-0-RJihwdPPn2QhyW7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX+5x5i68W7oJN
 +OueFTa/urz0QvQoDQSnngXGBsKuIe5AMNi6AoKtAbsqR4oWHmAu15DEsG5Hv1lCQ0PqI7uX14M
 bZVpJ+QPPprOe7c/Wwoaa+CV477qYXDlIV85de4L49zIYJ5Q7kghf2NwpkW+UJjKxeAk/7jO3kH
 ZNJDASg2/nrIufAtb8OWLnk5YtZiZw895eQjaRbCffS36rsbtO84xY/51MNSTOir5TGGQm+4RZF
 en1IRNJtHAA7+hRROrj2A6KsO5QIudJ2USKjGeZABVmgyseXEAFs9h//QptnM+HPJfVJdTkPSd1
 d/MZ6/CV5Kb1IHKa1ZMQ+/QMcbcQwr4Za2FvCrBrip44uSrht7Hvl8XBim0NFTt3BIjaXVbN9Ex
 fNTg6OmpjRoap2tQTRmudYPhwzn3e24MGXsfr+kpXqFZ3RolY9EdwowdMfyFlGwtr6kQQRJf
X-Proofpoint-ORIG-GUID: G45M86mq9-Pf4-0-RJihwdPPn2QhyW7u
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b47b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=QNV_3Zso053vk46vt-IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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

Lastly, rename the functions to  to memory_translate_iotlb() and
vfio_translate_iotlb().

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/system/memory.h | 19 +++++++++----------
 hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
 hw/virtio/vhost-vdpa.c  |  9 +++++++--
 system/memory.c         | 32 +++++++-------------------------
 4 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf..13416d7 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -738,21 +738,20 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
 /**
- * memory_get_xlat_addr: Extract addresses from a TLB entry
+ * memory_translate_iotlb: Extract addresses from a TLB entry.
+ *                         Called with rcu_read_lock held.
  *
  * @iotlb: pointer to an #IOMMUTLBEntry
- * @vaddr: virtual address
- * @ram_addr: RAM address
- * @read_only: indicates if writes are allowed
- * @mr_has_discard_manager: indicates memory is controlled by a
- *                          RamDiscardManager
+ * @xlat_p: return the offset of the entry from the start of the returned
+ *          MemoryRegion.
  * @errp: pointer to Error*, to store an error if it happens.
  *
- * Return: true on success, else false setting @errp with error.
+ * Return: On success, return the MemoryRegion containing the @iotlb translated
+ *         addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
+ *         On failure, return NULL, setting @errp with error.
  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d..0afafe3 100644
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
+static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                          Error **errp)
 {
-    bool ret, mr_has_discard_manager;
+    MemoryRegion *mr;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
+    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
+    if (mr && memory_region_has_ram_discard_manager(mr)) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
          * pages will remain pinned inside vfio until unmapped, resulting in a
@@ -118,7 +119,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                          " intended via an IOMMU. It's possible to mitigate "
                          " by setting/adjusting RLIMIT_MEMLOCK.");
     }
-    return ret;
+    return mr;
 }
 
 static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mr;
+    hwaddr xlat;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,10 +153,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             goto out;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
@@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     ram_addr_t translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
+    MemoryRegion *mr;
+    ram_addr_t xlat;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
@@ -1021,9 +1030,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
+    if (!mr) {
         goto out_unlock;
     }
+    translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11..a1dd9e1 100644
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
@@ -228,11 +230,14 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
-                                  &local_err)) {
+        mr = memory_translate_iotlb(iotlb, &xlat, &local_err);
+        if (!mr) {
             error_report_err(local_err);
             return;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
diff --git a/system/memory.c b/system/memory.c
index 63b983e..306e9ff 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 }
 
 /* Called with rcu_read_lock held.  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
+                                     Error **errp)
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
@@ -2195,7 +2191,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                  &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
         error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
-        return false;
+        return NULL;
     } else if (memory_region_has_ram_discard_manager(mr)) {
         RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
         MemoryRegionSection tmp = {
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
@@ -2216,7 +2209,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
                          " via virtio-mem): %" HWADDR_PRIx "",
                          iotlb->translated_addr);
-            return false;
+            return NULL;
         }
     }
 
@@ -2226,22 +2219,11 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
      */
     if (len & iotlb->addr_mask) {
         error_setg(errp, "iommu has granularity incompatible with target AS");
-        return false;
+        return NULL;
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
-    return true;
+    *xlat_p = xlat;
+    return mr;
 }
 
 void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
-- 
1.8.3.1


