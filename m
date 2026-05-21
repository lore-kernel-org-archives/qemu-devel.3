Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C4ACD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 00:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPrZu-0007bj-Jy; Wed, 20 May 2026 20:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPrZt-0007bb-Ax
 for qemu-devel@nongnu.org; Wed, 20 May 2026 20:47:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1wPrZr-0008Oi-1P
 for qemu-devel@nongnu.org; Wed, 20 May 2026 20:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779324475; x=1810860475;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RgbZeK+T0d0MjC474rAEIERQ+Q7bC7vfl+Q7h0f++pc=;
 b=BkGDzTKT8M/vsX7iKdE2VAcEBgAn8AejlNhwB78Mksn+aU/5BzHK8JdO
 EmHABEekFXHSfCIqymUeAI6TQ6casPB265IvDaRjMwc/BOwESwkCrpqEU
 /FGY3KoVFG56ridZw+jqpUViJsLjsebf3HDcE1bC8mGkiUympUaKRHgTo
 b7SVzro4GyjNZQay8Hy7P271Mv2N8B1Wl2rjPs40xAO1cwLG8wXSovVOJ
 WwIV/V0Fdz9ByzdEV9jdhpaY2o6FpaEelktEo//RpWAnoi5UVbsE2hRTU
 lkB2p2BVTv1fqE7/MvC5UQ97/58webt0B1/qx5n4rAwQzvCoKC9DNXd01 Q==;
X-CSE-ConnectionGUID: zBdSqfyURh21VzbR50n14g==
X-CSE-MsgGUID: 8aMFqnCfRNWOdfwpRHGRLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79969213"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="79969213"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 17:47:49 -0700
X-CSE-ConnectionGUID: Q8v4/O64Tauduee/FtDApg==
X-CSE-MsgGUID: i5GRZ4JATwKMsjS4R+5exQ==
X-ExtLoop1: 1
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.158.5])
 by fmviesa003.fm.intel.com with ESMTP; 20 May 2026 17:47:48 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/egl: reset framebuffer state when creating new EGL
Date: Wed, 20 May 2026 17:42:26 -0700
Message-Id: <20260521004226.1914121-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When an old EGL context is destroyed, its associated OpenGL textures 
and framebuffer resource IDs are already implicitly freed by the 
driver. However, the cached IDs and geometry attributes stored within 
the egl_fb structures remain stale and invalid for the new context.

Call egl_fb_destroy() on the guest, cursor, and window framebuffers 
in gd_egl_refresh() to safely clear these stale fields back to zero 
before they are re-initialized under the new current context.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 7c5c9b2428..fd14b391ed 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -163,6 +163,12 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
         }
 #ifdef CONFIG_GBM
+
+        /* resetting old ids to 0 for new egl context */
+        egl_fb_destroy(&vc->gfx.guest_fb);
+        egl_fb_destroy(&vc->gfx.cursor_fb);
+        egl_fb_destroy(&vc->gfx.win_fb);
+
         if (vc->gfx.guest_fb.dmabuf) {
             egl_dmabuf_release_texture(vc->gfx.guest_fb.dmabuf);
             gd_egl_scanout_dmabuf(dcl, vc->gfx.guest_fb.dmabuf);
-- 
2.43.0


