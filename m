Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911CFC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IR-0000aK-3Q; Wed, 29 Jan 2025 09:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IG-0000VZ-C2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9ID-0001KX-3B
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:51 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXq2w006366;
 Wed, 29 Jan 2025 14:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=/wgzN+mc7d/TiXv74t2VfLwHkMPhU6AEjb1uYCnlGds=; b=
 izQsHjMi0/133rwB7pjRMchDZPsroPwEZRGAZwoUI0DyiQvgzhh97pH/ZyyAXJSL
 QbzRFLr8RR8Sf0hwksMA5cnZVHqv4eeNR5eKT6SeonPfcUwrl+cGFufBQEBIX/Qt
 U8bXs6E5ktu46Mw2f8xUYCoaQKVdZSSyQoei7j5Phca1MCM2a7BjusHxHDNGMqd0
 INyE93FwdKdieW/rOhHXEh3n2M6YhJaLw89V11JdzsF952csQN5woXI46dGMASxz
 x3fSrPNWwuqU0zWECBWAPjgkf4GjKoYPeOZVjmrKw6WHouoqU7eiqtwJMuD3bV2R
 L87Ils2L6Go7rObo34v8Zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fmut8722-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TERLCB036983; Wed, 29 Jan 2025 14:43:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8O003307;
 Wed, 29 Jan 2025 14:43:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-6; Wed, 29 Jan 2025 14:43:44 +0000
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
Subject: [PATCH V1 05/26] vfio/container: preserve descriptors
Date: Wed, 29 Jan 2025 06:43:01 -0800
Message-Id: <1738161802-172631-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: P4t5w7olCeqdGegbXuBXHlal8MipYZli
X-Proofpoint-ORIG-GUID: P4t5w7olCeqdGegbXuBXHlal8MipYZli
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

At vfio creation time, save the value of vfio container, group, and device
descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
the saved descriptors, and remembers the reused status for subsequent
patches.  The reused status is cleared when vmstate load finishes.

During reuse, device and iommu state is already configured, so operations
in vfio_realize that would modify the configuration, such as vfio ioctl's,
are skipped.  The result is that vfio_realize constructs qemu data
structures that reflect the current state of the device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c           | 105 ++++++++++++++++++++++++++++++++++--------
 hw/vfio/cpr-legacy.c          |  17 +++++++
 include/hw/vfio/vfio-common.h |   2 +
 3 files changed, 105 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a90ce6c..81d0ccc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -31,6 +31,7 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/cpr.h"
 #include "pci.h"
 
 VFIOGroupList vfio_group_list =
@@ -415,12 +416,28 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
 }
 
 static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
-                                            Error **errp)
+                                            bool reused, Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
     VFIOContainer *container;
 
+    /*
+     * If container is reused, just set its type and skip the ioctls, as the
+     * container and group are already configured in the kernel.
+     * VFIO_TYPE1v2_IOMMU is the only type that supports reuse/cpr.
+     */
+    if (reused) {
+        if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
+            iommu_type = VFIO_TYPE1v2_IOMMU;
+            goto skip_iommu;
+        } else {
+            error_setg(errp, "container was reused but VFIO_TYPE1v2_IOMMU "
+                             "is not supported");
+            return NULL;
+        }
+    }
+
     iommu_type = vfio_get_iommu_type(fd, errp);
     if (iommu_type < 0) {
         return NULL;
@@ -430,10 +447,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
         return NULL;
     }
 
+skip_iommu:
     vioc_name = vfio_get_iommu_class_name(iommu_type);
 
     container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
+    container->reused = reused;
     container->iommu_type = iommu_type;
     return container;
 }
@@ -543,10 +562,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
     int ret, fd;
+    bool reused;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
 
     space = vfio_get_address_space(as);
+    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
+    reused = (fd > 0);
 
     /*
      * VFIO is currently incompatible with discarding of RAM insofar as the
@@ -579,28 +601,52 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * details once we know which type of IOMMU we are using.
      */
 
