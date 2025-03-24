Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702FBC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd2P-0005z9-99; Mon, 24 Mar 2025 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2G-0005xs-5q
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:52 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2D-0008V9-NU
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:51 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224019ad9edso99941065ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804387; x=1743409187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBnLYbHY4vG69xrvg+jj2XQI75wXpC82JycuCtb/2TU=;
 b=djDI2RRCdqPbm4uk6+IxaHILN/G7kZqYeznPH+TuW1S7juZmQWHVWPwKnHixMgKWU6
 K+zH1Jync0InEClDy5msnHmPjDzFDqLnmPzA4ySAg+eM7igePkYdOkqOzuCV7BtsEkPY
 DoUiCtWBL+nc2obTjxphue4RNQqH3RUhvfLy/qmmvcZ5+gsBYV11ZHuesHcnRm1EwxfP
 E0PQBGzB/ztUU4Ermkq/tCz/cjAyotLu5TiVm+5i3I0sJIwZiyUjtp4qrJgL4gJyGs4J
 YgoxE3L/aNOlJMCsvd+dVdS9iG0JFVS/jDZAOr6+Eix8KISnvADsMc2COkRlsdv7ks2Q
 NUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804387; x=1743409187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBnLYbHY4vG69xrvg+jj2XQI75wXpC82JycuCtb/2TU=;
 b=Q0/S7lodcwlUuAN7xrALMcTeWF2p+DBbFd9q0pZn2YncTpRtFbS7/GCEIFUVSpeRbN
 h2OEFr7YuUBNelVWEOl2OWE7VwRH7rTAs6FE/BDYLliTp9r0m8+lBAgU9M84j4OITXGA
 FoxQQtTCJET5O1e7K9/RhelK/T5bKeIC+X8HeJXPwtLilKACSObpFTiuMgg5VmS9bBE5
 CTkICjwFhx5fvqEgJOIg7yM8g3NQRKkCGeyoITLZWD9Q0XJ60cQNN0wdMoKRkIwGreXv
 /Pft9CnQ6XZIwvtEvUTCvePcW9ElPvw3pUvGb6zQuptVU92hprhRXZXJoPiEBJ2WvOcL
 C73A==
X-Gm-Message-State: AOJu0YxzXjxu46ORNzFsk0EdiSiyS28oKVMlpIsfVsCbxF9ZxWjVYQGz
 Rds84QzI4poA2WG5uYBwO19E41f6dJ0s4Brq6/9DOwrnlw/ZcYBOc5nc4vzH
X-Gm-Gg: ASbGncszhZSFKCygbi3lkz43Ar179zFHIQleflu3j985eV6IuY5xKa9XYIvoM+QhcIt
 XmMh/8PMU/8B9r+n8As79Kl71TZYrTi5sCZMDZ/DQAwS4mIlkN8iVd8VOi9ft3s7BRad8Qj+TQ5
 40tvdYsb1Mvj6B1jxVMLEHwvK2jgg3lnkqRSVA36NZaMhBLVB175KAzJtfVk7tJwtsp23o6Gaun
 mBIgnTtq3a+KWb8nLqtFTbsBKw1EwLPzCKenc3uOmrLxTPWK/+WL9ny/Ta1pw7MUsGBdNATPkyB
 C7g3sYkR16ouSQKrZvmoqCgTiIoE4zVOf64FPEftI1kEauPgFiDc6ZiWvK8VF7HG0u8IFhIeBYf
 F2J+OB2FFpvkLMPt3Btm9
X-Google-Smtp-Source: AGHT+IHH+Iv+fJO9G9COspyZ1KCR/WRkLQpfFOBj+R9iBnAfUc7miUNL6XvXUVT5Iz3hDaC01Rp8rg==
X-Received: by 2002:a17:902:ecc3:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22780c511c3mr207728315ad.4.1742804386787; 
 Mon, 24 Mar 2025 01:19:46 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:46 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 4/6] ui/egl: support multi-plane dmabuf when egl export/import
Date: Mon, 24 Mar 2025 16:19:19 +0800
Message-ID: <20250324081922.359369-5-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Qiang Yu <yuq825@gmail.com>

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 include/ui/egl-helpers.h |  5 ++-
 ui/dbus-listener.c       | 19 +++++----
 ui/egl-helpers.c         | 86 +++++++++++++++++++++++++++++-----------
 ui/spice-display.c       | 58 ++++++++++++++++++---------
 4 files changed, 116 insertions(+), 52 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 4b8c0d2281..fb80e15142 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -46,8 +46,9 @@ extern int qemu_egl_rn_fd;
 extern struct gbm_device *qemu_egl_rn_gbm_dev;
 
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
-                           EGLuint64KHR *modifier);
+bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
+                               EGLint *stride, EGLint *fourcc, int *num_planes,
+                               EGLuint64KHR *modifier);
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 3b39a23846..73b72ed57c 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -504,19 +504,22 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                backing_width, backing_height, x, y, w, h);
 #ifdef CONFIG_GBM
     g_autoptr(QemuDmaBuf) dmabuf = NULL;
