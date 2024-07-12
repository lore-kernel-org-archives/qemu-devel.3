Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D478C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkl-00066b-VE; Fri, 12 Jul 2024 07:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkd-0005aH-1I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEka-0007rX-Rw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BuLT021119;
 Fri, 12 Jul 2024 11:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=S
 6fQMnCtnXxuVyEmu+fxuqWG1QuQN9WhUDqA8cjsF7Q=; b=Voas6QlCJgzH0fQ4s
 EgkfxadAOxV7wuzUvUrjjj+yapdOUjfPgLEXkcTdrGl0QbeRjCRVKWuvAxZiCtsT
 CODu1QDpt6XeBHxnvirFVJuzfBuR0hz2SlNRlwXge2SiGbBIDm12RSVct5s4Si+2
 fETd8VkUB9C+YJaUSfZ8HipBw86fR5r0yR67fjyaxoLygCAKj5eDBgp8gfXT+zrj
 vpxXbOpn0nXqcCxhFzp5iZr1MWXLinWogqrOrCXQqbSFYLy0XlIfNvM7c0+1wuTy
 eXtJl9od0bArWy7WzIoDrj916/bQdP6pPhLkozynGRS22IzUFGZOuRyYRi7uFHkt
 YQdIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt30aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46C9ZjoU022757; Fri, 12 Jul 2024 11:47:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq9q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCm008041;
 Fri, 12 Jul 2024 11:47:39 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-11; Fri, 12 Jul 2024 11:47:39 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 10/12] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Date: Fri, 12 Jul 2024 12:47:02 +0100
Message-Id: <20240712114704.8708-11-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-GUID: HoAGbah5AF4iSuLiRbRZU7d-n64ClPPw
X-Proofpoint-ORIG-GUID: HoAGbah5AF4iSuLiRbRZU7d-n64ClPPw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
that fetches the bitmap that tells what was dirty in an IOVA
range.

A single bitmap is allocated and used across all the hwpts
sharing an IOAS which is then used in log_sync() to set Qemu
global bitmaps.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/iommufd.h |  4 ++++
 backends/iommufd.c       | 29 +++++++++++++++++++++++++++++
 hw/vfio/iommufd.c        | 27 +++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 4 files changed, 61 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 7416d9219703..869ca8b7ef59 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -57,6 +57,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                 Error **errp);
 bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                         bool start, Error **errp);
+bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                      uint64_t iova, ram_addr_t size,
+                                      uint64_t page_size, uint64_t *data,
+                                      Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 239f0976e0ad..46be719cae71 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -262,6 +262,35 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
     return true;
 }
 
+bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
+                                      uint32_t hwpt_id,
+                                      uint64_t iova, ram_addr_t size,
+                                      uint64_t page_size, uint64_t *data,
+                                      Error **errp)
+{
+    int ret;
+    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
+        .size = sizeof(get_dirty_bitmap),
+        .hwpt_id = hwpt_id,
+        .iova = iova,
+        .length = size,
+        .page_size = page_size,
+        .data = (uintptr_t)data,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
+    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
+                                           page_size, ret ? errno : 0);
+    if (ret) {
+        error_setg_errno(errp, errno,
+                         "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
+                         " size: 0x%"HWADDR_PRIx") failed", iova, size);
+        return false;
+    }
+
+    return true;
+}
+
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index da678315faeb..1fd1558fa0c0 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -146,6 +147,31 @@ err:
     return -EINVAL;
 }
 
+static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap, hwaddr iova,
+                                      hwaddr size, Error **errp)
+{
+    VFIOIOMMUFDContainer *container = container_of(bcontainer,
+                                                   VFIOIOMMUFDContainer,
+                                                   bcontainer);
+    unsigned long page_size = qemu_real_host_page_size();
+    VFIOIOASHwpt *hwpt;
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
+            continue;
+        }
+
+        if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
+                                              iova, size, page_size,
+                                              vbmap->bitmap, errp)) {
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
@@ -754,6 +780,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->detach_device = iommufd_cdev_detach;
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
     vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
 };
 
 static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
diff --git a/backends/trace-events b/backends/trace-events
index 28aca3b859d4..40811a316215 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -17,3 +17,4 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
+iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
-- 
2.17.2


