Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D44EF417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcuE-00038y-82; Mon, 09 Mar 2026 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuA-000374-Hm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcu8-00085c-2z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b611274bso5417648f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071542; x=1773676342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wc6MquOTQOl6tK0ogxwI89CHQE/LrPwVhz0daXJCuwQ=;
 b=nSrXoZOdhORSleNhmbAJIB83KWLL2ZFTrZNq1kmZ/fwYdWjSxuPIHM0GLqEZO+NRzP
 I9X7B/SfzEvfR8FCGo0bFYEBPOruVmAU3rHPkJOD8SfiBqADdvQXCoes6pExNYaOcqLS
 B0M/YH6RDL8dTxdd+Yz6HmKa/bh6qQlu+uhGtVMFiBtMqQFstlaZgrB7yS4TzvbjRFOF
 K6Wdi22das3Z36bseQmNTx3U7S3UwdkrFJNvSxMux0DRsL5ufgkyiyeS9dFlvTLtOPtu
 aSlMM8UHOVcIewRwOS6lfyZ5rpU3iXkeKVs9UNf6au+GiBHNexENdPNYHbmFlV4foYvd
 00bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071542; x=1773676342;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wc6MquOTQOl6tK0ogxwI89CHQE/LrPwVhz0daXJCuwQ=;
 b=t0aG5UU8mJSV4xMgzKc35FERKrK9utm9gsH05drAIaHnILZ4/ndN9CIboltjY1S3LO
 JSbUU1oE8caV9W4WAknUE4bBE3BAvDJ13G67E4ssHni8+IwxRnMlytYVbJDy1Tnt1z7H
 u0JLGpJJq+89jWKG2JuiLvFruJzQ6ySESI6zTVcutQ++SZNsjHc92t7DaO+pJIzzREpZ
 S+dczCGTnfw2FcHrj1qFlBK8ufyo/sgMhpograHANkqXX9G2/ChYa/RdDOiLh/1gTWVk
 PSP7Dlnochnp+qNvs9+SpU4MPRlvG4Z5VVZyEl+WdX7S/ZaG+FURr7ppfaXiVznalOi0
 3Gbg==
X-Gm-Message-State: AOJu0YylQThbmGi6rTS6lNi/zyFOr7Y8PyZDP/ul2vbkS3G7VlCDZlFj
 Aj8ELJJsmwKOIy1Gu2noYtV7CDZEwlpiFj2s9/LSuTnwrMpwnVG7KGGxMRXzeiFmo8DkcuBn8YH
 ps3iXqI0=
X-Gm-Gg: ATEYQzzk5ZdElJcc1gYJmui7uzQHON3Hk8Ta5ELHFN6yVa4M2R/WkAdCi2MRFBxHYYt
 JySyIxfrA5V+B6hZT11sg8YfuMxlP/2PhUAWqEr/lwPek+LcuOh4tu7GtVwbR/r+Zw4ltBi1UTe
 zmYqmi/xG04veL9Z8P2MkqtpLC8HOT27VhjzRoe6TKlfnEY9srQc9t1g36/vZcXtyYQb1t94C6s
 5p4U2wQXpsr29cnz4njd0qQCLxP0UEdBH9FcfH3g042YSl4jF8l0Rut+oGkwPplu0c4eLicS9o+
 cjWcsuhOy90MqzofduRfs6g9RluvlxM2qDjwN/IbVlHbDrYZycVV2079WPvUZxgBk5Q2W7Idt4V
 wso+QA3lGV3ipZaqZfoGwAZVngpDDgtoytAldfMaFjPCWjyqNiH0C8D5ChM70Bl0ByfpiaiI0Yi
 m3nTEK5OEKLPi2S5PYWp+pi6Bp8PY4+7reaeovgMPCctQl18rGHpX1zo/cYb0ObTlKYwa7Zaje
X-Received: by 2002:a05:6000:178f:b0:439:b2d9:cf35 with SMTP id
 ffacd0b85a97d-439da64f838mr20535790f8f.8.1773071541726; 
 Mon, 09 Mar 2026 08:52:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9fbsm28093511f8f.23.2026.03.09.08.52.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] Misc HW patches for 2026-03-09
