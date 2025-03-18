Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueYA-0001MJ-9s; Tue, 18 Mar 2025 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXp-0001EC-0B
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXl-0000iX-7D
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2260c915749so40610945ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333530; x=1742938330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EHnHeJlvlcB/V357qU8iLPSSLgx5/tZd4zZ6ZukNaUM=;
 b=DzuV855d8gQnnMlUtThg/e5y9Cj9+ZJ6su9q1HMwlbZeIx7NoKAumTgkfGfbueiDF3
 ergZ2Cjk6I4jl3FCYwdrpYdTE9pvB06a1bmDkWe+j94F8pHP3E/D11eis5lTKKnzjg3+
 vuwOzA/dp/r7H1dFxSXfQtVztYBxokr7ub85wTZn3YRqOV40tSd7RX3J8Z/crXTLuJF4
 AzqFm7fc32AUsyniybORgVlcMZg+FmDNvaDWiOJUDlQVAUjVOpTk6N0ZjvQOOICxU/+9
 /D382kG8KtmtyUnd4r8lvF11ledgtAvDzr8SqN2USvo8n6DeG02rNbxkLse/9JdAVYIC
 ow+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333530; x=1742938330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHnHeJlvlcB/V357qU8iLPSSLgx5/tZd4zZ6ZukNaUM=;
 b=cbih9axL2r71A4b3Wr6RNu4p1W7jvWBiKPLEOmZo8+JBLXk/AAZsM/TJgb+pVWZ4tm
 XfnyUtOyvpG3kAs0EgvUqwzhSviQpwTrQmLXwof6NpUHA//BxjyHZT29x7MlVN4sA9TZ
 wNrb8kW8x8oOscOT8MIZOwhkaHZvihy5XW08p/A70vWieIM4R7xIBAXVnKbahlAGtAab
 Rc78KUGD90iI2VLFeb+WPo2AOFJ1rpx/RxNBrJ3SHReo+0Sp9wGqEVb9I2sLR8llOye6
 cMwnRHDZPEZXr4vyLRa6GeGPJX2hVdXgrkQi9gDYdkIQXph1E4KGRgl/U/2Eb+sEFtjk
 ONGQ==
X-Gm-Message-State: AOJu0YzPp48bGmclW7LUAFOb/FDKTmdeYrGqedERreQYDLmpJUFDDHAk
 GKFdIZyvK2zdVw2ktjEneXhuO3l6A434Cq6z5eWbardeP4WOz25NJYRAfj3+s+glM1dJcX0SZhm
 C
X-Gm-Gg: ASbGnct97Hl4jl4szwZOII5yRV8WZZiUaCze+BV5jh8/xTjSZKMo3UjUSWA4+t5CRfF
 LasRhKB73qF5AkEoJerl0ECwuNpwT2r62IdFfSPt4aVLbPuQ2uyxhBiD+HaNyWReDeEtIQVUCKf
 VhF36iey0p4vsc22xbEWTitxlhTTc5JQ6cgL91yW6Xf3scf8I7TZFA9ggYmuKI6Uulp+y6zj37S
 ihsjO2dJ0+DafoLc8VTIQu4aTUZrHYp9cNpEsR4ljzNr1Ut3R6ZVLGGyY5LC7JqXCcTGEOse16X
 vImwshbpoueGHyyKx/9QlEXT9Yb0nVRJczzrjQGPqqC8gP4R8JhD7WF8obvZCQeQs/59DqyauX+
 M
X-Google-Smtp-Source: AGHT+IEdhW8AIHWUKDJfZkMSwhqLPBelPZdV2OlQROkng2SjPTDV5EWrFDC+qdCzZzz45S4G6pqRAw==
X-Received: by 2002:a05:6a21:496:b0:1f5:837b:1880 with SMTP id
 adf61e73a8af0-1fbebd7b8d1mr319006637.23.1742333530314; 
 Tue, 18 Mar 2025 14:32:10 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 00/42] accel/tcg, codebase: Build once patches
Date: Tue, 18 Mar 2025 14:31:25 -0700
Message-ID: <20250318213209.2579218-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Based-on: 20250317183417.285700-1-pierrick.bouvier@linaro.org
("[PATCH v6 00/18] make system memory API available for common code")

v1: 20250313034524.3069690-1-richard.henderson@linaro.org

