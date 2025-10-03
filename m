Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5318ACCA472
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSW-0006tb-Me; Thu, 02 Oct 2025 23:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSV-0006t1-CG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:27:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSJ-00019S-4L
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:27:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so2407953b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462050; x=1760066850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tlB7DAj2jIaFj0dYLUK1QlWYsLA0mmeVdPby1RZAezQ=;
 b=l04tp/DXGK4EplPaLUeJItZB50I+QYjGd/crkXhRs34q+i7xztIruG1ljfqzkp+Eb1
 ofSFFvFrZ/GgTXBI6SLWubXBrHu4oreYZeWmnTs6yTxMGJG6oj6/5u36TA6yiCjF7GpH
 TyMvjemU98uR80PSyN+m2UecZxLIH04YF43IFkF/nq6gibddkX0gClA5dqqOWXkt1kUN
 XoA2vwXgL5b4ZfC1ID4oBS4qmet2w40K5kFPFrQDPrB+Ntdnio7qbeCzU1NxPz3yGmsv
 oVOYRuG2/pbCME4PTyY47tDTQT0OLsN8bKdjeIRvLZXPd2veXAf8HpCmlCzT/bVrN2T8
 1NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462050; x=1760066850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tlB7DAj2jIaFj0dYLUK1QlWYsLA0mmeVdPby1RZAezQ=;
 b=YktY2c2N5vl38YrPaoLB6KOLbIZxpqpJXPJrZG+FzqLr5p6HfZHU/+oMxyHUMfCNVi
 7S4w9rPlh4/L0v4Umd2+ito5IjEJvwYGMVD/0V3vpqMJVNIpieZNevu7gbv/dH8ZFpwq
 b2qXRhTJSwJNMTxij8OGPczNKJypTtYZwTwnih+6Jfc/MUOm+f/dfjCt2ZdLLAcHM0Q8
 Z36mAv8sKz3Kq9957ioaohYwGmdQTTpibZ51g/9FmE8f2Pgcuafk90luIqgc68xOUNAz
 oI4WmWq4pAi8VFcON+v9Nf7v81sd6SjxWmJj5HxxhsplEHiqMhXco77LOeuqkAqmo3yw
 4xjg==
X-Gm-Message-State: AOJu0Yys5KK7u4WrZPNgPWR0giYIzbScR2jULgm9qCofkkUhzXS/YaDf
 RhTQC+G92BYfPXmo6vuN5OOrzhFNWfv82vkM16nX0O9jXXJvG/QZZB3NBPkcfA==
X-Gm-Gg: ASbGncvMblPs6NRrQA8YbqZarBV+z1nBuDxikn5rwenFa+0d37nUe75vTacyM9nLhvT
 lEkRwBFOSMnMD6V0x9d7NNZkUTHQX9wZHMrfNFsxmSCtjFILyOQLxFKcFB15hi+MsTRic63O+/T
 iMIv6KjiTmQ6H0fVcvUTwnnq14WWP5eaBjJ2geDYTskMw7nQLB/T+8Cb6u4hjIb7sBQoDYa2dGi
 f7q4dbmRo/TaBp+FIb8PxfhcTCqggS3qMfBux1+02K10pCALJSmrKCVoMZs34PYGbb0hcf9oD54
 a+MJNz7Z3DPKoe/re8jLqbI4vq1VTTcbKXUBH3l4T2OuzuBJDoAtQgpv53gI6N6j8cdeO9fFosX
 WkooycYfMyw3ksEEzWdR6h4nKc/Ey5tdvh2dgPrc8wRrg3jEbHpEJZZQq0BkIfk4uIFCMDaI+KV
 067E76QPsNWUXG0xnQvJMJ4b3fbzm6F7Zff3KcA6ydv+3be5e0SvIH
X-Google-Smtp-Source: AGHT+IH4zbvNTKDGrA5H3zztdRWbm7NkFbYGj4lHSzIh1KP54tZnBAD5+TzE1JuMiEeSgSMSr1rPiw==
X-Received: by 2002:a05:6a20:3d06:b0:32a:357:4ef3 with SMTP id
 adf61e73a8af0-32b620c8d0fmr1958998637.41.1759462049681; 
 Thu, 02 Oct 2025 20:27:29 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/26] riscv-to-apply queue
Date: Fri,  3 Oct 2025 13:26:52 +1000
Message-ID: <20251003032718.1324734-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 29b77c1a2db2d796bc3847852a5c8dc2a1e6e83b:

  Merge tag 'rust-ci-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-09-30 09:29:38 -0700)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20251003-3

for you to fetch changes up to ad2a0aa2824b1dac9f61bac33980e866e9a88856:

  docs: riscv-iommu: Update status of kernel support (2025-10-03 13:17:04 +1000)

