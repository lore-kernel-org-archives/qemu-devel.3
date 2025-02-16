Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B57AC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllK-0002vs-13; Sun, 16 Feb 2025 16:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllH-0002v9-Fu
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:11 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllF-0007t8-3s
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:11 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2346979f8f.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739665; x=1740344465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ftPSbevSBRqmtogAzGCsM4h9pDskfrjNtyoZjF1T/JU=;
 b=Tdx2uKdXD668q6ZiZ4dEiwM9PJZnAiGvMTZ8ikdaokX9GU7yws0s+GWX4wda03xpnR
 uKiIEOSpSKBEJxvZD9Ap6wAS+sojirZpLDGgXGysR8yJ/+nFK2v2ozxb/BlRdulJJpQV
 A1J0sjZR85JcDUT38L6kXTErxin6efpQZE/gHueGpv2vQa49z6aOyDdvUwK3StCm2a3r
 uC7cOzThgr7+ntuA4LkskuG4dWLOkFL/JRooYRD4FPckrVHqyPdpLHG5n3BZnwfm5Y+6
 kvED+bAI6Gc/gHyTurfkUml9aG1d/XAZ4FQr/oVBRwD2faYENjZjItEafovzi8S4Z+ho
 r9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739665; x=1740344465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ftPSbevSBRqmtogAzGCsM4h9pDskfrjNtyoZjF1T/JU=;
 b=X1580DWOLCCjaN2tkDzaauvqPWkb69Uln+zNFJBb+8U2g30ZFnWmjgzegvQxnJavGB
 lWQCJmTnM4JNg8YpJrcJOd5AbOLuFD1Ys2Kv9wYXo1Ph4bTlnPFXOpjXKTeEgoNPVPwr
 d/gnjqE/iRTJ+uhZe0Aru5yrUTZNkzMCSnsbE+XTZOzlcTmCTbFTUfQ5U1qsW7quaMPU
 r4J53KKXYCZ+MSyZ6PhWVYhBzMMPfpwDLEPqzX0E7ykKexdxwQMp6HCm2311IiiruZZU
 LQwL7YOuZmOxrSm/ybHfn4LvUY5Q1XBpKLf13RScdyj6UddjCXWeMTG5UhOXKyM8uGfd
 hGpw==
X-Gm-Message-State: AOJu0YxhIADvGRfmnH56x7xIduksb5e0nkngftYgfjIhs4JKsSr5duBm
 TivaVUVATr8nA00NYt5RDjcc5OuezDFBDF4vYXtCxuxQwHkwdaPw3tmhps6NW22p2O1qtm/oTZ2
 9fYE=
X-Gm-Gg: ASbGncumNPYJU6hWPifB8zkZMJE1gLlSQ3r+E88Tp/bMSb+z5AIvx1Ke+ugRR1Ov56C
 ciKiwLMX9/FFG+N9VJ0RccarAu9e46br9VG537SFCuCNv56FjI6CecsDfrMyLxDh3Qxq+mZAmaG
 ze8Av/3AwM5Z9zDbbusflegbKg2g1w0XITQnHU34LtLTXGFSqC85OdmXyJfdP6+UCmRMfV7Zv9b
 GyesynU2XbmKqH4kn7yMoawMzQzLOkRluEhDs0PDwj0Sjw/t3daGx/Lq1uYKoIuSUBnVBVwLaTd
 i4qS6GcqxORVylvLM+VcB3YhURgaWi+WLk/j92tFDDxyrRXWdrPNl0eBSBVQPujEURsA8ho=
X-Google-Smtp-Source: AGHT+IG2Z9/MqFiVrIN44w+I77maAQWHhU9ERMEUSGKDmJDHr5OoUh17/7TVakXrbh2EOQ09xwIiRw==
X-Received: by 2002:a5d:5a4c:0:b0:38b:f44b:8663 with SMTP id
 ffacd0b85a97d-38f3417165fmr6392733f8f.55.1739739665414; 
 Sun, 16 Feb 2025 13:01:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc8b4sm10584842f8f.50.2025.02.16.13.01.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/39] Misc HW patches for 2025-02-16
Date: Sun, 16 Feb 2025 22:00:52 +0100
Message-ID: <20250216210103.70235-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The following changes since commit 495de0fd82d8bb2d7035f82d9869cfeb48de2f9e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-02-14 08:19:05 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250216

for you to fetch changes up to 5bf24ec9c4d4771a9469cadd19cf534e9a32a9db:

  hw/rx: Allow execution without either bios or kernel (2025-02-16 14:45:38 +0100)

----------------------------------------------------------------
Misc HW patches

