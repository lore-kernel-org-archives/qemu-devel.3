Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D1BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8eq-0004c6-A1; Thu, 22 Feb 2024 07:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8eo-0004bt-Qo
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:58:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8ec-0005Wd-EK
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:58:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412888029baso3065145e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606700; x=1709211500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDWDehg/c5eR8sRlMxjCzGpqSPDjiJU2WvamJAzoTIs=;
 b=qNhyeBCMZq0jwasSuyolTk4MwzJQ/dvzJodceurdiOtR6dxo5ZI+CQrHwF6/yybx1Y
 KGS6haiCsTRo7wNGz+QiaUH/ZnrfQxnaJdSbpcUHI1aPQy77zSTB40/mNMLaoviISKBR
 XeeY9XUyj3qBY8LijGHu0OIPv06XvZIcAG/h5WeUV3VCkW5trEYXzDk7SrPrS/oBClqb
 zdA/UbZJ5bbZB1CvI8VHF74dwfNb+r9zUJnq+m3Rwae+3kvFPxfCIeS7Z5qbyyDUI/a3
 wPW8xFqxVTL48BTUiiUBhfKe49cqusn2cUWRbfZ47B5Xc73/kXMs3f1ox4MgpqYDSxbS
 EyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606700; x=1709211500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qDWDehg/c5eR8sRlMxjCzGpqSPDjiJU2WvamJAzoTIs=;
 b=J+ZzxgMX446YK42FBRJESMx20/BPuuaAG1z0BcavULhuhlhmg3Io+LOy/Vq4Mw5cDL
 vYH1IBmXjmATKlJQ+MLP+jfiej02lwJY93KZ7nikDV88tYAUiPHP0m5sj951zl9aMXlK
 9RchGwJKQuqRU1IA6YVYh0wYwvNgFIz0pJ2mcZRZGsAjshEhXBcdvINzZ0XmWm3aQPs6
 krflql32A4b4nO7DauEbQc9Z3gbgjXYTFF+L5aS5t22Fl+Jar25kU7Vhhj6vg86dpcFs
 F/abHaRAnY5Y3DbxxwNtxuxGfyalszo5fDFlDrq4qesIvExVjqhTvQB94M4qOxlJvKKF
 ofvQ==
X-Gm-Message-State: AOJu0YwbbSWoUqzxtfpoSZd/sbH2xdhmk4LVDL1qwmeZVHIQ+p861/zR
 bAcLCNwCfp7U0kQGTtq+eJDchmlE4AOjDX3G/PVerGdxmHybPDH6+GeIIUVzGP8wBXM1LAfxgoK
 WY6w=
X-Google-Smtp-Source: AGHT+IFuuOR18YWoOgkWy8Dtt8Ai/rJ6rSd3NLtzrSt/7y0+wgH5RC7TcTT/YcsZsSbHTVpUcvjhxw==
X-Received: by 2002:a05:600c:4f53:b0:412:5f58:53a5 with SMTP id
 m19-20020a05600c4f5300b004125f5853a5mr10143303wmq.24.1708606700537; 
 Thu, 22 Feb 2024 04:58:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 cc3-20020a5d5c03000000b0033d5e3c6835sm12112551wrb.5.2024.02.22.04.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:58:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/32] Misc HW patches for 2024-02-22
Date: Thu, 22 Feb 2024 13:58:09 +0100
Message-ID: <20240222125809.67291-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

  https://github.com/philmd/qemu.git tags/hw-misc-20240222

for you to fetch changes up to 7164f7e4028ad3b01a5f98c27482587b401ad420:

  hw/sparc/leon3: Fix wrong usage of DO_UPCAST macro (2024-02-22 12:47:40 +0100)

Supersedes: <20240221211626.48190-1-philmd@linaro.org>

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
- Prefer QDev API over QOM for devices (Phil)
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

