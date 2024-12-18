Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434F3E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Yj-000302-W4; Wed, 18 Dec 2024 17:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yf-0002zl-Pi
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Yd-0001rD-O5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:21 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so2146805ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561017; x=1735165817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jdv9Pu830lPDIAEMJbLdF4GTTGNKTQjj20qmaHswvqE=;
 b=cmDtxOwbx1vEp1vwhtMwtlPHjeLW9E+SQEMFyBjyq5JzhxNtwO7HjwCnJ0+6qDkdkb
 RzrLYKzPP3ZHl5K80nyNKVIWeztwMgKjOy4mRg+tNzq9quFK7sbzPeVICWoOC+smKzvC
 eWYHwMn3dCl8jt/SNtcJEJa7QfsoQGaF5dkLwRugxO4grMwvV2miwpDsDyA7lERrLDcQ
 rXU1S8RJg65IXylmFqGpMiQwNMHOubjiRMGNfzdqWOXfd06z3GX7JM8T5E1akRmNJGij
 LVyyjGn+PdlgNjbIlH+do1g8oXvy2Rur6wUivZnfFRYsiKt8IQjlj/xkFYrwAnmuM+yV
 Q0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561017; x=1735165817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jdv9Pu830lPDIAEMJbLdF4GTTGNKTQjj20qmaHswvqE=;
 b=Yb+3oimpAFwnNE2MDJFVxlvSIU9yc0XvBZ3oqgoLSp17zcynJxuN3vc2MScy6vH7XL
 edLyl23hKoVhSl4wSQS1zxpvrj9GQK4XgsTOVghsfm6dVP7zxV3hnZUb0XAIl07ezkLd
 1XC/ajrloJKUMcn4wkYgJ9jMl8LdTtHsAmQFrtZ1Vw0K8AGnfyNq7wpNwE6/lgUQbaOR
 bYNh/2G6AUybJOESuyThmZzzfnr7XpcAoNjxNYIkCCx4MtB/FUibAobnxEwxKb4TD80R
 DT8p6pCG1o00WGYloG48pH5ouzTh9/y6OcWGYzW4Cja93khJV58FS5zSOols7XHjJwBm
 6wEw==
X-Gm-Message-State: AOJu0YyUwEtNnfMwy4RPHJLndYS8UDsvJruydaYVJbsqT5c1J3kuO+NP
 L+1jj4qhsGu3qUDqE6mjBm5HhLzAmUmUjgjOohIyPUWs07239L9wbrBKl439
X-Gm-Gg: ASbGncuW52ie7RGWeSvaBTBpqwGsWAgaxmccwOoaF96erHWwdR894DjaI70FDIfZO3b
 7GXBO28x5ooOvIEaQ12uLn717g3MAQ/N4ez6AFT81xZbqchPNYSJocD8XJpKVSuVSZb7XapZBwZ
 v4PCuifFZRh0kS0WxAUEGrL40Yl4AKV3qEADrAFZoSNL4KtJoM0m9lsAzBt6Iu01huLkSwJPwLZ
 378JXaYdHoo3ZvQ3znUbm4Q8Ax/nxMv3q7qIXMROg+8RfDVLtI+65rjEob0ym9Q/7dgGT7qmcRK
 +SN9wFhN+BngCp8whMt4GGEuZzEqVuyFgfbKq2nol7nJxMB6xsFEixzCTBZje+Y=
X-Google-Smtp-Source: AGHT+IHd9EK4+ugYTQFJ+w4sDJwE0W3C36m1F3lQHCtQ4RH79a5JAKsjbu6sWAdudQ1KQMBr8zep6w==
X-Received: by 2002:a17:902:da8b:b0:215:3fb9:5201 with SMTP id
 d9443c01a7336-218d7252a53mr66062335ad.44.1734561016772; 
 Wed, 18 Dec 2024 14:30:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/39] riscv-to-apply queue
Date: Thu, 19 Dec 2024 08:29:30 +1000
Message-ID: <20241218223010.1931245-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:

  Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241219-1

for you to fetch changes up to 5632d271be16b5e769342d54198c4359658abcb7:

  target/riscv: add support for RV64 Xiangshan Nanhu CPU (2024-12-18 11:07:59 +1000)

----------------------------------------------------------------
RISC-V PR for 10.0

* Correct the validness check of iova
* Fix APLIC in_clrip and clripnum write emulation
* Support riscv-iommu-sys device
* Add Tenstorrent Ascalon CPU
* Add AIA userspace irqchip_split support
* Add Microblaze V generic board
* Upgrade ACPI SPCR table to support SPCR table revision 4 format
* Remove tswap64() calls from HTIF
* Support 64-bit address of initrd
* Introduce svukte ISA extension
* Support ssstateen extension
* Support for RV64 Xiangshan Nanhu CPU

----------------------------------------------------------------
Anton Blanchard (1):
      target/riscv: Add Tenstorrent Ascalon CPU

Daniel Henrique Barboza (15):
      hw/riscv/riscv-iommu.c: add riscv_iommu_instance_init()
      hw/riscv/riscv-iommu: parametrize CAP.IGS
      hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support
      hw/riscv/riscv-iommu: implement reset protocol
      docs/specs: add riscv-iommu-sys information
      hw/intc/riscv_aplic: rename is_kvm_aia()
      hw/riscv/virt.c: reduce virt_use_kvm_aia() usage
      hw/riscv/virt.c: rename helper to virt_use_kvm_aia_aplic_imsic()
      target/riscv/kvm: consider irqchip_split() in aia_create()
      hw/riscv/virt.c, riscv_aplic.c: add 'emulated_aplic' helpers
      hw/intc/riscv_aplic: add kvm_msicfgaddr for split mode aplic-imsic
      target/riscv/kvm: remove irqchip_split() restriction
      docs: update riscv/virt.rst with kernel-irqchip=split support
      target/riscv/tcg: hide warn for named feats when disabling via priv_ver
      target/riscv: add ssstateen

