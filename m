Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4C3C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIii-0007Qx-4Y; Sat, 17 Feb 2024 06:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIig-0007Qk-Cd
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:18:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbIie-0002f8-79
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:18:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d73066880eso27847695ad.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708168734; x=1708773534;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LAr3lMhjAiLi0UyzuSLE8jaq/+w2bRS8EncImPc2AOI=;
 b=bqGevhDjRr7xyLFq239XlwuQvVxerJjTafpNqi/V2Bde4sQUCtwvIGv+/u6TW2WQoa
 i4JDTBY/V/wXFQ/yECvvL4fK5sCTQ1WL+UfjkcY8ntp4FbzZoWPz7wXYmc5Cx2XRnjf6
 BhDhZiSBICOdtkbLC5iUVB1GoWleUUaUpvff/D+Bk86e7AsNS+LBfoOs7giV0Z4LgTJB
 w/xK12fah7y8rlmeCbDzWSSoD+2FPliZDhy8o4iH39RkKZfrYXDMcT5NnHAwLUIzHp9D
 JEfjbwfv/whWOyojncPUiaiIUo5O+ZEvHKOXR+rLxt1JGsnHWDvHGFPsFJkDb57W143X
 t1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708168734; x=1708773534;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAr3lMhjAiLi0UyzuSLE8jaq/+w2bRS8EncImPc2AOI=;
 b=PO8cX3vThVGVuk5ckwiQK1w/b1cpltRkyHWAwR+BjEzEoiru12qb0q366a7Qb2LDjY
 Vq9wPmUy2NT9HmzNWGlngmpsSiUjdTZHSJ+8cNcQuk+p2FCw1I0RVkXMkeFObZIYqQUt
 vhvXQn+3fUbNuvBvM9VpZ5EvcufcqV54rggX5wHFPtPn/8c4zOM+5+qnAw7BK0iK/H7b
 2PhKVCdhM2K5pTX2jTgO0aar+9Z2hIe3wcxZvH2u6MeKvAlIgn34dE6PUnLrlEEzdzfC
 71es9RAxU4UMwMnSb4oATfoj4ZfZ0dA4karv7RtTUBtLnCzpTb3HxDIsqHcBOFhaPUCO
 v7pA==
X-Gm-Message-State: AOJu0Yx24oIYoCRoKuN7TNg52K6Ww1zk/+IL+OPKcxa829su7i3T59ub
 hImz7mDmi8p4Fmz36oPp4T2NW5xO5xrEkF3C+aX0eX8KVylStNLFPWole4thh7k=
X-Google-Smtp-Source: AGHT+IFNZTQZq51G82/jeZ+OWtT13gpoJam3cDuZNBJW+XbNHJzSgpJn8+tyiCTEsCeNC/LqjFXWjg==
X-Received: by 2002:a17:902:c1c4:b0:1db:d4ea:35a3 with SMTP id
 c4-20020a170902c1c400b001dbd4ea35a3mr326162plc.10.1708168734122; 
 Sat, 17 Feb 2024 03:18:54 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 u20-20020a170903309400b001db4b376a01sm1265041plc.284.2024.02.17.03.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 03:18:53 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v11 0/6] ui/cocoa: Use NSWindow's ability to resize
Date: Sat, 17 Feb 2024 20:18:46 +0900
Message-Id: <20240217-cocoa-v11-0-0a17a7e534d4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABaW0GUC/2XNTWrDMBAF4KsErasyI1t/XfUeJQtZmmm0qBXsY
 hKC7x45IHDr5XvM9+YhZpoyzeLj9BATLXnOZawB8e0k4iWM3yRzqoVQoDpUiDKWWILU1gzOdJ7
 8kES9vU7E+fYa+jrXfMnzb5nur93FbO3/hcVIlL3nbiBAj6w+U7iP+fYey4/YJha7Z7YxW5kJr
 JDYauPgwNyeucacBJksh+QgWmJzYL6xHhR2jfmN6aAJB4beH78h7F3fHEKF0TKTTp7BhT9wXdc
 nI1CfcnoBAAA=
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
Changes in v11:
- Ensured to reflect screen size changes to bounds
- Link to v10: https://lore.kernel.org/r/20240214-cocoa-v10-0-c7ffe5d9f08a@daynix.com

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

 ui/cocoa.m | 533 +++++++++++++++++++++++++++++--------------------------------
 1 file changed, 250 insertions(+), 283 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231211-cocoa-576b8639e9bd

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


