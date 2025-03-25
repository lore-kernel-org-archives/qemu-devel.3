Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7350AC3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDvl-0000Ro-2z; Tue, 25 Mar 2025 19:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDvf-0000Pl-Rh
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:31 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDve-0005Gz-1C
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742946210; x=1774482210;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SE7yhbP+AWXupah990h9uyu4eFpaGpDOFqgO8RURnbU=;
 b=gDuTDkv4LZGKuwXcfD2//aJ46ax2ntQpXP1dnAUDrJIkcVlroxN+xgIU
 TrPFrcmM1QDkE/2jNbGNYF7iv6r/aA/UnZVzJLferUP18sLDg/ZXQqFlz
 w1OrGscNMNdT5rUy7ZPdZODEgJR8fGiFZ9V2COsCeowEItWKaGJ9VfC3g
 NfnsGCjnBgGBFihYzd7dS6KkffLddGLlS4f4JUCperv2GuEmBn9Pc1r5b
 fUgOXyxI0CLu6E44HVpvQr3+izQSewoDG13EnXS0WVgLZ9lZNoDX6DS+0
 99I0ooag6gADJh4enMh5MckQ9C63S5t0j2xbrpvXcPuikKdURjK3pXzo5 A==;
X-CSE-ConnectionGUID: sDRBK8OlQYah7R7zHiBZ4g==
X-CSE-MsgGUID: gTHF1k4/TCS6TfXmpPLUig==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55582853"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="55582853"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:20 -0700
X-CSE-ConnectionGUID: OPOi+L8XQfqhLQxKJAmuiw==
X-CSE-MsgGUID: l7l4lM4bSXums8DUvn7HnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="124332511"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:18 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v2 6/6] ui/spice: Blit the scanout texture if its memory
 layout is not linear
Date: Tue, 25 Mar 2025 16:39:36 -0700
Message-ID: <20250325234115.1332883-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In cases where the scanout buffer is provided as a texture (e.g. Virgl)
we need to check to see if it has a linear memory layout or not. If
it doesn't have a linear layout, then blitting it onto the texture
associated with the display surface (which already has a linear layout)
seems to ensure that there is no corruption seen regardless of which
encoder or decoder is used.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h |  3 ++
 ui/spice-display.c         | 67 +++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index f4922dd74b..d087d7198a 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -132,6 +132,9 @@ struct SimpleSpiceDisplay {
     egl_fb guest_fb;
     egl_fb blit_fb;
     egl_fb cursor_fb;
+    bool backing_y_0_top;
+    bool blit_scanout_texture;
+    bool new_scanout_texture;
     bool have_hot;
 #endif
 };
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 047d453a0b..3fa15d6981 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1035,20 +1035,34 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint stride = 0, fourcc = 0;
+    EGLuint64KHR modifier = 0;
     int fd = -1;
 
     assert(tex_id);
-    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc, NULL);
+
+    fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc, &modifier);
     if (fd < 0) {
         fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
         return;
     }
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
-    /* note: spice server will close the fd */
-    spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
-                         stride, fourcc, y_0_top);
-    qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    if (remote_client && modifier != DRM_FORMAT_MOD_LINEAR) {
+        egl_fb_destroy(&ssd->guest_fb);
+        egl_fb_setup_for_tex(&ssd->guest_fb,
+                             backing_width, backing_height,
+                             tex_id, false);
+        ssd->backing_y_0_top = y_0_top;
+        ssd->blit_scanout_texture = true;
+        ssd->new_scanout_texture = true;
+        close(fd);
+    } else {
+        /* note: spice server will close the fd */
+        spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
+                             stride, fourcc, y_0_top);
+        qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    }
+
     ssd->have_surface = false;
     ssd->have_scanout = true;
 }
@@ -1114,6 +1128,41 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
 }
 
+static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd)
+{
+    EGLint stride = 0, fourcc = 0;
+    int fd;
+
+    egl_fb_destroy(&ssd->blit_fb);
+    egl_fb_setup_for_tex(&ssd->blit_fb,
+                         surface_width(ssd->ds), surface_height(ssd->ds),
+                         ssd->ds->texture, false);
+    egl_fb_blit(&ssd->blit_fb, &ssd->guest_fb, false);
+    glFlush();
+
+    if (!ssd->new_scanout_texture) {
+        return true;
+    }
+
+    fd = egl_get_fd_for_texture(ssd->ds->texture,
+                                &stride, &fourcc,
+                                NULL);
+    if (fd < 0) {
+        fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
+        return false;
+    }
+
+    spice_qxl_gl_scanout(&ssd->qxl, fd,
+                         surface_width(ssd->ds),
+                         surface_height(ssd->ds),
+                         stride, fourcc, ssd->backing_y_0_top);
+    qemu_spice_gl_monitor_config(ssd, 0, 0,
+                                 surface_width(ssd->ds),
+                                 surface_height(ssd->ds));
+    ssd->new_scanout_texture = false;
+    return true;
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
@@ -1121,6 +1170,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint stride = 0, fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
+    bool ret;
     int fd;
     uint32_t width, height, texture;
 
@@ -1195,6 +1245,13 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
         glFlush();
     }
 
+    if (remote_client && ssd->blit_scanout_texture) {
+        ret = spice_gl_blit_scanout_texture(ssd);
+        if (!ret) {
+            return;
+        }
+    }
+
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-- 
2.48.1


