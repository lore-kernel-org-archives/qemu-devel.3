Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24486C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisJ-00048g-Nc; Thu, 29 May 2025 15:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisF-00044q-Hs
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisD-0000E2-6C
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:07 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfrBo022000;
 Thu, 29 May 2025 19:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=LjOlRnzzAvVSh7DCEMQZVpCSwfDNvAhjj64jzgIaMQ0=; b=
 K7upH25yMG5SADq7SmWr8N5K2gkwkEwOx18v9P32Pn6BOWG7AWm+rEDMhc5r8BC2
 0OPJOQcN7K/krwHdZiaFQ4PjH6aV3FB2lBWumxGmZfUBE/TZqdEbkEZ4ZccJ+UdA
 Uvd5gt95ry9/nyZUwvz6C7yxk8g1tkrCTTIqguYUDHdCpOyglmWdmxCrUprcqRx1
 oKMovxoW9IW6T/7kcq4/WtI19bhETOSrVjdq/3J8vUvXIT71XPfnPEqhNfomvmxR
 sxabY85rp+5sqLmoD9OcpChj99oSIIxE3F9+H3KsIkuTSe4KSMDBwEQsZGkt76dm
 t8J5Um23ZDmSZmikGPT9tQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12j9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THhwH0020358; Thu, 29 May 2025 19:24:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRD022158;
 Thu, 29 May 2025 19:24:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-14; Thu, 29 May 2025 19:24:51 +0000
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
Subject: [PATCH V4 13/43] vfio/container: mdev cpr blocker
Date: Thu, 29 May 2025 12:24:09 -0700
Message-Id: <1748546679-154091-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: YHRH6SUDdE1chCHhB6a6VEvaofsk4Toj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX/7xRLkg+/NIC
 bgfs1pk3wgTsgE0HS0oOw/zKXKsdm+FLh40hymmP8LZlxZk0g8uZAvESPhr8bPScUvNHL1ghmeT
 pqtm/5C5W6Uj/IHR/dpqbNXVnGeyNy2JL3eW5PDvIOyVLlOWcFqtVJOK+utACPa1ypSNMD7eiwA
 JCbU31aT78FQ2dQkKhq/h5M4idXxlvJ8xmCwo+FdsSCgqPvGOmpnzpAK2+0YoJwJKed1GTU2dCH
 bsiv/xZjOjCpjS/KoNtdGHrzh+Gy5HnKHfsW2xirY5Cy9Bi6enYDyI+GMIbjsmRShmLmNmLCDyW
 SPFxE2Ql4VY/NSBTbVKAGQJERjdphje4zEyoMCQWzMmKy6MMz4wjDjTg43u/w9tU3F8WtTuT/SH
 W02NXKKbyVijcULe4e5a/hOtAa93LX2/dcJ/0OJiHW1MkrRr7CyklvJ/GBqEw8XWxf0yQfAj
X-Proofpoint-ORIG-GUID: YHRH6SUDdE1chCHhB6a6VEvaofsk4Toj
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b484 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=tZdlq9DgnolhYxeEkKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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
index f91f2d5..f801a0d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -988,6 +988,13 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
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
@@ -1005,6 +1012,7 @@ static void vfio_legacy_detach_device(VFIODevice *vbasedev)
 
     vfio_device_unprepare(vbasedev);
 
+    migrate_del_blocker(&vbasedev->cpr.mdev_blocker);
     object_unref(vbasedev->hiod);
     vfio_device_put(vbasedev);
     vfio_group_put(group);
-- 
1.8.3.1