Fea.Wang (6):
      target/riscv: Add svukte extension capability variable
      target/riscv: Support senvcfg[UKTE] bit when svukte extension is enabled
      target/riscv: Support hstatus[HUKTE] bit when svukte extension is enabled
      target/riscv: Check memory access to meet svukte rule
      target/riscv: Expose svukte ISA extension
      target/riscv: Check svukte is not enabled in RV32

Jason Chien (1):
      hw/riscv/riscv-iommu.c: Correct the validness check of iova

Jim Shu (3):
      hw/riscv: Support to load DTB after 3GB memory on 64-bit system.
      hw/riscv: Add a new struct RISCVBootInfo
      hw/riscv: Add the checking if DTB overlaps to kernel or initrd

MollyChen (1):
      target/riscv: add support for RV64 Xiangshan Nanhu CPU

Philippe Mathieu-Daudé (5):
      MAINTAINERS: Cover RISC-V HTIF interface
      hw/char/riscv_htif: Explicit little-endian implementation
      hw/char/riscv_htif: Clarify MemoryRegionOps expect 32-bit accesses
      target/riscv: Include missing headers in 'vector_internals.h'
      target/riscv: Include missing headers in 'internals.h'

Sai Pavan Boddu (1):
      hw/riscv: Add Microblaze V generic board

Sia Jee Heng (3):
      qtest: allow SPCR acpi table changes
      hw/acpi: Upgrade ACPI SPCR table to support SPCR table revision 4 format
      tests/qtest/bios-tables-test: Update virt SPCR golden reference for RISC-V

Sunil V L (1):
      hw/riscv/virt: Add IOMMU as platform device if the option is set

Tomasz Jeznach (1):
      hw/riscv: add riscv-iommu-sys platform device

Yong-Xuan Wang (1):
      hw/intc/riscv_aplic: Fix APLIC in_clrip and clripnum write emulation

 MAINTAINERS                                |   8 +
 docs/specs/index.rst                       |   1 +
 docs/specs/riscv-aia.rst                   |  83 ++++++++++
 docs/specs/riscv-iommu.rst                 |  30 +++-
 docs/system/riscv/microblaze-v-generic.rst |  42 +++++
 docs/system/riscv/virt.rst                 |  17 ++
 docs/system/target-riscv.rst               |   1 +
 hw/riscv/riscv-iommu-bits.h                |   6 +
 hw/riscv/riscv-iommu.h                     |   5 +
 include/hw/acpi/acpi-defs.h                |   7 +-
 include/hw/acpi/aml-build.h                |   2 +-
 include/hw/intc/riscv_aplic.h              |   8 +
 include/hw/riscv/boot.h                    |  28 +++-
 include/hw/riscv/iommu.h                   |  10 +-
 include/hw/riscv/virt.h                    |   6 +-
 target/riscv/cpu-qom.h                     |   2 +
 target/riscv/cpu_bits.h                    |   2 +
 target/riscv/cpu_cfg.h                     |   2 +
 target/riscv/internals.h                   |   3 +
 target/riscv/vector_internals.h            |   1 +
 hw/acpi/aml-build.c                        |  20 ++-
 hw/arm/virt-acpi-build.c                   |   8 +-
 hw/char/riscv_htif.c                       |  15 +-
 hw/intc/riscv_aplic.c                      |  74 +++++++--
 hw/loongarch/acpi-build.c                  |   6 +-
 hw/riscv/boot.c                            | 100 +++++++----
 hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
 hw/riscv/microchip_pfsoc.c                 |  13 +-
 hw/riscv/opentitan.c                       |   4 +-
 hw/riscv/riscv-iommu-pci.c                 |  21 +++
 hw/riscv/riscv-iommu-sys.c                 | 256 +++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu.c                     | 137 ++++++++++-----
 hw/riscv/sifive_e.c                        |   4 +-
 hw/riscv/sifive_u.c                        |  18 +-
 hw/riscv/spike.c                           |  14 +-
 hw/riscv/virt-acpi-build.c                 |  12 +-
 hw/riscv/virt.c                            | 159 +++++++++++++++---
 target/riscv/cpu.c                         | 101 ++++++++++++
 target/riscv/cpu_helper.c                  |  55 +++++++
 target/riscv/csr.c                         |   7 +
 target/riscv/kvm/kvm-cpu.c                 |  43 ++---
 target/riscv/tcg/tcg-cpu.c                 |  27 ++-
 hw/riscv/Kconfig                           |   8 +
 hw/riscv/meson.build                       |   3 +-
 hw/riscv/trace-events                      |   4 +
 tests/data/acpi/riscv64/virt/SPCR          | Bin 80 -> 90 bytes
 46 files changed, 1380 insertions(+), 177 deletions(-)
 create mode 100644 docs/specs/riscv-aia.rst
 create mode 100644 docs/system/riscv/microblaze-v-generic.rst
 create mode 100644 hw/riscv/microblaze-v-generic.c
 create mode 100644 hw/riscv/riscv-iommu-sys.c

