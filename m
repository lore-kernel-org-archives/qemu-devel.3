Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C87BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZC-0007Jj-Mb; Sat, 20 Jul 2024 15:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFZ5-0006vc-Bu
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFZ2-0000ri-4T
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJF2Il016270;
 Sat, 20 Jul 2024 19:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=PrZpKjn22NnTRu3L/ZRkY8HK9ZTK3ILIUp25NlJXXPY=; b=
 RyXbMPMglk9zbN+z45Qpfr+qZJBsRw1tylEZFJE9BIifzQ81A6vxvtnm98VFY2KW
 il1QPw4Ni+LRDHDU5Pg/Vp8PJliTQt8mJ3sYITUelAepT2MZ89QO4WWpSOsR/p/M
 dLh5ip4FiMpQPzhLhsnAQxBmG5sggLlrwnpJGrFfaJpGPVl9wUK1k2C8SQz+h3mc
 yZmKcyTp+7z4SGng/7sU5uub+BfNpobjOc6mMsRT+nVl7RuByWwq5tf2rkpddJxI
 Ik0FTIiIPIPiQ9zv7huBnnNaeIlg6X4WBESJilouReI+OVX1M4dUi+1XRqICr7sD
 3sLMNdwWPm8bIIx9xFvneA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk7w000g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI06tt027423; Sat, 20 Jul 2024 19:15:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5pux3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfP028365;
 Sat, 20 Jul 2024 19:15:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-13; Sat, 20 Jul 2024 19:15:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 12/12] vfio: mdev blocker
Date: Sat, 20 Jul 2024 12:15:37 -0700
Message-Id: <1721502937-87102-13-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-ORIG-GUID: rF5Tpq8KAvljSnaTMrZxdy-CV-FxPcgV
X-Proofpoint-GUID: rF5Tpq8KAvljSnaTMrZxdy-CV-FxPcgV
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Block CPR if the container has any mdevs (mediated devices).  CPR is not
supported for legacy containers and mdevs.  It will be supported for iommufd
containers with mdevs in a future patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c                         | 10 ++++++++++
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b5e7592..872b07c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3100,6 +3100,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
     free(subsys);
 
+    vbasedev->is_mdev = is_mdev;
+    if (is_mdev && !vbasedev->bcontainer->n_mdev++) {
+        error_setg(&vbasedev->bcontainer->cpr_mdev_blocker,
+                   "CPR does not support vfio mdev");
+        migrate_add_blocker_modes(&vbasedev->bcontainer->cpr_mdev_blocker,
+                                  &error_fatal, MIG_MODE_CPR_EXEC, -1);
+    }
     trace_vfio_mdev(vbasedev->name, is_mdev);
 
     if (vbasedev->ram_block_discard_allowed && !is_mdev) {
@@ -3387,6 +3394,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
+    if (vbasedev->is_mdev && !--vbasedev->bcontainer->n_mdev) {
+        migrate_del_blocker(&vbasedev->bcontainer->cpr_mdev_blocker);
+    }
     vfio_migration_exit(vbasedev);
     pci_device_unset_iommu_device(pdev);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8aa02d4..342c40f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -133,6 +133,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    bool is_mdev;
     HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f8b7b26..e29cbb8 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -45,6 +45,7 @@ typedef struct VFIOContainerBase {
     uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
+    unsigned int n_mdev;
     bool dirty_pages_supported;
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
@@ -54,6 +55,7 @@ typedef struct VFIOContainerBase {
     NotifierWithReturn cpr_reboot_notifier;
     NotifierWithReturn cpr_exec_notifier;
     Error *cpr_blocker;
+    Error *cpr_mdev_blocker;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
-- 
1.8.3.1


