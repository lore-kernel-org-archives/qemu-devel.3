Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B175C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwT0-0004XU-2m; Fri, 14 Feb 2025 09:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSy-0004TB-Bs
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSw-0004T6-Om
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECu5LP019631;
 Fri, 14 Feb 2025 14:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=EtO+YcVnjLnfL11cilvDpps4BNkrAowKYxHloaLP1mw=; b=
 RwuKO06CF3rlxK8PbuWs87zGQbIPY7vaAe9RroUIh5lp1cZtWdsdHd58xLIKgXdX
 u5im8NMtz40IrsdGpFj14Gu8zrG2vbzvDn7t8xpnArVMSLys9je9sRVjhKnyin1d
 cPi52x8XHiAxrl+iFgh+t93c4JJMX54ESJzEqHliZBpwJ2P5Ais0UTmqWQ3mAYae
 U1hsSj74HrNacVKQokzcUPpw/hPG9JOK7EUNrjkFyqdslAcc75rsnm6cEerOGuyj
 dxLwXr8LSbbPbCIQELBP5oodvaXLOfShZnT9HYXVworJNRIB/VmZnw5hI9kUu739
 6BcX/0AIAi8zyHNiur6+EQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t4bmuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:48 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECO40Q025170; Fri, 14 Feb 2025 14:14:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPd006920;
 Fri, 14 Feb 2025 14:14:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-14; Fri, 14 Feb 2025 14:14:46 +0000
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
Subject: [PATCH V2 13/45] vfio/container: mdev cpr blocker
Date: Fri, 14 Feb 2025 06:13:55 -0800
Message-Id: <1739542467-226739-14-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 4QRSWsh1ny2SdqA5hi92l0ZweJZmPn8j
X-Proofpoint-GUID: 4QRSWsh1ny2SdqA5hi92l0ZweJZmPn8j
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

During CPR, after VFIO_DMA_UNMAP_FLAG_VADDR, the vaddr is temporarily
invalid, so mediated devices cannot be supported.  Add a blocker for them.
This restriction will not apply to iommufd containers when CPR is added
for them in a future patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c        | 8 ++++++++
 include/hw/vfio/vfio-cpr.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index d26f78e..8130d1f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -999,6 +999,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
+    if (vbasedev->mdev) {
+        error_setg(&vbasedev->cpr.mdev_blocker,
+                   "CPR does not support vfio mdev %s", vbasedev->name);
+        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
+                                  MIG_MODE_CPR_TRANSFER, -1);
+    }
+
     bcontainer = &group->container->bcontainer;
     vbasedev->bcontainer = bcontainer;
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
@@ -1015,6 +1022,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->bcontainer = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
+    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 1a3eee9..25ac944 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -17,6 +17,7 @@ typedef struct VFIOContainerCPR {
 
 typedef struct VFIODeviceCPR {
     bool reused;
+    Error *mdev_blocker;
 } VFIODeviceCPR;
 
 struct VFIOContainer;
-- 
1.8.3.1


