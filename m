Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9EEC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiF4D-0004gt-US; Wed, 12 Feb 2025 10:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF46-0004c9-7Q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:18 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiF42-0000pg-PQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:54:17 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so2013685e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375650; x=1739980450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9fvZyvUuG5we6uquTUIOU3INcIuKxOLNdEIdFjFeBAs=;
 b=SYCHgJEpXEdbwjycXM1GkjEZ2ij8AwJCFR50BexBT/T5CggezgSh+sLGuiUwbQuoPK
 ckIHYFK7zXJzzS6OfP5aVYH8dXyLxTsSFmBCFAx3ELAQOn8jboKOF0AwPYgAkMb4xBvd
 7tnmQ40b2CPlbOyI9brzDMnzRB3xICBS4glGy8MWtKUHBrHlhYCcJpdtGimMpqqYWhue
 UKFD+XBWvLOE5zgM3t4nLiRLWCF9UmLTVBu3nfvOUUcQTJQ+PwRNucDt9KbFFQ/BcRkZ
 1nrZSWW6gee7ewlpCG8bBkStKNPvCqTcytKxdg1lzI7dnCn0mGrSJQHyr1QLkAANV+Uf
 +ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375650; x=1739980450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9fvZyvUuG5we6uquTUIOU3INcIuKxOLNdEIdFjFeBAs=;
 b=AZQEcOi43leT53fKM7tr8zhhRVfOS0NVsBXAI3WRZn3oBrxpiNJyAtxj69hmons3pm
 WpfFUaXOQDDL+IWRBQohGHWcX4sew9Is1UCxMlQSmcf7Z/IgSIexKsAk3VPrSxa9muvc
 u2uIqIhxcF0FfVXOQ4as0Q3E0fSMbRgr+qIG+76uk/zYDB589SGxJt6sNehXN6+w0a7z
 dKTDoyKgQYqX3WD064EE6sIj5g+KYop6+CbobNaEgmcobJvUGwhn+kQHi9sm3O6a/g1q
 36pFSvnx8yv+wj/tH1CijNODFFIuhfB94NWR5PKpf5zIalUfT2fQnRRih78yiaO/1q4e
 QghA==
X-Gm-Message-State: AOJu0Yw1LAVBie1345xhbT5H+b/W8IwcwVPNC08JCeRyOhe9h5zp4Vdt
 4ojYd19bskdANR3aN2Yd0OpZG3JgQKhqKMPRetQ4KDAQEUm+1UCB5SOU9CNtD6iROTJ2s7iOdAL
 nXvQ=
X-Gm-Gg: ASbGncsikRPiP6SYYtj04PYivE4ZlSSO/kIVZub2BYzOedZSyZfGXfVYL/Lr4tNb2Ai
 zczhrddgarJBECSZ2Dd8Vk7aSgEpOl5NS1z5BGMcnbyKx12DQvg5rSdyQaXP5AyP0+lrdfpjMxq
 ZdfrhBt919q3nLwI2/nDjOSBqwWI4+foaMIRLtrg5qcahCSmJfvwgGjbKYAQhlD+auFNiuPZV7O
 +Ssq8v7kbv+DRVwowpD/HmY7MHGZIOKw83iKjVXZOgSHLAloMNI4AlHzM4XAWwHWF+tZuubgsMg
 9pnjdjPRaoVE7DgJcQmmkbK/gvbxp2TEkybWFfRkolyRHfqRyiDyXdqWMBloVaF2jnNwl+Y=
X-Google-Smtp-Source: AGHT+IE9bWOCAfFK5SSn8nKoB2J5L+2sjLvI8vJhat4uljf2b++3SueN6PShexJp9LDYaAuScfMWSA==
X-Received: by 2002:a05:600c:3ba7:b0:439:5766:7232 with SMTP id
 5b1f17b1804b1-439581b271fmr31779515e9.21.1739375650128; 
 Wed, 12 Feb 2025 07:54:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a076496sm23036485e9.32.2025.02.12.07.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 07:54:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/29] Misc HW patches for 2025-02-12
Date: Wed, 12 Feb 2025 16:54:06 +0100
Message-ID: <20250212155408.29502-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The following changes since commit f9edf32ea2e18a56de5d92f57e9d10565c822367:

  Merge tag 'pull-request-2025-02-11' of https://gitlab.com/thuth/qemu into staging (2025-02-11 13:27:32 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250212

for you to fetch changes up to b374adcae577dddfe6cfd404985014fdd2443428:

  hw: Make class data 'const' (2025-02-12 15:39:46 +0100)

Since 2025-02-10: Dropped MicroBlaze endianness patches, added constify.

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

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/xen: Prefer QOM cast for XenLegacyDevice

Peter Maydell (1):
  hw/net/smc91c111: Ignore attempt to pop from empty RX fifo

Phil Dennis-Jordan (1):
  hw/intc/apic: Fixes magic number use, removes outdated comment

Philippe Mathieu-Daudé (25):
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
  tests/functional: Have microblaze tests inherit common parent class
  hw: Declare various const data as 'const'
  hw: Make class data 'const'

Zhao Liu (1):
  hw/core/machine: Reject thread level cache

 hw/sd/sdhci-internal.h                        |  2 +-
 include/hw/boards.h                           |  2 +-
 include/hw/sysbus.h                           |  2 +
 include/hw/xen/xen_pvdev.h                    |  5 +-
 backends/tpm/tpm_util.c                       | 24 ++++----
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
 hw/core/machine-smp.c                         |  7 +++
 hw/core/null-machine.c                        |  1 -
 hw/core/sysbus.c                              | 54 ++++++++++-------
 hw/display/ramfb-standalone.c                 |  3 +-
 hw/i386/amd_iommu.c                           |  2 -
 hw/i386/intel_iommu.c                         |  2 -
 hw/i386/x86-iommu.c                           |  2 +-
 hw/intc/apic.c                                |  3 +-
 hw/isa/vt82c686.c                             |  2 +-
 hw/net/fsl_etsec/etsec.c                      |  4 +-
 hw/net/smc91c111.c                            |  9 +++
 hw/riscv/microchip_pfsoc.c                    |  1 +
 hw/riscv/opentitan.c                          |  1 +
 hw/riscv/sifive_u.c                           |  1 +
 hw/rtc/m48t59-isa.c                           |  2 +-
 hw/rtc/m48t59.c                               |  2 +-
 hw/s390x/s390-virtio-ccw.c                    |  1 -
 hw/sd/sdhci.c                                 |  2 +-
 hw/sensor/emc141x.c                           |  2 +-
 hw/sensor/isl_pmbus_vr.c                      |  2 +-
 hw/sensor/tmp421.c                            |  2 +-
 hw/tpm/tpm_tis_sysbus.c                       |  3 +-
 hw/usb/hcd-ehci-pci.c                         |  2 +-
 hw/usb/hcd-uhci.c                             |  2 +-
 hw/usb/xen-usb.c                              |  6 +-
 hw/vfio/amd-xgbe.c                            |  2 -
 hw/vfio/calxeda-xgmac.c                       |  2 -
 hw/vfio/platform.c                            |  4 +-
 hw/xen/xen-legacy-backend.c                   |  9 +--
 hw/xen/xen_pvdev.c                            |  2 +-
 system/vl.c                                   | 24 ++++++--
 .../functional/test_microblaze_s3adsp1800.py  | 34 +++++++++--
 .../test_microblazeel_s3adsp1800.py           | 32 ++--------
 tests/qemu-iotests/172.out                    | 60 -------------------
 62 files changed, 211 insertions(+), 205 deletions(-)

-- 
2.47.1


