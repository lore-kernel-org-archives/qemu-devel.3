Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D3EC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2AV-0000lH-N4; Tue, 10 Jun 2025 12:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP153-0004Kp-RN
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP150-0005vp-ED
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:04 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXYK2026647;
 Tue, 10 Jun 2025 15:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KZpZTn45bc/rvtEm0PRCar5zhcaWGPgRdsrNphDQE1k=; b=
 Lbvu04pg/anzlawFX8SKaxl/BiXwdRi61xiNne5LX8ZbEQreAZCIcI+9b5dh3n0S
 IP2uUbkAwq8ZZ3M7s0Nc34cTGHs3wXkQwWydVSg8AMiB/5Ciz2nUcjCNxAjeMJKo
 ZOs5BQ/Wd5bw/q6DkaPrNeiF/WI5Bpo8kf025R4gIO78mLEKFOUxtdQoXKYEtiLg
 oYvQwJFrnkbKK3dHZj2BX/E4rnhw8cMzM2m8oWpk0yjiDA4dRSbArs4EL8x5qUaj
 6rnqMKfcooELKvaJOv49sQOR2XLz55LMKvbsRzhrWtVVwr1Wspj3+/Db6z/DZwUW
 nU/bqx0wWs4/IouFPSPe3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjuwkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEwJAK003303; Tue, 10 Jun 2025 15:39:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wap7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:39:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfF028825;
 Tue, 10 Jun 2025 15:39:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-5; Tue, 10 Jun 2025 15:39:58 +0000
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
Subject: [PATCH V5 04/38] vfio/container: preserve descriptors
Date: Tue, 10 Jun 2025 08:39:17 -0700
Message-Id: <1749569991-25171-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684851cf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=miLydSRkNuMCGuxuvKoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXyGvi7vFYgSQ0
 Zd92qsspPVp7DsZAk3vOfGRMnos+fyvc36zjix2AE6Bl349cKfAWqPE/DreWQb4GdfL8SUW/1FB
 kKdlcmWeNa2hixw1ms4Vez/VXEqnAMp2/oQlqty0o1LduLWKjN1FF4ZAeNJToThdNg5pHxw8HbZ
 Uq0nFemfUHhbeOLTYIicIST+XcfQ/FGA2965Qo+fYRcb2Pom0H8RlCA/whSpiQlvyKhn7ubZK9k
 0mriCEp4yYmFmGOIffeTfgpF+tBOe57wOYElVPreVHhlI3ksgY6DP2CN9VZ9KJ8qCj3Fc53An9y
 iC2BOI1elRbUFg9t/A8gP3FeWGGWiDnwqLcpg3ZhzWkzcLIy9rE6pM6MMZwhBPXOV5EH2Vw0WZt
 7tvxQBQ6rdGLsxPE9WnxGL3HwLYYUizqEclGD+D13HGivEc31BGFH4LlrZFC51rxSc5aAyew
X-Proofpoint-ORIG-GUID: JdQ2bE6nyO2PTV3pJDMrZlmcxTDMTfh1
X-Proofpoint-GUID: JdQ2bE6nyO2PTV3pJDMrZlmcxTDMTfh1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
the saved descriptors.

During reuse, device and iommu state is already configured, so operations
in vfio_realize that would modify the configuration, such as vfio ioctl's,
are skipped.  The result is that vfio_realize constructs qemu data
structures that reflect the current state of the device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-cpr.h |  6 +++++
 hw/vfio/container.c        | 67 +++++++++++++++++++++++++++++++++++-----------
 hw/vfio/cpr-legacy.c       | 42 +++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d4e0bd5..5a2e5f6 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -13,6 +13,7 @@
 
 struct VFIOContainer;
 struct VFIOContainerBase;
+struct VFIOGroup;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
@@ -30,4 +31,9 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
                                  Error **errp);
 void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
 
+int vfio_cpr_group_get_device_fd(int d, const char *name);
+
+bool vfio_cpr_container_match(struct VFIOContainer *container,
+                              struct VFIOGroup *group, int fd);
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 93cdf80..5caae4c 100644
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
 #include "vfio-helpers.h"
@@ -425,7 +427,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
         return NULL;
     }
 
-    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
+    /*
+     * During CPR, just set the container type and skip the ioctls, as the
+     * container and group are already configured in the kernel.
+     */
+    if (!cpr_is_incoming() &&
+        !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
         return NULL;
     }
 
@@ -592,6 +599,11 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
     vfio_group_add_kvm_device(group);
+    /*
+     * Remember the container fd for each group, so we can attach to the same
+     * container after CPR.
+     */
+    cpr_resave_fd("vfio_container_for_group", group->groupid, container->fd);
     return true;
 }
 
