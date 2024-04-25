Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821BDC19F53
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzv05-0003NS-Re; Thu, 25 Apr 2024 05:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv04-0003Mf-Qx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv02-0001nu-SH
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714035758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gZ/10KPoJK3IMZD3iL7+DokD5HCisGHRG2Tt18eUng=;
 b=EuLeBXvG7A5tgKq0HOQxMvaH/AQqGdg4d8dXsF5v9xqjEdXAOzu2EQiliaXqT7AjO89ce6
 W7m7JaPBFFksNWB9p+uvjwTy5SvQzyzly3bgIFOMXSJhd+AuVjh0c+SxYwULD8s1B39bbA
 xvq+42L/f2YF9Yl0eMI6TJ1bHIrFFSo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-qyu54uJOMzu4Q01ItNaixg-1; Thu, 25 Apr 2024 05:02:34 -0400
X-MC-Unique: qyu54uJOMzu4Q01ItNaixg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B070880E95E;
 Thu, 25 Apr 2024 09:02:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33A872166B34;
 Thu, 25 Apr 2024 09:02:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] vfio/ap: Make vfio_ap_register_irq_notifier() return a
 bool
Date: Thu, 25 Apr 2024 11:02:12 +0200
Message-ID: <20240425090214.400194-3-clg@redhat.com>
In-Reply-To: <20240425090214.400194-1-clg@redhat.com>
References: <20240425090214.400194-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Since vfio_ap_register_irq_notifier() takes and 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h Rules
section.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 03f8ffaa5e2bf13cf8daa2f44aa4cf17809abd94..8bb024e2fde4a1d72346dee4b662d762374326b9 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -70,7 +70,7 @@ static void vfio_ap_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
+static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
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
@@ -122,6 +122,8 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
     }
+
+    return true;
 }
 
 static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
@@ -167,8 +169,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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


