Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C975EC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASC-0008Of-2p; Sun, 23 Feb 2025 06:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASA-0008O8-ND; Sun, 23 Feb 2025 06:47:22 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmAS8-0005v9-NV; Sun, 23 Feb 2025 06:47:22 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ded6c31344so4979450a12.1; 
 Sun, 23 Feb 2025 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311238; x=1740916038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tgSld8Qjv3h9JqKQUf+Zp1b7lgUyHl7hk037kh0cBVk=;
 b=m4ZMETY05028irDh5YyLO1M1jUD+L9HsPBwyYpjf0O7vArge2acW4hdm2JQl3wdADy
 OjwUM395eoE4ylHi3ng03Lju9KfB1n+ixDT+LED7I6ajxS06vN49V20ILamCFpzhyul0
 E/30ExWs5KF2+5UWo6qVz2FCBerqaRX6A/NBmwcmoC7MHxzAwCppha+T/FP9eTPVtq/d
 nSRFBR6xC42UfoH5K4w4dgPJJZQLgVXG65p+JzSm1hf3ZMwBGgF03mWa7a1Nc2FKUh5k
 2+1d1Y/v0GSM8cbjgB0wgGBxIw2kJzUiZNfUBZKtN05knFN8rg3P/m+CFB/i7rrsAr85
 Q2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311238; x=1740916038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgSld8Qjv3h9JqKQUf+Zp1b7lgUyHl7hk037kh0cBVk=;
 b=Y0mt22xHDF/DQ+qiHtlQbSjs4PAq5Z5sz4ZGbPT/2BvJU+ldBLovFjZHOVLN5O2nNI
 YNtipGrTtA93IWerZ08WjLPNHpRrpe6jgr/spWgzRYbKSBzQYESoq4wTMNABrYJvHAcH
 Cmv3/lMhaWADIb4uj+2NI9oDADWp2I6YY/gAp1E6X38PNQ4tNRwqyTCqObo1ZMop6rmm
 gwzrCdyqLvuhxyTQ/zdcyecoG83/H3EgCRB4b89GiCnltWvaiYksNC26czoSj5LBh6Ee
 E2RqJ9Ovbbh+0LIXyleFewBdrGdxBmxrhFL93kC9q7XDZ43I1MaoJtcKOHzJ8NbKuzmd
 1CNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrprm42kqupgAWOmYfT9XDH6p+FFI8OuH/JKBMmVwfiTRBWUv6clL/9jlnmbFhFx4p0XFqFhic0w==@nongnu.org
X-Gm-Message-State: AOJu0YyONWYgouIhKqIgVCKjNeo0Oj5guL3C7xTSjnsOpGJAujZWCKas
 hyDKGW8dFfHzGYrdP5B0RFZwU9+llR3KXChxnP/gd83c4UtqMl2bKfxRXA==
X-Gm-Gg: ASbGnctY84s2YqDbhYvQtvRX7a4rtvA6J7vtx1SR7Pcn9oSYkx0ZFqyfFY2PN878bLG
 fZRCQVQ55OKX+jYOHD94kSbuci1/KUx9C66jycnfrwSch4dnA/3PeX0e5a5Vs4kClGlU3BdUbns
 SZZfWQaghylNTDOCYENu5anHxsenU+2vl0KOvos2kwY8pw9HyOtSu8l2IxKZn6JsQ0A4PUkeYfn
 62xtYKBkbThaCHFTUgHOsGIXcATkOGG8GcwByZyKUJeRsD9SkoB16a6VORa79WAXgZy9OEJIC8V
 azuJkxVi5Z6Qv4QGmwfxmHzHx4qWeoW3YGuFUOu0Ba+ZygHKclVjhSCZ0tJ1tl3wbPkiixfpS5P
 Sk/VtEI5wNv1+
X-Google-Smtp-Source: AGHT+IEhh/xPlkrmBYDZZr133WBfa33BeCBec+O15IUvTSFw03EWWprGqRwKlZAu3YlMXJxMbMwCBQ==
X-Received: by 2002:a05:6402:540c:b0:5dc:74fd:abf1 with SMTP id
 4fb4d7f45d1cf-5e0b7107adbmr19801955a12.15.1740311237623; 
 Sun, 23 Feb 2025 03:47:17 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:17 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/18] Add i.MX 8M Plus EVK machine
