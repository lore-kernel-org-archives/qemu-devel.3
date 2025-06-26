Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF51C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhJA-0004QB-GA; Thu, 26 Jun 2025 03:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJ3-0004Pr-0j
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUhJ0-0001wj-8C
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYaB4dUKOwAtubar7RX7PLoeMOj0N+gdeYw3pMcSMLw=;
 b=Fi1F/TXzIWSq9Nj31MzHVCTtX2gzGhcjbwig1+MGvok2iBcBfhmo6fsp5vcTTE7FPfEZY7
 XDmR5lgwtGpNm+UnGjtDycMSqdrydKe4f1ONBVlUQ0kbf/7VHL5AZdMrdOX0TerGXAm6RX
 +IVmfFwRCiZHP4Q+CEOwgn67hlTpOIA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-HsK8dw9pMYqv3PKX55Rsjw-1; Thu,
 26 Jun 2025 03:45:53 -0400
X-MC-Unique: HsK8dw9pMYqv3PKX55Rsjw-1
X-Mimecast-MFC-AGG-ID: HsK8dw9pMYqv3PKX55Rsjw_1750923952
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5ADF1800368; Thu, 26 Jun 2025 07:45:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C780818002B3; Thu, 26 Jun 2025 07:45:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/25] vfio-user: add vfio-user class and container
Date: Thu, 26 Jun 2025 09:45:11 +0200
Message-ID: <20250626074529.1384114-8-clg@redhat.com>
In-Reply-To: <20250626074529.1384114-1-clg@redhat.com>
References: <20250626074529.1384114-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Levon <john.levon@nutanix.com>

Introduce basic plumbing for vfio-user with CONFIG_VFIO_USER.

We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
container type for the "IOMMU" type "vfio-iommu-user", and share some
common container code from hw/vfio/container.c.

Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
sharing some common code from hw/vfio/pci.c.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250625193012.2316242-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                           |   8 +
 hw/vfio-user/container.h              |  21 +++
 include/hw/vfio/vfio-container-base.h |   1 +
 hw/vfio-user/container.c              | 208 ++++++++++++++++++++++++++
 hw/vfio-user/pci.c                    | 185 +++++++++++++++++++++++
 hw/Kconfig                            |   1 +
 hw/meson.build                        |   1 +
 hw/vfio-user/Kconfig                  |   7 +
 hw/vfio-user/meson.build              |   9 ++
 9 files changed, 441 insertions(+)
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 27f4fe3f2597cb9b5a28d825e965ed891e15d4f2..2369391004bc3637696a38d4fbb05fe317beb338 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4253,6 +4253,14 @@ F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
 F: tests/functional/test_multiprocess.py
 
