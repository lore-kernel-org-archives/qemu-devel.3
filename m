Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ADEC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7R-0001VY-5p; Wed, 29 May 2024 12:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6y-0001BW-O8
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:14 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6v-0006Kd-CB
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:12 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6j-006COz-5O;
 Wed, 29 May 2024 17:24:57 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 10/26] vfio-user: add vfio-user class and container
Date: Wed, 29 May 2024 17:23:03 +0100
Message-Id: <20240529162319.1476680-11-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add a new class for vfio-user with its class and instance
constructors and destructors, and its pci ops.

Introduce VFIOUserContainer for handling container operations for such
classes.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                           |   1 +
 hw/vfio/container.c                   |   2 +-
 hw/vfio/meson.build                   |   5 +
 hw/vfio/pci.c                         |  12 +-
 hw/vfio/pci.h                         |   7 +
 hw/vfio/user-container.c              | 210 ++++++++++++++++++++++++++
 hw/vfio/user-pci.c                    | 155 +++++++++++++++++++
 include/hw/vfio/vfio-common.h         |   8 +
 include/hw/vfio/vfio-container-base.h |   1 +
 meson_options.txt                     |   2 +
 scripts/meson-buildoptions.sh         |   4 +
 11 files changed, 400 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/user-container.c
 create mode 100644 hw/vfio/user-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8744b2d76e..4ca266bb31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4087,6 +4087,7 @@ F: hw/remote/vfio-user-obj.c
 F: include/hw/remote/vfio-user-obj.h
 F: hw/remote/iommu.c
 F: include/hw/remote/iommu.h
+F: hw/vfio/user*
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6c70f95f04..4ff09e277f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -889,7 +889,7 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
     return true;
 }
 
-static void vfio_put_base_device(VFIODevice *vbasedev)
+void vfio_put_base_device(VFIODevice *vbasedev)
 {
     if (vbasedev->regions != NULL) {
         int i;
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bba776f75c..f897c5b81a 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -16,6 +16,11 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'pci-quirks.c',
   'pci.c',
 ))
+
+if get_option('vfio_user_client').enabled()
+  vfio_ss.add(files('user-container.c', 'user-pci.c'))
+endif
+
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2ad0dbe342..2e334c0c38 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -109,7 +109,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2585,7 +2585,7 @@ static void vfio_pci_compute_needs_reset(VFIODevice *vbasedev)
     }
 }
 
-static Object *vfio_pci_get_object(VFIODevice *vbasedev)
+Object *vfio_pci_get_object(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2641,7 +2641,7 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     }
 };
 
-static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -2649,7 +2649,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
                                        errp);
 }
 
-static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
@@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_detach_device(&vdev->vbasedev);
 
@@ -3359,7 +3359,7 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
-static void vfio_instance_init(Object *obj)
+void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 770448155e..040f4995b5 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -213,6 +213,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len);
 
