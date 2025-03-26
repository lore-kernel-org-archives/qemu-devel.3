Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92DEC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 09:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txN9y-0000zC-K7; Wed, 26 Mar 2025 05:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9s-0000ye-Cm
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txN9q-0003XC-6p
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 05:34:48 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227b828de00so62259475ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742981684; x=1743586484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhtailQ7Al3m+Hnv6ZcWWutKFcS73lvQuxI+xweqSDk=;
 b=hD0FUN1t6JHiLRPvbHKEImov8BFzbANoZ2W4TLa4vzIZSKJxRsipVMPCwpObA71nE0
 jpjde0W3DhhrvKPKwBmrqQzsfXsO5d7B/ehkoV+fmx1gqWRLhFhnWAbwEyHYYRr789It
 P+T0hgNE39iBEdFVxWIUaUD3jaZxbW4fZlHFbioiuuDp2c+5OQXvyQmIYXmRQ34zHDTe
 Ff7unuE+9lQg5IAjZyD4pAqbyvBGgj7fW2r4k2zeIzRzP/qrYbYcN4HaCE6fnNnLJ/j7
 89S4cXDYpVIufPKvvBIAWpvBiJ4zCeCtggwrWOWMBTUmXo9Xdej2QyMjrgacGoI/Nxew
 5qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742981684; x=1743586484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhtailQ7Al3m+Hnv6ZcWWutKFcS73lvQuxI+xweqSDk=;
 b=MU/JxLIjljC5CtKSTiVDI8zQWYxLG1m/nQ/B0HScH+kjvmarPaGjC875YI359omtXl
 Dgl6I9r+ru+1J8l1YV4owdq4D/S2jnvJDNFBV95EbYcQ1UVkqauhgv/yH5FWK/OvV+DH
 a0htdhKxI+Kv4eqKTBCN+Yc3QTGp42ker0nFs0IEaLoRow2Rw+SKHwIx0oMJYnd3OfTI
 LFmq/pCuRXRT7xh6e38t0sxL73hz6bv8k6EApzxE4cqBN/pJX3Yuj7YVSTf2AWdAcgdU
 F2cloTf8KKtIUsloVZ0MqwUYQJN5oRmpkgAN3st5CaBYWIH3t0L2GkM08MB1jZuCP2Jd
 3l/w==
X-Gm-Message-State: AOJu0YyBZio1QsvR2Ggy6haq+4Vtiuox3zRazRx+3tsiCJ/oK5fIhfVs
 hmLfrgU2Yylvq+lGQ1rNBWrB6/rw8NhGmKkM6AA9JAJGHuPL4qX+AXZwW48+
X-Gm-Gg: ASbGncs/vb6sYSTx0uefYHZ1diHnEAiECtJ3o8Lr3V2I1NuqwGXAFk8mFdLNJxdEqZJ
 VcKS8rFK4oWZpkThM4Qc1xeGNoXnUH4mVBzh6Ko3zFvHZrbFS1z7sTt8VPky3GQLkqgJDOOI6FG
 mCSi4ucL/4SO4oK9EpbP1Ss3ofj+v4Ae4fJVl2YLWf6V++cuFSD1Lfomfl0/ziqST5x510rv+4R
 i+z5+cichCRG2TGUuVjBh+ib9UHsjENDiQZVu9odWPOMTzAKX0X/QbKt4J7X87Xfa3ew5FkWgoP
 vRDCKSens9L6TYh6i8/BncI+F/tVJhCH3YAfVLgIYqN4eRJ7ZCOJiqE8xWZSwr9xgPb+w24a/2J
 7KhSlVfBW1X21su7kpqdG
X-Google-Smtp-Source: AGHT+IEb7oIzpxmEDQaLoS1jily73MZ2+hgsSe1LVGWx75obOqykmQZMeix/n1Q4boMl0No/ZHxgSA==
X-Received: by 2002:a05:6a00:2d91:b0:736:8c0f:774f with SMTP id
 d2e1a72fcca58-73905a50265mr25969859b3a.22.1742981684130; 
 Wed, 26 Mar 2025 02:34:44 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57f7sm11729684b3a.44.2025.03.26.02.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:34:43 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v2 4/6] ui/egl: support multi-plane dmabuf when egl
 export/import
Date: Wed, 26 Mar 2025 17:34:16 +0800
Message-ID: <20250326093418.397269-5-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326093418.397269-1-yuq825@gmail.com>
References: <20250326093418.397269-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x633.google.com
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

v2:
  * use new dmabuf API and check length

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 include/ui/egl-helpers.h |  5 ++-
 ui/dbus-listener.c       | 19 +++++----
 ui/egl-helpers.c         | 91 ++++++++++++++++++++++++++++++----------
 ui/spice-display.c       | 58 ++++++++++++++++---------
 4 files changed, 121 insertions(+), 52 deletions(-)

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
index 65373d519c..90147972cd 100644
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
index 8c0e394d2b..f76d0c04a2 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -283,44 +283,85 @@ err:
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
+    int nfds, noffsets, nstrides;
+    const int *fds = qemu_dmabuf_get_fds(dmabuf, &nfds);
+    const uint32_t *offsets = qemu_dmabuf_get_offsets(dmabuf, &noffsets);
+    const uint32_t *strides = qemu_dmabuf_get_strides(dmabuf, &nstrides);
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
     }
 
+    assert(nfds >= num_planes);
+    assert(noffsets >= num_planes);
+    assert(nstrides >= num_planes);
+
     attrs[i++] = EGL_WIDTH;
     attrs[i++] = qemu_dmabuf_get_backing_width(dmabuf);
     attrs[i++] = EGL_HEIGHT;
@@ -328,18 +369,22 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
     attrs[i++] = qemu_dmabuf_get_fourcc(dmabuf);
 
-    attrs[i++] = EGL_DMA_BUF_PLANE0_FD_EXT;
-    attrs[i++] = qemu_dmabuf_get_fds(dmabuf, NULL)[0];
-    attrs[i++] = EGL_DMA_BUF_PLANE0_PITCH_EXT;
-    attrs[i++] = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
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
+        attrs[i++] = fds[j] >= 0 ? fds[j] : fds[0];
+        attrs[i++] = stride_attrs[j];
+        attrs[i++] = strides[j];
+        attrs[i++] = offset_attrs[j];
+        attrs[i++] = offsets[j];
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
index 40547edb5e..d7ebb3682d 100644
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
             stride = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
-- 
2.43.0


