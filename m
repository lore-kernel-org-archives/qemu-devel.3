Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3666FC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 06:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucee5-00085w-GY; Fri, 18 Jul 2025 02:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uceb3-0005ay-6a
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:29:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uceb0-00055R-2L
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 02:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752820166; x=1784356166;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mx+6agLPlh4LnJNPcD3Sm7c/6wWZnIEPP+us69O4B5Q=;
 b=Pe2kgC0//mZATWlbYWoOccX4sz1bCk0jy2MUy/fFuRKAUId5X9yY6hc+
 OOQMG4LH8TfVOaFFsxopXACZrjuDsOBhZ98u7RgwBDUzjcohjquGwfURx
 uXobXE3rw0aC22Lbz+ef9Ee2BmslW+yttLB/DTDf+W7Q8Hsz5lkUNdjvj
 ZI4t4hb5lsuC5tBDop5SlBXiO6aTOadUZgEx0wkSl99L3I3lv60l9Vbkz
 o1SOCZdq2ciiNS+nT6wAok0kgcew+66wCMyfZWnHIXQMm2ZSLdL2kA8MF
 aaHLrc2HTGUv1l0NkuR32p0iueHV34pjxoPJdrJXvlbAVT/ORqyXoRqQL Q==;
X-CSE-ConnectionGUID: 86BdIU19SYOlOEJLGagNGg==
X-CSE-MsgGUID: zPtcBQCSSQq6neLH7R3CGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="77646212"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="77646212"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 23:29:22 -0700
X-CSE-ConnectionGUID: WOIAyKIvSlOdMjHhOh3aag==
X-CSE-MsgGUID: ZrqqJI4GTmqvHb1aOAVAdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; d="scan'208";a="181694337"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 23:29:22 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/spice: Destroy the temporary egl fb after the blit is
 submitted
Date: Thu, 17 Jul 2025 23:26:07 -0700
Message-ID: <20250718062607.2209900-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
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
 ui/spice-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 9ce622cefc..401d6c4aba 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1191,12 +1191,12 @@ static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd,
     uint64_t modifier;
     bool ret;
 
-    egl_fb_destroy(scanout_tex_fb);
     egl_fb_setup_for_tex(scanout_tex_fb,
                          surface_width(ssd->ds), surface_height(ssd->ds),
                          ssd->ds->texture, false);
     egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
     glFlush();
+    egl_fb_destroy(scanout_tex_fb);
 
     if (!ssd->new_scanout_texture) {
         return true;
@@ -1330,7 +1330,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     }
 
     if (spice_remote_client && ssd->blit_scanout_texture) {
-        egl_fb scanout_tex_fb;
+        egl_fb scanout_tex_fb = {};
 
         ret = spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
         if (!ret) {
-- 
2.49.0


