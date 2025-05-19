Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3CAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0W8-0008N6-Lh; Mon, 19 May 2025 09:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH0W6-0008MZ-C9
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:26:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH0W2-0005wY-3A
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:26:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ih0k024919;
 Mon, 19 May 2025 13:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=rZWZLKEq
 Tec4UuJoGnIArQ09C23J5GFqgafLa0wX+v8=; b=a15kItsF0QiJnvY53DM9CqTa
 ytEh6dGJg16kCUMFVN2mg2EITt1Ce2s5brQHrLYMbZvfUNe0+H7v29FcWn/y/REw
 tcEH/zPTz7vUi/apw0voFQgkdB9bySF/pOv/DKOcaZXJA56x2A/iuH+73gSqlJDw
 VYbhPmqtqhlJGgfMbT7jhCgbYIVpNsfazMaX8f5XLb6J7WgIDFEWg68GmFiE2+WP
 bahmY5lddmdsE3OO4/N37EFqZpFLI/r4BC3sxlOWCTTktbVDvHyJP6v6tUil5ZQn
 Rwea8iNNQnBkOMsXIoPIqRrK0/L4FJL3YqFBDhV9MQEKm/xfoeDIXQLlAI3Gqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvejysx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 13:26:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JBk9lX000818; Mon, 19 May 2025 13:26:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6pyac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 13:26:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54JDQjOJ008846;
 Mon, 19 May 2025 13:26:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 46pgw6py9b-1; Mon, 19 May 2025 13:26:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
Date: Mon, 19 May 2025 06:26:43 -0700
Message-Id: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190124
X-Proofpoint-GUID: qmhD9-cJYRtwKD-WodeciNc7IzhTQpzo
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b3197 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=QNV_3Zso053vk46vt-IA:9
 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: qmhD9-cJYRtwKD-WodeciNc7IzhTQpzo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyNSBTYWx0ZWRfX27gcg0+IYvgF
 PEaFqvtbSJ8EAFvVrG4HpixGcmSMU0qA/xwhq6LNd6RI5MDDx3KcMavAh1XlpDumQKfhnWpqtdt
 PmMy87QiJFso0MOUTX2Fi2UZH9q085UrCIuG3V9L0inTbIvsYLT3MiGUvnhRZIXl+kRT+I/UHjY
 WHu4EE6ELhuRPITcxReQdnody9mU0on1nwmcZkk/Urdw40V0QNB+T/BjL+rxGxHconSCv3j8gWS
 m7t6oX/J6qWCutyAcwshP9dvlV1qTxPAScXFjryZfaiv2R9cB46d0GtFmIdX2Oc6ttU5N54rwqx
 1hGWFtMIDUAvWHmyJUk3SDnquj5JMgHao8WSwUFAz9RNgdVtLijnBVsqf8KVImJPMGBdTElyRfE
 f0szb3DTTMl0tfaHNbrVYyWKI0SpIZ4MeSJuapL2WVwN5Wyqoi6XujrDXQWvdIFYduyKGTLv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
---
 hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
 hw/virtio/vhost-vdpa.c  |  9 +++++++--
 include/system/memory.h | 19 +++++++++----------
 system/memory.c         | 32 +++++++-------------------------
 4 files changed, 45 insertions(+), 48 deletions(-)

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


