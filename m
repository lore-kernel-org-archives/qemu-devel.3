Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F559C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN3A-0005ya-Li; Wed, 11 Jun 2025 11:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN38-0005ny-GC
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN36-0007Cw-7M
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pA9yFQZH+vk+flaeoJJGabmz2TfQN/RwC81Uw0R9Sds=;
 b=BifCbG07Rf124MVDKqsKpX9p6QgIds5fbOUfcREmmQQL2hvVOgoJKmRzo0wYCrp4TB7NQv
 L4zxk7d/39Mv9rGsPk30tAYbfGB2ejI1ELOh6yax7yE8+Zn9wJsBlekmQTPefWlc2Z1TYZ
 I8kGpBsmv3GBqrISa7LHkRPpjhzvAtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-FJ3XCkDDOyOsNrmusjabzA-1; Wed,
 11 Jun 2025 11:07:26 -0400
X-MC-Unique: FJ3XCkDDOyOsNrmusjabzA-1
X-Mimecast-MFC-AGG-ID: FJ3XCkDDOyOsNrmusjabzA_1749654445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48B4818089B5; Wed, 11 Jun 2025 15:07:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7782180045C; Wed, 11 Jun 2025 15:07:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/27] vfio/pci: vfio_notifier_cleanup
Date: Wed, 11 Jun 2025 17:06:17 +0200
Message-ID: <20250611150620.701903-26-clg@redhat.com>
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

Move event_notifier_cleanup calls to a helper vfio_notifier_cleanup.
This version is trivial, and does not yet use the vdev and nr parameters.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-17-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9ee36da626c319b166cab3d634842e28d4d58e10..06a7a63cf501deafe26b1a9172eb56fecf4deaf3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -68,6 +68,12 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
     return !ret;
 }
 
+static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
+                                  const char *name, int nr)
+{
+    event_notifier_cleanup(e);
+}
+
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
  * also be a huge overhead.  We try to get the best of both worlds by
@@ -180,7 +186,7 @@ fail_vfio:
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
                                           vdev->intx.route.irq);
 fail_irqfd:
-    event_notifier_cleanup(&vdev->intx.unmask);
+    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
@@ -212,7 +218,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
     }
 
     /* We only need to close the eventfd for VFIO to cleanup the kernel side */
-    event_notifier_cleanup(&vdev->intx.unmask);
+    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
 
     /* QEMU starts listening for interrupt events. */
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
@@ -311,7 +317,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->intx.interrupt);
+        vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
         return false;
     }
 
@@ -338,7 +344,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
 
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->intx.interrupt);
+    vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
 
     vdev->interrupt = VFIO_INT_NONE;
 
@@ -501,7 +507,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
     return;
 
 fail_kvm:
-    event_notifier_cleanup(&vector->kvm_interrupt);
+    vfio_notifier_cleanup(vector->vdev, &vector->kvm_interrupt, name, nr);
 fail_notifier:
     kvm_irqchip_release_virq(kvm_state, vector->virq);
     vector->virq = -1;
@@ -514,7 +520,7 @@ static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                           vector->virq);
     kvm_irqchip_release_virq(kvm_state, vector->virq);
     vector->virq = -1;
-    event_notifier_cleanup(&vector->kvm_interrupt);
+    vfio_notifier_cleanup(vdev, &vector->kvm_interrupt, "kvm_interrupt", nr);
 }
 
 static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
@@ -837,7 +843,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
             }
             qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
                                 NULL, NULL, NULL);
-            event_notifier_cleanup(&vector->interrupt);
+            vfio_notifier_cleanup(vdev, &vector->interrupt, "interrupt", i);
         }
     }
 
@@ -2958,7 +2964,7 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->err_notifier);
+        vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
         vdev->pci_aer = false;
     }
 }
@@ -2977,7 +2983,7 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
                         NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->err_notifier);
+    vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
 }
 
 static void vfio_req_notifier_handler(void *opaque)
@@ -3025,7 +3031,7 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->req_notifier);
+        vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
     } else {
         vdev->req_enabled = true;
     }
@@ -3045,7 +3051,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     }
     qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
                         NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->req_notifier);
+    vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
 
     vdev->req_enabled = false;
 }
-- 
2.49.0


