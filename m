Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30809EB3641
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEKh-000491-6F; Mon, 02 Mar 2026 20:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxEKf-00048n-AP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:13:53 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxEKd-0007kv-Fx
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772500432; x=1804036432;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dOnnmunbtpt+uAUydZNtyQGOdFuOjFUoe8XXROAhMwE=;
 b=meCPj2RMRMb61isqKbC37lQuTh9dL3SqJfkEBwUPpQToF5XDrayu9DPa
 p4Cq00ULkjOHMwILOLtBFD+nlXIs9RZ4PC/yZV0KuVmuSEbJRJeyaq4wT
 WW/FZRKD6Ia5G+GWVllakGyB3Oy9rp1Fqbx60s8Kcl5B1cgZawjCCz5wr
 npuKr1XFarrITRkK0SKbgGsxbgJ6SzOK5UGVPMLd1WrLEwqeFORw84Iot
 u+LrvttD+SnCUGaxRgRkwCJRCzlXomxUGrqSuRz+ChW3psL+d/zNDi1uW
 oGiuaIqzgqBnDOpnqldW4YZnFtKfw1AMw91Vl3q4b8iKgGp/xAcjX1WKS A==;
X-CSE-ConnectionGUID: DhGdmoU9TMWuTGVq3asgyQ==
X-CSE-MsgGUID: hYPwU8TlTZSW1YcjRUhi2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73489064"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="73489064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 17:13:48 -0800
X-CSE-ConnectionGUID: FFeYGz28Rp2qaxRW82NjZA==
X-CSE-MsgGUID: EWTkv8XPSP6gr8uPSpFwuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="222330570"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by orviesa004.jf.intel.com with ESMTP; 02 Mar 2026 17:13:48 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/egl-helpers: Fix FBO recreation and prevent texture
 accidental deletion
Date: Mon,  2 Mar 2026 17:08:44 -0800
Message-Id: <20260303010844.1925737-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

When egl_fb_setup_for_tex is called, we must handle cases
where the texture ID is reused across different GL contexts.

Texture Preservation - If the new texture ID matches
the cached ID, we must skip egl_fb_delete_texture to avoid
destroying the texture we are about to use.

FBO Recreation - Because FBOs are context-local and not shared,
a cached FBO ID from a previous context is invalid. We must
generate a new FBO handle if we are re-validating the same
texture ID in a potentially new context.

This prevents stale FBO usage and unintended texture deletion
during context transitions.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/egl-helpers.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index e3f2872cc1..7ac64f3ba8 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -111,15 +111,23 @@ void egl_fb_setup_default(egl_fb *fb, int width, int height, int x, int y)
 void egl_fb_setup_for_tex(egl_fb *fb, int width, int height,
                           GLuint texture, bool delete)
 {
-    egl_fb_delete_texture(fb);
+    if (fb->texture != texture) {
+        egl_fb_delete_texture(fb);
+    }
+
+    /*
+     * If fb->texture == texture, the existing fb->framebuffer is tied to
+     * a previous GL context. Since FBOs are not shared across contexts,
+     * we must create a new FBO for the current context.
+     */
+    if (!fb->framebuffer || (fb->texture == texture)) {
+        glGenFramebuffers(1, &fb->framebuffer);
+    }
 
     fb->width = width;
     fb->height = height;
     fb->texture = texture;
     fb->delete_texture = delete;
-    if (!fb->framebuffer) {
-        glGenFramebuffers(1, &fb->framebuffer);
-    }
 
     glBindFramebuffer(GL_FRAMEBUFFER_EXT, fb->framebuffer);
     glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_COLOR_ATTACHMENT0_EXT,
-- 
2.43.0


