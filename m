Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CEFC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxO-00026Q-EU; Wed, 21 Feb 2024 16:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxD-00020Y-0Z
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctx9-0000je-ED
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41275855dc4so8155495e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550189; x=1709154989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8uBLISnHsBy7pnbye/AKpsaEy5lYoO5sp8diPx57aqA=;
 b=xoS+Pi5av2NJI4+Smnujn7Z+rQkWXAtj/qnAuW57IcQeK1KR/7QZPkFYygG/n/MQjj
 bPgNZDrIL7RKS9xvy6UNcr1pkB5u5t9odAVuzHyNj6w2vCqT3uxiAaDvRiaqKnBptjNg
 l9rCl4haoziod1WQLVFNz226bdqPuAT+xdDr+Aq+I2DZJTrILBRTjM5yM+YThfpuNzgK
 iUmBItjVuA6iZf0ASCDDLR8AkVjIKs/jy/nMkXZQcAIelx31dpmBGcxGeHBJnO44NMvi
 jLb7IpATtpEpAGOE53wodctEO4A3o46YkreeQ9dB20vgKrZRYB+61jN6rW1BYOP9gtkm
 nscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550189; x=1709154989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uBLISnHsBy7pnbye/AKpsaEy5lYoO5sp8diPx57aqA=;
 b=b8AQifBiRTiEGPNrge6HOnYYhckM+/nLiPULb7gauwOp6UsWclMUhPq/natCjJp8gs
 3OkqLF96TX59orvhD2nV1Se+fWTZlCu+dZBhu6w4FhCUQPnhhucxB4jafu+9VGp2N1Cw
 W4BnY1g9A4CDuqdNVgznfdG6nktZt/sAT8uetTiCx6Uordyx/4oVh8CiKfb0cmj0MwQh
 bVlmTedpDnfvH+lZah0qQT/RVeHce+f7IjIXtmW/p0u9zAAzDJE8RhC+sy7uBH9Xu6vp
 DND0bJsWiUNOmyiL3JZFVuqgAEKP2DcufVAq4GBq0cvRWnFzdVgBrTaZnmDOHAAELGDE
 s4qQ==
X-Gm-Message-State: AOJu0YzgP5VljCDt8XFuf0BJhHjBcTEyiRF3I/luEZ7qFBauDcgMc/Jo
 LCOoHr+X9WWSTFCekH9dbqp+f/MsKMe5cyzit4kOW88z4dGdbmK+hazDsazCc8uRDIbBvuA9bsS
 4fKg=
X-Google-Smtp-Source: AGHT+IFoTZZPX3vRFtliIKTMz9I/uXJnHk5PjkjzSLox7dxtKfJQQxz/p2+15Xt4cqDxT97BJBHxoA==
X-Received: by 2002:a05:600c:3506:b0:411:df3b:b43d with SMTP id
 h6-20020a05600c350600b00411df3bb43dmr12906488wmq.8.1708550189315; 
 Wed, 21 Feb 2024 13:16:29 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 ay17-20020a05600c1e1100b004127876647fsm2545192wmb.41.2024.02.21.13.16.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/25] Misc HW patches for 2024-02-21
Date: Wed, 21 Feb 2024 22:16:00 +0100
Message-ID: <20240221211626.48190-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 760b4dcdddba4a40b9fa0eb78fdfc7eda7cb83d0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-02-20 10:11:08 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240221

for you to fetch changes up to df07f6bb563f25f39f4f5887adab557e42bdee59:

  hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro (2024-02-21 22:13:03 +0100)

Following checkpatch.pl error ignored:

  ERROR: Macros with complex values should be enclosed in parenthesis
  #62: FILE: include/hw/ide/ide-dev.h:31:
  +#define DEFINE_IDE_DEV_PROPERTIES()                     \
  +    DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
  +    DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
  +    DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
  +    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
  +    DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
  +    DEFINE_PROP_STRING("model", IDEDrive, dev.model)

----------------------------------------------------------------
Misc HW patch queue

- Remove sysbus_add_io (Phil)
- Build PPC 4xx PCI host bridges once (Phil)
- Display QOM path while debugging SMBus targets (Joe)
- Simplify x86 PC code (Bernhard)
- Remove qemu_[un]register_reset() calls in x86 PC CMOS (Peter)
- Fix wiring of ICH9 LPC interrupts (Bernhard)
- Split core IDE as device / bus / dma (Thomas)
- Fix invalid use of DO_UPCAST() in Leon3 (Thomas)

----------------------------------------------------------------

Bernhard Beschow (8):
  hw/i386/pc_piix: Share pc_cmos_init() invocation between pc and isapc
    machines
  hw/i386/x86: Turn apic_xrupt_override into class attribute
  hw/i386/pc: Merge pc_guest_info_init() into pc_machine_initfn()
  hw/i386/pc: Defer smbios_set_defaults() to machine_done
  hw/i386/pc: Confine system flash handling to pc_sysfw
  hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove it
  hw/i386/pc_q35: Populate interrupt handlers before realizing LPC PCI
    function
  hw/isa/meson.build: Sort alphabetically