----------------------------------------------------------------
First RISC-V PR for 10.2

* Fix MSI table size limit
* Add riscv64 to FirmwareArchitecture
* Sync RISC-V hwprobe with Linux
* Implement MonitorDef HMP API
* Update OpenSBI to v1.7
* Fix SiFive UART character drop issue and minor refactors
* Fix RISC-V timer migration issues
* Use riscv_cpu_is_32bit() when handling SBI_DBCN reg
* Use riscv_csrr in riscv_csr_read
* Align memory allocations to 2M on RISC-V
* Do not use translator_ldl in opcode_at
* Minor fixes of RISC-V CFI
* Modify minimum VLEN rule
* Fix vslide1[up|down].vx unexpected result when XLEN=32 and SEW=64
* Fixup IOMMU PDT Nested Walk
* Fix endianness swap on compressed instructions
* Update status of IOMMU kernel support

----------------------------------------------------------------
Andrea Bolognani (1):
      docs/interop/firmware: Add riscv64 to FirmwareArchitecture

Andrew Jones (1):
      hw/riscv/riscv-iommu: Fix MSI table size limit

Daniel Henrique Barboza (3):
      linux-user/syscall.c: sync RISC-V hwprobe with Linux
      target/riscv: implement MonitorDef HMP API
      roms/opensbi: Update to v1.7

Frank Chang (4):
      hw/char: sifive_uart: Raise IRQ according to the Tx/Rx watermark thresholds
      hw/char: sifive_uart: Avoid pushing Tx FIFO when size is zero
      hw/char: sifive_uart: Remove outdated comment about Tx FIFO
      hw/char: sifive_uart: Add newline to error message

Guo Ren (Alibaba DAMO Academy) (1):
      hw/riscv/riscv-iommu: Fixup PDT Nested Walk

Jim Shu (3):
      target/riscv: Fix the mepc when sspopchk triggers the exception
      target/riscv: Fix SSP CSR error handling in VU/VS mode
      target/riscv: Fix ssamoswap error handling

Joel Stanley (1):
      docs: riscv-iommu: Update status of kernel support

Max Chou (3):
      target/riscv: rvv: Replace checking V by checking Zve32x
      target/riscv: rvv: Modify minimum VLEN according to enabled vector extensions
      target/riscv: rvv: Fix vslide1[up|down].vx unexpected result when XLEN=32 and SEW=64

Philippe Mathieu-Daudé (1):
      target/riscv/kvm: Use riscv_cpu_is_32bit() when handling SBI_DBCN reg

TANG Tiancheng (4):
      hw/intc: Save time_delta in RISC-V mtimer VMState
      migration: Add support for a variable-length array of UINT32 pointers
      hw/intc: Save timers array in RISC-V mtimer VMState
      target/riscv: Save stimer and vstimer in CPU vmstate

Vladimir Isaev (1):
      target/riscv: do not use translator_ldl in opcode_at

Xuemei Liu (1):
      qemu/osdep: align memory allocations to 2M on RISC-V

stove (1):
      target/riscv: use riscv_csrr in riscv_csr_read

vhaudiquet (1):
      target/riscv: Fix endianness swap on compressed instructions

 docs/interop/firmware.json                     |   4 +-
 docs/specs/riscv-iommu.rst                     |  35 +++---
 include/hw/intc/riscv_aclint.h                 |   4 +
 include/migration/vmstate.h                    |  10 ++
 include/qemu/osdep.h                           |   2 +-
 target/riscv/cpu.h                             |   3 +-
 target/riscv/helper.h                          |  21 ++--
 hw/char/sifive_uart.c                          |  36 +++---
 hw/intc/riscv_aclint.c                         |   7 +-
 hw/riscv/riscv-iommu.c                         | 154 ++++++++++++++++++++++++-
 linux-user/syscall.c                           |  89 ++++++++++++++
 target/riscv/cpu.c                             |   2 +-
 target/riscv/csr.c                             |   5 +-
 target/riscv/kvm/kvm-cpu.c                     |   2 +-
 target/riscv/machine.c                         |  28 ++++-
 target/riscv/op_helper.c                       |  49 ++++++++
 target/riscv/riscv-qmp-cmds.c                  | 148 ++++++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                     |  21 +++-
 target/riscv/translate.c                       |   3 +-
 target/riscv/vector_helper.c                   |  20 ++--
 target/riscv/insn_trans/trans_rvv.c.inc        |  50 +++++++-
 target/riscv/insn_trans/trans_rvzce.c.inc      |   6 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc  |   9 ++
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 268312 -> 268752 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 272504 -> 273048 bytes
 roms/opensbi                                   |   2 +-
 26 files changed, 625 insertions(+), 85 deletions(-)

