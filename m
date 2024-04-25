Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1E4C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzv06-0003O7-OT; Thu, 25 Apr 2024 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv05-0003NL-Jr
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv04-0001oD-3w
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714035759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eNcDG1VJzaPpA0lCCtCxqlIRTm1GX/3eib6em5LyLE=;
 b=A80ZjE8saucUrwNC7SwVXMj4kagELJxrCqMuVm16bf+piTirScHZzAj9a11v9Esr1S/9kt
 fRXHXlnXPTua0LzOnCD98sZTG2bKr3Fv+kms3f77fDSx9HLY0OB3qZrwIes+8fLY7LppNJ
 Bab2AgoN3bMGMzSfLAGCPNw6fyNydL0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-dKhk6_1vMkab0gIAT_lscA-1; Thu, 25 Apr 2024 05:02:35 -0400
X-MC-Unique: dKhk6_1vMkab0gIAT_lscA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9445D8032FA;
 Thu, 25 Apr 2024 09:02:35 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2B22166B31;
 Thu, 25 Apr 2024 09:02:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] vfio/ccw: Use g_autofree variable in
 vfio_ccw_register_irq_notifier()
Date: Thu, 25 Apr 2024 11:02:13 +0200
Message-ID: <20240425090214.400194-4-clg@redhat.com>
In-Reply-To: <20240425090214.400194-1-clg@redhat.com>
References: <20240425090214.400194-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ccw.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 90e4a534371684c08e112364e1537eb8979f73f4..6764388bc47a970329fce2233626ccb8178e0165 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -384,7 +384,7 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    struct vfio_irq_info *irq_info;
+    g_autofree struct vfio_irq_info *irq_info = NULL;
     size_t argsz;
     int fd;
     EventNotifier *notifier;
@@ -421,14 +421,14 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
     if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
               irq_info) < 0 || irq_info->count < 1) {
         error_setg_errno(errp, errno, "vfio: Error getting irq info");
-        goto out_free_info;
+        return;
     }
 
     if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
                          "vfio: Unable to init event notifier for irq (%d)",
                          irq);
-        goto out_free_info;
+        return;
     }
 
     fd = event_notifier_get_fd(notifier);
@@ -439,9 +439,6 @@ static void vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         qemu_set_fd_handler(fd, NULL, NULL, vcdev);
         event_notifier_cleanup(notifier);
     }
-
-out_free_info:
-    g_free(irq_info);
 }
 
 static void vfio_ccw_unregister_irq_notifier(VFIOCCWDevice *vcdev,
-- 
2.44.0


