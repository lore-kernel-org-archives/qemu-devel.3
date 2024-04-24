Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16DDC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzc9Z-0003W6-Rr; Wed, 24 Apr 2024 08:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzc9F-0003GX-Qs
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzc9B-0007YB-Sv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713963287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3uxEL/eaBitS4ripjbD/SsCCxCLbXLWasb2GwhrpJVk=;
 b=djNx1HtzaQY8T2We8DvU6+spulOCQb9g2ymWjbw36tdRuNUCD/prF7//A5KQrFHHLqhY7t
 gRqDNw+c3WPng7R2ArQFPCyx8qTYBGgcUprgJN1bk0qh5CEUQSlRbmOICI8rNrOyZ7jeZT
 Jos+/jYZHl95ouLhzRM1fL5YXScR7jA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-QZvwdj7EOtefTQbjO3hdvw-1; Wed, 24 Apr 2024 08:54:45 -0400
X-MC-Unique: QZvwdj7EOtefTQbjO3hdvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B5E280D678;
 Wed, 24 Apr 2024 12:54:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62F16EC683;
 Wed, 24 Apr 2024 12:54:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] vfio/ccw: Use g_autofree variable
Date: Wed, 24 Apr 2024 14:54:41 +0200
Message-ID: <20240424125441.215953-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Also change the return value of vfio_ccw_register_irq_notifier() to be
a bool since it takes and 'Error **' argument. See the qapi/error.h
Rules section.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 90e4a534371684c08e112364e1537eb8979f73f4..1c630f6e9abe93ae0c2b5615d4409669f096c8c9 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -379,12 +379,12 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
+static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            unsigned int irq,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    struct vfio_irq_info *irq_info;
+    g_autofree struct vfio_irq_info *irq_info = NULL;
     size_t argsz;
     int fd;
     EventNotifier *notifier;
@@ -405,13 +405,13 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         break;
     default:
         error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
-        return;
+        return false;
     }
 
     if (vdev->num_irqs < irq + 1) {
         error_setg(errp, "vfio: IRQ %u not available (number of irqs %u)",
                    irq, vdev->num_irqs);
-        return;
+        return false;
     }
 
     argsz = sizeof(*irq_info);
@@ -421,14 +421,14 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
     if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
               irq_info) < 0 || irq_info->count < 1) {
         error_setg_errno(errp, errno, "vfio: Error getting irq info");
-        goto out_free_info;
+        return false;
     }
 
     if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
                          "vfio: Unable to init event notifier for irq (%d)",
                          irq);
-        goto out_free_info;
+        return false;
     }
 
     fd = event_notifier_get_fd(notifier);
@@ -440,8 +440,7 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         event_notifier_cleanup(notifier);
     }
 
-out_free_info:
-    g_free(irq_info);
+    return true;
 }
 
 static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
@@ -605,20 +604,18 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_region_err;
     }
 
-    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
-    if (err) {
+    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err)) {
         goto out_io_notifier_err;
     }
 
     if (vcdev->crw_region) {
-        vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX, &err);
-        if (err) {
+        if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX,
+                                            &err)) {
             goto out_irq_notifier_err;
         }
     }
 
-    vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &err);
-    if (err) {
+    if (!vfio_ccw_register_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX, &err)) {
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
-- 
2.44.0


