Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC14CEB365A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 03:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxGBO-00018t-Tl; Mon, 02 Mar 2026 22:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxGBN-00017q-1P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:12:25 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxGBJ-0005Zn-P7
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 22:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772507542; x=1804043542;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f3PLxG7obKkufdeeCmWMF1n7vnhFl87d+sDyWglp1+U=;
 b=Sy92dvJPnLgwnZtxBuqsgTQ7S+uHlZf6BOFKTPk3X9QWKOJV49FbiXqv
 1jOil475SKY6Q6yv+7Pv/5QjvhcgkLEYeelxCx1iE1ZScaceNpy6waOIK
 aEPtJwmRaq6+8rnXz7THWc5/39hvnODQU8nkDYxL0fW4BQaYFRGOF6GkN
 CZyctXpDyO0yxdzIEjbkTpPC3lZwErURIFnYPHMsq6hsL1wH4ne6QGcA5
 HYrRVDp+Tq9J/3IwvJysw/53hBkB8zhlS8Vvkj3BdFCsJu3fGLR0kvfkc
 TzT/1A234X5n8f2wJuSeyCqi+cAcZzsMLCHH/N9KtB+jgeSQp9JGXpm2c Q==;
X-CSE-ConnectionGUID: tjhSXCY1S4KJwMkYm5yong==
X-CSE-MsgGUID: rVitdxIqQ/CnaXbi07nT7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84881212"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="84881212"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 19:12:17 -0800
X-CSE-ConnectionGUID: tQaqoKQNThWcF/d+50qSgw==
X-CSE-MsgGUID: TOKDpUcCQdeGKu/HhW12BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="244797607"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by fmviesa001.fm.intel.com with ESMTP; 02 Mar 2026 19:12:17 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Implement dpy_gl_ctx_destroy_texture for gtk-egl and
 gtk-gl-area
Date: Mon,  2 Mar 2026 19:07:14 -0800
Message-Id: <20260303030714.1926907-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dongwon Kim <dongwon.kim@intel.com>

Currently, the texture associated with a DisplaySurface is not deleted
when the surface is switched or freed, leading to a memory leak in the
GPU process. This occurs because the GTK backend lacks a mapping for the
'dpy_gl_ctx_destroy_texture' operation.

This patch implements the necessary cleanup functions for both EGL and
GL Area backends. Each implementation ensures the appropriate GL context
is made current before calling surface_gl_destroy_texture(), ensuring
that the underlying GL texture ID is safely released by the driver.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/gtk.h |  4 ++++
 ui/gtk-egl.c     | 10 ++++++++++
 ui/gtk-gl-area.c |  8 ++++++++
 ui/gtk.c         |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 3e6ce3cb48..f1765ad5cb 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -170,6 +170,8 @@ void gd_egl_switch(DisplayChangeListener *dcl,
                    DisplaySurface *surface);
 QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
                                     QEMUGLParams *params);
+void gd_egl_destroy_texture(DisplayGLCtx *dgc,
+                            DisplaySurface *surface);
 void gd_egl_scanout_disable(DisplayChangeListener *dcl);
 void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_id,
@@ -206,6 +208,8 @@ QEMUGLContext gd_gl_area_create_context(DisplayGLCtx *dgc,
                                         QEMUGLParams *params);
 void gd_gl_area_destroy_context(DisplayGLCtx *dgc,
                                 QEMUGLContext ctx);
+void gd_gl_area_destroy_texture(DisplayGLCtx *dgc,
+                                DisplaySurface *surface);
 void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf);
 void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999c..c1b32bc41b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -225,6 +225,16 @@ QEMUGLContext gd_egl_create_context(DisplayGLCtx *dgc,
     return qemu_egl_create_context(dgc, params);
 }
 
+void gd_egl_destroy_texture(DisplayGLCtx *dgc, DisplaySurface *surface)
+{
+    VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
+
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
+
+    surface_gl_destroy_texture(dgc->gls, surface);
+}
+
 void gd_egl_scanout_disable(DisplayChangeListener *dcl)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index cd86022d26..84e41f4221 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -299,6 +299,14 @@ void gd_gl_area_destroy_context(DisplayGLCtx *dgc, QEMUGLContext ctx)
     g_clear_object(&ctx);
 }
 
+void gd_gl_area_destroy_texture(DisplayGLCtx *dgc, DisplaySurface *surface)
+{
+    VirtualConsole *vc = container_of(dgc, VirtualConsole, gfx.dgc);
+
+    gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+    surface_gl_destroy_texture(dgc->gls, surface);
+}
+
 void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_id,
                                 bool backing_y_0_top,
diff --git a/ui/gtk.c b/ui/gtk.c
index 9ebe7e8df0..217f425075 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -636,6 +636,7 @@ static const DisplayGLCtxOps gl_area_ctx_ops = {
     .dpy_gl_ctx_is_compatible_dcl = gd_gl_area_is_compatible_dcl,
     .dpy_gl_ctx_create       = gd_gl_area_create_context,
     .dpy_gl_ctx_destroy      = gd_gl_area_destroy_context,
+    .dpy_gl_ctx_destroy_texture = gd_gl_area_destroy_texture,
     .dpy_gl_ctx_make_current = gd_gl_area_make_current,
 };
 
@@ -670,6 +671,7 @@ static const DisplayGLCtxOps egl_ctx_ops = {
     .dpy_gl_ctx_is_compatible_dcl = gd_egl_is_compatible_dcl,
     .dpy_gl_ctx_create       = gd_egl_create_context,
     .dpy_gl_ctx_destroy      = qemu_egl_destroy_context,
+    .dpy_gl_ctx_destroy_texture = gd_egl_destroy_texture,
     .dpy_gl_ctx_make_current = gd_egl_make_current,
 };
 #endif
-- 
2.43.0


