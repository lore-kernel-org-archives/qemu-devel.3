Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D93C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8t0-0000hs-3a; Mon, 18 Mar 2024 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm8sx-0000hk-ON
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:02:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm8ss-00032H-Kg
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:02:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so2675953b3a.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710752537; x=1711357337;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z502RLD1sgTFTr5v5TqEjfA7K9An+j6E1eKtJWkBMR8=;
 b=WuBHXwmTzQTmNEyGqixLdhM4IVNZqDKns+22UYXB5veiH49NomPEHBG7U1c57+E4uV
 kI5vZ+G/tEPev27bZbDG5T9vJlB4FkPeMBe9HpOh2OYVPnLJI9vqOPQLlOeF0bGNeFBj
 3lqk2vsyrmpNUJy4DEiJ4b7b8JauxaE2BUzCoTRjBHOr1ebAAQ/N0WosY0d9CR70+17E
 MYOFBn1n1bkwd4CHWDPazIo4uHpE90KlgXK6GFQM2MZs44wz2AdAk37yuhWulqtNqvCb
 h+NVnSi6zdgsxTLP4LwbbTe7R8B2V2TJQnMDMEz0H8wSRzfSBeRLxu+WpcnjpsFsbxtM
 /QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710752537; x=1711357337;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z502RLD1sgTFTr5v5TqEjfA7K9An+j6E1eKtJWkBMR8=;
 b=ZAkCrHugflgTxoSFz1yKQL1MZXr5NejHcVi4phEBcz3FTrZHLNIENslykDfO9MoDsP
 nDMm5TeGz7/fXBTcXyeraXJbXPUhwASILWykc2eN8/8r3pgN7PB1d5y/s6rkxUbqsWqV
 2Ue1oFQgJLpRGHh4De6L8Uz192K0GU5gqTaGSv4v2fFkEVyeTcTM977rdgU2jgk5ipcE
 yTM5eL8ca+N50hii5ssNht7WhvGFDCkBv6GEnBlR2n+ReDt3xSWEqEo3NRuxjBG/i3DI
 lkZ1zmzFGLbrqgn86XYABKYvqB3/xpgMRFiY8g6Y6rSL8KQRK7f09fDVJD/iSrbjRlsM
 H2Mg==
X-Gm-Message-State: AOJu0YyVrKGGGMTo8o+XUO9FBEWw5z6nZoiuanetGWdxGNXB0ipEs2GL
 h/VNSShwHHLlZP/GTLrddo5GpIfZmlqBjgrPmaDRhzXIa3AA/9luS4GSw+hbdhM=
X-Google-Smtp-Source: AGHT+IE/IVMlxC1eWbaOj8Yb6RNpPlgdOI5A0AS4PMfchqQpBPdawnZ0PtsHYn3TIMCYWqQD2Oa9Ow==
X-Received: by 2002:a05:6a20:748b:b0:1a3:6bb1:92fb with SMTP id
 p11-20020a056a20748b00b001a36bb192fbmr323792pzd.19.1710752536995; 
 Mon, 18 Mar 2024 02:02:16 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 f5-20020a170902684500b001dddbb58d5esm8904883pln.109.2024.03.18.02.02.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 02:02:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 18 Mar 2024 18:02:12 +0900
Subject: [PATCH] ui/cocoa: Do not automatically zoom for HiDPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-zoom-v1-1-07ad14fcde19@daynix.com>
X-B4-Tracking: v=1; b=H4sIABMD+GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3ar8/FzdlDSTFDMLY5NUU7MkJaDSgqLUtMwKsDHRsbW1ABcWCA1
 WAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cocoa automatically zooms for a HiDPI display like Retina and makes
the display blurry. Revert the automatic zooming.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index fa879d7dcd4b..c5b3c28000ff 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -522,7 +522,10 @@ - (void) resizeWindow
     [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen.height)];
 
     if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
-        [[self window] setContentSize:NSMakeSize(screen.width, screen.height)];
+        CGFloat width = screen.width / [[self window] backingScaleFactor];
+        CGFloat height = screen.height / [[self window] backingScaleFactor];
+
+        [[self window] setContentSize:NSMakeSize(width, height)];
         [[self window] center];
     } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) {
         [[self window] setContentSize:[self screenSafeAreaSize]];
@@ -575,8 +578,8 @@ - (void) updateUIInfoLocked
 
     info.xoff = 0;
     info.yoff = 0;
-    info.width = frameSize.width;
-    info.height = frameSize.height;
+    info.width = frameSize.width * [[self window] backingScaleFactor];
+    info.height = frameSize.height * [[self window] backingScaleFactor];
 
     dpy_set_ui_info(dcl.con, &info, TRUE);
 }

---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240318-zoom-df4d6834e56b

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


