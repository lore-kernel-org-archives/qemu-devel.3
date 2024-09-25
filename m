Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAF8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 12:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stRZu-0006XL-ES; Wed, 25 Sep 2024 08:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1stRZm-00065A-4j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:57:02 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1stRZk-000871-1r
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 08:57:01 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53659867cbdso9941145e87.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269017; x=1727873817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBhqg6rrOsSPl3tFjeJPPeRGg22MQOEOeY4bFAHpkXQ=;
 b=bCYi56MqhCkeQyMBFvPSokobpnjRpBB0+BcGr5NzNiV+/tXl7H6HWCaElLTJWM7/SH
 j4wz26rZmMyEYoSktFbEH/npoVNKC8/V815zmXhO1vKpqeo4eMqaKiY3urgrOL1+Vzmu
 VBQcXSR7FxUKbpXPh/eAlLIp08+pIKA1uU4Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269017; x=1727873817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBhqg6rrOsSPl3tFjeJPPeRGg22MQOEOeY4bFAHpkXQ=;
 b=g2E99sUWNUnvi3b0dmyg74i9XOS65kluitZzqJGl0yVFrbS6HHGdK1DfZMlIhYjwaV
 kCuTof2x+If0DgP41kThQOWXBvIo3z5h8LfNmnJBaLZeIaDetjUs7O7ayZy43kEwa7v4
 iFZoGStIamQO0TqVJxCBPN+RcVPJCWabVBSwiaQw0wt3KW1Mx3gLcuU5X6aRyXJ1UC8D
 q3v+5bzWj6cjokpBZHT7asHOe9r9KkRw6gBvaltJcKNR2NJVbXtECzh+6dwvIbAqrH3T
 a8W4jkbdzKjaDBjmgKmZJb2N3hvvEOpLtpmI5rB+agHvGidPuKoAQa/hLeGOliQfgdHF
 eX/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5uqKZschdRUWbbkNGLTocAuG5iD69MmlbK5+tWnjCD93kn/LBuViO391VBFoaIp7kBq0r+GFy96KR@nongnu.org
X-Gm-Message-State: AOJu0YxDIuTvqZCoKnSMawnOqRa4ItDCHusLpOwvm1Rt3SO+LLyCa6Ms
 AC7MyZpj0qaxSV4FB/cGZ9Z4xhUKaQ50lt/N7QWjjjzcLaSH9IrWPm2/V2699A==
X-Google-Smtp-Source: AGHT+IFTgBKVQB2+Svfj82U46KunEpR9r22frwRpvBYIrZ1uRKoqgci8MINhw04VSUq3w6mrtcnWKQ==
X-Received: by 2002:a05:6512:138d:b0:536:5339:35a6 with SMTP id
 2adb3069b0e04-5387756657emr1974019e87.53.1727269017147; 
 Wed, 25 Sep 2024 05:56:57 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:56:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 00/19] spl: Support a relocating jump between phases (VBE part
 F)
Date: Wed, 25 Sep 2024 14:55:26 +0200
Message-ID: <20240925125622.197915-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=sjg@chromium.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


This series includes a way to deal with multiple XPL phases being
built to run from the same region of SRAM. This is useful because it may
not be possible to fit all the different phases in different parts of
the SRAM. Also it is a pain to have to build them with different values
for CONFIG_TEXT_BASE such that they can be loaded at different
addresses.

The mechanism is to copy some relocation code to the top of memory, then
load the next phase below that. Finally, the first phase jumps to the
relocation code, which copies or decompresses the next phase,
overwriting the first phase in the process. Finally, the relocation code
jumps to the start of the next phase.

In this way the maximum amount of space can be used, particular if the
next phase is compressed.

For this to work, some code in U-Boot must be placed in a 'rcode'
(relocation code) section. This ensures it can be copied as a block,
thus reducing the amount of the first-stage code which needs to survive
the relocation process.

For now there is a qemu-arm64 test for this feature, which ensures that
the basic mechanism is sound. Further work will likely expand this test
to include VPL and LZ4-compression, which so far have only been used on
real hardware.

Overall, without SPL_RELOC_LOADER enabled, this series provides a very
small code-size benefit due to it dropping some unneeded symbols.


Simon Glass (19):
  spl: Reduce the size of the bl_len field
  spl: Provide a way of indicating the phase to load
  spl: Avoid including hash algorithms which are not wanted
  spl: Provide a way to mark code needed for relocation
  lib: Mark crc8 as relocation code
  lib: Mark lz4 as relocation code
  lib: Mark memcpy() and memmove() as relocation code
  spl: Add a type for the jumper function
  spl: Add support for a relocating jump to the next phase
  spl: Plumb in the relocating loader
  spl: Support jumping to VPL from TPL
  spl: Record the correct name of the next phase
  spl: Show how to fill in the size of the next image
  spl: Add debugging in spl_set_header_raw_uboot()
  arm: qemu: Allow SPL and TPL
  arm: Add a new qemu_arm64_tpl board
  arm: Provide an rcode section in ARMv8 link script
  arm: qemu_arm64_tpl: Enable the relocating loader
  CI: Add new test for reloc loader

 .azure-pipelines.yml                  |   3 +
 .gitlab-ci.yml                        |   6 +
 MAINTAINERS                           |   6 +
 arch/arm/Kconfig                      |   2 +
 arch/arm/cpu/armv8/u-boot-spl.lds     |   8 ++
 arch/arm/dts/qemu-arm64.dts           |  17 +++
 arch/arm/mach-qemu/Kconfig            |  20 +++
 board/emulation/qemu-arm/Kconfig      |   2 +-
 board/emulation/qemu-arm/MAINTAINERS  |   5 +
 board/emulation/qemu-arm/Makefile     |   1 +
 board/emulation/qemu-arm/qemu-arm.env |   4 +
 board/emulation/qemu-arm/xpl.c        |  50 +++++++
 common/spl/Kconfig                    |   9 ++
 common/spl/Kconfig.tpl                |   9 ++
 common/spl/Kconfig.vpl                |   8 ++
 common/spl/Makefile                   |   1 +
 common/spl/spl.c                      |  45 +++++--
 common/spl/spl_reloc.c                | 182 ++++++++++++++++++++++++++
 configs/qemu_arm64_tpl_defconfig      |  83 ++++++++++++
 doc/develop/spl.rst                   |  35 +++++
 include/asm-generic/sections.h        |  16 +++
 include/spl.h                         |  57 +++++++-
 lib/Makefile                          |   6 +-
 lib/crc8.c                            |   5 +-
 lib/lz4.c                             |  27 ++--
 lib/lz4_wrapper.c                     |   2 +-
 lib/string.c                          |   5 +-
 test/py/tests/test_reloc.py           |  21 +++
 28 files changed, 604 insertions(+), 31 deletions(-)
 create mode 100644 board/emulation/qemu-arm/xpl.c
 create mode 100644 common/spl/spl_reloc.c
 create mode 100644 configs/qemu_arm64_tpl_defconfig
 create mode 100644 test/py/tests/test_reloc.py

-- 
2.43.0


