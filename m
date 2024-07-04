Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD49C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOlq-0000G9-DN; Thu, 04 Jul 2024 11:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlf-0000Dl-8D; Thu, 04 Jul 2024 11:53:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOlZ-0001zl-Rm; Thu, 04 Jul 2024 11:53:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 747AE77491;
 Thu,  4 Jul 2024 18:52:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 38A4CFEADC;
 Thu,  4 Jul 2024 18:52:51 +0300 (MSK)
Received: (nullmailer pid 1481677 invoked by uid 1000);
 Thu, 04 Jul 2024 15:52:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 03/18] ui/gtk: Draw guest frame at refresh cycle
Date: Thu,  4 Jul 2024 18:52:34 +0300
Message-Id: <20240704155251.1481617-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20240426225059.3871283-1-dongwon.kim@intel.com>
(cherry picked from commit 77bf310084dad38b3a2badf01766c659056f1cf2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 955234429d..bceeeb0352 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -150,6 +150,7 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
     if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        gd_egl_draw(vc);
         return;
     }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7fffd0544e..b490727402 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -126,6 +126,7 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
     if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.39.2


