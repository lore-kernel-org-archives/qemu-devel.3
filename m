Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAF8EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodh2-0003mD-8x; Thu, 12 Sep 2024 02:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodgz-0003fo-QH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodgw-0003NH-FA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso4574295e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123952; x=1726728752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TnWNuXB/pgq0sdatUNr8NlncIwuUPxn8vE5543AKT4c=;
 b=ZztntVFH2zl9n2/VJoAFAdmSKOlvqJMrutXiylCA5aYw5ipmHYGqOR1clyjzTp0toY
 t9sUuHb5b0jrwiNkE6yTqFa8inpaWr4beWK3Bbgq3mqCW6fenZVWwELNzFMHrCV6XbuM
 ZJsX7f6os3YrjTSZdVunlO/oTW3eehs7DBYCm54hfMNR78e8x2MOEWMYcuXw3QOqm6jz
 Y/FAiPjEdwVbrhHGaG265VNcEOI5GDecP391OI2XsceWKXVTZDUWyYxaKC/G+ANYSMUv
 /Incfmj2YCHrL1FTVegi/l+5VNYHNEgzZQTLtpHYFox2atQEUyGwfhFMM7Ui8T2JFkqt
 jyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123952; x=1726728752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TnWNuXB/pgq0sdatUNr8NlncIwuUPxn8vE5543AKT4c=;
 b=flbe02I3XAq+KqvJytsHc6MrfOeQmJqqcZd8rSSQj74HY0y2/0ziDmjH3i0KMMgAHR
 b9XvoXoMOfiV5WHIicadk6QACSHIb2MxmVBc12YTSOcAOWkNRHg3yErl2TabjBGTFhcr
 XDCm2epK0M6A4CO7Vakk0IPjJUqhZT7oNaj/RIcE8pXb2zKbQEoK3fC9v6U1HdqiPv/W
 quX2wHsl+i9cvu/NTXXJTbxOlEoF07fI8Lky10NHo8e6nWm3b7gXyZHL9fo+AfdUT7if
 R6i/r906BqkguhefJ8sFcIQcH/NPCw9tyNWLSxs5wQHGGSk9hmQ1czlM/mjM/H1clW0U
 R7eQ==
X-Gm-Message-State: AOJu0Yy/cAxa3zg/NzNGS2kgo1h4DhfrKmPRdvsqxWp6i2yE596XEgJK
 ZEtsyuSjIvYfHDrAUl2QYO8R4CIDFDVqBGZZM0cwxBPnqnByu8kEKBYowhZWtOGG/uo6EXOYcjJ
 b
X-Google-Smtp-Source: AGHT+IHXtzZSpSJUnk4FEXEWo7HxTe+riKOEbSrRZZnkKbegSWlwiIPsAy/wIXVUvlp1t2kdNlfeIg==
X-Received: by 2002:a05:600c:251:b0:42c:b1f0:f67 with SMTP id
 5b1f17b1804b1-42cdb66c968mr11595245e9.27.1726123951678; 
 Wed, 11 Sep 2024 23:52:31 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cc3dbsm193637295e9.20.2024.09.11.23.52.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/61] Misc HW & UI patches for 2024-09-12
Date: Thu, 12 Sep 2024 08:52:14 +0200
Message-ID: <20240912065227.67848-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

v2:
- Fill Pierrick's commit description suggested by Eric Blake
- Include TMP105 fixes from Guenter

The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:

  Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240912

for you to fetch changes up to bd480a2baab659abe90da878bc955670691f53a8:

  ui: remove break after g_assert_not_reached() (2024-09-12 08:44:48 +0200)

----------------------------------------------------------------
Misc HW & UI patches

