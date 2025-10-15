Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CD6CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t69-0000aZ-C8; Wed, 15 Oct 2025 00:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t67-0000Zr-AJ; Wed, 15 Oct 2025 00:26:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t64-0002vS-0F; Wed, 15 Oct 2025 00:26:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0CCF215D9D7;
 Wed, 15 Oct 2025 07:25:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99BA029FE7E;
 Wed, 15 Oct 2025 07:25:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Filip Hejsek <filip.hejsek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 04/13] ui/gtk: Fix callback function signature
Date: Wed, 15 Oct 2025 07:25:28 +0300
Message-ID: <20251015042540.68611-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Filip Hejsek <filip.hejsek@gmail.com>

The correct type for opaque pointer is gpointer,
not gpointer * (which is a pointer to a pointer).

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit c187a67c9dcdece58138f4df5ca4dd846934eddc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk.c b/ui/gtk.c
index 2db10c46da..fe0a2249ff 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -769,9 +769,9 @@ static gboolean gd_render_event(GtkGLArea *area, GdkGLContext *context,
 }
 
 static void gd_resize_event(GtkGLArea *area,
-                            gint width, gint height, gpointer *opaque)
+                            gint width, gint height, gpointer opaque)
 {
-    VirtualConsole *vc = (void *)opaque;
+    VirtualConsole *vc = opaque;
     double pw = width, ph = height;
     double sx = vc->gfx.scale_x, sy = vc->gfx.scale_y;
     GdkWindow *window = gtk_widget_get_window(GTK_WIDGET(area));
-- 
2.47.3


