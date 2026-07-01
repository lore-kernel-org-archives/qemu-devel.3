Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEA1C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes1F-0007sh-LZ; Wed, 01 Jul 2026 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1D-0007sS-ME
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:11 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes1B-0004Mh-IB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:18:11 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-137335bc3caso973708c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901088; x=1783505888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vK+UhYDuJpixhI7TmqzOfxEUUHTP7zTnhEPWWK+I7fk=;
 b=ZTWhv4yE/zc0myJtsd0lLmH/abQc+Dn7laUsDDSYp+fXMQo0giyyiMc4AQi4cRc63D
 FwunPWsr3uBCdn1dQf+OS45vFyMd2/Kcny3E7X9TikJL8/UCJoTU7PO5JLn33m9aYWSq
 7/tdpA43Zn+B4Nz5pEP/0JWyiACyxw8KCIzm3CRXEbPGhvy5f5eDjOYasKbGmG5y8gjS
 giZaHBefN0O0OKg8PqP/hisyEiG1mF0yPm/x38MH6NkH8ARBnM7natcStoRNlptYDIz6
 9ZnQOv/mX5gYl69ffL4dJXdk+GqUYzNcODfj+CbUQI+81cuPUe+YXmXLf2xlFSOM9F3p
 0x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901088; x=1783505888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vK+UhYDuJpixhI7TmqzOfxEUUHTP7zTnhEPWWK+I7fk=;
 b=EAT2yfnbQacvN4YBa4xpUSK3/MVQn2x/qeV2UtcEr5F4TGN7zY5FOJ/VwcvVjuWeLw
 x1dxzZbpMF92Gs5airtZbn5qMy+mT26SVE5MIDaJ2yj3kSe9jpXOUDfdl/2lSpANCWIP
 HimiOmt5SHTcmp58bQDOINq/LjqM/0zdyG85ci9AupDZIPmW9tyqap8Wxt9AaIsqv8kN
 wu744e+nzqPBR7LX7Bnhau45Bh25B1DoT9tLP075lFGnV4wWLT9UsB3YkUyqRVH/3pPh
 TzRrtQnHYQU5tkBLr++HLoeMkJziXgsTC+jmFxnErCa5rRbn8RhgMxeMFjTmUb4WznDQ
 ctSQ==
X-Gm-Message-State: AOJu0YxflGvVub+yOoTx/b5GMyDcG3MpKFDwg8NmMLD7+UI7hFxiORLF
 LVseSUaVu3B2BmDkEnD1iDOtOaYMlQgiI8QwhRoILroYlJaQdQY4sNTmwj+A4g==
X-Gm-Gg: AfdE7ckd2UpuT3h1wjF3+bQXHElHY3qhsIloVwq9K94w26b3HnruB2kusEfyDd2Vl8e
 K8iNqIYrs3+fIQUCcapPSMOln540YJedEG6yJTEr6nmxogCW4t1QGVpnUtGrpCzdfK8QW9Ctp7U
 QjfGP4UZvtGlvacBZH1KIklwLHk4mpIWj4/BCFqk4I/dw2iJ3Kf1fjm+49fozM+kDBBlDTvBFYn
 1SqHoiyFTn0a2UTIJeBWrDzq3eGAS22qOeq2sG7l3jUx6gB0tlFDcVjtIFYCPACsgFNelmBBQDZ
 XI71jc02gWqRZJpl2LUuG9vMKFbf49UY/FJ6e4BMcc9bBeTCEvVNIWIcn8Z7w5iEGUy1/u/8LPi
 kdoYFfbB1Dm68ySpC+CN5X+YPIpogvn8XpE2nN4PymOFPoX9QfoZt5kKUBk965zm8WoSmElvOOG
 jT/vlLWRDYXhRwIY0kkNrSRy/zkg5G280=
X-Received: by 2002:a05:7023:b16:b0:139:cf4f:3b80 with SMTP id
 a92af1059eb24-13b3916e114mr151288c88.34.1782901087861; 
 Wed, 01 Jul 2026 03:18:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:18:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/39] riscv-to-apply queue
Date: Wed,  1 Jul 2026 20:17:13 +1000
Message-ID: <20260701101752.2522962-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122b.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 30e8a06b64aa58a3990ba39cb5d09531e7d265e0:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2026-06-29 17:41:42 +0200)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260701

