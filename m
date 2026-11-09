Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7D606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R7Q5SHHt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLL8-0002oT-Kg; Mon, 09 Nov 2026 04:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKv-0002eX-GP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xQLKr-0002sV-73
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794215199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtZawW15GBpp/MKPNxGagt2UyFDje157f63U9RL92yQ=;
 b=R7Q5SHHtKX7Tt5G7KBMPesOLnRdh9b/Rc8QWpSql5V+mLg2kJ0Jv5dnfKjfU++1yFALjXE
 A72f3ckgW4fxwQpDuaQEqK8FgD1x7Hhdey9m3+ERqJvk0ViBh0ZuC4iAeefF41JEHqIxZ3
 ZldW+T3HqyZsJS5UwbV03LHFHNynFew=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-tKrJoxJ6NCaxnwiWIfrdfg-1; Mon,
 09 Nov 2026 04:06:36 -0500
X-MC-Unique: tKrJoxJ6NCaxnwiWIfrdfg-1
X-Mimecast-MFC-AGG-ID: tKrJoxJ6NCaxnwiWIfrdfg_1794215195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5714619560AF; Mon,  9 Nov 2026 09:06:35 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A90F30030FB; Mon,  9 Nov 2026 09:06:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-12.0 3/9] vfio/pci: Rename IRQ functions
Date: Mon,  9 Nov 2026 10:06:19 +0100
Message-ID: <20261109090625.908592-4-clg@redhat.com>
In-Reply-To: <20261109090625.908592-1-clg@redhat.com>
References: <20261109090625.908592-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Normalize IRQ function names to a consistent vfio_pci_*_verb pattern:

  vfio_pci_interrupt_setup     -> vfio_pci_irq_setup
  vfio_disable_interrupts      -> vfio_pci_irq_disable
  vfio_intx_enable             -> vfio_pci_intx_enable
  vfio_intx_disable            -> vfio_pci_intx_disable
  vfio_pci_vector_init         -> vfio_pci_msi_vector_use
  vfio_msi_setup               -> vfio_pci_msi_setup
  vfio_msi_enable              -> vfio_pci_msi_enable
  vfio_msi_disable             -> vfio_pci_msi_disable
  vfio_update_msi              -> vfio_pci_msi_update
  vfio_pci_teardown_msi        -> vfio_pci_msi_teardown
  vfio_msix_early_setup        -> vfio_pci_msix_early_setup
  vfio_msix_setup              -> vfio_pci_msix_setup
  vfio_msix_enable             -> vfio_pci_msix_enable
  vfio_msix_disable            -> vfio_pci_msix_disable
  vfio_unregister_err_notifier -> vfio_pci_unregister_err_notifier
  vfio_unregister_req_notifier -> vfio_pci_unregister_req_notifier

Drop the vfio_pci_intx_enable() wrapper that called vfio_intx_enable()
and reorder the declarations in pci.h.

No functional change.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h      | 45 ++++++++++++++++++----------------
 hw/vfio-user/pci.c |  4 +--
 hw/vfio/cpr.c      |  2 +-
 hw/vfio/pci-irq.c  | 61 +++++++++++++++++++++-------------------------
 hw/vfio/pci.c      | 38 ++++++++++++++---------------
 5 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 3315fb4fbceb..184df22b6e67 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -212,29 +212,32 @@ static inline bool vfio_is_base_display(VFIOPCIDevice *vdev)
 }
 
 /* MSI/MSI-X/INTx */