- Remove deprecated SH4 SHIX machine TC58128 NAND EEPROM (Phil)
- Remove deprecated CRIS target (Phil)
- Remove deprecated RISC-V 'any' CPU type (Phil)
- Add fifo8_peek_buf() to correctly handle FIFO wraparound (Mark)
- Minor cleanups in Designware PCIe, PL011 and loongson IPI models (Phil)
- Fixes in TI TMP105 temperature (Guenter)
- Convert Sun ESCC and ADB mouses to QemuInputHandler (Mark)
- Prevent heap overflow in VIRTIO sound device (Volker)
- Cleanups around g_assert_not_reached() call (Pierrick)
- Add Clément as VT-d reviewer (Clément)
- Prevent stuck modifier keys and unexpected text input on Windows (Volker)
- Explicitly set SDL2 swap interval when OpenGL is enabled (Gert)

----------------------------------------------------------------

CLEMENT MATHIEU--DRIF (1):
  MAINTAINERS: Add myself as a reviewer of VT-d

Gert Wollny (1):
  ui/sdl2: set swap interval explicitly when OpenGL is enabled

Guenter Roeck (2):
  hw/sensor/tmp105: Coding style fixes
  hw/sensor/tmp105: Lower 4 bit of limit registers are always 0

Mark Cave-Ayland (11):
  fifo8: rename fifo8_peekpop_buf() to fifo8_peekpop_bufptr()
  fifo8: introduce head variable for fifo8_peekpop_bufptr()
  fifo8: add skip parameter to fifo8_peekpop_bufptr()
  fifo8: replace fifo8_pop_bufptr() with fifo8_peekpop_bufptr() in
    fifo8_pop_buf()
  fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
  fifo8: honour do_pop argument in fifo8_peekpop_buf()
  fifo8: add fifo8_peek_buf() function
  fifo8: introduce fifo8_peek() function
  tests/unit: add test-fifo unit test
  hw/char/escc: convert Sun mouse to use QemuInputHandler
  hw/input/adb-mouse: convert to use QemuInputHandler

Philippe Mathieu-Daudé (35):
  hw/pci-host/designware: Declare CPU QOM types using DEFINE_TYPES()
    macro
  hw/pci-host/designware: Add 'host_mem' variable for clarity
  hw/intc/loongson_ipi: Remove unused headers
  hw/sh4: Remove the deprecated SHIX machine
  hw/block: Remove TC58128 NAND EEPROM
  hw/sh4: Remove sh7750_register_io_device() helper
  tests/tcg: Remove CRIS libc test files
  tests/tcg: Remove CRIS bare test files
  buildsys: Remove CRIS cross container
  linux-user: Remove support for CRIS target
  hw/cris: Remove the axis-dev88 machine
  hw/cris: Remove image loader helper
  hw/intc: Remove TYPE_ETRAX_FS_PIC device
  hw/char: Remove TYPE_ETRAX_FS_SERIAL device
  hw/net: Remove TYPE_ETRAX_FS_ETH device
  hw/dma: Remove ETRAX_FS DMA device
  hw/timer: Remove TYPE_ETRAX_FS_TIMER device
  system: Remove support for CRIS target
  target/cris: Remove the deprecated CRIS target
  seccomp: Remove check for CRIS host
  target/riscv: Remove the deprecated 'any' CPU type
  hw/char/pl011: Remove unused 'readbuff' field
  hw/char/pl011: Move pl011_put_fifo() earlier
  hw/char/pl011: Move pl011_loopback_enabled|tx() around
  hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
  hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
  hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
  hw/char/pl011: Warn when using disabled transmitter
  hw/char/pl011: Rename RX FIFO methods
  tests/unit: Strengthen FIFO8 tests
  tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
  tests/unit: Comment FIFO8 tests
  hw/sensor/tmp105: Use registerfields API
  hw/sensor/tmp105: Pass 'oneshot' argument to tmp105_alarm_update()
  hw/sensor/tmp105: OS (one-shot) bit in config register always returns
    0

Pierrick Bouvier (8):
  hw/char: replace assert(0) with g_assert_not_reached()
  hw/core: replace assert(0) with g_assert_not_reached()
  hw/watchdog: replace assert(0) with g_assert_not_reached()
  hw/gpio: remove break after g_assert_not_reached()
  hw/misc: remove break after g_assert_not_reached()
  hw/pci-host: remove break after g_assert_not_reached()
  system: replace assert(0) with g_assert_not_reached()
  ui: remove break after g_assert_not_reached()

