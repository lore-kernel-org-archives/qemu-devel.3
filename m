Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D316C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 22:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0UTf-0005zj-Bd; Fri, 26 Apr 2024 18:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s0UTY-0005x6-Gh
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 18:55:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s0UTU-0002Ty-O3
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 18:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714172125; x=1745708125;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=98P0Z1j1xy/Gsynk399xDqTUEpD15gL0Hw4d2ySuYlM=;
 b=G9Bd0eoEufxmMnkY1DcCgo7eGASDXVv5/0FuEMUHmy4yvB9WGEOVnzlW
 wbPrbyVw+DCTvqNZ7MdsarmKhEIIjsoCxhXsNHYyT9dld9G+PpycfFErk
 Yq1lM1TsMTl8tOkaWpJP8wCMPWd7OoIburegZg8YaJ/eSQP1sL+9v5Z9t
 khb1NArBf37JpHwILl4kKGMtX63a2BgodDbssUhKSByFLee+gk7iIrQVp
 PyJwDICgRkSxSqlNUP00D5/ZhFgUBwlvTJlY5VngoEHASWOT9maHhyjuP
 4kiMaMGXaS4ZcpuVfQGu3B42aaJSoNOAK/eTyLs2Nru4d6cQ4udLHnepL g==;
X-CSE-ConnectionGUID: fA4YByUdS5yzRjHDC2wHQg==
X-CSE-MsgGUID: u4KPnm9cQaSzyhTqoh82lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9849585"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="9849585"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 15:55:22 -0700
X-CSE-ConnectionGUID: p3xJ+RvaS1uBGY1Fwdz4Rw==
X-CSE-MsgGUID: Nk6h5bKCRVWmwIcAYPNSkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; d="scan'208";a="25529266"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa009.jf.intel.com with ESMTP; 26 Apr 2024 15:55:22 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] ui/gtk: Draw guest frame at refresh cycle
Date: Fri, 26 Apr 2024 15:50:59 -0700
Message-Id: <20240426225059.3871283-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
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

v2: Use gd_gl_area_draw(vc) in gtk-gl-area.c

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
index 52dcac161e..4fff957c3f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -126,6 +126,7 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
     if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.34.1


