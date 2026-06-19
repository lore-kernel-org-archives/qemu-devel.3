Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA6CDB46B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRAT-0008MR-88; Fri, 19 Jun 2026 00:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRAB-0008LM-M0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:12 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1waRA6-0005Ft-SP
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:49:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-845438a46d4so791321b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 21:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781844539; x=1782449339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=30hGgoPrHRyAt5aIu0xhOcmwM3yeZQ1gOMqUkh60lMk=;
 b=nMZCn7CkV3dY9J+jH2kIj/a+05wSC/HOAPAFwcAhtwanSHSoxFkdzKzGEhC6mT8qtk
 RAlXJCs0iLV/w9bIeyskuEdXxkTo7RrkS5uBiX52Dm4qZfm7n6ngG094i+TuYeoZ4tfa
 m69dKpuXzwPVC9nyQiAqRCDnvSsWYX2dASG2Lp92XmxsrOilBdpaYpbPT2565ci6+mTW
 pggo3sAGZbo7eKOkU0LgEpUQVIQG26WkyuR9zNB5sjvpgtKIuESRFoQ8FV9Aft38bVFJ
 eHKk5n1s0Ps1+wWQjldNaggbK7Lwik8FpnODs6VxpRBt9Rb788XQqZDW5X8v665tijmh
 ZfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781844539; x=1782449339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30hGgoPrHRyAt5aIu0xhOcmwM3yeZQ1gOMqUkh60lMk=;
 b=harULYOTW8Tf/tDXZTCe2jvgMbe4PQBhV70M3dbfQbr6ehEN4hRYpxvwdfXHzV8gS8
 YJrIbCTKsbcqVLgwhSDM3HhHNV1+4C4CqxPXAx/mQgD75b3H1Go32+poZdwxfdwokJE0
 gZji1AYyWfy/pgrPgfLXqUutCS5xsCj+jCZ8M/7mQ1/nXdSsSm3ajpTfdMnkO1BhL4L5
 eWH9Zcu/0IbFyIjVlaEJX1lTTDrEEKc0/NdhbMsS77IVHC0ZPnuz1fxh8g3A8rzSd8iH
 CHqAwp/cSgjEXDLPwEAC6QGfhmTSb6AJYkIi2G2Hw6DeRYCNbPF3zZv1LFBhPM8B9ott
 jRpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/WVpHb9jCEcV32BXoxMG+QeuqznJ7+vchpTXr2eB2l75JG25JGxw/hiCn0N0IQbt7sOE07Ojg2sUWr@nongnu.org
X-Gm-Message-State: AOJu0YwwYgGn50cpXZ2EGZ/tisV3qiurPUVSHfYhes/Ueay6PgGGJufI
 1LYzOM00TRG55rQ6xDbFf3n83Dy/tPQ1nhMqhJAbUFOEvGbrNP4YI1Cb
X-Gm-Gg: AfdE7cnQXfqh+At8PN8zXij9okbmpaymIEHpQRpqM9GOD3oAbmfqe8Hz5Xcs5b3iZxL
 YumorRK9PltCirH3njYR0p+Zyo0hF0WWf53+tjPQ6f/UeZgu+FOch3ETOkv3dxPAmZbFGDUudY5
 /LoQ6saWfsn+P4OfOZMUDXUFIaCWBFEVsLsNUkHivYWePAT88Q61EjaCcssTmYu3yFZD6IQAOXS
 0T40VBGNf7er/piF9Vo5GWRLCQFoLKz589y3I/4L5rsZOHwHg/qEb0uDON6T9UCUfsFQdkULPav
 hhJXUGU9XNYJPola0MTvGflw3CadjfyzY6AUbktyY1DrnWe6S2tR7Qf0S9TdWua2oDdZU6LKNkw
 G9NxwIv+l0raP7XrSG1zwyXQcrBWeZzhcXRePes4TXhvineT4bBch4qAnPSRi7GyW7AVBl2Y0O7
 bPgcnHMfZxk8VfdFdvKj5VOhLMf9RFXD1khZcwztLpIb2h4EOuw3ZEwJa8o6/YvAyshuHvLaUhc
 08cTMWi3GYV3yqsEU4A2lJX/Fot2+mlzm8HAPCP9Q==