Volker Rümelin (3):
  hw/audio/virtio-sound: fix heap buffer overflow
  ui/sdl2: release all modifiers
  ui/sdl2: ignore GUI keys in SDL_TEXTINPUT handler

 MAINTAINERS                                   |   24 +-
 docs/about/deprecated.rst                     |   27 -
 docs/about/emulation.rst                      |    4 -
 docs/about/removed-features.rst               |   20 +
 docs/user/main.rst                            |    4 -
 configure                                     |    4 -
 configs/devices/cris-softmmu/default.mak      |    4 -
 configs/devices/sh4-softmmu/default.mak       |    1 -
 configs/targets/cris-linux-user.mak           |    1 -
 configs/targets/cris-softmmu.mak              |    1 -
 qapi/machine.json                             |    2 +-
 hw/cris/boot.h                                |   16 -
 include/exec/poison.h                         |    1 -
 include/hw/char/escc.h                        |    3 +
 include/hw/char/pl011.h                       |    1 -
 include/hw/cris/etraxfs.h                     |   54 -
 include/hw/cris/etraxfs_dma.h                 |   36 -
 include/hw/pci-host/designware.h              |    2 -
 include/hw/sh4/sh.h                           |   19 -
 include/qemu/fifo8.h                          |   25 +
 include/sysemu/arch_init.h                    |    1 -
 include/ui/sdl2.h                             |    2 +
 include/user/abitypes.h                       |    7 -
 linux-user/cris/sockbits.h                    |    1 -
 linux-user/cris/syscall_nr.h                  |  367 --
 linux-user/cris/target_cpu.h                  |   45 -
 linux-user/cris/target_elf.h                  |   14 -
 linux-user/cris/target_errno_defs.h           |    7 -
 linux-user/cris/target_fcntl.h                |   11 -
 linux-user/cris/target_mman.h                 |   13 -
 linux-user/cris/target_prctl.h                |    1 -
 linux-user/cris/target_proc.h                 |    1 -
 linux-user/cris/target_resource.h             |    1 -
 linux-user/cris/target_signal.h               |    9 -
 linux-user/cris/target_structs.h              |    1 -
 linux-user/cris/target_syscall.h              |   46 -
 linux-user/cris/termbits.h                    |  225 --
 linux-user/syscall_defs.h                     |    7 +-
 target/cris/cpu-param.h                       |   16 -
 target/cris/cpu-qom.h                         |   32 -
 target/cris/cpu.h                             |  286 --
 target/cris/crisv10-decode.h                  |  112 -
 target/cris/crisv32-decode.h                  |  133 -
 target/cris/helper.h                          |   23 -
 target/cris/mmu.h                             |   22 -
 target/cris/opcode-cris.h                     |  355 --
 target/riscv/cpu-qom.h                        |    1 -
 tests/tcg/cris/libc/crisutils.h               |   76 -
 tests/tcg/cris/libc/sys.h                     |   18 -
 hw/audio/virtio-snd.c                         |   24 -
 hw/block/tc58128.c                            |  211 --
 hw/char/avr_usart.c                           |    2 +-
 hw/char/escc.c                                |   92 +-
 hw/char/etraxfs_ser.c                         |  267 --
 hw/char/pl011.c                               |  209 +-
 hw/core/numa.c                                |    2 +-
 hw/cris/axis_dev88.c                          |  351 --
 hw/cris/boot.c                                |  102 -
 hw/dma/etraxfs_dma.c                          |  781 ----
 hw/gpio/nrf51_gpio.c                          |    1 -
 hw/input/adb-mouse.c                          |   63 +-
 hw/intc/etraxfs_pic.c                         |  172 -
 hw/intc/loongson_ipi.c                        |    9 -
 hw/misc/imx6_ccm.c                            |    1 -
 hw/misc/mac_via.c                             |    2 -
 hw/net/etraxfs_eth.c                          |  688 ----
 hw/pci-host/designware.c                      |   44 +-
 hw/pci-host/gt64120.c                         |    2 -
 hw/sensor/tmp105.c                            |   66 +-
 hw/sh4/sh7750.c                               |   57 +-
 hw/sh4/shix.c                                 |   86 -
 hw/timer/etraxfs_timer.c                      |  407 ---
 hw/watchdog/watchdog.c                        |    2 +-
 linux-user/cris/cpu_loop.c                    |   95 -
 linux-user/cris/signal.c                      |  194 -
 linux-user/elfload.c                          |   15 -
 linux-user/syscall.c                          |   10 +-
 system/qemu-seccomp.c                         |    4 +-
 system/rtc.c                                  |    2 +-
 target/cris/cpu.c                             |  323 --
 target/cris/gdbstub.c                         |  127 -
 target/cris/helper.c                          |  287 --
 target/cris/machine.c                         |   93 -
 target/cris/mmu.c                             |  356 --
 target/cris/op_helper.c                       |  580 ---
 target/cris/translate.c                       | 3252 -----------------
 target/riscv/cpu.c                            |   28 -
 tests/qtest/machine-none-test.c               |    1 -
 tests/tcg/cris/bare/sys.c                     |   63 -
 tests/tcg/cris/libc/check_abs.c               |   40 -
 tests/tcg/cris/libc/check_addc.c              |   58 -
 tests/tcg/cris/libc/check_addcm.c             |   85 -
 tests/tcg/cris/libc/check_addo.c              |  125 -
 tests/tcg/cris/libc/check_addoq.c             |   44 -
 tests/tcg/cris/libc/check_bound.c             |  142 -
 tests/tcg/cris/libc/check_ftag.c              |   37 -
 .../cris/libc/check_gcctorture_pr28634-1.c    |   15 -
 .../tcg/cris/libc/check_gcctorture_pr28634.c  |   15 -
 .../tcg/cris/libc/check_glibc_kernelversion.c |  116 -
 tests/tcg/cris/libc/check_hello.c             |    7 -
 tests/tcg/cris/libc/check_int64.c             |   47 -
 tests/tcg/cris/libc/check_lz.c                |   49 -
 tests/tcg/cris/libc/check_mapbrk.c            |   39 -
 tests/tcg/cris/libc/check_mmap1.c             |   48 -
 tests/tcg/cris/libc/check_mmap2.c             |   48 -
 tests/tcg/cris/libc/check_mmap3.c             |   33 -
 tests/tcg/cris/libc/check_moveq.c             |   51 -
 tests/tcg/cris/libc/check_openpf1.c           |   38 -
 tests/tcg/cris/libc/check_openpf2.c           |   16 -
 tests/tcg/cris/libc/check_openpf3.c           |   49 -
 tests/tcg/cris/libc/check_openpf5.c           |   56 -
 tests/tcg/cris/libc/check_settls1.c           |   45 -
 tests/tcg/cris/libc/check_sigalrm.c           |   26 -
 tests/tcg/cris/libc/check_stat1.c             |   16 -
 tests/tcg/cris/libc/check_stat2.c             |   20 -
 tests/tcg/cris/libc/check_stat3.c             |   25 -
 tests/tcg/cris/libc/check_stat4.c             |   27 -
 tests/tcg/cris/libc/check_swap.c              |   76 -
 tests/tcg/cris/libc/check_time2.c             |   18 -
 tests/unit/test-fifo.c                        |  449 +++
 ui/qemu-pixman.c                              |    1 -
 ui/sdl2-input.c                               |    5 +
 ui/sdl2.c                                     |   19 +-
 util/fifo8.c                                  |   42 +-
 fpu/softfloat-specialize.c.inc                |    4 +-
 target/cris/translate_v10.c.inc               | 1262 -------
 .gitlab-ci.d/buildtest.yml                    |    2 +-
 .gitlab-ci.d/container-cross.yml              |    5 -
 .gitlab-ci.d/crossbuild-template.yml          |    4 +-
 hw/Kconfig                                    |    1 -
 hw/audio/trace-events                         |    1 -
 hw/block/Kconfig                              |    3 -
 hw/block/meson.build                          |    1 -
 hw/char/meson.build                           |    1 -
 hw/char/trace-events                          |    4 +-
 hw/cris/Kconfig                               |   11 -
 hw/cris/meson.build                           |    5 -
 hw/dma/meson.build                            |    1 -
 hw/intc/meson.build                           |    1 -
 hw/meson.build                                |    1 -
 hw/net/meson.build                            |    1 -
 hw/net/trace-events                           |    5 -
 hw/sh4/Kconfig                                |    7 -
 hw/sh4/meson.build                            |    1 -
 hw/timer/meson.build                          |    1 -
 scripts/coverity-scan/COMPONENTS.md           |    3 -
 scripts/probe-gdb-support.py                  |    1 -
 target/Kconfig                                |    1 -
 target/cris/Kconfig                           |    2 -
 target/cris/meson.build                       |   17 -
 target/meson.build                            |    1 -
 tests/data/qobject/qdict.txt                  |    6 -
 tests/docker/Makefile.include                 |    1 -
 .../dockerfiles/fedora-cris-cross.docker      |   14 -
 tests/tcg/cris/.gdbinit                       |   11 -
 tests/tcg/cris/Makefile.target                |   62 -
 tests/tcg/cris/README                         |    1 -
 tests/tcg/cris/bare/check_addcv17.s           |   65 -
 tests/tcg/cris/bare/check_addi.s              |   57 -
 tests/tcg/cris/bare/check_addiv32.s           |   62 -
 tests/tcg/cris/bare/check_addm.s              |   96 -
 tests/tcg/cris/bare/check_addq.s              |   47 -
 tests/tcg/cris/bare/check_addr.s              |   96 -
 tests/tcg/cris/bare/check_addxc.s             |   91 -
 tests/tcg/cris/bare/check_addxm.s             |  106 -
 tests/tcg/cris/bare/check_addxr.s             |   96 -
 tests/tcg/cris/bare/check_andc.s              |   80 -
 tests/tcg/cris/bare/check_andm.s              |   90 -
 tests/tcg/cris/bare/check_andq.s              |   46 -
 tests/tcg/cris/bare/check_andr.s              |   95 -
 tests/tcg/cris/bare/check_asr.s               |  230 --
 tests/tcg/cris/bare/check_ba.s                |   93 -
 tests/tcg/cris/bare/check_bas.s               |  102 -
 tests/tcg/cris/bare/check_bcc.s               |  197 -
 tests/tcg/cris/bare/check_boundc.s            |  101 -
 tests/tcg/cris/bare/check_boundr.s            |  125 -
 tests/tcg/cris/bare/check_btst.s              |   96 -
 tests/tcg/cris/bare/check_clearfv32.s         |   19 -
 tests/tcg/cris/bare/check_clrjmp1.s           |   36 -
 tests/tcg/cris/bare/check_cmp-2.s             |   15 -
 tests/tcg/cris/bare/check_cmpc.s              |   86 -
 tests/tcg/cris/bare/check_cmpm.s              |   96 -
 tests/tcg/cris/bare/check_cmpq.s              |   75 -
 tests/tcg/cris/bare/check_cmpr.s              |  102 -
 tests/tcg/cris/bare/check_cmpxc.s             |   92 -
 tests/tcg/cris/bare/check_cmpxm.s             |  106 -
 tests/tcg/cris/bare/check_dstep.s             |   42 -
 tests/tcg/cris/bare/check_jsr.s               |   85 -
 tests/tcg/cris/bare/check_lapc.s              |   78 -
 tests/tcg/cris/bare/check_lsl.s               |  217 --
 tests/tcg/cris/bare/check_lsr.s               |  218 --
 tests/tcg/cris/bare/check_mcp.s               |   49 -
 tests/tcg/cris/bare/check_movdelsr1.s         |   33 -
 tests/tcg/cris/bare/check_movecr.s            |   37 -
 tests/tcg/cris/bare/check_movei.s             |   50 -
 tests/tcg/cris/bare/check_movemr.s            |   78 -
 tests/tcg/cris/bare/check_movemrv32.s         |   96 -
 tests/tcg/cris/bare/check_mover.s             |   28 -
 tests/tcg/cris/bare/check_moverm.s            |   45 -
 tests/tcg/cris/bare/check_movmp.s             |  131 -
 tests/tcg/cris/bare/check_movpmv32.s          |   35 -
 tests/tcg/cris/bare/check_movpr.s             |   28 -
 tests/tcg/cris/bare/check_movprv32.s          |   21 -
 tests/tcg/cris/bare/check_movscr.s            |   29 -
 tests/tcg/cris/bare/check_movsm.s             |   44 -
 tests/tcg/cris/bare/check_movsr.s             |   46 -
 tests/tcg/cris/bare/check_movucr.s            |   33 -
 tests/tcg/cris/bare/check_movum.s             |   40 -
 tests/tcg/cris/bare/check_movur.s             |   45 -
 tests/tcg/cris/bare/check_mulv32.s            |   51 -
 tests/tcg/cris/bare/check_mulx.s              |  257 --
 tests/tcg/cris/bare/check_neg.s               |  104 -
 tests/tcg/cris/bare/check_not.s               |   31 -
 tests/tcg/cris/bare/check_orc.s               |   71 -
 tests/tcg/cris/bare/check_orm.s               |   75 -
 tests/tcg/cris/bare/check_orq.s               |   41 -
 tests/tcg/cris/bare/check_orr.s               |   84 -
 tests/tcg/cris/bare/check_ret.s               |   25 -
 tests/tcg/cris/bare/check_scc.s               |   95 -
 tests/tcg/cris/bare/check_subc.s              |   87 -
 tests/tcg/cris/bare/check_subm.s              |   96 -
 tests/tcg/cris/bare/check_subq.s              |   52 -
 tests/tcg/cris/bare/check_subr.s              |  102 -
 tests/tcg/cris/bare/check_xarith.s            |   72 -
 tests/tcg/cris/bare/crt.s                     |   13 -
 tests/tcg/cris/bare/testutils.inc             |  117 -
 tests/unit/meson.build                        |    1 +
 227 files changed, 865 insertions(+), 19137 deletions(-)
 delete mode 100644 configs/devices/cris-softmmu/default.mak
 delete mode 100644 configs/targets/cris-linux-user.mak
 delete mode 100644 configs/targets/cris-softmmu.mak
 delete mode 100644 hw/cris/boot.h
 delete mode 100644 include/hw/cris/etraxfs.h
 delete mode 100644 include/hw/cris/etraxfs_dma.h
 delete mode 100644 linux-user/cris/sockbits.h
 delete mode 100644 linux-user/cris/syscall_nr.h
 delete mode 100644 linux-user/cris/target_cpu.h
 delete mode 100644 linux-user/cris/target_elf.h
 delete mode 100644 linux-user/cris/target_errno_defs.h
 delete mode 100644 linux-user/cris/target_fcntl.h
 delete mode 100644 linux-user/cris/target_mman.h
 delete mode 100644 linux-user/cris/target_prctl.h
 delete mode 100644 linux-user/cris/target_proc.h
 delete mode 100644 linux-user/cris/target_resource.h
 delete mode 100644 linux-user/cris/target_signal.h
 delete mode 100644 linux-user/cris/target_structs.h
 delete mode 100644 linux-user/cris/target_syscall.h
 delete mode 100644 linux-user/cris/termbits.h
 delete mode 100644 target/cris/cpu-param.h
 delete mode 100644 target/cris/cpu-qom.h
 delete mode 100644 target/cris/cpu.h
 delete mode 100644 target/cris/crisv10-decode.h
 delete mode 100644 target/cris/crisv32-decode.h
 delete mode 100644 target/cris/helper.h
 delete mode 100644 target/cris/mmu.h
 delete mode 100644 target/cris/opcode-cris.h
 delete mode 100644 tests/tcg/cris/libc/crisutils.h
 delete mode 100644 tests/tcg/cris/libc/sys.h
 delete mode 100644 hw/block/tc58128.c
 delete mode 100644 hw/char/etraxfs_ser.c
 delete mode 100644 hw/cris/axis_dev88.c
 delete mode 100644 hw/cris/boot.c
 delete mode 100644 hw/dma/etraxfs_dma.c
 delete mode 100644 hw/intc/etraxfs_pic.c
 delete mode 100644 hw/net/etraxfs_eth.c
 delete mode 100644 hw/sh4/shix.c
 delete mode 100644 hw/timer/etraxfs_timer.c
 delete mode 100644 linux-user/cris/cpu_loop.c
 delete mode 100644 linux-user/cris/signal.c
 delete mode 100644 target/cris/cpu.c
 delete mode 100644 target/cris/gdbstub.c
 delete mode 100644 target/cris/helper.c
 delete mode 100644 target/cris/machine.c
 delete mode 100644 target/cris/mmu.c
 delete mode 100644 target/cris/op_helper.c
 delete mode 100644 target/cris/translate.c
 delete mode 100644 tests/tcg/cris/bare/sys.c
 delete mode 100644 tests/tcg/cris/libc/check_abs.c
 delete mode 100644 tests/tcg/cris/libc/check_addc.c
 delete mode 100644 tests/tcg/cris/libc/check_addcm.c
 delete mode 100644 tests/tcg/cris/libc/check_addo.c
 delete mode 100644 tests/tcg/cris/libc/check_addoq.c
 delete mode 100644 tests/tcg/cris/libc/check_bound.c
 delete mode 100644 tests/tcg/cris/libc/check_ftag.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634-1.c
 delete mode 100644 tests/tcg/cris/libc/check_gcctorture_pr28634.c
 delete mode 100644 tests/tcg/cris/libc/check_glibc_kernelversion.c
 delete mode 100644 tests/tcg/cris/libc/check_hello.c
 delete mode 100644 tests/tcg/cris/libc/check_int64.c
 delete mode 100644 tests/tcg/cris/libc/check_lz.c
 delete mode 100644 tests/tcg/cris/libc/check_mapbrk.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap1.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap2.c
 delete mode 100644 tests/tcg/cris/libc/check_mmap3.c
 delete mode 100644 tests/tcg/cris/libc/check_moveq.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf1.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf2.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf3.c
 delete mode 100644 tests/tcg/cris/libc/check_openpf5.c
 delete mode 100644 tests/tcg/cris/libc/check_settls1.c
 delete mode 100644 tests/tcg/cris/libc/check_sigalrm.c
 delete mode 100644 tests/tcg/cris/libc/check_stat1.c
 delete mode 100644 tests/tcg/cris/libc/check_stat2.c
 delete mode 100644 tests/tcg/cris/libc/check_stat3.c
 delete mode 100644 tests/tcg/cris/libc/check_stat4.c
 delete mode 100644 tests/tcg/cris/libc/check_swap.c
 delete mode 100644 tests/tcg/cris/libc/check_time2.c
 create mode 100644 tests/unit/test-fifo.c
 delete mode 100644 target/cris/translate_v10.c.inc
 delete mode 100644 hw/cris/Kconfig
 delete mode 100644 hw/cris/meson.build
 delete mode 100644 target/cris/Kconfig
 delete mode 100644 target/cris/meson.build
 delete mode 100644 tests/docker/dockerfiles/fedora-cris-cross.docker
 delete mode 100644 tests/tcg/cris/.gdbinit
 delete mode 100644 tests/tcg/cris/Makefile.target
 delete mode 100644 tests/tcg/cris/README
 delete mode 100644 tests/tcg/cris/bare/check_addcv17.s
 delete mode 100644 tests/tcg/cris/bare/check_addi.s
 delete mode 100644 tests/tcg/cris/bare/check_addiv32.s
 delete mode 100644 tests/tcg/cris/bare/check_addm.s
 delete mode 100644 tests/tcg/cris/bare/check_addq.s
 delete mode 100644 tests/tcg/cris/bare/check_addr.s
 delete mode 100644 tests/tcg/cris/bare/check_addxc.s
 delete mode 100644 tests/tcg/cris/bare/check_addxm.s
 delete mode 100644 tests/tcg/cris/bare/check_addxr.s
 delete mode 100644 tests/tcg/cris/bare/check_andc.s
 delete mode 100644 tests/tcg/cris/bare/check_andm.s
 delete mode 100644 tests/tcg/cris/bare/check_andq.s
 delete mode 100644 tests/tcg/cris/bare/check_andr.s
 delete mode 100644 tests/tcg/cris/bare/check_asr.s
 delete mode 100644 tests/tcg/cris/bare/check_ba.s
 delete mode 100644 tests/tcg/cris/bare/check_bas.s
 delete mode 100644 tests/tcg/cris/bare/check_bcc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundc.s
 delete mode 100644 tests/tcg/cris/bare/check_boundr.s
 delete mode 100644 tests/tcg/cris/bare/check_btst.s
 delete mode 100644 tests/tcg/cris/bare/check_clearfv32.s
 delete mode 100644 tests/tcg/cris/bare/check_clrjmp1.s
 delete mode 100644 tests/tcg/cris/bare/check_cmp-2.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpm.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpq.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpr.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxc.s
 delete mode 100644 tests/tcg/cris/bare/check_cmpxm.s
 delete mode 100644 tests/tcg/cris/bare/check_dstep.s
 delete mode 100644 tests/tcg/cris/bare/check_jsr.s
 delete mode 100644 tests/tcg/cris/bare/check_lapc.s
 delete mode 100644 tests/tcg/cris/bare/check_lsl.s
 delete mode 100644 tests/tcg/cris/bare/check_lsr.s
 delete mode 100644 tests/tcg/cris/bare/check_mcp.s
 delete mode 100644 tests/tcg/cris/bare/check_movdelsr1.s
 delete mode 100644 tests/tcg/cris/bare/check_movecr.s
 delete mode 100644 tests/tcg/cris/bare/check_movei.s
 delete mode 100644 tests/tcg/cris/bare/check_movemr.s
 delete mode 100644 tests/tcg/cris/bare/check_movemrv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mover.s
 delete mode 100644 tests/tcg/cris/bare/check_moverm.s
 delete mode 100644 tests/tcg/cris/bare/check_movmp.s
 delete mode 100644 tests/tcg/cris/bare/check_movpmv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movpr.s
 delete mode 100644 tests/tcg/cris/bare/check_movprv32.s
 delete mode 100644 tests/tcg/cris/bare/check_movscr.s
 delete mode 100644 tests/tcg/cris/bare/check_movsm.s
 delete mode 100644 tests/tcg/cris/bare/check_movsr.s
 delete mode 100644 tests/tcg/cris/bare/check_movucr.s
 delete mode 100644 tests/tcg/cris/bare/check_movum.s
 delete mode 100644 tests/tcg/cris/bare/check_movur.s
 delete mode 100644 tests/tcg/cris/bare/check_mulv32.s
 delete mode 100644 tests/tcg/cris/bare/check_mulx.s
 delete mode 100644 tests/tcg/cris/bare/check_neg.s
 delete mode 100644 tests/tcg/cris/bare/check_not.s
 delete mode 100644 tests/tcg/cris/bare/check_orc.s
 delete mode 100644 tests/tcg/cris/bare/check_orm.s
 delete mode 100644 tests/tcg/cris/bare/check_orq.s
 delete mode 100644 tests/tcg/cris/bare/check_orr.s
 delete mode 100644 tests/tcg/cris/bare/check_ret.s
 delete mode 100644 tests/tcg/cris/bare/check_scc.s
 delete mode 100644 tests/tcg/cris/bare/check_subc.s
 delete mode 100644 tests/tcg/cris/bare/check_subm.s
 delete mode 100644 tests/tcg/cris/bare/check_subq.s
 delete mode 100644 tests/tcg/cris/bare/check_subr.s
 delete mode 100644 tests/tcg/cris/bare/check_xarith.s
 delete mode 100644 tests/tcg/cris/bare/crt.s
 delete mode 100644 tests/tcg/cris/bare/testutils.inc

-- 
2.45.2