- Use qemu_hexdump_line() in TPM backend (Philippe)
- Remove magic number in APIC (Phil)
- Disable thread-level cache topology (Zhao)
- Xen QOM style cleanups (Bernhard)
- Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
- Invert logic of machine no_sdcard flag (Philippe)
- Housekeeping in MicroBlaze functional tests (Philippe)
- Prevent out-of-bound access in SMC91C111 RX path (Peter)
- Declare more fields / arguments as const (Philippe)
- Introduce EndianMode QAPI enum (Philippe)
- Make various Xilinx devices endianness configurable (Philippe)
- Mark some devices memory regions as little-endian (Philippe)
- Allow execution RX gdbsim machine without BIOS/kernel (Keith)

Ignoring a pair of "line over 80 characters" checkpatch warnings in:

#141: FILE: hw/net/xilinx_ethlite.c:382:
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XlnxXpsEthLite, model_endianness),
#72: FILE: hw/char/xilinx_uartlite.c:185:
+    DEFINE_PROP_ENDIAN_NODEFAULT("endianness", XilinxUARTLite, model_endianness),

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/xen: Prefer QOM cast for XenLegacyDevice

Keith Packard (1):
  hw/rx: Allow execution without either bios or kernel

Peter Maydell (1):
  hw/net/smc91c111: Ignore attempt to pop from empty RX fifo

Phil Dennis-Jordan (1):
  hw/intc/apic: Fixes magic number use, removes outdated comment

Philippe Mathieu-Daudé (34):
  backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
  hw/arm/xlnx-zynqmp: Use &error_abort for programming errors
  hw/sysbus: Use sizeof(BusState) in main_system_bus_create()
  hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
  hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
  hw/vfio: Have VFIO_PLATFORM devices inherit from
    DYNAMIC_SYS_BUS_DEVICE
  hw/display: Have RAMFB device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/i386: Have X86_IOMMU devices inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/net: Have eTSEC device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/tpm: Have TPM TIS sysbus device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
  hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
  hw/boards: Rename no_sdcard -> auto_create_sdcard
  hw/boards: Do not create unusable default if=sd drives
  hw/arm: Remove all invalid uses of auto_create_sdcard=true
  hw/riscv: Remove all invalid uses of auto_create_sdcard=true
  hw/boards: Ensure machine setting auto_create_sdcard expose a SD Bus
  hw/riscv/opentitan: Include missing 'exec/address-spaces.h' header
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Allow microblaze tests to take a machine name
    argument
  tests/functional: Remove sleep() kludges from microblaze tests
  hw: Declare various const data as 'const'
  hw: Make class data 'const'
  hw/qdev-properties-system: Introduce EndianMode QAPI enum
  hw/intc/xilinx_intc: Make device endianness configurable
  hw/net/xilinx_ethlite: Make device endianness configurable
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable
  hw/arm: Mark Allwinner Technology devices as little-endian
  hw/mips: Mark Boston machine devices as little-endian
  hw/mips: Mark Loonson3 Virt machine devices as little-endian
  hw/pci-host: Mark versatile regions as little-endian

