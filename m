Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1B3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Ii-0000g5-1v; Wed, 29 Jan 2025 09:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Id-0000fb-0I
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Ia-0001Os-UB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXqKX031317;
 Wed, 29 Jan 2025 14:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=pho1q/EKZZS+oZE4Tpv1oDI4pvH5imz3U2LHYeXtWnM=; b=
 EeE+5RMMIEsbcKioSNIiJvXX5RcYF2F4NQs1/lW5Ds/Fzcfha4JQWIHsxcYEYR8I
 mm7e5/h7e+NHiA70P2ghv85PafonIvM8JJVxoaeqHmuwJCFbivz8uBg188FJrhlG
 +VVLfA20lpY6g6kSFS5AvGvuvgyy2ImEXZG7gpr7SfcrstO7tFRo3yiswlbgYw6p
 ViTzfKdoUY45rA/HEvEw7gmQX82pIDr2IFP3eQtYocK95gjioTBTRJdXVbopk4cc
 JOXxOM5BHuU/OTtqPiZxkUUweGz0DvjqUtWdFPonbVjDgPmGzGUERDVPYyI9K5qT
 nruHX+csg5Q53GqoWon2SA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp1a81e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:44:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDddn2034299; Wed, 29 Jan 2025 14:43:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4vh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf94003307;
 Wed, 29 Jan 2025 14:43:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-26; Wed, 29 Jan 2025 14:43:58 +0000
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
Subject: [PATCH V1 25/26] vfio/iommufd: reconstruct device
Date: Wed, 29 Jan 2025 06:43:21 -0800
Message-Id: <1738161802-172631-26-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: hQL5yp3j1NfW_7Jzo--HeGbMibork-wp
X-Proofpoint-ORIG-GUID: hQL5yp3j1NfW_7Jzo--HeGbMibork-wp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reconstruct userland device state after CPR.  During vfio_realize, skip
all ioctls that configure the device, as it was already configured in old
QEMU.

Save the ioas_id in vmstate, and skip its allocation in vfio_realize.
Because we skip ioctl's, it is not needed at realize time.  However, we do
need the range info, so defer the call to iommufd_cdev_get_info_iova_range
to a post_load handler, at which time the ioas_id is known.

Save the devid in vmstate.  It is used in one place during realize, to
fetch hw_caps device info, at vfio_device_hiod_realize ->
hiod_iommufd_vfio_realize -> iommufd_backend_get_device_info.  The hw_caps
is not needed until post load time (see the next paragraph), so defer
the call to vfio_device_hiod_realize to post load, at which time the
devid is known.

Save the hwpt_id in vmstate.  In realize, skip its allocation from
iommufd_cdev_attach -> iommufd_cdev_attach_container ->
iommufd_cdev_autodomains_get.  Rebuild userland structures to hold
hwpt_id by calling iommufd_cdev_rebuild_hwpt at post load time.
This depends on hw_caps as described above.

Lastly, change the owning process of the iommufd device in post load.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-iommufd.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/iommufd.c             | 46 +++++++++++++++++++++++++++++++++++++---
 hw/vfio/trace-events          |  1 +
 include/hw/vfio/vfio-common.h |  3 +++
 4 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 053ff8c..711e5cf 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -14,6 +14,9 @@
 #include "migration/vmstate.h"
 #include "system/iommufd.h"
 
+#define IOMMUFD_CONTAINER(base) \
+    container_of(base, VFIOIOMMUFDContainer, bcontainer)
+
 static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
 {
     if (!iommufd_change_process_capable(container->be)) {
@@ -29,6 +32,13 @@ static int vfio_container_post_load(void *opaque, int version_id)
     VFIOIOMMUFDContainer *container = opaque;
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIODevice *vbasedev;
+    Error *err = NULL;
+    uint32_t ioas_id = container->ioas_id;
+
+    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
+        error_report_err(err);
+        return -1;
+    }
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
         vbasedev->reused = false;
@@ -38,21 +48,41 @@ static int vfio_container_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOIOMMUFDContainer *container = opaque;
+
+    /*
+     * The process has not changed yet, but proactively call the ioctl,
+     * and it will fail if any DMA mappings are not supported.
+     */
+    return iommufd_change_process(container->be);
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static int iommufd_cpr_post_load(void *opaque, int version_id)
+{
+     IOMMUFDBackend *be = opaque;
+     return iommufd_change_process(be);
+}
+
 static const VMStateDescription iommufd_cpr_vmstate = {
     .name = "iommufd",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = iommufd_cpr_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
@@ -90,12 +120,31 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
     vfio_cpr_unregister_container(bcontainer);
 }
 
+static int vfio_device_post_load(void *opaque, int version_id)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOIOMMUFDContainer *container = IOMMUFD_CONTAINER(vbasedev->bcontainer);
+    Error *err = NULL;
+
+    if (!vfio_device_hiod_realize(vbasedev, &err)) {
+        error_report_err(err);
+        return false;
+    }
+    if (!vbasedev->mdev) {
+        iommufd_cdev_rebuild_hwpt(vbasedev, container);
+    }
+    return true;
+}
+
 static const VMStateDescription vfio_device_vmstate = {
     .name = "vfio-iommufd-device",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vfio_device_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_INT32(devid, VFIODevice),
+        VMSTATE_UINT32(hwpt_id, VFIODevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index abd17b6..a007b6c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -99,6 +99,11 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         goto err_kvm_device_add;
     }
 
+    if (vbasedev->reused) {
+        /* Already bound, and devid was set in iommufd_cdev_attach */
+        goto skip_bind;
+    }
+
     /* Bind device to iommufd */
     bind.iommufd = iommufd->fd;
     if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
@@ -110,6 +115,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
     vbasedev->devid = bind.out_devid;
     trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
                                         vbasedev->fd, vbasedev->devid);
