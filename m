Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A35DC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27p-00030z-DB; Tue, 10 Jun 2025 12:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP156-0004Li-34
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP154-00068Y-Fr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:07 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXYZP026650;
 Tue, 10 Jun 2025 15:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=lg7CINerCXP/A+tZb16MVexCxoY8iHyNSVA+jer3ddQ=; b=
 kDXMTni++5Kytpc/e3fe/M9tkaxxeT56yNZ6ecYzYLAbkWICYZEBEXUuhKn2gOpZ
 2NeqcqrFXd53SMmIEqNWrRWDuF3lYU6v5CRzQGHukcZN6CfVsQdxFHfZYkO8au3W
 NjdoWI57xcFUPZE5Ntx0mSnrcbysepagW0nafKiy0lvBCW3o4ofN4+IRjYjQ+B3N
 Xd+H5t2SS8IJdx3JczGl3D7XtbfGJ5dnrmdYe4uNxiiNhcWFABQf/jUvjfgb4TlW
 8LFtCClzcRG2CCv454p2AaGTbM76Rh/vBMGlHYJvPbSXRuHqJOyC1WvKJOy2NyMM
 lBDDtg9u4/QvSo0kurMSyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjuwm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEbn3d004100; Tue, 10 Jun 2025 15:40:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wasy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfL028825;
 Tue, 10 Jun 2025 15:40:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-8; Tue, 10 Jun 2025 15:40:02 +0000
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
Subject: [PATCH V5 07/38] vfio/container: mdev cpr blocker
Date: Tue, 10 Jun 2025 08:39:20 -0700
Message-Id: <1749569991-25171-8-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684851d3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=tZdlq9DgnolhYxeEkKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXzqGe4hkjmaxC
 ne3/O55Q+YCcEfSL5W9H0gnT1IZmPBZuYxqz1f/AudzLEZuvq93J1DAsXHIaCJKTPo8B52Lqkp3
 D+PibO4S6j5EWxhXfTSgxuzciE5i6W57dcRoLqJdWjhQYVpyps12f2BxKlUTaQffJhyGKDQ7o6K
 qtOJalWE1HoeviAipizOHxG4Z1fdU8s+nILfZnpb027Hqjvjw6Duvx1wt169HAxc1OxhdCLLPdB
 Zd1dN51l+0e/XmzQ7PEYSNXCAgZ7iZgoRt4zFOjaMUeEdhFOiDgUuMWbaXyKMu3ukdCzeFXuhH2
 4dYqnqNhhoFFziEUnkFTJl9XRLUfJmgCjoAGgnyqw53FJcGCUM1MK0MnzDAmDkhHZJBYjl33u5N
 /R/Cr9IYCc53MEG9pJlqrNexSsQQbcP+yB27HtkUJHzaHqTewbNSB6xE78lov+rk+tRFpe05
X-Proofpoint-ORIG-GUID: sVItzSKKtldNDOVuLgmAaMYy66Q3-JgW
X-Proofpoint-GUID: sVItzSKKtldNDOVuLgmAaMYy66Q3-JgW
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

During CPR, after VFIO_DMA_UNMAP_FLAG_VADDR, the vaddr is temporarily
invalid, so mediated devices cannot be supported.  Add a blocker for them.
This restriction will not apply to iommufd containers when CPR is added
for them in a future patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h    | 3 +++
 include/hw/vfio/vfio-device.h | 2 ++
 hw/vfio/container.c           | 8 ++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 0462447..b83dd42 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -22,6 +22,9 @@ typedef struct VFIOContainerCPR {
                          void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
+typedef struct VFIODeviceCPR {
+    Error *mdev_blocker;
+} VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
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
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 936ce37..3e8d645 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -987,6 +987,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         goto device_put_exit;
     }
 
+    if (vbasedev->mdev) {
+        error_setg(&vbasedev->cpr.mdev_blocker,
+                   "CPR does not support vfio mdev %s", vbasedev->name);
+        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
+                                  MIG_MODE_CPR_TRANSFER, -1);
+    }
+
     return true;
 
 device_put_exit:
@@ -1004,6 +1011,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 
     vfio_device_unprepare(vbasedev);
 
+    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
-- 
1.8.3.1