@@ -601,6 +613,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
     group->container = NULL;
     vfio_group_del_kvm_device(group);
     vfio_ram_block_discard_disable(container, false);
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 }
 
 static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
@@ -615,17 +628,34 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
     bool group_was_added = false;
 
     space = vfio_address_space_get(as);
+    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
 
-    QLIST_FOREACH(bcontainer, &space->containers, next) {
-        container = container_of(bcontainer, VFIOContainer, bcontainer);
-        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            return vfio_container_group_add(container, group, errp);
+    if (!cpr_is_incoming()) {
+        QLIST_FOREACH(bcontainer, &space->containers, next) {
+            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
+                return vfio_container_group_add(container, group, errp);
+            }
         }
-    }
 
-    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
-    if (fd < 0) {
-        goto fail;
+        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
+        if (fd < 0) {
+            goto fail;
+        }
+    } else {
+        /*
+         * For incoming CPR, the group is already attached in the kernel.
+         * If a container with matching fd is found, then update the
+         * userland group list and return.  If not, then after the loop,
+         * create the container struct and group list.
+         */
+        QLIST_FOREACH(bcontainer, &space->containers, next) {
+            container = container_of(bcontainer, VFIOContainer, bcontainer);
+
+            if (vfio_cpr_container_match(container, group, fd)) {
+                return vfio_container_group_add(container, group, errp);
+            }
+        }
     }
 
     ret = ioctl(fd, VFIO_GET_API_VERSION);
@@ -697,6 +727,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
 
     /*
      * Explicitly release the listener first before unset container,
@@ -750,7 +781,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open(path, O_RDWR, errp);
+    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, errp);
     if (group->fd < 0) {
         goto free_group_exit;
     }
@@ -782,6 +813,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     return group;
 
 close_fd_exit:
+    cpr_delete_fd("vfio_group", groupid);
     close(group->fd);
 
 free_group_exit:
@@ -803,6 +835,7 @@ static void vfio_group_put(VFIOGroup *group)
     vfio_container_disconnect(group);
     QLIST_REMOVE(group, next);
     trace_vfio_group_put(group->fd);
+    cpr_delete_fd("vfio_group", group->groupid);
     close(group->fd);
     g_free(group);
 }
@@ -813,7 +846,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
 
-    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
+    fd = vfio_cpr_group_get_device_fd(group->fd, name);
     if (fd < 0) {
         error_setg_errno(errp, errno, "error getting device from group %d",
                          group->groupid);
@@ -826,8 +859,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     info = vfio_get_device_info(fd);
     if (!info) {
         error_setg_errno(errp, errno, "error getting device info");
-        close(fd);
-        return false;
+        goto fail;
     }
 
     /*
@@ -841,8 +873,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         if (!QLIST_EMPTY(&group->device_list)) {
             error_setg(errp, "Inconsistent setting of support for discarding "
                        "RAM (e.g., balloon) within group");
-            close(fd);
-            return false;
+            goto fail;
         }
 
         if (!group->ram_block_discard_allowed) {
@@ -860,6 +891,11 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
     return true;
+
+fail:
+    close(fd);
+    cpr_delete_fd(name, 0);
+    return false;
 }
 
 static void vfio_device_put(VFIODevice *vbasedev)
@@ -870,6 +906,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_device_put(vbasedev->fd);
+    cpr_delete_fd(vbasedev->name, 0);
     close(vbasedev->fd);
 }
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index dd7ac84..ac4a9ab 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -8,6 +8,7 @@
 #include <linux/vfio.h>
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-container.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
@@ -66,3 +67,44 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
     migrate_del_blocker(&container->cpr.blocker);
     vmstate_unregister(NULL, &vfio_container_vmstate, container);
 }
+
+int vfio_cpr_group_get_device_fd(int d, const char *name)
+{
+    const int id = 0;
+    int fd = cpr_find_fd(name, id);
+
+    if (fd < 0) {
+        fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
+        if (fd >= 0) {
+            cpr_save_fd(name, id, fd);
+        }
+    }
+    return fd;
+}
+
+static bool same_device(int fd1, int fd2)
+{
+    struct stat st1, st2;
+
+    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
+}
+
+bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
+                              int fd)
+{
+    if (container->fd == fd) {
+        return true;
+    }
+    if (!same_device(container->fd, fd)) {
+        return false;
+    }
+    /*
+     * Same device, different fd.  This occurs when the container fd is
+     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
+     * produces duplicates.  De-dup it.
+     */
+    cpr_delete_fd("vfio_container_for_group", group->groupid);
+    close(fd);
+    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
+    return true;
+}
-- 
1.8.3.1


