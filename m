Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C591EC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnCT-0007GP-8S; Mon, 06 Jul 2026 13:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCI-0007E6-Cd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:34 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCF-00046B-Ec
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:34 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-493b567a019so5406475e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783359210; x=1783964010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pybcs5s0EJoZh0aRLv5GD/xzxrXejiSNkABytqAQThk=;
 b=pHs90fLrDAUlNQf8H/A88LkFz/ZJl0ZnSGEx5Ckma3XxnzN9syvTQQ0vDDW/IiVWTH
 1COjk9aZLNy+6AsipDPH5cL5OZBYpLHW6yPeVvC8dds+h5AsmVXh6exbBkAj2KbIqMoi
 SuIlFJ79jCR3UKvy2RMDQNubNHyyQmJst2V7G7wptRaBJb/Fv0YA4uRjK1PUEVeKUd7o
 H11e80Ca0sFkBcnp4FWOz0dEavkqBXVuCQoX2SCLewARUGh+LQ++xM/Ms+x5eZA7LVIJ
 ZT87CSVKBYUvYxmgmpTYy3ISx57zc3OeWytmJ6W/AivD1oCYpTk2mZzzp9LSMu1llmDQ
 jyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783359210; x=1783964010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pybcs5s0EJoZh0aRLv5GD/xzxrXejiSNkABytqAQThk=;
 b=kVYWMPWiLo3b5h/ba1xSVaqgidW2206fXxjLcWQEiTwv7A3mSxbk4wr9MZFxHuE6az
 dElLUcn2iGGTLS/9N7BnzaRD/WTwGrkur1sb+yG3x/ZzX6AbI+I+ojVeQ7Ln2r5B+aBD
 6kpaggeG1nte54NL226OEAZY77yg1Usk+3mYb8a6RvT3u8XCtpJW29U5XPxKxDIAVCTH
 iJ7fTqOYP9NbZbc9YKgLhPVrNSSqjreScrx9mTBZrkGhZemRv4o3ZDNdLp5vxCL0/D9f
 CQe1pbY5Ia1Xgl9CMl0lq5zfksqktzXOG15xyx5cPf+Aby0BDkdPE3WFBUH3c5w0t9BG
 cw0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxnUclL5BjZ4Lk8QqqDs+HseHJrI0CwPUE+YhXdyFWIqA6pbq2OPj3Dwpb/83DaVZn7hHtgRgRzM0C@nongnu.org
X-Gm-Message-State: AOJu0YwvPdfpcRLydUKXwCTPEEks5UdBaP8cA3qz1YLvY9z0cq4f7dmc
 9trx9mdr5UiVNC1lgtO9o8q1x7tREyONOy1FDfX2rLIc4q17IhyFtn7NQdLS4M2I4pgDGzXGQZn
 dgpK/THRWmB2S
X-Gm-Gg: AfdE7ckhY8Dxg+A0UXxJX9v1XnkYwFqXrCQ2DW2myfbMpbKdtVf52Q6kzq/VeCq2mCw
 eZEs68QfB211xnp5cG7YHfvkfek+RFp085RKbcyl0nl0nuacbM0srOLbGIka3zXtzVPZxKvmq0j
 fcgmCqHUD87oEqXppY+2QlTIkA5yFWYAYLSRKrS2q6FOO1Ng9sH5QeFObxLQtvYv66EPaGIUDxE
 1NCp1v5AMB8xgOyWdemQa/CUWaWZ7eMPwuThFu82oZLuftcznWLBdzJYX8DH3G9nx/DINwlua30
 BcDrSY7sWaeu1hck1GFlJW5c2rgQhVW+//hfCW6VepCY0NYFu9KlLNJKStWQyD2Fp3THFmqo/6D
 9P6drmy15ATeOYx/iI3lKcslOCPcRl1eO73YBpAT98+YOIQ0KFbCs9cijwM8tC6g+WX+UGN7Gug
 4jGHj7FPzo1vTRxGhFgZh+l/u7zCJ3i7eZmBPrqngH3HvIMFyZwxDOt73Hb/9Xb8maG3ewTlca6
 cphmhAcitVhjp+jgkeG5g==
X-Received: by 2002:a05:600c:3f14:b0:493:ad1b:b38d with SMTP id
 5b1f17b1804b1-493df0a0891mr16650575e9.37.1783359209871; 
 Mon, 06 Jul 2026 10:33:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e006b6besm467365e9.2.2026.07.06.10.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:33:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/display/exynos4210_fimd: Clamp windows to screen size
Date: Mon,  6 Jul 2026 18:33:24 +0100
Message-ID: <20260706173324.804340-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
References: <20260706173324.804340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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
---
 hw/display/exynos4210_fimd.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 52f2285cf5..6c062a28c0 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1237,7 +1237,7 @@ static bool exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    uint32_t global_width;
+    uint32_t global_width, global_height;
     uint32_t window_width;
 
     if (!s || !s->console || !s->enabled ||
@@ -1246,16 +1246,28 @@ static bool exynos4210_fimd_update(void *opaque)
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
2.43.0


