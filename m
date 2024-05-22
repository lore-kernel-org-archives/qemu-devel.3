Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CD4C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 10:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihE-0003hI-7Q; Wed, 22 May 2024 05:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih9-0003cB-0I
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih6-0001kU-AN
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMOxYYRcoL+OG3/njrsJOgo7fJUzW9n8pgdZCpEu3hI=;
 b=GjC3NHb892PA4KUv/X/30qXF5uEP+wRLLwx9lQt2+1zWp0pOQEV7lZGUfKBXd4pwjo9Hlr
 DRQvPuwmqlQhz0qjT9aVFrCnbXiaMR8t4OYpvRur0dehAjpqRjtvBx8jkwPlAo5Jgao/xh
 Vklf7uVSMveqIy2eizgQJzwcCI2YYEE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-QkjBp-0uP1O6yAeCcW9SHg-1; Wed, 22 May 2024 05:55:33 -0400
X-MC-Unique: QkjBp-0uP1O6yAeCcW9SHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6B91857A83;
 Wed, 22 May 2024 09:55:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDE42870;
 Wed, 22 May 2024 09:55:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/47] vfio/display: Fix error path in call site of
 ramfb_setup()
Date: Wed, 22 May 2024 11:54:25 +0200
Message-ID: <20240522095442.195243-31-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

vfio_display_dmabuf_init() and vfio_display_region_init() calls
ramfb_setup() without checking its return value.

So we may run into a situation that vfio_display_probe() succeed
but errp is set. This is risky and may lead to assert failure in
error_setv().

Cc: Gerd Hoffmann <kraxel@redhat.com>
Fixes: b290659fc3d ("hw/vfio/display: add ramfb support")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index fe624a6c9b86e7204e2763ab62ef60903f19d350..d28b724102d5970cb2b9dc7464dc7575b6f441d9 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -361,6 +361,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     vfio_display_edid_init(vdev);
     return 0;
@@ -488,6 +491,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           vdev);
     if (vdev->enable_ramfb) {
         vdev->dpy->ramfb = ramfb_setup(errp);
+        if (!vdev->dpy->ramfb) {
+            return -EINVAL;
+        }
     }
     return 0;
 }
-- 
2.45.1


