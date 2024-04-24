Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EC8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzc9b-0003a0-E8; Wed, 24 Apr 2024 08:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzc99-00039n-2H
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzc94-0007XV-IT
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713963281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qVynGe+t5z5NyGs0+Qd10ORM1+RjFFwRMd09+L7iEaM=;
 b=QiTLYD37IwuQFIEEh5q9qqokS4xuNvkBbzC0+Ta1P0RSRrKWkF4cFWMJAlKAkiCOCedtXE
 UeIgmrf//tOEo4DOSjhYngxSQ/XDBrngHAdRirE1LFxxNmuxqfQirIEBK4VWXyvLCbP7GU
 pR9MnLSoXSMBZzLVSsqlL2ww9dZRumE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10--WmtGsSKPa2Q2xgWhZS6vA-1; Wed,
 24 Apr 2024 08:54:37 -0400
X-MC-Unique: -WmtGsSKPa2Q2xgWhZS6vA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 912DE29AC018;
 Wed, 24 Apr 2024 12:54:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35823EC682;
 Wed, 24 Apr 2024 12:54:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] vfio/ap: Use g_autofree variable
Date: Wed, 24 Apr 2024 14:54:32 +0200
Message-ID: <20240424125432.215886-1-clg@redhat.com>
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

Also change the return value of vfio_ap_register_irq_notifier() to be
a bool since it takes and 'Error **' argument. See the qapi/error.h
Rules section.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7c4caa5938636937680fec87e999249ac84a4498..8bb024e2fde4a1d72346dee4b662d762374326b9 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -70,14 +70,14 @@ static void vfio_ap_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
+static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
     size_t argsz;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    struct vfio_irq_info *irq_info;
+    g_autofree struct vfio_irq_info *irq_info = NULL;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -87,13 +87,13 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
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
@@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
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
@@ -123,9 +123,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         event_notifier_cleanup(notifier);
     }
 
-out_free_info:
-    g_free(irq_info);
-
+    return true;
 }
 
 static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
@@ -171,8 +169,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         goto error;
     }
 
-    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
-    if (err) {
+    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err)) {
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
-- 
2.44.0


