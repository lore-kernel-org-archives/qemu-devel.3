Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE70C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90E-0004YF-Hm; Tue, 26 Mar 2024 11:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp90A-0004Du-Sd
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:14 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp909-0001JS-1c
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-341c7c8adf3so2025402f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467971; x=1712072771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTnsklKw4fWTCEXstwwApylL5b79xPCluS5bdtq/AP4=;
 b=K9kypSWjrfL9N49/W0NFOIIlz2Dnk9rtYgHDD6A1UPo93CPorPUdqVmjm6kgb6pr2O
 ZuDtGSzklFVjwXlOvepNxv0tv7EHRW9ndWLYhbvZBKNEJKw3G3sqh/NjSeLkNEqY3810
 lC/FZkOjdhaCgmmaGXaR0yLvPtpXg37ndUompjvycbESn9AEB3SfLm3FEeUVU8i9a1UC
 FL/if81txP+DD12rEucTkPTogqMX0JCVVr4lUnZc4f+qhgv9kWP0UtxgbS7YcTUioGqI
 8aHdJtGGmg9YCTjK7Udiyf5IkzFCclroIJUHFaunEgDmUZuQS2O0Gx9apk5FQYDC5pU6
 tDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467971; x=1712072771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTnsklKw4fWTCEXstwwApylL5b79xPCluS5bdtq/AP4=;
 b=QOn0wjYMRy8wymQWLFp1CHha2K0NGFyxXjt7Q16nOtY3Zj3+2wkyZZJ9a4kvKPfrNr
 I8FVqn9c5vtj50Sm68z+j8kGg6+IUXsLl0W/+Ur5Y2V6g3RSIqA7B8u7VTtgpgAtN7F3
 WsjxbF7VzhAq+sc8u1WDQgD4/au34yYl0B97GyBmO1O+0NS/RqseJoV9uiF6+mXKrAp6
 vxQBBXbhervPKgzMTJGBMeA2e4KpKzKISAoHC5XR7mpB/DoP1v28dfCDrLe8TtWpZ3RP
 pOPMuEss3gp8UAsxuFW91sI39TEpDW6Yys7qpg3+GvkHn4vTJ27qPZbRMLtLxiFLQYtQ
 ONww==
X-Gm-Message-State: AOJu0YyIENf6BsRhQfUCrMm+0cxYWKCFMcUJI8r6+Vv7Ky04AxX+G6y2
 m5PtbZNtLlIrEiclrTP2T7FHRQKziMC/Y6blWj85QY7RFcotFEuaSKj0g6cTMlehkXBGUtdNDGp
 r
X-Google-Smtp-Source: AGHT+IFRg138015mLkS4XG4Sdyh7YagfM5S5mQJ97xUcjF73GKx/sVaycVtwbwmi4p09E0ToYZh4Dg==
X-Received: by 2002:a5d:5b88:0:b0:33e:c0a9:79c with SMTP id
 df8-20020a5d5b88000000b0033ec0a9079cmr24223wrb.23.1711467971342; 
 Tue, 26 Mar 2024 08:46:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 dv13-20020a0560000d8d00b0033e25c39ac3sm12463085wrb.80.2024.03.26.08.46.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:46:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/13] ui/cocoa: Fix aspect ratio
Date: Tue, 26 Mar 2024 16:45:02 +0100
Message-ID: <20240326154505.8300-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

[NSWindow setContentAspectRatio:] does not trigger window resize itself,
so the wrong aspect ratio will persist if nothing resizes the window.
Call [NSWindow setContentSize:] in such a case.

Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240323-fixes-v2-1-18651a2b0394@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 810751cf26..17e125d66d 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -519,6 +519,43 @@ - (void) drawRect:(NSRect) rect
     }
 }
 
+- (NSSize)fixAspectRatio:(NSSize)max
+{
+    NSSize scaled;
+    NSSize fixed;
+
+    scaled.width = screen.width * max.height;
+    scaled.height = screen.height * max.width;
+
+    /*
+     * Here screen is our guest's output size, and max is the size of the
+     * largest possible area of the screen we can display on.
+     * We want to scale up (screen.width x screen.height) by either:
+     *   1) max.height / screen.height
+     *   2) max.width / screen.width
+     * With the first scale factor the scale will result in an output height of
+     * max.height (i.e. we will fill the whole height of the available screen
+     * space and have black bars left and right) and with the second scale
+     * factor the scaling will result in an output width of max.width (i.e. we
+     * fill the whole width of the available screen space and have black bars
+     * top and bottom). We need to pick whichever keeps the whole of the guest
+     * output on the screen, which is to say the smaller of the two scale
+     * factors.
+     * To avoid doing more division than strictly necessary, instead of directly
+     * comparing scale factors 1 and 2 we instead calculate and compare those
+     * two scale factors multiplied by (screen.height * screen.width).
+     */
+    if (scaled.width < scaled.height) {
+        fixed.width = scaled.width / screen.height;
+        fixed.height = max.height;
+    } else {
+        fixed.width = max.width;
+        fixed.height = scaled.height / screen.width;
+    }
+
+    return fixed;
+}
+
 - (NSSize) screenSafeAreaSize
 {
     NSSize size = [[[self window] screen] frame].size;
@@ -536,8 +573,10 @@ - (void) resizeWindow
         [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
-        [[self window] setContentSize:[self screenSafeAreaSize]];
+        [[self window] setContentSize:[self fixAspectRatio:[self screenSafeAreaSize]]];
         [[self window] center];
+    } else {
+        [[self window] setContentSize:[self fixAspectRatio:[self frame].size]];
     }
 }
 
-- 
2.41.0


