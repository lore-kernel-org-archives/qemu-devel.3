Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E93DC3ABA0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyCf-000603-UW; Fri, 31 Jan 2025 16:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCc-0005zo-Tx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCa-0007m4-SF
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so24217155e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357522; x=1738962322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t85JfzSySsJNmkSw200IIYELaXWv/XR2Cy20L4r7KeU=;
 b=AGSYCBnfmVVUG4ltfR6melTWifcQ6HCHdIgAozgvctbFIaGFRFNPrdxelWLx0sQteU
 1C4xl51H3Wlugz3lpev1TwBAiFCc74kCmGIBZGfnAbFaRO3wfZf/XEXfGWAl5p3hP3Nj
 CMJact0tF/5TNI+wIlYUQPGaI103OJuzWWFfGbuiBlUFCUN/rIrHWZ2T+H+Iq42GfhIV
 xGPrVxSZqFpqQX5JC43aWq7KbhgF7RVQVgncranJs/XjB6/a0aoSyKsjTlICb9f7kliO
 1NZgI+nIqneFUi6d2KlVheMlkNkRtsGvGuHAClR2AB04Mhgk08ZOmKgv3HL5sr48FiJZ
 moOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357522; x=1738962322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t85JfzSySsJNmkSw200IIYELaXWv/XR2Cy20L4r7KeU=;
 b=A7ZCffu/MiXa1gfKv/YsNwGjuvGguGCHTevQdnCtsQlTAOOfHmURNDIGqEEooG09lh
 lkUwFInqFMigCUJfod16btKFNB1w1ReCvZsh5smXMiIN8axSAirZY9ewgVSqi8YkzeWi
 yZ0yCVoCPE92mUkSDGqMhKyRh79EIK9sLSewLk2MvTxZfh2biKEF8VDdi4R1wF18i5QI
 VKBXRNhucPMpbSWbvxZPejPreMsv2RlH0soFAtleBx2W7sb/AmKiUNcSmI94Kk1BpazZ
 vI8XWu42tT7ArJV9qb/MCm8es4QYD0apgEkSTpND6uwQmqcq/YPuL0M9bySTT67xO5NZ
 GrAg==
X-Gm-Message-State: AOJu0YyGssydASntvxc7UXxFMBdQoVbJ34IpwtHezmWgg046G9WOBf1E
 JpuJLBTV8sMdb98m1oX599YXCgCHmRb1t1G+FcphwUeeJAjMVGzJcRB0SFgspzFIL1D+iDdr7Xs
 Oolk=
X-Gm-Gg: ASbGnctBU+MKG9wUT0cna96pa2rwWYxDgiq+ZpUbqFWVRuy51+r+zmV4PDuvPapZVHP
 X243QUNDZKpgkpVdMGIY3qkMufGPB9bLWzX210ZkohhDHdpwmpyZDaNdkkckd6/Bd4t/viK4DGn
 D2VbmyjpDiYWOUX3UWU8aWIR1u0VSu0Vhn4jZ8gwo58M4ZKoBOlrLyIPwIpuRgYeDJeHVgvrVDm
 TygYeGd02KCfUNcl6JiPMG1H9c2x24fhtWYyXzmPH0NZf66VjmYBzWjGAOW4kuvTM062cPgDIe2
 tOcf3b7AR4dOxyKQaAmW+I0PDw+3DdCBeHYOw1yZrXF7TmnjjPQgBMlY4Cd7TlSo0w==
X-Google-Smtp-Source: AGHT+IEtq5MYKQbjn884t28dXVAJIQaNFfdQJ33OMDWpCfiqVGXoruPYgTkxwUhRHjF1ZozPXr3k2g==
X-Received: by 2002:a05:600c:6c44:b0:436:fb02:e90 with SMTP id
 5b1f17b1804b1-438dc48aa14mr128845825e9.10.1738357522473; 
 Fri, 31 Jan 2025 13:05:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23e5e53sm65665165e9.17.2025.01.31.13.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/36] Misc HW patches for 2025-01-31
