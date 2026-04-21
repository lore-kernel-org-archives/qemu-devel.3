Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E405F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE4e-0004nu-TK; Tue, 21 Apr 2026 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE40-0004aI-OS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3t-0007NJ-LI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIr7OAH7jPAt9Ijrp8ig0Z4yyQ3WYxYoNGA5UcPZCys=;
 b=c6bV1Daa7qVe58VW2QYE6r6lK//xNxe7C3uWbdTdEfMY3ZSEgmzMHlUi7wYfni9umO6EzN
 3QITOyJTC9siFbiez1AmZRIJ5iTLHH/M/TuGY4r8V5s301nspf7KGpZqVL1hKf3K1fSxvQ
 /mFku3Vg0Qx0/EcPFej3EIQUCScm90k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-aUIqYgI-N2ervx99N1yH0g-1; Tue,
 21 Apr 2026 12:34:54 -0400
X-MC-Unique: aUIqYgI-N2ervx99N1yH0g-1
X-Mimecast-MFC-AGG-ID: aUIqYgI-N2ervx99N1yH0g_1776789293
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773E81955F29; Tue, 21 Apr 2026 16:34:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C125D1956056; Tue, 21 Apr 2026 16:34:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/14] hw/vfio/pci.c: eradicate CONFIG_KVM
Date: Tue, 21 Apr 2026 18:34:29 +0200
Message-ID: <20260421163438.3447280-6-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We just need to add kvm_enabled() guard when calling concerned
functions, but no need to extract those kvm functions since they are not
using any kvm specific types that would not be visible at compilation
time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-6-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1f1f3aaad9a901a087ecad1b5c46e8756b3a6339..b2a07f6bb4217bcacead194ce75b359b1896ef3a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -152,7 +152,6 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
@@ -206,14 +205,10 @@ fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     return false;
-#else
-    return true;
-#endif
 }
 
 static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_KVM
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
@@ -236,14 +231,10 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.kvm_accel = true;
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
     return true;
-#else
-    return true;
-#endif
 }
 
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
-#ifdef CONFIG_KVM
     PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.kvm_accel) {
@@ -277,7 +268,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
     trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
-#endif
 }
 
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
@@ -287,7 +277,9 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     trace_vfio_intx_update(vdev->vbasedev.name,
                            vdev->intx.route.irq, route->irq);
 
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
 
     vdev->intx.route = *route;
 
@@ -295,7 +287,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -350,16 +342,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(pdev->config, pin);
 
-#ifdef CONFIG_KVM
     /*
      * Only conditional to avoid generating error messages on platforms
      * where we won't actually use the result anyway.
      */
-    if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
+    if (kvm_enabled() && kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
         vdev->intx.route = pci_device_route_intx_to_irq(pdev,
                                                         vdev->intx.pin);
     }
-#endif
 
     if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
                             errp)) {
@@ -370,7 +360,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
 
     if (cpr_is_incoming()) {
-        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
+        if (kvm_enabled() && !vfio_cpr_intx_enable_kvm(vdev, &err)) {
             warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         }
         goto skip_signaling;
@@ -383,7 +373,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (!vfio_intx_enable_kvm(vdev, &err)) {
+    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -400,7 +390,9 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
     int fd;
 
     timer_del(vdev->intx.mmap_timer);
-    vfio_intx_disable_kvm(vdev);
+    if (kvm_enabled()) {
+        vfio_intx_disable_kvm(vdev);
+    }
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(pdev);
-- 
2.53.0


