Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E87C4829D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 04:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra6wa-0001tr-8P; Tue, 13 Feb 2024 23:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wY-0001tc-31
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:22 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra6wW-00063y-CB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 23:32:21 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so3413023b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 20:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707885139; x=1708489939;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wnwjVxqk08D3G/NjJfrMLQ/7aEsC1PfgC3HvxwkiAkE=;
 b=ijEKGLiqQvb7XuKcmOY1hVhrw2DREItYaccscCedht0/E/dLxlbWgX+VLDx1xbwo3w
 yDR+xukH/RQhMB5V7XABYuZ42SU3Ph9Rj2BAOBHvM+MjbusR6oNtMB0UmRe9syZ7aee8
 vcZOuedOkykcsC92Zia2bnUHnJ62d6F+T43sq/gvpcCTUhte7FxCdKnJyEvx70JTam6z
 AGmCf3KYM0JKNIIbW/o3JcoIOmXVSaEn1SSmRMP3+dR6HEi71ey1qXAMFixVw23/6/hc
 IjEBDqkZjmRLgXPH0JFO0Wzj9LgBPQymF2zgHXKLsQjsbA1Qw4Nxa29EKPeX5n0xHfjS
 GP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707885139; x=1708489939;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnwjVxqk08D3G/NjJfrMLQ/7aEsC1PfgC3HvxwkiAkE=;
 b=npCf6R2eiqX49dsKvY7TKZee60VowcGYAaPMSzuCbcQQQ27eNbQ5OnL/mdrDnO2Brh
 AnSaSavbeNWdj2ul4WYepYh/+4hUJ8U3PTK/OyJqaBccXfI5sN5HvVwKbH02OP1X61Bw
 KuE03GBomKYJIJb1++tqys7zCSsM2qIa8e6YE8pZT/OcO1GfaMzgKL8MFj906sI8igB2
 EzejhaIh7+8w1x1LRlctoZDXLlF1TZ7ejHJCVLzgKlBFj1nLgNkqq8DSllHPXMaEYMpZ
 Q9sCAUiNnTfJba7aFZKYTR/mtkBp2hF2XgXba5SRgjvPyD93zQmdknnNw6m35YgTdavP
 vtcA==
X-Gm-Message-State: AOJu0Yw3PKplvCwkzsDPab7YOTcYFunzqZGCHHi1z6zOKDHcTph/MCDI
 hL5gncOqVP3r/EdAAq5GlW/SwAOwX9FQDyquedpQ36sw+/4mJ02v+0tkT7aoaDU=
X-Google-Smtp-Source: AGHT+IEZbAwMDMhqJrweLJJi1FeCZ+PTaJEYF+TRLfjAyIVOaqTwJck1+RbiIMZYbgRttzirRCB6KQ==
X-Received: by 2002:aa7:93a1:0:b0:6e0:3834:6573 with SMTP id
 x1-20020aa793a1000000b006e038346573mr1306827pff.28.1707885138720; 
 Tue, 13 Feb 2024 20:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU1bemxcRxRzmtOLHh09pQsCabGORqxkAEkbQviCwYCbmtjt6LwJZE0mgLX1MF2IOxO1+BDD4jA8QxgJRySR6AaGJkwPfx5E8NpDuJ/+9SaeEJRDtnKJ3BqfiDN1hIs1WXXhzCVDsLjvQDcbJ0WTQbTRKkTkOrDVpL8hBF+7rLa7AlxuosvyqTSpIRys4/c2jgb0Qx3HR0eBxk0Kbqvzdh+NifKignoRSJJOioEZXCXxI3N0OtssLwTsTfRMgeZIbjHqV/wPvIEiTiq
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ff21-20020a056a002f5500b006e0737f2bafsm8203108pfb.45.2024.02.13.20.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 20:32:18 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 0/6] ui/cocoa: Use NSWindow's ability to resize
Date: Wed, 14 Feb 2024 13:32:00 +0900
Message-Id: <20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEFCzGUC/2XNTQ6CMBAF4KuYrq3pFOiPK+9hXJR2Kl1ITTEEQ
 ri7hYQEZfle5nszkQ5TwI5cTxNJ2IcuxDYHYOcTsY1pn0iDywXhjBfAAaiNNhpaSVErUWjUtSP
 59p3Qh2Eduj9ybkL3iWlcd3uxtP8LvaBAS+2LGhlo8PzmzNiG4WLjiywTvdwzuTGZmTCeA3pZC
 cUOTO2Z2piijDrpjVPMSvTiwPTGSsah2JheWGUqhNqzUv9+m+f5C3MH1Y1BAQAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

V5 -> V6:
  Rebased.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v10:
- Removed relative mouse input scaling.
- Link to v9: https://lore.kernel.org/r/20240213-cocoa-v9-0-d5a5e1bf0490@daynix.com

Changes in v9:
- Split patch "ui/cocoa: Use NSWindow's ability to resize" into patches
  "ui/cocoa: Let the platform toggle fullscreen", "ui/cocoa: Make window
  resizable", "ui/cocoa: Call console_select() with the BQL".
- Added patch "ui/cocoa: Scale with NSView instead of Core Graphics".
- Rebased.
- Dropped Tested-by: from patch "ui/cocoa: Use NSWindow's ability to
  resize".
- Link to v8: https://lore.kernel.org/r/20231218-cocoa-v8-0-d7fad80c7ef6@daynix.com

Changes in v8:
- Split into three patches. (BALATON Zoltan)
- Removed negative full-screen conditions. (BALATON Zoltan)
- Converted a C++-style comment to C style.
- Link to v7: https://lore.kernel.org/r/20231217-cocoa-v7-1-6af21ef75680@daynix.com

Changes in v7:
- Fixed zoom-to-fit option. (Marek Glogowski)
- Link to v6: https://lore.kernel.org/r/20231211-cocoa-v6-1-49f3be0191f2@daynix.com

---
Akihiko Odaki (6):
      ui/cocoa: Release specific mouse buttons
      ui/cocoa: Scale with NSView instead of Core Graphics
      ui/cocoa: Let the platform toggle fullscreen
      ui/cocoa: Make window resizable
      ui/cocoa: Call console_select() with the BQL
      ui/cocoa: Remove stretch_video flag

 ui/cocoa.m | 532 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 249 insertions(+), 283 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231211-cocoa-576b8639e9bd

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


