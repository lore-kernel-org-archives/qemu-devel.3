Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D3CD1CA15
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 02:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t892k-0000au-IL; Mon, 04 Nov 2024 21:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1t892h-0000aU-V1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:11:40 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1t892e-0000aZ-4f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 21:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730772696; x=1762308696;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FGLY++qk3h6l1yvhDRbUMzqAFGoYNV6mNXSuhxvTMVM=;
 b=nPbvR2OSWs4FvuCj8KbKgRxmJvgsUqkus04lvA98aOBJzRot7b3M9OGz
 rLOeob7c+Z0RW3TJ+v8qPd63hVsUzArZHHOxWh3c/6v2zzsHHWFAzvtno
 6saOcmIfuddOLTcfbcsHeQg8ODGMqVAOhuIHaOS5+vlETlRymkMXigcQf
 +7ns4bExgliZt41Fb5sd8pAo66YjUJyYRG5FNBaSXeKrInYX1Hq8yoZjk
 yLhkVIDpL6/bJn9/fIZpTBE5sEOHwO5lnCbfpfbaGPmp/RZwpXaCSS9UJ
 487RV8t1dcrTs69fg5csTtIlZwcIgsuaYonAr78wpkz+ozb4i7/T0hBs2 g==;
X-CSE-ConnectionGUID: uDJ+v+DZSxuY5CdMUuF3zw==
X-CSE-MsgGUID: E/O+Aj95SA2jTyz0HXh2hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30613131"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; d="scan'208";a="30613131"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 18:11:31 -0800
X-CSE-ConnectionGUID: tXQUA1CvSn2zp93F1Anu5w==
X-CSE-MsgGUID: y6v8JBRDQMq4FKHgs95nuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; d="scan'208";a="83950167"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2024 18:11:32 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Consider the scaling factor when getting the root
 coordinates
Date: Mon,  4 Nov 2024 18:09:29 -0800
Message-Id: <20241105020929.3982540-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Since gdk_window_get_root_coords() expects a position within the window,
we need to translate Guest's cooridinates to window local coordinates
by multiplying them with the scaling factor.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 8e14c2ac81..5009db59eb 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -459,7 +459,8 @@ static void gd_mouse_set(DisplayChangeListener *dcl,
 
     dpy = gtk_widget_get_display(vc->gfx.drawing_area);
     gdk_window_get_root_coords(gtk_widget_get_window(vc->gfx.drawing_area),
-                               x, y, &x_root, &y_root);
+                               x * vc->gfx.scale_x, y * vc->gfx.scale_y,
+                               &x_root, &y_root);
     gdk_device_warp(gd_get_pointer(dpy),
                     gtk_widget_get_screen(vc->gfx.drawing_area),
                     x_root, y_root);
-- 
2.34.1


