Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088A6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 23:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s08BV-0004Nc-E6; Thu, 25 Apr 2024 19:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s08BR-0004NG-R6
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 19:07:17 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s08BP-0001Ts-Qo
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 19:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714086435; x=1745622435;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I46kgx0qBEUyzZuJjru2bRy5+dP+OLVrjfR3ZJfPkME=;
 b=ZrIJ0E5g1jZA5kZ5hkG9NakOzbO2gIeBLzUYqiHOou1yaF3IBsMrCsCv
 +w7E5JCHLn/SlBUcSA5FhiD7lvl3fVQeCXlUnxRuDCPSjjQ9e/uxufPGY
 JhgSuLkZ5MvQZEf2tIDaP0sU1pRV8hBSeF4aGnrAZdGvEofkXuv/aA7gj
 YhXBN9XNYQ9XLNHDk6zfcvYA9eXwm1KizSNJ+ie3hewTnUjOYkbJT0Nem
 mq599UcwiOmc578zBm0AR8Dy6/g7mY/yg6+9h4G389nX0HPXZT5juQmC7
 FLhvLKaO8sCsD3Pc4JyuH3cDUE8bM0BmQyMVwnlB1eDzmUfSIRTRHHTFQ g==;
X-CSE-ConnectionGUID: qJo1tYD7RY+va+j38jMUUg==
X-CSE-MsgGUID: ht1Iq5CCSxiTqyXEU3yAJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9677753"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9677753"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 16:07:11 -0700
X-CSE-ConnectionGUID: ZDbxq9f4SFe1ZpTgC4KDuA==
X-CSE-MsgGUID: cRGu1scxQ+6fSaqL2Gz6Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; d="scan'208";a="25230772"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa009.fm.intel.com with ESMTP; 25 Apr 2024 16:07:12 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Draw guest frame at refresh cycle
Date: Thu, 25 Apr 2024 16:02:50 -0700
Message-Id: <20240425230250.1037257-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

Draw routine needs to be manually invoked in the next refresh
if there is a scanout blob from the guest. This is to prevent
a situation where there is a scheduled draw event but it won't
happen bacause the window is currently in inactive state
(minimized or tabified). If draw is not done for a long time,
gl_block timeout and/or fence timeout (on the guest) will happen
eventually.

Suggested-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 1 +
 ui/gtk-gl-area.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3af5ac5bcf..75f6b9011a 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -150,6 +150,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
     if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        gd_egl_draw(vc);
         return;
     }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 52dcac161e..7b4ba37b78 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -126,6 +126,7 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
     if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        gd_egl_draw(vc);
         return;
     }
 
-- 
2.34.1