Date: Sun, 23 Feb 2025 12:46:50 +0100
Message-ID: <20250223114708.1780-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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
U-Boot does not work yet. I plan to use this machine in CI and I also want =
to=0D
make it available to a bigger audience, so I propose to add it to QEMU. My =
goal=0D
would be to have it added for 10.0. For this, a Changelog entry could be ad=
ded=0D
under https://wiki.qemu.org/ChangeLog/10.0 such as:=0D
  * New board model "imx8mp-evk": i.MX 8M Plus Evaluation Kit=0D
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
v3:=0D
* Pick up R-b tags=0D
* Add QTest testcase for the RS5C372 RTC (Phil)=0D
* Rephrase machine description (Peter)=0D
* Fix typos and confused sentence in machine documentation (Peter)=0D
* Use g_autofree for object names (Peter)=0D
* Clarify source of "cntfrq" CPU property (Peter)=0D
* Fix typo "g[e]neral purpose timers" in commit message (Peter)=0D
* Don't `default y if I2C_DEVICES` for hw/gpio/pca955* (Peter)=0D
* TYPE_FSL_IMX8M_PCIE_PHY:=0D
  * Implement reset method (Peter)=0D
  * Use named constant rather than risking undefined behavior (Peter)=0D
* Fix copy'n'paste typo in imx8mp_analog.c=0D
Open questions:=0D
* How to generate all zero boot rom file in a portable way (Peter)=0D
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
  hw/arm/fsl-imx8mp: Implement general purpose timers=0D
  hw/arm/fsl-imx8mp: Add Ethernet controller=0D
  hw/arm/fsl-imx8mp: Add USB support=0D
  hw/arm/fsl-imx8mp: Add boot ROM=0D
  hw/arm/fsl-imx8mp: Add on-chip RAM=0D
  hw/rtc: Add Ricoh RS5C372 RTC emulation=0D
=0D
 MAINTAINERS                         |  16 +=0D
 docs/system/arm/imx8mp-evk.rst      |  70 +++=0D
 docs/system/target-arm.rst          |   1 +=0D
 include/hw/arm/fsl-imx8mp.h         | 285 +++++++++++=0D
 include/hw/misc/imx8mp_analog.h     |  81 +++=0D
 include/hw/misc/imx8mp_ccm.h        |  30 ++=0D
 include/hw/pci-host/designware.h    |   7 +=0D
 include/hw/pci-host/fsl_imx8m_phy.h |  28 ++=0D
 include/hw/timer/imx_gpt.h          |   1 +=0D
 include/hw/usb/hcd-dwc3.h           |   2 +-=0D
 hw/arm/fsl-imx8mp.c                 | 732 ++++++++++++++++++++++++++++=0D
 hw/arm/imx8mp-evk.c                 |  74 +++=0D
 hw/misc/imx8mp_analog.c             | 160 ++++++=0D
 hw/misc/imx8mp_ccm.c                | 175 +++++++=0D
 hw/pci-host/designware.c            |  18 +-=0D
 hw/pci-host/fsl_imx8m_phy.c         |  98 ++++=0D
 hw/rtc/rs5c372.c                    | 236 +++++++++=0D
 hw/timer/imx_gpt.c                  |  25 +=0D
 hw/usb/hcd-dwc3.c                   |   5 +=0D
 tests/qtest/rs5c372-test.c          |  43 ++=0D
 hw/arm/Kconfig                      |  24 +=0D
 hw/arm/meson.build                  |   2 +=0D
 hw/gpio/Kconfig                     |   8 +=0D
 hw/misc/Kconfig                     |  14 +-=0D
 hw/misc/meson.build                 |   2 +=0D
 hw/pci-host/Kconfig                 |   3 +=0D
 hw/pci-host/meson.build             |   1 +=0D
 hw/rtc/Kconfig                      |   5 +=0D
 hw/rtc/meson.build                  |   1 +=0D
 hw/rtc/trace-events                 |   4 +=0D
 pc-bios/imx8mp-boot.rom             | Bin 0 -> 258048 bytes=0D
 pc-bios/meson.build                 |   1 +=0D
 tests/qtest/meson.build             |   1 +=0D
 33 files changed, 2143 insertions(+), 10 deletions(-)=0D
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
 create mode 100644 tests/qtest/rs5c372-test.c=0D
 create mode 100644 pc-bios/imx8mp-boot.rom=0D
=0D
-- =0D
2.48.1=0D
=0D

