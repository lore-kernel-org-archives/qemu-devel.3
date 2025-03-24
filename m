Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E71FC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 08:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twd2O-0005yy-76; Mon, 24 Mar 2025 04:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2K-0005yW-UR
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twd2I-0008Vl-Ri
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 04:19:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227b828de00so11227655ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742804392; x=1743409192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+F17rzNN91y1k0DYnf9D8xKNFC10iphwHGYpP+pDpI=;
 b=ecEGt++PdU7zg8aoP6Y5IRGfUCPZQG4nUf/5DEzBDEynDwIB0wovQQ3jPCu08axLCV
 HYbfa2E0WTVjceiDN24ycM4l+ql10L0xtGVDyQdwa/bx88tkJ3eql7WOmy4/PHiOE2Su
 hGK/ajlssh0nReNTm0M5OHi5sqSxL+0+NsDOctRdTwFZZ8kwYP4jw+ssi/Cj93+S5Pr5
 hw15JtkBDioH9HXAV/8XBCcLxfBtynrJy7kq++fYOr2w+cIqKnGEIdYLE8Bz7DxnAAVn
 xqJnPkZv20kQtckQVLj8dpv3MHksAili8diiZ3pzjjuYtELSDx7Ra5TbMDl2CLRqOVAE
 l3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742804392; x=1743409192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+F17rzNN91y1k0DYnf9D8xKNFC10iphwHGYpP+pDpI=;
 b=DbidWu7N98CwnEbswyp/KJFjDXmwCj4l6tLX7B5Ci02IHbSccjcEvDdvybMjAJf2eY
 b+oYK8tILPmuLv8CtLA6FWhaemXb6Y2M/Y0ABSfT7UPXKpG9/d+BrGff9KLQe4ZIhwQz
 XnJNKKzJ9OYfMu9ZVMdJCze+azVz1ee1SWVdu9Yy9VXUqifjI66I9B0j2CS3qjaneV+s
 DAhbilRalz9Z+J/48wcp33UcDiKfQtzl6s/DqTnbMqLPIMW+Mhk0/3UpYIgIVyZPTR6e
 i8VDK0ro6T8RquRp3ACXBKKqc+t4dLXeikdca8Cc9fnnRPpvlcEXVF8abdpOn4ocCM4U
 dv0A==
X-Gm-Message-State: AOJu0YxB2nZvCE7THSN2s7Wn3leNjQJR06p5Csl/6xgwJr+TOsivoQOn
 mU06jfVPzX7JKETv9sK402HaWKrsLZb4t+RKNVYPhnxzVObTHiMFFiuvLWi3
X-Gm-Gg: ASbGncvFDQZzZutxyrgmWFkjxSwVP64qMsWg45w4zGMsb1q2WedkSntAYlIUr9I4bCC
 8ABSrwB2MVBJ8iTHD3MhBET1QssuJpcN3BkoUii42Ii8/m6hOVXEAevHn/PQ1tTsaYlh6fPOOa0
 YX1DYbCsqouCSeKRLMrPAGckRXcPW4qeLGlkgfMtYoq9gAEpLALOoJnx6MARCfp1wst51cCddA6
 RAGTpf70RY8aQrFZ4naFTOkl1lqbKvBWg9j6xfd3I7dc0xAHfEpomETIAkt/OQKsC5pgf4HwBF+
 +vRhzXJPqjgFvEBitVw7KTr15+yjYn0I/YwUzmE3HBRT/0T2SxzphskmryE/sgiHgqH7CvlhY5I
 aiO9ki4h6m2MQCNb8AqRD
X-Google-Smtp-Source: AGHT+IEjADdDtR/Qek+6quUjOis5K/sr7Rt+evRV/Y4eUxCYhkCpSqxs7Ajud3o6SFEZODocomdXww==
X-Received: by 2002:a17:903:41cf:b0:223:5e56:a1ce with SMTP id
 d9443c01a7336-22780e0a90cmr187722645ad.32.1742804392411; 
 Mon, 24 Mar 2025 01:19:52 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2278120a5b6sm64717685ad.252.2025.03.24.01.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 01:19:51 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
Date: Mon, 24 Mar 2025 16:19:21 +0800
Message-ID: <20250324081922.359369-7-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324081922.359369-1-yuq825@gmail.com>
References: <20250324081922.359369-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yuq825@gmail.com; helo=mail-pl1-x62d.google.com
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
 meson.build        |  2 +-
 ui/spice-display.c | 65 +++++++++++++++++++++++-----------------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/meson.build b/meson.build
