Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnCP-0007Ft-T9; Mon, 06 Jul 2026 13:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCI-0007E5-Af
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCF-00045y-4N
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so11226775e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783359209; x=1783964009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A0FNVhKwjG3aDw/GRmOzMnN8MY+Svb77ZDzchT5mAYc=;
 b=CK0y51EFpliVP2OZdPAeTlpHqiEYzCBkMs0ndn4VBYI2OW1A17PvwDY7t3r4sqiF6/
 z4By+HhfQuCvpiCdjCjACn9yfGQGIYW9y+O42tBWT2hGWdikQzdZvLE6uZwcbD3e9fIn
 yr1OrtI0nc7mf3JHFhlOWaWlejGBiJYewQp4hv3dAL1hZRVXFRUsEFtMAmfTuBWYnTfH
 4nP1j2L8a/9tS0zwTBNW2eCnDnrGBQxyxQIbzhs3Mqc9YqKN6iNz5/B2W/c2NxI1RRUP
 B9hKpD1kwpUSWO+1dbJnSA2it9Z624oUZxIsVSqKGPPRwD/lLO/UZ4e4V1yDbIj8p596
 wFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783359209; x=1783964009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A0FNVhKwjG3aDw/GRmOzMnN8MY+Svb77ZDzchT5mAYc=;
 b=ReC84f9MUp18sOaBfnfvcLkpwpExTGzL0cC2xRCLbvAe1J9eWPjrYM5nO3kM5vmzIc
 fiM1jY2n4QSSbpiNoOKts1fZOiOQObdcmmBNw55HkVSroG7toykMpBFzmNvNhtmRcYMJ
 JpXg3FjTaAR08PWsKAf46ltkH81fDf21pphBSr70KDvyoWVRHigiaLXP58NVKqnxv45C
 xefC4tjQwqMvJquO72XZn6yaRqO0KiwS0a10wPSJ7SYR0L8EsWVhECv3AYOVrELxYPXK
 x5gLQl86vFUKc+hjKrk2IBjHgrtl5LwFoYAppvPWdvk13suB+KyDm6qJKBLLm0mGmk5/
 /Dmg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7C5EhAB4am5G67k7raMeb68UI2EYLVc3h7KSX/TvQzujz6wOUfsgy2/7+9588BQErJsGRvX3JZ4sD@nongnu.org
X-Gm-Message-State: AOJu0YyvOpFbSCFOl4ceqaK51Z1lnAKtkkyRhH/ruUJbc53sTUo5+mzQ
 VggH85+VNGYgbEmMwC3lcGsqGvEiz4XMvTHIYITeLukzE2ObETSn0gLParcdZ2NmsWY9yF3I3qy
 KKyunNYo5eA==
X-Gm-Gg: AfdE7cniSyOeq83dvLWR147jmIBo936v2UAr3kaWeKQf7JQvV86lm4R1/NK2gx70jkg
 CYqsN+gVG49gqF4O+g2qewY76rI/lULwalTRyiWw3L5OM+8UPHkKy6U9z+B03yRgyKd3VVmhZ+W
 Z4Nb4Iuhmm44v7XDXSi+yjObdl4cD9BIXXMh9v1cO5cLAyK9ShTPrc1+wEW4Vu6Q91WmEKoWDdZ
 ErtOynxMlweWv97rwoi/fEjUxs5EDb6Sbe+2LbOuCEAirdA/7obbGQqhXR0T24ClALLWfFkv6Wn
 XdBCUCCzBXkvQFMNceF/zGCg7cEEoPI+x/sDOtf/x47F2SHBCnh9ZSeGNzo4Azsh0D4zgT/6SCw
 6zIHmiq91mGPkP+hrQdGulPT0EQ/Uc0+DWdowvhPDUkj4yg6y4uifqOyoH8r1j2SQIYseG9d63G
 fawYwrHreMJVra7mbI8cD05ajvoyZzDu+6JDZDl1mdbdgoPJro5C1KNc0YKn+99dDDw6zDYzm+/
 MWdgrD+KPPupYz7FWjr7TBxMDw2V6Yv
X-Received: by 2002:a05:600c:56c2:b0:493:d0b2:bc46 with SMTP id
 5b1f17b1804b1-493df0786dfmr13669655e9.28.1783359209020; 
 Mon, 06 Jul 2026 10:33:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e006b6besm467365e9.2.2026.07.06.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:33:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/display/exynos4210_fimd: Pass width to draw_line
 functions
