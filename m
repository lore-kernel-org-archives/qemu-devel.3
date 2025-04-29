Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352E5C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eCv-0000pG-2E; Tue, 29 Apr 2025 02:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCf-0000ap-UX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:29 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCe-0005Ma-5h
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907144; x=1777443144;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q/7IV4zXWPUNZVc5NISNGgaHsZd/LQO2N4LerTRJBK4=;
 b=D9izVgN3VRYivMvIs3vpwlqoOjaJwj4BjBRlgCJRKNmsHNsjm2vGkNeL
 2rfwAuHuTEpOzCYPUlhezuUFHQY3apdExDGSfh76y/O5IKD+kussvYqZq
 2aLT/7yBkdFg8GfbZBH0NeQUNCd+oq0dBNHgbI8CbNGfeOkztknQQ7mUT
 i+oG310zCtheqyiKtRIaCLhC+/MB+mQEux8vj9teNWjeMIYFGEWyFgynK
 V9RdWyGkM/RHuZRLG6mg8+f51MqR0eJA+oimOAx5X2A9FpF1uc+xu33Lr
 pMY5pVtgbF31Ev1YB9PotdfXZ13+Jskv7NLotusTowxtZeaOwPBye6aqt w==;
X-CSE-ConnectionGUID: m2cpyFRIQjCm8Q7j3lxKyQ==
X-CSE-MsgGUID: nxFtkTgSTVWn1Mxdyv6wfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58169841"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58169841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:10 -0700
X-CSE-ConnectionGUID: MZTwtlBtTSqclV3Z+pp9Pw==
X-CSE-MsgGUID: 8iHTZ+NNSp6G8aGvDJ9oCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133687174"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:05 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v3 5/6] ui/spice: Create a new texture with linear layout when
 gl=on is enabled
Date: Mon, 28 Apr 2025 23:08:29 -0700
Message-ID: <20250429060952.59508-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429060952.59508-1-vivek.kasireddy@intel.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Since most encoders/decoders (invoked by Spice) may not work with
tiled memory associated with a texture, we need to create another
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
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/spice-display.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 2c4daa0707..047d453a0b 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -26,6 +26,7 @@
 #include "ui/console.h"
 #include "trace.h"
 
+#include "standard-headers/drm/drm_fourcc.h"
 #include "ui/spice-display.h"
 
 bool spice_opengl;
@@ -890,11 +891,65 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
+                                        EGLint *stride, EGLint *fourcc,
+                                        EGLuint64KHR *modifier,
+                                        int *fd)
+{
+    GLuint texture = 0;
+
+    if (!remote_client) {
+        return true;
+    }
+
+    if (surface_format(ssd->ds) == PIXMAN_r5g6b5) {
+        return true;
+    }
+
+    if (*modifier == DRM_FORMAT_MOD_LINEAR) {
+        return true;
+    }
+
+    /*
+     * We really want to ensure that the memory layout of the texture
+     * is linear; otherwise, the encoder's output may show corruption.
+     */
+    surface_gl_create_texture_from_fd(ssd->ds, *fd, &texture);
+
+    /*
+     * A successful return after glImportMemoryFdEXT() means that
+     * the ownership of fd has been passed to GL. In other words,
+     * the fd we got above should not be used anymore.
+     */
+    if (texture > 0) {
+        *fd = egl_get_fd_for_texture(texture,
+                                     stride, fourcc,
+                                     NULL);
+        if (*fd < 0) {
+            glDeleteTextures(1, &texture);
+            *fd = egl_get_fd_for_texture(ssd->ds->texture,
+                                         stride, fourcc,
+                                         NULL);
+            if (*fd < 0) {
+                surface_gl_destroy_texture(ssd->gls, ssd->ds);
+                warn_report("spice: no texture available to display");
+                return false;
+            }
+        } else {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            ssd->ds->texture = texture;
+        }
+    }
+    return true;
+}
+
 static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint stride, fourcc;
+    EGLuint64KHR modifier;
+    bool ret;
     int fd;
 
     if (ssd->ds) {
@@ -905,12 +960,18 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
         surface_gl_create_texture(ssd->gls, ssd->ds);
         fd = egl_get_fd_for_texture(ssd->ds->texture,
                                     &stride, &fourcc,
-                                    NULL);
+                                    &modifier);
         if (fd < 0) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
         }
 
+        ret = spice_gl_replace_fd_texture(ssd, &stride, &fourcc, &modifier, &fd);
+        if (!ret) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            return;
+        }
+
         trace_qemu_spice_gl_surface(ssd->qxl.id,
                                     surface_width(ssd->ds),
                                     surface_height(ssd->ds),
-- 
2.49.0


