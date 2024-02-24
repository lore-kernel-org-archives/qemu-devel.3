Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5372C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNW-00023M-Ay; Sat, 24 Feb 2024 07:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNU-00022r-9p
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:40 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNS-0006iz-DX
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:40 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e43ee3f6fbso1503860b3a.3
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778616; x=1709383416;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CmAC7eTTvI3PfLipbSfRM377cTGrXFOp/fodQZ5ZMPM=;
 b=hAU3bWsDYW1SXof/+LHnOGKCY+3pRj8oIuU/zRBkEnTUGjDy/AX2GzLdM56xecyB87
 zbn/D8sX7nIOlZnjW+10U1HKqd1ZIo4vTCZEoVVTChu6vof722aI3I8skhhNt4vS9/m/
 0hu3FV49+Jvkmkmlw0LrKeBgT1MKKn3tG8e/dA2330F9PRXlOYUPUgbimA8lzITElMBN
 YBAT3sKdRq2osPtNE2mroCK2EkuGJBRAK1L169+Mlrkw4Jq7ZRA5gmGyeiw24lmoVSVQ
 3ulCqCMWnHcSpGkv/+ZO04CIbH9qF2w7VAHgVUrKSXV8FXHyFvAx1wyXyyA9NIAWCjwA
 xxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778616; x=1709383416;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CmAC7eTTvI3PfLipbSfRM377cTGrXFOp/fodQZ5ZMPM=;
 b=Fp7I+DMljj4gr9bFeUyiiymV9WJY9KWLGvYWG8/U26kO2icjy1grwzCvTSafs3Sosd
 +QJMB1jAXi8HiJRCRzR7LZXUtn4oNt6C6ASTttKqhEm2OwohmcELTbLto/KwaEN6cQ26
 2fWLu+3u4lz8lnqc5BEZo7b4SdTCw7O2VtHkFNwwGQv+B6UzG2aVV9wtdsCY1MxAkTaU
 u6gpp55URGr1tfI39dGsDiyHi2Phdv/XRvHDOFywnzZ6xL9vDt5eXfKr9ZkEwose9bgd
 yJbY0OsU3FV2ZcxrGMfCvo1zjU426FqdJ6YzAVex4JYxbUewLbKHvEZ1pqTMLxfwRE4d
 VGow==
X-Gm-Message-State: AOJu0YycJpWD+PruNiQcOZr0RpZ3v53QdatCkksW+UojFuALTWt0NUhe
 RviXl3EEfTy8YRNsxE7nl7okxR/SlATPruLxJzJhNnil6ANu4oX7DJFWAhmxUFE=
X-Google-Smtp-Source: AGHT+IFNcjqIQPjS+HB1iIJq71kYHykluq55bi/5H663T8vIwXYmgODq5eaAvPmCFKgiI2k7txIj8A==
X-Received: by 2002:a05:6a00:be5:b0:6e4:d1f9:ba35 with SMTP id
 x37-20020a056a000be500b006e4d1f9ba35mr2672672pfu.30.1708778616231; 
 Sat, 24 Feb 2024 04:43:36 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 j10-20020a63550a000000b005ceeeea1816sm1047222pgb.77.2024.02.24.04.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v12 00/10] ui/cocoa: Use NSWindow's ability to resize
Date: Sat, 24 Feb 2024 21:43:31 +0900
Message-Id: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPk2WUC/2XQzWrDMAwH8FcpPs/D8rd32nuUHhxbWn1YPJIRW
 krefU7BI1uOEvr9hfRgM04FZ/Z2erAJlzKXOrYC5MuJpWscP5CX3BpMCqlAAvBUU43cODt4qwK
 GIbM2+zUhldsz6Hxp9bXM33W6P3MXu3X/JyyWA9eB1IACApB8z/E+lttrqp9si1jcnrnOXGM2k
 gQkZ6wXB+b3zHfmueDZUcxeJIdkDyx0poUE1VnYmIkGYSChw3EbiL3T3YFoMDkiNDmQ8PEIYQ9
 /z2v/aTSCiw6N0ln/geu6/gChaQz4swEAAA==
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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
Changes in v12:
- Extracted patches "ui/cocoa: Split [-QemuCocoaView handleEventLocked:]",
  "ui/cocoa: Immediately call [-QemuCocoaView handleMouseEvent:buttons:]" from
  "ui/cocoa: Release specific mouse buttons". (Peter Maydell)
- Changed the message of patch "ui/cocoa: Call console_select() with the BQL" to
  refer to [-QemuCocoaView displayConsole:]. (Peter Maydell)
- Added patch "ui/cocoa: Fix pause label coordinates".
- Added patch "ui/cocoa: Remove normalWindow".
- Removed [-QemuCocoaView fixZoomedFullScreenSize:], which turned out
  unnecessary.
- Simplified references to NSWindow.styleMask.
- Link to v11: https://lore.kernel.org/r/20240217-cocoa-v11-0-0a17a7e534d4@daynix.com

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
Akihiko Odaki (10):
      ui/cocoa: Split [-QemuCocoaView handleEventLocked:]
      ui/cocoa: Immediately call [-QemuCocoaView handleMouseEvent:buttons:]
      ui/cocoa: Release specific mouse buttons
      ui/cocoa: Scale with NSView instead of Core Graphics
      ui/cocoa: Fix pause label coordinates
      ui/cocoa: Let the platform toggle fullscreen
      ui/cocoa: Remove normalWindow
      ui/cocoa: Make window resizable
      ui/cocoa: Call console_select() with the BQL
      ui/cocoa: Remove stretch_video flag

 ui/cocoa.m | 552 +++++++++++++++++++++++++++----------------------------------
 1 file changed, 242 insertions(+), 310 deletions(-)
---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231211-cocoa-576b8639e9bd

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


