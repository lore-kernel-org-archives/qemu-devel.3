Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B0C3600E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 03:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdT1-0006wh-39; Wed, 26 Mar 2025 22:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSz-0006vJ-Dg
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdSx-0007f2-AB
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227aaa82fafso11441935ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044372; x=1743649172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IF6+1qu9uhL+EekOvwEYbOGbn7hB8tB+Fgd35faQhNg=;
 b=j8Q6rOTrk6pwLkzsSfS6Ofz7U2qw4MlAwvusrBRdb9gjY4/alB11ObbEgqv44kOIc+
 3M3ISZVuO88CycGaynIwLMLw6m4BlJ/hqIFLU4ecqRjFKanTrD9ZRFi5FgGhv2+mGVUX
 +T7kdQk1MZOHSHWgKSpx0qKrqmYHa5Cnd7vvZ2AsGaiJivdvulSSmKdMwehmiG5tvU3O
 Oj+YXzHmGBNhWodMc5+2oovs7zPIXlhtNdEz9+ridw8UIbiXxUJGN3QF3DalSU+heRVT
 0e3ztbjT/SOpq+hhP/cdoj5QU7SnptfUzznRNdCUGGFLoBWoY/OuJhlEuVzkVx03WOJ9
 AziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044372; x=1743649172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IF6+1qu9uhL+EekOvwEYbOGbn7hB8tB+Fgd35faQhNg=;
 b=ArWkLErJZm/01yfGdYq3d1ELOcDf3ZzT5lqzHePGL1m3L56lmFKrd7Oz5mvKCaBH4A
 hGlvgx6nxqoFueghOPY68OVqpLMrYLTDVLaBBe74Q540YqmZpEf0IsXNUaQ0WVKTUYGS
 O4ZKpTaP6vnpj+7Y39wUPEilIQga+fTW4OUHkvrHCLNK+FQQnMw2STZVSD8kRwRZw7yV
 jRedtidEQvfia7ESoI3WiqVFrllj7pAysQe3SSpoCOs4SIBj44nd7xNb7GcJRC+/tgFK
 aeMvxEnCc09N6nremiqx4CuxU1XHTtNsSW+BJzHVZGmZnBHNfzW/Ai6uY95tG7KmvZL8
 w+2A==
X-Gm-Message-State: AOJu0YzGjH0DxTVQR1t0olAzW+4FkEzMnTsVa4ozcbHbrwwD/gCbzfJ9
 mPgQUYwGjeuHoZGE6DlI0OX2j1byJLi06lfabCzqgsGZnmAGJjHzQVQoHpWH
X-Gm-Gg: ASbGncuzUpiqAgFh5vVtdi/ofQ3/5uyybMipB0/c2RCiyONzu9S75gyJRis5+6nZrr/
 Xxyo6onWOtG5pO18ggzlklwJsNW1O4Ent+1s9AeX910OI4Evw2KRvE0aXv3HeSePtLzDLHG7CjS
 qLelLpxgaH5xwB9UIjF5XsyzswD9DujUvBK9+JhmN3XYkBWgahoVn+xKKPNB4pxVltlo2AukVT5
 9U74AGciBVcqsjczRiKzQPEY9ceyvo4lTkh5U9tSQNRODMRcY1xbKb/a76O+T1tvnp5D+wBm9+g
 GNazLNy7qy0OcRAhl5Sc0vpnOoCDcf5365VEjwQvdOtk+5UprTfn+jKbHOFwol150tBdAPW9FDV
 ZCSsW04p6pa6tWrNKbqOT
X-Google-Smtp-Source: AGHT+IH/5Tsj4Y/u82eXIdi//lBKLJIGL9IP2oEITHk0/29sjP56+mMxuixuszdsQNBtuOkHiGvjXA==
X-Received: by 2002:a17:902:ecc3:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-22804913ccamr27624055ad.41.1743044372365; 
 Wed, 26 Mar 2025 19:59:32 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:32 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 4/6] ui/egl: support multi-plane dmabuf when egl
 export/import
Date: Thu, 27 Mar 2025 10:58:46 +0800
Message-ID: <20250327025848.46962-5-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327025848.46962-1-yuq825@gmail.com>
References: <20250327025848.46962-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x634.google.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


