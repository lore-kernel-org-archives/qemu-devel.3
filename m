Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7227AC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UF-0003XI-HK; Wed, 02 Jul 2025 17:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UD-0003Wj-Oo
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UB-0003jD-Qy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdff007914;
 Wed, 2 Jul 2025 21:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=WZOc13eWyibxucEb2szeMT0WOvqZfOBclzkvdwbNsj0=; b=
 X9xOyFCW+NGE06JfiqdmMvi301lGyFwei5hLc+UZH5WWr3a4Ig0aX4iCC7ep3eR4
 aAjCJxJJP1oX9NuYqDSHwOynSFMK8pc/cuuAAhKkUKF6fwS/7woBqpHKKTVRWSH4
 dvhtPbG9Xmy1N214h/8u72G+qojTbfE4bqRXi0VjUQFVzBpxgAsXYDjfinETKgSi
 fWjIMoDbsEfesDyiPYAMx72gNpGehdE8Glg+/VQlxfyX5OZZsM8TlYy3A94JhdjK
 UmTjd0jNqCSNXuT/MKRqFSq/v4CjwUf5E7IT6SobOx6/lVl18KkubVfMPQ+XAvwO
 O2on4wd6Qri/g/BomPxn8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af7vh5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562KRI8t033624; Wed, 2 Jul 2025 21:59:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:10 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgM020012;
 Wed, 2 Jul 2025 21:59:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-15; Wed, 02 Jul 2025 21:59:09 +0000
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
Subject: [PATCH V6 14/21] vfio/iommufd: cpr state
Date: Wed,  2 Jul 2025 14:58:51 -0700
Message-Id: <1751493538-202042-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-ORIG-GUID: LB58geWSs6hV3EVR5dHSvdlPrQrLNf6n
X-Proofpoint-GUID: LB58geWSs6hV3EVR5dHSvdlPrQrLNf6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MSBTYWx0ZWRfX6/LlfwShBvTo
 6IXHTurtC+GRqd5jPH0PTPBZ6ZpyRksWlX5H3C25+ronazzpfua/O4RRfYGmR7ShV3rV0724PNp
 165+gI4JCbhu6i8MXtsxPTGbXoVhrmDC23+qo20pIwBY8QkKVAdbpiy3K/IG/sfLG0IeNOruI3O
 m3tn0mei/+xrcIVw1/aaMQh+fNH5Ywp0zbrRsfxub+Y10G9ai0nCDsLQv/BoaViptAq+WIXsi1l
 wxetW/hw0SzLt2YjoJfXKrCAExeA8MH1+GYD+pTOVmqMFg8SFFfgL/6OIgkn9qSYjD1WqfxR7MF
 YpX/hKp08W7he5OOVxxXRdcuqkxHpgajeGjwUpDaugi8sjdN/JbFEThAVYGa6hvB3IW1SnSahyK
 3TuZC3cDC/7YdBIYeWZmjk22hpVxIAB3y8NgzaW1yWts13A7Y5nCwMqpjCDJMkT1w20/GrZx
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=6865abaf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=VOZiMoB78o4PvpBx7BoA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-cpr.h |  3 ++
 hw/vfio/cpr-iommufd.c      | 98 +++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c          |  2 +
 hw/vfio/trace-events       |  3 ++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index c94d5e0..4c17cb3 100644
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
index f95773b..4166201 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -7,14 +7,98 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
 #include "migration/blocker.h"
 #include "migration/cpr.h"
 #include "migration/migration.h"
 #include "migration/vmstate.h"
 #include "system/iommufd.h"
 #include "vfio-iommufd.h"
+#include "trace.h"
 
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
+        trace_vfio_cpr_find_device(elem->ioas_id, elem->devid, elem->hwpt_id);
+        return true;
+    }
+    return false;
+}
 
 static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
 {
@@ -81,8 +165,20 @@ void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
 
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
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e1728c4..8ec0ad0 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -197,6 +197,9 @@ iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD con
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
 
+# cpr-iommufd.c
+vfio_cpr_find_device(uint32_t ioas_id, int devid, uint32_t hwpt_id) "ioas_id %u, devid %d, hwpt_id %u"
+
 # device.c
 vfio_device_get_region_info_type(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_device_reset_handler(void) ""
-- 
1.8.3.1


