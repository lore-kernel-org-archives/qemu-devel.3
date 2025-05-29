Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE25C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKit6-0005Jw-OB; Thu, 29 May 2025 15:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisP-0004CN-Rj
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisN-0000T7-Sl
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfpFp020656;
 Thu, 29 May 2025 19:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VNfieDHLDnPmQUfT7Q3ZHKIwOL28O3CeZwUGaBMR++I=; b=
 YvNP9PfFbeNf/5dbQHPmQb0RYRk0iz5sXyQRAgBc6STs3/FFVqyl5oxNx6cgULKU
 kdb7S9K4eAO+ppJh9z2Tqg0S1mkrNm+1GyWcfJwqPxj2QfrJhHoVphXLNMH87lkt
 oSCrobKTWrzWO0ZdV+ieyAjJ/Oy8uOO6KvejXL5pGPoJ+1N6XZ6ciiI0eajMKFJt
 fksm6/2FFnLNjO4rjc6CqTd9/AWblh3J5DHV2ZB4G8ZgN/i9nbpWig/wi5Y1vsV1
 3ailtsuxUR5MUNZ47lILSPkY0GxHvK+P+5OEuZYOzNbMFogR5PUeu/iQq4upFYqz
 obWog2HL4Ym7rEqYtW7MwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46wjbcmww6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJOTT2020393; Thu, 29 May 2025 19:25:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeS1022158;
 Thu, 29 May 2025 19:25:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-38; Thu, 29 May 2025 19:25:11 +0000
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
Subject: [PATCH V4 37/43] vfio/iommufd: cpr state
Date: Thu, 29 May 2025 12:24:33 -0700
Message-Id: <1748546679-154091-38-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: RAob8Ri6Vp8pOUGtY4pkBcRCD_O1nB9u
X-Proofpoint-ORIG-GUID: RAob8Ri6Vp8pOUGtY4pkBcRCD_O1nB9u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX1NquzHTVjvkI
 8da+arcXD3kBXEt7EJ6AQkTiVhKlVbkvkfyXzbv7PrntwB7hmplo4dWUqweAyFFo7v/11V7G1+C
 RgEHOe3n66kg8fHPJifQf3Q/VyK4Zirq07EP86zOxBdLyO5VwgfyO/xxpK2nN8qK/f4IQFjt2Hh
 6BZXE1OHEcjzrfJJGLLZePi/yBvyD2jm38FNHy5cYK1BvFL3u6VcSfPP6tAxLu+ErLriOzIxDl+
 AM7MA0pjlaqhvhkneZHb37dUtsJ/H2SkZAx14036bcKmImGf9/F+NZPmBnRaNQMaNTYhkmNVF6g
 LLK7Z05ZFZDNMI/kpeFx9Ri5gJB8WtxcU0CSFMfe04BFORKMLgza0L1A8CWEEZCFYIk8yuTe0Bb
 UdsEGK7GzeYgAVZWVq6Tz53lYGsSzo34rTFbYnx23iUMbKQkTxbC5rYnKzINw7ZXN7mrgUTm
X-Authority-Analysis: v=2.4 cv=c8qrQQ9l c=1 sm=1 tr=0 ts=6838b499 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ATNqwdPFLO-6k9L18g8A:9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
index c690c2c..1fd383e 100644
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


