Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFA7C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9V-0003yH-6r; Mon, 12 May 2025 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9O-0003lF-QD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9M-0006ee-8y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9ffJ018643;
 Mon, 12 May 2025 15:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=n19sIWPuT7OKmB603ippcm31tw4Pu7rf9KTLG61wEiI=; b=
 H8Dw6OB4dOcsXwXvodE5F8Xaye4ZanO7rwR/vajLVxnw45BZqhxGIHnhDpvqn66T
 Y/3sgwSYRIFP9/qwGfhlLHDTXa9Wuvb3yuKPkmocAq/YjSHvU2pXzcw8+T/iZgdg
 MDitdzj0JEes3TyFfIuBQ0YRKl8aqcKAzhUyU94X/MenPk8JkpyR7D1zW23DFveA
 no8ISkxWSbGQr3XKKRSORgGhCveINRxaL3va3k0GsIVOnANhLW1vDnGq6oMzBjOs
 e0B7w1qB8IFAFNGhYAx6RXSW3sUG1kt8GVauqN3vFfmykzmbEYm2tJm2CT+K9hye
 jikDnry4mQRph19tbQ0hQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2sd3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEFvxF002388; Mon, 12 May 2025 15:33:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3666y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:00 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4q030605;
 Mon, 12 May 2025 15:32:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-8; Mon, 12 May 2025 15:32:59 +0000
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
Subject: [PATCH V3 07/42] vfio/container: preserve descriptors
Date: Mon, 12 May 2025 08:32:18 -0700
Message-Id: <1747063973-124548-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX4SR7vT9JyAJJ
 rd4C6WF3OaG+3McXQ2Evcie7o6cYb0qwksIqAMkYEDO5NFT0A6j7in6H10WEpJ56CZmyDKzcUL4
 qPSa8ft1MOWi6pUq6dDOHP3xfqfQV4YR0cBYvuTD3MH2mG3qnl0bMn7cm2QyVT014S3U+FCVvGp
 SqUrU3KwJQMYUt/QkP/gkTDh1w/nrmEwgjiGa5zo2ZeUSMEK8C8qqF+eV+lmtA54YkPQ/YPKNg5
 laoKTtE157jHFTZGERTnM4yWoELKi0bHngVVTbQCsUFp5U5xQ23XsO6xQpkhC5t8R3xCVdKLgAO
 1pnZTdsUFvyAo44e+YN6WGScsugpFsHI7CS8SWSKgU6ZmrLql3RkREXPRbJv9oBGUgO/PpCiAQV
 dS+y003naOe4vcC3ZL+Gk/g+TtY011Wd/ynZatoyxVfDnXyg4uCkvLaVYKQ3oRV7rkKkUCu2
X-Proofpoint-GUID: 6bl2KE3tpMNr1mJ7CbByjLmtPKTrD5At
X-Proofpoint-ORIG-GUID: 6bl2KE3tpMNr1mJ7CbByjLmtPKTrD5At
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214ad b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=m6PkJStKav1_m1v22YcA:9
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
 hw/vfio/container.c           | 65 ++++++++++++++++++++++++++++++++++++-------
 hw/vfio/cpr-legacy.c          | 46 ++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-cpr.h    |  9 ++++++
 include/hw/vfio/vfio-device.h |  2 ++
 4 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 85c76da..278a220 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -31,6 +31,8 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/blocker.h"
 #include "pci.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -414,7 +416,7 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
 }
 
 static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
-                                            Error **errp)
+                                            bool cpr_reused, Error **errp)
 {
     int iommu_type;
     const char *vioc_name;
@@ -425,7 +427,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
         return NULL;
     }
 
-    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
+    /*
+     * If container is reused, just set its type and skip the ioctls, as the
+     * container and group are already configured in the kernel.
+     */
+    if (!cpr_reused && !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
         return NULL;
     }
 
@@ -433,6 +439,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
 
     container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
     container->fd = fd;
+    container->cpr.reused = cpr_reused;
     container->iommu_type = iommu_type;
     return container;
 }
@@ -584,7 +591,7 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
 }
 
 static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
-                                     Error **errp)
+                                     bool cpr_reused, Error **errp)
 {
     if (!vfio_container_attach_discard_disable(container, group, errp)) {
         return false;
@@ -592,6 +599,9 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
     vfio_group_add_kvm_device(group);
+    if (!cpr_reused) {
+        cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    }
     return true;
 }
 
@@ -601,6 +611,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
     group->container = NULL;
     vfio_group_del_kvm_device(group);
     vfio_ram_block_discard_disable(container, false);
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 }
 
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
@@ -613,17 +624,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     VFIOIOMMUClass *vioc = NULL;
     bool new_container = false;
     bool group_was_added = false;