index 9d9c11731f..b87704a83b 100644
--- a/meson.build
+++ b/meson.build
@@ -1329,7 +1329,7 @@ if get_option('spice') \
              .require(pixman.found(),
                       error_message: 'cannot enable SPICE if pixman is not available') \
              .allowed()
-  spice = dependency('spice-server', version: '>=0.14.0',
+  spice = dependency('spice-server', version: '>=0.14.3',
                      required: get_option('spice'),
                      method: 'pkg-config')
 endif
diff --git a/ui/spice-display.c b/ui/spice-display.c
index b7016ece6a..46b6d5dfc9 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -28,6 +28,8 @@
 
 #include "ui/spice-display.h"
 
+#include "standard-headers/drm/drm_fourcc.h"
+
 bool spice_opengl;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
@@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     if (ssd->ds) {
         uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
         int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
+        uint64_t modifier;
 
         surface_gl_create_texture(ssd->gls, ssd->ds);
         if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)offset,
-                                       (EGLint *)stride, &fourcc, &num_planes, NULL)) {
-            surface_gl_destroy_texture(ssd->gls, ssd->ds);
-            return;
-        }
-
-        if (num_planes > 1) {
-            fprintf(stderr, "%s: does not support multi-plane texture\n", __func__);
+                                       (EGLint *)stride, &fourcc, &num_planes, &modifier)) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
         }
@@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                                     fourcc);
 
         /* note: spice server will close the fd */
-        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
-                             surface_width(ssd->ds),
-                             surface_height(ssd->ds),
-                             stride[0], fourcc, false);
+        spice_qxl_gl_scanout2(&ssd->qxl, fd,
+                              surface_width(ssd->ds),
+                              surface_height(ssd->ds),
+                              offset, stride, num_planes,
+                              fourcc, modifier, false);
         ssd->have_surface = true;
         ssd->have_scanout = false;
 
@@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
     trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
-    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
+    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORMAT_INVALID,
+                          DRM_FORMAT_MOD_INVALID, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
     ssd->have_surface = false;
     ssd->have_scanout = false;
@@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
     int fd[DMABUF_MAX_PLANES], num_planes;
+    uint64_t modifier;
 
     assert(tex_id);
     if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
-                                   &num_planes, NULL)) {
+                                   &num_planes, &modifier)) {
         fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
         return;
     }
-    if (num_planes > 1) {
-        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
-        return;
-    }
+
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
     /* note: spice server will close the fd */
-    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height,
-                         stride[0], fourcc, y_0_top);
+    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_height,
+                          (uint32_t *)offset, (uint32_t *)stride, num_planes,
+                          fourcc, modifier, y_0_top);
     qemu_spice_gl_monitor_config(ssd, x, y, w, h);
     ssd->have_surface = false;
     ssd->have_scanout = true;
@@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    EGLint stride = 0, fourcc = 0;
+    EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
     uint64_t cookie;
-    int fd;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                 ssd->blit_fb.height != height) {
                 int fds[DMABUF_MAX_PLANES], num_planes;
                 uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+                uint64_t modifier;
 
                 trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
                                                   height);
@@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                      width, height);
                 if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds,
                                                (EGLint *)offsets, (EGLint *)strides,
-                                               &fourcc, &num_planes, NULL)) {
+                                               &fourcc, &num_planes, &modifier)) {
                     fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
                     return;
                 }
-                if (num_planes > 1) {
-                    fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
-                    return;
-                }
-                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
-                                     strides[0], fourcc, false);
+
+                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height, offsets, strides,
+                                      num_planes, fourcc, modifier, false);
             }
         } else {
-            stride = qemu_dmabuf_get_stride(dmabuf)[0];
+            int fds[DMABUF_MAX_PLANES];
+
             fourcc = qemu_dmabuf_get_fourcc(dmabuf);
             y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
-            qemu_dmabuf_dup_fd(dmabuf, &fd);
+            qemu_dmabuf_dup_fd(dmabuf, fds);
 
             trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
-                                 stride, fourcc, y_0_top);
+            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
+                                  qemu_dmabuf_get_offset(dmabuf),
+                                  qemu_dmabuf_get_stride(dmabuf),
+                                  qemu_dmabuf_get_num_planes(dmabuf),
+                                  fourcc,
+                                  qemu_dmabuf_get_modifier(dmabuf),
+                                  y_0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
         ssd->guest_dmabuf_refresh = false;
-- 
2.43.0


