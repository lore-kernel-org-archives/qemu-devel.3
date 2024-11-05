Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C50CD40D08
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8T4p-0000F7-Rl; Tue, 05 Nov 2024 18:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8T4o-0000Dd-5y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:35:10 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8T4m-0005uZ-5s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 18:35:09 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99fa009adcso383950466b.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 15:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730849706; x=1731454506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r3lMxukWduCUE8byc7r6NbMVK9bemeU0okjQN121woY=;
 b=oS+0K72q0d9NuE+6xRJUnBXBJqI/ZSbfteQspA8wb4R3VvrOaHGjpfiwSGTl5kiWDk
 ajqv5QeLI9EpCKNCMErZqvrnKtn5FwvuxjB3YMvOh0ZTQIMYufdz0pE3hAl/ojPC492i
 ZzkrOzjzOhx4wKOwPm0AoXa4J9IWGyAhVfRLtTSbgccvlYuxbDti/DVRTqmWCbqndJ4n
 OcIshyVkFQ+3anPemXvM9iIWNqBuYUgk+FGyxi5xVRRxFnFMifT93xhCNrLiwQQoYVxn
 4IBpBtzx5c3FVOvPcuVd3ILsyBFYxM5rPN2F8p5RBw/chZP1Orv3BC7aJDEQxSn+n8u7
 NlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730849706; x=1731454506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3lMxukWduCUE8byc7r6NbMVK9bemeU0okjQN121woY=;
 b=vaZt2QNBki9eZCkDIM9Vmz32Y/wWP9p7T/mmqYVgCariYMZo7LMAGoFmyaeDpz4RJg
 S1VNMye8kV3EN1M7/ke8d81yPaaQzCZ1FTibni2Z91JuIdTn9tNX06A4Ex0yrm5Meaig
 o9u4GVVD/ME0OeCsz/ka3JxTnLjMfFG0ld26WCOi6N+g8ACQNOH57I4gS3AnESm/K1Vc
 JG/UVD6YDJ6LECqhDxgnarpKp5GdvR3aMbe7jVD8LLToxNyFOR/DW694FF3D2Dvjgxwr
 vd5jvvudD/OzsR/dc9J0a19koomfYoeHoIyJ0XTc6scuSdCL6yZwbwVpa1wkxVCCb5tt
 eOqg==
X-Gm-Message-State: AOJu0YzJHZibhWmv1ZzGGQgBaPbWBoCHITqkbYkzcgph4KAno0hAmtep
 WLtxQ1hs11Jn+xFVkHKNwmNrfADmMoKv33GeR3Wo8pWgvZcE/zMkwgQWcPhzWrKNmc7PVUG0RMJ
 mXqsLmA==
X-Google-Smtp-Source: AGHT+IFrHjKA9O1Dtdq6ugizNwLtKc6UK9YEvF0XLTgIgkvb+rRPeyxopqgM6WSjOrhIdCyCwo1SnA==
X-Received: by 2002:a05:6402:2102:b0:5ce:cff3:1fe5 with SMTP id
 4fb4d7f45d1cf-5cecff32129mr12608959a12.25.1730849705499; 
 Tue, 05 Nov 2024 15:35:05 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6a9a410sm1900319a12.13.2024.11.05.15.35.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 15:35:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/29] Misc HW patches for 2024-11-05
Date: Tue,  5 Nov 2024 23:35:02 +0000
Message-ID: <20241105233503.56812-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

The following changes since commit 44a9394b1d272b53306d097d4bc20ff7ad14b159:

  Merge tag 'pull-nvme-20241104' of https://gitlab.com/birkelund/qemu into staging (2024-11-05 14:23:22 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20241105

for you to fetch changes up to d37eede7a8e6ff33d21aacb41a68e63e8ffa1d60:

  hw/riscv/iommu: fix build error with clang (2024-11-05 23:32:25 +0000)

----------------------------------------------------------------
Misc HW patch queue

- Deprecate a pair of untested microblaze big-endian machines (Philippe)
- Arch-agnostic CPU topology checks at machine level (Zhao)
- Cleanups on PPC E500 (Bernhard)
- Various conversions to DEFINE_TYPES() macro (Bernhard)
- Fix RISC-V _pext_u64() name clashing (Pierrick)

----------------------------------------------------------------

Bernhard Beschow (17):
  hw/ppc/e500: Prefer QOM cast
  hw/ppc/e500: Remove unused "irqs" parameter
  hw/ppc/e500: Add missing device tree properties to i2c controller node
  hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
  hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
  hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
  hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
  hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
  hw/net/fsl_etsec/miim: Reuse MII constants
  hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
  hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
  hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
  hw/sd/sdhci: Prefer DEFINE_TYPES() macro
  hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
  hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
  hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
  hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro

Philippe Mathieu-Daudé (6):
  target/microblaze: Alias CPU endianness property as 'little-endian'
  hw/microblaze: Deprecate big-endian petalogix-ml605 & xlnx-zynqmp-pmu
  hw/microblaze/s3adsp1800: Explicit CPU endianness
  hw/microblaze/s3adsp1800: Rename unimplemented MMIO region as xps_gpio
  hw/microblaze/s3adsp1800: Declare machine type using DEFINE_TYPES
    macro
  hw/core/machine: Add missing 'units.h' and 'error-report.h' headers

Pierrick Bouvier (1):
  hw/riscv/iommu: fix build error with clang

Zhao Liu (5):
  i386/cpu: Don't enumerate the "invalid" CPU topology level
  hw/core: Make CPU topology enumeration arch-agnostic
  qapi/qom: Define cache enumeration and properties for machine
  hw/core: Check smp cache topology support for machine
  hw/core: Add a helper to check the cache topology level

 docs/about/deprecated.rst                     |   6 +
 .../devices/microblaze-softmmu/default.mak    |   2 -
 .../devices/microblazeel-softmmu/default.mak  |   5 +-
 qapi/machine-common.json                      |  94 ++++++++++-
 include/hw/boards.h                           |  16 ++
 include/hw/i386/topology.h                    |  22 +--
 target/i386/cpu.h                             |   4 +-
 hw/block/pflash_cfi01.c                       |  21 +--
 hw/core/machine-smp.c                         | 126 +++++++++++++++
 hw/core/machine.c                             |  46 ++++++
 hw/gpio/mpc8xxx.c                             |  22 ++-
 hw/i2c/mpc_i2c.c                              |  29 ++--
 hw/i2c/smbus_eeprom.c                         |  19 +--
 hw/i386/x86-common.c                          |   4 +-
 hw/microblaze/petalogix_ml605_mmu.c           |   9 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  21 ++-
 hw/microblaze/xlnx-zynqmp-pmu.c               |  10 +-
 hw/net/fsl_etsec/etsec.c                      |  22 ++-
 hw/net/fsl_etsec/miim.c                       |  19 +--
 hw/pci-host/ppce500.c                         |  44 +++--
 hw/ppc/e500.c                                 |  10 +-
 hw/ppc/mpc8544_guts.c                         |  32 ++--
 hw/riscv/riscv-iommu.c                        |  23 ++-
 hw/rtc/ds1338.c                               |  20 +--
 hw/sd/sdhci.c                                 |  62 +++----
 hw/usb/hcd-ehci-sysbus.c                      | 118 ++++++--------
 target/i386/cpu.c                             | 151 +++++++++---------
 target/microblaze/cpu.c                       |  10 ++
 hw/i2c/trace-events                           |   5 +
 29 files changed, 625 insertions(+), 347 deletions(-)

-- 
2.45.2