-    int fd;
-    uint32_t offset = 0, stride, fourcc;
+    int fd[DMABUF_MAX_PLANES], num_planes;
+    uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc;
     uint64_t modifier;
 
     assert(tex_id);
-    fd = egl_get_fd_for_texture(tex_id, (EGLint *)&stride, (EGLint *)&fourcc,
-                                &modifier);
-    if (fd < 0) {
-        error_report("%s: failed to get fd for texture", __func__);
+    if (!egl_dmabuf_export_texture(tex_id, fd, (EGLint *)offset, (EGLint *)stride,
+                                   (EGLint *)&fourcc, &num_planes, &modifier)) {
+        error_report("%s: failed to export dmabuf for texture", __func__);
+        return;
+    }
+    if (num_planes > 1) {
+        error_report("%s: does not support multi-plane dmabuf", __func__);
         return;
     }
-    dmabuf = qemu_dmabuf_new(w, h, &offset, &stride, x, y, backing_width,
-                             backing_height, fourcc, modifier, &fd, 1,
+    dmabuf = qemu_dmabuf_new(w, h, offset, stride, x, y, backing_width,
+                             backing_height, fourcc, modifier, fd, num_planes,
                              false, backing_y_0_top);
 
     dbus_scanout_dmabuf(dcl, dmabuf);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 970286325f..864855f540 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -283,39 +283,75 @@ err:
     return -1;
 }
 
-int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
-                           EGLuint64KHR *modifier)
+bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
+                               EGLint *stride, EGLint *fourcc, int *num_planes,
+                               EGLuint64KHR *modifier)
 {
     EGLImageKHR image;
-    EGLint num_planes, fd;
+    EGLuint64KHR modifiers[DMABUF_MAX_PLANES];
 
     image = eglCreateImageKHR(qemu_egl_display, eglGetCurrentContext(),
                               EGL_GL_TEXTURE_2D_KHR,
                               (EGLClientBuffer)(unsigned long)tex_id,
                               NULL);
     if (!image) {
-        return -1;
+        return false;
     }
 
     eglExportDMABUFImageQueryMESA(qemu_egl_display, image, fourcc,
-                                  &num_planes, modifier);
-    if (num_planes != 1) {
-        eglDestroyImageKHR(qemu_egl_display, image);
-        return -1;
-    }
-    eglExportDMABUFImageMESA(qemu_egl_display, image, &fd, stride, NULL);
+                                  num_planes, modifiers);
+    eglExportDMABUFImageMESA(qemu_egl_display, image, fd, stride, offset);
     eglDestroyImageKHR(qemu_egl_display, image);
 
