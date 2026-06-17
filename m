Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B5CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs9U-00045V-0b; Wed, 17 Jun 2026 11:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9C-0003pl-V7
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs9B-0004uu-42
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MzOdUytBdgJJhzQhPUejN4Y5WnUZqTyZ0mNfL1b4Eg=;
 b=aX75g4mHhIxWpeAaz5IINpOJ4HDP3jHJm/ZTknGDBk9c2ruxRCCQQPi8hX9gFmvQqTr8cY
 M3p33JQaXDNe/kVrDQascf+AprERkFUlOCscC/iRaZlnSSgZujt9ZQtv9jwZ6Cnkq0Af63
 xTMm+OgnTpBqIa3vyWmBmQvl94LFky8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-dvjBaLQsMqCtU9vNWlCupw-1; Wed,
 17 Jun 2026 11:25:42 -0400
X-MC-Unique: dvjBaLQsMqCtU9vNWlCupw-1
X-Mimecast-MFC-AGG-ID: dvjBaLQsMqCtU9vNWlCupw_1781709941
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 326FD1955F15
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 237053189; Wed, 17 Jun 2026 15:25:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:22 +0400
Subject: [GIT PULL 25/27] ui/pixman: fix zero rowstride in
 qemu_pixman_image_new_shareable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-25-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5684;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SOq11z6oxabN4M1NCITQwuh+JlZhpfFFGuIR0ptG8V4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvpL7wKjpDyzs8JLOm+wykV9r4j7urpezWWo
 VYNwTR6q36JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5ZgLD/9HUjBKk5Yrnq779QlOFeOC/i7cRk6cNzQ0zExqvv/B+mX4yjcLFtmQaXI4O7DpavLPJ8N
 Ps8WmiHdDWQn1Efo1nu9wUXkYdzPVZKT+owo/2fMG9iHLa57otVYGS5qSOqUsrIHirmrVTAyPMq
 Dg3f925ztE04jEmK5LL8kzikmlQwrkWPHXXvZyN9YI8dllORs3z/F8+x1VbRau7hnS8r5at4R8O
 OdSsNmP3qN+ICb25pp//AT+bcVhjjaZAnxGxLlHl5N/qsJ16sM6s8IeVDdUDhziv+9E+gX5e6EF
 r38qvU8E8mP+nhrCO+4RCCjR8zY37rQiDMPmqtnMNdRXdbDFwt/eVQB37I/hkJxaW5NAsW/bWY0
 JDgf6sya3gi6/s6UFdlzHXEGWWGNSffMVRn8ZYzlb1PNosfzqIaBd68MTmTbCj5a9cDAvdCPotm
 FfolY/zB3jGgoo3DPWidr0ldJMVwbP6KF6oRCirPJ2rFAsIIc6YVGc7GwuhOYNS69v0Dd4y0qNR
 Q/ylIcANNPM7RQqG/nfzVHVbmP5gUO/5b9dGODBQl1BBildc1qBvApmupqYwcXos8WzFq/VzB3Y
 8am022gGWXB2XEHMMoy1PJ/IRKnF0GqPQvNbITRaiQRnQVDEGLg4q5L435qbqVXV9RNkykuJWmO
 i+22CKXYn2XTxpA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_create_displaysurface_from() callers such as xlnx_dp.c pass
linesize=0 with data=NULL, relying on pixman to compute the stride.
Since 1ff788db978 ("ui: use a shareable type"), the data=NULL path
goes through qemu_pixman_image_new_shareable() which computes
size = height * rowstride_bytes, resulting in a zero-size allocation
and an abort in qemu_memfd_alloc().

