Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA24EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 14:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uArIF-0003AO-Lb; Fri, 02 May 2025 10:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHu-00037v-Od
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uArHs-0008Q0-7U
 for qemu-devel@nongnu.org; Fri, 02 May 2025 10:22:50 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WBJ0002723;
 Fri, 2 May 2025 14:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Yj5vi/3xvJQXg2gLwubdyqinJVWZCDtrqHxqw1r//VQ=; b=
 QaHCO9TAXNrZh7MlJPMZrJQZ2x0MiZ3T4yfCazeIcswUw/9WLowQKB0anyRbd6yc
 XA/N0SyXUqfCDU2SYEJCOqylRsed4Y+dIvxlSHC81KeyBezt3BWD48DR0qnaeIOB
 UXYwdMyeLvuu42jYCulhH+91Rih582M/2gDdjDRo5JRwVQySd8ESEMeVmdXlRams
 CEZ357+mtUt5x+yXB6S26gy1Dbee9n/JgPwA73q7gpb/TPEHy4KLGtuAhgWJWdU2
 P+mFlO11UDYKCn3d1ycupZYsXzvu4mmIcrUvs/2CUVMxvNw3Ur5PvLkdO/C6XEzN
 vRyoPRJbnIy59SJf8KQI9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uundg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 542DZJPD023740; Fri, 2 May 2025 14:22:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxm33pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 14:22:43 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 542EIQwq039705;
 Fri, 2 May 2025 14:22:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 468nxm33ng-3; Fri, 02 May 2025 14:22:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/3] vfio/container: reform vfio_container_connect cleanup
Date: Fri,  2 May 2025 07:22:39 -0700
Message-Id: <1746195760-101443-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
References: <1746195760-101443-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDExNCBTYWx0ZWRfX71syGncC3nL5
 sS2dQ2WDq8pfGUlLk99t1usCxH9SVpRGCJp85653RLc5sA1wHIHR0yP4T51r5ILgXJ0eGvjHVvE
 +GTFpKTaTfyRoq5iJv2ckrgssmg9PQxLVIYmiL8ZBx6WkQ5UrE2ijw91NffTbOVmVj8LYyoIB22
 8lNldYbjBphUD2W4nEi9BjpfSfumv6TcPI6v3xTnXmmedA7JDqFR9V+uyPMLDuyaS9eqvth5nga
 17X6/LptNn3hG07MGymjm5+hdMpSAMFcEjRvmFDF/zmshIpcREaIriHJGqtisqGxQlKqOVszEQc
 I+CZvI5efb0GJanSSThewhz2RP414/91hIkZdKSXBLjsw7m4XmGMuTrUTL+P58vq5kmbdrG3y8V
 JlBUGz+C1E280hq7JOdZzlZDLboxNCoPIeCxiyFlurGUx/Y6S7x9U89njjSL12zIRgk7mMsa
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=6814d534 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=zRH-A_WAcChkXfh64xYA:9
 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: GJmzDgpjJYYlRoDifldWymaNeBNe_j8r
X-Proofpoint-GUID: GJmzDgpjJYYlRoDifldWymaNeBNe_j8r
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Replace the proliferation of exit labels in vfio_container_connect with
conditionals for cleaning each piece of state.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cedric Le Goater <clg@redhat.com>
---
 hw/vfio/container.c | 60 +++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bf4bbd2..26433ae 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -563,9 +563,12 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
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
 
     space = vfio_address_space_get(as);
 
@@ -584,35 +587,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
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
 
     vfio_group_add_kvm_device(group);
@@ -621,35 +626,36 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     group->container = container;
     QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    group_was_added = true;
 
     if (!vfio_listener_register(bcontainer, errp)) {
-        goto listener_release_exit;
+        goto fail;
     }
 
     bcontainer->initialized = true;
 
     return true;
-listener_release_exit:
-    QLIST_REMOVE(group, container_next);
-    vfio_group_del_kvm_device(group);
+
+fail:
     vfio_listener_unregister(bcontainer);
-    if (vioc->release) {
+
+    if (group_was_added) {
+        QLIST_REMOVE(group, container_next);
+        vfio_group_del_kvm_device(group);
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
     vfio_address_space_put(space);
 
     return false;
-- 
1.8.3.1


