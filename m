Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE3C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMn8M-0004D6-F4; Thu, 27 Jun 2024 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8K-0004Cp-9d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMn8I-0000Rv-Fs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 07:17:44 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6bce380eb9bso4722051a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 04:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719487061; x=1720091861;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iXcIgBgA0UJ6yrWDCCFqNE734EdF88Woj/W/UvPazNo=;
 b=q4s0OmEmzXbY5d7NFuYum+UnIKuTZbjabv9W73j9Zfn8a37qNypn7YPdntuov9vsIw
 SPeCEYT/mGTi7mofd4BWMveTsuKXNNiRg2s/Z9uzyVN4w+aWN6rwg/vnQyS8qyE10ovI
 H7aOM0FIQfPz+uSBIUdDo4MVV8K1WAkm0VjQaX+S6quF8ewQzvugKUTBz84kXJm4Cbo9
 aY6BLpGojum+bgoaYIl1+AUW7UADx84xVDU3DCiSKVIaa7tRKiXYTubCO0vNxi2MRKZ5
 RzOFiPS5bKXDwa25SHjO97zlm5EASIUQZVTn1+7TTyMH8iDU/CTVVOnmIkRVZ/UiQGX2
 88AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719487061; x=1720091861;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iXcIgBgA0UJ6yrWDCCFqNE734EdF88Woj/W/UvPazNo=;
 b=ACrlpZ6jixjvEYpKAVZnmn14p/9G4nhrpghkWatFWlK5MtXZssCdY2DYv0lko90mr1
 iJLqch+eqaWG7s2b+UkWraj0koLfVTK3k+26RXquMyCnxw1Y0JkB9aLcHc8Nr7+gfXAP
 XoYZMepW5pPZ5GJO+FiLeSijsf6IyU0mR1TLveyNsHVFG4RLTYNuzl9rwbap2Kyyv8TO
 PdyiU01t9wP/Lu1oBd2vINQzwJbtfMe1N6hLYkE3yf2Vc/7NqAcVCvrIj76ZOcvolpOG
 mtGGlOvcFP51O9DsPuICcH6aX8DORIyUaNtvwWaXixRdDGJtlatvvvOrnUtYlH7K6AFr
 xLfg==
X-Gm-Message-State: AOJu0Yzqe961BHxMkY7prptVJi85EBeJzl2s0A8WXvbSfZX785Vvdn2T
 lqCnPAHLb7ZDcRMYN9euyRLsdfVSc1GEN3WlA4MbmYucFBN+rHZGHz/m/eQbrwY=
X-Google-Smtp-Source: AGHT+IEMyFjBG4S6M0CGobNobDUuuYtQSCSb1n3hKon0+oodrOzjRBaIGxOpHKQMMC515+0oCWDiug==
X-Received: by 2002:a05:6a21:7881:b0:1be:d897:7982 with SMTP id
 adf61e73a8af0-1bed8977a19mr632799637.43.1719487060789; 
 Thu, 27 Jun 2024 04:17:40 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8fe8ac707sm1186734a91.9.2024.06.27.04.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 04:17:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/4] ui/cocoa: Add cursor composition
Date: Thu, 27 Jun 2024 20:17:32 +0900
Message-Id: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExKfWYC/2XMQQ7CIBCF4as0sxbDDLWiK+9huigU7SyEBpS0a
 bi72K3L/+Xl2yC5yC7BtdkgusyJg69BhwbsNPinEzzWBpLUSoVa2E9MIQrVXtCglt1JE9TzHN2
 Dlx2697UnTu8Q193N+Fv/iIxCCmmM66zSRHi+jcPqeTna8IK+lPIFnkM8D50AAAA=
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add accelerated cursor composition to ui/cocoa. This does not only
improve performance for display devices that exposes the capability to
the guest according to dpy_cursor_define_supported(), but fixes the
cursor display for devices that unconditionally expects the availability
of the capability (e.g., virtio-gpu).

The common pattern to implement accelerated cursor composition is to
replace the cursor and warp it so that the replaced cursor is shown at
the correct position on the guest display for relative pointer devices.
Unfortunately, ui/cocoa cannot do the same because warping the cursor
position interfers with the mouse input so it uses CALayer instead;
although it is not specialized for cursor composition, it still can
compose images with hardware acceleration.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Incorporated changes from:
  https://lore.kernel.org/r/20240625134931.92279-2-phil@philjordan.eu
  ("[PATCH v2 1/2] ui/cocoa: Minor fixes to CALayer based cursors")
- Added patch "ui/cocoa: Release CGColorSpace"
- Added patch "ui/console: Convert mouse visibility parameter into bool"
- Noted that the problem with warping is relevant only for relative
  pointer devices.
- Link to v1: https://lore.kernel.org/r/20240318-cursor-v1-0-0bbe6c382217@daynix.com

---
Akihiko Odaki (4):
      ui/cocoa: Release CGColorSpace
      ui/console: Convert mouse visibility parameter into bool
      ui/cocoa: Add cursor composition
      ui/console: Remove dpy_cursor_define_supported()

 meson.build             |   3 +-
 include/ui/console.h    |   5 +--
 hw/display/ati.c        |   2 +-
 hw/display/qxl-render.c |   4 --
 hw/display/virtio-gpu.c |   3 +-
 hw/display/vmware_vga.c |   8 ++--
 ui/console.c            |  18 ++-------
 ui/dbus-listener.c      |   2 +-
 ui/gtk.c                |   2 +-
 ui/sdl2.c               |   4 +-
 ui/spice-display.c      |  11 ++---
 ui/vnc.c                |   2 +-
 ui/cocoa.m              | 104 +++++++++++++++++++++++++++++++++++++++++++++++-
 13 files changed, 126 insertions(+), 42 deletions(-)
---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240318-cursor-3491b1806582

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


