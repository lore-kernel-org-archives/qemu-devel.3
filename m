Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7961C3DA47
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpSD-00055H-Qk; Mon, 08 Jul 2024 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS7-0004cM-Ea
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS3-0002X1-EY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTfM004389;
 Mon, 8 Jul 2024 14:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=f
 1bRBqPzVSgljRFlFIl90pFkjgfs7i2Bi3J1zvMFLCg=; b=lEFRsp+/+9oito433
 N9j0RZEGkR2bR8WA/JC4tVA9czSbPuJd6LXFm0w5PFLkl01SGKz3grMoJ3zRA7yC
 GaOPdiQgNfsvwoeLHKRlWcIEs0ODS0SbvfOD84djHbW1OO1wv5lVEQypN/LH652Z
 cioT7VLlSXMzIGv9P8ZT+kTmz51vkr/DM0wEFqcKnF/xwwidWd2cwJp6xSsopRKW
 HFexgq0qhgXmBdtPyPI0MT+6FbYSFgWcke0wR0KtCrExZ80ZVIpZaRqoaf/TaYB8
 hrTVH3NGzXCRVdE8jfdcBFtfvzS/h0NH0ixKrcoKvNKCaDBiMopz9vykdHCGG0/r
 MqCIA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsjsky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DOSFK008768; Mon, 8 Jul 2024 14:34:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r715-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZH037381;
 Mon, 8 Jul 2024 14:34:42 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-8; Mon, 08 Jul 2024 14:34:42 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 07/10] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Date: Mon,  8 Jul 2024 15:34:17 +0100
Message-Id: <20240708143420.16953-8-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=987
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-ORIG-GUID: SztYO9LI5O9lS_QbPm-tt_YdM2n2SPIf
X-Proofpoint-GUID: SztYO9LI5O9lS_QbPm-tt_YdM2n2SPIf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/sysemu/iommufd.h |  3 +++
 backends/iommufd.c       | 26 ++++++++++++++++++++++++++
 hw/vfio/iommufd.c        | 34 ++++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 4 files changed, 64 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 1470377f55ba..223f1ea14e84 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -56,6 +56,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
                                void *data_ptr, uint32_t *out_hwpt);
 int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
                                        bool start);
+int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint64_t iova, ram_addr_t size,
+                                     uint64_t page_size, uint64_t *data);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 69daabc27473..b2d3bbd7c31b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -257,6 +257,32 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
     return ret;
 }
 
+int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint64_t iova, ram_addr_t size,
+                                     uint64_t page_size, uint64_t *data)
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
+                                           page_size, ret);
+    if (ret) {
+        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
+                     " size: 0x%"PRIx64") failed: %s", iova,
+                     size, strerror(errno));
+    }
+
+    return !ret ? 0 : -errno;
+}
+
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 158a98cb3b12..9fad47baed9e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -152,6 +153,38 @@ err:
     return ret;
 }
 
+static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                      VFIOBitmap *vbmap, hwaddr iova,
+                                      hwaddr size, Error **errp)
+{
+    VFIOIOMMUFDContainer *container = container_of(bcontainer,
+                                                   VFIOIOMMUFDContainer,
+                                                   bcontainer);
+    int ret;
+    VFIOIOASHwpt *hwpt;
+    unsigned long page_size;
+
+    page_size = qemu_real_host_page_size();
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
+            continue;
+        }
+
+        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
+                                               iova, size, page_size,
+                                               vbmap->bitmap);
+        if (ret) {
+            error_setg_errno(errp, ret,
+                             "Failed to get dirty bitmap report, hwpt_id %u, iova: "
+                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
+                             hwpt->hwpt_id, iova, size);
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
@@ -777,6 +810,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
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


