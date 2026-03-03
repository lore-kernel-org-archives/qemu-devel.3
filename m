Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE26EB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxENm-00059C-TF; Mon, 02 Mar 2026 20:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxENf-00053x-1g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:59 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxENd-0008B4-G1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772500617; x=1804036617;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CQbMw7k8VbECn4rME/YV3kJFc5e0kYbwbzc1M9exl9E=;
 b=kvLXRxMd3f5G5C8AVeGq/ZhpDHP62x97ITGxunbh8+Yx+JNijC0OcjeE
 QJJxiqh76HzyB7+WX2JWf7TXfsLBaJetlxl7WEURJMb2M/OmNn8qbwiaI
 ag49dZRK1xfRm5xSGfCpdc7/MA/qzgTqkE6bRbE1lZps17pBgxCNc7J+f
 aoTFuq9nZLUvNNaiMJaVbrFKoROK53R0dAC+IyVi9x8jq/alqiGx7kCwN
 hH6h/xNDk7QLIrYGpt60mpxSCQegSpd+1BAPe9+AzjQvGyU+inYV5sxlP
 Dpwuri7+jqfrDtCJCMpiBN34JKqkZAxjE7Sfunp8u5zRdFCd7xuLFnirq g==;
X-CSE-ConnectionGUID: k+tPtT7/TGOzPVzQX6UXCQ==
X-CSE-MsgGUID: jH6v7ewvQTuXbFZrMT1pGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="84162912"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="84162912"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 17:16:54 -0800
X-CSE-ConnectionGUID: vC/j5UCyQ7iMyHYPYICe7g==
X-CSE-MsgGUID: CnwpXvHOSJqXZNPTSTk/8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="221993892"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by orviesa003.jf.intel.com with ESMTP; 02 Mar 2026 17:16:54 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk-egl: Ensure EGL surface is available before drawing
Date: Mon,  2 Mar 2026 17:11:51 -0800
Message-Id: <20260303011151.1925827-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

The EGL surface and context are destroyed when a new GTK window is
created. We must ensure these are recreated and initialized before
any rendering happens in gd_egl_refresh.

Currently, the check for a pending draw is performed before the
surface initialization block. This can result in an attempt to
draw when the EGL surface (vc->gfx.esurface) is not yet available.

This patch moves the drawing check after the surface initialization
to ensure a valid surface exists before rendering in gd_egl_refresh.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index ae9239999c..52d187c482 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -152,12 +152,6 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_egl_draw(vc);
-        return;
-    }
-
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
@@ -176,6 +170,12 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 #endif
     }
 
+    if (vc->gfx.guest_fb.dmabuf &&
+        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
+        gd_egl_draw(vc);
+        return;
+    }
+
     graphic_hw_update(dcl->con);
 
     if (vc->gfx.glupdates) {
-- 
2.43.0


