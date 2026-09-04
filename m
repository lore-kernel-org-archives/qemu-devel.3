Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C980EC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Th0-0003jw-AQ; Fri, 04 Sep 2026 09:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgw-0003g3-Sa
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2Tgv-000536-4p
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PE2y/oNgzTqJkspzOVg9RTCAjjRevuAKrC0Gi+I2jnI=;
 b=iIxw3iLr93fOwp7/p8kw5rrFByPU9ubDIHlyRLp71KeZLTvh23GO87LZWVqugiI05ASoyQ
 akWT1EESLLK7HgNPjXuCRyO0LknlS/6eguTPlPxlrjDhbsoAFwxTS+BN8y/RsTqHg4T2X8
 7hfQcmEc3Pvy3/ypyy33DzS5mOAIO9Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-rLyNd4uJO_iILrgVTuUCdQ-1; Fri,
 04 Sep 2026 09:10:44 -0400
X-MC-Unique: rLyNd4uJO_iILrgVTuUCdQ-1
X-Mimecast-MFC-AGG-ID: rLyNd4uJO_iILrgVTuUCdQ_1788527443
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F7E01893ECF; Fri,  4 Sep 2026 13:10:43 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 187F55BC; Fri,  4 Sep 2026 13:10:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 17:10:11 +0400
Subject: [PATCH v2 07/25] ui/gtk: move draw_submitted from QemuDmaBuf to
 VirtualGfxConsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-virtio-gpu-cleanup-v2-7-15b5ae6b0023@redhat.com>
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
In-Reply-To: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6194;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sbPg4GMfuImsj8Uxx32aC9Ecbd9b3gqJ9T++XNXhrqQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvddVT1QSsHzUsyynmFBNOmBhKMgXscyGPc
 j3kzePl0PaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5R9nD/9vS5DnAb7z66S17IWGxjUhacrDYQJnYyfrnDKjIbwpphFgEcqBi+ARmWGZeX/6TTItltV
 GP3smNmTAs8bNLF5e3JyQ1Y17uwWyCUhyZ9/nOshfw2Q73ORrif8pmIhUIO/jGB4ALA0tJ3CznV
 iYmRrQFvFElRQVC2hLujOTkkH3l7yZgcDNiUlABVRCFWxa/DmsZvsQ5+2EN2zaAlKRRgl1gviS1
 hbRheL126wDDWNNVDP77H5DA/400criWR99Z1xwNvtycA4nM1dBHmuBXAuLKML+/xcPHxqvS1dy
 yBXE+IBFqUPQhbcmehkZ6Uv1HbdRbKQe0YWmJzV+Oxy65yHY/i/vufsMMeLXctvdMsWla8B9aur
 8ed7J8na3M/e2VWhvSJV52+La0zSxRyjwIQjJchrQMu/0SQHVJ/5jLhHYRohEciXX8YfHIXzgHg
 5spbat3iHksYQNdkmhz8ml8rwLy1r69XhK0D/RaXAvXSoj2S0ZFrfqau4mS5trU39jqqAvqPJBz
 JWh0bYqSK4GG6XM2mNsRM4Zk+C3YJ0vFfdLOIgHbvjW7MxffNwVLy5tUGrOrdMO7yJoRfu7Ds2/
 JyXj6+vq+ABj5R2DEYUDp1sFUCg0bCgqbNWNaUYCIpiHLSgJro/PrlebRZZG+SXh1hDL0U7ysJ9
 fgGgOsAqYCNIkWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The draw_submitted flag on QemuDmaBuf is only used by the GTK display
backend to gate the draw pipeline and prevent gl_block refcount
imbalance when the guest submits frames faster than GTK draws them. It
is not an intrinsic property of the DMA-BUF but transient display
listener state.

Move it to VirtualGfxConsole, replacing the getter/setter calls with
direct struct member access. Reset the flag when the active dmabuf is
released in gd_gl_release_dmabuf().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/dmabuf.h |  2 --
 include/ui/gtk.h    |  1 +
 ui/dmabuf.c         | 13 -------------
 ui/gtk-egl.c        | 13 ++++++-------
 ui/gtk-gl-area.c    | 10 +++++-----
 ui/gtk.c            |  1 +
 6 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index 381583bd536c..b972099859f2 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -42,8 +42,6 @@ uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
 
 #endif
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 4b4ef50e3701..b66b9ca5c519 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -59,6 +59,7 @@ typedef struct VirtualGfxConsole {
     bool scanout_mode;
     bool has_dmabuf;
     int gl_fence_fd;
+    bool draw_submitted;
 #endif
 } VirtualGfxConsole;
 
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index b61dc7ad2783..16063dc62ae8 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -26,7 +26,6 @@ struct QemuDmaBuf {
     uint32_t  backing_height;
     bool      y0_top;
     bool      allow_fences;
-    bool      draw_submitted;
 };
 
 QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
@@ -212,21 +211,9 @@ bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
     return dmabuf->allow_fences;
 }
 
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->draw_submitted;
-}
-
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
 {
     assert(dmabuf != NULL);
     dmabuf->texture = texture;
 }
 
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
-{
-    assert(dmabuf != NULL);
-    dmabuf->draw_submitted = draw_submitted;
-}
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index c671aabd11b3..8623181336e9 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -86,10 +86,10 @@ void gd_egl_draw(VirtualConsole *vc)
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
+            if (!vc->gfx.draw_submitted) {
                 return;
             } else {
-                qemu_dmabuf_set_draw_submitted(dmabuf, false);
+                vc->gfx.draw_submitted = false;
             }
             qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
@@ -169,8 +169,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 #endif
     }
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.draw_submitted) {
         gd_egl_draw(vc);
         return;
     }
@@ -290,6 +289,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }
@@ -406,9 +406,8 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
+    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
+        vc->gfx.draw_submitted = true;
         gtk_egl_set_scanout_mode(vc, true);
     }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 29d1b1e4116f..45c0c8c81a11 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -82,10 +82,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
 
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
+            if (!vc->gfx.draw_submitted) {
                 return;
             } else {
-                qemu_dmabuf_set_draw_submitted(dmabuf, false);
+                vc->gfx.draw_submitted = false;
             }
             qemu_console_hw_gl_block(vc->gfx.dcl.con, true);
         }
@@ -319,9 +319,8 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
+    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.draw_submitted) {
+        vc->gfx.draw_submitted = true;
         gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
@@ -356,6 +355,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     if (qemu_dmabuf_get_allow_fences(dmabuf)) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }
diff --git a/ui/gtk.c b/ui/gtk.c
index 1c75b9ea3c4d..55e45e8445bc 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -593,6 +593,7 @@ static void gd_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
     if (vc->gfx.guest_fb.dmabuf == dmabuf) {
         vc->gfx.guest_fb.dmabuf = NULL;
+        vc->gfx.draw_submitted = false;
     }
 #endif
 }

-- 
2.55.0.543.g5ebe2ebe4ea8