Philippe Mathieu-Daudé (13):
  hw/input/pckbd: Open-code i8042_setup_a20_line() wrapper
  hw/sysbus: Inline and remove sysbus_add_io()
  hw/ppc/ppc4xx_pci: Remove unused "hw/ppc/ppc.h" header
  hw/ppc/ppc4xx_pci: Extract PCI host definitions to
    hw/pci-host/ppc4xx.h
  hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
  hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/
  hw/ppc/spapr_cpu: Use qdev_is_realized() instead of QOM API
  hw/ppc/pnv_bmc: Use qdev_new() instead of QOM API
  hw/tricore/testboard: Use qdev_new() instead of QOM basic API
  hw/i386/pc_sysfw: Use qdev_is_realized() instead of QOM API
  hw/acpi: Include missing 'qapi/qapi-types-acpi.h' generated header
  hw/acpi/cpu: Use CPUState typedef
  hw/acpi/ich9_tco: Include missing 'migration/vmstate.h' header

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

 MAINTAINERS                             |   5 +-
 hw/i386/fw_cfg.h                        |   3 +-
 include/hw/acpi/cpu.h                   |   3 +-
 include/hw/acpi/ich9_tco.h              |   1 +
 include/hw/acpi/memory_hotplug.h        |   1 +
 include/hw/i386/pc.h                    |   9 +-
 include/hw/i386/x86.h                   |   3 +-
 include/hw/ide.h                        |   9 -
 include/hw/ide/ide-bus.h                |  42 +++++
 include/hw/ide/ide-dev.h                | 184 +++++++++++++++++++++
 include/hw/ide/ide-dma.h                |  37 +++++
 include/hw/ide/internal.h               | 211 +-----------------------
 include/hw/ide/pci.h                    |   2 +-
 include/hw/input/i8042.h                |   1 -
 include/hw/pci-host/ppc4xx.h            |  17 ++
 include/hw/ppc/ppc4xx.h                 |   5 -
 include/hw/sysbus.h                     |   2 -
 include/hw/tricore/tricore_testdevice.h |   3 -
 hw/core/sysbus.c                        |   6 -
 hw/i2c/smbus_slave.c                    |   8 +-
 hw/i386/acpi-common.c                   |   3 +-
 hw/i386/fw_cfg.c                        |  12 +-
 hw/i386/kvmvapic.c                      |   3 +-
 hw/i386/pc.c                            |  60 +++----
 hw/i386/pc_piix.c                       |  31 +---
 hw/i386/pc_q35.c                        |  22 +--
 hw/i386/pc_sysfw.c                      |  23 +--
 hw/ide/cf.c                             |  58 +++++++
 hw/ide/cmd646.c                         |   1 +
 hw/ide/ide-bus.c                        | 111 +++++++++++++
 hw/ide/{qdev.c => ide-dev.c}            | 137 +--------------
 hw/ide/pci.c                            |   1 +
 hw/ide/piix.c                           |   1 +
 hw/ide/sii3112.c                        |   1 +
 hw/ide/via.c                            |   1 +
 hw/input/pckbd.c                        |   5 -
 hw/mips/mipssim.c                       |   3 +-
 hw/nvram/fw_cfg.c                       |   6 +-
 hw/{ppc => pci-host}/ppc440_pcix.c      |   3 +-
 hw/{ppc => pci-host}/ppc4xx_pci.c       |   3 +-
 hw/pci-host/ppce500.c                   |   2 +-
 hw/ppc/pnv_bmc.c                        |  10 +-
 hw/ppc/ppc440_bamboo.c                  |   1 +
 hw/ppc/ppc440_uc.c                      |   1 +
 hw/ppc/sam460ex.c                       |   1 +
 hw/ppc/spapr_cpu_core.c                 |   3 +-
 hw/sparc/leon3.c                        |   2 +-
 hw/tricore/tricore_testboard.c          |   4 +-
 hw/arm/Kconfig                          |   2 +
 hw/ide/Kconfig                          |  32 ++--
 hw/ide/meson.build                      |   4 +-
 hw/isa/meson.build                      |   2 +-
 hw/pci-host/Kconfig                     |   8 +
 hw/pci-host/meson.build                 |   2 +
 hw/pci-host/trace-events                |  12 ++
 hw/ppc/Kconfig                          |   3 +-
 hw/ppc/meson.build                      |   3 +-
 hw/ppc/trace-events                     |  12 --
 58 files changed, 607 insertions(+), 534 deletions(-)
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