X-Received: by 2002:a05:6a00:a257:b0:842:7fc8:eba with SMTP id
 d2e1a72fcca58-845507bbd87mr2179181b3a.11.1781844539371; 
 Thu, 18 Jun 2026 21:48:59 -0700 (PDT)
Received: from donnager-debian.. ([144.6.172.18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8455363da44sm870141b3a.8.2026.06.18.21.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 21:48:58 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chris Rauer <crauer@google.com>, Alano Song <alanosong@163.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH v9 00/12] hw/riscv: Add the Tenstorrent Atlantis machine
Date: Fri, 19 Jun 2026 14:18:24 +0930
Message-ID: <20260619044838.1054677-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introducing Tenstorrent Atlantis!

 The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
 and CoreLab Technology. It is based on the Atlantis SoC, which includes
 the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.

 The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
 RISC-V CPU.

Thanks to Alistair and Phil for the reviews.

v8: https://lore.kernel.org/qemu-riscv/20260603065859.592063-1-joel@jms.id.au/

Changes since v8:
 - Use uint32_t for imsic stride
 - Rebase on Daniel's upstream fdt helpers and use them
 - Fix dram memory layout and handle < 2GB case 
 - Warn when modifying provided device tree memory node 
 - Add experimental to machine description so users who haven't read the
   docs know the machine is WIP
 - Minor dw i2c fixes: avoid guest_error at reset time, fix DW_IC_CON
   valid mask
 - Add Portia and Anirudh as Reviewers for Tenstorrent machines

Chris Rauer (1):
  hw/i2c: Add DesignWare I2C Controller

Joel Stanley (6):
  hw/riscv/virt: Move AIA initialisation to helper file
  hw/riscv/aia: Provide number of irq sources
  hw/riscv/aia: Configure stride for the M-mode IMSIC
  hw/riscv: Add Tenstorrent Atlantis machine
  hw/riscv/atlantis: Integrate i2c controllers
  hw/riscv/atlantis: Add some i2c peripherals

Nicholas Piggin (5):
  hw/riscv/boot: Describe discontiguous memory in boot_info
  hw/riscv/boot: Account for discontiguous memory when loading firmware
  target/riscv: tt-ascalon: Enable Zkr extension
  hw/riscv/atlantis: Provide a simple halting payload
  tests/functional/riscv64: Add tt-atlantis tests

 MAINTAINERS                                  |  21 +
 docs/system/riscv/tt_atlantis.rst            |  41 +
 docs/system/target-riscv.rst                 |   1 +
 hw/riscv/aia.h                               |  26 +
 include/hw/i2c/designware_i2c.h              |  56 ++
 include/hw/riscv/boot.h                      |  12 +-
 include/hw/riscv/tt_atlantis.h               |  64 ++
 include/hw/riscv/virt.h                      |   2 +-
 hw/i2c/designware_i2c.c                      | 745 +++++++++++++++++++
 hw/riscv/aia.c                               |  94 +++
 hw/riscv/boot.c                              |  34 +-
 hw/riscv/k230.c                              |   8 +-
 hw/riscv/microchip_pfsoc.c                   |   8 +-
 hw/riscv/opentitan.c                         |   6 +-
 hw/riscv/shakti_c.c                          |   6 +-
 hw/riscv/sifive_u.c                          |   6 +-
 hw/riscv/spike.c                             |   6 +-
 hw/riscv/tt_atlantis.c                       | 636 ++++++++++++++++
 hw/riscv/virt-acpi-build.c                   |  27 +-
 hw/riscv/virt.c                              |  97 +--
 hw/riscv/xiangshan_kmh.c                     |   6 +-
 target/riscv/cpu.c                           |   1 +
 hw/i2c/Kconfig                               |   5 +
 hw/i2c/meson.build                           |   1 +
 hw/riscv/Kconfig                             |  13 +
 hw/riscv/meson.build                         |   2 +
 tests/functional/riscv64/meson.build         |   1 +
 tests/functional/riscv64/test_opensbi.py     |   4 +
 tests/functional/riscv64/test_tt_atlantis.py |  57 ++
 29 files changed, 1878 insertions(+), 108 deletions(-)
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


