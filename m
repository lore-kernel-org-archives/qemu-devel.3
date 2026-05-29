Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC629CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDQ-0001CH-4d; Fri, 29 May 2026 07:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDO-0001Bk-6l
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDM-0008G9-LS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUnppt3zZ6J4KL/3jUgG//BerI9sXfCD2NeAfiGYx0E=;
 b=eMz0RbIkUn9T9hmHektU02go7onX6aPCqYQ9i2+gCFbwbUY9hQvox2rE1wg6CbMcGi+zux
 EjwYETV+gHKGkXTLFGtQdexWWrnPCEBDGAWLcT1ubeHT66vEqzIrdsH7TpQv/PZWIEeFdm
 1hvmkwUnIJLpTuGj4e9DSozvlCqoHo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-H9WSfipQM8yVYJYaxJ8CFg-1; Fri,
 29 May 2026 07:17:14 -0400
X-MC-Unique: H9WSfipQM8yVYJYaxJ8CFg-1
X-Mimecast-MFC-AGG-ID: H9WSfipQM8yVYJYaxJ8CFg_1780053433
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC68A180060F; Fri, 29 May 2026 11:17:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8DBA11800465; Fri, 29 May 2026 11:17:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:26 +0400
Subject: [PATCH 05/32] vfio/pci: close display console during unrealize,
 not finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-5-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ttKR1/sfL9cktoq6rbHU+J5rJDaU7RMjgOqYO6e1mjM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWPltb3cKVepBIG91NiEmrOif4orMn8xGCNw
 qk0xFDpKuWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jwAKCRDa6OEJdZac
 5WE7D/4rQ0y1hitU6hAzaioqr5HrgIIXkEe49k1LzynlsCAT5RaQqQJVw0AWt4u63wPhjSGQVKe
 7kwwM042PTLsLC4c/r3LcJjqDSZf2lcllJZqTRkBU0rzC8xHFirL4ewgaRjDLxAPqIdxhI6Tov6
 khCxZYw3FYvb7SKj4cIrPOgcIA6HJcS+HTxPgBZ5COpqJOk3y/4zGpryUpRriLf5h2o6zmOaQhJ
 g+QcFflItBt6/PQvIRZWSDQR+K+jz+XWv37Vd7spYqxOFEHlxdHYdWBZ4dQz9zw07Zz+Kdp7kur
 TXocn7CbERf1Ay89wNGDgWgGzcMv+tPY7WBwXFXWhY0rJY9jQUAU+pQTBCyn1MP0vHtrDJdc/1V
 s2PLqHTFaMT3G3QGTQoxAHfEDcEzEWIxNLhkRGFrR5ymwTDsXgjSePyW9VbYaGobdMoG2VxssNE
 71Vt1HcYoQuhnHH8LmUyYRwfOv2hzEaiS51wDlBD3nYAmb1mRSrEMHEYVjhGzUpTYTlvTqwOTLZ
 3kY9QkN6n0fE68q2sLJ9l15jbqciAa6CFftDrDjEqoepYladWxJ5YtXClrD/9eE6bpgg0t1HFK+
 LNUPxzWg+t3NzeuchJieMYp/9Qbfh+pukqr4sRdLkdY2IloX51XOfSwInJBXy3Or6IRjwShhySy
 nPEgOV56DusQV9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/vfio/pci.h     |  1 +
 hw/vfio/display.c | 30 +++++++++++++++++++-----------
 hw/vfio/pci.c     |  1 +
 3 files changed, 21 insertions(+), 11 deletions(-)

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
index 8f91e83da88..34cc25ee0e0 100644
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
 
@@ -547,17 +538,34 @@ bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
     return false;
 }
 
-void vfio_display_finalize(VFIOPCIDevice *vdev)
+void vfio_display_exit(VFIOPCIDevice *vdev)
 {
     if (!vdev->dpy) {
         return;
     }
 
+    if (display_opengl) {
+        qemu_console_set_display_gl_ctx(vdev->dpy->con, NULL);
+    }
     qemu_graphic_console_close(vdev->dpy->con);
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
     vfio_display_dmabuf_exit(vdev->dpy);
-    vfio_display_region_exit(vdev->dpy);
+    if (vdev->dpy->region.buffer.size) {
+        vfio_region_finalize(&vdev->dpy->region.buffer);
+    }
     vfio_display_edid_exit(vdev->dpy);
     g_free(vdev->dpy);
+    vdev->dpy = NULL;
 }
 
 static bool migrate_needed(void *opaque)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e637..78beacd24e1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3624,6 +3624,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    vfio_display_exit(vdev);
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(pdev, NULL);

-- 
2.54.0