Date: Mon,  9 Mar 2026 16:51:30 +0100
Message-ID: <20260309155219.62400-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The following changes since commit 7608a95d2e0bd8c8d069ab77824d02586dd94648:

  Merge tag 'pull-xen-20260309' of https://xenbits.xen.org/git-http/people/aperard/qemu-dm into staging (2026-03-09 12:15:42 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260309

for you to fetch changes up to caa5d8257037201f4e546ec833e51863ae07b331:

  hw/misc/riscv_cpc: Free CPU array in instance_finalize (2026-03-09 16:45:25 +0100)

Ignoring following checkpatch errors:

  17/48 Checking commit b362f63b6016 (tests: fix leaks in dbus-display-test)
  WARNING: line over 80 characters
  #44: FILE: tests/qtest/dbus-display-test.c:137:
  +    qemu_dbus_display1_listener_unix_map_complete_scanout_map(object, invocation,

  35/48 Checking commit 6d5eb13974b3 (ati-vga: Remove src and dst stride mutation in ati_2d_blt)
  WARNING: line over 80 characters
  #38: FILE: hw/display/ati_2d.c:129:
  +        DPRINTF("pixman_blt(%p, %p, %ld, %ld, %d, %d, %d, %d, %d, %d, %d, %d)\n",

Couldn't test well mingw-w64-clang-x86_64 because of issues with the
OSU Open Source Lab mirror:

  error: failed retrieving file 'mingw-w64-clang-x86_64-libwinpthread-13.0.0.r560.g3197fc7d6-1-any.pkg.tar.zst.sig' from ftp2.osuosl.org : Operation too slow. Less than 1 bytes/sec transferred the last 10 seconds

----------------------------------------------------------------
Misc HW patches

- Remove versioned machines released in QEMU 3.1 and 4.0
- Enable X.Org text rendering on ATI VGA model
- Various memory leaks / overflows fixed
- Build using -Wformat-overflow=2 CPPFLAG
----------------------------------------------------------------

Akihiko Odaki (6):
  coreaudio: Remove unnecessary explicit casts
  coreaudio: Remove extra whitespaces
  contrib/elf2dmp: Grow PDB URL buffer
  vfio/pci: Grow buffer in vfio_pci_host_match()
  tests: Clean up double comparisons to avoid compiler warning
  meson: Add -Wformat-overflow=2

BALATON Zoltan (2):
  ati-vga: Simplify hw cursor drawing
  ati-vga: Do not access pixel outside the screen

Chad Jablonski (9):
  ati-vga: Remove src and dst stride mutation in ati_2d_blt
  ati-vga: Use local variables for register values in ati_2d_blt
  ati-vga: Introduce ATI2DCtx struct for 2D blit context
  ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
  ati-vga: Split ati_2d_do_blt from ati_2d_blt
  ati-vga: Remove ATIVGAState param from ati_2d_do_blt
  ati-vga: Implement scissor rectangle clipping for 2D operations
  ati-vga: Implement HOST_DATA register writes
  ati-vga: Implement HOST_DATA flush to VRAM

Cédric Le Goater (1):
  hw/i3c/dw-i3c: Fix memory leaks in error logging paths

Marc-André Lureau (4):
  tests: fix leaks in dbus-display-test
  ui/dbus: fix leak regression
  ui/dbus: fix Unix.Map proxy leak
  ui/dbus: fix pixman cleanup

Peter Foley (2):
  net/passt: Only kill passt if it wrote a pidfile
  net/passt: Don't try to read the pidfile if passt got a signal

Peter Maydell (8):
  hw/net/npcm_gmac: Catch accesses off the end of the register array
  hw/sparc/sun4m: Don't set up dummy cpu interrupts
  hw/sparc/sun4m: Use qdev GPIOs rather than qemu_allocate_irqs()
  hw/timer/slavio_timer: Free resources allocated in instance_init
  hw/qdev: Document qdev_get_dev_path()
  hw: Make qdev_get_printable_name() consistently return freeable string
  hw/misc/sifive_e_aon: Don't leak timer
  hw/misc/riscv_cpc: Free CPU array in instance_finalize

Philippe Mathieu-Daudé (15):
  hw/timer/hpet: Remove HPETState::hpet_offset_saved field
  hw/i386/pc: Remove deprecated pc-q35/pc-i440fx/xenfv 3.1 machines
  hw/i386/pc: Remove PCMachineClass::pvh_enabled field
  hw/i386/x86: Remove @pvh_enabled argument in x86_load_linux()
  hw/core/boards: Remove MachineClass::smbus_no_migration_support field
  hw/i386/pc: Remove pc_compat_3_1[] array
  hw/i386/iommu: Remove IntelIOMMUState::dma_drain field
  target/i386/cpu: Remove X86CPU::intel_pt_auto_level field
  hw/core/machine: Remove the hw_compat_3_1[] array
  hw/pci-bridge/pcie_rp: Remove PCIESlot::disable_acs field
  hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and pc-i440fx-4.0
    machines
  hw/i386/pc: Remove pc_compat_4_0[] array
  hw/core/machine: Remove the hw_compat_4_0[] array
  hw/virtio: Remove VirtIOBalloon::qemu_4_0_config_size field
  hw/rtc/pl031: : Remove PL031State::migrate_tick_offset field

Roman Kiryanov (2):
  virtio-snd: remove a redundant memory allocation
  virtio-snd: remove redundant fields

 meson.build                              |   1 +
 hw/display/ati_int.h                     |  12 +
 hw/display/ati_regs.h                    |  13 +
 include/hw/audio/virtio-snd.h            |   4 +-
 include/hw/core/boards.h                 |   7 -
 include/hw/core/qdev.h                   |  39 ++
 include/hw/i2c/pm_smbus.h                |   7 -
 include/hw/i386/intel_iommu.h            |   1 -
 include/hw/i386/microvm.h                |   2 +-
 include/hw/i386/pc.h                     |   9 -
 include/hw/i386/x86.h                    |   3 +-
 include/hw/misc/sifive_e_aon.h           |   2 +-
 include/hw/net/npcm_gmac.h               |   3 +-
 include/hw/pci/pcie_port.h               |   3 -
 include/hw/rtc/pl031.h                   |   1 -
 include/hw/virtio/virtio-balloon.h       |   1 -
 target/i386/cpu.h                        |   3 -
 contrib/elf2dmp/main.c                   |  32 +-
 hw/acpi/piix4.c                          |   8 +-
 hw/audio/virtio-snd.c                    |  55 ++-
 hw/core/machine.c                        |  29 --
 hw/core/qdev.c                           |   4 +-
 hw/display/ati.c                         |  38 +-
 hw/display/ati_2d.c                      | 443 ++++++++++++++++-------
 hw/display/ati_dbg.c                     |   9 +
 hw/i2c/pm_smbus.c                        |   7 -
 hw/i2c/smbus_eeprom.c                    |   4 +-
 hw/i2c/smbus_ich9.c                      |  10 +-
 hw/i386/intel_iommu.c                    |  11 +-
 hw/i386/microvm.c                        |   2 +-
 hw/i386/nitro_enclave.c                  |   4 +-
 hw/i386/pc.c                             |  34 +-
 hw/i386/pc_piix.c                        |  36 --
 hw/i386/pc_q35.c                         |  39 --
 hw/i386/x86-common.c                     |   6 +-
 hw/i3c/dw-i3c.c                          |   6 +-
 hw/misc/riscv_cpc.c                      |   8 +
 hw/misc/sifive_e_aon.c                   |  16 +-
 hw/net/npcm_gmac.c                       |  14 +
 hw/pci-bridge/pcie_root_port.c           |   3 +-
 hw/rtc/pl031.c                           |  22 --
 hw/sparc/sun4m.c                         |  34 +-
 hw/timer/hpet.c                          |   9 +-
 hw/timer/slavio_timer.c                  |  25 +-
 hw/vfio/pci.c                            |   2 +-
 hw/virtio/virtio-balloon.c               |   5 -
 hw/virtio/virtio.c                       |  12 +-
 net/passt.c                              |  17 +-
 target/i386/cpu.c                        |  10 +-
 tests/qtest/dbus-display-test.c          |   9 +
 tests/unit/test-qobject-input-visitor.c  |   8 +-
 tests/unit/test-qobject-output-visitor.c |   7 +-
 ui/dbus-listener.c                       |  11 +-
 audio/coreaudio.m                        |  24 +-
 rust/hw/timer/hpet/src/device.rs         |   9 +-
 55 files changed, 617 insertions(+), 516 deletions(-)

-- 
2.53.0


