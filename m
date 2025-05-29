Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17B6C5B549
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVct-0007zD-RR; Thu, 29 May 2025 01:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVck-0007xN-2e
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uKVcd-0008Dw-Hq
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748495768; x=1780031768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lsr8UAMbL2vZZ9fnM7rkXFZ/rXRs+2OC9E+0A+zHKCk=;
 b=gK6CznboU9Ci4DgQVDNj0axvp4a6mbeixyVutCWfuX4PYMTaWO913S2E
 V+eUr1DT/CZuCkc98rvrMyHJNwz6n3gRl3bv5JxQYQdfqACcMBF7/s78M
 2PBYO1c6xJcnixCPuOxqgl5XRQxib+aKp9R9sN6XCmS6/jGRqbP7500Jj
 yaWxsE/RmVCXtVxOyH6UIzean50k1NbNvGSTys1hqn7zWTUXN/nMIsyMW
 f4DBxQG1D1Cf1K3oFXk5AbLHgPTTfk60ym7F4bHU1m2rD1e324gv/fKlL
 FERtla0NEAUu1PUgE4jFLSNLuQPHygGNIkyXnGEMNeiScB8Wr0BW04OYB g==;
X-CSE-ConnectionGUID: 0EUzf+QDQK2bZ/Lop8iayQ==
X-CSE-MsgGUID: VH4/15ZaQBeltlFUNcvZIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50241903"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50241903"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 22:15:27 -0700
X-CSE-ConnectionGUID: 8D/hxm1VQbyPljwCjttiug==
X-CSE-MsgGUID: wae3CeirRpunBH125GXkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="174455347"
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
Subject: [PATCH v5 5/7] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Wed, 28 May 2025 22:11:16 -0700
Message-ID: <20250529051352.1409904-6-vivek.kasireddy@intel.com>
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
Co-developed-by: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
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
2.49.0