Date: Fri, 31 Jan 2025 22:04:43 +0100
Message-ID: <20250131210520.85874-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 871af84dd599fab68c8ed414d9ecbdb2bcfc5801:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-01-29 09:51:03 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250131

for you to fetch changes up to aa0cbf85f3f0b949f61e7aead9902fb6eaee29a8:

  hw/sd: Remove unused SDState::enable (2025-01-31 19:36:44 +0100)

----------------------------------------------------------------
Misc HW patches

- Remove uses of &first_cpu in rx-gdbsim and loongson3_virt machines (Philippe)
- Convert few legacy qemu_allocate_irqs to qemu_init_irqs (Philippe)
- Add tracing events in i2c-echo device (Titus)
- Fix debug format string in USB EHCI (Zoltan)
- Rework loader API to remove its target_words_bigendian() call (Philippe)
- QOMify OMAP MMC device (Peter)
- Remove legacy SD Card APIs (Peter)

----------------------------------------------------------------

BALATON Zoltan (1):
  hw/usb/hcd-ehci: Fix debug printf format string

Peter Maydell (11):
  hw/sd/omap_mmc: Do a minimal conversion to QDev
  hw/sd/omap_mmc: Convert remaining 'struct omap_mmc_s' uses to
    OMAPMMCState
  hw/sd/omap_mmc: Convert output qemu_irqs to gpio and sysbus IRQ APIs
  hw/sd/omap_mmc: Convert to SDBus API
  hw/sd/omap_mmc: Use similar API for "wire up omap_clk" to other OMAP
    devices
  hw/arm/omap1: Inline creation of MMC
  hw/sd/omap_mmc: Remove unused coverswitch qemu_irq
  hw/sd/omap_mmc: Untabify
  hw/sd: Remove unused 'enable' method from SDCardClass
  hw/sd: Remove unused legacy functions, stop killing mammoths
  hw/sd: Remove unused SDState::enable

Philippe Mathieu-Daudé (23):
  hw/rx/rx-gdbsim: Remove unnecessary uses of &first_cpu
  hw/mips/loongson3_virt: Factor generic_cpu_reset() out
  hw/mips/loongson3_virt: Invert vCPU creation order to remove
    &first_cpu
  hw/mips/loongson3_virt: Have fw_conf_init() access local loaderparams
  hw/mips/loongson3_virt: Pass CPU argument to get_cpu_freq_hz()
  hw/mips/loongson3_bootp: Include missing headers
  hw/mips/loongson3: Propagate cpu_count to init_loongson_params()
  hw/mips/loongson3_virt: Propagate cpu_count to init_boot_param()
  hw/mips/loongson3_bootp: Propagate processor_id to init_cpu_info()
  hw/mips/loongson3_virt: Propagate processor_id to
    init_loongson_params()
  hw/mips/loongson3_virt: Propagate %processor_id to init_boot_param()
  hw/mips/loongson3_bootp: Move to common_ss[]
  hw/irq: Introduce qemu_init_irqs() helper
  hw/ipack: Clarify KConfig symbols
  hw/ipack: Remove legacy qemu_allocate_irqs() use
  hw/sh4/r2d: Convert legacy qemu_allocate_irqs() to qemu_init_irqs()
  hw/char/pci-multi: Convert legacy qemu_allocate_irqs to qemu_init_irq
  hw/avr/boot: Replace load_elf_ram_sym() -> load_elf_as()
  hw/loader: Remove unused load_elf_ram()
  hw/loader: Clarify local variable name in load_elf_ram_sym()
  hw/loader: Pass ELFDATA endian order argument to load_elf_ram_sym()
  hw/loader: Pass ELFDATA endian order argument to load_elf_as()
  hw/loader: Pass ELFDATA endian order argument to load_elf()

