Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D609C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thabi-00064I-1o; Mon, 10 Feb 2025 15:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabf-00063p-IW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:15 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thabZ-0003UH-NK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:42:15 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso32381175e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220127; x=1739824927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SJr5z9ae/TFaELMlTEnCnVd5z+ON9SCf5Ds9hjjhaa4=;
 b=daCsR7ceIrxnrTts2831ERmV0Bd5LoPnXH+CewIi8TZtm3DV+/OUe86e85wtsaY2dE
 uJhPD7If4H580iYvdW9RTVC8sMtXGPrezdYJCCtxhmRZRLrcrzDK5v73a5SuWQIV4Mvy
 lr9k6VW5S5GH3H7WtpaqSvQsanZ4zRYeZgdoBI09tCa4V7jIpaBCnOEpX1NeZZvA0ofs
 hv7qcVETo5hFRDG1eR4zbxSpvxKZDWRMGkUDK6J4m6ev2S7dwLBNHyCD9MKYpRjrTVPr
 uoAIoSrhHuSgXPNGk3aaForZ0BLeyo405Qdws8LbFxrO53NaQb6PnGSxd6ZutvjBx1C6
 TCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220127; x=1739824927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJr5z9ae/TFaELMlTEnCnVd5z+ON9SCf5Ds9hjjhaa4=;
 b=aODWg1zGVn9BAC3jkArzM/LT91TAr+aGOIsAYJ+OxZIF+rTCMNjLpOf2sRwAmR1L4i
 Q+MGGvg6Zd6vg66NGE43SzDnM3j/VaxsdgwIrWJl6fpCpucfl5IPtPXECfhMeZgiPfNZ
 3OZCPBGvTHKesRlYUpkS5UCWXNXbgXmFPK+ZWrqppm3yS309AMgqh8iaS8OT1tAUsbUc
 t3wwkaHFKvakMK7aXBuv3gLoxRp9OOdD9Z0b3TXwU2juLE0Q4DXGuEOymp5BYr5QEu6e
 PNwUSkT/9LjFzrvSG2XlsW5Fn+Gj+pdksep/qRcj3zZCBnUp69E0aO6/C+eNRRsY/MwI
 NXgw==
X-Gm-Message-State: AOJu0YzVVZLldV3dE2YnTlDPlIACyMFHisxNERpyMZp15XOkwOFuCxg0
 3nUBVW/4/4wSDKraycIUEGwEpAdlu2ET3ZvihTb4lGMUiw9d+nloga6XKbRvG7y4RQZhYNvnTKK
 Obj4=
X-Gm-Gg: ASbGnctsPzt7xR/iw1tIJlhK5xPbT9KbeIcRb7NjMt2zavMtp0LapSbo6ZjXrqGPj7s
 keFST28TtiUBJQ3qeKXkAWZuQ9d3t9Vx4JKLM7CzUrzQleMsODb33o/jMQMX6UJd6zgbnefW9eE
 +zy1uLjifG0eUv288/gWyihKRdIRlX5uCVEpQzaqnvXhzwB97gcmn8mwBRVlDSi0X2qmChBG0az
 PM/lEmZjTH9jOj9TiSqqd/IZ/K1XgghlmTX4rdLbMofTCqtXw6frCHiNshHPMKnmy/5LivO03n8
 xclHp2s3X96FHUsuavc9nLQ7x5rZeBR3C3CmouMUvq/V/XtS1SqOjHl7g5Zwa2VS0Q==
X-Google-Smtp-Source: AGHT+IGaYPa9IMdy2JPrek5RQF3cdbewLLfluzi3UWMK/SDssJ5XOgi6ADw2xdWIH2RjrgOvHucfIQ==
X-Received: by 2002:a05:6000:2ad:b0:38d:e02d:5f43 with SMTP id
 ffacd0b85a97d-38de02d60a6mr3382963f8f.2.1739220127527; 
 Mon, 10 Feb 2025 12:42:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43936bcc04fsm80576935e9.20.2025.02.10.12.42.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:42:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/32] Misc HW patches for 2025-02-10
Date: Mon, 10 Feb 2025 21:41:32 +0100
Message-ID: <20250210204204.54407-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The following changes since commit 54e91d1523b412b4cff7cb36c898fa9dc133e886:

  Merge tag 'pull-qapi-2025-02-10-v2' of https://repo.or.cz/qemu/armbru into staging (2025-02-10 10:47:31 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250210

for you to fetch changes up to 1078a376932cc1d1c501ee3643fef329da6a189a:

  hw/net/smc91c111: Ignore attempt to pop from empty RX fifo (2025-02-10 21:30:44 +0100)

----------------------------------------------------------------
Misc HW patches

- Use qemu_hexdump_line() in TPM backend (Philippe)
- Make various Xilinx devices endianness configurable (Philippe)
- Remove magic number in APIC (Phil)
- Disable thread-level cache topology (Zhao)
- Xen QOM style cleanups (Bernhard)
- Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE (Philippe)
- Invert logic of machine no_sdcard flag (Philippe)
- Housekeeping in MicroBlaze functional tests (Philippe)
- Prevent out-of-bound access in SMC91C111 RX path (Peter)

----------------------------------------------------------------

Bernhard Beschow (1):
  hw/xen: Prefer QOM cast for XenLegacyDevice

Peter Maydell (1):
  hw/net/smc91c111: Ignore attempt to pop from empty RX fifo

Phil Dennis-Jordan (1):
  hw/intc/apic: Fixes magic number use, removes outdated comment

Philippe Mathieu-Daudé (28):
  backends/tpm: Use qemu_hexdump_line() to avoid sprintf()
  hw/intc/xilinx_intc: Make device endianness configurable
  hw/net/xilinx_ethlite: Make device endianness configurable
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable
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
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Allow microblaze tests to take a machine name
    argument
  tests/functional: Remove sleep() kludges from microblaze tests
  tests/functional: Have microblaze tests inherit common parent class
  hw/riscv/opentitan: Include missing 'exec/address-spaces.h' header

Zhao Liu (1):
  hw/core/machine: Reject thread level cache

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
 hw/char/xilinx_uartlite.c                     | 27 +++++----
 hw/core/machine-smp.c                         |  7 +++
 hw/core/null-machine.c                        |  1 -
 hw/core/sysbus.c                              | 54 ++++++++++-------
 hw/display/ramfb-standalone.c                 |  3 +-
 hw/i386/amd_iommu.c                           |  2 -
 hw/i386/intel_iommu.c                         |  2 -
 hw/i386/x86-iommu.c                           |  2 +-
 hw/intc/apic.c                                |  3 +-
 hw/intc/xilinx_intc.c                         | 52 +++++++++++-----
 hw/microblaze/petalogix_ml605_mmu.c           |  3 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  4 ++
 hw/net/fsl_etsec/etsec.c                      |  4 +-
 hw/net/smc91c111.c                            |  9 +++
 hw/net/xilinx_ethlite.c                       | 20 +++++--
 hw/ppc/virtex_ml507.c                         |  1 +
 hw/riscv/microchip_pfsoc.c                    |  1 +
 hw/riscv/opentitan.c                          |  1 +
 hw/riscv/sifive_u.c                           |  1 +
 hw/s390x/s390-virtio-ccw.c                    |  1 -
 hw/ssi/xilinx_spi.c                           | 24 +++++---
 hw/timer/xilinx_timer.c                       | 35 +++++++----
 hw/tpm/tpm_tis_sysbus.c                       |  3 +-
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
 60 files changed, 314 insertions(+), 248 deletions(-)

-- 
2.47.1


