Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E13C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIix-0007TU-QC; Sat, 17 Feb 2024 06:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIiv-0007TG-1g
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIit-0002gJ-JE
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:19:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d72f71f222so12185285ad.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168750; x=1708773550;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DO8YZPx6QrrKSNDeG/X3kChJmZWSkpzHJ3UAX5RJjfg=;
 b=1B4IJk/wojUGS1K4+2dhsjv6K50nOXXg0ZwwEnEzyaMkpccISUsJN9p0fYHhcdIKEm
 xgAMNy8bhvZL/P4Yb4Q6517UXtvQCIXQiKtM/VG6uMbr7OWmp0Vxgu4mnej5VOsgeldO
 g/jo8GqKfsDlpk+8mTvRBz6ALkTEFPbGD00ihGgg8U+32Q3nQ1AdxYUvEIBWo5GWd7jq
 KbuqGp7jEtjIhTkfn74nm4iC+RhJVDWWoe2x0meOiWfomYfj8JHxXBRpHc2o0zlBs+LI
 F0Ht0NBnjqqP9hri78nvRA3JS/Eyy8Ba5syXahmqxKaL/DP/y2NIMsLi7+2SB+5dp+KL
 iRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168750; x=1708773550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DO8YZPx6QrrKSNDeG/X3kChJmZWSkpzHJ3UAX5RJjfg=;
 b=AwJRTU9VzMZAPr/94pUriW3pL3WAGt7AjDRaGjl+KbO15qAkSp5eeFk0Rto0T1ly9i
 hsvTG0N26Oqa3BGYiRipEKNeCeKA4MnbOPAcdtY1KclwGmffAPqN431Kc3oByrBfBCL4
 U13mZE2R1dFi4N0ikNvIcEwAA9lnf7L/j+/f1+UN7L9GyGm+pM2VPoYCwaq+s1ni3ETx
 Cf6KJJRw9/sMPb3t9C3jm1N/FwQW9rWE8pSFz9D+w5Hg8d1PBMGER0aBznateUQIpFzd
 gWu4uFzv9MV7+7klPFW/YdMMxcmPf/KtBSCr06cs0qiQ0cyrDkWsRvu4O82RkOvBR5CX
 43Qg==
X-Gm-Message-State: AOJu0Yxg+4GXtEckYtTo7+3fgF0uxqwSbZTyOYlxkZxyIXKYo1MtaHc5
 PU9S0V4XVR7CCW1w9WMfa4Z+0FkDYasOxPWpLhCDDMeTLDtNU8MnuKmCTeIrOdc=
X-Google-Smtp-Source: AGHT+IEbAAC0ZrJ9krUDnZ8sltdpmoIrCjN6VBn1RqJXaLoogugpnsrnB58hAHjVlMN6JMMMbY3Fyw==
X-Received: by 2002:a17:902:da87:b0:1db:28c4:b757 with SMTP id
 j7-20020a170902da8700b001db28c4b757mr8454048plx.0.1708168750434; 
 Sat, 17 Feb 2024 03:19:10 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 e21-20020a17090ac21500b00298dd684b8csm1586463pjt.32.2024.02.17.03.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:19:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 17 Feb 2024 20:18:50 +0900
Subject: [PATCH v11 4/6] ui/cocoa: Make window resizable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-cocoa-v11-4-0a17a7e534d4@daynix.com>
References: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
In-Reply-To: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

The window will be resizable when zoom-to-fit is on.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 0ebe0f326373..17f290987563 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1379,8 +1379,10 @@ - (void)zoomToFit:(id) sender
 {
     stretch_video = !stretch_video;
     if (stretch_video == true) {
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
         [sender setState: NSControlStateValueOn];
     } else {
+        [normalWindow setStyleMask:[normalWindow styleMask] & ~NSWindowStyleMaskResizable];
         [cocoaView resizeWindow];
         [sender setState: NSControlStateValueOff];
     }
@@ -2033,6 +2035,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
 
     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
         stretch_video = true;
+        [normalWindow setStyleMask:[normalWindow styleMask] | NSWindowStyleMaskResizable];
     }
 
     create_initial_menus();

-- 
2.43.1


