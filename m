Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87762C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXc3c-0007l7-BT; Fri, 04 Jul 2025 04:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3W-0007hE-FV
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXc3T-0000Fu-H9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OBpe/6J4zCOQSdUBlq9XBrD/jdeXQVwxK0cWryWLSA=;
 b=Lt52InNYnil1CdcH/Rf7I8ozHo4TUiv8DvgNj8u1ngua4aUqaKvL237rTe8707agJaf+HV
 SYs6hhyHC1dzNmE0Hc8YVAkgOfzVEPUqUm8TgfppR5Q7U8r4aAD+77BjNMoeidXmkypA7V
 lDLPZV3PaASOr8KDsbWfd3vHMQYAYRA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-KqkNclA3NtKMjp8iG6pHrA-1; Fri,
 04 Jul 2025 04:45:55 -0400
X-MC-Unique: KqkNclA3NtKMjp8iG6pHrA-1
X-Mimecast-MFC-AGG-ID: KqkNclA3NtKMjp8iG6pHrA_1751618754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AA9A1800268; Fri,  4 Jul 2025 08:45:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8000619560A7; Fri,  4 Jul 2025 08:45:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/27] vfio-pci: preserve INTx
Date: Fri,  4 Jul 2025 10:45:09 +0200
Message-ID: <20250704084528.1412959-9-clg@redhat.com>
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

Preserve vfio INTx state across cpr-transfer.  Preserve VFIOINTx fields as
follows:
  pin : Recover this from the vfio config in kernel space
  interrupt : Preserve its eventfd descriptor across exec.
  unmask : Ditto
  route.irq : This could perhaps be recovered in vfio_pci_post_load by
    calling pci_device_route_intx_to_irq(pin), whose implementation reads
    config space for a bridge device such as ich9.  However, there is no
    guarantee that the bridge vmstate is read before vfio vmstate.  Rather
    than fiddling with MigrationPriority for vmstate handlers, explicitly
    save route.irq in vfio vmstate.
  pending : save in vfio vmstate.
  mmap_timeout, mmap_timer : Re-initialize
  bool kvm_accel : Re-initialize

In vfio_realize, defer calling vfio_intx_enable until the vmstate
is available, in vfio_pci_post_load.  Modify vfio_intx_enable and
vfio_intx_kvm_enable to skip vfio initialization, but still perform
kvm initialization.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1751493538-202042-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr.c | 27 ++++++++++++++++++++++++-
 hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index e467373e8d17abc80fb627e8bd512824d7f322ab..f5555cabe72a817c000a1359bc7fd318c6aff4c1 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -139,7 +139,11 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
         vfio_cpr_claim_vectors(vdev, nr_vectors, false);
 
     } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
-        g_assert_not_reached();      /* completed in a subsequent patch */
+        Error *local_err = NULL;
+        if (!vfio_pci_intx_enable(vdev, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
     }
 
     return 0;
@@ -152,6 +156,26 @@ static bool pci_msix_present(void *opaque, int version_id)
     return msix_present(pdev);
 }
 
+static const VMStateDescription vfio_intx_vmstate = {
+    .name = "vfio-cpr-intx",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(pending, VFIOINTx),
+        VMSTATE_UINT32(route.mode, VFIOINTx),
+        VMSTATE_INT32(route.irq, VFIOINTx),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_VFIO_INTX(_field, _state) {                         \
+    .name       = (stringify(_field)),                              \
+    .size       = sizeof(VFIOINTx),                                 \
+    .vmsd       = &vfio_intx_vmstate,                               \
+    .flags      = VMS_STRUCT,                                       \
+    .offset     = vmstate_offset_value(_state, _field, VFIOINTx),   \
+}
+
 const VMStateDescription vfio_cpr_pci_vmstate = {
     .name = "vfio-cpr-pci",
     .version_id = 0,
@@ -162,6 +186,7 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
+        VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5f9f2640e5aaeca2ef26e5056664a979fc5c842c..dd0b2a0b947d4f9c788c6cd8b41e8ac916098724 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -210,6 +210,36 @@ fail:
 #endif
 }
 
+static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
+{
+#ifdef CONFIG_KVM
+    if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
+        vdev->intx.route.mode != PCI_INTX_ENABLED ||
+        !kvm_resamplefds_enabled()) {
+        return true;
+    }
+
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
+        return false;
+    }
+
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &vdev->intx.interrupt,
+                                           &vdev->intx.unmask,
+                                           vdev->intx.route.irq)) {
+        error_setg_errno(errp, errno, "failed to setup resample irqfd");
+        vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
+        return false;
+    }
+
+    vdev->intx.kvm_accel = true;
+    trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
+    return true;
+#else
+    return true;
+#endif
+}
+
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
@@ -305,7 +335,13 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    vfio_disable_interrupts(vdev);
+    /*
+     * Do not alter interrupt state during vfio_realize and cpr load.
+     * The incoming state is cleared thereafter.
+     */
+    if (!cpr_is_incoming()) {
+        vfio_disable_interrupts(vdev);
+    }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(vdev->pdev.config, pin);
@@ -328,6 +364,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
+
+    if (cpr_is_incoming()) {
+        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+        goto skip_signaling;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
@@ -339,6 +383,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
+skip_signaling:
     vdev->interrupt = VFIO_INT_INTx;
 
     trace_vfio_intx_enable(vdev->vbasedev.name);
@@ -3237,7 +3282,13 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
+
+        /*
+         * During CPR, do not call vfio_intx_enable at this time.  Instead,
+         * call it from vfio_pci_post_load after the intx routing data has
+         * been loaded from vmstate.
+         */
+        if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
             timer_free(vdev->intx.mmap_timer);
             pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
             kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
-- 
2.50.0


