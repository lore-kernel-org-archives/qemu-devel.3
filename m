Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC10C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eCv-0000qN-TM; Tue, 29 Apr 2025 02:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCe-0000a3-3C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:27 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCb-0005Mm-OE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907142; x=1777443142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0uQUu7jwWHtxWQnUaOy1/HzHY9G5+CCLW6sT3sEd1lA=;
 b=ZI1pshXQP5vU3wMNmPr5WW72pExbKsUPR8mC3CG2maKRFuT99v4L9Lme
 T5tdMokR4ZtJXR0hEryoL95m/ffkB2wUsjR7vJexfsnxJ+ddBv+Wq6YTy
 5KWsbHsE3AhFKDzu6qtpnZqSZez1utqPA1YNkSiO1luwjgsN55U/Yo7dr
 YKPcDtm/X4nuXyXnePKot/3zDv24tsm7hkRk0FnlxAOOn6zZNYRHz26jf
 YYwyItA3XbN21nU6SbntJv4h46ukPlSPfzS/qito4YnAOALFVXOZvf7mo
 rX3zyCVM9ES5/zPp9GaWrVzL6iykFYKx6F9u9LxP/Ew0debx8Lgh5bJbQ A==;
X-CSE-ConnectionGUID: 3ilKcBImSTW7raxAohRmOg==
X-CSE-MsgGUID: 2s2mMQE8Rzq7lzz65lV7Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58169834"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58169834"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:10 -0700
X-CSE-ConnectionGUID: HX0lm92dRVyOGH1Fyg/NAA==
X-CSE-MsgGUID: FftOUFKETmSVhZjBaK345A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133687173"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:05 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Mon, 28 Apr 2025 23:08:28 -0700
Message-ID: <20250429060952.59508-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429060952.59508-1-vivek.kasireddy@intel.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/console.h |  2 ++
 ui/console-gl.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 46b3128185..fa2dd53e2e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -422,6 +422,8 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
                              pixman_format_code_t format);
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
+void surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture);
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 103b954017..f83012fed4 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/shader.h"
 
@@ -96,6 +97,33 @@ void surface_gl_create_texture(QemuGLShader *gls,
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
 }
 
+void surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture)
+{
+    unsigned long size = surface_stride(surface) * surface_height(surface);
+    GLuint mem_obj;
+
+    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
+        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
+        return;
+    }
+
+#ifdef GL_EXT_memory_object_fd
+    glCreateMemoryObjectsEXT(1, &mem_obj);
+    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
+    if (glGetError() != GL_NO_ERROR) {
+        error_report("spice: cannot import memory object from fd");
+        return;
+    }
+
+    glGenTextures(1, texture);
+    glBindTexture(GL_TEXTURE_2D, *texture);
+    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_LINEAR_TILING_EXT);
+    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, surface_width(surface),
+                         surface_height(surface), mem_obj, 0);
+#endif
+}
+
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h)
-- 
2.49.0


