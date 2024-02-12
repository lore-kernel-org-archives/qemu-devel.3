Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510C2C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWom-0006zF-F6; Mon, 12 Feb 2024 08:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo8-0006XF-59
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo3-0007ER-6B
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:13 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDo2xU000440; Mon, 12 Feb 2024 13:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NKYw2KnbG7Z3DMtUsjDy0vLuRffYtT6VEU5hwHoz/To=;
 b=R2a4wCixrkFccEU2MwY2CeNB6advwdYxwk9/GtBsATDZ29qsfg444qnORCFXgER3/nTo
 Sl1OyF7TMS6lSRUlrHyvm5TioSzrB+TBrcfcPDCa0QvlP4JJFi0QfwepZke593gsoEXp
 TRU5c3LUJG+SVmQ5DNSLi99bSMniGA3yAwBbbnEi+N7oyTG455nFaAbHgYATIw0INyTe
 lnFPkYyLZuZI+48T8fd+IrYWyP0soHubCr40x3yDOPuOKuDKfWT3vKUCC0CZ+KM82URG
 AqhkgyhEqRa5gnT86rP0c+7EhczYdwfbR54PxxlaX3f9ePw6kKZ2E5LIsMZ0G55MsKqU 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7mj2g0h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:06 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CCrK38024602; Mon, 12 Feb 2024 13:57:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc2103-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:57:06 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqiB026744;
 Mon, 12 Feb 2024 13:57:05 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-5; Mon, 12 Feb 2024 13:57:05 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH RFCv2 4/8] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Date: Mon, 12 Feb 2024 13:56:39 +0000
Message-Id: <20240212135643.5858-5-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: tYafEM4yiwjKW6zarmRoeruJwAz6VQ2W
X-Proofpoint-ORIG-GUID: tYafEM4yiwjKW6zarmRoeruJwAz6VQ2W
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
enables or disables dirty page tracking.

It is called on the whole list of iommu domains it is are tracking,
and on failure it rolls it back.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 backends/iommufd.c       | 19 +++++++++++++++++++
 backends/trace-events    |  1 +
 hw/vfio/common.c         |  7 ++++++-
 hw/vfio/iommufd.c        | 28 ++++++++++++++++++++++++++++
 include/sysemu/iommufd.h |  3 +++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2970135af4b9..954de61c2da0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -240,6 +240,25 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
     return !ret ? 0 : -errno;
 }
 
+int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                       bool start)
+{
+    int ret;
+    struct iommu_hwpt_set_dirty_tracking set_dirty = {
+            .size = sizeof(set_dirty),
+            .hwpt_id = hwpt_id,
+            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
+    };
+
+    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
+    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret);
+    if (ret) {
+        error_report("IOMMU_HWPT_SET_DIRTY_TRACKING failed: %s",
+                     strerror(errno));
+    }
+    return !ret ? 0 : -errno;
+}
+
 static const TypeInfo iommufd_backend_info = {
     .name = TYPE_IOMMUFD_BACKEND,
     .parent = TYPE_OBJECT,
diff --git a/backends/trace-events b/backends/trace-events
index f83a276a4253..feba2baca5f7 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d8fc7077f839..a940c0b6ede8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -190,7 +190,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         VFIOMigration *migration = vbasedev->migration;
 
-        if (!migration) {
+        if (!migration && !vbasedev->iommufd_dev.iommufd) {
             return false;
         }
 
@@ -199,6 +199,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
              vfio_device_state_is_precopy(vbasedev))) {
             return false;
         }
+
+        if (vbasedev->iommufd_dev.iommufd &&
+            !bcontainer->dirty_pages_supported) {
+            return false;
+        }
     }
     return true;
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index edacb6d72748..361e659288fd 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,6 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
+#include "migration/migration.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
@@ -115,6 +116,32 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
     iommufd_backend_disconnect(vbasedev->iommufd_dev.iommufd);
 }
 
+static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                           bool start)
+{
+    const VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+    int ret;
+    VFIOIOASHwpt *hwpt;
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = iommufd_backend_set_dirty_tracking(container->be,
+                                                 hwpt->hwpt_id, start);
+        if (ret) {
+            goto err;
+        }
+    }
+
+    return 0;
+
+err:
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        iommufd_backend_set_dirty_tracking(container->be,
+                                           hwpt->hwpt_id, !start);
+    }
+    return ret;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     long int ret = -ENOTTY;
@@ -737,6 +764,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
     vioc->detach_device = iommufd_cdev_detach;
     vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
     vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
+    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
 };
 
 static const TypeInfo types[] = {
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 1966b75caae2..562c189dd92c 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -53,4 +53,7 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
                                uint32_t pt_id, uint32_t flags,
                                uint32_t data_type, uint32_t data_len,
                                void *data_ptr, uint32_t *out_hwpt);
+int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                       bool start);
+
 #endif
-- 
2.39.3


