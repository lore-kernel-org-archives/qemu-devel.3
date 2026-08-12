Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D176FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8iy-00008e-Ia; Wed, 12 Aug 2026 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iJ-00083N-0p; Wed, 12 Aug 2026 09:09:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8iF-0005jw-2n; Wed, 12 Aug 2026 09:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=wZZjUk1Z/hUz3DWKPsezpMEnzXSSph+0sdM7FhmeqNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aUKxvSy56G+9NogDA99DkD+fc9NSFqHNrjiBwRPuF4NoXgm37zqccQ7pM8jWgHqY8
 hN3O7XdmDbK3u5OjSFhkFmVcuygIAERLHFQsflqtZrwT+yIdpA7nF+nyT9iS9VVSF3
 T1OW3xkRrYQJIzVjrGlPoq6J0EN6T0cw0d337JzSvIlui5JHGY8bg8zuy3O8MFePdH
 Cd2e8XYK7reHxfmOYmMG+O8Sv5n0H/0b9DySZI53+PwxldMoSmgPkI5UukO5w8bsei
 RNZkMHWyX4+sFZQhcRqMpY6lg94vQrk8CWYVBL6hypGX7Q+TfcDZ6Y7bmwAToGP6LO
 E4+87+4Va+iYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 579E11CA4C5;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D76B409BA8;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 855672F920; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 070/102] hw/display/exynos4210_fimd: Clamp windows to
 screen size
Date: Wed, 12 Aug 2026 16:01:45 +0300
Message-ID: <20260812130233.621965-70-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In exynos4210_fimd_update(), we iterate through the enabled windows,
blitting them to the screen. We assume here that the guest has not
programmed the window's coordinates to be outside the overall LCD
screen resulation, but we never check this. This can result in the
guest being able to cause us to access outside our allocated
framebuffer backing memory.

Since all the coordinates here are unsigned, they can't be off
the left/top side of the screen, only the bottom/right. If
the top left corner of the window is out of bounds, the whole
window is invisible and we can skip it. If the bottom right
corner is out of bounds, we clamp it to the screen size so that
we only draw the visible part.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3795
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20260706173324.804340-4-peter.maydell@linaro.org
(cherry picked from commit a5f8d33682be079e6b9b41f07b2eb517121b3b46)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index bafbaf89cf0..e3b99d0353b 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1291,7 +1291,7 @@ static void exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    uint32_t global_width;
+    uint32_t global_width, global_height;
     uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
@@ -1300,16 +1300,28 @@ static void exynos4210_fimd_update(void *opaque)
     }
 
     global_width = exynos4210_fimd_global_width(s);
+    global_height = exynos4210_fimd_global_height(s);
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
     for (i = 0; i < NUM_OF_WINDOWS; i++) {
         w = &s->window[i];
         if ((w->wincon & FIMD_WINCON_ENWIN) && w->host_fb_addr) {
-            scrn_height = w->rightbot_y - w->lefttop_y + 1;
+            uint32_t rightbot_x, rightbot_y;
+
+            if (w->lefttop_x >= global_width ||
+                w->lefttop_y >= global_height) {
+                /* Guest has put the window entirely offscreen: ignore */
+                continue;
+            }
+
+            /* Clamp right corner coords to be within the screen */
+            rightbot_x = MIN(w->rightbot_x, global_width - 1);
+            rightbot_y = MIN(w->rightbot_y, global_height - 1);
+            scrn_height = rightbot_y - w->lefttop_y + 1;
             scrn_width = w->virtpage_width;
             /* Number of bytes to actually draw */
-            window_width = w->rightbot_x - w->lefttop_x + 1;
+            window_width = rightbot_x - w->lefttop_x + 1;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
             host_fb_addr = w->host_fb_addr;
-- 
2.47.3


