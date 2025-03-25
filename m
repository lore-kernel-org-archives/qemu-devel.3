Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565F6C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDvh-0000QI-FO; Tue, 25 Mar 2025 19:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDve-0000PE-6J
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:30 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txDvc-0005HG-E2
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742946209; x=1774482209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ncD6agZmF3oz1bSf+Cj/TALHncQK1yrSZlA8HMMyTHs=;
 b=kNAfG7I6eKpOpwZkghkGd+RHsd1X5G/WhZUR+z9buSQ2tIAbof2wIlGk
 xR+1yAROvo8/Ot2lJDMdePbsJAwdc31vrlJWPjmY7KB6RhoyNvXN30KRw
 m7Bd3FcKIZccVi6el2EZ04Cgykj+e268vpn2tmCdiQe3qcVUO72c3ktsJ
 t3jhMor9SKY4bSllGsUdPWIE04eI2nnlDbIsIqxx8G7TlOgCQ/+ZyyFh9
 T8SQmCVydz+i9e6NhHazT5iLAJz3zVm/fgVGNmuTF6mw7jWww5o15rtcY
 TBLh7m0DvRXeNiwvpjHdbef0Zk3gU8R00HXoHKnhQVmxPkdgETPQIC6an g==;
X-CSE-ConnectionGUID: P98zSwivSs+qG+MPn/GQKw==
X-CSE-MsgGUID: pwdMZSIYSdqmyzfjsgTcwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="55582846"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="55582846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:19 -0700
X-CSE-ConnectionGUID: Gbj/qVDpRxO8GAuZc2NPLQ==
X-CSE-MsgGUID: hG/KNTs7RSSXR5LVSCGeZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="124332505"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 16:43:18 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v2 4/6] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Tue, 25 Mar 2025 16:39:34 -0700
Message-ID: <20250325234115.1332883-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/console.h |  2 ++
 ui/console-gl.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

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
index 103b954017..8ee882bc3c 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -96,6 +96,32 @@ void surface_gl_create_texture(QemuGLShader *gls,
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
+    if (!glIsMemoryObjectEXT(mem_obj)) {
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
2.48.1


