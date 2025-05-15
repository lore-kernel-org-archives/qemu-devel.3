Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13021C5475C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOfA-0006nY-NC; Wed, 14 May 2025 22:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf6-0006kB-4G
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:32 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf4-0005i5-2c
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747277370; x=1778813370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mvjg/ktKajg8f9d4j5dRKNxgmW9hH868BCrGCjM/hms=;
 b=bwuhKJH+Hi2Mj/KbzAuIdm2ByG3n/YQGLpRmPny29Mb1XzR7AHNCgnhT
 idj0X2uIcektpWctyQ0pXpYZlJ/uktGMKkvybgXKb0DwFzncYTBcCIq4h
 ilomTf3vPqU8YolaBxd72vzRk60km9pss2GZDd5pngQWiPlpnbZvfIJuK
 WluIwS1WAILNSh7kJ24HeYscOTq1sfmLQSFD+eLa3k6rzQhUVXhlN14v0
 EfSaPXsfFfgSJlvtNT0oNCZ83MufYJtqrDwluOdfsf+LxcK612np2tls7
 4o+nrbnn9rHY8L6xmCBz/1snf7RaTysnEWFq6hyXMPeQc02oQ+uakHcL+ Q==;
X-CSE-ConnectionGUID: ppYI9U3ZTceC8faRqj59Dg==
X-CSE-MsgGUID: yBDmQe5rSeyP707PGWIthA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36819312"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="36819312"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
X-CSE-ConnectionGUID: hOEe7SKDQgupDhbR7E4/Lw==
X-CSE-MsgGUID: Y5dbmWe/QJqkW4reyDzaxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="142246661"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v4 6/7] ui/spice: Create a new texture with linear layout when
 gl=on is enabled
Date: Wed, 14 May 2025 19:45:44 -0700
Message-ID: <20250515024734.758335-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515024734.758335-1-vivek.kasireddy@intel.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
 ui/spice-display.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index ed91521ac2..fb56da4ab0 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -893,6 +893,75 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
+                                        int *fds, uint64_t *modifier,
+                                        int *num_planes)
+{
+    uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+    GLuint texture = 0;
+    int fourcc;
+    bool ret;
+
+    if (!remote_client) {
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
+    if (!surface_gl_create_texture_from_fd(ssd->ds, fds[0], &texture)) {
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
+    }
+    return ret;
+}
+
 static void spice_server_gl_scanout(QXLInstance *qxl,
                                     const int *fd,
                                     uint32_t width, uint32_t height,
@@ -917,6 +986,7 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+    bool ret;
 
     if (ssd->ds) {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
@@ -939,6 +1009,12 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
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
2.49.0


