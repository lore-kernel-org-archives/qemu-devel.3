Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530F606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mr3BeULy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsK7-0008Oh-Ql; Fri, 13 Nov 2026 09:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIb-0007jd-BZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIZ-00068Z-Ah
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boVL+YPFQpURwiwZ//F+yK3LedXMmNngnhYKbtKW0I0=;
 b=Mr3BeULySCtkqZOemZukVVwI9Qy5cLYac2Gnc2flPvwJf2lg7jVPt3TEVsB+WwJUxcoo8g
 NEs8RiSWoWuN+CMj8s3WQKkpGNknD+jz32rAwMZUb7RIfGC9wS0PXoqVLRzyzyEzH+KCA1
 i2AeTmDXyJD9ygyJFiAlP6OMTM6wSVs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-Wg-OeOZWOTy6dJ_PH4sB-g-1; Fri,
 13 Nov 2026 09:30:36 -0500
X-MC-Unique: Wg-OeOZWOTy6dJ_PH4sB-g-1
X-Mimecast-MFC-AGG-ID: Wg-OeOZWOTy6dJ_PH4sB-g_1794580235
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 617F718005BC; Fri, 13 Nov 2026 14:30:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 022D6195E489; Fri, 13 Nov 2026 14:30:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 18:29:59 +0400
Subject: [PATCH v3 7/8] hw/display/vhost-user-gpu: fix scanout bookkeeping
 on the 2D path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v3-7-98e4fa3e77eb@redhat.com>
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
In-Reply-To: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lOf5MxEmLJPnyVq3COzD5WEd7J8Zyk+m0hta2VgDXkw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9x7mwm0Cx27c9Iwo8GIgjTwFWLIrQ8qirKxXk
 4s1+2W0LCmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavce5gAKCRDa6OEJdZac
 5bHyEACimurzv9ENsni0T6lLMbOfLUsBo94SQNk+klzV7ekgwJMk1sLUVOJ0vEDKrIZEXNtDL8q
 mQZaB1Hx9dlGItXxPhAYwQM+BxxLX8/vg/8qJgzTVr3A2d1zKj7oduwcYNXdUEoWdwCYS+Z8d9A
 p7qSZqN1gK9eh48Z6b7aac5D+Uj6CrRXl5EsZlU98FbUTvDWPv31OUB4ZAFTP9VwuXhAd9oojSg
 AJ1GBIxJ7M7Z2dtxAiWgHEVBmEKL8EecmcG7cp9KzT/IFBgdkyQLnyKoTgFbJE1xQe8eKiuFQcx
 nskiy4wIo3GKl6TLkxYETfS/fQJJLbCNIAHOuOWcSFcrEK57BgvRRpL0j+nuvD7sYrMfoj+IrQ1
 vfspU3Bdget4EOVN0llAQz2WHCjudR0kFv0CU1JeOij3YbFxdwKibW0yTyG24lTqC2pS1cGVS7O
 /0tzoMqXc4Zh1IWGyNNGimvf6adrZYg4i2T5OSXVK4u7q/M+r3PY8X3Wjkc0OXkJYAcakqdBvIr
 wBpDEog9NgIxM2CJZxoFa/DZW+2MSSuw6SGRu21UDlR+NYNT3n8bzteJVtgn8/D7rR76PtEkV0g
 4lsbVrzI7kFuZt0HGeX2vsop+zSm1CPFv49vkf5JFhHa8CsFKbKMqEsRYcam6xtKHDVBOI/LXiF
 ph/2KlW74c5HL9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 2D and dmabuf scanout paths disagreed on who owns
virtio_gpu_scanout::ds and on when the frontend dmabuf is released.

Disabling the scanout (width == 0) installs a placeholder surface
through qemu_console_set_surface(), which frees the surface it replaces,
leaving ds dangling. The next VHOST_USER_GPU_UPDATE then composited into
the freed surface and installed it again. Only free a surface the console
did not install, and drop updates that arrive without a scanout surface.

Fixes: 267f664658fe ("hw/display: add vhost-user-vga & gpu-pci")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/vhost-user-gpu.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index ac5bf7f8a428..554eee767cc3 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -193,6 +193,19 @@ vhost_user_gpu_unblock(VhostUserGPU *g)
     vhost_user_gpu_send_msg(g, &msg);
 }
 
+/*
+ * A surface not installed on the console is owned by the device, the
+ * installed one is freed by qemu_console_set_surface().
+ */
+static void
+vhost_user_gpu_clear_scanout_ds(struct virtio_gpu_scanout *s)
+{
+    if (s->ds && s->ds != qemu_console_surface(s->con)) {
+        qemu_free_displaysurface(s->ds);
+    }
+    s->ds = NULL;
+}
+
 static void
 vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 {
@@ -263,6 +276,13 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         s = &g->parent_obj.scanout[m->scanout_id];
         con = s->con;
 
+        if (g->dmabuf[m->scanout_id]) {
+            qemu_console_gl_release_dmabuf(con, g->dmabuf[m->scanout_id]);
+            g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
+        }
+
+        vhost_user_gpu_clear_scanout_ds(s);
+
         if (m->width == 0) {
             qemu_console_set_surface(con, NULL);
         } else {
@@ -290,7 +310,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         }
 
         g->parent_obj.enable = 1;
-        con = g->parent_obj.scanout[m->scanout_id].con;
+        s = &g->parent_obj.scanout[m->scanout_id];
+        con = s->con;
         old = g->dmabuf[m->scanout_id];
 
         if (fd == -1) {
@@ -298,6 +319,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
                 qemu_console_gl_release_dmabuf(con, old);
                 g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
             }
+            vhost_user_gpu_clear_scanout_ds(s);
             qemu_console_gl_scanout_disable(con);
             break;
         }
@@ -307,6 +329,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             modifier = m2->modifier;
         }
 
+        vhost_user_gpu_clear_scanout_ds(s);
+
         dmabuf = qemu_dmabuf_new(m->width, m->height,
                                  &offset, &stride, 0, 0,
                                  m->fd_width, m->fd_height,
@@ -361,6 +385,11 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
         s = &g->parent_obj.scanout[m->scanout_id];
         con = s->con;
+        if (!s->ds) {
+            error_report("vhost-user-gpu: no 2D scanout surface"
+                         " for scanout %d", m->scanout_id);
+            break;
+        }
         pixman_image_t *image =
             pixman_image_create_bits(PIXMAN_x8r8g8b8,
                                      m->width,
@@ -660,6 +689,7 @@ vhost_user_gpu_reset_bh(void *opaque)
             g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
         }
         qemu_console_gl_scanout_disable(scanout->con);
+        vhost_user_gpu_clear_scanout_ds(scanout);
         qemu_console_set_surface(scanout->con, NULL);
     }
 

-- 
2.56.0.116.g6de20f6092dc


