Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95386C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IY-0000cv-Di; Wed, 29 Jan 2025 09:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IP-0000ZJ-CC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IM-0001NV-GP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:01 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXjoE006534;
 Wed, 29 Jan 2025 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=bOvNzUBOzzP3JeyjYtLGjFNUTpKnuSslDX1WD5QbhjU=; b=
 BEKHaSTepz9F0cPVNDFPyHqMoLu2TZwhYQ5j9/X0qrzchffNG1Jf9WwTpRAV5jnz
 MUWFW4i6at3e++OiNX5ZjQDFagAzumxW15p4hmNlc2BRajXKWQ7Y5++zIquuBulV
 HNZ4bLa29WRONTN/DvWD3tQO5YUFY9qIanbgwm5DID27rDRWLvehVpW6So+Go+61
 FooSNXa4RMJWc+lUyBOmv6lRDx12y9E6KGlC6eDztJhDCN8OvLyT8No7+Z+V7WHj
 dlKer/wH6xdTTKFV/nktykcKgrfZ9wQ8hU9hoR7eTQ7W7gSv1VIlMZRM18HMbdNF
 w/ctKWzZh2o+5mA+YYq+dQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmf808u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDo8GN034292; Wed, 29 Jan 2025 14:43:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8q003307;
 Wed, 29 Jan 2025 14:43:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-20; Wed, 29 Jan 2025 14:43:54 +0000
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
Subject: [PATCH V1 19/26] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Date: Wed, 29 Jan 2025 06:43:15 -0800
Message-Id: <1738161802-172631-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-GUID: 3aPhxYnu15EnbVN3Y2BkcBFCZRCra4k3
X-Proofpoint-ORIG-GUID: 3aPhxYnu15EnbVN3Y2BkcBFCZRCra4k3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
Such a mapping can be preserved without modification during CPR,
because it depends on the file's address space, which does not change,
rather than on the process's address space, which does change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c                    | 36 +++++++++++++++++++++++++++++++++++
 backends/trace-events                 |  1 +
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/iommufd.c                     | 13 +++++++++++++
 include/exec/cpu-common.h             |  1 +
 include/hw/vfio/vfio-container-base.h |  3 +++
 include/system/iommufd.h              |  3 +++
 system/physmem.c                      |  5 +++++
 8 files changed, 71 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 7b4fc8e..6d29221 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -174,6 +174,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
     return ret;
 }
 
+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                                 hwaddr iova, ram_addr_t size,
+                                 int mfd, unsigned long start, bool readonly)
+{
+    int ret, fd = be->fd;
+    struct iommu_ioas_map_file map = {
+        .size = sizeof(map),
+        .flags = IOMMU_IOAS_MAP_READABLE |
+                 IOMMU_IOAS_MAP_FIXED_IOVA,
+        .ioas_id = ioas_id,
+        .fd = mfd,
+        .start = start,
+        .iova = iova,
+        .length = size,
+    };
+
+    if (!readonly) {
+        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
+    }
+
+    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
+    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
+                                       readonly, ret);
+    if (ret) {
+        ret = -errno;
+
+        /* TODO: Not support mapping hardware PCI BAR region for now. */
+        if (errno == EFAULT) {
+            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
+        } else {
+            error_report("IOMMU_IOAS_MAP_FILE failed: %m");
+        }
+    }
+    return ret;
+}
+
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 40811a3..f478e18 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d user
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
 iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
+iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d (%d)"
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 302cd4c..fbaf04a 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -21,7 +21,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            RAMBlock *rb)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
+    if (mfd >= 0 && vioc->dma_map_file) {
+        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
+        unsigned long offset = qemu_ram_get_fd_offset(rb);
+
+        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
+                           readonly);
+        return 0;
+    }
     g_assert(vioc->dma_map);
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 42ba63f..a3e7edb 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -38,6 +38,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
+static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 int fd, unsigned long start, bool readonly)
+{
+    const VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    return iommufd_backend_map_file_dma(container->be,
+                                        container->ioas_id,
+                                        iova, size, fd, start, readonly);
+}
+
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb)
@@ -806,6 +818,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
 
     vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b1d76d6..0cab252 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -95,6 +95,7 @@ void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
 void *qemu_ram_get_host_addr(RAMBlock *rb);
 ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index d82e256..4daa5f8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,6 +115,9 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+                        hwaddr iova, ram_addr_t size,
+                        int fd, unsigned long start, bool readonly);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb);
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75b..ac700b8 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
 bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                 Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                                 hwaddr iova, ram_addr_t size, int fd,
+                                 unsigned long start, bool readonly);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
diff --git a/system/physmem.c b/system/physmem.c
index 0bcfc6c..c41a80b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1569,6 +1569,11 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
     return rb->offset;
 }
 
+ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
+{
+    return rb->fd_offset;
+}
+
 ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
 {
     return rb->used_length;
-- 
1.8.3.1


