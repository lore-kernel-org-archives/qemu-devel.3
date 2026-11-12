Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBBB606A333
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d6Ytd9TL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTJ6-0003RQ-9e; Thu, 12 Nov 2026 06:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTJ4-0003R2-5N
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTJ2-0001Hu-JZ
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794484168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YpShDEABGAmkxbnH3ihAp/aiDpRuOyakw9qerQE6qo=;
 b=d6Ytd9TL4DTd2oIbLUP4NU/AI1mM+nvhTTivAyjv0iQLJ3fwn0c3WgK+OtQxHq4khVbGc/
 QoaAndm7scMqh7KO+Qr3jxeNJRtdcCu2hNiqWDbXPEtr5DYdywfEMJow4VYJE5QwS4ZBHC
 TG49Op0WAfUDeGWWigY+/JhlsYfen70=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-hxR1MSrMPjqR51R1VKeGNA-1; Thu,
 12 Nov 2026 06:49:26 -0500
X-MC-Unique: hxR1MSrMPjqR51R1VKeGNA-1
X-Mimecast-MFC-AGG-ID: hxR1MSrMPjqR51R1VKeGNA_1794484165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23E56196C409; Thu, 12 Nov 2026 11:49:25 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A4331800543; Thu, 12 Nov 2026 11:49:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Nov 2026 15:48:49 +0400
Subject: [PATCH 6/7] hw/display/vhost-user-gpu: fix scanout bookkeeping on
 the 2D path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-issue-4848-v1-6-aeba1cfe2c03@redhat.com>
References: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
In-Reply-To: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=G/0MOx9MYapqfTMthJ2kS8S+QQ/MEe/7lXPDMexj9Fo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9aeqIsoMd3USOHG2imD+cNhi/BTGGzuQM298o
 RAhhurra9KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavWnqgAKCRDa6OEJdZac
 5UvHD/4i/Dsnvgbqu5M5d9+85Eg7MZ+aKsssWVqMk4tk6lAAaiuAeHNGdGvTjC9G1GARYV7CC60
 cbFq3ft00GGpbxI165dpIPnLOpejCWKDygx+1Wek/CtvMJVG5LGVGFK0BE5pK2xp/IIuRCvL3xW
 L7y12X+Is4rgznDyLgPUBXULPtFLiKScmNlfUf7Gr/M4BQFvKtacNPzkoD9OjeDT8c/0f/SLw6S
 rYmV3gR6XpkAHKrMShaeUoxXk9ODuAH2CjD2IduSXESlcUv5+8ItdbMolwSDcE7oJQo3iB+fm9D
 ZmWLDMT5tDY499439WqhzqTcGrI6mHTGA47gpGNf/X+dmXdorz6Ows/O826PNzUE/93D8JdQ6h+
 J0vYwqhB8VP9Xym8Vc3g1dgwER/IkdXarG8DAK4lwk6qBTJqLuyaIRmesu2qrY82QY5BOcqC+2W
 MPKErQxcu/xwaL9+N4ZR8I7A2HxOvgxGKsOEoIwXT5COz16t9F+X6GiGHaLzcha/6xGS4r8mslz
 xw3KcBYwLcSnCsxywER+I5eH5C0j3UtuZYPk71fN5kyZhQLHwR2/tlnhqHsVrqk7IRQDPYGXUxi
 C67WFraV1DIPYKNazG77D7mXoKIRsTVVodKJMmWkkQS4PvWxpM4/VqU1O+c9/nmSxW/nL5nGi5v
 t9Q8HT1JzdbP55Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 4eab482f2181..63776ab30ac5 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -192,6 +192,19 @@ vhost_user_gpu_unblock(VhostUserGPU *g)
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
@@ -262,6 +275,13 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
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
@@ -289,7 +309,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
         }
 
         g->parent_obj.enable = 1;
-        con = g->parent_obj.scanout[m->scanout_id].con;
+        s = &g->parent_obj.scanout[m->scanout_id];
+        con = s->con;
         old = g->dmabuf[m->scanout_id];
 
         if (fd == -1) {
@@ -297,6 +318,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
                 qemu_console_gl_release_dmabuf(con, old);
                 g_clear_pointer(&g->dmabuf[m->scanout_id], qemu_dmabuf_free);
             }
+            vhost_user_gpu_clear_scanout_ds(s);
             qemu_console_gl_scanout_disable(con);
             break;
         }
@@ -306,6 +328,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
             modifier = m2->modifier;
         }
 
+        vhost_user_gpu_clear_scanout_ds(s);
+
         dmabuf = qemu_dmabuf_new(m->width, m->height,
                                  &offset, &stride, 0, 0,
                                  m->fd_width, m->fd_height,
@@ -360,6 +384,11 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUserGpuMsg *msg)
 
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
@@ -659,6 +688,7 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
             g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
         }
         qemu_console_gl_scanout_disable(scanout->con);
+        vhost_user_gpu_clear_scanout_ds(scanout);
         qemu_console_set_surface(scanout->con, NULL);
     }
 

-- 
2.56.0.116.g6de20f6092dc


