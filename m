Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24B8C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3C-00065O-97; Wed, 11 Jun 2025 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2z-0005br-Q7
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2y-0007BU-29
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ZCUI4orxnF82b1y3t9R6rH4WLabU1ZdInS/jhGwZkA=;
 b=Siede8fzYkyHqx1O2I8OVp/MvKZjkYntwfRmw4Nndp3rXiaJDQEFZ70nqaVoDQQmX3XcW6
 ppp1Cg1YFUzeqe+QC1tXFPLA13mxVGYNZpTjb4QNC1e/xSWvqG7weye+XKQJtAbjyKsr3V
 8p0Q0kTTejRlczOJ/gcP3jbLU1oHJkQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-zbmHHeWzPhuLxOHFmN8peQ-1; Wed,
 11 Jun 2025 11:07:21 -0400
X-MC-Unique: zbmHHeWzPhuLxOHFmN8peQ-1
X-Mimecast-MFC-AGG-ID: zbmHHeWzPhuLxOHFmN8peQ_1749654439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8BB18002ED; Wed, 11 Jun 2025 15:07:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46D65180045B; Wed, 11 Jun 2025 15:07:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/27] vfio/pci: vfio_notifier_init
Date: Wed, 11 Jun 2025 17:06:14 +0200
Message-ID: <20250611150620.701903-23-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Steve Sistare <steven.sistare@oracle.com>

Move event_notifier_init calls to a helper vfio_notifier_init.
This version is trivial, but it will be expanded to support CPR
in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-14-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7a33c19ea28c454221ee430784e5d84cf498486b..dc0d9a7fbb939cdcae58c40e7bd33b0a2c1bd3ec 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -57,6 +57,16 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+{
+    int ret = event_notifier_init(e, 0);
+
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+    }
+    return !ret;
+}
+
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
  * also be a huge overhead.  We try to get the best of both worlds by
@@ -137,8 +147,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (event_notifier_init(&vdev->intx.unmask, 0)) {
-        error_setg(errp, "event_notifier_init failed eoi");
+    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
         goto fail;
     }
 
@@ -269,7 +278,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
     int32_t fd;
-    int ret;
 
 
     if (!pin) {
@@ -292,9 +300,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    ret = event_notifier_init(&vdev->intx.interrupt, 0);
-    if (ret) {
-        error_setg_errno(errp, -ret, "event_notifier_init failed");
+    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -474,11 +480,13 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 
 static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
 {
+    const char *name = "kvm_interrupt";
+
     if (vector->virq < 0) {
         return;
     }
 
-    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
+    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
         goto fail_notifier;
     }
 
@@ -535,11 +543,12 @@ static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
+    Error *err = NULL;
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (event_notifier_init(&vector->interrupt, 0)) {
-        error_report("vfio: Error: event_notifier_init failed");
+    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+        error_report_err(err);
     }
     vector->use = true;
     if (vdev->interrupt == VFIO_INT_MSIX) {
@@ -755,13 +764,14 @@ retry:
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
+        Error *err = NULL;
 
         vector->vdev = vdev;
         vector->virq = -1;
         vector->use = true;
 
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
+        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+            error_report_err(err);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2928,8 +2938,8 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->err_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for error detection");
+    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+        error_report_err(err);
         vdev->pci_aer = false;
         return;
     }
@@ -2995,8 +3005,8 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->req_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for device request");
+    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
+        error_report_err(err);
         return;
     }
 
-- 
2.49.0