+
+skip_bind:
     return true;
 err_bind:
     iommufd_cdev_kvm_device_del(vbasedev);
@@ -292,6 +299,7 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
 static void iommufd_cdev_set_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt *hwpt)
 {
     vbasedev->hwpt = hwpt;
+    vbasedev->hwpt_id = hwpt->hwpt_id;
     vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
 }
@@ -324,6 +332,24 @@ static VFIOIOASHwpt *iommufd_cdev_make_hwpt(VFIODevice *vbasedev,
     return hwpt;
 }
 
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container)
+{
+    VFIOIOASHwpt *hwpt;
+    int hwpt_id = vbasedev->hwpt_id;
+
+    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
+
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        if (hwpt->hwpt_id == hwpt_id) {
+            iommufd_cdev_set_hwpt(vbasedev, hwpt);
+            return;
+        }
+    }
+    hwpt = iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id);
+    iommufd_cdev_set_hwpt(vbasedev, hwpt);
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
@@ -527,7 +553,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
      * FD to be connected and having a devid to be able to successfully call
      * iommufd_backend_get_device_info().
      */
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+    if (!vbasedev->reused &&
+        !vfio_device_hiod_realize(vbasedev, errp)) {
         goto err_alloc_ioas;
     }
 
@@ -538,7 +565,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
             vbasedev->iommufd != container->be) {
             continue;
         }
-        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
+        if (!vbasedev->reused &&
+            !iommufd_cdev_attach_container(vbasedev, container, &err)) {
             const char *msg = error_get_pretty(err);
 
             trace_iommufd_cdev_fail_attach_existing_container(msg);
@@ -555,6 +583,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         }
     }
 
+    if (vbasedev->reused) {
+        ioas_id = -1;           /* ioas_id will be received from vmstate */
+        goto skip_ioas_alloc;
+    }
+
     /* Need to allocate a new dedicated container */
     if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
@@ -562,6 +595,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
 
+skip_ioas_alloc:
     container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
     container->be = vbasedev->iommufd;
     container->ioas_id = ioas_id;
@@ -570,7 +604,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     bcontainer = &container->bcontainer;
     vfio_address_space_insert(space, bcontainer);
 
-    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
+    if (!vbasedev->reused &&
+        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
         goto err_attach_container;
     }
 
@@ -579,6 +614,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
+    if (vbasedev->reused) {
+        goto skip_info;
+    }
+
     if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
         error_append_hint(&err,
                    "Fallback to default 64bit IOVA range and 4K page size\n");
@@ -587,6 +626,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         bcontainer->pgsizes = qemu_real_host_page_size();
     }
 
+skip_info:
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index cab1cf1..25ff04c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -176,6 +176,7 @@ iommufd_cdev_connect_and_bind(int iommufd, const char *name, int devfd, int devi
 iommufd_cdev_getfd(const char *dev, int devfd) " %s (fd=%d)"
 iommufd_cdev_attach_ioas_hwpt(int iommufd, const char *name, int devfd, int id) " [iommufd=%d] Successfully attached device %s (%d) to id=%d"
 iommufd_cdev_detach_ioas_hwpt(int iommufd, const char *name) " [iommufd=%d] Successfully detached %s"
+iommufd_cdev_rebuild_hwpt(int iommufd, int hwpt_id) " [iommufd=%d] hwpt %d"
 iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index add44d4..a359ea9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -157,6 +157,7 @@ typedef struct VFIODevice {
     HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
+    uint32_t hwpt_id;
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
 } VFIODevice;
@@ -270,6 +271,8 @@ bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
 void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
+void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
+                               VFIOIOMMUFDContainer *container);
 bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
                                       uint32_t ioas_id, Error **errp);
 bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
-- 
1.8.3.1


