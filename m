Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B098C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVct-0007zF-RK; Thu, 29 May 2025 01:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVck-0007xQ-MS
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVci-0008GJ-0E
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748495772; x=1780031772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cxAatodOAORzZ95kPaQtugcUFXjQS+idcd+I3ZMbUoI=;
 b=axZ7UMVvlgtUbpWqF4AFT8L+GCfsjpV/BUcgGQ2G18lIZ/wpvXMrRAYu
 hMCMi+PyVJMjB2zaQ1xg9eUMPu0CaWSmMh/ElTG7FoY5ULF36OVm0cj+m
 uLn7PBWtvAfxTAbcsxZyPTsGdhJtr1pgN0otoyL1gmTFTee26AOgCpcIW
 GPFC18AzV7HHdHbSlKM9wBLyzh3IFwNcuZAUApJWgG6nCZrgykzD0UG6i
 Jz//D5vmLGRrIEnf+tr/soft2PpZpxWuchGaS4wtw+fZEILyvfOK41fYD
 iq6a/9zz2goGcZqd2yqGVZVEDYN4BwVR9Sq9eJ0fL1M3B6xfiy7JlxCq2 A==;
X-CSE-ConnectionGUID: oT4qYxZaTWKD4T+a1asieg==
X-CSE-MsgGUID: Od/0aaYTSnuaCM9ZKU2E6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50241913"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50241913"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:27 -0700
X-CSE-ConnectionGUID: A91srPbvSLeJwLUQxkZsBQ==
X-CSE-MsgGUID: wh7Vo0hxR2GYXoXXa20tvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174455354"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:27 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v5 7/7] ui/spice: Blit the scanout texture if its memory
 layout is not linear
Date: Wed, 28 May 2025 22:11:18 -0700
Message-ID: <20250529051352.1409904-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h |  3 ++
 ui/spice-display.c         | 81 +++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 9bdde78266..690ece7380 100644
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
index 854a97c198..9ce622cefc 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1086,7 +1086,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
-    int fd[DMABUF_MAX_PLANES], num_planes;
+    int fd[DMABUF_MAX_PLANES], num_planes, i;
     uint64_t modifier;
 
     assert(tex_id);
@@ -1098,11 +1098,26 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
 
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
-    /* note: spice server will close the fd */
-    spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
-                            (uint32_t *)offset, (uint32_t *)stride, num_planes,
-                            fourcc, modifier, y_0_top);
-    qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    if (spice_remote_client && modifier != DRM_FORMAT_MOD_LINEAR) {
+        egl_fb_destroy(&ssd->guest_fb);
+        egl_fb_setup_for_tex(&ssd->guest_fb,
+                             backing_width, backing_height,
+                             tex_id, false);
+        ssd->backing_y_0_top = y_0_top;
+        ssd->blit_scanout_texture = true;
+        ssd->new_scanout_texture = true;
+
+        for (i = 0; i < num_planes; i++) {
+            close(fd[i]);
+        }
+    } else {
+        /* note: spice server will close the fd */
+        spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
+                                (uint32_t *)offset, (uint32_t *)stride,
+                                num_planes, fourcc, modifier, y_0_top);
+        qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    }
+
     ssd->have_surface = false;
     ssd->have_scanout = true;
 }
@@ -1168,6 +1183,50 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
 }
 
+static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd,
+                                          egl_fb *scanout_tex_fb)
+{
+    uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+    int fds[DMABUF_MAX_PLANES], num_planes, fourcc;
+    uint64_t modifier;
+    bool ret;
+
+    egl_fb_destroy(scanout_tex_fb);
+    egl_fb_setup_for_tex(scanout_tex_fb,
+                         surface_width(ssd->ds), surface_height(ssd->ds),
+                         ssd->ds->texture, false);
+    egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
+    glFlush();
+
+    if (!ssd->new_scanout_texture) {
+        return true;
+    }
+
+    ret = egl_dmabuf_export_texture(ssd->ds->texture,
+                                    fds,
+                                    (EGLint *)offsets,
+                                    (EGLint *)strides,
+                                    &fourcc,
+                                    &num_planes,
+                                    &modifier);
+    if (!ret) {
+        error_report("spice: failed to get fd for texture");
+        return false;
+    }
+
+    spice_server_gl_scanout(&ssd->qxl, fds,
+                            surface_width(ssd->ds),
+                            surface_height(ssd->ds),
+                            (uint32_t *)offsets, (uint32_t *)strides,
+                            num_planes, fourcc, modifier,
+                            ssd->backing_y_0_top);
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
@@ -1175,6 +1234,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
+    bool ret;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1269,6 +1329,15 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
         glFlush();
     }
 
+    if (spice_remote_client && ssd->blit_scanout_texture) {
+        egl_fb scanout_tex_fb;
+
+        ret = spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
+        if (!ret) {
+            return;
+        }
+    }
+
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-- 
2.49.0


