Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B321C021A9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSs-0004No-42; Fri, 14 Feb 2025 09:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSp-0004Mv-Mp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSo-0004Ro-03
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtUQu017777;
 Fri, 14 Feb 2025 14:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=kea8JUzvCW8nODhxeDL5w/7NENARlC44BW5O1/xjKAQ=; b=
 ZPkNqfDro0sxe9XlgaYO+UnqgWV2RAgwQX91nsDvKfnzKvR2ilhn5Y8VYDqQdjyi
 RV/gT6Jw1KhlRQ3z6+1/yS0iMp6PxqfrFjffxokJT16DvB9z5mpIi1CUyP196qey
 YLTwgzL0Rzp/YcWD0KhDqaQBza9PfwfDyAQ+gPNmZJGSMKlRa4DB4arzML/TK9eL
 PhIsLtGaYbh/CYqtmV2lLATedG29Re+fw+Nw6M6zcbDyuCUKE3hr7VW1wL20gCPa
 61Dxfg2VZGi5cC17Vnx6qj1HMM6Df828SaMpby15zproUICKtK99Wjaaz8UojAU9
 ABKgaIk/C1O4qowFwDacMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgbtvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECP2ko025273; Fri, 14 Feb 2025 14:14:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg6j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPP006920;
 Fri, 14 Feb 2025 14:14:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-7; Fri, 14 Feb 2025 14:14:37 +0000
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
Subject: [PATCH V2 06/45] vfio/container: reform vfio_connect_container cleanup
Date: Fri, 14 Feb 2025 06:13:48 -0800
Message-Id: <1739542467-226739-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: DbU7bNdqkoIU_LdU3eSd9mOTzVOnn6xN
X-Proofpoint-ORIG-GUID: DbU7bNdqkoIU_LdU3eSd9mOTzVOnn6xN
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
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

Replace the proliferation of exit labels in vfio_connect_container with
conditionals for cleaning each piece of state.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c | 61 +++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0f17d53..c668d07 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -587,9 +587,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 {
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
-    int ret, fd;
+    int ret, fd = -1;
     VFIOAddressSpace *space;
-    VFIOIOMMUClass *vioc;
+    VFIOIOMMUClass *vioc = NULL;
+    bool new_container = false;
+    bool group_was_added = false;
+    bool discard_disabled = false;
 
     space = vfio_get_address_space(as);
 
@@ -608,35 +611,37 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     if (fd < 0) {
-        goto put_space_exit;
+        goto fail;
     }
 
     ret = ioctl(fd, VFIO_GET_API_VERSION);
     if (ret != VFIO_API_VERSION) {
         error_setg(errp, "supported vfio version: %d, "
                    "reported version: %d", VFIO_API_VERSION, ret);
-        goto close_fd_exit;
+        goto fail;
     }
 
     container = vfio_create_container(fd, group, errp);
     if (!container) {
-        goto close_fd_exit;
+        goto fail;
     }
+    new_container = true;
     bcontainer = &container->bcontainer;
 
     if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto free_container_exit;
+        goto fail;
     }
 
     if (!vfio_attach_discard_disable(container, group, errp)) {
-        goto unregister_container_exit;
+        goto fail;
     }
+    discard_disabled = true;
 
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto enable_discards_exit;
+        goto fail;
     }
 
     vfio_kvm_device_add_group(group);
@@ -645,6 +650,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    group_was_added = true;
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
@@ -652,35 +658,34 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (bcontainer->error) {
         error_propagate_prepend(errp, bcontainer->error,
             "memory listener initialization failed: ");
-        goto listener_release_exit;
+        goto fail;
     }
 
     bcontainer->initialized = true;
 
     return true;
-listener_release_exit:
-    QLIST_REMOVE(group, container_next);
-    vfio_kvm_device_del_group(group);
+
+fail:
     memory_listener_unregister(&bcontainer->listener);
-    if (vioc->release) {
+
+    if (group_was_added) {
+        QLIST_REMOVE(group, container_next);
+        vfio_kvm_device_del_group(group);
+    }
+    if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
-
-enable_discards_exit:
-    vfio_ram_block_discard_disable(container, false);
-
-unregister_container_exit:
-    vfio_cpr_unregister_container(bcontainer);
-
-free_container_exit:
-    object_unref(container);
-
-close_fd_exit:
-    close(fd);
-
-put_space_exit:
+    if (discard_disabled) {
+        vfio_ram_block_discard_disable(container, false);
+    }
+    if (new_container) {
+        vfio_cpr_unregister_container(bcontainer);
+        object_unref(container);
+    }
+    if (fd >= 0) {
+        close(fd);
+    }
     vfio_put_address_space(space);
-
     return false;
 }
 
-- 
1.8.3.1


