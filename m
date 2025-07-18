Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C0EC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 23:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucuia-0006pH-N7; Fri, 18 Jul 2025 19:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1ucuiW-0006ju-JB
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 19:42:17 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1ucuiT-0003h1-VA
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 19:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752882132; x=1784418132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fL6UqhsgnUYt1MefObBWRGNQV2U99Qh0QQqUIr1xdNY=;
 b=IKL2vFZvYLaLnUMlmQCFyXGZxkCzMVJJlDKwUQ6WBGsX8yeKTX5uruPc
 YWdJ0j/KDB8/igVJdtY0A2Qh5/aEZAwg31n4igw6nZ+gUl7XaSqusIPjl
 CKt7R8vRlX6Cm14R2A0VphGuZ+WvjtvdE+H2MKDbRbPbTJH+kpGa4JxvR
 T5ShpMzJe3oFkhlU6nx+F0qZhGUxAy8FBYvHJGRWUpMyAdZFIH1H8DeVR
 rKFiz9U1Jl9bAvnRTCWm8E3oesiqzj3z5MIQW+WslgP9hBuT65T7bHJI+
 MWmjbZw8Eoxp9S8RmI+AzutB9WYKS9NntZkWmeTSdAWPuD8BCcf0cvA4Y w==;
X-CSE-ConnectionGUID: xMX9mbI0TfakGMgNsptRSw==
X-CSE-MsgGUID: kSwj16F4SC+BEAipIFAbOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58846316"
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; d="scan'208";a="58846316"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 16:42:08 -0700
X-CSE-ConnectionGUID: Q3ncy0ENSdy2LUhtWQ1hxw==
X-CSE-MsgGUID: wzXzpbi6Tli5YdIZC2p6xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,323,1744095600"; d="scan'208";a="162891797"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 16:42:09 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/spice: Destroy the temporary egl fb after the blit is
 submitted
Date: Fri, 18 Jul 2025 16:40:39 -0700
Message-ID: <20250718234039.2266704-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
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

The temporary egl fb scanout_tex_fb is only needed to facilitate the
blit to the display surface's texture (ssd->ds->texture). Therefore,
destroy it after the blit is submitted. And, also make sure that it
is empty initialized before it is actually used.

Fixes: f851cd65 ("ui/spice: Blit the scanout texture if its memory layout is not linear")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
v2:
- Make scanout_tex_fb local to spice_gl_blit_scanout_texture() since
  it is not used outside of it (Peter)
---
 ui/spice-display.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 9ce622cefc..669832c561 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1183,20 +1183,20 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
 }
 
-static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd,
-                                          egl_fb *scanout_tex_fb)
+static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd)
 {
     uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
     int fds[DMABUF_MAX_PLANES], num_planes, fourcc;
+    egl_fb scanout_tex_fb = {};
     uint64_t modifier;
     bool ret;
 
-    egl_fb_destroy(scanout_tex_fb);
-    egl_fb_setup_for_tex(scanout_tex_fb,
+    egl_fb_setup_for_tex(&scanout_tex_fb,
                          surface_width(ssd->ds), surface_height(ssd->ds),
                          ssd->ds->texture, false);
-    egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
+    egl_fb_blit(&scanout_tex_fb, &ssd->guest_fb, false);
     glFlush();
+    egl_fb_destroy(&scanout_tex_fb);
 
     if (!ssd->new_scanout_texture) {
         return true;
@@ -1330,9 +1330,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     }
 
     if (spice_remote_client && ssd->blit_scanout_texture) {
-        egl_fb scanout_tex_fb;
-
-        ret = spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
+        ret = spice_gl_blit_scanout_texture(ssd);
         if (!ret) {
             return;
         }
-- 
2.49.0