-    return fd;
+    /* Only first modifier matters. */
+    if (modifier)
+        *modifier = modifiers[0];
+
+    return true;
 }
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
 {
     EGLImageKHR image = EGL_NO_IMAGE_KHR;
     EGLint attrs[64];
-    int i = 0;
+    int i = 0, j;
     uint64_t modifier = qemu_dmabuf_get_modifier(dmabuf);
     uint32_t texture = qemu_dmabuf_get_texture(dmabuf);
+    const int *fd = qemu_dmabuf_get_fd(dmabuf);
+    const uint32_t *offset = qemu_dmabuf_get_offset(dmabuf);
+    const uint32_t *stride = qemu_dmabuf_get_stride(dmabuf);
+    uint32_t num_planes = qemu_dmabuf_get_num_planes(dmabuf);
+
+    EGLint fd_attrs[] = {
+        EGL_DMA_BUF_PLANE0_FD_EXT,
+        EGL_DMA_BUF_PLANE1_FD_EXT,
+        EGL_DMA_BUF_PLANE2_FD_EXT,
+        EGL_DMA_BUF_PLANE3_FD_EXT,
+    };
+    EGLint offset_attrs[] = {
+        EGL_DMA_BUF_PLANE0_OFFSET_EXT,
+        EGL_DMA_BUF_PLANE1_OFFSET_EXT,
+        EGL_DMA_BUF_PLANE2_OFFSET_EXT,
+        EGL_DMA_BUF_PLANE3_OFFSET_EXT,
+    };
+    EGLint stride_attrs[] = {
+        EGL_DMA_BUF_PLANE0_PITCH_EXT,
+        EGL_DMA_BUF_PLANE1_PITCH_EXT,
+        EGL_DMA_BUF_PLANE2_PITCH_EXT,
+        EGL_DMA_BUF_PLANE3_PITCH_EXT,
+    };
+    EGLint modifier_lo_attrs[] = {
+        EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT,
+        EGL_DMA_BUF_PLANE1_MODIFIER_LO_EXT,
+        EGL_DMA_BUF_PLANE2_MODIFIER_LO_EXT,
+        EGL_DMA_BUF_PLANE3_MODIFIER_LO_EXT,
+    };
+    EGLint modifier_hi_attrs[] = {
+        EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT,
+        EGL_DMA_BUF_PLANE1_MODIFIER_HI_EXT,
+        EGL_DMA_BUF_PLANE2_MODIFIER_HI_EXT,
+        EGL_DMA_BUF_PLANE3_MODIFIER_HI_EXT,
+    };
 
     if (texture != 0) {
         return;
@@ -328,18 +364,22 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
     attrs[i++] = qemu_dmabuf_get_fourcc(dmabuf);
 
-    attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
-    attrs[i++] = qemu_dmabuf_get_fd(dmabuf)[0];
-    attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
-    attrs[i++] = qemu_dmabuf_get_stride(dmabuf)[0];
-    attrs[i++] = EGL_DMA_BUF_PLANE0_OFFSET_EXT;
-    attrs[i++] = 0;
-    if (modifier != DRM_FORMAT_MOD_INVALID) {
-        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
-        attrs[i++] = (modifier >>  0) & 0xffffffff;
-        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
-        attrs[i++] = (modifier >> 32) & 0xffffffff;
+    for (j = 0; j < num_planes; j++) {
+        attrs[i++] = fd_attrs[j];
+        /* fd[1-3] may be -1 if using a joint buffer for all planes */
+        attrs[i++] = fd[j] >= 0 ? fd[j] : fd[0];
+        attrs[i++] = stride_attrs[j];
+        attrs[i++] = stride[j];
+        attrs[i++] = offset_attrs[j];
+        attrs[i++] = offset[j];
+        if (modifier != DRM_FORMAT_MOD_INVALID) {
+            attrs[i++] = modifier_lo_attrs[j];
+            attrs[i++] = (modifier >>  0) & 0xffffffff;
+            attrs[i++] = modifier_hi_attrs[j];
+            attrs[i++] = (modifier >> 32) & 0xffffffff;
+        }
     }
+
     attrs[i++] = EGL_NONE;
 
     image = eglCreateImageKHR(qemu_egl_display,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 82598fe9e8..b7016ece6a 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -876,19 +876,24 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    EGLint stride, fourcc;
-    int fd;
 
     if (ssd->ds) {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
     }
     ssd->ds = new_surface;
     if (ssd->ds) {
+        uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
+        int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
+
         surface_gl_create_texture(ssd->gls, ssd->ds);
-        fd = egl_get_fd_for_texture(ssd->ds->texture,
-                                    &stride, &fourcc,
-                                    NULL);
-        if (fd < 0) {
+        if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)offset,
+                                       (EGLint *)stride, &fourcc, &num_planes, NULL)) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            return;
+        }
+
+        if (num_planes > 1) {
+            fprintf(stderr, "%s: does not support multi-plane texture\n", __func__);
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
         }
@@ -899,10 +904,10 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                                     fourcc);
 
         /* note: spice server will close the fd */
-        spice_qxl_gl_scanout(&ssd->qxl, fd,
+        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
                              surface_width(ssd->ds),
                              surface_height(ssd->ds),
-                             stride, fourcc, false);
+                             stride[0], fourcc, false);
         ssd->have_surface = true;
         ssd->have_scanout = false;
 
@@ -941,20 +946,24 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
                                           void *d3d_tex2d)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    EGLint stride = 0, fourcc = 0;
-    int fd = -1;
+    EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
+    int fd[DMABUF_MAX_PLANES], num_planes;
 
     assert(tex_id);
-    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc, NULL);
-    if (fd < 0) {
-        fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
+    if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
+                                   &num_planes, NULL)) {
+        fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
+        return;
+    }
+    if (num_planes > 1) {
+        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
         return;
     }
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
     /* note: spice server will close the fd */
-    spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
-                         stride, fourcc, y_0_top);
+    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height,
+                         stride[0], fourcc, y_0_top);
     qemu_spice_gl_monitor_config(ssd, x, y, w, h);
     ssd->have_surface = false;
     ssd->have_scanout = true;
@@ -1064,15 +1073,26 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
             /* dest framebuffer */
             if (ssd->blit_fb.width  != width ||
                 ssd->blit_fb.height != height) {
+                int fds[DMABUF_MAX_PLANES], num_planes;
+                uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+
                 trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
                                                   height);
                 egl_fb_destroy(&ssd->blit_fb);
                 egl_fb_setup_new_tex(&ssd->blit_fb,
                                      width, height);
-                fd = egl_get_fd_for_texture(ssd->blit_fb.texture,
-                                            &stride, &fourcc, NULL);
-                spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
-                                     stride, fourcc, false);
+                if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds,
+                                               (EGLint *)offsets, (EGLint *)strides,
+                                               &fourcc, &num_planes, NULL)) {
+                    fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
+                    return;
+                }
+                if (num_planes > 1) {
+                    fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
+                    return;
+                }
+                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
+                                     strides[0], fourcc, false);
             }
         } else {
             stride = qemu_dmabuf_get_stride(dmabuf)[0];
-- 
2.43.0


