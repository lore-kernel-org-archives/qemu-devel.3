Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A646EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0MK-00027H-MR; Mon, 22 Jul 2024 17:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0ME-0001ik-I4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MC-0006Qs-6q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:10 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKtgNF032336;
 Mon, 22 Jul 2024 21:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=z6SvRVSPICjGFaAswXiOKA9qxrODVD9rJh12dlb82dY=; b=
 SJ7P56yv9WXST1d88PHaEpqOhKqBzAIjrTlg5z164UD6f69iMGYX/xT1pTA0eHf8
 LSQR+C/6C/KiBiLHn8w4iU3J2+mQbUCXrRpufvBlJd7bI/qn9p51fD4f+oBRkW9v
 RJqZh9PGzs3wPEf4mGVYtjCUV9Vu4cG+Vnt6KUH5qLFIwd+4AUiT0nSXgXmq2hFJ
 1L6lodYEt71CtFSmOizNa8uXNpp8MBytKdL+q3HQ55117Sbey6rIWU5JceYSeh8X
 32nPr2A4N1E13WwHvU9+YXvMhTeFkOSfzlAP/CIDqcLvpQ+pNatV8jLx3LDhYL8F
 Ubl7+eAsr2eFLibzCzVk5w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkquh6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MKa7qP011034; Mon, 22 Jul 2024 21:14:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6txF040372;
 Mon, 22 Jul 2024 21:14:04 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-8; Mon, 22 Jul 2024 21:14:04 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 7/9] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Date: Mon, 22 Jul 2024 22:13:24 +0100
Message-Id: <20240722211326.70162-8-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-ORIG-GUID: DXIUpZhH69jz30AJ8eYcMqaDNGKKgKGs
X-Proofpoint-GUID: DXIUpZhH69jz30AJ8eYcMqaDNGKKgKGs
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
Reviewed-by: Cédric Le Goater <clg@redhat.co>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  4 ++++
 backends/iommufd.c       | 29 +++++++++++++++++++++++++++++
 hw/vfio/iommufd.c        | 28 ++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 4 files changed, 62 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 6fb412f61144..4c4886c7787b 100644
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
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b97883503884..9bc466a89c47 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -261,6 +261,35 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
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
+                         " size: 0x"RAM_ADDR_FMT") failed", iova, size);
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
index b882a3f59a6e..92b976464283 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -146,6 +147,32 @@ err:
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
+                                              (uint64_t *)vbmap->bitmap,
+                                              errp)) {
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
@@ -757,6 +784,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
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


