Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A417CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmR-0000Fx-16; Tue, 02 Sep 2025 09:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmO-0000EV-IU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmJ-0004ME-Hr
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:32 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso36631275e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818618; x=1757423418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vD6Iz35QiHbSUwvu1jynQZHzgw/SckW+b8rJZ52/7fg=;
 b=GLxV/SAZbaf1xgzREKvy0kp98cKUznvfU8SxpYUddggDAFX01GBkK6t3VNK/J7vzb0
 TeCWIV9wN6dXv7+IiTLLFzWHtD+oYx/6aFiopRCGBN4u35TyH4v3Y+k2QJaQBktux55R
 MmjI2ocbkCa+yCD+jWUJfN7nwws4mvxpj5VH8JX3Fz/2r2QZBEKJxBKOTEiMKBkQ+vs9
 savxRpMHL3GEVV/1kxozRCdM0e5aBqtFsvnbNwbqQdUdxmVeNeLMslCq4c9B3ZscH48X
 Wqro7EXDW0C/9WfvezP5PBlTXei/yCOaOYr4pTehXi1ZbA3PM0IKPlBeWATphxIMnMsa
 leGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818618; x=1757423418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vD6Iz35QiHbSUwvu1jynQZHzgw/SckW+b8rJZ52/7fg=;
 b=amwviZUuOosuc8hqt4KPi0lFW2UsM+S7FRhzhv1H2geSzwav0+/LETNFgVzpfuLEOd
 sRRHxpJEBYCY8VAJ1fzdqYLfBQxDDwG1vHSPEygpXCTSeTTx6u0SywoOr+lvrgD/AbC7
 gwudp78kcDLJBD6of+X9bNmhRvL0z8oEZGLOFmScw33VSDqZ/b/j2JjFwN8+1gRJdXO0
 QzSCs4Pr27GUOMl6WQKKIyW4/rWuppd6twtRFGzoPKNd0yhDan22BrG8620w+v8v/8cv
 iMLO/HpKMYEZMUf7eJAg5CmmZLzOqaX6mokkc4tmkb8RIjlTTdGLa8TfQfCFVyBbXbal
 /ESw==
X-Gm-Message-State: AOJu0YyzYQlTIzpdLQykT4PVl60+689D49Zqf4pbGjNDmNA8wlf6mVfN
 pHwsfZM75QkbVAErmjXtKsJbxY9UoNTPBbyJlH3hkb3Srxome+4FHWAeZ0rVVL/Q2GtAKu9Lr01
 9JhNd
X-Gm-Gg: ASbGncsDAsLesUexsTcHK3psmceq583f57lw0rxKjMl6kgke8jA1drAifgaDK/5kMLf
 yiBzsiWY+CqeontRfCpqjV3QOSf83sHVLVXfRmOiZqFUYnV6SRrgYBUYlvUbpkQkOa8/bj2re1x
 PsMj7ktPiIjJBWstjKQ1SFYALb1uf/ZzK7Vz0hVhOEldm6tLZQuJAQjXiYvOhx2sOEjvnkCyRpz
 V7kF3t1TUTG/WVzaBivzL1Srf0HPz3ZWxXztKKbCLjSV8ujRp1wnkcA9HxYevPk/bKBoLfmhp7J
 oz6mhKCbW1vkFIa4X134BUrefOupXYRHY/Z1P1Pgb/Dgzbm2N9oTHPW94anUMnmiuOCmgQ6TlwH
 K4Glt0x6LN8Tu6vBBrYGce5IXCPD6whKUENvarzNbkCehDWqleUn2i4Uwsg0sQaL5dV4rnlMP
X-Google-Smtp-Source: AGHT+IH4vlvptjMbmYjLgwQcbEpGACGXyUONGE6ONmfOWhKElPg3EGGmHt+t0k0HYFN3LGTx6RAVqw==
X-Received: by 2002:a05:600c:4817:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-45b84c3afa3mr66327485e9.7.1756818618134; 
 Tue, 02 Sep 2025 06:10:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b945332adsm43977715e9.4.2025.09.02.06.10.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] Misc HW patches for 2025-09-02
Date: Tue,  2 Sep 2025 15:09:37 +0200
Message-ID: <20250902131016.84968-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit 09d16ef11c97684a658c29ef1c75bce9f6019328:

  Merge tag 'pull-loongarch-20250829' of https://github.com/bibo-mao/qemu into staging (2025-09-01 11:15:06 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250902

for you to fetch changes up to 3071c0ce5f55aeb9ec65fb20be1e762290371102:

  hw/i386/pc_piix.c: remove unnecessary if() from pc_init1() (2025-09-02 15:06:57 +0200)

----------------------------------------------------------------
Misc HW patches

- Compile various system files once
- Remove SDCard spec v1.10
- Remove mipssim machine and mipsnet device model
- Prevent crash in e1000e when legacy interrupt fires after enabling MSI-X
- Introduce qemu_init_irq_child()
- Remove various memory leaks reported by ASan
- Few Coverity fixes
- Use 74Kf CPU to run MIPS16e binaries and M14Kc for microMIPS ones

(a pair if spurious checkpatch.pl warnings ignored).

----------------------------------------------------------------

Aditya Gupta (1):
  hw/ppc: Fix build error with CONFIG_POWERNV disabled

Cédric Le Goater (4):
  hw/arm/virt: Include 'system/system.h'
  hw/isa/superio: Include 'system/system.h'
  hw/mips/loongson3_virt: Include 'system/system.h'
  hw/mips/malta: Include 'system/system.h'

