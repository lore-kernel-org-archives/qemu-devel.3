Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A00EC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJRt-0001uD-7O; Fri, 12 Apr 2024 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRq-0001t4-FW
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRm-0004ZA-GP
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-343eb6cc46bso685109f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938091; x=1713542891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YPNUCG34JRtanqhu40n9+rt/oe0ODrWbJJWPvLvAacM=;
 b=AO2sDC3Q87jebDEjw2c6aO3gHudt6i0aeSwU3cr7/cmX6P7eB/xwroGt+mXC+gL+WW
 S62gJn6kVHzwAEhxiIub5mkxUFBa0jqK4ShuWNMcM8IGIwhkEkO5rufxae3fk6V8PX+H
 xO9OryDwlJ0YsKgWO62rAaJ0Yaq5A1KmFcTVB27zmdIllN9WdCAnVSZdDUO4d0PITRbT
 9uVtMQc6tbF6qBu2NI/RsDeU/41bdXnncVbiLxeXA0ZyAnYjeTSsLr2ivxiGo1Z0u2Nw
 IGZjTLTbHb0I6Njogf/YT3wrX1EVjEV1aADMKfDeAVPXqHncpVKmYzZ0mWkVc4ak1Bjc
 A2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938091; x=1713542891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPNUCG34JRtanqhu40n9+rt/oe0ODrWbJJWPvLvAacM=;
 b=fAjT+2r0QsXo5wJmg9Wre3DL2gbBN8caiturCBa5hXphY+cTLM2fiFQ7SZkEjDgSJT
 ZZaLhyoCdHjlsv5cBNEAhBbHnDV+mxWKZ7EMJBXHp3LjIX2JKGHlNR652JzBfa6HOF76
 VxPcb8LuUxbrwM42QYMZ1se2KpbAWM0DT5hWf9vdz3FKH0lR6NYfnbvfh4jVTawF6RI0
 QEBsr5o+oHyNgC0sZo1brCcQKUL2yHCwqJ/s/4w509zyOKoF1ubNu+BPWVJgmFSJ5Qg/
 YDCMkrs/llc6pOTiJGGj3kZerb7VY/oMdNXMHYOnEeVjqotDwhUGuXUWdGFQssOQAYAh
 IJ0w==
X-Gm-Message-State: AOJu0YyMm+mnvC+WigLRZDd/bJGFDrf774dycsxgdGIF/l5QdG3tFGVa
 WtCJGUOyW5FFdAc8+aBBX9w06RW44TPeb4gwuANb9OlKCRu1e3HadcItB7djxqsApmSSUhsP8oI
 L
X-Google-Smtp-Source: AGHT+IHN1mVsSN3sHhwLQidMwnAh/9/jM7SdbaODEOHCCesKN6OULHGizTP/zg8NzSLEMDch8apppg==
X-Received: by 2002:a5d:640b:0:b0:343:77f4:e663 with SMTP id
 z11-20020a5d640b000000b0034377f4e663mr1922582wru.18.1712938090609; 
 Fri, 12 Apr 2024 09:08:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cr12-20020a05600004ec00b00341ce80ea66sm4582371wrb.82.2024.04.12.09.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 09:08:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] reset: Add RESET_TYPE_SNAPSHOT_LOAD
Date: Fri, 12 Apr 2024 17:08:03 +0100
Message-Id: <20240412160809.1260625-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Some devices and machines need to handle the reset before a vmsave
snapshot is loaded differently -- the main user is the handling of
RNG seed information, which does not want to put a new RNG seed into
a ROM blob when we are doing a snapshot load.

Currently this kind of reset handling is supported only for:
 * TYPE_MACHINE reset methods, which take a ShutdownCause argument
 * reset functions registered with qemu_register_reset_nosnapshotload

Adding a new ResetType that indicates the pre-snapshot-load reset
allows code that implements reset via Resettable to also do this.
As an immediate consequence, that means we can clean up the ugly
global variable in reset.c that we use to implement the
qemu_register_reset_nosnapshotload() callbacks. Slightly longer
term, I'm looking at making TYPE_MACHINE a subtype of TYPE_DEVICE,
and converting the non-standard reset method of MachineClass into
a Resettable as a result, so we'll need this ResetType there too.

Adding a new reset type makes plain an awkwardness in our current
Resettable API: we only pass the ResetType in to the 'enter' phase
method, not 'hold' and 'exit', even though we have it available
in the calling code. To avoid annoying workarounds like implementing
an 'enter' method that stashes the ResetType for the later 'hold'
or 'exit' method to use, we change the signatures of the 'hold'
and 'exit' methods to also pass the ResetType. Patch 3 is a
Coccinelle script which implements the transformation of the code,
and patch 4 is the result of running that script, with no manual
tweaks. This is really the biggest part of this patchset.

Patch 6 is the actual addition of the new ResetType, which isn't
very complicated. There is a TODO comment in resettable.h that
claims that "ResettableState structure has to be expanded" to
add more ResetTypes, but I can't see any reason why this should
be, and I didn't find any discussion in the mailing list archives
about it, so I have gone ahead anyway...

thanks
-- PMM

