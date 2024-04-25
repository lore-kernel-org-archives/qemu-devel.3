Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89427C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzv06-0003Nr-6g; Thu, 25 Apr 2024 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv04-0003MZ-MD
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzv02-0001nc-1A
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714035756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+C5YBph1gPYL7SiqnOtT3ZSLnOZz+k2TjkkuGQcsy28=;
 b=Ri+YFFe1/TvhLyeH4OP8XDJK+AyyoM56RYbagNwtgkk3BKYolsXLiuhah6yc4mQL1pROAn
 LxnAhbge6Xcd9QCh/FmUXvvD3QDlFxiqQXU8dvNF0slAUggxTw3+wHUZq0G71s64DAHNcO
 ksDffzEqiBnxHIDbqgumY1B+kFnQtws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-HurBy0ciNzu_3bETNknDVA-1; Thu, 25 Apr 2024 05:02:32 -0400
X-MC-Unique: HurBy0ciNzu_3bETNknDVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABA098065D2;
 Thu, 25 Apr 2024 09:02:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.195.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB7472166AE1;
 Thu, 25 Apr 2024 09:02:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] vfio/ap: Use g_autofree variable in
 vfio_ap_register_irq_notifier()
Date: Thu, 25 Apr 2024 11:02:11 +0200
Message-ID: <20240425090214.400194-2-clg@redhat.com>
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
 hw/vfio/ap.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7c4caa5938636937680fec87e999249ac84a4498..03f8ffaa5e2bf13cf8daa2f44aa4cf17809abd94 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -77,7 +77,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
     size_t argsz;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    struct vfio_irq_info *irq_info;
+    g_autofree struct vfio_irq_info *irq_info = NULL;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
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
@@ -122,10 +122,6 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         qemu_set_fd_handler(fd, NULL, NULL, vapdev);
         event_notifier_cleanup(notifier);
     }
-
-out_free_info:
-    g_free(irq_info);
-
 }
 
 static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
-- 
2.44.0


