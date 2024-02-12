Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C475AC48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWoG-0006bK-BV; Mon, 12 Feb 2024 08:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWo3-0006WR-Ev
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rZWnx-0007Co-Me
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:57:08 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CDJPSn031790; Mon, 12 Feb 2024 13:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=MYG69SyNLbthPmaYGIKZeO5BilKjofwiHEQgRnSbyC4=;
 b=Yi9z1KVx9spbIPH89ImK/xodo2wthWhg+4doA7FMtDFFt3MJno7N/Ou0sEDq30qcoFGu
 9PwHFaIu2CRZs6ilH4yv7EB8Lrtd8QYs3kOHIPicqfexs0h2XlmjFgExebHATW7JYHfS
 zEH9C7LvY4gTcFoPWkxbPK9dWlNuarCA4asBKDBFQdCYI3jQdrfKTodwXafe0KgHWyoJ
 eeSaYXs2YuYAhbqMgzTJP88T8gdae410dW+1hQY3VrMpn6EEtiOKkLjsPX6psZPegHt5
 dLFHBFs+2x9DAD+XOSjd9/PaV3c2D9zLQiIrluVCW5SFWTZk3leY31FsPiZaAJ53wRNg Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7m40g31u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41CDsIXH024563; Mon, 12 Feb 2024 13:56:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5ykc20vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 13:56:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CDuqi7026744;
 Mon, 12 Feb 2024 13:56:58 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-27-30.vpn.oracle.com
 [10.175.27.30])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3w5ykc20rs-3; Mon, 12 Feb 2024 13:56:58 +0000
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
Subject: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Date: Mon, 12 Feb 2024 13:56:37 +0000
Message-Id: <20240212135643.5858-3-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-1-joao.m.martins@oracle.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0
 mlxlogscore=850 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120105
X-Proofpoint-GUID: VLDUzPKLAXB6tYr-LMpgLxPjtFbQffm5
X-Proofpoint-ORIG-GUID: VLDUzPKLAXB6tYr-LMpgLxPjtFbQffm5
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

There's generally two modes of operation for IOMMUFD:

* The simple user API which intends to perform relatively simple things
with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
and mainly performs IOAS_MAP and UNMAP.

* The native IOMMUFD API where you have fine grained control of the
IOMMU domain and model it accordingly. This is where most new feature
are being steered to.

For dirty tracking 2) is required, as it needs to ensure that
the stage-2/parent IOMMU domain will only attach devices
that support dirty tracking (so far it is all homogeneous in x86, likely
not the case for smmuv3). Such invariant on dirty tracking provides a
useful guarantee to VMMs that will refuse incompatible device
attachments for IOMMU domains.

For dirty tracking such property is enabled/enforced via HWPT_ALLOC,
which is responsible for creating an IOMMU domain. This is contrast to
the 'simple API' where the IOMMU domain is created by IOMMUFD
automatically when it attaches to VFIO (usually referred as autodomains)

To support dirty tracking with the advanced IOMMUFD API, it needs
similar logic, where IOMMU domains are created and devices attached to
compatible domains. Essentially mimmicing kernel
iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
to IOAS attach.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
Right now the only alternative to a userspace autodomains implementation
is to mimmicing all the flags being added to HWPT_ALLOC but into VFIO
IOAS attach. So opted for autodomains userspace approach to avoid the
duplication of hwpt-alloc flags vs attach-ioas flags. I lack mdev real
drivers atm, so testing with those is still TBD.

Opinions, comments, welcome!
---
 backends/iommufd.c            | 29 +++++++++++++
 backends/trace-events         |  1 +
 hw/vfio/iommufd.c             | 78 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  9 ++++
 include/sysemu/iommufd.h      |  4 ++
 5 files changed, 121 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 8486894f1b3f..2970135af4b9 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -211,6 +211,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t flags,
