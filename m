Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC824C04FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxZxO-0001RY-Sh; Thu, 18 Apr 2024 18:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZxK-0001Qj-9Q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:10 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZxG-0001zY-MT
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713478206; x=1745014206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nMsvYvPGRXdO+98hOVHSC7j1wW0RCka3DHS4lg1WWRs=;
 b=BuvXwS4FDUvu6Kd9Hpulh0SX8/FW2aWgxGNPYxWaWXNJ/Isbgs+txoRt
 Vtw+zpFZnwRfanhNq5aOni9Ml8UF0BaCseTiaFbvLeYZ6HPBHl8H0jS1C
 YvmhTVnPUsI8q+aPIMc6kyCe9RVro4iTYq8MCb9WoymbqV6MWH5gyS7HY
 BouhXLceqSZ33YubnR8iS3gGP4vz5USVdN8bOs1il6AH14lpjjECFMGTR
 8ceSIjs1/E0Y5i34QJ0AHgBvRdtE0eIpztKTAr18NBALCaTQ+3HxLT6L4
 pFz9r4eJ05LH+HsdfUOGbY53KdZV/6mNDQBtJk1MYeRZg7tPSvynX2kGS Q==;
X-CSE-ConnectionGUID: MPbqH/MMRI6Fj86BmrgmkA==
X-CSE-MsgGUID: 4WDxS+tATlSV/w04rZF42A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12002034"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="12002034"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 15:09:55 -0700
X-CSE-ConnectionGUID: osOFp8NnR0KyZ9ghHRhwsg==
X-CSE-MsgGUID: 6iH7HHVgQ96gE4c7mZ9Vpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="60559332"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 15:09:56 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com
Subject: [PATCH v7 5/5] ui/dmabuf: New dmabuf.c and dmabuf.h for QemuDmaBuf
 struct and helpers
Date: Thu, 18 Apr 2024 15:05:41 -0700
Message-Id: <20240418220541.931134-6-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418220541.931134-1-dongwon.kim@intel.com>
References: <20240418220541.931134-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

Create new header and source files to encapsulate QemuDmaBuf struct
and its data for privatization.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h |  52 +---------
 include/ui/dmabuf.h  |  38 ++++++++
 ui/console.c         | 179 +---------------------------------
 ui/dmabuf.c          | 223 +++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build       |   1 +
 5 files changed, 264 insertions(+), 229 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

diff --git a/include/ui/console.h b/include/ui/console.h
index b47135bc2f..5e5c4b6951 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -7,6 +7,7 @@
 #include "qapi/qapi-types-ui.h"
 #include "ui/input.h"
 #include "ui/surface.h"
+#include "ui/dmabuf.h"
 
 #define TYPE_QEMU_CONSOLE "qemu-console"
 OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
@@ -185,25 +186,6 @@ struct QEMUGLParams {
     int minor_ver;
 };
 
-typedef struct QemuDmaBuf {
-    int       fd;
-    uint32_t  width;
-    uint32_t  height;
-    uint32_t  stride;
-    uint32_t  fourcc;
-    uint64_t  modifier;
-    uint32_t  texture;
-    uint32_t  x;
-    uint32_t  y;
-    uint32_t  backing_width;
-    uint32_t  backing_height;
-    bool      y0_top;
-    void      *sync;
-    int       fence_fd;
-    bool      allow_fences;
-    bool      draw_submitted;
-} QemuDmaBuf;
-
 enum display_scanout {
     SCANOUT_NONE,
     SCANOUT_SURFACE,
@@ -358,42 +340,10 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
-QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
-                                   uint32_t stride, uint32_t x,
-                                   uint32_t y, uint32_t backing_width,
-                                   uint32_t backing_height, uint32_t fourcc,
-                                   uint64_t modifier, int32_t dmabuf_fd,
-                                   bool allow_fences, bool y0_top);
-void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
-
-G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
-
-int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
-uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
-uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
-bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
-int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
-bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
-void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
-void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
-void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
                    uint32_t x, uint32_t y, uint32_t w, uint32_t h);
-
 QEMUGLContext dpy_gl_ctx_create(QemuConsole *con,
                                 QEMUGLParams *params);
 void dpy_gl_ctx_destroy(QemuConsole *con, QEMUGLContext ctx);
diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
new file mode 100644
index 0000000000..8de33cd1ab
--- /dev/null
+++ b/include/ui/dmabuf.h
@@ -0,0 +1,38 @@
+#ifndef DMABUF_H
+#define DMABUF_H
+
+typedef struct QemuDmaBuf QemuDmaBuf;
+
+QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
+                                   uint32_t stride, uint32_t x,
+                                   uint32_t y, uint32_t backing_width,
+                                   uint32_t backing_height, uint32_t fourcc,
+                                   uint64_t modifier, int32_t dmabuf_fd,
+                                   bool allow_fences, bool y0_top);
+void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
+
+int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
+uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
+uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
+bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
+void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
+int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
+bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
+bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
+void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
+void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
+void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
+void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
+void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
+
+#endif
diff --git a/ui/console.c b/ui/console.c
index 101af3df4a..f5a2cd75e9 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
+#include "ui/dmabuf.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
@@ -1132,184 +1133,6 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
-QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
-                                   uint32_t stride, uint32_t x,
-                                   uint32_t y, uint32_t backing_width,
-                                   uint32_t backing_height, uint32_t fourcc,
-                                   uint64_t modifier, int32_t dmabuf_fd,
-                                   bool allow_fences, bool y0_top) {
-    QemuDmaBuf *dmabuf;
-
-    dmabuf = g_new0(QemuDmaBuf, 1);
-
-    dmabuf->width = width;
-    dmabuf->height = height;
-    dmabuf->stride = stride;
-    dmabuf->x = x;
-    dmabuf->y = y;
-    dmabuf->backing_width = backing_width;
-    dmabuf->backing_height = backing_height;
-    dmabuf->fourcc = fourcc;
-    dmabuf->modifier = modifier;
-    dmabuf->fd = dmabuf_fd;
-    dmabuf->allow_fences = allow_fences;
-    dmabuf->y0_top = y0_top;
-    dmabuf->fence_fd = -1;
-
-    return dmabuf;
-}
-
-void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
-{
-    if (dmabuf == NULL) {
-        return;
-    }
-
-    g_free(dmabuf);
-}
-
-int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->fd;
-}
-
-uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->width;
-}
-
-uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->height;
-}
-
-uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->stride;
-}
-
-uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->fourcc;
-}
-
-uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->modifier;
-}
-
-uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->texture;
-}
-
-uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->x;
-}
-
-uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->y;
-}
-
-uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->backing_width;
-}
-
-uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->backing_height;
-}
-
-bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->y0_top;
-}
-
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->sync;
-}
-
-int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->fence_fd;
-}
-
-bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->allow_fences;
-}
-
-bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->draw_submitted;
-}
-
-void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
-{
-    assert(dmabuf != NULL);
-    dmabuf->texture = texture;
-}
-
-void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
-{
-    assert(dmabuf != NULL);
-    dmabuf->fence_fd = fence_fd;
-}
-
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
-{
-    assert(dmabuf != NULL);
-    dmabuf->sync = sync;
-}
-
-void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
-{
-    assert(dmabuf != NULL);
-    dmabuf->draw_submitted = draw_submitted;
-}
-
-void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
-{
-    assert(dmabuf != NULL);
-    dmabuf->fd = fd;
-}
-
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
new file mode 100644
index 0000000000..a81cc244ac
--- /dev/null
+++ b/ui/dmabuf.c
@@ -0,0 +1,223 @@
+/*
+ * QEMU DmaBuf
+ *
+ * Copyright (c) 2024 Dongwon Kim <dongwon.kim@intel.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "ui/dmabuf.h"
+
+struct QemuDmaBuf {
+    int       fd;
+    uint32_t  width;
+    uint32_t  height;
+    uint32_t  stride;
+    uint32_t  fourcc;
+    uint64_t  modifier;
+    uint32_t  texture;
+    uint32_t  x;
+    uint32_t  y;
+    uint32_t  backing_width;
+    uint32_t  backing_height;
+    bool      y0_top;
+    void      *sync;
+    int       fence_fd;
+    bool      allow_fences;
+    bool      draw_submitted;
+};
+
+QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
+                            uint32_t stride, uint32_t x,
+                            uint32_t y, uint32_t backing_width,
+                            uint32_t backing_height, uint32_t fourcc,
+                            uint64_t modifier, int32_t dmabuf_fd,
+                            bool allow_fences, bool y0_top) {
+    QemuDmaBuf *dmabuf;
+
+    dmabuf = g_new0(QemuDmaBuf, 1);
+
+    dmabuf->width = width;
+    dmabuf->height = height;
+    dmabuf->stride = stride;
+    dmabuf->x = x;
+    dmabuf->y = y;
+    dmabuf->backing_width = backing_width;
+    dmabuf->backing_height = backing_height;
+    dmabuf->fourcc = fourcc;
+    dmabuf->modifier = modifier;
+    dmabuf->fd = dmabuf_fd;
+    dmabuf->allow_fences = allow_fences;
+    dmabuf->y0_top = y0_top;
+    dmabuf->fence_fd = -1;
+
+    return dmabuf;
+}
+
+void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf == NULL) {
+        return;
+    }
+
+    g_free(dmabuf);
+}
+
+int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->fd;
+}
+
+uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->width;
+}
+
+uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->height;
+}
+
+uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->stride;
+}
+
+uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->fourcc;
+}
+
+uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->modifier;
+}
+
+uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->texture;
+}
+
+uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->x;
+}
+
+uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->y;
+}
+
+uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->backing_width;
+}
+
+uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->backing_height;
+}
+
+bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->y0_top;
+}
+
+void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->sync;
+}
+
+int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->fence_fd;
+}
+
+bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->allow_fences;
+}
+
+bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->draw_submitted;
+}
+
+void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
+{
+    assert(dmabuf != NULL);
+    dmabuf->texture = texture;
+}
+
+void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
+{
+    assert(dmabuf != NULL);
+    dmabuf->fence_fd = fence_fd;
+}
+
+void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
+{
+    assert(dmabuf != NULL);
+    dmabuf->sync = sync;
+}
+
+void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
+{
+    assert(dmabuf != NULL);
+    dmabuf->draw_submitted = draw_submitted;
+}
+
+void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
+{
+    assert(dmabuf != NULL);
+    dmabuf->fd = fd;
+}
diff --git a/ui/meson.build b/ui/meson.build
index a5ce22a678..5d89986b0e 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -7,6 +7,7 @@ system_ss.add(files(
   'clipboard.c',
   'console.c',
   'cursor.c',
+  'dmabuf.c',
   'input-keymap.c',
   'input-legacy.c',
   'input-barrier.c',
-- 
2.34.1


