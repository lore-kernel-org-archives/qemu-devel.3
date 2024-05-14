Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFA1C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s2c-0004Cq-B1; Tue, 14 May 2024 09:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2b-000480-Ci
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2Z-0002JP-FC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ/XfE369Dtu2s+FlUhtbEsUIXm5785Bdr8tO/dWyIg=;
 b=WWinbXrSxHi3jJeB2pQJmxe4ikSZ3YG2D5zS7JmK3EBzCltkwVlvtp2lMlf5wUWGBsDdbY
 NbrCV7ULTbBViCelO4rJvgRppvZ2mDF1x8cf4i61p68IS6eb2pZAOexhG5Jr1yFkuR5qTi
 moc1fy11gOV/MXlw0mK8aUhDgSdKy1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-fHoPcTEKPxy4YBFNEU-cuw-1; Tue,
 14 May 2024 09:17:47 -0400
X-MC-Unique: fHoPcTEKPxy4YBFNEU-cuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 087FD3C000AE;
 Tue, 14 May 2024 13:17:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CFBE40C6EB7;
 Tue, 14 May 2024 13:17:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 04/11] ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf
 struct and helpers
Date: Tue, 14 May 2024 17:17:18 +0400
Message-ID: <20240514131725.931234-5-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
     GPL to be in line with QEMU's default license

v11: -- Added new helpers, qemu_dmabuf_close for closing dmabuf->fd,
        qemu_dmabuf_dup_fd for duplicating dmabuf->fd
        (Daniel P. Berrangé <berrange@redhat.com>)

     -- Let qemu_dmabuf_fee to call qemu_dmabuf_close before freeing
        the struct to make sure fd is closed.
        (Daniel P. Berrangé <berrange@redhat.com>)

v12: Not closing fd in qemu_dmabuf_free because there are cases fd
     should still be available even after the struct is destroyed
     (e.g. virtio-gpu: res->dmabuf_fd).

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Message-Id: <20240508175403.3399895-3-dongwon.kim@intel.com>
---
 include/ui/console.h |  20 +----
 include/ui/dmabuf.h  |  66 ++++++++++++++
 ui/dmabuf.c          | 210 +++++++++++++++++++++++++++++++++++++++++++
 ui/meson.build       |   1 +
 4 files changed, 278 insertions(+), 19 deletions(-)
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
index 0000000000..4198cdf85a
--- /dev/null
+++ b/include/ui/dmabuf.h
@@ -0,0 +1,66 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QemuDmaBuf struct and helpers used for accessing its data
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
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
+                            uint32_t stride, uint32_t x,
+                            uint32_t y, uint32_t backing_width,
+                            uint32_t backing_height, uint32_t fourcc,
+                            uint64_t modifier, int dmabuf_fd,
+                            bool allow_fences, bool y0_top);
+void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
+
+int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
+int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);
+void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
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
index 0000000000..e047d5ca26
--- /dev/null
+++ b/ui/dmabuf.c
@@ -0,0 +1,210 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QemuDmaBuf struct and helpers used for accessing its data
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
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
+int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    return dmabuf->fd;
+}
+
+int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    if (dmabuf->fd >= 0) {
+        return dup(dmabuf->fd);
+    } else {
+        return -1;
+    }
+}
+
+void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
+{
+    assert(dmabuf != NULL);
+
+    if (dmabuf->fd >= 0) {
+        close(dmabuf->fd);
+        dmabuf->fd = -1;
+    }
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
2.41.0.28.gd7d8841f67


