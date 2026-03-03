Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D19BEB3649
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxE9W-0006gO-Dm; Mon, 02 Mar 2026 20:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxE9U-0006g8-2h
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:02:21 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1vxE9Q-0005yy-UR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772499737; x=1804035737;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jmC6uQFHHr8rOGyPQcUxlZJ12pEqrgl5m0ZvTMddGPU=;
 b=GDyWEFBLoYjsD07aU8+6molc88xsy/yU4CtpGhNYh7TeVpiU9JrG/ApZ
 457keLCFvkKeQqNLmtWOLbPQTsQ2X+9rPrqWulMUNaIeOhsmCbh0HxNNZ
 mONkv0QPYqZ4vT4zjf8e0jn231Qxz3BxvoaUwCjacQtYXKxRyieyhKAJ6
 HnWH5nVQ4+PjwNa73dEb8TsEcC8k0kQ3pfh3na3jTD1Mf5yg81mCv9au1
 e3kNysMHLZNYOyZtXmEnFPsSUwd53XOcO7U1zcddI1yaOkCxFw7uAkXwZ
 9EdsCJ4j0Yls1zQRITcBplA6wb2BixpgOjX4QJikgUKXZxp4y2RXbtdn8 A==;
X-CSE-ConnectionGUID: SYtOPQigTUOl+bjFNlkwCQ==
X-CSE-MsgGUID: D/N1BjvWSuG3GwilJR21JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73710678"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="73710678"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 17:02:13 -0800
X-CSE-ConnectionGUID: 4p3Bfl05RLeKWzTtVrHQFA==
X-CSE-MsgGUID: vjhGWf9XTBuopi27jLDOkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="220860843"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.205.222])
 by fmviesa004.fm.intel.com with ESMTP; 02 Mar 2026 17:02:12 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 01/23] ui/gtk: Fix lookup and segfault for invalid page numbers
Date: Mon,  2 Mar 2026 16:57:09 -0800
Message-Id: <20260303005709.1925477-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
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

A page number of -1 is invalid and can refer to multiple
unattached Virtual Consoles (VCs). This patch ensures negative
page numbers are no longer treated as valid indices.

To prevent a regression, a null check is added to
gtk_release_modifiers. This avoids a segmentation fault during
the "untabify" process, where a VC's page number is temporarily
set to -1 immediately after detaching.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 48571bedbf..15a6d79fa2 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -166,7 +166,7 @@ static VirtualConsole *gd_vc_find_by_page(GtkDisplayState *s, gint page)
     for (i = 0; i < s->nb_vcs; i++) {
         vc = &s->vc[i];
         p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), vc->tab_item);
-        if (p == page) {
+        if (p >= 0 && p == page) {
             return vc;
         }
     }
@@ -355,7 +355,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
 {
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    if (vc->type != GD_VC_GFX ||
+    if (!vc || vc->type != GD_VC_GFX ||
         !qemu_console_is_graphic(vc->gfx.dcl.con)) {
         return;
     }
-- 
2.43.0