+    bool cpr_reused;
 
     space = vfio_address_space_get(as);
+    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
+    cpr_reused = (fd > 0);
+
+    /*
+     * If the container is reused, then the group is already attached in the
+     * kernel.  If a container with matching fd is found, then update the
+     * userland group list and return.  If not, then after the loop, create
+     * the container struct and group list.
+     */
 
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            return vfio_container_group_add(container, group, errp);
+
+        if (cpr_reused) {
+            if (!vfio_cpr_container_match(container, group, &fd)) {
+                continue;
+            }
+        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+            continue;
         }
+
+        return vfio_container_group_add(container, group, cpr_reused, errp);
+    }
+
+    if (!cpr_reused) {
+        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     if (fd < 0) {
         goto fail;
     }
@@ -635,7 +666,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    container = vfio_create_container(fd, group, errp);
+    container = vfio_create_container(fd, group, cpr_reused, errp);
     if (!container) {
         goto fail;
     }
@@ -655,7 +686,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     vfio_address_space_insert(space, bcontainer);
 
-    if (!vfio_container_group_add(container, group, errp)) {
+    if (!vfio_container_group_add(container, group, cpr_reused, errp)) {
         goto fail;
     }
     group_was_added = true;
@@ -697,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 
     /*
      * Explicitly release the listener first before unset container,
@@ -750,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR, errp);
+    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, NULL, errp);
     if (group->fd < 0) {
         goto free_group_exit;
     }
@@ -782,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     return group;
 
 close_fd_exit:
+    cpr_delete_fd("vfio_group", groupid);
     close(group->fd);
 
 free_group_exit:
@@ -803,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
     vfio_container_disconnect(group);
     QLIST_REMOVE(group, next);
     trace_vfio_group_put(group->fd);
+    cpr_delete_fd("vfio_group", group->groupid);
     close(group->fd);
     g_free(group);
 }
@@ -812,8 +846,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
+    bool cpr_reused;
+
+    fd = cpr_find_fd(name, 0);
+    cpr_reused = (fd >= 0);
+    if (!cpr_reused) {
+        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    }
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -857,6 +897,10 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
+    vbasedev->cpr.reused = cpr_reused;
+    if (!cpr_reused) {
+        cpr_save_fd(name, 0, fd);
+    }
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
     return true;
@@ -870,6 +914,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_device_put(vbasedev->fd);
+    cpr_delete_fd(vbasedev->name, 0);
     close(vbasedev->fd);
 }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index fac323c..638a8e0 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
@@ -31,10 +32,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_post_load(void *opaque, int version_id)
+{
+    VFIOContainer *container = opaque;
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    container->cpr.reused = false;
+
+    QLIST_FOREACH(group, &container->group_list, container_next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            vbasedev->cpr.reused = false;
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
@@ -68,3 +86,31 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
 }
+
+static bool same_device(int fd1, int fd2)
+{
+    struct stat st1, st2;
+
+    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
+}
+
+bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+                              int *pfd)
+{
+    if (container->fd == *pfd) {
+        return true;
+    }
+    if (!same_device(container->fd, *pfd)) {
+        return false;
+    }
+    /*
+     * Same device, different fd.  This occurs when the container fd is
+     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
+     * produces duplicates.  De-dup it.
+     */
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
+    close(*pfd);
+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    *pfd = container->fd;
+    return true;
+}
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index f864547..1c4f070 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -13,10 +13,16 @@
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
+    bool reused;
 } VFIOContainerCPR;
 
+typedef struct VFIODeviceCPR {
+    bool reused;
+} VFIODeviceCPR;
+
 struct VFIOContainer;
 struct VFIOContainerBase;
+struct VFIOGroup;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
@@ -29,4 +35,7 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
+bool vfio_cpr_container_match(struct VFIOContainer *container,
+                              struct VFIOGroup *group, int *fd);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8bcb3c1..4e4d0b6 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -28,6 +28,7 @@
 #endif
 #include "system/system.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "system/host_iommu_device.h"
 #include "system/iommufd.h"
 
@@ -84,6 +85,7 @@ typedef struct VFIODevice {
     VFIOIOASHwpt *hwpt;
     QLIST_ENTRY(VFIODevice) hwpt_next;
     struct vfio_region_info **reginfo;
+    VFIODeviceCPR cpr;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
1.8.3.1


