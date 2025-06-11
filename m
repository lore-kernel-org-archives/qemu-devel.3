Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE02C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3A-0005w1-2m; Wed, 11 Jun 2025 11:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN32-0005cg-JS
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN30-0007By-Pj
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lG8a96YdjQCH9XXM3WHbjpwIIIH7Gvf8mUYoPYWvZsY=;
 b=BKZxXEeTgz9B+WapTADH9VhpcxHr4sZ7l4CVngbgkvTisgiZX69LHZgn/F5I/NFC0GnrX2
 4lvOYUXWFi+E5KrG4zyLg8//cjyul1gV2q7ml5NmMKxaQMr5hlWVA/nPjpDVHXiyiQbIoS
 GXGJY3Dmpf79vIum7H0xBKMXmd34Ljk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184---Ks2alsPe69cqT20_j27g-1; Wed,
 11 Jun 2025 11:07:24 -0400
X-MC-Unique: --Ks2alsPe69cqT20_j27g-1
X-Mimecast-MFC-AGG-ID: --Ks2alsPe69cqT20_j27g_1749654443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49D5D1956080; Wed, 11 Jun 2025 15:07:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87478180045B; Wed, 11 Jun 2025 15:07:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/27] vfio/pci: vfio_notifier_init cpr parameters
Date: Wed, 11 Jun 2025 17:06:16 +0200
Message-ID: <20250611150620.701903-25-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

From: Steve Sistare <steven.sistare@oracle.com>

Pass vdev and nr to vfio_notifier_init, for use by CPR in a subsequent
patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-16-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1d22c41efb6c6150ca1dff6ace752faad4a0fcfd..9ee36da626c319b166cab3d634842e28d4d58e10 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -57,7 +57,8 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
-static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
+                               const char *name, int nr, Error **errp)
 {
     int ret = event_notifier_init(e, 0);
 
@@ -147,7 +148,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
     }
 
@@ -300,7 +301,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
+    if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
+                            errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -486,7 +488,8 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
         return;
     }
 
-    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
+    if (!vfio_notifier_init(vector->vdev, &vector->kvm_interrupt, name, nr,
+                            NULL)) {
         goto fail_notifier;
     }
 
@@ -544,12 +547,13 @@ static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
-    Error *err = NULL;
+    Error *local_err = NULL;
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
-        error_report_err(err);
+    if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", nr,
+                            &local_err)) {
+        error_report_err(local_err);
     }
     vector->use = true;
     if (vdev->interrupt == VFIO_INT_MSIX) {
@@ -765,14 +769,15 @@ retry:
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
-        Error *err = NULL;
+        Error *local_err = NULL;
 
         vector->vdev = vdev;
         vector->virq = -1;
         vector->use = true;
 
-        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
-            error_report_err(err);
+        if (!vfio_notifier_init(vdev, &vector->interrupt, "interrupt", i,
+                                &local_err)) {
+            error_report_err(local_err);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2939,7 +2944,8 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->err_notifier, "err_notifier", 0,
+                            &err)) {
         error_report_err(err);
         vdev->pci_aer = false;
         return;
@@ -3006,7 +3012,8 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
+    if (!vfio_notifier_init(vdev, &vdev->req_notifier, "req_notifier", 0,
+                            &err)) {
         error_report_err(err);
         return;
     }
-- 
2.49.0