A number of bugs have been fixed from v1, and small adjustments.
Phil came up with a better version of one of my patches, and I
have replaced mine.  Now based on Pierrick's v6 memory.h work.

This is all together at

  https://gitlab.com/rth7680/qemu.git tcg-next


r~


Philippe Mathieu-Daudé (2):
  accel/tcg: Remove unnecesary inclusion of memory-internal.h in
    cputlb.c
  exec: Restrict memory-internal.h to system/

Richard Henderson (40):
  accel/tcg: Build user-exec-stub.c once
  accel/tcg: Build plugin-gen.c once
  accel/tcg: Fix cpu_ld*_code_mmu for user mode
  include/exec: Use vaddr for *_mmu guest memory access routines
  include/exec: Split out cpu-ldst-common.h
  include/exec: Split out cpu-mmu-index.h
  include/exec: Inline *_mmuidx_ra memory operations
  include/exec: Inline *_data_ra memory operations
  include/exec: Inline *_data memory operations
  include/exec: Inline *_code memory operations
  accel/tcg: Perform aligned atomic reads in translator_ld
  accel/tcg: Use cpu_ld*_code_mmu in translator.c
  accel/tcg: Implement translator_ld*_end
  accel/tcg: Remove mmap_lock/unlock from watchpoint.c
  include/exec: Split out mmap-lock.h
  include/system: Move exec/memory.h to system/memory.h
  include/system: Move exec/address-spaces.h to system/address-spaces.h
  include/system: Move exec/ioport.h to system/ioport.h
  include/system: Move exec/ram_addr.h to system/ram_addr.h
  include/system: Move exec/ramblock.h to system/ramblock.h
  meson: Introduce top-level libuser_ss and libsystem_ss
  gdbstub: Move syscalls.c out of common_ss
  accel/tcg: Use libuser_ss and libsystem_ss
  semihosting: Move user-only implementation out-of-line
  target/mips: Restrict semihosting tests to system mode
  target/xtensa: Restrict semihosting tests to system mode
  include/exec: Split out watchpoint.h
  hw/core: Move unconditional files to libsystem_ss, libuser_ss
  system: Move most files to libsystem_ss
  plugins: Move api.c, core.c to libuser_ss, libsystem_ss
  include/exec: Drop ifndef CONFIG_USER_ONLY from cpu-common.h
  include/hw/core: Drop ifndef CONFIG_USER_ONLY from cpu.h
  include/hw/intc: Remove ifndef CONFIG_USER_ONLY from armv7m_nvic.h
  include/hw/s390x: Remove ifndef CONFIG_USER_ONLY in css.h
  include/exec: Split out icount.h
  include/exec: Protect icount_enabled from poisoned symbols
  include/system: Remove ifndef CONFIG_USER_ONLY in qtest.h
  include/qemu: Remove ifndef CONFIG_USER_ONLY from accel.h
  target/riscv: Remove ifndef CONFIG_USER_ONLY from cpu_cfg.h
  meson: Only allow CONFIG_USER_ONLY from certain source sets

 accel/tcg/atomic_template.h                 |  16 +-
 accel/tcg/internal-target.h                 |   1 +
 hw/arm/strongarm.h                          |   2 +-
 hw/display/apple-gfx.h                      |   2 +-
 hw/display/framebuffer.h                    |   2 +-
 hw/display/vga_int.h                        |   4 +-
 hw/hyperv/hv-balloon-our_range_memslots.h   |   2 +-
 hw/intc/ioapic_internal.h                   |   2 +-
 hw/net/i82596.h                             |   4 +-
 hw/net/pcnet.h                              |   2 +-
 hw/s390x/ipl.h                              |   2 +-
 hw/tpm/tpm_ppi.h                            |   2 +-
 hw/usb/hcd-uhci.h                           |   2 +-
 hw/vfio/pci.h                               |   2 +-
 hw/virtio/vhost-iova-tree.h                 |   2 +-
 include/exec/cpu-all.h                      |  10 +-
 include/exec/cpu-common.h                   |  26 -
 include/exec/cpu-ldst-common.h              | 122 +++++
 include/exec/cpu-mmu-index.h                |  39 ++
 include/exec/cpu_ldst.h                     | 540 +++++++++++++-------
 include/exec/icount.h                       |  76 +++
 include/exec/mmap-lock.h                    |  33 ++
 include/exec/page-protection.h              |  22 -
 include/exec/poison.h                       |   5 +
 include/exec/translator.h                   |  50 +-
 include/exec/watchpoint.h                   |  41 ++
 include/hw/acpi/acpi.h                      |   2 +-
 include/hw/acpi/ich9_tco.h                  |   2 +-
 include/hw/arm/fsl-imx25.h                  |   2 +-
 include/hw/arm/fsl-imx31.h                  |   2 +-
 include/hw/arm/fsl-imx6.h                   |   2 +-
 include/hw/arm/fsl-imx6ul.h                 |   2 +-
 include/hw/arm/omap.h                       |   2 +-
 include/hw/arm/stm32l4x5_soc.h              |   2 +-
 include/hw/boards.h                         |   2 +-
 include/hw/char/parallel-isa.h              |   2 +-
 include/hw/char/parallel.h                  |   2 +-
 include/hw/char/riscv_htif.h                |   2 +-
 include/hw/char/serial-mm.h                 |   2 +-
 include/hw/char/serial.h                    |   2 +-
 include/hw/core/cpu.h                       |  40 --
 include/hw/display/macfb.h                  |   2 +-
 include/hw/dma/i8257.h                      |   2 +-
 include/hw/fsi/aspeed_apb2opb.h             |   2 +-
 include/hw/fsi/cfam.h                       |   2 +-
 include/hw/fsi/fsi-master.h                 |   2 +-
 include/hw/fsi/fsi.h                        |   2 +-
 include/hw/fsi/lbus.h                       |   2 +-
 include/hw/gpio/npcm7xx_gpio.h              |   2 +-
 include/hw/hw.h                             |   4 -
 include/hw/i2c/npcm7xx_smbus.h              |   2 +-
 include/hw/i2c/pm_smbus.h                   |   2 +-
 include/hw/i386/apic_internal.h             |   2 +-
 include/hw/i386/x86.h                       |   2 +-
 include/hw/ide/ahci.h                       |   2 +-
 include/hw/ide/ide-bus.h                    |   2 +-
 include/hw/intc/armv7m_nvic.h               |  14 -
 include/hw/ipmi/ipmi.h                      |   2 +-
 include/hw/isa/apm.h                        |   2 +-
 include/hw/isa/isa.h                        |   4 +-
 include/hw/m68k/q800.h                      |   2 +-
 include/hw/mem/npcm7xx_mc.h                 |   2 +-
 include/hw/mem/pc-dimm.h                    |   2 +-
 include/hw/mips/mips.h                      |   2 +-
 include/hw/misc/auxbus.h                    |   2 +-
 include/hw/misc/ivshmem-flat.h              |   2 +-
 include/hw/misc/lasi.h                      |   2 +-
 include/hw/misc/mac_via.h                   |   2 +-
 include/hw/misc/npcm7xx_mft.h               |   2 +-
 include/hw/misc/npcm_clk.h                  |   2 +-
 include/hw/misc/npcm_gcr.h                  |   2 +-
 include/hw/misc/pvpanic.h                   |   2 +-
 include/hw/net/dp8393x.h                    |   2 +-
 include/hw/net/msf2-emac.h                  |   2 +-
 include/hw/nubus/nubus.h                    |   2 +-
 include/hw/nvram/mac_nvram.h                |   2 +-
 include/hw/nvram/npcm7xx_otp.h              |   2 +-
 include/hw/pci-host/fsl_imx8m_phy.h         |   2 +-
 include/hw/pci-host/pam.h                   |   2 +-
 include/hw/pci-host/remote.h                |   2 +-
 include/hw/pci/pci.h                        |   2 +-
 include/hw/pci/pcie_host.h                  |   2 +-
 include/hw/pci/shpc.h                       |   2 +-
 include/hw/ppc/mac_dbdma.h                  |   2 +-
 include/hw/ppc/pnv_lpc.h                    |   2 +-
 include/hw/ppc/pnv_occ.h                    |   2 +-
 include/hw/ppc/pnv_sbe.h                    |   2 +-
 include/hw/ppc/pnv_xscom.h                  |   2 +-
 include/hw/ppc/ppc4xx.h                     |   2 +-
 include/hw/ppc/vof.h                        |   4 +-
 include/hw/ppc/xics.h                       |   2 +-
 include/hw/register.h                       |   2 +-
 include/hw/remote/proxy-memory-listener.h   |   2 +-
 include/hw/s390x/css.h                      |   2 -
 include/hw/sh4/sh_intc.h                    |   2 +-
 include/hw/southbridge/ich9.h               |   2 +-
 include/hw/sysbus.h                         |   2 +-
 include/hw/timer/npcm7xx_timer.h            |   2 +-
 include/hw/tricore/triboard.h               |   2 +-
 include/hw/tricore/tricore.h                |   2 +-
 include/hw/usb.h                            |   2 +-
 include/hw/vfio/vfio-common.h               |   2 +-
 include/hw/vfio/vfio-container-base.h       |   2 +-
 include/hw/virtio/vhost-backend.h           |   2 +-
 include/hw/virtio/vhost.h                   |   2 +-
 include/hw/virtio/virtio.h                  |   2 +-
 include/hw/xen/xen-pvh-common.h             |   2 +-
 include/hw/xtensa/mx_pic.h                  |   2 +-
 include/qemu/accel.h                        |  10 +-
 include/qemu/iova-tree.h                    |   2 +-
 include/qemu/reserved-region.h              |   2 +-
 include/semihosting/semihost.h              |  29 +-
 include/{exec => system}/address-spaces.h   |   8 +-
 include/system/confidential-guest-support.h |   4 -
 include/system/cpu-timers.h                 |  58 ---
 include/system/dma.h                        |   4 +-
 include/system/hostmem.h                    |   2 +-
 include/{exec => system}/ioport.h           |   8 +-
 include/system/kvm_int.h                    |   2 +-
 include/{exec => system}/memory.h           |   8 +-
 include/system/qtest.h                      |   2 -
 include/{exec => system}/ram_addr.h         |  11 +-
 include/{exec => system}/ramblock.h         |   9 +-
 include/system/replay.h                     |   4 -
 include/system/vhost-user-backend.h         |   2 +-
 include/system/xen.h                        |   4 -
 migration/rdma.h                            |   2 +-
 rust/wrapper.h                              |   4 +-
 {include/exec => system}/memory-internal.h  |   6 -
 target/i386/hvf/vmx.h                       |   2 +-
 target/loongarch/cpu.h                      |   2 +-
 target/mips/cpu.h                           |   2 +-
 target/riscv/cpu_cfg.h                      |   2 -
 accel/hvf/hvf-accel-ops.c                   |   2 +-
 accel/kvm/kvm-all.c                         |   4 +-
 accel/tcg/cpu-exec.c                        |   3 +-
 accel/tcg/cputlb.c                          |  41 +-
 accel/tcg/icount-common.c                   |   2 +-
 accel/tcg/monitor.c                         |   1 +
 accel/tcg/plugin-gen.c                      |  13 +-
 accel/tcg/tb-maint.c                        |   1 +
 accel/tcg/tcg-accel-ops-icount.c            |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c             |   2 +-
 accel/tcg/tcg-accel-ops-rr.c                |   2 +-
 accel/tcg/tcg-accel-ops.c                   |   3 +-
 accel/tcg/tcg-all.c                         |   2 +-
 accel/tcg/translate-all.c                   |   5 +-
 accel/tcg/translator.c                      | 120 +++--
 accel/tcg/user-exec.c                       |  89 +---
 accel/tcg/watchpoint.c                      |   3 -
 backends/tpm/tpm_util.c                     |   2 +-
 block/blkio.c                               |   4 +-
 disas/disas-mon.c                           |   2 +-
 hw/acpi/erst.c                              |   4 +-
 hw/arm/aspeed_ast10x0.c                     |   2 +-
 hw/arm/bananapi_m2u.c                       |   2 +-
 hw/arm/collie.c                             |   2 +-
 hw/arm/exynos4_boards.c                     |   2 +-
 hw/arm/fsl-imx31.c                          |   2 +-
 hw/arm/fsl-imx8mp.c                         |   2 +-
 hw/arm/imx8mp-evk.c                         |   2 +-
 hw/arm/integratorcp.c                       |   2 +-
 hw/arm/kzm.c                                |   2 +-
 hw/arm/microbit.c                           |   2 +-
 hw/arm/mps2-tz.c                            |   2 +-
 hw/arm/mps2.c                               |   2 +-
 hw/arm/mps3r.c                              |   2 +-
 hw/arm/msf2-soc.c                           |   2 +-
 hw/arm/msf2-som.c                           |   2 +-
 hw/arm/musca.c                              |   2 +-
 hw/arm/omap1.c                              |   2 +-
 hw/arm/omap_sx1.c                           |   2 +-
 hw/arm/orangepi.c                           |   2 +-
 hw/arm/stellaris.c                          |   2 +-
 hw/arm/stm32f100_soc.c                      |   2 +-
 hw/arm/stm32f205_soc.c                      |   2 +-
 hw/arm/stm32f405_soc.c                      |   2 +-
 hw/arm/stm32l4x5_soc.c                      |   2 +-
 hw/avr/atmega.c                             |   4 +-
 hw/block/fdc-isa.c                          |   2 +-
 hw/block/fdc-sysbus.c                       |   2 +-
 hw/char/goldfish_tty.c                      |   2 +-
 hw/char/omap_uart.c                         |   2 +-
 hw/char/riscv_htif.c                        |   2 +-
 hw/core/cpu-system.c                        |   4 +-
 hw/core/loader-fit.c                        |   2 +-
 hw/core/loader.c                            |   2 +-
 hw/core/null-machine.c                      |   2 +-
 hw/core/ptimer.c                            |   2 +-
 hw/core/sysbus.c                            |   2 +-
 hw/display/edid-region.c                    |   2 +-
 hw/display/virtio-gpu-udmabuf.c             |   2 +-
 hw/dma/rc4030.c                             |   2 +-
 hw/hyperv/hv-balloon.c                      |   4 +-
 hw/hyperv/hyperv.c                          |   4 +-
 hw/i386/acpi-common.c                       |   2 +-
 hw/i386/acpi-microvm.c                      |   2 +-
 hw/i386/kvm/xen_evtchn.c                    |   2 +-
 hw/i386/kvm/xen_gnttab.c                    |   2 +-
 hw/i386/kvm/xen_overlay.c                   |   2 +-
 hw/i386/pc_piix.c                           |   2 +-
 hw/i386/sgx-epc.c                           |   2 +-
 hw/i386/sgx.c                               |   2 +-
 hw/i386/vapic.c                             |   2 +-
 hw/ide/ahci-sysbus.c                        |   2 +-
 hw/input/lasips2.c                          |   2 +-
 hw/intc/loongarch_extioi.c                  |   2 +-
 hw/intc/mips_gic.c                          |   2 +-
 hw/intc/ompic.c                             |   2 +-
 hw/intc/riscv_aplic.c                       |   2 +-
 hw/intc/riscv_imsic.c                       |   2 +-
 hw/loongarch/virt.c                         |   2 +-
 hw/mem/memory-device.c                      |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c         |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c    |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c             |   2 +-
 hw/mips/mipssim.c                           |   2 +-
 hw/misc/allwinner-h3-dramc.c                |   2 +-
 hw/misc/allwinner-r40-dramc.c               |   2 +-
 hw/misc/ivshmem-flat.c                      |   2 +-
 hw/misc/mac_via.c                           |   2 +-
 hw/net/i82596.c                             |   2 +-
 hw/net/ne2000.c                             |   2 +-
 hw/nvram/fw_cfg.c                           |   2 +-
 hw/openrisc/openrisc_sim.c                  |   2 +-
 hw/openrisc/virt.c                          |   2 +-
 hw/pci-bridge/pci_bridge_dev.c              |   2 +-
 hw/pci-host/mv64361.c                       |   2 +-
 hw/pci-host/remote.c                        |   2 +-
 hw/ppc/pegasos2.c                           |   2 +-
 hw/ppc/pnv_homer.c                          |   2 +-
 hw/ppc/pnv_psi.c                            |   2 +-
 hw/ppc/ppc4xx_sdram.c                       |   2 +-
 hw/ppc/prep_systemio.c                      |   2 +-
 hw/ppc/rs6000_mc.c                          |   2 +-
 hw/ppc/sam460ex.c                           |   2 +-
 hw/ppc/spapr.c                              |   2 +-
 hw/ppc/spapr_caps.c                         |   2 +-
 hw/ppc/spapr_ovec.c                         |   2 +-
 hw/ppc/spapr_pci.c                          |   2 +-
 hw/ppc/vof.c                                |   2 +-
 hw/remote/iommu.c                           |   4 +-
 hw/remote/machine.c                         |   2 +-
 hw/remote/memory.c                          |   2 +-
 hw/remote/proxy-memory-listener.c           |   4 +-
 hw/remote/vfio-user-obj.c                   |   2 +-
 hw/riscv/microblaze-v-generic.c             |   2 +-
 hw/riscv/opentitan.c                        |   2 +-
 hw/riscv/shakti_c.c                         |   2 +-
 hw/s390x/css.c                              |   2 +-
 hw/s390x/s390-pci-inst.c                    |   2 +-
 hw/s390x/s390-skeys.c                       |   2 +-
 hw/s390x/s390-stattrib-kvm.c                |   2 +-
 hw/s390x/s390-stattrib.c                    |   2 +-
 hw/s390x/s390-virtio-ccw.c                  |   2 +-
 hw/s390x/virtio-ccw.c                       |   2 +-
 hw/sparc/sun4m_iommu.c                      |   2 +-
 hw/sparc64/sun4u_iommu.c                    |   2 +-
 hw/timer/hpet.c                             |   2 +-
 hw/timer/sh_timer.c                         |   2 +-
 hw/tpm/tpm_crb.c                            |   2 +-
 hw/vfio/ap.c                                |   2 +-
 hw/vfio/ccw.c                               |   2 +-
 hw/vfio/common.c                            |   7 +-
 hw/vfio/container.c                         |   6 +-
 hw/vfio/platform.c                          |   4 +-
 hw/vfio/spapr.c                             |   4 +-
 hw/virtio/vhost-user.c                      |   2 +-
 hw/virtio/vhost-vdpa.c                      |   2 +-
 hw/virtio/virtio-balloon.c                  |   2 +-
 hw/virtio/virtio-bus.c                      |   2 +-
 hw/virtio/virtio-mem.c                      |   2 +-
 hw/xtensa/sim.c                             |   2 +-
 hw/xtensa/virt.c                            |   2 +-
 hw/xtensa/xtensa_memory.c                   |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 linux-user/arm/cpu_loop.c                   |   1 +
 linux-user/elfload.c                        |   1 +
 linux-user/flatload.c                       |   1 +
 linux-user/mmap.c                           |   1 +
 linux-user/syscall.c                        |   1 +
 migration/dirtyrate.c                       |   4 +-
 migration/file.c                            |   2 +-
 migration/multifd-nocomp.c                  |   2 +-
 migration/multifd-qatzip.c                  |   2 +-
 migration/multifd-qpl.c                     |   2 +-
 migration/multifd-uadk.c                    |   2 +-
 migration/multifd-zero-page.c               |   2 +-
 migration/multifd-zlib.c                    |   2 +-
 migration/multifd-zstd.c                    |   2 +-
 migration/multifd.c                         |   2 +-
 migration/postcopy-ram.c                    |   2 +-
 migration/ram.c                             |   2 +-
 migration/rdma.c                            |   2 +-
 migration/savevm.c                          |   2 +-
 monitor/hmp-cmds-target.c                   |   4 +-
 monitor/hmp-cmds.c                          |   4 +-
 replay/replay.c                             |   2 +-
 semihosting/uaccess.c                       |   1 +
 semihosting/user.c                          |  15 +
 stubs/icount.c                              |   2 +-
 stubs/ram-block.c                           |   2 +-
 system/cpu-timers.c                         |   1 +
 system/dirtylimit.c                         |   2 +-
 system/dma-helpers.c                        |   2 +-
 system/ioport.c                             |   6 +-
 system/memory.c                             |  10 +-
 system/memory_mapping.c                     |   4 +-
 system/physmem.c                            |   9 +-
 system/qtest.c                              |   4 +-
 system/vl.c                                 |   1 +
 system/watchpoint.c                         |   1 +
 target/arm/debug_helper.c                   |   1 +
 target/arm/gdbstub64.c                      |   3 +
 target/arm/helper.c                         |   2 +
 target/arm/hvf/hvf.c                        |   2 +-
 target/arm/kvm.c                            |   2 +-
 target/arm/tcg/mte_helper.c                 |   2 +-
 target/avr/helper.c                         |   2 +-
 target/hppa/mem_helper.c                    |   1 +
 target/i386/cpu-apic.c                      |   2 +-
 target/i386/cpu.c                           |   3 +-
 target/i386/kvm/xen-emu.c                   |   2 +-
 target/i386/machine.c                       |   2 +-
 target/i386/nvmm/nvmm-all.c                 |   4 +-
 target/i386/sev.c                           |   2 +-
 target/i386/tcg/system/bpt_helper.c         |   1 +
 target/i386/tcg/system/misc_helper.c        |   2 +-
 target/i386/tcg/system/tcg-cpu.c            |   2 +-
 target/i386/tcg/translate.c                 |   1 +
 target/i386/whpx/whpx-all.c                 |   4 +-
 target/loongarch/cpu_helper.c               |   1 +
 target/loongarch/kvm/kvm.c                  |   2 +-
 target/microblaze/helper.c                  |   1 +
 target/microblaze/mmu.c                     |   1 +
 target/mips/cpu.c                           |   7 +-
 target/openrisc/translate.c                 |   1 +
 target/ppc/cpu.c                            |   1 +
 target/ppc/cpu_init.c                       |   2 +-
 target/ppc/kvm.c                            |   2 +-
 target/riscv/cpu_helper.c                   |   2 +-
 target/riscv/csr.c                          |   2 +-
 target/riscv/debug.c                        |   2 +
 target/riscv/kvm/kvm-cpu.c                  |   2 +-
 target/riscv/machine.c                      |   2 +-
 target/riscv/pmu.c                          |   2 +-
 target/s390x/helper.c                       |   1 +
 target/s390x/kvm/kvm.c                      |   2 +-
 target/s390x/mmu_helper.c                   |   2 +-
 target/s390x/sigp.c                         |   2 +-
 target/s390x/tcg/excp_helper.c              |   3 +-
 target/sparc/cpu.c                          |   1 +
 target/sparc/mmu_helper.c                   |   1 +
 target/tricore/helper.c                     |   1 +
 target/xtensa/cpu.c                         |   2 +-
 target/xtensa/dbg_helper.c                  |   3 +-
 target/xtensa/mmu_helper.c                  |   1 +
 target/xtensa/translate.c                   |  24 +-
 tests/qtest/fuzz/generic_fuzz.c             |   4 +-
 tests/qtest/fuzz/qos_fuzz.c                 |   2 +-
 tests/qtest/fuzz/qtest_wrappers.c           |   2 +-
 tests/unit/test-resv-mem.c                  |   2 +-
 ui/console.c                                |   2 +-
 util/async.c                                |   2 +-
 util/main-loop.c                            |   1 +
 util/qemu-timer.c                           |   1 +
 util/vfio-helpers.c                         |   2 +-
 MAINTAINERS                                 |  10 +-
 accel/tcg/ldst_common.c.inc                 | 335 +-----------
 accel/tcg/meson.build                       |  25 +-
 docs/devel/memory.rst                       |   2 +-
 gdbstub/meson.build                         |  36 +-
 hw/core/meson.build                         |   4 +-
 hw/display/apple-gfx.m                      |   2 +-
 meson.build                                 |  24 +
 plugins/meson.build                         |   5 +-
 scripts/analyze-inclusions                  |   2 +-
 semihosting/meson.build                     |   2 +
 system/meson.build                          |   7 +-
 tcg/meson.build                             |  23 +-
 380 files changed, 1340 insertions(+), 1369 deletions(-)
 create mode 100644 include/exec/cpu-ldst-common.h
 create mode 100644 include/exec/cpu-mmu-index.h
 create mode 100644 include/exec/icount.h
 create mode 100644 include/exec/mmap-lock.h
 create mode 100644 include/exec/watchpoint.h
 rename include/{exec => system}/address-spaces.h (89%)
 rename include/{exec => system}/ioport.h (96%)
 rename include/{exec => system}/memory.h (99%)
 rename include/{exec => system}/ram_addr.h (99%)
 rename include/{exec => system}/ramblock.h (96%)
 rename {include/exec => system}/memory-internal.h (88%)
 create mode 100644 semihosting/user.c

-- 
2.43.0


