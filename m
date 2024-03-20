Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640D3CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2uq-0006pg-Az; Wed, 20 Mar 2024 16:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2uo-0006pP-RQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:02 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn2un-0004Vw-4g
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710967921; x=1742503921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dxV3MF5+iP/ZPXXY6+fsokpxMNICvp4QsGMQJNiJA4k=;
 b=kFdT4a+TS0Zait7GuXJ16GTw3sDa5r52SLDZ0jR+kO4Ly6TsGqjnDyXE
 MPAWlcZmCUOtv6vIZAbaqnq1meXE8JjCftNDvl18KY6aCJBUd2ZTTuFyF
 5722nQYRX9EGzorPMwz0jkMWPZYnIHdvNqARmgwXq1tGMMELgBVdhrbbv
 0li/ONtt4oRlhKG6z2N1MwXDVi3qFB9CSaWtAWAuB5IjwD52GFhRFEY8s
 1qqkDglC2nODmOHSn20eJZT5+/ULGWCvfMG/EQeoJKh7H+ZYsqugkPAqz
 1hFYPgewD62cKansVd9J96l2cUn4yzoaQnBRBRWCVDzpBMYcuRnJBzkkr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16463567"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="16463567"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 13:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14679717"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2024 13:51:55 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 2/3] hw/vfio: intialize QemuDmaBuf using the function from
 ui/console
Date: Wed, 20 Mar 2024 13:50:17 -0700
Message-Id: <20240320205018.3351984-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320205018.3351984-1-dongwon.kim@intel.com>
References: <20240320205018.3351984-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

QemuDmaBuf is an abstraction of dmabuf specifically for ui/console usage.
To enhance safety and maintainability, it is needed to centralizes its
creation and initialization within ui/console using newly introduced methods.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/vfio/display.c             | 35 ++++++++++++++++++++---------------
 include/hw/vfio/vfio-common.h |  2 +-
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..a3bdb01789 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -241,14 +241,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
     dmabuf = g_new0(VFIODMABuf, 1);
     dmabuf->dmabuf_id  = plane.dmabuf_id;
-    dmabuf->buf.width  = plane.width;
-    dmabuf->buf.height = plane.height;
-    dmabuf->buf.backing_width = plane.width;
-    dmabuf->buf.backing_height = plane.height;
-    dmabuf->buf.stride = plane.stride;
-    dmabuf->buf.fourcc = plane.drm_format;
-    dmabuf->buf.modifier = plane.drm_format_mod;
-    dmabuf->buf.fd     = fd;
+    dmabuf->buf = dpy_gl_create_dmabuf(plane.width, plane.height, plane.stride,
+                                       0, 0, plane.width, plane.height,
+                                       plane.drm_format, plane.drm_format_mod,
+                                       fd, false);
     if (plane_type == DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
     }
@@ -259,9 +255,15 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDevice *vdev,
 
 static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *dmabuf)
 {
+    int fd;
+
     QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
-    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
-    close(dmabuf->buf.fd);
+    fd = dpy_gl_dmabuf_get_fd(dmabuf->buf);
+    if (fd > -1) {
+        close(fd);
+    }
+
+    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
     g_free(dmabuf);
 }
 
@@ -286,6 +288,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
     VFIODMABuf *primary, *cursor;
+    uint32_t width, height;
     bool free_bufs = false, new_cursor = false;
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
@@ -296,11 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
+    width = dpy_gl_dmabuf_get_width(primary->buf);
+    height = dpy_gl_dmabuf_get_height(primary->buf);
+
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
-        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
+        qemu_console_resize(dpy->con, width, height);
+        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
         free_bufs = true;
     }
 
@@ -314,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     if (cursor && (new_cursor || cursor->hot_updates)) {
         bool have_hot = (cursor->hot_x != 0xffffffff &&
                          cursor->hot_y != 0xffffffff);
-        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
+        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
                              cursor->hot_x, cursor->hot_y);
         cursor->hot_updates = 0;
     } else if (!cursor && new_cursor) {
@@ -328,7 +333,7 @@ static void vfio_display_dmabuf_update(void *opaque)
         cursor->pos_updates = 0;
     }
 
-    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
+    dpy_gl_update(dpy->con, 0, 0, width, height);
 
     if (free_bufs) {
         vfio_display_free_dmabufs(vdev);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..d66e27db02 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -148,7 +148,7 @@ typedef struct VFIOGroup {
 } VFIOGroup;
 
 typedef struct VFIODMABuf {
-    QemuDmaBuf buf;
+    QemuDmaBuf *buf;
     uint32_t pos_x, pos_y, pos_updates;
     uint32_t hot_x, hot_y, hot_updates;
     int dmabuf_id;
-- 
2.34.1


