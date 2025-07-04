Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F09C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc47-0008Vj-TW; Fri, 04 Jul 2025 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc44-0008OB-V9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc42-00013O-PW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g522b//I6zPH1mnEyR7Hwc51XyvTjb1tOQ42jXQ8atw=;
 b=hIBAll5x4gR9G9YlbRqaY5jETaR3wD6G7Vxy16PTA5Ly4MZHEJ1ULCBCy8+ZN5qBsz2BfH
 wRJQSHc/f1dMh5xw4yL5H+lAFVLfmKoqi3IN742EBHoyaVUCJBkbNsc/0PSif3OmZIldZ1
 M3MTJA1Be+D7hixpeS8BLNB0Cdf3GFs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-uWz6ndk2NAScZiLsDed3_g-1; Fri,
 04 Jul 2025 04:46:30 -0400
X-MC-Unique: uWz6ndk2NAScZiLsDed3_g-1
X-Mimecast-MFC-AGG-ID: uWz6ndk2NAScZiLsDed3_g_1751618789
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ED711808985; Fri,  4 Jul 2025 08:46:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5C4A19560A7; Fri,  4 Jul 2025 08:46:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/27] vfio/iommufd: cpr state
Date: Fri,  4 Jul 2025 10:45:21 +0200
Message-ID: <20250704084528.1412959-21-clg@redhat.com>
In-Reply-To: <20250704084528.1412959-1-clg@redhat.com>
References: <20250704084528.1412959-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

VFIO iommufd devices will need access to ioas_id, devid, and hwpt_id in
new QEMU at realize time, so add them to CPR state.  Define CprVFIODevice
as the object which holds the state and is serialized to the vmstate file.
Define accessors to copy state between VFIODevice and CprVFIODevice.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-15-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  3 ++
 hw/vfio/cpr-iommufd.c      | 98 +++++++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c          |  2 +
 hw/vfio/trace-events       |  3 ++
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 286e3d4e9a7497b3ba279d990449e71db676ec39..287837249589e269f87e33ba2635e8682a764e82 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -34,6 +34,8 @@ typedef struct VFIOContainerCPR {
 typedef struct VFIODeviceCPR {
     Error *mdev_blocker;
     Error *id_blocker;
+    uint32_t hwpt_id;
+    uint32_t ioas_id;
 } VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
@@ -55,6 +57,7 @@ bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be, Error **errp);
 void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
 void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
 void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
+void vfio_cpr_load_device(struct VFIODevice *vbasedev);
 
 int vfio_cpr_group_get_device_fd(int d, const char *name);
 
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index f95773b02c84f2ce8e27c49165b6ad68c4bc2328..4166201e3f70441ff97aef23c3b6f8bf506c76ad 100644
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
+
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
 
-const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later patch */
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
index ff291be2356d1a2f59aa6dc7953dc3fc00a627bd..f0d57ea65f148063ec2022e2321fd1d970494779 100644
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
index e1728c4ef64acfc4a377dfc4711cad35c03a51b7..8ec0ad0cde064927f58fbd8459413b303d155979 100644
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
2.50.0