-void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr);
+bool vfio_pci_irq_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_irq_disable(VFIOPCIDevice *vdev);
+
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_disable(VFIOPCIDevice *vdev);
+void vfio_pci_intx_eoi(VFIODevice *vbasedev);
+void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
+
+bool vfio_pci_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
+void vfio_pci_msi_vector_use(VFIOPCIDevice *vdev, int nr);
+void vfio_pci_msi_enable(VFIOPCIDevice *vdev);
+void vfio_pci_msi_disable(VFIOPCIDevice *vdev);
+void vfio_pci_msi_update(VFIOPCIDevice *vdev);
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
+void vfio_pci_msi_teardown(VFIOPCIDevice *vdev);
+
+bool vfio_pci_msix_early_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
+void vfio_pci_msix_enable(VFIOPCIDevice *vdev);
+void vfio_pci_msix_disable(VFIOPCIDevice *vdev);
+void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
+
 void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                int vector_n, bool msix);
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
-bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
-void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
-void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
-void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
-void vfio_disable_interrupts(VFIOPCIDevice *vdev);
-bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp);
-void vfio_intx_disable(VFIOPCIDevice *vdev);
-void vfio_msi_enable(VFIOPCIDevice *vdev);
-void vfio_msi_disable(VFIOPCIDevice *vdev);
-void vfio_msix_enable(VFIOPCIDevice *vdev);
-void vfio_msix_disable(VFIOPCIDevice *vdev);
-void vfio_update_msi(VFIOPCIDevice *vdev);
-bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp);
-bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
-bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp);
-bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
-void vfio_pci_intx_eoi(VFIODevice *vbasedev);
-void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
 
 /* Config space */
 int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
@@ -301,9 +304,9 @@ extern const VMStateDescription vfio_display_vmstate;
 
 /* Notifiers */
 void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
-void vfio_unregister_err_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_unregister_err_notifier(VFIOPCIDevice *vdev);
 void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
-void vfio_unregister_req_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_unregister_req_notifier(VFIOPCIDevice *vdev);
 
 /**
  * vfio_pci_from_vfio_device: Transform from VFIODevice to
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index c749ff149f8a..2a66500c1e6d 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -345,7 +345,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_user_msix_setup(vdev);
     }
 
-    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+    if (!vfio_pci_irq_setup(vdev, errp)) {
         goto out_teardown;
     }
 
@@ -355,7 +355,7 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     return;
 
 out_teardown:
-    vfio_pci_teardown_msi(vdev);
+    vfio_pci_msi_teardown(vdev);
     vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 6e1659dcddc1..3c1304781d76 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -69,7 +69,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
 
         fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
         if (fd >= 0) {
-            vfio_pci_vector_init(vdev, i);
+            vfio_pci_msi_vector_use(vdev, i);
             vfio_pci_msi_set_handler(vdev, i, true);
         }
 
diff --git a/hw/vfio/pci-irq.c b/hw/vfio/pci-irq.c
index 2b2a118b130a..62b0e9a64d90 100644
--- a/hw/vfio/pci-irq.c
+++ b/hw/vfio/pci-irq.c
@@ -301,7 +301,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
     vfio_intx_update(vdev, &vdev->intx.route);
 }
 
-bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     uint32_t val = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
@@ -329,7 +329,7 @@ bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
      * The incoming state is cleared thereafter.
      */
     if (!cpr_is_incoming()) {
-        vfio_disable_interrupts(vdev);
+        vfio_pci_irq_disable(vdev);
     }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
@@ -377,7 +377,7 @@ skip_signaling:
     return true;
 }
 
-void vfio_intx_disable(VFIOPCIDevice *vdev)
+void vfio_pci_intx_disable(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int fd;
@@ -400,11 +400,6 @@ void vfio_intx_disable(VFIOPCIDevice *vdev)
     trace_vfio_intx_disable(vdev->vbasedev.name);
 }
 
-bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
-{
-    return vfio_intx_enable(vdev, errp);
-}
-
 void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable)
 {
     int fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -629,7 +624,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
     }
 }
 
-void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_msi_vector_use(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = PCI_DEVICE(vdev);
@@ -660,7 +655,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     vector = &vdev->msi_vectors[nr];
 
     if (!vector->use) {
-        vfio_pci_vector_init(vdev, nr);
+        vfio_pci_msi_vector_use(vdev, nr);
     }
 
     qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -801,12 +796,12 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     }
 }
 
