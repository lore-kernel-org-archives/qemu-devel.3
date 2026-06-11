Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD2BCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKi-0000E5-PJ; Thu, 11 Jun 2026 05:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKg-0000Cj-VD
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKf-0004cl-AZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8KCcxB/87JZWf00pdVP2Q3ZKQiVGJ/SAu2efz9MEMM=;
 b=Op0iZInGyVimr3iHzWu+JHApsPAUIzIpCevKK8O4qLJGTHW+34nEC/Rc7sZ557S/AnlnrT
 VKBXXq8TWyAsbVNtm2g7HcLnxgwgCG/QvsbAbXm/x7AAlX1EvyyVt+eHlcFsSKFyQRnmnw
 fopi+tJiwvIUmmXeA9ysRxJzNp0YXKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-zCFaqJ6DNVy4fEkBg22dCg-1; Thu,
 11 Jun 2026 05:04:08 -0400
X-MC-Unique: zCFaqJ6DNVy4fEkBg22dCg-1
X-Mimecast-MFC-AGG-ID: zCFaqJ6DNVy4fEkBg22dCg_1781168646
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E69A1955EA5; Thu, 11 Jun 2026 09:04:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3FDA180057F; Thu, 11 Jun 2026 09:04:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:20 +0400
Subject: [PATCH v3 05/35] vfio/pci: close display console during unrealize,
 not finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-5-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4013;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=K1oZPfnVuo07AbIZqxBLuVUWmmjqQNhuapL73uboTaM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnndsqDms/2WXDcdA+mf79HcIPQ81hKpFIgLD
 KOmFp84gh+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53QAKCRDa6OEJdZac
 5Y4bD/9ror9HzYrSC32OPiVm8eyyrb4gFGQ6ILiaMU4m9UXvt3ftSssr4lt4aUYRqr6wg5IOnA4
 7z2aaoj3Jdnz3Ra9Lwoh2oKuTjEchFf6M+xgBp7LBDti121/Fj/JdsHnKeGZ+f2mCm0PGUGb+2n
 L7/an2jBeZ3SDgCywTCO4VzO5WU+lldxYNbNzL4wJrVGu2V7GWykNmMVap+vptXUlCVWRT7/lnH
 Ur0wwdLYigK20q9D9VjTN2juObQsw7wuh6jmpDaLi6IetMNDhDraTr2FMSmse45WS7+uc+5fhme
 owwKy9aVA7JgaqOWASiTQxX7fp8bg7uL7R9KtbSD6x/VukBmmVNUL+EnUFZs/vktMv7x0fs3LDK
 eSw3ygEjVUtriNuTpY4j/rzFDJMoJb6UV/TUCSj+tonI+ZlZYUqWL8SLF3WGvL6HI1q9na6TL1F
 uHARZ1Xg7x3rrov21aXGPTIMaBIxSUpGJA94Wy8U7tn6vYx7UYzpazRKxCusgQvuoc2vgkqsDdz
 YXj/cj/RMI1fdzAGYgxs1aSMYf4DgDYjVe+D22vXHFRTnEPYnecS6a2xVpodbOfegD7FopPZQ5Y
 82RCOnTVAEOlRlNLkWjgPFsL63qu1e/yrJM6pYJcggekoceo5wLoC6FYURpealGBSw8OXMqINQo
 BuK1p7sl5MXwQ+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/vfio/pci.c     |  1 +
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 748ec77beb4..8320b37fc32 100644
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


