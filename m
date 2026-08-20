Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC4C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 02:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwspp-0001pq-OV; Wed, 19 Aug 2026 22:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspi-0001pA-QL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:47 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kylefoxaustin.github@gmail.com>)
 id 1wwspg-0000IL-KE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 22:48:46 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66bee06ff74so2624794d50.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 19:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787194122; x=1787798922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XcvZD0VAihWuOrA7ZB8scy6ZZcyX8R0a7z6aaXLjTOM=;
 b=XKu4HtBVMR0h93PSmtPoPa9/nLjliNllXjdmmI/NrVdhxnE0OmKvNmTQWCziwsUU+I
 zfC5ROUInM8OjPIjtbVDUr2jT20efstxQRMSP9hoUKRI1CHxx8l2XvMz6amgc4QQM2bE
 Hj9p/jI7V+/I+4/rv8fiCPb6Sdz/nE+V4DXh0bbCPYc7eTZ1YQOJ4tQkrfCGqsheqSWz
 PXmfMOqHN7KGLM9rS08KuyZ+sx9PAWSIhDlqwKvsmdZaXAHF5p9CcTaCAPiCCFaYqgAA
 w/VsJg6d4tbC/dn5zPWl6spYmgKdwRQ4ZgyJmqStakI73wCfNwuDq+YeYp675DvYmSaC
 XKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787194122; x=1787798922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XcvZD0VAihWuOrA7ZB8scy6ZZcyX8R0a7z6aaXLjTOM=;
 b=b5GvkGKQ8R34SDajB/PEi8ZwvJpwVBrMlmIvqyhFWXOY7Arm43oGf9yjEDfXIsI1eb
 wJPoen4+RF+pPQPyiT3eLlE2uRJbbLm+j12CgDxLb0o8Nb6D3oRJEbOnSTMBt84cLpGE
 BVVLSIOB9vDtwXKlT0yXaRSYFAN0j9uObDvrBevm6c2IXna56k1c4FizYuqEonSZT4WV
 o7whdKSyvBuA6L55ntb4HPoLzUzXY71BuRqMVelBxN3l14CkQ8+oImiVgdnNVkHcKQHP
 UyqUB3O/6lvZb3gEJVJ83uZFfYZETVgvVFtrKgJfTK8C2TIO3azwccKGo5BFPib61FPs
 AwrQ==
X-Gm-Message-State: AFuF++msx2G4GvbOTnYKybPN2TX1cPa7Oaxa52Ldu9b3EEJ6nJCfNF0g
 eETderCCA0JwglsVbWWRDVObUVXtBHwm/4WgqkrwTSB6RvVtR06YSAr/Rot6QQ==
X-Gm-Gg: AR+sD107oigDX8XoeQQEt5DTWwAZz7pvtScWAUT//LpkgU94z9TAu810mVzomVu9cV3
 BVCeF6B4PezQAUEY6zWLYbZUBXIsyNVUYKEIeNPiy8NQejYQLIxB/QsYUKcPHRneDLbLrMHV14j
 O2uIFlknjZYtn4v9Puy66LkSaLMUrmB40/vBcoWKQO7+VaLBs2moO6hC/niO4aP5KZpmCxt486p
 XvpyP1tz8HV3DqvP9ZEc+g8t8VOTeX2g2LXN3+jYRYHckBT5Xbt2JTjHXBZnwwzTp/wqCpHS5ex
 cvG5Kl2+IDY1MyQqoE8Ydp2NNAzYoyHHW34V/iNIvvB464WqMLFfJ5JCAw98IoFkVN5lJDuNFve
 NrwRYcvWvIIcjqeBdWb3YmkpK90lCyhnmNcsuG5ew4jqz0ysCENoXy6b0UZWYRtNGXTMuWHDVBu
 CiRXhNqWz7XwE1UOv33sEPOATKMEFJBnAFj4WTzcQigbVJ6F6/ETPryrdWl4yAwb/8L+e3w0dCB
 OTnxC9w3TuanO2eGZyNa+Qx4eEBGKjlSDig9JdbE2FPw7J12ifqFcYpF/11aZ8WVwkecg==
