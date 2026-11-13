Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A13606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O88w9+e1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoki-0002vj-JN; Fri, 13 Nov 2026 05:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokf-0002nt-5t
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokd-0001gE-Ia
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yp/l6VtxtI8ayp3qc92ios6N7Mf21erGSZG9DOArtSU=;
 b=O88w9+e1YJ2bZ7M4dmj5yhuHE6BiotxXPbYdgbQfMq/H8fdYk5oUw//CqFiBP1+WirLtlC
 ojjFy0XDu3K0svYHYGkkAt9NoqQADsoc/3PAPFH2jAzrAzAXQCD78G7BS0ju2hG+QXjI0M
 yLG/s3hLwhtR/t94A6EYX5mSvrAmxK4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-1dU3WqgVPPirggp7xiwEUQ-1; Fri,
 13 Nov 2026 05:43:19 -0500
X-MC-Unique: 1dU3WqgVPPirggp7xiwEUQ-1
X-Mimecast-MFC-AGG-ID: 1dU3WqgVPPirggp7xiwEUQ_1794566598
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1D9B18005AD; Fri, 13 Nov 2026 10:43:18 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E38FE1955F2D; Fri, 13 Nov 2026 10:43:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Nov 2026 14:42:19 +0400
Subject: [PATCH v2 7/8] hw/display/vhost-user-gpu: fix scanout bookkeeping
 on the 2D path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-issue-4848-v2-7-631414664bca@redhat.com>
References: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
In-Reply-To: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bu2Jw1oB8pOarMz6zN3hE4eKhr0TauzRyp/pmKD/klo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umoRa+psdwbVXljEOomHyyMNB3fuKToH5RNL
 K/mLJIIyfSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbpqAAKCRDa6OEJdZac
 5Q1OD/4/n0JXnHS7mWhNoV9ibh3dE30si6oMXOpd9LsZWzWEDKZKvcx2RWrWWJjE05xTOBh0iaH
 79gdKKrSL90O/MgApJsKIUmpoly6QqETvGF3hXCcctCueywH1AkeQ+v9G+shJxSLyuF9zRd+xTt
 /GfZvbm4xD35wA1MUUpovfdpettXOyZyy1fZsHYE5HwTNZnLVudpSeCI07Y2NG7tNWubCJKmwcP
 NlHQaw5f2dK4OaGhCYQybEJa0osV1JfDM52LeS/9XfROLssbDE1+vfZNF7umJRIJ4gIUU70ajDc
 hUj7mblxMr2LzpAjaiAvixkMRNiFBqqj5nJsEG0Tie2swB5uov3swA4v89gKKFHWy/8F6DzohZS
 EF1u2Iyu3oaFBSIsqJLju9WNSdvu1fcJCOrQRrDG7IUawqi2cucgLBw2XNn1ilMGwk6ezcK//AO
 qYZAACKfR8cLxRYFmZXH7ZpFnxWQRApG9z5XnsH/iVVF+XH3JI19F7DOdO4bpQCq1yOG6kxzTe4
 B7aTtgzM+abBj85AIB6O9A/4Krk29e3i1gTnyP3NI159ryBjWSfwfGIYf6qwvtBFEYEmQJM1K25
 8bRGw18GuIirq4Q+ClVtcY+6J+zpAODPzx2VXl1JsdCpDBH6eyvGmRvwE5DxAeH4hMQOmcIJyzt
 uJwo5lrAHNyaH6Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
index 4c5ddc5bef4a..2895fe68125e 100644
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
@@ -663,6 +692,7 @@ vhost_user_gpu_reset_bh(void *opaque)
             g_clear_pointer(&g->dmabuf[i], qemu_dmabuf_free);
         }
         qemu_console_gl_scanout_disable(scanout->con);
+        vhost_user_gpu_clear_scanout_ds(scanout);
         qemu_console_set_surface(scanout->con, NULL);
     }
 

-- 
2.56.0.116.g6de20f6092dc


