Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C4D1D460
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr5z-00075I-8g; Thu, 08 Jan 2026 09:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5p-00070q-N1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:30 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5n-0000gB-4v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:29 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d3ffb0f44so21688975e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882865; x=1768487665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LK1fJuDCyZ+JCIQVkUbdv1IIkYo19dcsZFbtPtQwA4o=;
 b=LD/0f++ohkwH7/4s0EdsB1GxqYY2/8C6HENzxrh1AGSoebdzIIXENjjhF1qr4780Xu
 OahAnTFrMb7gddaOElTF8lUMiaE3kzn8tvGkxr2X933vnF1LOpD0Ks9sIPcYxhIbUEqx
 Ecj9krFM5XC7rLaXskCkACW1V8nlWzsHj4wWExAM50IUvcHPlRnDsP3ldTkYzxXFkrzO
 FqCDFEYdiWIDzjxQJvAK5yHbxRJu8hkIVx49vDsyCqasEH8h6iDSq9BeSINxZ/lEluF+
 9yeKa+GlyzB1dg7eK6amdzG08Dx3VGqQd5fSazcvS50sH6s5KurgNYv8RGlslDKonxzL
 D9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882865; x=1768487665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LK1fJuDCyZ+JCIQVkUbdv1IIkYo19dcsZFbtPtQwA4o=;
 b=kiLXJAkFyLpOXUrFYySqxuVP5x242/FZr3UCKbvVKe+cZZxQmp7/WNE681DKSOmRvv
 KxaVRlWlK7l5sN2kpcX2l0G75DaWh9fQXb110gtbyou84HNf2svK9TxMx0smBT97Pab1
 UNa8d6D6FeG+4kUjtRaQRfblCvx/yG9pNOQ+zo7hdXHKK/NAwE65CJS9kCYuTX0Da76o
 StpMAmydbgHJe8wsF4l8PgMTAD/1TZj4u0b1KQ+yCblM+CfgmTD/qEcAkVlxjupXX23v
 tgT9K9SgpBVD7Vad+pX2H+3CZW3nCNAKQZXkUU86crdviYzD17KRHgAYP2UR26aiV3FR
 1qDQ==
X-Gm-Message-State: AOJu0YwjFJwVP/AMRp0OIsXjiyhx+hdrgLdj9w1pacpnXT53h4dNr6Eg
 cMAHuBhGcKQV0qml00Fz2ahki2UmHUGOCCLHxwfpknCZxQTSC/w/6RGjDFBC1RCspJk=
X-Gm-Gg: AY/fxX6dHntECLhddJ/y9wS0q4zhoLhuUCOSpOYppM9pwzaQSdeyiKJupxNGyLMAqPK
 i5+E21w67PDsraN4Rzm/NuIwwGfcR4Sk/3Wq+JTX0k8Dv1KlbBP++GTUUXmRTQHu9aeTWiWth6u
 F6q84C0TT26jxELKI1ZKTukUHhZFGXZGTwUB9SNDfDYiwFvXsXsFWcFawuCg/o7W+wnON38G5pO
 G1HA0T+s0vx+RmixFz3dAp7/SIRgNlBeSXsos11KC4MDht2RlR5numA/GR4BLj618DQk+3qiQwy
 0q2CPU4hLf1qbnFk+AsNWeaLFCzUI7Y9ODrK88OkyVf5Qm2D1zPng2Dlxq/z9W2hUzf9EqQWcfc
 on6B4n1fXZAUjoCOfhevrbR9VA8GEw/begStdVr5ctrd9flLmtuPVjQ0bEsT2DLZeavPDmXDGXI
 OTzSL/FIiCi+M=
X-Google-Smtp-Source: AGHT+IE8oxPQ6D33yNKb1TeAnSpxaYwtuXGYdFLJ1fY2IJ8jUdCoraYWUbvc8DZlzRCxkzt+pJ80mg==
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47d84b3baa1mr58498795e9.20.1767882865206; 
 Thu, 08 Jan 2026 06:34:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7053f5sm151990255e9.14.2026.01.08.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D89B35F804;
 Thu, 08 Jan 2026 14:34:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 00/12] cpu_reset clean-ups for arm, sh4, mips,
 m68k and tricore
Date: Thu,  8 Jan 2026 14:34:11 +0000
Message-ID: <20260108143423.1378674-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We tend to apply cpu_reset inconsistently throughout our various
models which leads to unintended ordering dependencies. This got in
the way in my last plugins series:

  https://patchew.org/QEMU/20251219190849.238323-1-alex.bennee@linaro.org/

where I needed to shuffle things around to ensure that gdb register
creation was done after dependant peripherals had created their cpu
interfaces.

Regardless of that we do have a proper reset interface now and most
architectures have moved to it. This series attempts to clean-up the
remaining cases with proper qemu_register_reset() calls so reset is
called when we intend to.

Alex.

Alex Bennée (12):
  target/sh4: drop cpu_reset from realizefn
  target/m68k: introduce env->reset_pc
  hw/m68k: register a nextcube_cpu_reset handler
  hw/m68k: register a mcf5208evb_cpu_reset handler
  hw/m68k: register a an5206_cpu_reset handler
  hw/m68k: just use reset_pc for virt platform
  target/m68k: drop cpu_reset on realizefn
  hw/mips: defer finalising gcr_base until reset time
  hw/mips: drop cpu_reset in mips_cpu_realizefn
  target/tricore: move cpu_reset from tricore_cpu_realizefn
  target/arm: remove extraneous cpu_reset from realizefn
  include/hw: expand cpu_reset function docs

 include/hw/core/cpu.h |  3 +++
 target/m68k/cpu.h     |  1 +
 hw/m68k/an5206.c      | 24 +++++++++++++++++-------
 hw/m68k/mcf5208.c     | 25 +++++++++++++++++++------
 hw/m68k/next-cube.c   | 23 +++++++++++++++++------
 hw/m68k/virt.c        | 24 +++++++-----------------
 hw/mips/cps.c         | 22 +++++++++++++---------
 hw/misc/mips_cmgcr.c  |  1 -
 target/arm/cpu.c      |  1 -
 target/m68k/cpu.c     |  1 -
 target/mips/cpu.c     |  1 -
 target/sh4/cpu.c      |  1 -
 target/tricore/cpu.c  |  9 ++++++++-
 13 files changed, 85 insertions(+), 51 deletions(-)

-- 
2.47.3


