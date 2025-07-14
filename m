Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556BBC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 12:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIGd-0004Pz-Ns; Mon, 14 Jul 2025 08:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubHGx-0002I3-5k
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubHGq-00065s-7U
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752492172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PoE6bd35sOk0qJdIlAC+wu6emNS0c0T/QE+67h9qX4=;
 b=MBmIQa9wZF2uA5obfkpGzXgIirV57QRGxbPdmxPpeMBICPYA8eEbEtFomuft7mrRgb3nvu
 7J9oJIrlD68v0JP4PuDNfA/+GLaay1+jKfcAW+EUjBZt/rf+U7SxiSybD5Ip7F2UArp34u
 g6MbtPq6eqmbat4d2PKwX1rGDFE43po=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-_3bZWZWZMTiyyirt0tZxDw-1; Mon,
 14 Jul 2025 07:11:36 -0400
X-MC-Unique: _3bZWZWZMTiyyirt0tZxDw-1
X-Mimecast-MFC-AGG-ID: _3bZWZWZMTiyyirt0tZxDw_1752491495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 316BE18011DF; Mon, 14 Jul 2025 11:11:35 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0441D1800285; Mon, 14 Jul 2025 11:11:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PULL 08/13] ui/spice: Create a new texture with linear layout when
 gl=on is specified
Date: Mon, 14 Jul 2025 15:10:31 +0400
Message-ID: <20250714111039.4150419-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Since most encoders/decoders (invoked by Spice) may not work properly
with tiled memory associated with a texture, we need to create another
texture that has linear memory layout and use that instead.

Note that, there does not seem to be a direct way to indicate to the
GL implementation that a texture's backing memory needs to be linear.
Instead, we have to do it in a roundabout way where we need to first
create a tiled texture and import that as a memory object to create
a new texture that has a linear memory layout.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Co-developed-by: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20250617043546.1022779-7-vivek.kasireddy@intel.com>
---
 include/ui/surface.h |  1 +
 ui/console-gl.c      |  6 ++++
 ui/spice-display.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index f16f7be8be..006b1986bb 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -22,6 +22,7 @@ typedef struct DisplaySurface {
     GLenum glformat;
     GLenum gltype;
     GLuint texture;
+    GLuint mem_obj;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index afb36dba64..403fc36fbd 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -184,6 +184,12 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
     }
     glDeleteTextures(1, &surface->texture);
     surface->texture = 0;
+#ifdef GL_EXT_memory_object_fd
+    if (surface->mem_obj) {
+        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
+        surface->mem_obj = 0;
+    }
+#endif
 }
 
 void surface_gl_setup_viewport(QemuGLShader *gls,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index e409b6bdb2..854a97c198 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -893,6 +893,81 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
+                                        int *fds, uint64_t *modifier,
+                                        int *num_planes)
+{
+    uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+    GLuint texture;
+    GLuint mem_obj;
+    int fourcc;
+    bool ret;
+
+    if (!spice_remote_client) {
+        return true;
+    }
+
+    if (*modifier == DRM_FORMAT_MOD_LINEAR) {
+        return true;
+    }
+
+    if (*num_planes > 1) {
+        error_report("spice: cannot replace texture with multiple planes");
+        return false;
+    }
+
+    /*
+     * We really want to ensure that the memory layout of the texture
+     * is linear; otherwise, the encoder's output may show corruption.
+     */
+    if (!surface_gl_create_texture_from_fd(ssd->ds, fds[0], &texture,
+                                           &mem_obj)) {
+        error_report("spice: cannot create new texture from fd");
+        return false;
+    }
+
+    /*
+     * A successful return after glImportMemoryFdEXT() means that
+     * the ownership of fd has been passed to GL. In other words,
+     * the fd we got above should not be used anymore.
+     */
+    ret = egl_dmabuf_export_texture(texture,
+                                    fds,
+                                    (EGLint *)offsets,
+                                    (EGLint *)strides,
+                                    &fourcc,
+                                    num_planes,
+                                    modifier);
+    if (!ret) {
+        glDeleteTextures(1, &texture);
+#ifdef GL_EXT_memory_object_fd
+        glDeleteMemoryObjectsEXT(1, &mem_obj);
+#endif
+
+        /*
+         * Since we couldn't export our newly create texture (or create,
+         * an fd associated with it) we need to backtrack and try to
+         * recreate the fd associated with the original texture.
+         */
+        ret = egl_dmabuf_export_texture(ssd->ds->texture,
+                                        fds,
+                                        (EGLint *)offsets,
+                                        (EGLint *)strides,
+                                        &fourcc,
+                                        num_planes,
+                                        modifier);
+        if (!ret) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            warn_report("spice: no texture available to display");
+        }
+    } else {
+        surface_gl_destroy_texture(ssd->gls, ssd->ds);
+        ssd->ds->texture = texture;
+        ssd->ds->mem_obj = mem_obj;
+    }
+    return ret;
+}
+
 static void spice_server_gl_scanout(QXLInstance *qxl,
                                     const int *fd,
                                     uint32_t width, uint32_t height,
@@ -917,6 +992,7 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+    bool ret;
 
     if (ssd->ds) {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
@@ -939,6 +1015,12 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
             return;
         }
 
+        ret = spice_gl_replace_fd_texture(ssd, fd, &modifier, &num_planes);
+        if (!ret) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            return;
+        }
+
         trace_qemu_spice_gl_surface(ssd->qxl.id,
                                     surface_width(ssd->ds),
                                     surface_height(ssd->ds),
-- 
2.50.0


