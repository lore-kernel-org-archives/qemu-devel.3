Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93871D78788
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 16:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9x5-00011Y-7v; Thu, 21 Nov 2024 11:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1tE9x3-00010z-9c
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:22:41 -0500
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charmitro@posteo.net>)
 id 1tE9x1-0001Cv-Hi
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:22:40 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 5ED08240101
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 17:22:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1732206153; bh=dX0H3zLmPY7rh6TPKPV6fcbuqthN9TQRCrXyn2GoFIQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
 Content-Transfer-Encoding:From;
 b=dQd/VoXgM/EPK+vtk8C+/W9ZjLsk4lDu23J9yMkgv+SQlLQqbfTOO1Hs577pojAQP
 huC91Tb/19vHseyXvnHdWxCuPkuBJLZtoIVk2SnhSYiDHfkftVEdL54rLdL2cxBoua
 e5UbSHGK415SKRnzMrGCTSnozCeQxMyokCZGzJT072jq5t1mE+YJ7SzG2jKnnMFq1E
 SiDyc9p6SyMxoMIAZoxM0THMdGXRDWxFnfuHgDNyePQFjGpuPrNddf2f4XmS57YtAV
 +fsS9ZUaN/s9NSzsnmE/sUTIO/VOprbeqwMWhzLjRRmWWqUX9JXx6SCryqJa061mLH
 4oiE7NsrK00lg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4XvNmm08qyz6tw6;
 Thu, 21 Nov 2024 17:22:31 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Charalampos Mitrodimas <charmitro@posteo.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH] ui/gtk: Fix event handling on macOS hosts
Date: Thu, 21 Nov 2024 16:21:46 +0000
Message-Id: <20241121162146.53643-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=charmitro@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The GTK+ UI was not properly handling events on macOS due to missing
event loop polling in the Cocoa backend. Add polling of the GLib main
context during display refresh to ensure UI events are processed.

This fixes UI responsiveness issues when running QEMU with the GTK
display (--display gtk) on macOS hosts.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2676

Co-developed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 ui/gtk.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index bf9d3dd679..979210255f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -437,6 +437,15 @@ static void gd_update(DisplayChangeListener *dcl,
 
 static void gd_refresh(DisplayChangeListener *dcl)
 {
+#ifdef GDK_WINDOWING_QUARTZ
+    GMainContext *context;
+    if (GDK_IS_QUARTZ_DISPLAY(gdk_display_get_default())) {
+        context = g_main_context_default();
+        while (g_main_context_pending(context)) {
+            g_main_context_iteration(context, FALSE);
+        }
+    }
+#endif
     graphic_hw_update(dcl->con);
 }
 
-- 
2.39.5 (Apple Git-154)