for you to fetch changes up to 64ce9ac18757d79f3b5b337f7bcbdd0dabef3ce1:

  hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0 (2026-07-01 20:14:20 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1

* Fix IMSIC CSR write and add tests
* Parametrise debug trigger number
* Add 'svbare' satp-mode
* Fix RINTC PLIC context ID for KVM
* Avoid abort when reading vtype before env->xl is set
* Skip reset for KVM irqchip
* Skip FP/Vector sync on KVM_PUT_RUNTIME_STATE
* More FDT cleanups (PLIC)
* Make FCTL.BE in IOMMU read only 0
* Check DC.TC reserved bits in IOMMU
* Apply UXL WARL handling to vsstatus
* Set cmd_ill IOFENCE.C if rsvp bits are set in IOMMU
* Set RISCV_IOMMU_FQ_HDR_PV appropriately
* Fix MSI MRIF IOMMU interrupt-pending offset
* Report QEMU CPU archid as 42
* Check PMP before updating PTE
* Add the Tenstorrent Atlantis machine

----------------------------------------------------------------
Alistair Francis (1):
      hw/riscv/atlantis: Ensure OpenSBI has a non-zero next_addr

Charlie Jenkins (1):
      target/riscv: Report QEMU CPU archid as 42

Chris Rauer (1):
      hw/i2c: Add DesignWare I2C Controller

Daniel Henrique Barboza (16):
      target/riscv/cpu: add CPU unrealize callback
      target/riscv: dynamic alloc of debug trigger arrays
      target/riscv: add 'num-triggers' debug property
      target/riscv/cpu.c: add 'svbare' satp-mode
      hw/riscv/sifive_u.c: remove unneeded qemu_fdt_get_phandle() call
      hw/riscv/sifive_u.c: use intc_phandle in plic creation
      hw/riscv/sifive_u: add #address-cells in PLIC FDT
      hw/riscv/virt.c: change 'plic' nodename to 'interrupt-controller'
      hw/riscv: add create_fdt_plic() helper
      hw/riscv/riscv-iommu: rename regs_rw to regs
      hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
      hw/riscv/riscv-iommu: check DC.TC reserved bits
      hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are set
      hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV appropriately
      hw/riscv/riscv-iommu.c: fix MSI MRIF interrupt-pending offset
      hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0

Inochi Amaoto (1):
      target/riscv: Check PMP before updating PTE

Joel Stanley (9):
      target/riscv: Avoid NULL deref in IMSIC CSR write
      tests/functional/riscv64: Use newer kernel for tuxrun boot
      tests/functional/riscv64: Add virt machine AIA boot test
      hw/riscv/virt: Move AIA initialisation to helper file
      hw/riscv/aia: Provide number of irq sources
      hw/riscv/aia: Configure stride for the M-mode IMSIC
      hw/riscv: Add Tenstorrent Atlantis machine
      hw/riscv/atlantis: Integrate i2c controllers
      hw/riscv/atlantis: Add some i2c peripherals

Meng Zhuo (1):
      target/riscv/kvm: skip FP/Vector sync on KVM_PUT_RUNTIME_STATE

Nicholas Piggin (4):
      hw/riscv/boot: Describe discontiguous memory in boot_info
      hw/riscv/boot: Account for discontiguous memory when loading firmware
      target/riscv: tt-ascalon: Enable Zkr extension
      tests/functional/riscv64: Add tt-atlantis tests

Qingwei Hu (3):
      hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for KVM
      hw/intc: riscv_aplic: Skip reset for KVM irqchip
      hw/intc: riscv_imsic: Skip reset for KVM irqchip

SeungJu Cheon (1):
      target/riscv: Apply UXL WARL handling to vsstatus

ZhengXiang Qin (1):
      target/riscv: avoid abort when reading vtype before env->xl is set

 MAINTAINERS                                  |  21 +
 docs/system/riscv/tt_atlantis.rst            |  41 ++
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/aia.h                               |  26 +
 hw/riscv/riscv-iommu-bits.h                  |   4 +
 hw/riscv/riscv-iommu.h                       |  26 +-
 include/hw/i2c/designware_i2c.h              |  56 ++
 include/hw/riscv/boot.h                      |  12 +-
 include/hw/riscv/fdt-common.h                |   5 +
 include/hw/riscv/sifive_u.h                  |   2 +
 include/hw/riscv/tt_atlantis.h               |  64 +++
 include/hw/riscv/virt.h                      |   2 +-
 target/riscv/cpu.h                           |  39 +-
 target/riscv/debug.h                         |   1 +
 hw/i2c/designware_i2c.c                      | 745 +++++++++++++++++++++++++++
 hw/intc/riscv_aplic.c                        |   4 +
 hw/intc/riscv_imsic.c                        |   4 +
 hw/riscv/aia.c                               |  94 ++++
 hw/riscv/boot.c                              |  34 +-
 hw/riscv/fdt-common.c                        |  30 ++
 hw/riscv/k230.c                              |   8 +-
 hw/riscv/microchip_pfsoc.c                   |   8 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/riscv-iommu-hpm.c                   |   4 +-
 hw/riscv/riscv-iommu.c                       |  73 ++-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |  48 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 617 ++++++++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  29 +-
 hw/riscv/virt.c                              | 148 ++----
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 target/riscv/cpu.c                           |  43 +-
 target/riscv/cpu_helper.c                    |   8 +
 target/riscv/csr.c                           |  48 +-
 target/riscv/debug.c                         |  46 +-
 target/riscv/kvm/kvm-cpu.c                   |  19 +-
 target/riscv/machine.c                       |  16 +-
 hw/i2c/Kconfig                               |   5 +
 hw/i2c/meson.build                           |   1 +
 hw/riscv/Kconfig                             |  13 +
 hw/riscv/meson.build                         |   2 +
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  57 ++
 tests/functional/riscv64/test_tuxrun.py      |  11 +-
 46 files changed, 2196 insertions(+), 248 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/riscv/aia.h
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

