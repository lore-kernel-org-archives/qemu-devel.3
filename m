Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45331C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7Y-0004hX-1a; Tue, 04 Feb 2025 04:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7W-0004gV-6h; Tue, 04 Feb 2025 04:21:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7T-00052B-Q4; Tue, 04 Feb 2025 04:21:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43626213fffso39034305e9.1; 
 Tue, 04 Feb 2025 01:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660881; x=1739265681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vG2zeYlx21p1/xmxRjUnwQ71OyTX+iR75azfeATRfxI=;
 b=dkRHXBbAzbg2azwjp7dof6U8oltuncm5mavHSO+YQuI+85SgNWpwEd0+pxaDgaCRCV
 sC8phhaNHT76eTkSPxOI9+/rBunDYwpEl5/CXxX5pTw0vbSSOLPEMJ8hHL4eGx+Vb3FM
 irZVDZ+7i/z664dt2wduKa89l4bNytvI5zvYrPoz9TBDX+d1O4Od5X7rAelTMtjeS1GF
 NSYZ+4O4Eez5rxUyzuWV7L5a0f4edGcNlMUwU6+KF71WP8H2cNhfnVJRvn4YpJ9O6ZS4
 Bj8HaJNV3/kPxbnluZ0qnqdqkrBp1Q7HEs8Rz6/UUtDPwS/BANdMVz/7B9ZShOv1OTDU
 XKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660881; x=1739265681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vG2zeYlx21p1/xmxRjUnwQ71OyTX+iR75azfeATRfxI=;
 b=QE5dL88BRzsQZbUk9ymKgFnnxKykz91R2FcdYEPIadeay43hhyOSMyj7Vzqwp/o3am
 orNLNBwR1STc7pCwREyaNCGZTGVm5v0a0ckqyj4qNdP5i9iWZnfv9pPIYIe24m9z++Ux
 URZCTjfgJ1tDyr6bWq09mFMDgVuBlccTJq6Ib7QwV8gcd+NWV3rWVljZg9BMJhLU/W9c
 1ldQDnpO86Jw1HzBW/qebyx+AeV0fDE5EoUCJmD6/GlJcIV11YfRpqjI0sau9akaJph6
 U1miZrXJc11l4+AP0dqdn8XE240CC/8/njpmwXGcGWxnOiSnsw1xnbXqBJCse94Xl4Qq
 0BoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwpVfWHuWmsigMzRGl+PIhvh0l8OaLY6talLwfW5wmjjU6TEJDtwGuGhXom32M14VVkI7HTVZLgg==@nongnu.org
X-Gm-Message-State: AOJu0YwNq3xRgqJ9Wn8MderaOyQnkl5MevnlJxBk8yUH7GlNJUaIbW0z
 6YfHfbvk/jyAEbBq14B5wyGIqJr770OfxaCAYl9TmeG+aVR33HLlXfaE4g==
X-Gm-Gg: ASbGncsz3tCWnvwWAjljPpUjrj/3pnPvTLIkkoRY4gJZOeJ7Ee03MvqjHVjRWlcttjZ
 45fGRohn0qtpUCy8My9XyRv5E/0smWmmESICDgTEYxzxwR78ir0G9RMGlax07c/Gwy6xSFR653f
 7hbRcFLjK+uGTIuGI5EVk3HsBwCI3bnXXUOgrko4abzpNqf2d0/evFrUec6Tm39mmel8b/o2ZRj
 4koA0zveNNA7/DsoGjsu0s9IWIuh7Cj9/LxP7/0gPnZThMktsAP5AiqPZHxykNNKWMeREqZF0v3
 EcOkLuX0iYpEn19Pf2dIxCeONAjuFpgbM2ho+UoJny0BrcNveoIu3V+5boyphAj0VMIw3/UfcgS
 jCB+30rWaqg==
X-Google-Smtp-Source: AGHT+IHHl43hJleVFSUDDYPobfQX6fJ8JWlWa8FnsebsJA37MVlsGMR60OBVnNQ3A4WdRbir/IH3Ew==
X-Received: by 2002:a05:600c:4286:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-43905f782a9mr17459505e9.9.1738660880658; 
 Tue, 04 Feb 2025 01:21:20 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:20 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 00/18] Add i.MX 8M Plus EVK machine
Date: Tue,  4 Feb 2025 10:20:54 +0100
Message-ID: <20250204092112.26957-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series adds a new aarch64 machine to QEMU: i.MX 8M Plus EVK [1]. It al=
lows=0D
for running Linux distributions such as Buildroot=0D
(freescale_imx8mpevk_defconfig) and Arch Linux [2] via direct kernel boot.=
=0D
U-Boot does not work yet. I plan to use this machine myself and I also want=
 to=0D
make it available to a bigger audience, so I propose to add it to QEMU. My =
goal=0D
would be to have it added for 10.0.=0D
=0D
The series is structured as follows: The first three patches fix some issue=
s in=0D
device models reused by the new machine. Patches 4-17 add the machine step =
by=0D
step which includes documentation. The last patch adds an I=C2=B2C RTC whic=
h I'd like=0D
to use along with the new machine.=0D
=0D
I've based some code on existing one (see "Based on" in file headers) and I=
'm=0D
unsure how to handle the licensing and attribution correctly -- advice welc=
ome.=0D
=0D
v2:=0D
* Rebase onto master, eliminating some patches from the series=0D
* Initialize ROM with memory_region_init_rom() (Zoltan)=0D
* Mark the machine as "Maintained" (Peter)=0D
* Do not select TEST_DEVICES (Peter)=0D
* Have separate sources for the two clock tree modules (Peter)=0D
* Make PCI devices attach to the correct bus (Peter)=0D
* Avoid adding documentation that is removed later (Zoltan) Instead, docume=
nt=0D
  Buildroot process in the first place and change it slightly.=0D
