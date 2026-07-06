Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2095AC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnCZ-0007Li-K1; Mon, 06 Jul 2026 13:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCH-0007Dz-8g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnCF-00045j-2D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:33:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493d3135f62so11988915e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783359208; x=1783964008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMkmNSdkpmxypOmCNIZ6s6HhJiiuCbTO1iVZOoCp2tM=;
 b=yIIQQxwpohcTO/AUkHLr04UjSVprH+M4SHOek2aePr/n5OqeiNxD/TdDH1HBthdOTZ
 6ektiSSx2yp0E3wGQc3+gTf9yL+ZYwuH+akDhaH9SiHQ89vGYoVbXGrTma28lxKdt+5d
 fFywTFJ1aY2SfHgl54+1UQTkvzRK+nRl37xhq8V/ZZWTbPIwNgg23VTDXwGPSMfZ78ti
 VHw8s3YB5aWfmv1uFKyck4GLFABd/xNkN+gIriIdcUoKKA1QclpiJoJw+UN1fZ8RP6Qq
 XppHvzHCrsDiN0HzT/gtOqrYxOda7i4Xk/8pIQJsK+SJTG8/wBl/2D0kWqSTRqKuzdC6
 ninw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783359208; x=1783964008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kMkmNSdkpmxypOmCNIZ6s6HhJiiuCbTO1iVZOoCp2tM=;
 b=SGI3dgvz73ePJckLuzGKtJCzKv9euc/gJ2Ibt44QoHf4W9SOly30O3WRU4ctVMP9eY
 i9YrZaTfvakLqIiQOsfzZF/mcfp47vfjFBW3yfy7U1RRf8vfzQt7hhKQ2ssEHGRssjIw
 DvYAbmuvIXFvZOu45qfQuLRPJl5/9wtnX/xzkrGH1bK5lYG+NAzZUzexz4J6h7kGoOwO
 FYGd0dcz7TPUlYUNFQu0+qWIroaupMyrhk3HGFeHDdEtZq77IenHPubYQWGenR8uWFgj
 JsBQgvShxAp4JfI12SToEzjzY0Ig5v1rJU1ZKYW+IxxIFLdwOXVXPxeQJJwCjc8XIkSj
 qHdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIXQIWCtkNUbq6jLoQYgNc4DxrHUHFDSEfSjDU/8+tFiKAaVIO7CWWPgrgQa4akJ+wFQpoMbSsW69q@nongnu.org
X-Gm-Message-State: AOJu0Yw7Kjsg50mSB+tF2ZE7ir4ODipGMUY4K6c84OunRZAZKz9gs+Fd
 sviWVBAgL0PkmA+0tsSUXnPdag6IXV9l2GKRQOYcGm1txxQ4N2rf6wEqzQL3MrDG1JM=
X-Gm-Gg: AfdE7cnI0EOSbUkx9f1jsKjBEbTYtPU2mJ7TWZZl1m8VtMEaSYnsc5BW8MYv7oAFtMG
 g3BshetB4cBGGit4/F3FSB+y+8SaFzOxqn8uXaWlGUosLg1BWC5o7mTbBghoxrI769jSbGYmoia
 0C5UyRNzdZtHoQ4UlWqLXZuaZYEOerQWumcdEHZx8nIYdbP7PxWIVJcNdFNDUfPIj83I/EnK89Y
 1eqP6C4bTIL2f+sOncaM1Cy4+rqMfZ5Wa/8cb/rsuNP9Vt+z5DP+OBTp/X7myRsvLGPPAcnv6mo
 RJkZUjHgE/P2H7TEIHD7+SaVdWrUDKcE4de+tnukUaQasghJW1opg+Dq9N+loxXY6iMF7quBi8a
 iNlvKgJdlHdp1eP1OckYWtSVAhrIBB+YP6muuJIB1IsRWXKFdymW27TcMyiel6wKrh4hhrclx8z
 4r43IaoJif0IzxAEclSw3nNJkXlP16G98LZfmAG3Q41SzaHyIX/wwzByMHGX1fdyjNA5qFesfrN
 lFkxJQ/jKpFwZf7hWaHpA==
X-Received: by 2002:a05:600c:37ce:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-493df0777bemr19584785e9.37.1783359207262; 
 Mon, 06 Jul 2026 10:33:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e006b6besm467365e9.2.2026.07.06.10.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:33:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/display/exynos4210_fimd: Factor out finding screen
 width/height
Date: Mon,  6 Jul 2026 18:33:22 +0100
Message-ID: <20260706173324.804340-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
References: <20260706173324.804340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently we hard-code the expressions for getting the global screen
width and height out of the VIDTCON2 register where we need them.
Use functions instead.  Make the global_width variable in
exynos4210_fimd_update() uint32_t for consistency.  (The values are
clamped to well below INT_MAX, so there is no overflow risk here.)


Stable CC because this is a prerequisite for an upcoming bugfix
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/exynos4210_fimd.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 7507e4fd3c..43ad5fa0b4 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1195,15 +1195,25 @@ static void exynos4210_fimd_update_irq(Exynos4210fimdState *s)
     }
 }
 
+static uint32_t exynos4210_fimd_global_width(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
+static uint32_t exynos4210_fimd_global_height(Exynos4210fimdState *s)
+{
+    return ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
+            FIMD_VIDTCON2_SIZE_MASK) + 1;
+}
+
 static void exynos4210_update_resolution(Exynos4210fimdState *s)
 {
     DisplaySurface *surface = qemu_console_surface(s->console);
 
     /* LCD resolution is stored in VIDEO TIME CONTROL REGISTER 2 */
-    uint32_t width = ((s->vidtcon[2] >> FIMD_VIDTCON2_HOR_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
-    uint32_t height = ((s->vidtcon[2] >> FIMD_VIDTCON2_VER_SHIFT) &
-            FIMD_VIDTCON2_SIZE_MASK) + 1;
+    uint32_t width = exynos4210_fimd_global_width(s);
+    uint32_t height = exynos4210_fimd_global_height(s);
 
     if (s->ifb == NULL || surface_width(surface) != width ||
             surface_height(surface) != height) {
@@ -1229,14 +1239,14 @@ static bool exynos4210_fimd_update(void *opaque)
     bool blend = false;
     uint8_t *host_fb_addr;
     bool is_dirty = false;
-    int global_width;
+    uint32_t global_width;
 
     if (!s || !s->console || !s->enabled ||
         surface_bits_per_pixel(qemu_console_surface(s->console)) == 0) {
         return true;
     }
 
-    global_width = (s->vidtcon[2] & FIMD_VIDTCON2_SIZE_MASK) + 1;
+    global_width = exynos4210_fimd_global_width(s);
     exynos4210_update_resolution(s);
     surface = qemu_console_surface(s->console);
 
-- 
2.43.0