Introduce qemu-pixman-helpers.h with overflow-safe stride and buffer
size computation (matching pixman's create_bits() formula), and use it
from both qemu_pixman_image_new_shareable() and pixman-minimal's
create_bits().

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 1ff788db9781 ("ui: use a shareable type")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260611113614.1935094-1-marcandre.lureau@redhat.com>
---
 include/ui/pixman-minimal.h      | 25 ++++----------------
 include/ui/qemu-pixman-helpers.h | 49 ++++++++++++++++++++++++++++++++++++++++
 include/ui/qemu-pixman.h         |  1 +
 ui/qemu-pixman.c                 |  8 ++++++-
 4 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/include/ui/pixman-minimal.h b/include/ui/pixman-minimal.h
index 6dd7de1c7e7..680cc809ace 100644
--- a/include/ui/pixman-minimal.h
+++ b/include/ui/pixman-minimal.h
@@ -113,6 +113,8 @@ typedef struct pixman_color {
     uint16_t    alpha;
 } pixman_color_t;
 
+#include "qemu-pixman-helpers.h"
+
 static inline uint32_t *create_bits(pixman_format_code_t format,
                                     int width,
                                     int height,
@@ -120,28 +122,9 @@ static inline uint32_t *create_bits(pixman_format_code_t format,
 {
     int stride = 0;
     size_t buf_size = 0;
-    int bpp = PIXMAN_FORMAT_BPP(format);
-
-    /*
-     * Calculate the following while checking for overflow truncation:
-     * stride = ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
-     */
-
-    if (unlikely(__builtin_mul_overflow(width, bpp, &stride))) {
-        return NULL;
-    }
-
-    if (unlikely(__builtin_add_overflow(stride, 0x1f, &stride))) {
-        return NULL;
-    }
-
-    stride >>= 5;
-
-    stride *= sizeof(uint32_t);
 
-    if (unlikely(__builtin_mul_overflow((size_t) height,
-                                        (size_t) stride,
-                                        &buf_size))) {
+    if (!qemu_pixman_image_calc_size(format, width, height,
+                                     &stride, &buf_size)) {
         return NULL;
     }
 
diff --git a/include/ui/qemu-pixman-helpers.h b/include/ui/qemu-pixman-helpers.h
new file mode 100644
index 00000000000..3e247a37946
--- /dev/null
+++ b/include/ui/qemu-pixman-helpers.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Pixman stride and buffer size helpers.
+ * Expects PIXMAN_FORMAT_BPP() and pixman_format_code_t to be
+ * already defined (by either <pixman.h> or "pixman-minimal.h").
+ */
+
+#ifndef QEMU_PIXMAN_HELPERS_H
+#define QEMU_PIXMAN_HELPERS_H
+
+/*
+ * Compute the row stride for a pixman image, aligned to sizeof(uint32_t),
+ * as pixman does. Returns -1 on integer overflow.
+ */
+static inline int qemu_pixman_stride(pixman_format_code_t format, int width)
+{
+    int stride;
+
+    if (unlikely(__builtin_mul_overflow(width, PIXMAN_FORMAT_BPP(format),
+                                        &stride)) ||
+        unlikely(__builtin_add_overflow(stride, 31, &stride))) {
+        return -1;
+    }
+    return (stride / 32) * sizeof(uint32_t);
+}
+
+/*
+ * Compute stride and buffer size for a pixman image.
+ * If *rowstride_bytes is 0, compute it from format and width
+ * (aligned to sizeof(uint32_t), as pixman does).
+ * Returns false on integer overflow.
+ */
+static inline bool qemu_pixman_image_calc_size(pixman_format_code_t format,
+                                               int width, int height,
+                                               int *rowstride_bytes,
+                                               size_t *buf_size)
+{
+    if (!*rowstride_bytes) {
+        *rowstride_bytes = qemu_pixman_stride(format, width);
+        if (*rowstride_bytes < 0) {
+            return false;
+        }
+    }
+
+    return likely(!__builtin_mul_overflow((size_t)height,
+                                          (size_t)*rowstride_bytes, buf_size));
+}
+
+#endif /* QEMU_PIXMAN_HELPERS_H */
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 4bc7a59698e..1d042c7f634 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -8,6 +8,7 @@
 
 #ifdef CONFIG_PIXMAN
 #include <pixman.h>
+#include "qemu-pixman-helpers.h"
 #else
 #include "pixman-minimal.h"
 #endif
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index aea09755b94..9dc606f692a 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -320,12 +320,18 @@ qemu_pixman_image_new_shareable(pixman_image_t **image,
                                 Error **errp)
 {
     ERRP_GUARD();
-    size_t size = height * rowstride_bytes;
+    size_t size;
     void *bits = NULL;
 
     g_return_val_if_fail(image != NULL, false);
     g_return_val_if_fail(handle != NULL, false);
 
+    if (!qemu_pixman_image_calc_size(format, width, height,
+                                     &rowstride_bytes, &size)) {
+        error_setg(errp, "Image dimensions overflow");
+        return false;
+    }
+
     bits = qemu_pixman_shareable_alloc(name, size, handle, errp);
     if (!bits) {
         return false;

-- 
2.54.0


