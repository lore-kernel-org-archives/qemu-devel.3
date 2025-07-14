Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6C7C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHiK-0003Kb-Gs; Mon, 14 Jul 2025 07:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH5r-0006Jn-Rj
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH5q-0003FS-4M
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGxC8pOOHdvNF80rDAG/0y/ryZPUHgUpZxYeZeyNMtI=;
 b=LrnW84H7q1paUf4oT0dGn2+vUjZWr6G3/B5md0nIBZv8c4jzkH048vUrlbBzqxK0QjWkjS
 5nN29JesFvKoQqmuaOy7oABZIYjB59FXeqJTGvngLn0SuKHCzTUsHiiW/cCur9kz0Mk4Yy
 H8XaYv54Nd/tyhK4ZWpqGTgX2/3QFc8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-z0va03VdNS2sZ2OSjYAeiA-1; Mon,
 14 Jul 2025 07:11:30 -0400
X-MC-Unique: z0va03VdNS2sZ2OSjYAeiA-1
X-Mimecast-MFC-AGG-ID: z0va03VdNS2sZ2OSjYAeiA_1752491489
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0595195608F; Mon, 14 Jul 2025 11:11:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFB281977000; Mon, 14 Jul 2025 11:11:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PULL 07/13] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Mon, 14 Jul 2025 15:10:30 +0400
Message-ID: <20250714111039.4150419-8-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

There are cases where we do not want the memory layout of a texture to
be tiled as the component processing the texture would not know how to
de-tile either via software or hardware. Therefore, ensuring that the
memory backing the texture has a linear layout is absolutely necessary
in these situations.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Co-developed-by: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20250617043546.1022779-6-vivek.kasireddy@intel.com>
---
 include/ui/console.h |  3 +++
 ui/console-gl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 46b3128185..98feaa58bd 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -422,6 +422,9 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
                              pixman_format_code_t format);
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
+bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture,
+                                       GLuint *mem_obj);
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 103b954017..afb36dba64 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/shader.h"
 
@@ -96,6 +97,53 @@ void surface_gl_create_texture(QemuGLShader *gls,
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
 }
 
+bool surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture,
+                                       GLuint *mem_obj)
+{
+    unsigned long size = surface_stride(surface) * surface_height(surface);
+    GLenum err = glGetError();
+    *texture = 0;
+    *mem_obj = 0;
+
+    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
+        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
+        error_report("spice: required OpenGL extensions not supported: "
+                     "GL_EXT_memory_object and GL_EXT_memory_object_fd");
+        return false;
+    }
+
+#ifdef GL_EXT_memory_object_fd
+    glCreateMemoryObjectsEXT(1, mem_obj);
+    glImportMemoryFdEXT(*mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
+
+    err = glGetError();
+    if (err != GL_NO_ERROR) {
+        error_report("spice: cannot import memory object from fd");
+        goto cleanup_mem;
+    }
+
+    glGenTextures(1, texture);
+    glBindTexture(GL_TEXTURE_2D, *texture);
+    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_LINEAR_TILING_EXT);
+    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, surface_width(surface),
+                         surface_height(surface), *mem_obj, 0);
+    err = glGetError();
+    if (err != GL_NO_ERROR) {
+        error_report("spice: cannot create texture from memory object");
+        goto cleanup_tex_and_mem;
+    }
+    return true;
+
+cleanup_tex_and_mem:
+    glDeleteTextures(1, texture);
+cleanup_mem:
+    glDeleteMemoryObjectsEXT(1, mem_obj);
+
+#endif
+    return false;
+}
+
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h)
-- 
2.50.0


