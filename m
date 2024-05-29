Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A3BC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM7Y-00022k-4k; Wed, 29 May 2024 12:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM74-0001Ht-1L
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:23 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM71-0006La-RT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:17 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6k-006CQ5-Vf;
 Wed, 29 May 2024 17:24:58 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 19/26] vfio-user: forward msix BAR accesses to server
Date: Wed, 29 May 2024 17:23:12 +0100
Message-Id: <20240529162319.1476680-20-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
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

Server holds device current device pending state
Use irq masking commands in socket case

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/helpers.c             | 26 +++++++++++
 hw/vfio/pci.c                 | 86 +++++++++++++++++++++++++----------
 hw/vfio/pci.h                 |  2 +
 hw/vfio/user-pci.c            | 63 +++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  2 +
 5 files changed, 156 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b2a5d7d1ba..54c8c9b03e 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -71,6 +71,32 @@ void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
     vbasedev->io->set_irqs(vbasedev, &irq_set);
 }
 
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = irq,
+        .count = 1,
+    };
+
+    vbasedev->io->set_irqs(vbasedev, &irq_set);
+}
+
 static inline const char *action_to_str(int action)
 {
     switch (action) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 56bfb17eec..8ff69ff6ec 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -520,11 +520,30 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
     kvm_irqchip_commit_routes(kvm_state);
 }
 
+static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
+                               unsigned int nr)
+{
+    Error *err = NULL;
+    int32_t fd;
+
+    if (vector->virq >= 0) {
+        fd = event_notifier_get_fd(&vector->kvm_interrupt);
+    } else {
+        fd = event_notifier_get_fd(&vector->interrupt);
+    }
+
+    if (!vfio_set_irq_signaling(vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vbasedev->name);
+    }
+}
+
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
+    bool new_vec = false;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
@@ -539,6 +558,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             error_report("vfio: Error: event_notifier_init failed");
         }
         vector->use = true;
+        new_vec = true;
         msix_vector_use(pdev, nr);
     }
 
@@ -565,6 +585,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector);
             }
+            new_vec = true;
         }
     }
 
@@ -574,38 +595,35 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
      * in use, so we shutdown and incrementally increase them as needed.
      * nr_vectors represents the total number of vectors allocated.
      *
+     * Otherwise, unmask the vector if the vector is already setup (and we can
+     * do so) or send the fd if not.
+     *
      * When dynamic allocation is supported, let the host only allocate
      * and enable a vector when it is in use in guest. nr_vectors represents
      * the upper bound of vectors being enabled (but not all of the ranges
      * is allocated or enabled).
      */
+
     if (resizing) {
         vdev->nr_vectors = nr + 1;
     }
 
     if (!vdev->defer_kvm_irq_routing) {
-        if (vdev->msix->noresize && resizing) {
-            vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
-            ret = vfio_enable_vectors(vdev, true);
-            if (ret) {
-                error_report("vfio: failed to enable vectors, %d", ret);
-            }
-        } else {
-            Error *err = NULL;
-            int32_t fd;
-
-            if (vector->virq >= 0) {
-                fd = event_notifier_get_fd(&vector->kvm_interrupt);
+        if (resizing) {
+            if (vdev->msix->noresize) {
+                vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
+                ret = vfio_enable_vectors(vdev, true);
+                if (ret) {
+                    error_report("vfio: failed to enable vectors, %d", ret);
+                }
             } else {
-                fd = event_notifier_get_fd(&vector->interrupt);
-            }
-
-            if (!vfio_set_irq_signaling(&vdev->vbasedev,
-                                        VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd,
-                                        &err)) {
-                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+                set_irq_signalling(&vdev->vbasedev, vector, nr);
             }
+        } else if (vdev->can_mask_msix && !new_vec) {
+            vfio_unmask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   nr);
+        } else {
+            set_irq_signalling(&vdev->vbasedev, vector, nr);
         }
     }
 
@@ -633,6 +651,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
 
+    /* just mask vector if peer supports it */
+    if (vdev->can_mask_msix) {
+        vfio_mask_single_irq(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr);
+        return;
+    }
+
     /*
      * There are still old guests that mask and unmask vectors on every
      * interrupt.  If we're using QEMU bypass with a KVM irqfd, leave all of
@@ -704,7 +728,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable vectors, %d", ret);
         }
-    } else {
+    } else if (!vdev->can_mask_msix) {
         /*
          * Some communication channels between VF & PF or PF & fw rely on the
          * physical state of the device and expect that enabling MSI-X from the
@@ -721,6 +745,13 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
         if (ret) {
             error_report("vfio: failed to enable MSI-X, %d", ret);
         }
+    } else {
+        /*
+         * If we can use irq masking, send an invalid fd on vector 0
+         * to enable MSI-X without any vectors enabled.
+         */
+        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, NULL);
     }
 
     trace_vfio_msix_enable(vdev->vbasedev.name);
@@ -2771,7 +2802,7 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2832,8 +2863,17 @@ bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
+    ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
+    if (ret == 0 && (irq_info.flags & VFIO_IRQ_INFO_MASKABLE)) {
+        vdev->can_mask_msix = true;
+    } else {
+        vdev->can_mask_msix = false;
+    }
 
+    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
+    irq_info.argsz = sizeof(irq_info);
     ret = vbasedev->io->get_irq_info(vbasedev, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 1eeb67bb2e..d678b84191 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -114,6 +114,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
@@ -183,6 +184,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool can_mask_msix;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/hw/vfio/user-pci.c b/hw/vfio/user-pci.c
index b8a9f7a7fb..9514f6e2fa 100644
--- a/hw/vfio/user-pci.c
+++ b/hw/vfio/user-pci.c
@@ -44,6 +44,62 @@ struct VFIOUserPCIDevice {
     bool no_post;       /* all regions write are sync */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these acceses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -153,6 +209,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_add_capabilities(vdev, errp)) {
         goto out_teardown;
     }
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
 
     if (!vfio_interrupt_setup(vdev, errp)) {
         goto out_teardown;
@@ -205,6 +264,10 @@ static void vfio_user_instance_finalize(Object *obj)
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 617891c4fe..747b343596 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -248,6 +248,8 @@ void vfio_spapr_container_deinit(VFIOContainer *container);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
+void vfio_unmask_single_irq(VFIODevice *vbasedev, int index, int irq);
+void vfio_mask_single_irq(VFIODevice *vbasedev, int index, int irq);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 void vfio_region_write(void *opaque, hwaddr addr,
-- 
2.34.1


