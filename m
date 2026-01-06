Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E572CD043A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04H-0003QP-22; Tue, 06 Jan 2026 00:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04B-0003JX-0y
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:15 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd048-0001ju-KM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:14 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c3cb504efso716599a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679030; x=1768283830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=+bSd+xF/k2sME2hDvH8mdjlOZr09+Lkw6VV7qfy6PR0=;
 b=nIfNbCkZnU9r3wwoY+rZfkxUCx3Qb317EROUrxG4RuD3BU1N0pN1xxBUunesGtt8XT
 /n6Irk3SD2WZoQsoNI1m6lqRxO/qS8trtGATuipoJZ06TcYYx8gCRHPBge2iN3DJ3KzD
 L2syph/nO0V/RLgQYPwBAWaJp3dw/6kEJK6onX0SwbU4AIkuHY69Woxrh/6fh+5N21eU
 sSrm3R/1iGykB3kj5wrsnu5SmjQ5qZ7uL4l2pEBn58rnIkdbJoX4LRJMTrRMg/jbK/Iw
 sd4U+9mqQ7JigKVHiptAhcakqX12v/01H8zs02K4I/N9QezP36ufFIJEYc28lsIQxoaR
 1wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679030; x=1768283830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bSd+xF/k2sME2hDvH8mdjlOZr09+Lkw6VV7qfy6PR0=;
 b=u2MKRNpemP/nQ8+hsP7cDDJSksDsLLsTrEzZUvtrpDAn5MbzRNGfnHB3j1Lk7QsAdt
 CEdwQAS6nONsK221GSIJNiZ25bfYv2QZQnCYIGwXvywMbIkLe5ttDDFsoUfZPVvNGO/5
 zSxlG3/WRqIY9aF2yz3MqfCBSoDQIxX07e6Pvi4RhBVJ6hHaCKwreiVw7XMgPUkhklNX
 otpfIeTBJc4xqmQ3ZlzMjarQVzW594bh25oPJKz6Ddb36KgvcUiGxi0gmsc0qzFctWlz
 6mijtAgwK6K1jmjytS3/lYlPdGGGyKx3gf1FA2IOcvYlxofUl+sHyR+ig4Sw8IXQOXh+
 4ciw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWGxFhmqBm2fGY2yKVMQjXyenYADF3fCx7Y9OthxSCOGT31T++FTVid8j4EyEeNFiV0F0rKXudPdUh@nongnu.org
X-Gm-Message-State: AOJu0Yzyag02gWCy9IscsiA2qM1/cR567WtpECSiJoXtF4y/eLDl8MbT
 H2oS5u9unToQYB1/fw0BkH3mtBh0XikkGPhQuTJ+ghZu7Qrw6x4xyGKd
X-Gm-Gg: AY/fxX7NZi1T+yIE8u13LQ8eiVQ97iO+xGUIA5hfebJZVMpzLMeFfLVu+vpNtCseYv9
 U8PXpyQcTKmG+93HCdpNYgVW3RjYOdyjfLStcY4aWZru8xBUsdL98BodfWIo++FTC22eOpvF1sk
 ueBeGbGydya2RuBS7MpYD5U7/RmHyc/rIQNktnP9IhOgoQ6S3sytkFrkn8W1O42a+O8CwhheR7T
 vRevn53wTof/vIK3lBe75kObiCDHN6GAoeJPqabcBOv6aF3ycwDKNgZDuY2TBOYFfRgna1taFoJ
 Px87Lw3dtqk5hg5iJHvb2ku7BVX21ZISw3Ph2w9vXRaBMo0aLMOiX9fDL1BveJF8IJtB+bwMpev
 JLkoE/sr8u55axVEn5HP4FtXd8VD6C+hfPiYz4sxyyvXcwB5x+IcaJlQwgq9iE7sBvwUIBaR9hl
 CkbnCfRpxqHIQDR1Hz1xs/
X-Google-Smtp-Source: AGHT+IHfj7L0WiKHO0tfb/kuIiUrQrrP8keUu00gI/91qdg6YkSfg9Pn2gBRzFI7SREZyIvnMmFvfw==
X-Received: by 2002:a17:90b:1d45:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-34f5f32de30mr1341774a91.34.1767679030423; 
 Mon, 05 Jan 2026 21:57:10 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:09 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 00/16] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Tue,  6 Jan 2026 16:26:40 +1030
Message-ID: <20260106055658.209029-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

This initial series adds the base machine support including:

 - AIA (Advanced Interrupt Architecture) support
 - PCIe controller and DesignWare I2C integration
 - Serial console and device tree generation
 - Functional tests for OpenSBI+Linux boot

Changes outside of adding the machine:

 - Atlantis maps DRAM high in the address space but maintains an alias
   for the first 2GB at 0x0. We have updated the RISC-V boot loader code
   to support boot_info for discontiguous memory layouts.

 - The riscv64 virt machine AIA initialisation has been moved to a
   helper file to allow code reuse with the Atlantis machine

 - Revived the DesignWare I2C controller model (previously proposed for
   ARM virt) with permission from the original author.

I hope to get early feedback on the base machine now. We intend to
continue modelling the soc so it can be useful for firmware and
operating system development and testing, so expect more patches to do
that soon.

Chris Rauer (1):
  hw/i2c: Add designware i2c controller

Joel Stanley (6):
  target/riscv: tt-ascalon: Add Tenstorrent mvendorid
  hw/riscv: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c buses
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (9):
  target/riscv: tt-ascalon: Enable Zkr extension
  target/riscv: tt-ascalon: Add Svadu extension
  riscv/boot: Describe discontiguous memory in boot_info
  riscv/boot: Account for discontiguous memory when loading firmware
  hw/riscv/atlantis: Add PCIe controller
  tests/functional/riscv64: Add tt-atlantis tests
  hw/riscv/boot: Warn if a ELF format file is loaded as a binary
  hw/riscv/boot: Provide a simple halting payload
  hw/riscv/atlantis: Use halting kernel if there is no payload

 MAINTAINERS                                  |  15 +
 docs/system/riscv/tt_atlantis.rst            |  38 +
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/aia.h                               |  59 ++
 include/hw/i2c/designware_i2c.h              | 101 ++
 include/hw/riscv/boot.h                      |  14 +-
 include/hw/riscv/tt_atlantis.h               |  95 ++
 include/hw/riscv/virt.h                      |  30 +-
 target/riscv/cpu_vendorid.h                  |   2 +
 hw/i2c/designware_i2c.c                      | 813 ++++++++++++++++
 hw/riscv/aia.c                               |  89 ++
 hw/riscv/boot.c                              |  73 +-
 hw/riscv/microchip_pfsoc.c                   |   6 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   3 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 917 +++++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  24 +-
 hw/riscv/virt.c                              |  94 +-
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 target/riscv/cpu.c                           |   4 +-
 hw/i2c/Kconfig                               |   4 +
 hw/i2c/meson.build                           |   1 +
 hw/riscv/Kconfig                             |  21 +
 hw/riscv/meson.build                         |   3 +-
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  68 ++
 29 files changed, 2365 insertions(+), 139 deletions(-)
 create mode 100644 docs/system/riscv/tt_atlantis.rst
 create mode 100644 hw/riscv/aia.h
 create mode 100644 include/hw/i2c/designware_i2c.h
 create mode 100644 include/hw/riscv/tt_atlantis.h
 create mode 100644 hw/i2c/designware_i2c.c
 create mode 100644 hw/riscv/aia.c
 create mode 100644 hw/riscv/tt_atlantis.c
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

-- 
2.47.3