Zhao Liu (1):
  hw/core/machine: Reject thread level cache

 qapi/common.json                              | 14 +++++
 hw/sd/sdhci-internal.h                        |  2 +-
 include/hw/boards.h                           |  2 +-
 include/hw/qdev-properties-system.h           |  7 +++
 include/hw/sysbus.h                           |  2 +
 include/hw/xen/xen_pvdev.h                    |  5 +-
 backends/tpm/tpm_util.c                       | 24 ++++----
 hw/arm/allwinner-a10.c                        |  2 +-
 hw/arm/allwinner-h3.c                         |  8 +--
 hw/arm/allwinner-r40.c                        |  2 +-
 hw/arm/aspeed.c                               | 20 +++++++
 hw/arm/bananapi_m2u.c                         |  1 +
 hw/arm/cubieboard.c                           |  1 +
 hw/arm/exynos4_boards.c                       |  2 +
 hw/arm/fby35.c                                |  1 +
 hw/arm/imx25_pdk.c                            |  1 +
 hw/arm/integratorcp.c                         |  1 +
 hw/arm/mcimx6ul-evk.c                         |  1 +
 hw/arm/mcimx7d-sabre.c                        |  1 +
 hw/arm/npcm7xx_boards.c                       |  5 ++
 hw/arm/omap_sx1.c                             |  2 +
 hw/arm/orangepi.c                             |  1 +
 hw/arm/raspi.c                                |  5 ++
 hw/arm/raspi4b.c                              |  1 +
 hw/arm/realview.c                             |  4 ++
 hw/arm/sabrelite.c                            |  1 +
 hw/arm/stellaris.c                            |  1 +
 hw/arm/versatilepb.c                          |  2 +
 hw/arm/vexpress.c                             |  2 +
 hw/arm/xilinx_zynq.c                          |  1 -
 hw/arm/xlnx-versal-virt.c                     |  1 +
 hw/arm/xlnx-zcu102.c                          |  1 +
 hw/arm/xlnx-zynqmp.c                          | 38 ++++--------
 hw/char/xilinx_uartlite.c                     | 34 +++++++----
 hw/core/machine-smp.c                         |  7 +++
 hw/core/null-machine.c                        |  1 -
 hw/core/qdev-properties-system.c              | 11 ++++
 hw/core/sysbus.c                              | 54 ++++++++++-------
 hw/display/ramfb-standalone.c                 |  3 +-
 hw/i2c/allwinner-i2c.c                        |  2 +-
 hw/i386/amd_iommu.c                           |  2 -
 hw/i386/intel_iommu.c                         |  2 -
 hw/i386/x86-iommu.c                           |  2 +-
 hw/intc/allwinner-a10-pic.c                   |  2 +-
 hw/intc/apic.c                                |  3 +-
 hw/intc/xilinx_intc.c                         | 59 +++++++++++++-----
 hw/isa/vt82c686.c                             |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  5 ++
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  6 ++
 hw/mips/boston.c                              |  6 +-
 hw/mips/loongson3_virt.c                      |  4 +-
 hw/misc/allwinner-a10-ccm.c                   |  2 +-
 hw/misc/allwinner-a10-dramc.c                 |  2 +-
 hw/misc/allwinner-cpucfg.c                    |  2 +-
 hw/misc/allwinner-h3-ccu.c                    |  2 +-
 hw/misc/allwinner-h3-dramc.c                  |  6 +-
 hw/misc/allwinner-h3-sysctrl.c                |  2 +-
 hw/misc/allwinner-r40-ccu.c                   |  2 +-
 hw/misc/allwinner-r40-dramc.c                 | 10 ++--
 hw/misc/allwinner-sid.c                       |  2 +-
 hw/misc/allwinner-sramc.c                     |  2 +-
 hw/net/allwinner-sun8i-emac.c                 |  2 +-
 hw/net/allwinner_emac.c                       |  2 +-
 hw/net/fsl_etsec/etsec.c                      |  4 +-
 hw/net/smc91c111.c                            |  9 +++
 hw/net/xilinx_ethlite.c                       | 29 +++++++--
 hw/pci-host/versatile.c                       |  4 +-
 hw/ppc/virtex_ml507.c                         |  2 +
 hw/riscv/microblaze-v-generic.c               |  5 ++
 hw/riscv/microchip_pfsoc.c                    |  1 +
 hw/riscv/opentitan.c                          |  1 +
 hw/riscv/sifive_u.c                           |  1 +
 hw/rtc/allwinner-rtc.c                        |  2 +-
 hw/rtc/m48t59-isa.c                           |  2 +-
 hw/rtc/m48t59.c                               |  2 +-
 hw/rx/rx-gdbsim.c                             |  3 -
 hw/s390x/s390-virtio-ccw.c                    |  1 -
 hw/sd/allwinner-sdhost.c                      |  2 +-
 hw/sd/sdhci.c                                 |  2 +-
 hw/sensor/emc141x.c                           |  2 +-
 hw/sensor/isl_pmbus_vr.c                      |  2 +-
 hw/sensor/tmp421.c                            |  2 +-
 hw/ssi/allwinner-a10-spi.c                    |  2 +-
 hw/ssi/xilinx_spi.c                           | 32 +++++++---
 hw/timer/allwinner-a10-pit.c                  |  2 +-
 hw/timer/xilinx_timer.c                       | 43 +++++++++----
 hw/tpm/tpm_tis_sysbus.c                       |  3 +-
 hw/usb/hcd-ehci-pci.c                         |  2 +-
 hw/usb/hcd-uhci.c                             |  2 +-
 hw/usb/xen-usb.c                              |  6 +-
 hw/vfio/amd-xgbe.c                            |  2 -
 hw/vfio/calxeda-xgmac.c                       |  2 -
 hw/vfio/platform.c                            |  4 +-
 hw/watchdog/allwinner-wdt.c                   |  2 +-
 hw/xen/xen-legacy-backend.c                   |  9 +--
 hw/xen/xen_pvdev.c                            |  2 +-
 system/vl.c                                   | 24 ++++++--
 .../functional/test_microblaze_s3adsp1800.py  | 11 ++--
 .../test_microblazeel_s3adsp1800.py           | 19 +++---
 tests/qemu-iotests/172.out                    | 60 -------------------
 100 files changed, 425 insertions(+), 281 deletions(-)

-- 
2.47.1