+                               uint32_t data_type, uint32_t data_len,
+                               void *data_ptr, uint32_t *out_hwpt)
+{
+    int ret;
+    struct iommu_hwpt_alloc alloc_hwpt = {
+        .size = sizeof(struct iommu_hwpt_alloc),
+        .flags = flags,
+        .dev_id = dev_id,
+        .pt_id = pt_id,
+        .data_type = data_type,
+        .data_len = data_len,
+        .data_uptr = (uint64_t)data_ptr,
+        .__reserved = 0,
+    };
+
+    ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
+    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id, flags, data_type,
+                                     data_len, (uint64_t)data_ptr,
+                                     alloc_hwpt.out_hwpt_id, ret);
+    if (ret) {
+        error_report("IOMMU_HWPT_ALLOC failed: %m");
+    } else {
+        *out_hwpt = alloc_hwpt.out_hwpt_id;
+    }
+    return !ret ? 0 : -errno;
+}
+
 static const TypeInfo iommufd_backend_info = {
     .name = TYPE_IOMMUFD_BACKEND,
     .parent = TYPE_OBJECT,
diff --git a/backends/trace-events b/backends/trace-events
index d45c6e31a67e..f83a276a4253 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -13,5 +13,6 @@ iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
 iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 7d39d7a5fa51..ca7ec45e725c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -219,10 +219,82 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return ret;
 }
 
+static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
+                                        VFIOIOMMUFDContainer *container,
+                                        Error **errp)
+{
+    int iommufd = vbasedev->iommufd_dev.iommufd->fd;
+    VFIOIOASHwpt *hwpt;
+    Error *err = NULL;
+    int ret = -EINVAL;
+    uint32_t hwpt_id;
+
+    /* Try to find a domain */
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
+        if (ret) {
+            /* -EINVAL means the domain is incompatible with the device. */
+            if (ret == -EINVAL) {
+                continue;
+            }
+            return ret;
+        } else {
+            vbasedev->hwpt = hwpt;
+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+            return 0;
+        }
+    }
+
+    ret = iommufd_backend_alloc_hwpt(iommufd,
+                                     vbasedev->iommufd_dev.devid,
+                                     container->ioas_id, 0, 0, 0,
+                                     NULL, &hwpt_id);
+    if (ret) {
+        error_append_hint(&err,
+                   "Failed to allocate HWPT for device %s. Fallback to IOAS attach\n",
+                   vbasedev->name);
+        warn_report_err(err);
+        return ret;
+    }
+
+    hwpt = g_malloc0(sizeof(*hwpt));
+    hwpt->hwpt_id = hwpt_id;
+    QLIST_INIT(&hwpt->device_list);
+
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
+    if (ret) {
+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
+        g_free(hwpt);
+        return ret;
+    }
+
+    vbasedev->hwpt = hwpt;
+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    return 0;
+}
+
+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
+                                         VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
+
+    QLIST_REMOVE(vbasedev, hwpt_next);
+    QLIST_REMOVE(hwpt, next);
+    if (QLIST_EMPTY(&hwpt->device_list)) {
+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
+        g_free(hwpt);
+    }
+}
+
 static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
 {
+    if (!iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
+        return 0;
+    }
+
     return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
 
@@ -231,6 +303,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
 {
     Error *err = NULL;
 
+    if (vbasedev->hwpt) {
+        iommufd_cdev_autodomains_put(vbasedev, container);
+        return;
+    }
+
     if (iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
         error_report_err(err);
     }
@@ -370,6 +447,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     container = g_malloc0(sizeof(*container));
     container->be = vbasedev->iommufd_dev.iommufd;
     container->ioas_id = ioas_id;
+    QLIST_INIT(&container->hwpt_list);
 
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, iommufd_vioc);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9c4b60c906d9..7f7d823221e2 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -93,10 +93,17 @@ typedef struct VFIOHostDMAWindow {
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
+typedef struct VFIOIOASHwpt {
+    uint32_t hwpt_id;
+    QLIST_HEAD(, VFIODevice) device_list;
+    QLIST_ENTRY(VFIOIOASHwpt) next;
+} VFIOIOASHwpt;
+
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
 
 /* Abstraction of host IOMMU legacy device */
@@ -136,6 +143,8 @@ typedef struct VFIODevice {
         IOMMULegacyDevice legacy_dev;
         IOMMUFDDevice iommufd_dev;
     };
+    VFIOIOASHwpt *hwpt;
+    QLIST_ENTRY(VFIODevice) hwpt_next;
 } VFIODevice;
 
 QEMU_BUILD_BUG_ON(offsetof(VFIODevice, legacy_dev.base) !=
diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 4afe97307dbe..1966b75caae2 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -49,4 +49,8 @@ typedef struct IOMMUFDDevice {
 void iommufd_device_init(IOMMUFDDevice *idev);
 int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
                                        Error **errp);
+int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t flags,
+                               uint32_t data_type, uint32_t data_len,
+                               void *data_ptr, uint32_t *out_hwpt);
 #endif
-- 
2.39.3