Peter Maydell (6):
  hw/misc: Don't special case RESET_TYPE_COLD in npcm7xx_clk, gcr
  allwinner-i2c, adm1272: Use device_cold_reset() for software-triggered
    reset
  scripts/coccinelle: New script to add ResetType to hold and exit
    phases
  hw, target: Add ResetType argument to hold and exit phase methods
  docs/devel/reset: Update to new API for hold and exit phase methods
  reset: Add RESET_TYPE_SNAPSHOT_LOAD

 docs/devel/reset.rst                |  25 ++++--
 scripts/coccinelle/reset-type.cocci | 133 ++++++++++++++++++++++++++++
 include/hw/resettable.h             |   5 +-
 hw/adc/npcm7xx_adc.c                |   2 +-
 hw/arm/pxa2xx_pic.c                 |   2 +-
 hw/arm/smmu-common.c                |   2 +-
 hw/arm/smmuv3.c                     |   4 +-
 hw/arm/stellaris.c                  |  10 +--
 hw/audio/asc.c                      |   2 +-
 hw/char/cadence_uart.c              |   2 +-
 hw/char/sifive_uart.c               |   2 +-
 hw/core/cpu-common.c                |   2 +-
 hw/core/qdev.c                      |   4 +-
 hw/core/reset.c                     |  17 ++--
 hw/core/resettable.c                |   8 +-
 hw/display/virtio-vga.c             |   4 +-
 hw/gpio/npcm7xx_gpio.c              |   2 +-
 hw/gpio/pl061.c                     |   2 +-
 hw/gpio/stm32l4x5_gpio.c            |   2 +-
 hw/hyperv/vmbus.c                   |   2 +-
 hw/i2c/allwinner-i2c.c              |   5 +-
 hw/i2c/npcm7xx_smbus.c              |   2 +-
 hw/input/adb.c                      |   2 +-
 hw/input/ps2.c                      |  12 +--
 hw/intc/arm_gic_common.c            |   2 +-
 hw/intc/arm_gic_kvm.c               |   4 +-
 hw/intc/arm_gicv3_common.c          |   2 +-
 hw/intc/arm_gicv3_its.c             |   4 +-
 hw/intc/arm_gicv3_its_common.c      |   2 +-
 hw/intc/arm_gicv3_its_kvm.c         |   4 +-
 hw/intc/arm_gicv3_kvm.c             |   4 +-
 hw/intc/xics.c                      |   2 +-
 hw/m68k/q800-glue.c                 |   2 +-
 hw/misc/djmemc.c                    |   2 +-
 hw/misc/iosb.c                      |   2 +-
 hw/misc/mac_via.c                   |   8 +-
 hw/misc/macio/cuda.c                |   4 +-
 hw/misc/macio/pmu.c                 |   4 +-
 hw/misc/mos6522.c                   |   2 +-
 hw/misc/npcm7xx_clk.c               |  13 +--
 hw/misc/npcm7xx_gcr.c               |  12 +--
 hw/misc/npcm7xx_mft.c               |   2 +-
 hw/misc/npcm7xx_pwm.c               |   2 +-
 hw/misc/stm32l4x5_exti.c            |   2 +-
 hw/misc/stm32l4x5_rcc.c             |  10 +--
 hw/misc/stm32l4x5_syscfg.c          |   2 +-
 hw/misc/xlnx-versal-cframe-reg.c    |   2 +-
 hw/misc/xlnx-versal-crl.c           |   2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c  |   2 +-
 hw/misc/xlnx-versal-trng.c          |   2 +-
 hw/misc/xlnx-versal-xramc.c         |   2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c      |   2 +-
 hw/misc/xlnx-zynqmp-crf.c           |   2 +-
 hw/misc/zynq_slcr.c                 |   4 +-
 hw/net/can/xlnx-zynqmp-can.c        |   2 +-
 hw/net/e1000.c                      |   2 +-
 hw/net/e1000e.c                     |   2 +-
 hw/net/igb.c                        |   2 +-
 hw/net/igbvf.c                      |   2 +-
 hw/nvram/xlnx-bbram.c               |   2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c   |   2 +-
 hw/nvram/xlnx-zynqmp-efuse.c        |   2 +-
 hw/pci-bridge/cxl_root_port.c       |   4 +-
 hw/pci-bridge/pcie_root_port.c      |   2 +-
 hw/pci-host/bonito.c                |   2 +-
 hw/pci-host/pnv_phb.c               |   4 +-
 hw/pci-host/pnv_phb3_msi.c          |   4 +-
 hw/pci/pci.c                        |   4 +-
 hw/rtc/mc146818rtc.c                |   2 +-
 hw/s390x/css-bridge.c               |   2 +-
 hw/sensor/adm1266.c                 |   2 +-
 hw/sensor/adm1272.c                 |   4 +-
 hw/sensor/isl_pmbus_vr.c            |  10 +--
 hw/sensor/max31785.c                |   2 +-
 hw/sensor/max34451.c                |   2 +-
 hw/ssi/npcm7xx_fiu.c                |   2 +-
 hw/timer/etraxfs_timer.c            |   2 +-
 hw/timer/npcm7xx_timer.c            |   2 +-
 hw/usb/hcd-dwc2.c                   |   8 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c |   2 +-
 hw/virtio/virtio-pci.c              |   2 +-
 target/arm/cpu.c                    |   4 +-
 target/avr/cpu.c                    |   4 +-
 target/cris/cpu.c                   |   4 +-
 target/hexagon/cpu.c                |   4 +-
 target/i386/cpu.c                   |   4 +-
 target/loongarch/cpu.c              |   4 +-
 target/m68k/cpu.c                   |   4 +-
 target/microblaze/cpu.c             |   4 +-
 target/mips/cpu.c                   |   4 +-
 target/nios2/cpu.c                  |   4 +-
 target/openrisc/cpu.c               |   4 +-
 target/ppc/cpu_init.c               |   4 +-
 target/riscv/cpu.c                  |   4 +-
 target/rx/cpu.c                     |   4 +-
 target/sh4/cpu.c                    |   4 +-
 target/sparc/cpu.c                  |   4 +-
 target/tricore/cpu.c                |   4 +-
 target/xtensa/cpu.c                 |   4 +-
 99 files changed, 317 insertions(+), 195 deletions(-)
 create mode 100644 scripts/coccinelle/reset-type.cocci

-- 
2.34.1


