Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6F8E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEG-0005v9-Ac; Thu, 19 Dec 2024 20:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEF-0005v1-Gf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:54:59 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSED-0004BI-8a
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:54:59 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fdc6e04411so922217a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659694; x=1735264494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OB/NU3ycGgOaUP9hsWJcl3zGwGKcP7EBFauCdVFumGQ=;
 b=OStGZB7G33venKI88zWeJEOvGe6EwHdlDx8+P7YqAxdRLS14HxTR7k6GRv4U+Jdn6i
 Dj9r6R8w8SILMFEDqwlITKYO1FLX2PvoeTG1nBAt1/hRw2ZOa57bgG25lzbIztCDM7Oe
 Y6XGCiQawnr4oehj5kIwpYStHYnU6vAVQJuXB/h8ftl0sLqUJVc6em6DkS4F8jhjIS09
 fJa5Z1IR/rSJ6xDm+jMqu6CtbntCWSYSCqrf/adtwlYK8z54dhqa/RBgb4o0GjFSwRyn
 n33wtGWtoa5yVRh7hfmkbpZv+uCyKZhOerSy6mrF2sMNGQamFnM4/dI3eRjmOJKKXJZS
 Yfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659694; x=1735264494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OB/NU3ycGgOaUP9hsWJcl3zGwGKcP7EBFauCdVFumGQ=;
 b=nqzxQ2StyfFzPBmBsbzXYwueb00Z/xaWpLf6xWAASomnNoAhDx2OH8cTOFodx9z7qc
 OioQZBtGJp/2Iep46aX95EYzm80iViZZnrnfltXegzAm1UZEmEbgHfflk7Nqzm6euIuV
 blAWGe3hwQF0dXZqqLvtbD3rzItC2zSp7yPR29SVU4l2vZzfNa328HWQsgK1bbeTed1n
 rsWiskwVvFcoETxTQ2ILmLXLdQmo7jWLv7PcjXcZkLYy3+1dBqvVQpJ9X6vVNJHLt64Z
 6ZquODXEQV8G1dUaAq/0bU7Izl/M8YC6pKHS+2PrXFXAoVqSFSuLXBf25Tpbhi9dyVp3
 O3Xg==
X-Gm-Message-State: AOJu0YxgKHbFUNpxBj5wMcW3R6EOupIXMtcamvPz0LEXXvcqkkT1yvyM
 HSCbMmCOpCXqp2+QRy8Oe+mWgoUWlN2fxrFpgP5EaoURj809MKM2yAVPYImw
X-Gm-Gg: ASbGncuGPwyIpDJILnyQmdQvhWRVHggdSPC5157CQ1C9jdKOx0JMrechRQf8nZPnQ25
 BtaRxrYxkAX/6D7w3KYax6ajh8F5b7PTdWx5Hsn0TUM/EcNzEKQ0NbAqeHtUUKrvErWq5+GYJ4C
 JFJJlboLk4RqX0lgj3iGkFIxAvZVYNkeczDY8gw4QNdtvSrUdne+pPAbl0cS7zdFeQ/t4jfn2J7
 37wAwgszU/YHGuvk7iipfOXBngJeYoiLsCTTHWSLRwKZVauLDGnj1wSWRyVaWb44/6DOs3VcYLb
 y3WrL+ULapOM7y9TdIAmZaUqs4KwFcAHwfUguef4Y5b0c5w6170ErtVf6VxYfZU=
X-Google-Smtp-Source: AGHT+IFoIJxqgNW9FAPpS34aDMFc3yW302/dbmQy7vD2LQU8M8lpZJhC1dgW/B47hVJ/QEdt+UyUhA==
X-Received: by 2002:a05:6a21:8dc2:b0:1e1:ccf3:a72 with SMTP id
 adf61e73a8af0-1e5e07ffd40mr1721552637.28.1734659694404; 
 Thu, 19 Dec 2024 17:54:54 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:54:53 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/39] riscv-to-apply queue
Date: Fri, 20 Dec 2024 11:54:00 +1000
Message-ID: <20241220015441.317236-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

The following changes since commit 3e9793ab01904144c204589811e0e879109a9713:

  Merge tag 'qga-pull-2024-12-18' of https://github.com/kostyanf14/qemu into staging (2024-12-18 20:24:59 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20241220

for you to fetch changes up to 2fc8f50eadad5dcc99bc5de1333808b9de47a097:

  target/riscv: add support for RV64 Xiangshan Nanhu CPU (2024-12-20 11:22:47 +1000)

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

