Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A012CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzc-0007bO-Q1; Wed, 24 Jun 2026 07:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLza-0007au-3r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzY-0007bR-I9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCYvLYmEeD5QhRXhLF6IjSZt7kmsPPjuNwnFozuJR7Q=;
 b=e3LqBmha2MT0Jb+DzinvXs4qhH11EOtOoz0b+93R9g8dR8BvaVx4ybdVyigk7GCijl8Eh6
 +97i+lAOSUpPd7LaMnAkyH0WQf6FUHp/nKqeFkyDrttCSnyAuMcUjR5mAgQzP9xx3sX7yv
 jz0e8FAivHniYP9LXG4QAx2v4WDXPZw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-HrR8lrD8NeOyIjViVeCDMw-1; Wed,
 24 Jun 2026 07:42:02 -0400
X-MC-Unique: HrR8lrD8NeOyIjViVeCDMw-1
X-Mimecast-MFC-AGG-ID: HrR8lrD8NeOyIjViVeCDMw_1782301321
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28BBD1801F09
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:42:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA66918004D4; Wed, 24 Jun 2026 11:41:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:27 +0400
Subject: [GIT PULL 05/35] vfio/pci: close display console during unrealize,
 not finalize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-5-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4370;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LPLSQM+FEtLfSBulNP9xzMByZoehhoO5YKhU9Vpd1bo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JmpYMx+Ywwp0+MXPG+dWgNUquoHfnJsP7NQ
 X1OG79mCo6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5Ws3D/9rOawyQhPuorlJwbJY8vAvV3ou5rkf5s/ZMrL+2BgOnhlKFsN5CQYrCVtnqmt9DoaEgdT
 ewVnKsNc7mKmG0qYiqnD2huigIMDQ4Z8K5g9vidN6k6+ImyoZoSVPY650MqXFUJmB1KDLwU/jJB
 f/heMR0LyIaSEoPuZZiliwFnKVo17MlECfjgMQuW52aJWt/sQQHBWYYakKsPiWNUq2n69mlf2T1
 cB/GhY61Ez5tppW5VNyxYUQpG8VXH1tK9e6jXB0ockqcFWBLn+z45NK5VI/Mzm7GNFop74XwRd9
 DxYAQ5/ZrmZ8C4YRCIB0O+NHNjKY2k34H8+teu3MQ52hTo4Qikhuk8KWjrj7u4JnMaUPjwsb+vz
 O2apBOu8uAa1EXleOqF8YRmIC722eg3JiunMiwSHkYfmcS0jJRIdLjkW0bvIAK6RcQi0svfEh9c
 OKEq+7FJop2Q0GlvIR6pkrgvMtcykXhYGeXFjALxgdcMb/1k9aZ7Ap9T+if65JGw2xslKGyhnJp
 rU/PvJKNF0iFKM+fahL4/p2tJ6C95I5Hp6aEX7fVulOkyvlXx9EtsxfVlm/vyevRI9AXdKkW1J+
 rwA6QLh5Qzekd1id1leUnwRglxI/LO2940W6mMQjgB7jCydD3y5Q7hIlVpTLX6GtIYvRvtqKFbS
 lUvMBrgt09hSMxA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Acked-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-5-4656aec3398d@redhat.com>
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