Joe Komlodi (1):
  hw/i2c/smbus_slave: Add object path on error prints

Peter Maydell (2):
  hw/i386/pc: Store pointers to IDE buses in PCMachineState
  hw/i386/pc: Do pc_cmos_init_late() from pc_machine_done()

Philippe Mathieu-Daudé (6):
  hw/input/pckbd: Open-code i8042_setup_a20_line() wrapper
  hw/sysbus: Inline and remove sysbus_add_io()
  hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
  hw/ppc/ppc4xx_pci: Extract PCI host definitions to
    hw/pci-host/ppc4xx.h
  hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
  hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/

Thomas Huth (8):
  hw/ide: Add the possibility to disable the CompactFlash device in the
    build
  hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
  hw/ide: Move IDE DMA related definitions to a separate header
    ide-dma.h
  hw/ide: Move IDE device related definitions to ide-dev.h
  hw/ide: Move IDE bus related definitions to a new header ide-bus.h
  hw/ide: Remove the include/hw/ide.h legacy file
  hw/ide: Stop exposing internal.h to non-IDE files
  hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro

 MAINTAINERS                        |   5 +-
 hw/i386/fw_cfg.h                   |   3 +-
 include/hw/i386/pc.h               |   9 +-
 include/hw/i386/x86.h              |   3 +-
 include/hw/ide.h                   |   9 --
 include/hw/ide/ide-bus.h           |  42 ++++++
 include/hw/ide/ide-dev.h           | 184 +++++++++++++++++++++++++
 include/hw/ide/ide-dma.h           |  37 +++++
 include/hw/ide/internal.h          | 211 +----------------------------
 include/hw/ide/pci.h               |   2 +-
 include/hw/input/i8042.h           |   1 -
 include/hw/pci-host/ppc4xx.h       |  17 +++
 include/hw/ppc/ppc4xx.h            |   5 -
 include/hw/sysbus.h                |   2 -
 hw/core/sysbus.c                   |   6 -
 hw/i2c/smbus_slave.c               |   8 +-
 hw/i386/acpi-common.c              |   3 +-
 hw/i386/fw_cfg.c                   |  12 +-
 hw/i386/kvmvapic.c                 |   2 +-
 hw/i386/pc.c                       |  60 ++++----
 hw/i386/pc_piix.c                  |  31 +----
 hw/i386/pc_q35.c                   |  22 +--
 hw/i386/pc_sysfw.c                 |  17 +--
 hw/ide/cf.c                        |  58 ++++++++
 hw/ide/cmd646.c                    |   1 +
 hw/ide/ide-bus.c                   | 111 +++++++++++++++
 hw/ide/{qdev.c => ide-dev.c}       | 137 +------------------
 hw/ide/pci.c                       |   1 +
 hw/ide/piix.c                      |   1 +
 hw/ide/sii3112.c                   |   1 +
 hw/ide/via.c                       |   1 +
 hw/input/pckbd.c                   |   5 -
 hw/mips/mipssim.c                  |   2 +-
 hw/nvram/fw_cfg.c                  |   5 +-
 hw/{ppc => pci-host}/ppc440_pcix.c |   3 +-
 hw/{ppc => pci-host}/ppc4xx_pci.c  |   3 +-
 hw/pci-host/ppce500.c              |   2 +-
 hw/ppc/ppc440_bamboo.c             |   1 +
 hw/ppc/ppc440_uc.c                 |   1 +
 hw/ppc/sam460ex.c                  |   1 +
 hw/sparc/leon3.c                   |   2 +-
 hw/arm/Kconfig                     |   2 +
 hw/ide/Kconfig                     |  32 +++--
 hw/ide/meson.build                 |   4 +-
 hw/isa/meson.build                 |   2 +-
 hw/pci-host/Kconfig                |   8 ++
 hw/pci-host/meson.build            |   2 +
 hw/pci-host/trace-events           |  12 ++
 hw/ppc/Kconfig                     |   3 +-
 hw/ppc/meson.build                 |   3 +-
 hw/ppc/trace-events                |  12 --
 51 files changed, 591 insertions(+), 516 deletions(-)
 delete mode 100644 include/hw/ide.h
 create mode 100644 include/hw/ide/ide-bus.h
 create mode 100644 include/hw/ide/ide-dev.h
 create mode 100644 include/hw/ide/ide-dma.h
 create mode 100644 include/hw/pci-host/ppc4xx.h
 create mode 100644 hw/ide/cf.c
 create mode 100644 hw/ide/ide-bus.c
 rename hw/ide/{qdev.c => ide-dev.c} (67%)
 rename hw/{ppc => pci-host}/ppc440_pcix.c (99%)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (99%)

-- 
2.41.0