+VFIO-USER:
+M: John Levon <john.levon@nutanix.com>
+M: Thanos Makatos <thanos.makatos@nutanix.com>
+S: Supported
+F: hw/vfio-user/*
+F: include/hw/vfio-user/*
+F: subprojects/libvfio-user
+
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
 R: Andrew Melnychenko <andrew@daynix.com>
diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
new file mode 100644
index 0000000000000000000000000000000000000000..e4a46d2c1b0f712cd7fc1ff62a65d889050de835
--- /dev/null
+++ b/hw/vfio-user/container.h
@@ -0,0 +1,21 @@
+/*
+ * vfio-user specific definitions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_USER_CONTAINER_H
+#define HW_VFIO_USER_CONTAINER_H
+
+#include "qemu/osdep.h"
+
+#include "hw/vfio/vfio-container-base.h"
+
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
+
+#endif /* HW_VFIO_USER_CONTAINER_H */
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f0232654eedf19c4d9c4f0ed55e79074442720c3..3cd86ec59e1a4605dea92fadeca5816145ae409b 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
new file mode 100644
index 0000000000000000000000000000000000000000..2367332177245e509842f9f0546f028e8a132c14
--- /dev/null
+++ b/hw/vfio-user/container.c
@@ -0,0 +1,208 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "qemu/osdep.h"
+
+#include "hw/vfio-user/container.h"
+#include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-listener.h"
+#include "qapi/error.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    return -ENOTSUP;
+}
+
+static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
+                             ram_addr_t size, void *vaddr, bool readonly,
+                             MemoryRegion *mrp)
+{
+    return -ENOTSUP;
+}
+
+static int
+vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
+                                    bool start, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+                                         VFIOBitmap *vbmap, hwaddr iova,
+                                         hwaddr size, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
+{
+    error_setg_errno(errp, ENOTSUP, "Not supported");
+    return -ENOTSUP;
+}
+
+static VFIOUserContainer *vfio_user_create_container(Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    return container;
+}
+
+/*
+ * Try to mirror vfio_container_connect() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_user_container_connect(AddressSpace *as, Error **errp)
+{
+    VFIOContainerBase *bcontainer;
+    VFIOUserContainer *container;
+    VFIOAddressSpace *space;
+    VFIOIOMMUClass *vioc;
+
+    space = vfio_address_space_get(as);
+
+    container = vfio_user_create_container(errp);
+    if (!container) {
+        goto put_space_exit;
+    }
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    assert(vioc->setup);
+
+    if (!vioc->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    vfio_address_space_insert(space, bcontainer);
+
+    if (!vfio_listener_register(bcontainer, errp)) {
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    object_unref(container);
+
+put_space_exit:
+    vfio_address_space_put(space);
+
+    return NULL;
+}
+
+static void vfio_user_container_disconnect(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    vfio_listener_unregister(bcontainer);
+    if (vioc->release) {
+        vioc->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_cpr_unregister_container(bcontainer);
+    object_unref(container);
+
+    vfio_address_space_put(space);
+}
+
+static bool vfio_user_device_get(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_device_attach: attach a device to a new container.
+ */
+static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_user_container_connect(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_device_get(container, vbasedev, errp);
+}
+
+static void vfio_user_device_detach(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    vfio_device_unprepare(vbasedev);
+
+    vfio_user_container_disconnect(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_device_attach;
+    vioc->detach_device = vfio_user_device_detach;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .instance_size = sizeof(VFIOUserContainer),
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
new file mode 100644
index 0000000000000000000000000000000000000000..86d705574736586a893feb529a057e799ae610c8
--- /dev/null
+++ b/hw/vfio-user/pci.c
@@ -0,0 +1,185 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qapi-visit-sockets.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/vfio/pci.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    SocketAddress *socket;
+};
+
+/*
+ * Emulated devices don't use host hot reset
+ */
+static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
+{
+    vbasedev->needs_reset = false;
+}
+
+static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
+{
+    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
+                                           device.vbasedev);
+
+    return OBJECT(vdev);
+}
+
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_pci_intx_eoi,
+    .vfio_get_object = vfio_user_pci_get_object,
+    /* No live migration support yet. */
+    .vfio_save_config = NULL,
+    .vfio_load_config = NULL,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    const char *sock_name;
+    AddressSpace *as;
+
+    if (!udev->socket) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "e.g. -device '{"
+            "\"driver\":\"vfio-user-pci\", "
+            "\"socket\": {\"path\": \"/tmp/vfio-user.sock\", "
+            "\"type\": \"unix\"}'"
+            "}'\n");
+        return;
+    }
+
+    sock_name = udev->socket->u.q_unix.path;
+
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    /*
+     * vfio-user devices are effectively mdevs (don't use a host iommu).
+     */
+    vbasedev->mdev = true;
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
+                                          vbasedev->name, vbasedev,
+                                          as, errp)) {
+        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+        return;
+    }
+}
+
+static void vfio_user_instance_init(Object *obj)
+{
+    PCIDevice *pci_dev = PCI_DEVICE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+
+    device_add_bootindex_property(obj, &vdev->bootindex,
+                                  "bootindex", NULL,
+                                  &pci_dev->qdev);
+    vdev->host.domain = ~0U;
+    vdev->host.bus = ~0U;
+    vdev->host.slot = ~0U;
+    vdev->host.function = ~0U;
+
+    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
+                     DEVICE(vdev), false);
+
+    vdev->nv_gpudirect_clique = 0xFF;
+
+    /*
+     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices.
+     */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
+static void vfio_user_instance_finalize(Object *obj)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+
+    vfio_pci_put_device(vdev);
+}
+
+static const Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
+                       vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
+                       device_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
+                       sub_vendor_id, PCI_ANY_ID),
+    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
+                       sub_device_id, PCI_ANY_ID),
+};
+
+static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
+                                     void *opaque, Error **errp)
+{
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
+    bool success;
+
+    qapi_free_SocketAddress(udev->socket);
+
+    udev->socket = NULL;
+
+    success = visit_type_SocketAddress(v, name, &udev->socket, errp);
+
+    if (!success) {
+        return;
+    }
+
+    if (udev->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
+        error_setg(errp, "Unsupported socket type %s",
+                   SocketAddressType_str(udev->socket->type));
+        qapi_free_SocketAddress(udev->socket);
+        udev->socket = NULL;
+        return;
+    }
+}
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
+
+    object_class_property_add(klass, "socket", "SocketAddress", NULL,
+                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_set_description(klass, "socket",
+                                          "SocketAddress (UNIX sockets only)");
+
+    dc->desc = "VFIO over socket PCI device assignment";
+    pdc->realize = vfio_user_pci_realize;
+}
+
+static const TypeInfo vfio_user_pci_dev_info = {
+    .name = TYPE_VFIO_USER_PCI,
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOUserPCIDevice),
+    .class_init = vfio_user_pci_dev_class_init,
+    .instance_init = vfio_user_instance_init,
+    .instance_finalize = vfio_user_instance_finalize,
+};
+
+static void register_vfio_user_dev_type(void)
+{
+    type_register_static(&vfio_user_pci_dev_info);
+}
+
+ type_init(register_vfio_user_dev_type)
diff --git a/hw/Kconfig b/hw/Kconfig
index 9a86a6a28a643c5ed17d37336ed006cc557f1cda..9e6c789ae7ee518fdea385fcd166c4d8a626b041 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -42,6 +42,7 @@ source ufs/Kconfig
 source usb/Kconfig
 source virtio/Kconfig
 source vfio/Kconfig
+source vfio-user/Kconfig
 source vmapple/Kconfig
 source xen/Kconfig
 source watchdog/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index b91f761fe08aae3e4732c2e463528d743e1390e1..791ce21ab42afbb4207413ffb21b080489bf12b8 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -39,6 +39,7 @@ subdir('uefi')
 subdir('ufs')
 subdir('usb')
 subdir('vfio')
+subdir('vfio-user')
 subdir('virtio')
 subdir('vmapple')
 subdir('watchdog')
diff --git a/hw/vfio-user/Kconfig b/hw/vfio-user/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..24bdf7af903bee63e2eeefcbe6243d131c0f612d
--- /dev/null
+++ b/hw/vfio-user/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config VFIO_USER
+    bool
+    default y
+    depends on VFIO_PCI
+
diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..b82c558252e82d0f492bd68ab6c8b657d5b6b08c
--- /dev/null
+++ b/hw/vfio-user/meson.build
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+vfio_user_ss = ss.source_set()
+vfio_user_ss.add(files(
+  'container.c',
+  'pci.c',
+))
+
+system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)
-- 
2.49.0