Denis Rastyogin (1):
  target/mips: fix TLB huge page check to use 64-bit shift

Djordje Todorovic (1):
  hw/pci: Allow explicit function numbers in pci

Jan Kiszka (4):
  hw/sd/sdcard: Fix size check for backing block image
  hw/sd/sdcard: Add validation for boot-partition-size
  hw/sd/sdcard: Refactor sd_bootpart_offset
  crypto/hmac: Allow to build hmac over multiple
    qcrypto_gnutls_hmac_bytes[v] calls

Laurent Vivier (1):
  e1000e: Prevent crash from legacy interrupt firing after MSI-X enable

Mark Cave-Ayland (1):
  hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()

Peter Maydell (8):
  hw/irq: New qemu_init_irq_child() function
  hw/char/serial-pci-multi: Use qemu_init_irq_child() to avoid leak
  hw/ide/ich.c: Use qemu_init_irq_child() to avoid memory leak
  hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
  hw/char/max78000_uart: Destroy FIFO on deinit
  hw/misc/xlnx-versal-cframe-reg: Free FIFO, g_tree on deinit
  hw/display/xlnx_dp: Don't leak dpcd and edid objects
  hw/arm/boot: Correctly free the MemoryDeviceInfoList

Philippe Mathieu-Daudé (12):
  hw/sd/sdcard: Remove support for spec v1.10
  target/ppc/kvm: Avoid using alloca()
  docs/devel/style: Mention alloca() family API is forbidden
  scripts/coverity-scan/COMPONENTS.md: Add a 'plugins' category
  hw/scsi/mptsas: Avoid silent integer truncation in MPI_FUNC_IOC_INIT
  hw/ssi: Document ssi_transfer() method
  elf: Add EF_MIPS_ARCH_ASE definitions
  linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
  linux-user/mips: Select M14Kc CPU to run microMIPS binaries
  hw/mips: Remove mipssim machine
  hw/net: Remove mipsnet device model
  docs/about/removed-features: Clarify 'device_add' is removed

Pierrick Bouvier (6):
  migration: compile migration/ram.c once
  migration/vfio: compile only once
  cpu-target: build compilation unit once for user/system
  include/exec/target_page.h: move page-target.c to header
  hw/meson: enter target hw first
  hw/intc: compile some arm related source once

 MAINTAINERS                             |   7 +-
 docs/about/deprecated.rst               |  18 --
 docs/about/removed-features.rst         |  14 +-
 docs/devel/style.rst                    |   4 +-
 docs/system/target-mips.rst             |  11 -
 configs/devices/mips-softmmu/common.mak |   1 -
 meson.build                             |   5 +-
 hw/sd/sdmmc-internal.h                  |   3 +-
 include/crypto/hmac.h                   |  12 +
 include/elf.h                           |   7 +
 include/exec/target_page.h              |  11 +-
 include/hw/irq.h                        |  23 +-
 include/hw/sd/sd.h                      |   1 -
 include/hw/ssi/ssi.h                    |  14 ++
 target/ppc/cpu.h                        |   4 +
 cpu-target.c                            |   5 -
 crypto/hmac-gcrypt.c                    |   4 +-
 crypto/hmac-glib.c                      |   4 +-
 crypto/hmac-gnutls.c                    |   4 +-
 crypto/hmac-nettle.c                    |   4 +-
 hw/arm/boot.c                           |   2 +-
 hw/arm/virt.c                           |   1 +
 hw/char/max78000_uart.c                 |   7 +
 hw/char/serial-pci-multi.c              |   3 +-
 hw/core/irq.c                           |   8 +
 hw/display/xlnx_dp.c                    |  10 +-
 hw/gpio/pca9554.c                       |   2 +-
 hw/i386/pc_piix.c                       |   6 +-
 hw/ide/ich.c                            |   3 +-
 hw/isa/isa-superio.c                    |   1 +
 hw/mips/loongson3_virt.c                |   1 +
 hw/mips/malta.c                         |   1 +
 hw/mips/mipssim.c                       | 249 --------------------
 hw/misc/xlnx-versal-cframe-reg.c        |   9 +
 hw/net/e1000e_core.c                    |   5 -
 hw/net/mipsnet.c                        | 297 ------------------------
 hw/pci/pci.c                            |  15 +-
 hw/ppc/pnv.c                            |  86 +++++++
 hw/scsi/mptsas.c                        |   6 +-
 hw/sd/sd.c                              |  39 ++--
 linux-user/mips/elfload.c               |   6 +
 migration/vfio-stub.c                   |  16 ++
 migration/vfio.c                        |  14 --
 page-target.c                           |  21 --
 target-info-stub.c                      |   4 +
 target/mips/tcg/system/tlb_helper.c     |   2 +-
 target/ppc/kvm.c                        |   6 +-
 target/ppc/misc_helper.c                |  59 +----
 hw/intc/meson.build                     |   6 +-
 hw/meson.build                          |  45 ++--
 hw/mips/Kconfig                         |   7 -
 hw/mips/meson.build                     |   1 -
 hw/net/Kconfig                          |   3 -
 hw/net/meson.build                      |   1 -
 hw/net/trace-events                     |   7 -
 migration/meson.build                   |   8 +-
 scripts/coverity-scan/COMPONENTS.md     |   3 +
 57 files changed, 331 insertions(+), 785 deletions(-)
 delete mode 100644 hw/mips/mipssim.c
 delete mode 100644 hw/net/mipsnet.c
 create mode 100644 migration/vfio-stub.c
 delete mode 100644 page-target.c

-- 
2.51.0


