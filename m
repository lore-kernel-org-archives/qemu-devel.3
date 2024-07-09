Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F919C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9My-0005YW-5H; Tue, 09 Jul 2024 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Ms-0005Af-Fl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mq-0006Lb-VX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8taY1k+UlGNUyqXc/omqsBgz7mHZ39E8IuXRU5oAeUo=;
 b=eIP8nBnOyry+KCG1i87tS2RiCg5juORfzPOFhpRdytKos3LwEKecOWxNjrHW84Dpt7KOLu
 +s7XTyLF3UmsvUCnUE0b/a4Rdyf3HUG+x2GAAXVSLiEfToz0zkqVw8hSWyXEKAfQlAfJtY
 wvia12w5TiLHRhwjPWNkLKZhdkJKw4s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-zrNK9WcKMZ6_1QK9o4vylQ-1; Tue,
 09 Jul 2024 07:50:42 -0400
X-MC-Unique: zrNK9WcKMZ6_1QK9o4vylQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B391819560B3; Tue,  9 Jul 2024 11:50:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1C633000183; Tue,  9 Jul 2024 11:50:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 9/9] vfio/display: Fix vfio_display_edid_init() error path
Date: Tue,  9 Jul 2024 13:50:17 +0200
Message-ID: <20240709115017.798043-10-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

vfio_display_edid_init() can fail for many reasons and return silently.
It would be good to report the error.

Old mdev driver may not support vfio edid region and we allow to go
through in this case.

vfio_display_edid_update() isn't changed because it can be called at
runtime when UI changes (i.e. window resize).

Fixes: 08479114b0de ("vfio/display: add edid support.")
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/vfio/display.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 9c57fd388886100bf9eae061def39688d33a8695..ea87830fe0d5fc66f3f27a16bde5d75b7b6280c0 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -124,7 +124,7 @@ static void vfio_display_edid_ui_info(void *opaque, uint32_t idx,
     }
 }
 
-static void vfio_display_edid_init(VFIOPCIDevice *vdev)
+static bool vfio_display_edid_init(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODisplay *dpy = vdev->dpy;
     int fd = vdev->vbasedev.fd;
@@ -135,7 +135,8 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                    VFIO_REGION_SUBTYPE_GFX_EDID,
                                    &dpy->edid_info);
     if (ret) {
-        return;
+        /* Failed to get GFX edid info, allow to go through without edid. */
+        return true;
     }
 
     trace_vfio_display_edid_available();
@@ -167,15 +168,16 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
                                         vfio_display_edid_link_up, vdev);
 
     vfio_display_edid_update(vdev, true, 0, 0);
-    return;
+    return true;
 
 err:
+    error_setg(errp, "vfio: failed to read GFX edid field");
     trace_vfio_display_edid_write_error();
     g_free(dpy->edid_info);
     g_free(dpy->edid_regs);
     dpy->edid_info = NULL;
     dpy->edid_regs = NULL;
-    return;
+    return false;
 }
 
 static void vfio_display_edid_exit(VFIODisplay *dpy)
@@ -368,8 +370,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
     }
-    vfio_display_edid_init(vdev);
-    return true;
+    return vfio_display_edid_init(vdev, errp);
 }
 
 static void vfio_display_dmabuf_exit(VFIODisplay *dpy)
-- 
2.45.2


