Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE999C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3a-0007hl-Jg; Fri, 04 Jul 2025 04:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3T-0007gz-1F
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3Q-0000F7-L8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jmKYEXW/S0Z39ORxlWOomJ49IWOiCtqxFymROBfA0I=;
 b=dKjwPIdCRF8QSIUAB2vgrKoymfpglwGmZVMYL4hOEWo2P5Nz1j4Pon6Qyo+tBCJlyMTmR7
 aFF1+EsLSfF94ODQ5F2OET9PRY9LObaukuY4WoQA3OvhBskFXUl/4x9QGfcMh1ZlT0/xVV
 l6CnKD+U97ZLxCKMU/Rmqmg0NakCWjw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-7PiWimIfM7e_eSs6x1QjGg-1; Fri,
 04 Jul 2025 04:45:53 -0400
X-MC-Unique: 7PiWimIfM7e_eSs6x1QjGg-1
X-Mimecast-MFC-AGG-ID: 7PiWimIfM7e_eSs6x1QjGg_1751618752
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2057718011FE; Fri,  4 Jul 2025 08:45:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5664019560A7; Fri,  4 Jul 2025 08:45:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/27] vfio-pci: preserve MSI
Date: Fri,  4 Jul 2025 10:45:08 +0200
Message-ID: <20250704084528.1412959-8-clg@redhat.com>
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

Save the MSI message area as part of vfio-pci vmstate, and preserve the
interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
then the vfio-pci post_load handler finds the eventfds in CPR state,
rebuilds vector data structures, and attaches the interrupts to the new
KVM instance.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h              |  2 +
 include/hw/vfio/vfio-cpr.h |  8 ++++
 hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c              | 52 +++++++++++++++++++-
 4 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ba7330b27e80d1a565da2704689e48fa9bece18..495fae737d3a2e455e1cc04e062b9860196899be 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index dbb2a16b7a8174c15412a9297e0beb3d274ab520..f21578da3cb3611e04260f458e77aca6f48036fe 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -15,6 +15,7 @@
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
+struct VFIOPCIDevice;
 
 typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
                           hwaddr iova, ram_addr_t size, void *vaddr,
@@ -53,6 +54,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_ram_discard_register_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                             int nr, int fd);
+int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                            int nr);
+void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                               int nr);
+
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index fdbb58e2039e9fc6bd91c37a0f534522c0987680..e467373e8d17abc80fb627e8bd512824d7f322ab 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -9,6 +9,8 @@
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/pci.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/msi.h"
 #include "migration/cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
@@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
 
+#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
+    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
+
+void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
+                             int fd)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    cpr_save_fd(fdname, nr, fd);
+}
+
+int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    return cpr_find_fd(fdname, nr);
+}
+
+void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    cpr_delete_fd(fdname, nr);
+}
+
+static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
+                                   bool msix)
+{
+    int i, fd;
+    bool pending = false;
+    PCIDevice *pdev = &vdev->pdev;
+
+    vdev->nr_vectors = nr_vectors;
+    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
+    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
+
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
+
+    for (i = 0; i < nr_vectors; i++) {
+        VFIOMSIVector *vector = &vdev->msi_vectors[i];
+
+        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
+        if (fd >= 0) {
+            vfio_pci_vector_init(vdev, i);
+            vfio_pci_msi_set_handler(vdev, i);
+        }
+
+        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
+            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
+        } else {
+            vdev->msi_vectors[i].virq = -1;
+        }
+
+        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
+            set_bit(i, vdev->msix->pending);
+            pending = true;
+        }
+    }
+
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
+
+    if (msix) {
+        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
+    }
+}
+
 /*
  * The kernel may change non-emulated config bits.  Exclude them from the
  * changed-bits check in get_pci_config_device.
@@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
     return 0;
 }
 
+static int vfio_cpr_pci_post_load(void *opaque, int version_id)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int nr_vectors;
+
+    if (msix_enabled(pdev)) {
+        vfio_pci_msix_set_notifiers(vdev);
+        nr_vectors = vdev->msix->entries;
+        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
+
+    } else if (msi_enabled(pdev)) {
+        nr_vectors = msi_nr_vectors_allocated(pdev);
+        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        g_assert_not_reached();      /* completed in a subsequent patch */
+    }
+
+    return 0;
+}
+
+static bool pci_msix_present(void *opaque, int version_id)
+{
+    PCIDevice *pdev = opaque;
+
+    return msix_present(pdev);
+}
+
 const VMStateDescription vfio_cpr_pci_vmstate = {
     .name = "vfio-cpr-pci",
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_load = vfio_cpr_pci_pre_load,
+    .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fa25bded25c51f8efb6c5ad31bd90506cd69745c..5f9f2640e5aaeca2ef26e5056664a979fc5c842c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "migration/vmstate.h"
 #include "migration/cpr.h"
 #include "qobject/qdict.h"
@@ -57,20 +58,33 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+/* Create new or reuse existing eventfd */
 static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
                                const char *name, int nr, Error **errp)
 {
-    int ret = event_notifier_init(e, 0);
+    int fd, ret;
 
+    fd = vfio_cpr_load_vector_fd(vdev, name, nr);
+    if (fd >= 0) {
+        event_notifier_init_fd(e, fd);
+        return true;
+    }
+
+    ret = event_notifier_init(e, 0);
     if (ret) {
         error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+        return false;
     }
-    return !ret;
+
+    fd = event_notifier_get_fd(e);
+    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+    return true;
 }
 
 static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
                                   const char *name, int nr)
 {
+    vfio_cpr_delete_vector_fd(vdev, name, nr);
     event_notifier_cleanup(e);
 }
 
@@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
+    int fd = event_notifier_get_fd(&vector->interrupt);
+
+    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+}
+
 /*
  * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
  * fd to kernel.
@@ -656,6 +678,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 static int vfio_msix_vector_use(PCIDevice *pdev,
                                 unsigned int nr, MSIMessage msg)
 {
+    /*
+     * Ignore the callback from msix_set_vector_notifiers during resume.
+     * The necessary subset of these actions is called from
+     * vfio_cpr_claim_vectors during post load.
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
     return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
 }
 
@@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
     }
 }
 
+void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
+{
+    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+                              vfio_msix_vector_release, NULL);
+}
+
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
@@ -2965,6 +3002,11 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -3032,6 +3074,12 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (cpr_is_incoming()) {
+        vdev->req_enabled = true;
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-- 
2.50.0


