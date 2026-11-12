Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1C606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZ45JMbS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTJB-0003V8-Du; Thu, 12 Nov 2026 06:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTJ9-0003Tg-4P
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRTJ7-0001IS-Cy
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794484172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=op7BkSuNZ8Zbo574r/FSSFlJolfv/40A7UhIg6j8YTE=;
 b=OZ45JMbS9MNCSPaQ62PcmyY2fJDDr2xU+1XdvD9Vho9yn1QbMyDhGJXdAQ7Jz+RskrZsUP
 uhSVUL3FV/0ARBEMUtKNps9ELhHkGkvOyKaHQo7nvmIRqaumKs05eWpvLnEXcWxZTLl+1Q
 UsTssQoacuTrgYcXi/E8ZH9KvBC44ME=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-gM_cOSHfNgmrs7x8ztacMg-1; Thu,
 12 Nov 2026 06:49:29 -0500
X-MC-Unique: gM_cOSHfNgmrs7x8ztacMg-1
X-Mimecast-MFC-AGG-ID: gM_cOSHfNgmrs7x8ztacMg_1794484168
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72E2618ABC4F; Thu, 12 Nov 2026 11:49:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88AA5421; Thu, 12 Nov 2026 11:49:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 12 Nov 2026 15:48:50 +0400
Subject: [PATCH 7/7] contrib/vhost-user-gpu: use the stride of the exported
 dmabuf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-issue-4848-v1-7-aeba1cfe2c03@redhat.com>
References: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
In-Reply-To: <20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=JgsUB5ABXypFnT7exHfSKyy7d0nafDLzLCjvZIaAWyk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9aeqqjLZ7Nm/sycqIBn6pjv3yA488OKxCisFH
 CHoVkJuR0yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavWnqgAKCRDa6OEJdZac
 5UpTEACEF/r7NKTuGlA1Fu6xko8nzS/tt7b4y95ZKAGtnGTRnRwh6BjEAXzhGOKhdJtw3WqkxBX
 uGAIaey872l95lBxZc6Lhfzu2ALAWohOud9irIbYRjLedlhYsWWxYvJ7QYBNZly27wha89T5XXV
 00KIjrDxVxTRT1CJzikCzi45pF824UgAeSEoJql/7UxnVuzrcqWtNV0HvrUgVDpDyBw9vZDXWyi
 fq+eiXEUOI80cmRoQ2UucaMYyA+5pCI0WWnP29FbvVvrq49rfE1y1dojM/b9/Luzxs2NrZxTEDC
 rFOcPsFMILIgGTZXIhTE9Rycq/K4FHtmLffYUzCCAq3ZYlGBijdvJWEUVNXwEBnEiOyq8nZVo4v
 b7+8wAV6cDF9qXPVoc1IJNUJtX1ojFHG1AAA3zXw+pnDaPkJUYiFeLVrmzdVAa1tSLRz33YWp/P
 1Cs7R593RzD/9Ib9ZkUEbYIlst2chflLAxQxM6JXjzrnHHrFaEE0hs434+JOBZT26iEZRikrhDh
 Lsx1qecusuYEP96GY8wjrr053qs8INQLipr3cdc7rV1TqcuxCOxrrRPbEuUxMpgVcFoxQdCIqPO
 d9oBkrEjqyRERGIz5VLVPDqfN6ZEe3yb7PMp8uPNHsLh2z0WPOHsAKXAb/UMy1LqX7vQN5dx8kP
 lYyYc96Qk/FtRFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

virgl_renderer_get_fd_for_texture2() returns the stride and offset that
eglExportDMABUFImageMESA() gave the exported dmabuf. Use that stride.
Reject a scanout with a non-zero offset, as the scanout message has no
field to carry it.

This fixes dmabuf import/sheared with Intel driver when the resolution
stride is not 256-byte aligned.

Left for later (after 11.2 release), add new message / field for offset.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/virgl.c | 48 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index c33b3dbeb8b7..4ab2c5fcdafc 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -18,6 +18,23 @@
 
 #include <epoxy/gl.h>
 
+/*
+ * VIRGL_CHECK_VERSION available since libvirglrenderer 1.0.1 and was fixed
+ * in 1.1.0. Undefine bugged version of the macro and provide our own.
+ */
+#if defined(VIRGL_CHECK_VERSION) && \
+    VIRGL_VERSION_MAJOR == 1 && VIRGL_VERSION_MINOR < 1
+#undef VIRGL_CHECK_VERSION
+#endif
+
+#ifndef VIRGL_CHECK_VERSION
+#define VIRGL_CHECK_VERSION(major, minor, micro) \
+    (VIRGL_VERSION_MAJOR > (major) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR > (minor) || \
+     VIRGL_VERSION_MAJOR == (major) && VIRGL_VERSION_MINOR == (minor) && \
+     VIRGL_VERSION_MICRO >= (micro))
+#endif
+
 void
 vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
                             gpointer data)
@@ -409,12 +426,33 @@ virgl_cmd_set_scanout(VuGpu *g,
         }
 
         int fd = -1;
-        if (virgl_renderer_get_fd_for_texture(info.tex_id, &fd) < 0) {
-            g_critical("%s: failed to get fd for texture\n", __func__);
-            cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
-            return;
+        int stride = info.stride;
+        int offset = 0;
+        bool exported = false;
+
+#if VIRGL_CHECK_VERSION(0, 7, 0)
+        exported = virgl_renderer_get_fd_for_texture2(info.tex_id, &fd,
+                                                      &stride, &offset) == 0;
+#endif
+        if (!exported) {
+            stride = info.stride;
+            offset = 0;
+            if (virgl_renderer_get_fd_for_texture(info.tex_id, &fd) < 0) {
+                g_critical("%s: failed to get fd for texture\n", __func__);
+                cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+                return;
+            }
         }
         assert(fd >= 0);
+
+        if (offset) {
+            /* the scanout message has no field to carry the buffer offset */
+            g_critical("%s: unsupported dmabuf offset %d\n", __func__, offset);
+            close(fd);
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+
         VhostUserGpuMsg msg = {
             .payload.dmabuf_scanout.scanout_id = ss.scanout_id,
             .payload.dmabuf_scanout.x =  ss.r.x,
@@ -423,7 +461,7 @@ virgl_cmd_set_scanout(VuGpu *g,
             .payload.dmabuf_scanout.height = ss.r.height,
             .payload.dmabuf_scanout.fd_width = info.width,
             .payload.dmabuf_scanout.fd_height = info.height,
-            .payload.dmabuf_scanout.fd_stride = info.stride,
+            .payload.dmabuf_scanout.fd_stride = stride,
             .payload.dmabuf_scanout.fd_flags = info.flags,
             .payload.dmabuf_scanout.fd_drm_fourcc = info.drm_fourcc
         };

-- 
2.56.0.116.g6de20f6092dc


