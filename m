Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD08C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTEDv-0001aI-Ut; Mon, 15 Jul 2024 01:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEDt-0001SC-Ut
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:05 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTEDr-0000c6-6S
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:26:05 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3856b7be480so14317845ab.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721021162; x=1721625962;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iHuyZlhpKJ1Dkt9TX+IwKytrXQTRTNvimOeb8QrdFW0=;
 b=rvra3sxiby9c5cp3tTnp6w7zgkO0lxxkDlgTmE4jiW7FlVYV3zrNC6YnoQggqv6O+x
 Nq5sqtbcXF9Lg5fvIDbBKi0/ERjgWHaojaOCO1Omxm4164FZZTSgSbSpD2xnqfNUkJAI
 0TxAWYl073JgK63uVy87cHFygC2WQQl7lkjKMsj12kjSPL10jLqcSrU3b54Irh+jq4g4
 Dn8iEKIA0wOA0ArR+forr8UxijEW/EQh5C3Axa7m9afE1lohf5v/mGIvYGMrDG3ppOEr
 G1vGAu71PhNChqUaaeX/stlNXxSL1Z5iw1SR0RFXxnJYsJg8Sn6BlVlL/Yn1/C8KLOYT
 jemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721021162; x=1721625962;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHuyZlhpKJ1Dkt9TX+IwKytrXQTRTNvimOeb8QrdFW0=;
 b=iBu5o6eqEV9qeS6VubTWe0mMQA0Bys1DgHcObnrqDHpLe/ARLlUEmkfzlWeufPnsUV
 XxwiaZPEcRKFpIyDDJVGtUDOetPsJTAP+w2RXcJtqyegaNYpzwsKu9YMB5E1E2znsska
 bmiy9QLiVV9hHHLlLPaeHU8r4su4ZaKna7Z0q6FuwMpC5OZngmKGMRRhamvt0WqYDuQi
 A6SNCNrlIHcVr2bQuqwPrk4D78DwAHSIeGvna/RSW+xFFb6jsvMOTva4rwTURZEqaZxu
 S9Wo1lueNu0LLDG3bzU0Fv7xSGD2Hc9VJQj8eG6CpdI+TVl2f/ofqHOVdCut76UioWsB
 8rwQ==
X-Gm-Message-State: AOJu0YzYBZt+NEnrKR1W9HmtWYWiQqh5whUFI2L4ROEXaV9FqhZJBo4+
 V9cgAlFZSkB/vFfQlMhvFG6z7ZwGuaFZNMET3Q78SebBmZHf8mFR8dELmVlPnhk=
X-Google-Smtp-Source: AGHT+IGSxM75DG6UjOxBq3kS94RHM8LonRuReIQC3M64tHFRB/AqbJcJh62W6aPFa8CONTWgs/gIFA==
X-Received: by 2002:a05:6e02:170c:b0:375:ab93:5062 with SMTP id
 e9e14a558f8ab-38a57117d80mr252554035ab.2.1721021160855; 
 Sun, 14 Jul 2024 22:26:00 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ecd26acsm3405261b3a.217.2024.07.14.22.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:26:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/4] ui/cocoa: Add cursor composition
Date: Mon, 15 Jul 2024 14:25:41 +0900
Message-Id: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANaylGYC/2WMQQ6CMBBFr0JmbU07A6W68h7GBZRRupCaVhsI4
 e4WFhrj8v3892aIHBxHOBYzBE4uOj9koF0Btm+GGwvXZQaUWEpSRthXiD4IKg+qVUbqyiDk8yP
 w1Y1b6HzJ3Lv49GHaukmt618iKSGFbFvWlgyiqk9dMw1u3Ft/h7WR8OtprD8eZs+S7YiZKq30j
 7csyxuTe/pJ1QAAAA==
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
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x131.google.com
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
Changes in v3:
- Incorporated changes from:
  "[PATCH v3 1/4] ui/cocoa: Typo fix in based-on patches"
- Link to v2: https://lore.kernel.org/r/20240627-cursor-v2-0-c3cd3ee35616@daynix.com

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