+void vfio_intx_eoi(VFIODevice *vbasedev);
+Object *vfio_pci_get_object(VFIODevice *vbasedev);
+int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp);
+int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+void vfio_instance_init(Object *obj);
+
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
new file mode 100644
index 0000000000..1fd42e9bfd
--- /dev/null
+++ b/hw/vfio/user-container.c
@@ -0,0 +1,210 @@
+/*
+ * Container for vfio-user IOMMU type: rather than communicating with the kernel
+ * vfio driver, we communicate over a socket to a server using the vfio-user
+ * protocol.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
+#include "hw/hw.h"
+#include "qemu/error-report.h"
+#include "qemu/range.h"
+#include "sysemu/reset.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "pci.h"
+
+static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
+                               hwaddr iova, ram_addr_t size,
+                               IOMMUTLBEntry *iotlb, int flags)
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
+/*
+ * Try to mirror vfio_connect_container() as much as possible.
+ */
+static VFIOUserContainer *
+vfio_connect_user_container(AddressSpace *as, Error **errp)
+{
+    VFIOAddressSpace *space;
+    VFIOUserContainer *container;
+    VFIOContainerBase *bcontainer;
+
+    space = vfio_get_address_space(as);
+
+    container = g_malloc0(sizeof(*container));
+
+    bcontainer = &container->bcontainer;
+
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto free_container_exit;
+    }
+
+    assert(bcontainer->ops->setup);
+
+    if (!bcontainer->ops->setup(bcontainer, errp)) {
+        goto unregister_container_exit;
+    }
+
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+
+    bcontainer->listener = vfio_memory_listener;
+    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
+
+    if (bcontainer->error) {
+        errno = EINVAL;
+        error_propagate_prepend(errp, bcontainer->error,
+            "memory listener initialization failed: ");
+        goto listener_release_exit;
+    }
+
+    bcontainer->initialized = true;
+
+    return container;
+
+listener_release_exit:
+    QLIST_REMOVE(bcontainer, next);
+    memory_listener_unregister(&bcontainer->listener);
+    if (bcontainer->ops->release) {
+        bcontainer->ops->release(bcontainer);
+    }
+
+unregister_container_exit:
+    vfio_cpr_unregister_container(bcontainer);
+
+free_container_exit:
+    g_free(container);
+
+    vfio_put_address_space(space);
+
+    return NULL;
+}
+
+static void vfio_disconnect_user_container(VFIOUserContainer *container)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+
+    memory_listener_unregister(&bcontainer->listener);
+    if (bcontainer->ops->release) {
+        bcontainer->ops->release(bcontainer);
+    }
+
+    VFIOAddressSpace *space = bcontainer->space;
+
+    vfio_container_destroy(bcontainer);
+
+    vfio_cpr_unregister_container(bcontainer);
+    g_free(container);
+
+    vfio_put_address_space(space);
+}
+
+static bool vfio_user_get_device(VFIOUserContainer *container,
+                                 VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_info info = { 0 };
+
+    vbasedev->fd = -1;
+
+    vfio_prepare_device(vbasedev, &container->bcontainer, NULL, &info);
+
+    return true;
+}
+
+/*
+ * vfio_user_attach_device: attach a device to a new container.
+ */
+static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
+                                    AddressSpace *as, Error **errp)
+{
+    VFIOUserContainer *container;
+
+    container = vfio_connect_user_container(as, errp);
+    if (container == NULL) {
+        error_prepend(errp, "failed to connect proxy");
+        return false;
+    }
+
+    return vfio_user_get_device(container, vbasedev, errp);
+}
+
+static void vfio_user_detach_device(VFIODevice *vbasedev)
+{
+    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
+                                                VFIOUserContainer, bcontainer);
+
+    QLIST_REMOVE(vbasedev, global_next);
+    QLIST_REMOVE(vbasedev, container_next);
+    vbasedev->bcontainer = NULL;
+    vfio_put_base_device(vbasedev);
+    vfio_disconnect_user_container(container);
+}
+
+static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
+{
+    /* ->needs_reset is always false for vfio-user. */
+    return 0;
+}
+
+static void vfio_iommu_user_class_init(ObjectClass *klass, void *data)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
+
+    vioc->setup = vfio_user_setup;
+    vioc->dma_map = vfio_user_dma_map;
+    vioc->dma_unmap = vfio_user_dma_unmap;
+    vioc->attach_device = vfio_user_attach_device;
+    vioc->detach_device = vfio_user_detach_device;
+    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
+    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
+    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
+};
+
+static const TypeInfo types[] = {
+    {
+        .name = TYPE_VFIO_IOMMU_USER,
+        .parent = TYPE_VFIO_IOMMU,
+        .class_init = vfio_iommu_user_class_init,
+    },
+};
+
+DEFINE_TYPES(types)
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
new file mode 100644
index 0000000000..fd0e534f0f
--- /dev/null
+++ b/hw/vfio/user-pci.c
@@ -0,0 +1,155 @@
+/*
+ * vfio PCI device over a UNIX socket.
+ *
+ * Copyright © 2018, 2021 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vfio.h>
+#include <sys/ioctl.h>
+
+#include "hw/hw.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "migration/vmstate.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/range.h"
+#include "qemu/units.h"
+#include "sysemu/kvm.h"
+#include "sysemu/runstate.h"
+#include "pci.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
+#include "migration/qemu-file.h"
+
+#define TYPE_VFIO_USER_PCI "vfio-user-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
+
+struct VFIOUserPCIDevice {
+    VFIOPCIDevice device;
+    char *sock_name;
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
+static VFIODeviceOps vfio_user_pci_ops = {
+    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
+    .vfio_eoi = vfio_intx_eoi,
+    .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
+};
+
+static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
+{
+    ERRP_GUARD();
+    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    AddressSpace *as;
+
+    /*
+     * TODO: make option parser understand SocketAddress
+     * and use that instead of having scalar options
+     * for each socket type.
+     */
+    if (!udev->sock_name) {
+        error_setg(errp, "No socket specified");
+        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
+        return;
+    }
+
+    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
+    vbasedev->ops = &vfio_user_pci_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
+    vbasedev->dev = DEVICE(vdev);
+
+    as = pci_device_iommu_address_space(pdev);
+    if (!vfio_attach_device_by_iommu_type(TYPE_VFIO_IOMMU_USER,
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
+                     &vfio_dev_io_ioctl, DEVICE(vdev), false);
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
+static Property vfio_user_pci_dev_properties[] = {
+    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_user_pci_dev_properties);
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
+type_init(register_vfio_user_dev_type)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 689cafe28b..c12fd1e2f0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -75,6 +75,7 @@ typedef struct VFIOMigration {
 
 struct VFIOGroup;
 
+/* MMU container sub-class for legacy vfio implementation. */
 typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
@@ -83,6 +84,11 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
+/* MMU container sub-class for vfio-user. */
+typedef struct VFIOUserContainer {
+    VFIOContainerBase bcontainer;
+} VFIOUserContainer;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
@@ -92,6 +98,7 @@ typedef struct VFIOHostDMAWindow {
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
 
+/* MMU container sub-class for vfio iommufd implementation. */
 typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
@@ -257,6 +264,7 @@ bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
                                       VFIODevice *vbasedev, AddressSpace *as,
                                       Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
+void vfio_put_base_device(VFIODevice *vbasedev);
 
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c2c1af70ac..82472e4b3c 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -96,6 +96,7 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer);
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
+#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
 /*
  * VFIOContainerBase is not an abstract QOM object because it felt
diff --git a/meson_options.txt b/meson_options.txt
index 4c1583eb40..239c69b2f4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -105,6 +105,8 @@ option('multiprocess', type: 'feature', value: 'auto',
        description: 'Out of process device emulation support')
 option('relocatable', type : 'boolean', value : true,
        description: 'toggle relocatable install')
+option('vfio_user_client', type: 'feature', value: 'disabled',
+       description: 'vfio-user client support')
 option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6ce5a8b72a..51be621296 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -191,6 +191,8 @@ meson_options_help() {
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
   printf "%s\n" '                  VDUSE block export support'
+  printf "%s\n" '  vfio-user-client'
+  printf "%s\n" '                  vfio-user client support'
   printf "%s\n" '  vfio-user-server'
   printf "%s\n" '                  vfio-user server support'
   printf "%s\n" '  vhdx            vhdx image format support'
@@ -508,6 +510,8 @@ _meson_option_parse() {
     --disable-vdi) printf "%s" -Dvdi=disabled ;;
     --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
     --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
+    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
+    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
     --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
     --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
     --enable-vhdx) printf "%s" -Dvhdx=enabled ;;
-- 
2.34.1


