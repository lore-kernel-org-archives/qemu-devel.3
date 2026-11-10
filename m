Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906D606B9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B92TcGlY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhIP-0005ce-3s; Tue, 10 Nov 2026 03:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhI5-0005Kw-CM
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhI3-0003Ox-Mg
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794299595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzxuNv17Zwp7J0czqBKJdXgYVmX5KppsCEe7IfdrFcA=;
 b=B92TcGlYXZe77LbWGC1TgvGIWWNXPMyYvqcOFFHZT+rGQKpho0R/isFehMG1x7hn941tgJ
 g5ZVESYKs9Z/Gdkocw56WL7mBZxaHGhlsuQWFwOwDe0grn/EZrzMX4xLlkgoW2VUXhGw3Q
 gJ5HTsqQlTJ6Z7jcBfiEjUPIMr25SBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-kqAXGZtFMGKg2ObbTuskew-1; Tue,
 10 Nov 2026 03:33:09 -0500
X-MC-Unique: kqAXGZtFMGKg2ObbTuskew-1
X-Mimecast-MFC-AGG-ID: kqAXGZtFMGKg2ObbTuskew_1794299588
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 001AF18002FB; Tue, 10 Nov 2026 08:33:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C6ED1956086; Tue, 10 Nov 2026 08:33:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Nov 2026 12:31:12 +0400
Subject: [PATCH 2/4] virtio-gpu/gl: reject non-32bpp cursor resources
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-master-v1-2-7a0505d6c259@redhat.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
In-Reply-To: <20261110-master-v1-0-7a0505d6c259@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=T1QIA9gVvv747WfQ9Sv15OLJzjhIMDR/rCKUQyVrVk0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq8ta3lF36q+7XjqKzMY9nhYhZvyY0w87aG08uu
 3abx+xdcniJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavLWtwAKCRDa6OEJdZac
 5eNVEAC2sFPdQmN2wlwhCQxIhmrKsYRFly2H6T0QHWTlaN4nzpTPLdYlCcLsFTVS1EydnJkrGwV
 kWJd0pJcP51jCk2g+UJcOUHE+iremmYDKSdI5Vz+qQq/MZMF348eT7WsUTdHnPsYFQm7ZPoAz1Z
 2WRvzFcHdlQCe4/I4j6GaI1HswZdNbIA6+JtLAj0bg0Lfvk2p97DAFV1uhIJGfINdF2zuRbAhph
 tWaiBYy3FC4WcFlmqjzKkGo42VA3+za0IWqk9+wrMVGBcP4+NUpu79dnyFI1j572oB6yJXXWmTv
 nZ4uzm2TV2JxvnLMLk5Iv77sZRbJfVA0Uz2J5MFEyyM6624qn7dyZhAFWPYjtqslJsFg1a1okve
 0oFVX6B4d3P6vx4T2MQndo0Ccp5IF8JfyXqjF7r4KN7tpW+fjHPnarxQhE3/4BBj+ZcfYQqx+5T
 2dLK5FrEd8vIOLjFc4dGimJuflUr7qmvK2zX4lxclDo2Vagi+6NrQLyGxn2pnQaH6iT5MbGRYTa
 VWZ18NbIoITL+DBpSHlbQEHpPa0kPYtIzb955lg2c7hm/1NAQrjfmKA42o8AhTW25QZjw1+Fgos
 G6qxAMeuoW2wR+zZU3sg9G8B3WsuniQ9UrXJIjRvHkeuAWgngMvLR5ZsG9u9QecGtxkQTdQ7y9O
 99sPxziTYSp0tDw==
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cursor pixel data is copied as 32bpp, but the resource format is never
checked. virgl_renderer_get_cursor_data() sizes its buffer for the
resource's own format, while virtio_gpu_gl_update_cursor_data() copies
width * height * 4 bytes from it: a 64x64 R8_UNORM resource gives a
4096 byte buffer and a 16384 byte read, so 12 KiB of host heap past the
end of the allocation is sent to a connected VNC client as cursor data.

Look up the resource format and refuse anything that is not 32bpp,
matching what the non-virgl paths accept. Querying the renderer covers
blob resources: a blob carries no format in the virtio command and QEMU
stores 0 for it. The virgl and virtio format enums have the same values
for the accepted formats.

Fixes: CVE-2026-122027
Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-gl.c            | 18 ++++++++++++++++++
 include/hw/virtio/virtio-gpu-pixman.h | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 2b7a41c46643..c314631b05f3 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -31,6 +31,7 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
                                              uint32_t resource_id)
 {
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
+    struct virgl_renderer_resource_info info = { 0 };
     uint32_t width, height;
     uint32_t pixels, *data;
 
@@ -38,6 +39,20 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
         return;
     }
 
+    virgl_renderer_force_ctx_0();
+    if (virgl_renderer_resource_get_info(resource_id, &info) != 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown cursor resource %u\n",
+                      __func__, resource_id);
+        return;
+    }
+
+    if (!virtio_gpu_format_is_cursor_capable(info.virgl_format)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: cursor resource %u has unsupported format %u\n",
+                      __func__, resource_id, info.virgl_format);
+        return;
+    }
+
     data = virgl_renderer_get_cursor_data(resource_id, &width, &height);
     if (!data) {
         return;
@@ -45,6 +60,9 @@ static void virtio_gpu_gl_update_cursor_data(VirtIOGPU *g,
 
     if (width != s->current_cursor->width ||
         height != s->current_cursor->height) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: cursor resource %u has unsupported dimension %ux%u\n",
+                      __func__, resource_id, width, height);
         free(data);
         return;
     }
diff --git a/include/hw/virtio/virtio-gpu-pixman.h b/include/hw/virtio/virtio-gpu-pixman.h
index 4dba782758dc..d6043d2ca1df 100644
--- a/include/hw/virtio/virtio-gpu-pixman.h
+++ b/include/hw/virtio/virtio-gpu-pixman.h
@@ -42,4 +42,17 @@ virtio_gpu_get_pixman_format(uint32_t virtio_gpu_format)
     }
 }
 
+/*
+ * Cursor data is copied as 32bpp; formats without a pixman mapping are
+ * rejected.
+ */
+static inline bool
+virtio_gpu_format_is_cursor_capable(uint32_t format)
+{
+    pixman_format_code_t pformat;
+
+    pformat = virtio_gpu_get_pixman_format(format);
+    return pformat && PIXMAN_FORMAT_BPP(pformat) == 32;
+}
+
 #endif

-- 
2.56.0.116.g6de20f6092dc