Titus Rwantare (1):
  hw/misc/i2c-echo: add tracing

 hw/mips/loongson3_bootp.h      |   1 +
 include/hw/arm/omap.h          |  17 ++-
 include/hw/ipack/ipack.h       |   7 +-
 include/hw/irq.h               |  11 ++
 include/hw/loader.h            |  22 +--
 include/hw/sd/sd.h             |   1 -
 include/hw/sd/sdcard_legacy.h  |  50 -------
 hw/alpha/dp264.c               |   4 +-
 hw/arm/armv7m.c                |   2 +-
 hw/arm/boot.c                  |  16 +--
 hw/arm/omap1.c                 |  26 +++-
 hw/avr/boot.c                  |   8 +-
 hw/char/ipoctal232.c           |   4 +-
 hw/char/serial-pci-multi.c     |   7 +-
 hw/core/generic-loader.c       |   6 +-
 hw/core/irq.c                  |   8 ++
 hw/core/loader.c               |  44 ++----
 hw/hppa/machine.c              |   4 +-
 hw/i386/multiboot.c            |   4 +-
 hw/i386/x86-common.c           |   4 +-
 hw/ipack/ipack.c               |   5 +-
 hw/ipack/tpci200.c             |   6 +-
 hw/loongarch/boot.c            |   2 +-
 hw/m68k/an5206.c               |   2 +-
 hw/m68k/mcf5208.c              |   2 +-
 hw/m68k/q800.c                 |   2 +-
 hw/m68k/virt.c                 |   2 +-
 hw/microblaze/boot.c           |   6 +-
 hw/mips/boston.c               |   2 +-
 hw/mips/fuloong2e.c            |   2 +-
 hw/mips/loongson3_bootp.c      |  16 ++-
 hw/mips/loongson3_virt.c       |  59 ++++----
 hw/mips/malta.c                |   5 +-
 hw/mips/mipssim.c              |   3 +-
 hw/misc/i2c-echo.c             |   8 ++
 hw/openrisc/boot.c             |   2 +-
 hw/pci-host/raven.c            |   4 +-
 hw/ppc/e500.c                  |   2 +-
 hw/ppc/mac_newworld.c          |   5 +-
 hw/ppc/mac_oldworld.c          |   4 +-
 hw/ppc/pegasos2.c              |   8 +-
 hw/ppc/ppc405_boards.c         |   2 +-
 hw/ppc/ppc440_bamboo.c         |   3 +-
 hw/ppc/sam460ex.c              |   2 +-
 hw/ppc/spapr.c                 |   8 +-
 hw/ppc/virtex_ml507.c          |   4 +-
 hw/riscv/boot.c                |   3 +-
 hw/rx/rx-gdbsim.c              |   4 +-
 hw/s390x/ipl.c                 |   6 +-
 hw/sd/omap_mmc.c               | 250 ++++++++++++++++++---------------
 hw/sd/sd.c                     |  94 +++----------
 hw/sh4/r2d.c                   |  38 ++---
 hw/sparc/leon3.c               |   2 +-
 hw/sparc/sun4m.c               |   5 +-
 hw/sparc64/sun4u.c             |   6 +-
 hw/tricore/triboard.c          |   2 +-
 hw/tricore/tricore_testboard.c |   2 +-
 hw/usb/hcd-ehci.c              |   3 +-
 hw/xtensa/sim.c                |   3 +-
 hw/xtensa/xtfpga.c             |   3 +-
 hw/char/Kconfig                |   5 +
 hw/char/meson.build            |   2 +-
 hw/ipack/Kconfig               |   4 +
 hw/ipack/meson.build           |   3 +-
 hw/mips/meson.build            |   3 +-
 hw/misc/trace-events           |   5 +
 tests/qtest/libqos/meson.build |   4 +-
 tests/qtest/meson.build        |   4 +-
 68 files changed, 408 insertions(+), 455 deletions(-)
 delete mode 100644 include/hw/sd/sdcard_legacy.h

-- 
2.47.1


