Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A370C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihD-0003g7-4H; Wed, 22 May 2024 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih0-0003XV-SW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igk-0001Pz-Cf
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYGjldkPYHoH5A5sfKwcPOo2ffdx4sbmA1HzAej7FO0=;
 b=U6fzVryKbYvBZtXnyI60YSE9QEDUhFonYR51lfJLpeFcR64VBt3nZUgnxIrQYj7Tt6Ufh3
 7JJmKL5ufRIQEvism+GazEjpkh+4txNKG38cYXbHv/z3LmR8B3xLQS65bQo77b56VLjsn+
 OvMTW4w83taOuCXxdIiIYfUfpjuUJ3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-wMN70ybSPLeA5XI_5yOQkQ-1; Wed, 22 May 2024 05:55:08 -0400
X-MC-Unique: wMN70ybSPLeA5XI_5yOQkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 723AE85A58C;
 Wed, 22 May 2024 09:55:08 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 351A528E3;
 Wed, 22 May 2024 09:55:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 13/47] vfio/ccw: Make vfio_ccw_register_irq_notifier() return a
 bool
Date: Wed, 22 May 2024 11:54:08 +0200
Message-ID: <20240522095442.195243-14-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since vfio_ccw_register_irq_notifier() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h Rules
section.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 6764388bc47a970329fce2233626ccb8178e0165..1c630f6e9abe93ae0c2b5615d4409669f096c8c9 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -379,7 +379,7 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
+static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            unsigned int irq,
                                            Error **errp)
 {
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
-        return;
+        return false;
     }
 
     if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
                          "vfio: Unable to init event notifier for irq (%d)",
                          irq);
-        return;
+        return false;
     }
 
     fd = event_notifier_get_fd(notifier);
@@ -439,6 +439,8 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(notifier);
     }
+
+    return true;
 }
 
 static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
@@ -602,20 +604,18 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
2.45.1


