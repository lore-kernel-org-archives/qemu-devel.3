Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9CAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 19:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtX6-0005u9-3n; Fri, 19 Apr 2024 15:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtX0-0005sp-5H
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxtWx-0004E7-Os
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 15:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713553456; x=1745089456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5PO68DQNUZfb+SjBwv+nx/sOzc/sE+YKuFJciRspZUE=;
 b=bBThJllCS45kK31UH1D3tlq7585aV80ReqbDEnlwFObe4Q3XxynBb8+x
 9iDVWDT6pKLE/7Y19nC3xo4WupHZInx/7m6bYADI21ojcmfS1swfgDqQI
 QezBn8b7jI5g46BZzz0MXvUnnN1os3PcW7gmuwWzx7P/VoUtxjDB2kqA7
 8pQgV5CTETPwhVsreDoGAYaq1J8gKDXtOomUQc7iCDvDvSBkgJ5IOb7C8
 p2E+0uzywgqpsgI0sdz7YRjYBTK4QGpVp+/lMULQrvdTKpZxHayhgi3DJ
 41lcmVIxKKAE4q5kxSOoOb4nKW2nfZK42132bjvy8xFropbJY/8imLWri A==;
X-CSE-ConnectionGUID: NQmsk+8wTfWhyzXaQrqPGA==
X-CSE-MsgGUID: RkcePS5qSzW4ItB+Xv/RkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="20564988"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="20564988"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2024 12:04:07 -0700
X-CSE-ConnectionGUID: cgB8PhXmQNmfVrjA6LqNjg==
X-CSE-MsgGUID: MCdzeAawTWigdyz+GsrQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; d="scan'208";a="54346786"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa002.jf.intel.com with ESMTP; 19 Apr 2024 12:04:08 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v8 2/6] ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf
 struct and helpers
Date: Fri, 19 Apr 2024 11:59:48 -0700
Message-Id: <20240419185952.991930-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419185952.991930-1-dongwon.kim@intel.com>
References: <20240419185952.991930-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
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

New header and source files are added for containing QemuDmaBuf struct
definition and newly introduced helpers for creating/freeing the struct
and accessing its data.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h |  20 +----
 include/ui/dmabuf.h  |  81 +++++++++++++++++
 ui/dmabuf.c          | 206 +++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build       |   1 +
 4 files changed, 289 insertions(+), 19 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

diff --git a/include/ui/console.h b/include/ui/console.h
index 0bc7a00ac0..a208a68b88 100644
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
diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
new file mode 100644
index 0000000000..e332958c39
--- /dev/null
+++ b/include/ui/dmabuf.h
@@ -0,0 +1,81 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * QemuDmaBuf struct and helpers used for accessing its data
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
+#ifndef DMABUF_H
+#define DMABUF_H
+
+typedef struct QemuDmaBuf {
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
+} QemuDmaBuf;
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
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
new file mode 100644
index 0000000000..ef3b07956e
--- /dev/null
+++ b/ui/dmabuf.c
@@ -0,0 +1,206 @@
+/*
+ * SPDX-License-Identifier: MIT
+ *
+ * QemuDmaBuf struct and helpers used for accessing its data
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
index a5ce22a678..3b724eb2f1 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -17,6 +17,7 @@ system_ss.add(files(
   'ui-hmp-cmds.c',
   'ui-qmp-cmds.c',
   'util.c',
+  'dmabuf.c',
 ))
 system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
 if dbus_display
-- 
2.34.1