-void vfio_msix_enable(VFIOPCIDevice *vdev)
+void vfio_pci_msix_enable(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
 
-    vfio_disable_interrupts(vdev);
+    vfio_pci_irq_disable(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
 
@@ -856,12 +851,12 @@ void vfio_msix_enable(VFIOPCIDevice *vdev)
     trace_vfio_msix_enable(vdev->vbasedev.name);
 }
 
-void vfio_msi_enable(VFIOPCIDevice *vdev)
+void vfio_pci_msi_enable(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, i;
 
-    vfio_disable_interrupts(vdev);
+    vfio_pci_irq_disable(vdev);
 
     vdev->nr_vectors = msi_nr_vectors_allocated(pdev);
 retry:
@@ -954,7 +949,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
     vdev->interrupt = VFIO_INT_NONE;
 }
 
-void vfio_msix_disable(VFIOPCIDevice *vdev)
+void vfio_pci_msix_disable(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     Error *err = NULL;
@@ -975,12 +970,12 @@ void vfio_msix_disable(VFIOPCIDevice *vdev)
 
     /*
      * Always clear MSI-X IRQ index. A PF device could have enabled
-     * MSI-X with no vectors. See vfio_msix_enable().
+     * MSI-X with no vectors. See vfio_pci_msix_enable().
      */
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
 
     vfio_msi_disable_common(vdev);
-    if (!vfio_intx_enable(vdev, &err)) {
+    if (!vfio_pci_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -990,13 +985,13 @@ void vfio_msix_disable(VFIOPCIDevice *vdev)
     trace_vfio_msix_disable(vdev->vbasedev.name);
 }
 
-void vfio_msi_disable(VFIOPCIDevice *vdev)
+void vfio_pci_msi_disable(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
 
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_MSI_IRQ_INDEX);
     vfio_msi_disable_common(vdev);
-    vfio_intx_enable(vdev, &err);
+    vfio_pci_intx_enable(vdev, &err);
     if (err) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
@@ -1004,7 +999,7 @@ void vfio_msi_disable(VFIOPCIDevice *vdev)
     trace_vfio_msi_disable(vdev->vbasedev.name);
 }
 
-void vfio_update_msi(VFIOPCIDevice *vdev)
+void vfio_pci_msi_update(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int i;
@@ -1025,7 +1020,7 @@ void vfio_update_msi(VFIOPCIDevice *vdev)
 /*
  * Interrupt setup
  */
-void vfio_disable_interrupts(VFIOPCIDevice *vdev)
+void vfio_pci_irq_disable(VFIOPCIDevice *vdev)
 {
     /*
      * More complicated than it looks.  Disabling MSI/X transitions the
@@ -1033,17 +1028,17 @@ void vfio_disable_interrupts(VFIOPCIDevice *vdev)
      * disable MSI/X and then cleanup by disabling INTx.
      */
     if (vdev->interrupt == VFIO_INT_MSIX) {
-        vfio_msix_disable(vdev);
+        vfio_pci_msix_disable(vdev);
     } else if (vdev->interrupt == VFIO_INT_MSI) {
-        vfio_msi_disable(vdev);
+        vfio_pci_msi_disable(vdev);
     }
 
     if (vdev->interrupt == VFIO_INT_INTx) {
-        vfio_intx_disable(vdev);
+        vfio_pci_intx_disable(vdev);
     }
 }
 
-bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
+bool vfio_pci_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t ctrl;
@@ -1259,7 +1254,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  * need to first look for where the MSI-X table lives.  So we
  * unfortunately split MSI-X setup across two functions.
  */
-bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t pos;
@@ -1367,7 +1362,7 @@ bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     return vfio_pci_relocate_msix(vdev, errp);
 }
 
-bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
+bool vfio_pci_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
@@ -1425,7 +1420,7 @@ bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_pci_msi_teardown(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
@@ -1503,7 +1498,7 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
     }
 }
 
-void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_unregister_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
 
@@ -1577,7 +1572,7 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
     }
 }
 
-void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_unregister_req_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
 
@@ -1596,7 +1591,7 @@ void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_irq_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
@@ -1620,11 +1615,11 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
 
         /*
-         * During CPR, do not call vfio_intx_enable at this time.  Instead,
+         * During CPR, do not call vfio_pci_intx_enable at this time.  Instead,
          * call it from vfio_pci_post_load after the intx routing data has
          * been loaded from vmstate.
          */
