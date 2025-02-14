Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A22AC021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSs-0004OV-Rt; Fri, 14 Feb 2025 09:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSq-0004NV-QK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSo-0004Rx-Tm
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:44 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtqaR022708;
 Fri, 14 Feb 2025 14:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=BI7xHpN3QRFQfxooh96sk1xXdkB6bvKSbO1XC86F69Q=; b=
 N6KDb12HyhiQy3ccdt7YHvQi0sBQAGyCECtK73voIbZq/8WA3igA6gCuMh5lcWJw
 4A3AP7m5jFzZd72PCU14yd/4PcxfwGgP9m3VtcbGmX/Wie1yJV5bX20QNNOk1bEn
 7+Vlc7/2pReQLnIU+fmtHBhDO5edcd72M09EbNQ8b1cnexFmhdvmJay48YimcLR4
 XjK4pwFPWldbwt431giMKR615GyY5dat113uiUn64zhiH9f5ZjIKfqREWmp31DbA
 ZX+XrMNlUajSDCJR2Th4IoYxJs+zQunUYaEGZMKcWmkKYnpubADVyTVNFxxtlE+L
 VwfkaFJyy6kYfdUc/+7STQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s43q6h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECwW5o025139; Fri, 14 Feb 2025 14:14:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPR006920;
 Fri, 14 Feb 2025 14:14:38 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-8; Fri, 14 Feb 2025 14:14:38 +0000
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
Subject: [PATCH V2 07/45] vfio/container: vfio_container_group_add
Date: Fri, 14 Feb 2025 06:13:49 -0800
Message-Id: <1739542467-226739-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: YKVcgwofVQIBWbk4x06DcaBUnYSsZKpN
X-Proofpoint-ORIG-GUID: YKVcgwofVQIBWbk4x06DcaBUnYSsZKpN
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

Add vfio_container_group_add to de-dup some code.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c668d07..c5bbb03 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -582,6 +582,26 @@ static bool vfio_attach_discard_disable(VFIOContainer *container,
     return !ret;
 }
 
+static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
+                                     Error **errp)
+{
+    if (!vfio_attach_discard_disable(container, group, errp)) {
+        return false;
+    }
+    group->container = container;
+    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    vfio_kvm_device_add_group(group);
+    return true;
+}
+
+static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
+{
+    QLIST_REMOVE(group, container_next);
+    group->container = NULL;
+    vfio_kvm_device_del_group(group);
+    vfio_ram_block_discard_disable(container, false);
+}
+
 static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                    Error **errp)
 {
@@ -592,20 +612,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOIOMMUClass *vioc = NULL;
     bool new_container = false;
     bool group_was_added = false;
-    bool discard_disabled = false;
 
     space = vfio_get_address_space(as);
 
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
-            if (!vfio_attach_discard_disable(container, group, errp)) {
-                return false;
-            }
-            group->container = container;
-            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
-            vfio_kvm_device_add_group(group);
-            return true;
+            return vfio_container_group_add(container, group, errp);
         }
     }
 
@@ -632,11 +645,6 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    if (!vfio_attach_discard_disable(container, group, errp)) {
-        goto fail;
-    }
-    discard_disabled = true;
-
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
@@ -644,12 +652,11 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
 
-    vfio_kvm_device_add_group(group);
-
     vfio_address_space_insert(space, bcontainer);
 
-    group->container = container;
-    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
+    if (!vfio_container_group_add(container, group, errp)) {
+        goto fail;
+    }
     group_was_added = true;
 
     bcontainer->listener = vfio_memory_listener;
@@ -669,15 +676,11 @@ fail:
     memory_listener_unregister(&bcontainer->listener);
 
     if (group_was_added) {
-        QLIST_REMOVE(group, container_next);
-        vfio_kvm_device_del_group(group);
+        vfio_container_group_del(container, group);
     }
     if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
-    if (discard_disabled) {
-        vfio_ram_block_discard_disable(container, false);
-    }
     if (new_container) {
         vfio_cpr_unregister_container(bcontainer);
         object_unref(container);
-- 
1.8.3.1