Date: Mon,  6 Jul 2026 18:33:23 +0100
Message-ID: <20260706173324.804340-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
References: <20260706173324.804340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The draw_line functions currently assume the width of the line they
need to draw is w->rightbot_x - w->lefttop_x + 1, i.e.  the full
width of the guest-programmed window.  We want to be able to clamp
this to the overall screen size, which we can calculate in the
calling function.

Refactor to do this calculation in the caller and pass the
width as an argument to the draw_line functions.

Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 43ad5fa0b4..52f2285cf5 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -282,7 +282,7 @@ struct Exynos4210fimdWindow {
 
     pixel_to_rgb_func *pixel_to_rgb;
     void (*draw_line)(Exynos4210fimdWindow *w, uint8_t *src, uint8_t *dst,
-            bool blend);
+                      uint32_t width, bool blend);
     uint32_t (*get_alpha)(Exynos4210fimdWindow *w, uint32_t pix_a);
     uint16_t lefttop_x, lefttop_y;   /* VIDOSD0 register */
     uint16_t rightbot_x, rightbot_y; /* VIDOSD1 register */
@@ -784,9 +784,9 @@ exynos4210_fimd_blend_pixel(Exynos4210fimdWindow *w, rgba p_bg, rgba *ret)
 /* Draw line with index in palette table in RAM frame buffer data */
 #define DEF_DRAW_LINE_PALETTE(N) \
 static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-               uint8_t *dst, bool blend) \
+                                        uint8_t *dst, uint32_t width, \
+                                        bool blend)                   \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -813,9 +813,8 @@ static void glue(draw_line_palette_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
 /* Draw line with direct color value in RAM frame buffer data */
 #define DEF_DRAW_LINE_NOPALETTE(N) \
 static void glue(draw_line_, N)(Exynos4210fimdWindow *w, uint8_t *src, \
-                    uint8_t *dst, bool blend) \
+                                uint8_t *dst, uint32_t width, bool blend) \
 { \
-    int width = w->rightbot_x - w->lefttop_x + 1; \
     uint8_t *ifb = dst; \
     uint8_t swap = (w->wincon & FIMD_WINCON_SWAP) >> FIMD_WINCON_SWAP_SHIFT; \
     uint64_t data; \
@@ -848,11 +847,10 @@ DEF_DRAW_LINE_NOPALETTE(32)
 
 /* Special draw line routine for window color map case */
 static void draw_line_mapcolor(Exynos4210fimdWindow *w, uint8_t *src,
-                       uint8_t *dst, bool blend)
+                               uint8_t *dst, uint32_t width, bool blend)
 {
     rgba p, p_old;
     uint8_t *ifb = dst;
-    int width = w->rightbot_x - w->lefttop_x + 1;
     uint32_t map_color = w->winmap & FIMD_WINMAP_COLOR_MASK;
 
     do {
@@ -1240,6 +1238,7 @@ static bool exynos4210_fimd_update(void *opaque)
     uint8_t *host_fb_addr;
     bool is_dirty = false;
     uint32_t global_width;
+    uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
@@ -1255,6 +1254,8 @@ static bool exynos4210_fimd_update(void *opaque)
         if ((w->wincon & FIMD_WINCON_ENWIN) && w->host_fb_addr) {
             scrn_height = w->rightbot_y - w->lefttop_y + 1;
             scrn_width = w->virtpage_width;
+            /* Number of bytes to actually draw */
+            window_width = w->rightbot_x - w->lefttop_x + 1;
             /* Total width of virtual screen page in bytes */
             inc_size = scrn_width + w->virtpage_offsize;
             host_fb_addr = w->host_fb_addr;
@@ -1273,7 +1274,8 @@ static bool exynos4210_fimd_update(void *opaque)
                     last_line = line;
                     w->draw_line(w, host_fb_addr, s->ifb +
                         w->lefttop_x * RGBA_SIZE + (w->lefttop_y + line) *
-                        global_width * RGBA_SIZE, blend);
+                                 global_width * RGBA_SIZE,
+                                 window_width, blend);
                 }
                 host_fb_addr += inc_size;
                 fb_line_addr += inc_size;
-- 
2.43.0


