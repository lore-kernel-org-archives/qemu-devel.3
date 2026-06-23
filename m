Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D6ECDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvou-0002Ol-8I; Tue, 23 Jun 2026 03:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvor-0002OT-0D
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvop-0007x0-7q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jO7NTyqZIFny9BsTp3wlzPTLQv3yKAF2eQx+6+opB8=;
 b=I0yKHk3LQ8y1FP3uvLkuV+DscoySsPhf2TixnlQQEakB8jQbR8UZ8Fmd/Ydi8dHmdI0Xke
 1SAP955te0FQFxU9XMkxgRT+iuNC8ipw+mpgfmB/LWt5S3FYyztZMVy1zaCAVkn5FStViv
 gAmzzRqnTUQNN2XkvRf95kEbjdZaLg4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-DGbrG7StNFuiwpy8OJwcLw-1; Tue,
 23 Jun 2026 03:45:09 -0400
X-MC-Unique: DGbrG7StNFuiwpy8OJwcLw-1
X-Mimecast-MFC-AGG-ID: DGbrG7StNFuiwpy8OJwcLw_1782200707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B13FD19560B4; Tue, 23 Jun 2026 07:45:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B897195608C; Tue, 23 Jun 2026 07:45:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:20 +0400
Subject: [PATCH v4 05/34] vfio/pci: close display console during unrealize,
 not finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-5-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pLWa+XVHn/Q+NSKVadtf3ObvQXqUqMOfKYU3sjRlxaw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldIhogQ7Vsz36nKrlBOChPi/o59aRGxuq6u
 ic0atsFlfyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5YcjD/9DLsJrn+5I+suI6qG9TpWX58Y0pzw+2qi1GQy0zfNpT28U6dQy/6CwxIQb8WsSJ1g/iZV
 tAFmjAPAoZKfBnqXCJtAR0z1PBo2Kyus4ITx+Ce78C9bDEb9fCLvJ2LK+w5Vr4P3KkFk9tEAwq6
 4gRgEZlrKHKZ/hmPFlZAQ4VSdLL4HbUyCvl4jLojeLDKjpBr8A6LVwzfyPObpD9qYz33x+Wr1wy
 FYtsG2DYUWx44HPMg9k9vec7KseFD0naXOhCyGt33JiE3GSjlchL5J2aDuWQZjZrKAfxIL+9ME1
 dS2fHmxwm+KkE5zZ1TaWnBEKlCtTYz9VCzRTh4AZs0XXnfEirFbnPuf3Q3CgXFwfGfL13oCFrMP
 sfbgSJWu9PWHHDOUYyfe9l1fv7oljYwFknPW4NY5BjzkuQxpIrnisjoO1kcrWTDhnAqdm3Lejp4
 7xXLWAQUt7XBUbIDdqOP6MyuFgFqmGyFgOcLaK/rxzxMuKavvpSrrLrl2T3AjiremNUr4BoDhZK
 C+MzmFUEvQ4dL5D1HNCuKBYQ2y0HHwC3ddZ7svraocD6Z5pNHC0RKgP/TXd3W9vYuekZypaFKxJ
 uAaiSpqufS7J5bl6q8GttS/Y2qEBEwjIiBlZi5QWTXNtRCLhCFotvTGps0liQJCJTTTPoabOhS9
 w/oo+M3F+TMlxmw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QemuGraphicConsole holds a strong QOM link back to the device via
its "device" property (OBJ_PROP_LINK_STRONG). When graphic_console_close()
is only called from vfio_display_finalize() during object finalize, this
creates a ref-cycle deadlock: the device can't reach refcount 0 because
the console holds a strong ref, but the console's ref is only dropped by
graphic_console_close() which runs inside finalize.

Split the display teardown into two phases:
- vfio_display_exit(): called during unrealize (vfio_exitfn), closes
  the graphic console to break the ref cycle, and removes display
  region subregions while the parent memory regions are still alive.
- vfio_display_finalize(): remains in finalize (vfio_pci_put_device),
  frees display region memory, dmabuf, and edid resources. The region
  memory contains QOM child objects (MemoryRegions) that must stay
  alive until QOM finalization has processed them.

Acked-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS       |  1 +
 hw/vfio/pci.h     |  1 +
 hw/vfio/display.c | 29 +++++++++++++++++------------
 hw/vfio/pci.c     |  2 ++
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f6..35f87b7c9a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2347,6 +2347,7 @@ S: Supported
 F: hw/vfio/*
 F: util/vfio-helpers.c
 F: include/hw/vfio/
+F: docs/devel/vfio-mdpy.rst
 F: docs/devel/migration/vfio.rst
 F: qapi/vfio.json
 F: migration/vfio-stub.c
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d350..cf567115870 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -270,6 +270,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 void vfio_display_reset(VFIOPCIDevice *vdev);
 bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
+void vfio_display_exit(VFIOPCIDevice *vdev);
 void vfio_display_finalize(VFIOPCIDevice *vdev);
 
 extern const VMStateDescription vfio_display_vmstate;
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 8f91e83da88..cb83d98e9af 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -505,15 +505,6 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_display_region_exit(VFIODisplay *dpy)
-{
-    if (!dpy->region.buffer.size) {
-        return;
-    }
-
-    vfio_region_exit(&dpy->region.buffer);
-    vfio_region_finalize(&dpy->region.buffer);
-}
 
 /* ---------------------------------------------------------------------- */
 
@@ -547,17 +538,31 @@ bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     return false;
 }
 
-void vfio_display_finalize(VFIOPCIDevice *vdev)
+void vfio_display_exit(VFIOPCIDevice *vdev)
 {
     if (!vdev->dpy) {
         return;
     }
 
-    qemu_graphic_console_close(vdev->dpy->con);
     vfio_display_dmabuf_exit(vdev->dpy);
-    vfio_display_region_exit(vdev->dpy);
+    qemu_graphic_console_close(vdev->dpy->con);
+    if (vdev->dpy->region.buffer.size) {
+        vfio_region_exit(&vdev->dpy->region.buffer);
+    }
+}
+
+void vfio_display_finalize(VFIOPCIDevice *vdev)
+{
+    if (!vdev->dpy) {
+        return;
+    }
+
+    if (vdev->dpy->region.buffer.size) {
+        vfio_region_finalize(&vdev->dpy->region.buffer);
+    }
     vfio_display_edid_exit(vdev->dpy);
     g_free(vdev->dpy);
+    vdev->dpy = NULL;
 }
 
 static bool migrate_needed(void *opaque)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e637..7d57eb4f478 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3591,6 +3591,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     return;
 
 out_deregister:
+    vfio_display_exit(vdev);
     if (vdev->interrupt == VFIO_INT_INTx) {
         vfio_intx_disable(vdev);
     }
@@ -3624,6 +3625,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    vfio_display_exit(vdev);
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(pdev, NULL);

-- 
2.54.0


