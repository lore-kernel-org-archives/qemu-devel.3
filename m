Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC94C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 13:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6s37-0005m5-Cg; Tue, 14 May 2024 09:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2y-00056h-N8
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1s6s2v-0002Ns-WD
 for qemu-devel@nongnu.org; Tue, 14 May 2024 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715692700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLYSs2WpyTSi501CbyWQYRqmMlfLgx76s3MXUm3MEeU=;
 b=Q92K41lFPCCcIauF0a3zd+T32zBIP2OE6sdCTCYobk6v9SiTHB/DXCbLr60FNpcp8tF/hx
 j/AU3lCuGxLSBggIcB4MeSG+QsdgDdoVkUz9PAa2we3jLf6ffH2A0kkfrfzye4KW5jPvRX
 A+sGhWCVMNrnA/zXQvKQCkgWASH0E+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-zseJFXjxMmWi1GrkItR90Q-1; Tue, 14 May 2024 09:18:16 -0400
X-MC-Unique: zseJFXjxMmWi1GrkItR90Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D5A88030A6;
 Tue, 14 May 2024 13:18:16 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45BF0909;
 Tue, 14 May 2024 13:18:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, hikalium <hikalium@hikalium.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 10/11] ui/gtk: Fix mouse/motion event scaling issue with GTK
 display backend
Date: Tue, 14 May 2024 17:17:24 +0400
Message-ID: <20240514131725.931234-11-marcandre.lureau@redhat.com>
In-Reply-To: <20240514131725.931234-1-marcandre.lureau@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: hikalium <hikalium@hikalium.com>

Remove gtk_widget_get_scale_factor() usage from the calculation of
the motion events in the GTK backend to make it work correctly on
environments that have `gtk_widget_get_scale_factor() != 1`.

This scale factor usage had been introduced in the commit f14aab420c and
at that time the window size was used for calculating the things and it
was working correctly. However, in the commit 2f31663ed4 the logic
switched to use the widget size instead of window size and because of
the change the usage of scale factor becomes invalid (since widgets use
`vc->gfx.scale_{x, y}` for scaling).

Tested on Crostini on ChromeOS (15823.51.0) with an external display.

Fixes: 2f31663ed4 ("ui/gtk: use widget size for cursor motion event")
Fixes: f14aab420c ("ui: fix incorrect pointer position on highdpi with
gtk")

Signed-off-by: hikalium <hikalium@hikalium.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240512111435.30121-3-hikalium@hikalium.com>
---
 ui/gtk.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 7ce73b0798..93b13b7a30 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -891,7 +891,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     int x, y;
     int mx, my;
     int fbh, fbw;
-    int ww, wh, ws;
+    int ww, wh;
 
     if (!vc->gfx.ds) {
         return TRUE;
@@ -899,11 +899,15 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
 
     fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-
     ww = gtk_widget_get_allocated_width(widget);
     wh = gtk_widget_get_allocated_height(widget);
-    ws = gtk_widget_get_scale_factor(widget);
 
+    /*
+     * `widget` may not have the same size with the frame buffer.
+     * In such cases, some paddings are needed around the `vc`.
+     * To achieve that, `vc` will be displayed at (mx, my)
+     * so that it is displayed at the center of the widget.
+     */
     mx = my = 0;
     if (ww > fbw) {
         mx = (ww - fbw) / 2;
@@ -912,8 +916,12 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
         my = (wh - fbh) / 2;
     }
 
-    x = (motion->x - mx) / vc->gfx.scale_x * ws;
-    y = (motion->y - my) / vc->gfx.scale_y * ws;
+    /*
+     * `motion` is reported in `widget` coordinates
+     * so translating it to the coordinates in `vc`.
+     */
+    x = (motion->x - mx) / vc->gfx.scale_x;
+    y = (motion->y - my) / vc->gfx.scale_y;
 
     trace_gd_motion_event(ww, wh, gtk_widget_get_scale_factor(widget), x, y);
 
-- 
2.41.0.28.gd7d8841f67


