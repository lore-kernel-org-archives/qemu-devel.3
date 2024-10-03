Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7FCF857A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJwN-0001vu-8C; Thu, 03 Oct 2024 07:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwF-0001Mo-PR
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJwB-0004zf-AU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcKY8NbRO5rE3QymUOzFCDyaN/n6+6K2gQ+Ykq/T3aU=;
 b=hvZxb6xtcxDhXNsXtjJf/iQtfgEb5rOqkXijWLPrQCIo4fFUIgIWQFv04Qc13+JshnwGmb
 YTT3lRNLnWnpKhhlN3+Ozwtl9I2+zqsm7OBQkSg4xNglKAwCMXCNOxUQJ7A7Fd58lmShEZ
 iGRUHxdcTEHQWo8ccGwvFNcs6FQuh1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-qBOFjRvwO-eonGj18PX_hA-1; Thu,
 03 Oct 2024 07:23:49 -0400
X-MC-Unique: qBOFjRvwO-eonGj18PX_hA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5D801956096; Thu,  3 Oct 2024 11:23:47 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9C47E19560A3; Thu,  3 Oct 2024 11:23:46 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 12/16] ui/surface: allocate shared memory on !win32
Date: Thu,  3 Oct 2024 15:22:39 +0400
Message-ID: <20241003112244.3340697-13-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use qemu_memfd_alloc() to allocate the display surface memory, which
will fallback on tmpfile/mmap() on systems without memfd, and allow to
share the display with other processes.

This is similar to how display memory is allocated on win32 since commit
09b4c198 ("console/win32: allocate shareable display surface").

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/surface.h |  8 ++++++++
 ui/console.c         | 30 ++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index 345b19169d..dacf12ffe2 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -23,6 +23,10 @@ typedef struct DisplaySurface {
     GLenum gltype;
     GLuint texture;
 #endif
+#ifndef WIN32
+    int shmfd;
+    uint32_t shmfd_offset;
+#endif
 #ifdef WIN32
     HANDLE handle;
     uint32_t handle_offset;
@@ -37,6 +41,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
 DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
 DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                                 const char *msg);
+#ifndef WIN32
+void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
+                                   int shmfd, uint32_t offset);
+#endif
 #ifdef WIN32
 void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
                                           HANDLE h, uint32_t offset);
diff --git a/ui/console.c b/ui/console.c
index fdd76c2be4..56f2462c3d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -37,6 +37,7 @@
 #include "trace.h"
 #include "exec/memory.h"
 #include "qom/object.h"
+#include "qemu/memfd.h"
 
 #include "console-priv.h"
 
@@ -452,6 +453,17 @@ qemu_graphic_console_init(Object *obj)
 {
 }
 
+#ifndef WIN32
+void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
+                                   int shmfd, uint32_t offset)
+{
+    assert(surface->shmfd == -1);
+
+    surface->shmfd = shmfd;
+    surface->shmfd_offset = offset;
+}
+#endif
+
 #ifdef WIN32
 void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
                                           HANDLE h, uint32_t offset)
@@ -469,12 +481,16 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
     void *bits = NULL;
 #ifdef WIN32
     HANDLE handle = NULL;
+#else
+    int shmfd = -1;
 #endif
 
     trace_displaysurface_create(width, height);
 
 #ifdef WIN32
     bits = qemu_win32_map_alloc(width * height * 4, &handle, &error_abort);
+#else
+    bits = qemu_memfd_alloc("displaysurface", width * height * 4, 0, &shmfd, &error_abort);
 #endif
 
     surface = qemu_create_displaysurface_from(
@@ -486,9 +502,13 @@ DisplaySurface *qemu_create_displaysurface(int width, int height)
 
 #ifdef WIN32
     qemu_displaysurface_win32_set_handle(surface, handle, 0);
-    pixman_image_set_destroy_function(surface->image,
-                                      qemu_pixman_shared_image_destroy, handle);
+    void *data = handle;
+#else
+    qemu_displaysurface_set_shmfd(surface, shmfd, 0);
+    void *data = GINT_TO_POINTER(shmfd);
 #endif
+    pixman_image_set_destroy_function(surface->image, qemu_pixman_shared_image_destroy, data);
+
     return surface;
 }
 
@@ -499,6 +519,9 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_from(surface, width, height, format);
+#ifndef WIN32
+    surface->shmfd = -1;
+#endif
     surface->image = pixman_image_create_bits(format,
                                               width, height,
                                               (void *)data, linesize);
@@ -512,6 +535,9 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_pixman(surface);
+#ifndef WIN32
+    surface->shmfd = -1;
+#endif
     surface->image = pixman_image_ref(image);
 
     return surface;
-- 
2.45.2.827.g557ae147e6