+    /*
+     * If the container is reused, then the group is already attached in the
+     * kernel.  If a container with matching fd is found, then update the
+     * userland group list and return.  If not, then after the loop, create
+     * the container struct and group list.
+     */
+
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            ret = vfio_ram_block_discard_disable(container, true);
-            if (ret) {
-                error_setg_errno(errp, -ret,
-                                 "Cannot set discarding of RAM broken");
-                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
-                          &container->fd)) {
-                    error_report("vfio: error disconnecting group %d from"
-                                 " container", group->groupid);
-                }
-                return false;
+
+        if (reused) {
+            if (container->fd != fd) {
+                continue;
             }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+            continue;
+        }
+
+        /* Container is a match for the group */
+        ret = vfio_ram_block_discard_disable(container, true);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Cannot set discarding of RAM broken");
+            if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
+                      &container->fd)) {
+                error_report("vfio: error disconnecting group %d from"
+                             " container", group->groupid);
+
+            }
+            goto delete_fd_exit;
+        }
+        group->container = container;
+        QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+        if (!reused) {
             vfio_kvm_device_add_group(group);
-            return true;
+            cpr_save_fd("vfio_container_for_group", group->groupid,
+                        container->fd);
         }
+        return true;
+    }
+
+    /* No matching container found, create one */
+    if (!reused) {
+        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     if (fd < 0) {
         goto put_space_exit;
     }
@@ -612,11 +658,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto close_fd_exit;
     }
 
-    container = vfio_create_container(fd, group, errp);
+    container = vfio_create_container(fd, group, reused, errp);
     if (!container) {
         goto close_fd_exit;
     }
     bcontainer = &container->bcontainer;
+    container->reused = reused;
 
     if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto free_container_exit;
@@ -652,6 +699,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     bcontainer->initialized = true;
+    cpr_resave_fd("vfio_container_for_group", group->groupid, fd);
 
     return true;
 listener_release_exit:
@@ -677,6 +725,8 @@ close_fd_exit:
 put_space_exit:
     vfio_put_address_space(space);
 
+delete_fd_exit:
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
     return false;
 }
 
@@ -688,6 +738,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 
     /*
      * Explicitly release the listener first before unset container,
@@ -741,7 +792,12 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR, errp);
+
+    group->fd = cpr_find_fd("vfio_group", groupid);
+    if (group->fd < 0) {
+        group->fd = qemu_open(path, O_RDWR, errp);
+    }
+
     if (group->fd < 0) {
         goto free_group_exit;
     }
@@ -769,6 +825,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     }
 
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
+    cpr_resave_fd("vfio_group", groupid, group->fd);
 
     return group;
 
@@ -794,6 +851,7 @@ static void vfio_put_group(VFIOGroup *group)
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);
     trace_vfio_put_group(group->fd);
+    cpr_delete_fd("vfio_group", group->groupid);
     close(group->fd);
     g_free(group);
 }
@@ -803,8 +861,14 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
+    bool reused;
+
+    fd = cpr_find_fd(name, 0);
+    reused = (fd >= 0);
+    if (!reused) {
+        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    }
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -849,6 +913,8 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     vbasedev->num_irqs = info->num_irqs;
     vbasedev->num_regions = info->num_regions;
     vbasedev->flags = info->flags;
+    vbasedev->reused = reused;
+    cpr_resave_fd(name, 0, fd);
 
     trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
@@ -865,6 +931,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
+    cpr_delete_fd(vbasedev->name, 0);
     close(vbasedev->fd);
 }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index d3bbc05..ce6f14e 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -29,10 +29,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOContainer *container = opaque;
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    container->reused = false;
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            vbasedev->reused = false;
+        }
+    }
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 53e554f..a435a90 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -85,6 +85,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
     Error *cpr_blocker;
+    bool reused;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
@@ -135,6 +136,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    bool reused;
     VFIODeviceOps *ops;
     unsigned int num_irqs;
     unsigned int num_regions;
-- 
1.8.3.1


