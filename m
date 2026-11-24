Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BC606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gTBMDWAx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVpwg-0005V2-W0; Tue, 24 Nov 2026 07:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwc-0005UW-Tt
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xVpwY-0000nt-Of
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795524497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ouj6wqJW+ZOi8VBCZcSOVFR0jhYItWumNxQLsZX6Amc=;
 b=gTBMDWAxErGFbXQPFUHsDxn3W78j0fkIc2d2K6uZK4+vUYENRR3nynu3td4gzZ2KnszuQg
 U9B+RfcNMoIi7lfwTXhMghhdTc65nQXrZ39KG1isKRxb1KDaVDRcr5BPlO30e0jRKNcOhh
 SJhcyC/e/Izg/jD4SIGVUwDe0F4PVgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-18mQd4QXNoankjNnOuZvlA-1; Tue,
 24 Nov 2026 12:48:15 +0000
X-MC-Unique: 18mQd4QXNoankjNnOuZvlA-1
X-Mimecast-MFC-AGG-ID: 18mQd4QXNoankjNnOuZvlA_1795524494
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 598D71955F73; Tue, 24 Nov 2026 12:48:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1379441F; Tue, 24 Nov 2026 12:48:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 24 Nov 2026 16:47:48 +0400
Subject: [PATCH v4 5/6] hw/display/vhost-user-gpu: fix scanout bookkeeping
 on the 2D path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-issue-4848-v4-5-24993c4766fc@redhat.com>
References: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
In-Reply-To: <20261124-issue-4848-v4-0-24993c4766fc@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3648;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qn++vy9K6hNqW6En7tPZCFiihIYgUx2punxJPmRN6oA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBrBYd27Ele+LB0plX1lvZWqDP0MUH4mjeRRC+D5
 MXk0Z8PTZOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCawWHdgAKCRDa6OEJdZac
 5RUBD/4qj2uKqTpnbHruwimG/Xia265yITlHzIPSLuzDOylFD6Nrd4PqPunUPstaHYqMi+qpNb1
 5iBKEWdeJ5SzArL5wdT01D1WnkE9QDY2Y6+KOaW4/ApyIyOVBs8hhEObJZDnkZVYECbf9RPoePr
 BVOanSJhazwA4JgwfGLwquYJW8/HYpCyiusXPoawQcfAhcWbDWo3FvSB/6yRIgHmgebw9ykHFhx
 yguDNwc3MqLPURAUPJ0a8dOPXAoOAe/mta65kKA/C1J1EKSCuvLzkSljO8oBwvqMupN/EaxvrE4
 cneBRuSM/LeNMtnG2k3R6H7wV877iycDN+z/p9pbpIDu4n606IovNYNInPTAAhpx8TdmK4kdwx3
 45pGDOJXZZ64AoqUKsdHRXYGdY9yX6BLeR6mSAqs6+u2lqLJ4SZTB5VKlOwhiudYT1oc8HitFA7
 t+BMSsJ0J22pkqBZWv6C4jZimj2Joqs24z1U00KMoLEUoj6dOPtdkvS6IP7yCRFRsFrf/QYhT14
 LZYSVLK1MgCOmWgFzEOmIq17IZbSbMN2PljzAXc1SWqrNab+OywlhhI436DNpP80Yn737KXQL3M
 iUKICkxWc8IMczT3aYVtX8D8xkegbTFipDZEnSd0ISuNJtm0DMxNQ+gRAMG7hz/ugcP1tvmWUks
 DaenjStC3SX7TDw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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
 hw/display/vhost-user-gpu.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index ef9aa73ceed5..0a8bb07d8db7 100644
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

-- 
2.56.0.116.g6de20f6092dc