X-Received: by 2002:a05:690e:4505:10b0:667:aa5c:d2d1 with SMTP id
 956f58d0204a3-66ccb65a09bmr2434884d50.38.1787194121790; 
 Wed, 19 Aug 2026 19:48:41 -0700 (PDT)
Received: from skippy.localdomain (99-61-67-1.lightspeed.austtx.sbcglobal.net.
 [99.61.67.1]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66ccafd03basm1986454d50.1.2026.08.19.19.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 19:48:40 -0700 (PDT)
From: Kyle Fox <kylefoxaustin.github@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kyle Fox <kylefoxaustin.github@gmail.com>
Subject: [PATCH 00/16] hw/arm: add the NXP i.MX 95 EVK machine
Date: Wed, 19 Aug 2026 21:48:18 -0500
Message-Id: <20260820024834.3286721-1-kylefoxaustin.github@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=kylefoxaustin.github@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds a QEMU machine for the NXP i.MX 95 19x19 LPDDR5 EVK
(machine name "imx95-19x19-evk"). The i.MX 95 is a heterogeneous SoC;
the machine models a fixed topology of 6 Cortex-A55 application cores,
one Cortex-M33 that runs NXP's System Manager (SM) firmware, and one
Cortex-M7 real-time core that the SM boots and manages.

What it does
============

It boots an arm64 Linux kernel to a userspace shell on the A55 cluster
(both a mainline arm64-defconfig kernel and the NXP BSP kernel work).

The defining property of this SoC -- and the reason the machine is
shaped the way it is -- is that the System Manager firmware, running on
the M33, is the *only* SCMI provider. Linux's clock, power,
performance-domain, sensor and reset operations are all served by the SM
over a shared mailbox (MU2); there is no SCMI implementation inside QEMU.
The machine models the mailbox cross-connect and the SM's bring-up
peripherals (LPUART, MU, System Counter, ANATOP/SRC/GPC, ELE, LPI2C +
PMIC, uSDHC, ...) faithfully enough that the *real, unmodified* SM
firmware runs on the emulated M33 and answers Linux's SCMI traffic.

A consequence worth stating plainly up front: booting Linux on this
machine requires the SM firmware image as an input, loaded onto the M33
with "-device loader,file=m33_image.elf,cpu-num=6". Without it the M33
stays halted, nothing answers SCMI, and Linux hangs at arm-scmi probe.
The SM is open source (https://github.com/nxp-imx/imx-sm) and builds
with an arm-none-eabi toolchain; docs/system/arm/imx95-evk.rst walks
through obtaining every required artifact.

Scope (headless v1)
===================

This is a deliberately minimal first machine: it boots to a serial
console. It is headless -- the DPU (display controller) is a
probe-completing stub, and the GPU (Mali-G310), VPU (Amphion) and NPU
(Neutron) are MMIO stubs that Linux enumerates but that perform no
rendering, codec or inference. Real display + Wayland output, the NETC
networking complex, and the multimedia blocks are intended as follow-on
series on top of this base.

The blocks that are modelled are exactly those on the Linux+SM bring-up
critical path; everything else that the stock EVK device tree probes is
a logging stub so that enabling those nodes degrades gracefully rather
than faulting on the first access.

How to test
===========

  $ qemu-system-aarch64 -M imx95-19x19-evk -m 2G -display none \
      -kernel Image -dtb imx95-19x19-evk.dtb -initrd initramfs.cpio.gz \
      -device loader,file=m33_image.elf,cpu-num=6 \
      -append "earlycon=lpuart32,mmio32,0x44380010 console=ttyLP0,115200 \
               cpuidle.off=1" -serial mon:stdio

A functional test is included (tests/functional/aarch64/test_imx95_evk.py).
Because the SM firmware and a matching kernel/dtb are external inputs
that are not redistributable, the test is gated on QEMU_TEST_IMX95_*
environment variables and skips cleanly when they are unset -- so it
will SKIP in upstream CI as posted. I would appreciate guidance on the
preferred convention here: I am happy to host a redistributable
kernel+dtb (and exercise the SM path separately) as an Asset() so CI
actually runs the machine, if that is wanted.

Prerequisites (patches 01-04)
=============================

The first four patches are generic, non-i.MX95 changes that the machine
depends on. They are separate commits so they can be reviewed (and
taken) on their own merits:

  01  hw/sd/sdhci: two opt-in uSDHC quirk bits (SDCLK_AUTO_GATE,
      NO_SDMA_BOUNDARY). The i.MX (u)SDHC issues commands with SDCLK
      auto-gated and its SDMA does not honour the 512 KiB ADMA boundary
      the generic core assumes.
  02  hw/arm/boot: let a board preset info->initrd_start, so a board
      with a reserved-memory carveout can keep the initrd clear of it.
  03  target/arm: an opt-in "pmsav7-rbar-align-down" CPU property that
      aligns down a PMSAv7 MPU region base not aligned to its size,
      instead of the architectural UNPREDICTABLE drop. An earlier version
      of this fix changed that behaviour unconditionally and was rightly
      not taken; this reworks it as a property that defaults to false (so
      no existing behaviour changes) and is only registered on PMSAv7
      (v7-M / v7-R) CPUs. The NXP i.MX 95 Cortex-M7 SDK firmware relies on
      the align-down for one of its MPU regions.
  04  hw/arm/armv7m: forward that property to the CPU object, following
      the existing init-svtor / vfp / dsp forwarding, so an SoC can enable
      it on an affected core. (The i.MX 95 SoC enables it on the M7 only;
      the M33 is a v8-M / PMSAv8 core and needs no such quirk.)

Series layout
=============

  01-04  generic prerequisites (above)
  05     hw/char: i.MX LPUART
  06     hw/i2c:  i.MX LPI2C
  07     hw/misc: i.MX Messaging Unit (MU v2)
  08     hw/misc: NXP EdgeLock Enclave (ELE) responder
  09     hw/timer: i.MX 95 system counter
  10     hw/misc: i.MX 95 watchdog
  11     hw/misc: ANATOP/AONMIX/GPC/SRC power & clock blocks
  12     hw/misc: PMIC (PF09/PF53/PCAL6408A) + xcache
  13     hw/misc: DPU command-sequencer stub (headless)
  14     hw/arm:  i.MX 95 SoC container (fsl-imx95)
  15     hw/arm:  i.MX 95 19x19 EVK board
  16     docs, MAINTAINERS, tests/functional

Every patch builds on its own (the series is bisectable), device state
carries migration vmsd + reset, and checkpatch is clean.

  46 files changed, 6529 insertions(+), 13 deletions(-)

Thanks for reviewing.

Kyle Fox (16):
  hw/sd/sdhci: add i.MX uSDHC SDCLK_AUTO_GATE and NO_SDMA_BOUNDARY
    quirks
  hw/arm/boot: let a board preset initrd_start
  target/arm: opt-in align-down for a misaligned PMSAv7 MPU RBAR
  hw/arm/armv7m: forward pmsav7-rbar-align-down to the CPU
  hw/char: add i.MX LPUART
  hw/i2c: add i.MX LPI2C
  hw/misc: add i.MX Messaging Unit (MU v2)
  hw/misc: add NXP EdgeLock Enclave (ELE) responder
  hw/timer: add i.MX 95 system counter
  hw/misc: add i.MX 95 watchdog
  hw/misc: add i.MX 95 ANATOP/AONMIX/GPC/SRC power and clock blocks
  hw/misc: add i.MX 95 PMIC (PF09/PF53/PCAL6408A) and xcache controllers
  hw/misc: add i.MX 95 DPU command-sequencer stub (headless)
  hw/arm: add i.MX 95 SoC container (fsl-imx95)
  hw/arm: add i.MX 95 19x19 EVK board
  docs, MAINTAINERS, tests/functional: add i.MX 95 EVK

 MAINTAINERS                                |   18 +
 docs/system/arm/imx95-evk.rst              |  242 +++
 docs/system/target-arm.rst                 |    1 +
 hw/arm/Kconfig                             |   26 +
 hw/arm/armv7m.c                            |    8 +
 hw/arm/boot.c                              |   12 +-
 hw/arm/fsl-imx95.c                         | 1646 ++++++++++++++++++++
 hw/arm/imx95-evk.c                         |  136 ++
 hw/arm/meson.build                         |    2 +
 hw/char/Kconfig                            |    3 +
 hw/char/imx_lpuart.c                       |  382 +++++
 hw/char/meson.build                        |    1 +
 hw/char/trace-events                       |    3 +
 hw/i2c/Kconfig                             |    4 +
 hw/i2c/imx_lpi2c.c                         |  296 ++++
 hw/i2c/meson.build                         |    1 +
 hw/i2c/trace-events                        |    4 +
 hw/misc/Kconfig                            |   32 +
 hw/misc/imx95_anatop.c                     |  201 +++
 hw/misc/imx95_aonmix.c                     |  160 ++
 hw/misc/imx95_dpu.c                        |  117 ++
 hw/misc/imx95_ele_server.c                 |  284 ++++
 hw/misc/imx95_gpc.c                        |  160 ++
 hw/misc/imx95_pmic.c                       |  357 +++++
 hw/misc/imx95_src.c                        |  228 +++
 hw/misc/imx95_wdog.c                       |  198 +++
 hw/misc/imx95_xcache.c                     |  185 +++
 hw/misc/imx_mu.c                           |  454 ++++++
 hw/misc/meson.build                        |   10 +
 hw/misc/trace-events                       |   25 +
 hw/sd/sdhci.c                              |   67 +-
 hw/timer/Kconfig                           |    3 +
 hw/timer/imx95_sysctr.c                    |  241 +++
 hw/timer/meson.build                       |    1 +
 hw/timer/trace-events                      |    2 +
 include/hw/arm/armv7m.h                    |    4 +
 include/hw/arm/fsl-imx95.h                 |  481 ++++++
 include/hw/char/imx_lpuart.h               |  123 ++
 include/hw/misc/imx95_ele_server.h         |   47 +
 include/hw/misc/imx_mu.h                   |  144 ++
 include/hw/sd/sdhci.h                      |   21 +
 target/arm/cpu.c                           |   19 +
 target/arm/cpu.h                           |    6 +
 target/arm/ptw.c                           |   28 +-
 tests/functional/aarch64/meson.build       |    2 +
 tests/functional/aarch64/test_imx95_evk.py |  157 ++
 46 files changed, 6529 insertions(+), 13 deletions(-)
 create mode 100644 docs/system/arm/imx95-evk.rst
 create mode 100644 hw/arm/fsl-imx95.c
 create mode 100644 hw/arm/imx95-evk.c
 create mode 100644 hw/char/imx_lpuart.c
 create mode 100644 hw/i2c/imx_lpi2c.c
 create mode 100644 hw/misc/imx95_anatop.c
 create mode 100644 hw/misc/imx95_aonmix.c
 create mode 100644 hw/misc/imx95_dpu.c
 create mode 100644 hw/misc/imx95_ele_server.c
 create mode 100644 hw/misc/imx95_gpc.c
 create mode 100644 hw/misc/imx95_pmic.c
 create mode 100644 hw/misc/imx95_src.c
 create mode 100644 hw/misc/imx95_wdog.c
 create mode 100644 hw/misc/imx95_xcache.c
 create mode 100644 hw/misc/imx_mu.c
 create mode 100644 hw/timer/imx95_sysctr.c
 create mode 100644 include/hw/arm/fsl-imx95.h
 create mode 100644 include/hw/char/imx_lpuart.h
 create mode 100644 include/hw/misc/imx95_ele_server.h
 create mode 100644 include/hw/misc/imx_mu.h
 create mode 100644 tests/functional/aarch64/test_imx95_evk.py


base-commit: ae4f3443209ab154b48b706a146e5f557ab147cb
-- 
2.34.1


