Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC539C71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27c-0002Ea-1X; Tue, 10 Jun 2025 12:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15l-0004Yg-Ml
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15h-0006F7-Vg
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:47 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXihr029127;
 Tue, 10 Jun 2025 15:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=r6A5+OF62LeohAfBcd51nbDzIFuPmkRdgwCUIqNR6s8=; b=
 ZX8rq4I/84aaaF7B4FENOzn+ZkVtQBdLMoJCzRsaKmjbyr5El0k6kOFA1r76xdC6
 Hb11eS7Yv/nWU7mMS3mGJ4+//eIIf7qnN02FSF/UWopGhlIMsJo53/z/5X/8jgzn
 bneJ5YlU5kPaOQbog+1iYtcGtgpFBdfGUsLqwvoax2S5ueErOOgLpIxQLMmEOXYI
 l2gtcTfqUQ0COsQwp1I/S9IzOqBUpEQqsmjHIx10jmT7SGROh18vIRb1wOxQU8e4
 oYcrS675dIdWMZ2EA1K81aOHMf4xLkFHgqcXK3MWIt1S+LQC7/WbB3lC2J/WS6ZS
 lbPzUzIvjO9hkTv1Uqr3Ig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v4jgp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF0Xvv003202; Tue, 10 Jun 2025 15:40:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:42 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrg9028825;
 Tue, 10 Jun 2025 15:40:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-32; Tue, 10 Jun 2025 15:40:41 +0000
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
Subject: [PATCH V5 31/38] vfio/iommufd: cpr state
Date: Tue, 10 Jun 2025 08:39:44 -0700
Message-Id: <1749569991-25171-32-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: qiB-bR90FlPeiWi0kb-eIqjEguCuUdCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX+yZrIYv7jNGV
 jG3n4DFcyCJ4SCbpmxPCzZTaquX6YEc1nzDBXh2+6vVdPyYqXm+DSqdZF2012a1sj3Au1f6bOGH
 xrln0vJT7UX04tpx3YVoTgvFpEnX+qKaKu03XGuRYNqyhGzZtLWuBMTihZnBYvqrBoDzRQGEPBo
 D4XIuP2UE+hBmcB2i0T9kwitWWWbRp8gkfiiKXZt9sXq7gA5Aon6nl43NZYUtUFvGU446xVsuvw
 Q6Xunnf+fhOzps7P1EE+pPtvdS9teq3ZA6GzpQP1EXPt5zlTxSW/E3Sh2BdY346GqmEWD5TCBAl
 hFeKdJu3CFJJnvHZaf5nYEcxV+mcwguFtjItzoxH6eN0ZCEAmb13i4lcDiEOt9Vl5meorkCi3AR
 mlAT56ogCy6jT5iKo5uBHM5ZypCc+DIXKFYjfMrPEPXm+vWZrjh7pf6VH4UeMfo70ETI3RB+
X-Proofpoint-ORIG-GUID: qiB-bR90FlPeiWi0kb-eIqjEguCuUdCG
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684851fb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=ATNqwdPFLO-6k9L18g8A:9 cc=ntf
 awl=host:14714
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

VFIO iommufd devices will need access to ioas_id, devid, and hwpt_id in
new QEMU at realize time, so add them to CPR state.  Define CprVFIODevice
as the object which holds the state and is serialized to the vmstate file.
Define accessors to copy state between VFIODevice and CprVFIODevice.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-cpr.h |  3 ++
 hw/vfio/cpr-iommufd.c      | 96 +++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c          |  2 +
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 619af07..f88e4ba 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -33,6 +33,8 @@ typedef struct VFIOContainerCPR {
 typedef struct VFIODeviceCPR {
     Error *mdev_blocker;
     Error *id_blocker;
+    uint32_t hwpt_id;
+    uint32_t ioas_id;
 } VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
@@ -54,6 +56,7 @@ bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
 void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
 void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
+void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 3e78265..2eca8a6 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -7,6 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
@@ -14,7 +15,88 @@
 #include "system/iommufd.h"
 #include "vfio-iommufd.h"
 
-const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
+typedef struct CprVFIODevice {
+    char *name;
+    unsigned int namelen;
+    uint32_t ioas_id;
+    int devid;
+    uint32_t hwpt_id;
+    QLIST_ENTRY(CprVFIODevice) next;
+} CprVFIODevice;
+
+static const VMStateDescription vmstate_cpr_vfio_device = {
+    .name = "cpr vfio device",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(namelen, CprVFIODevice),
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprVFIODevice, 0, NULL, namelen),
+        VMSTATE_INT32(devid, CprVFIODevice),
+        VMSTATE_UINT32(ioas_id, CprVFIODevice),
+        VMSTATE_UINT32(hwpt_id, CprVFIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = CPR_STATE "/vfio devices",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]){
+        VMSTATE_QLIST_V(vfio_devices, CprState, 1, vmstate_cpr_vfio_device,
+                        CprVFIODevice, next),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void vfio_cpr_save_device(VFIODevice *vbasedev)
+{
+    CprVFIODevice *elem = g_new0(CprVFIODevice, 1);
+
+    elem->name = g_strdup(vbasedev->name);
+    elem->namelen = strlen(vbasedev->name) + 1;
+    elem->ioas_id = vbasedev->cpr.ioas_id;
+    elem->devid = vbasedev->devid;
+    elem->hwpt_id = vbasedev->cpr.hwpt_id;
+    QLIST_INSERT_HEAD(&cpr_state.vfio_devices, elem, next);
+}
+
+static CprVFIODevice *find_device(const char *name)
+{
+    CprVFIODeviceList *head = &cpr_state.vfio_devices;
+    CprVFIODevice *elem;
+
+    QLIST_FOREACH(elem, head, next) {
+        if (!strcmp(elem->name, name)) {
+            return elem;
+        }
+    }
+    return NULL;
+}
+
+static void vfio_cpr_delete_device(const char *name)
+{
+    CprVFIODevice *elem = find_device(name);
+
+    if (elem) {
+        QLIST_REMOVE(elem, next);
+        g_free(elem->name);
+        g_free(elem);
+    }
+}
+
+static bool vfio_cpr_find_device(VFIODevice *vbasedev)
+{
+    CprVFIODevice *elem = find_device(vbasedev->name);
+
+    if (elem) {
+        vbasedev->cpr.ioas_id = elem->ioas_id;
+        vbasedev->devid = elem->devid;
+        vbasedev->cpr.hwpt_id = elem->hwpt_id;
+        return true;
+    }
+    return false;
+}
 
 static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
 {
@@ -79,8 +161,20 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 
 void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
 {
+    if (!cpr_is_incoming()) {
+        vfio_cpr_save_device(vbasedev);
+    }
 }
 
 void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
 {
+    vfio_cpr_delete_device(vbasedev->name);
+}
+
+void vfio_cpr_load_device(VFIODevice *vbasedev)
+{
+    if (cpr_is_incoming()) {
+        bool ret = vfio_cpr_find_device(vbasedev);
+        g_assert(ret);
+    }
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ff291be..f0d57ea 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -515,6 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     const VFIOIOMMUClass *iommufd_vioc =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
 
+    vfio_cpr_load_device(vbasedev);
+
     if (vbasedev->fd < 0) {
         devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
         if (devfd < 0) {
-- 
1.8.3.1


