Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C044C71155
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5i-0002rT-ME; Tue, 17 Jun 2025 00:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5g-0002qo-Sc
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:32 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5f-0007je-52
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135112; x=1781671112;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ue4HPEcFSIrDaSAT8nEWuR645zrsYBFtKwmN9cfIvAo=;
 b=OaFAFiB+CBy6R1Nx7R9hH2Rle66pYu4myLUpx6LhviRUVl4gE5mdANU7
 3bymJHKv+L0SX9EXwxd1+J9a91Y6tvVfUZ9KLSczFnr/vtpzMLx8G+vhK
 qyk9XaOC0Zl5gNF3+T51O2A055N3DrhmvRHt+H+Fluwzs5n8LX1I40ohA
 dyJggC2bL21j4/SSgwoU1Jhj08eoGHaQkyUHevmeVncv/tjTFaT8CFp7u
 xU5NsNeA9eIoOYFBiSDh/Pt1vzGYm/oP8HyeKRK8VuOFju45gZunWxgVx
 jQd3ua2sLkU/oxdzwczkdSKTRZxQ7MQIhP3hmfDfsoqO91voEvNsbjX+B Q==;
X-CSE-ConnectionGUID: fyc8id0KSri9/ltJ5OIhog==
X-CSE-MsgGUID: GTXxWZxiSGSecvdtizQZug==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432311"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432311"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:25 -0700
X-CSE-ConnectionGUID: 4wV1pOAJS1GrrNntW1uzOw==
X-CSE-MsgGUID: Zo5zqAGbT5yYYCik+qUaWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551052"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:24 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v6 5/7] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Mon, 16 Jun 2025 21:32:29 -0700
Message-ID: <20250617043546.1022779-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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


