Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA49C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 07:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7o3-0002vF-4w; Mon, 18 Mar 2024 03:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7o1-0002v0-AI
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rm7ny-0008Vy-Dh
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 03:53:12 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1def142ae7bso23241305ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710748387; x=1711353187;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=50Na86RH2DAFkdKCyteYOu4w/+CXTPWd6wjY+hO/isU=;
 b=mff1+NzuEBUtbRQIKnByT3Jh/2u0BOWhG4KgmQ2b+B0a91i3OXvhT1wYe2hxyoVdCM
 57qqA2lyzQw/tB0OxpXg+K15mAN5gitu4AJhrigt2ocTM1mECTbDhXoc0697gxBUMIYA
 NRfacGGaejIoCze2LS+7qqMdjgGjuZzZYYS8T1S40/tXuEaGm2Xz+0ejax5LAJWKm6cb
 mDjPevEAGeTN5SafE74ZrdWnnk0084wDwda2HHkK6fsHUgHtdc24XZjagb8I9s7uu172
 HCacd425x/VMQ0g+MNTo0wSaaDHa+rnP9l9tmYT2sWV1F7TfOMHUonifeO4WMLbis/p0
 vzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710748387; x=1711353187;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50Na86RH2DAFkdKCyteYOu4w/+CXTPWd6wjY+hO/isU=;
 b=PkscZsbxeEi42uBpueBUeX/eJTEevshjDqUNHmV/hxSVXS82snbB3fzupRZNk3X9P/
 UO1e4aaXuve5nR+hrJJfTibLvJdL/4Z3nqd+sXzJotwSjJkX+QLt8REMqkV7GNWBR+Z+
 5GJ4fCn0AU5q0jts4Nw7gjvZafBqfeX8QDZnkNguzgHOpWRNm6lZncTyl+AtUZSMl+7v
 h64+y+Krxqe5e9MafcuPRJ2pzd3xm7Fq5gF0o/f3MxM3WUa2Mu7sI+Gg/KFRXXcdlZz1
 eP+cu7iEI13T7WTCnu7h5yyNOdLI8BhBa0NUnwFt3TDZlYE4z0TwH7xeVsrSpZzDacTE
 UxdQ==
X-Gm-Message-State: AOJu0YwVzZ9xXG6J+WMpNe7XY9IjTjn/dQ78Ha5Qh7ApSJI/Qjnok2XM
 jIiAcpFf7s43fg+Pi8weSO39CAyhrwLAEkAbtjNIFnF1DRZflCK0V1hBG/0UVc8=
X-Google-Smtp-Source: AGHT+IGE3srPYXlwaxn+LKG0T7KDmQY5XAzvWVGtwA2ET0hY5SLQnL6XijmKbIr+7m5HbkptPfB47A==
X-Received: by 2002:a17:902:e5d1:b0:1e0:2bce:d7ed with SMTP id
 u17-20020a170902e5d100b001e02bced7edmr1327203plf.26.1710748387566; 
 Mon, 18 Mar 2024 00:53:07 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 x9-20020a170902a38900b001e004924412sm3419502pla.108.2024.03.18.00.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 00:53:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] Fixes for "ui/cocoa: Let the platform toggle fullscreen"
Date: Mon, 18 Mar 2024 16:52:59 +0900
Message-Id: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANvy92UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0ML3bTMitRiXfMkQwvz1GQjY7NEAyWg2oKiVLAEUGl0bG0tAHpI4PN
 XAAAA
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

This series contains patches for regressions caused by commit 91aa508d0274
("ui/cocoa: Let the platform toggle fullscreen").

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (3):
      ui/cocoa: Fix aspect ratio
      ui/cocoa: Resize window after toggling zoom-to-fit
      ui/cocoa: Use NSTrackingInVisibleRect

 ui/cocoa.m | 72 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)
---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240318-fixes-7b187ec236a0

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