-        if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
+        if (!cpr_is_incoming() && !vfio_pci_intx_enable(vdev, errp)) {
             timer_free(vdev->intx.mmap_timer);
             pci_device_set_intx_routing_notifier(pdev, NULL);
             kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5fd099695c8e..9a3e960126ea 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -482,13 +482,13 @@ void vfio_pci_write_config(PCIDevice *pdev,
 
         if (!was_enabled) {
             if (is_enabled) {
-                vfio_msi_enable(vdev);
+                vfio_pci_msi_enable(vdev);
             }
         } else {
             if (!is_enabled) {
-                vfio_msi_disable(vdev);
+                vfio_pci_msi_disable(vdev);
             } else {
-                vfio_update_msi(vdev);
+                vfio_pci_msi_update(vdev);
             }
         }
     } else if (pdev->cap_present & QEMU_PCI_CAP_MSIX &&
@@ -500,9 +500,9 @@ void vfio_pci_write_config(PCIDevice *pdev,
         is_enabled = msix_enabled(pdev);
 
         if (!was_enabled && is_enabled) {
-            vfio_msix_enable(vdev);
+            vfio_pci_msix_enable(vdev);
         } else if (was_enabled && !is_enabled) {
-            vfio_msix_disable(vdev);
+            vfio_pci_msix_disable(vdev);
         }
     } else if (ranges_overlap(addr, len, PCI_BASE_ADDRESS_0, 24) ||
         range_covers_byte(addr, len, PCI_COMMAND)) {
@@ -1021,14 +1021,14 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 
     switch (cap_id) {
     case PCI_CAP_ID_MSI:
-        ret = vfio_msi_setup(vdev, pos, errp);
+        ret = vfio_pci_msi_setup(vdev, pos, errp);
         break;
     case PCI_CAP_ID_EXP:
         vfio_check_pcie_flr(vdev, pos);
         ret = vfio_setup_pcie_cap(vdev, pos, size, errp);
         break;
     case PCI_CAP_ID_MSIX:
-        ret = vfio_msix_setup(vdev, pos, errp);
+        ret = vfio_pci_msix_setup(vdev, pos, errp);
         break;
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
@@ -1361,7 +1361,7 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
     uint32_t val;
     uint16_t cmd;
 
-    vfio_disable_interrupts(vdev);
+    vfio_pci_irq_disable(vdev);
 
     /*
      * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
@@ -1410,7 +1410,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
     Error *err = NULL;
     int ret, nr;
 
-    if (!vfio_intx_enable(vdev, &err)) {
+    if (!vfio_pci_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -1618,9 +1618,9 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     }
 
     if (msi_enabled(pdev)) {
-        vfio_msi_enable(vdev);
+        vfio_pci_msi_enable(vdev);
     } else if (msix_enabled(pdev)) {
-        vfio_msix_enable(vdev);
+        vfio_pci_msix_enable(vdev);
     }
 
     return ret;
@@ -1944,7 +1944,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_bars_prepare(vdev);
 
-    if (!vfio_msix_early_setup(vdev, errp)) {
+    if (!vfio_pci_msix_early_setup(vdev, errp)) {
         return false;
     }
 
@@ -2043,7 +2043,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    if (!vfio_pci_interrupt_setup(vdev, errp)) {
+    if (!vfio_pci_irq_setup(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -2097,7 +2097,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 out_deregister:
     vfio_display_exit(vdev);
     if (vdev->interrupt == VFIO_INT_INTx) {
-        vfio_intx_disable(vdev);
+        vfio_pci_intx_disable(vdev);
     }
     pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
@@ -2111,7 +2111,7 @@ out_unset_idev:
         pci_device_unset_iommu_device(pdev);
     }
 out_teardown:
-    vfio_pci_teardown_msi(vdev);
+    vfio_pci_msi_teardown(vdev);
     vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
@@ -2130,17 +2130,17 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_display_exit(vdev);
-    vfio_unregister_req_notifier(vdev);
-    vfio_unregister_err_notifier(vdev);
+    vfio_pci_unregister_req_notifier(vdev);
+    vfio_pci_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
-    vfio_disable_interrupts(vdev);
+    vfio_pci_irq_disable(vdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
-    vfio_pci_teardown_msi(vdev);
+    vfio_pci_msi_teardown(vdev);
     vfio_pci_disable_rp_atomics(vdev);
     vfio_pci_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
-- 
2.56.0