* Drop TCA6416 device model (Phil, Dmitrii)=0D
* Add pca955* Kconfig cleanup patch=0D
=0D
[1] https://www.nxp.com/design/design-center/development-boards-and-designs=
/8MPLUSLPD4-EVK=0D
[2] https://archlinuxarm.org/platforms/armv8/generic=0D
=0D
Bernhard Beschow (18):=0D
  hw/usb/hcd-dwc3: Align global registers size with Linux=0D
  hw/pci-host/designware: Prevent device attachment on internal PCIe=0D
    root bus=0D
  hw/gpio/pca955*: Move Kconfig switches next to implementations=0D
  hw/arm: Add i.MX 8M Plus EVK board=0D
  hw/arm/fsl-imx8mp: Implement clock tree=0D
  hw/arm/fsl-imx8mp: Add SNVS=0D
  hw/arm/fsl-imx8mp: Add USDHC storage controllers=0D
  hw/arm/fsl-imx8mp: Add PCIe support=0D
  hw/arm/fsl-imx8mp: Add GPIO controllers=0D
  hw/arm/fsl-imx8mp: Add I2C controllers=0D
  hw/arm/fsl-imx8mp: Add SPI controllers=0D
  hw/arm/fsl-imx8mp: Add watchdog support=0D
  hw/arm/fsl-imx8mp: Implement gneral purpose timers=0D
  hw/arm/fsl-imx8mp: Add Ethernet controller=0D
  hw/arm/fsl-imx8mp: Add USB support=0D
  hw/arm/fsl-imx8mp: Add boot ROM=0D
  hw/arm/fsl-imx8mp: Add on-chip RAM=0D
  hw/rtc: Add Ricoh RS5C372 RTC emulation=0D
=0D
 MAINTAINERS                         |  15 +=0D
 docs/system/arm/imx8mp-evk.rst      |  72 +++=0D
 docs/system/target-arm.rst          |   1 +=0D
 include/hw/arm/fsl-imx8mp.h         | 285 +++++++++++=0D
 include/hw/misc/imx8mp_analog.h     |  81 +++=0D
 include/hw/misc/imx8mp_ccm.h        |  30 ++=0D
 include/hw/pci-host/designware.h    |   7 +=0D
 include/hw/pci-host/fsl_imx8m_phy.h |  27 +=0D
 include/hw/timer/imx_gpt.h          |   1 +=0D
 include/hw/usb/hcd-dwc3.h           |   2 +-=0D
 hw/arm/fsl-imx8mp.c                 | 736 ++++++++++++++++++++++++++++=0D
 hw/arm/imx8mp-evk.c                 |  74 +++=0D
 hw/misc/imx8mp_analog.c             | 160 ++++++=0D
 hw/misc/imx8mp_ccm.c                | 175 +++++++=0D
 hw/pci-host/designware.c            |  18 +-=0D
 hw/pci-host/fsl_imx8m_phy.c         |  88 ++++=0D
 hw/rtc/rs5c372.c                    | 227 +++++++++=0D
 hw/timer/imx_gpt.c                  |  25 +=0D
 hw/usb/hcd-dwc3.c                   |   5 +=0D
 hw/arm/Kconfig                      |  24 +=0D
 hw/arm/meson.build                  |   2 +=0D
 hw/gpio/Kconfig                     |  10 +=0D
 hw/misc/Kconfig                     |  14 +-=0D
 hw/misc/meson.build                 |   2 +=0D
 hw/pci-host/Kconfig                 |   3 +=0D
 hw/pci-host/meson.build             |   1 +=0D
 hw/rtc/Kconfig                      |   5 +=0D
 hw/rtc/meson.build                  |   1 +=0D
 hw/rtc/trace-events                 |   4 +=0D
 pc-bios/imx8mp-boot.rom             | Bin 0 -> 258048 bytes=0D
 pc-bios/meson.build                 |   1 +=0D
 31 files changed, 2086 insertions(+), 10 deletions(-)=0D
 create mode 100644 docs/system/arm/imx8mp-evk.rst=0D
 create mode 100644 include/hw/arm/fsl-imx8mp.h=0D
 create mode 100644 include/hw/misc/imx8mp_analog.h=0D
 create mode 100644 include/hw/misc/imx8mp_ccm.h=0D
 create mode 100644 include/hw/pci-host/fsl_imx8m_phy.h=0D
 create mode 100644 hw/arm/fsl-imx8mp.c=0D
 create mode 100644 hw/arm/imx8mp-evk.c=0D
 create mode 100644 hw/misc/imx8mp_analog.c=0D
 create mode 100644 hw/misc/imx8mp_ccm.c=0D
 create mode 100644 hw/pci-host/fsl_imx8m_phy.c=0D
 create mode 100644 hw/rtc/rs5c372.c=0D
 create mode 100644 pc-bios/imx8mp-boot.rom=0D
=0D
-- =0D
2.48.1=0D
=0D

