Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97906C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfKx-0004bh-5z; Fri, 17 Jan 2025 00:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfKw-0004bH-7N
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:06 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfKu-0005sP-8e
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:05 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21634338cfdso42874865ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093362; x=1737698162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o/DZGZeWD0MxvygJ9aCip0QDeN363QjnwDH1CWULPhM=;
 b=mgnKYUeQRLqlzRMDHNrS84sYgBCDhPtw42CMWRPy7nNaQPGDRPtjsjzNtB4+8x5nbB
 z9YABT0RR00vhGzbQCu0YMb7mXclO9KunE6gJDpF/n8IHI1QsnHfYdhjh1UN6lWzzmPi
 /nrOyEsCDl9Ax/80NY+abpAk9oxr0Umx23/GSEF63WYpoFTAyaBWXqT34nnriATMI672
 1b69c3GTeaFjgr3w1oAkHSxzQ6vLoNxGVDwzm2x5DIf3f9KEAe6NhkwY8yv4zQjzPw4+
 Xvr9VXKiGkCLBJhASj420Y8k0agJS2RM91H30NegnILwSLPHHcIfle0um1u3xza8/gZx
 2gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093362; x=1737698162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o/DZGZeWD0MxvygJ9aCip0QDeN363QjnwDH1CWULPhM=;
 b=g4Hy33bpPmyOF4z8Fmi+iRekO9NDic03Xx/juBmzCt2wnORpbokD2DfhSUXvBUA2pl
 HQzNIv5TS2DMY1oVFJNZ07/VlWSoO++MKbhXzS9MWd9b7wMhzq0fevddHe3p1b0EwHFS
 iezGZbCuplC92xV2xLJnkmasNbHxG2caNbvzlav1kwWhmMigO0ggszXSTjB/UO7wba5t
 7RDR8xQnUyny+IkgIDFfpmqoPBO3/f9Nt/8Fb61S6dqkw8KFo1SZI45nTjtHVnb/tmqt
 Y9GIuSpGtCZpRHEFxemYFPydJahk/JTZm+RXMsVBGXvtp/hyFvs+Y1c2Kr2+r7bVHEzd
 I5Rg==
X-Gm-Message-State: AOJu0Yxl3bFg96ZZ/muNB1oKapHiiFsmbM/wwdtj6GqDUVxb6B180SPz
 Va+GdhdE/yYXFCgf0H6HHqh9ikLx23Z2CxihE56K6Fq/B+Ur5eJPy31nHg==
X-Gm-Gg: ASbGncsmRrDyYSHuBdgFdV9X1LX/LKGYGS5M/uQy0meIcZmYd7TdygirDO7ZEmKtT8z
 9R0vmP9HH4VfeVnLfkCy/L5dCk3FssDMzYbG8qDNOnYCYbWtkyFNqanzST0djcrbeDuqLiXnpdg
 UW21MFnueYMOFsG/f1mbLFgKVftZD/Kl2E6mOnD0bqVjFwef2OKnMUG90AhMfpNnz0B2QRX34p0
 pW0pdZ/pnaBbEwIBqTydqL9mU0Va3yMW+X+pqWE507CIujiUHM4ZJwugGQk/ZOrZ/6tcghc2N9M
 B41kJLeLMMbDbmNZXwxW7cn28Hb5W36PVVFkWzbmmrgkmyNDGszKL6gt4acW
X-Google-Smtp-Source: AGHT+IF0D2cx5M2E2iypYtYivzKLTiQSWOJFTOGFMTJDfHCE9vKI8UkTzg0mGhIzmHp06ppjkvOm3g==
X-Received: by 2002:a17:903:32ce:b0:215:b190:de6 with SMTP id
 d9443c01a7336-21c3553b341mr18521805ad.3.1737093361826; 
 Thu, 16 Jan 2025 21:56:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/50] riscv-to-apply queue
Date: Fri, 17 Jan 2025 15:55:02 +1000
Message-ID: <20250117055552.108376-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

The following changes since commit 4d5d933bbc7cc52f6cc6b9021f91fa06266222d5:

  Merge tag 'pull-xenfv-20250116' of git://git.infradead.org/users/dwmw2/qemu into staging (2025-01-16 09:03:43 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250117-2

for you to fetch changes up to f195d4af294f76762407e2273a564950a8f42db6:

  hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events (2025-01-17 15:52:56 +1000)

----------------------------------------------------------------
Second RISC-V PR for 10.0

* Reduce the overhead for simple RISC-V vector unit-stride loads and stores
* Add V bit to GDB priv reg
* Add 'sha' support
* Add traces for exceptions in user mode
* Update Pointer Masking to Zjpm v1.0
* Add Smrnmi support
* Fix timebase-frequency when using KVM acceleration
* Add RISC-V Counter delegation ISA extension support
* Add support for Smdbltrp and Ssdbltrp extensions
* Introduce a translation tag for the IOMMU page table cache
* Support Supm and Sspm as part of Zjpm v1.0
* Convert htif debug prints to trace events

----------------------------------------------------------------
Alexey Baturo (8):
      target/riscv: Remove obsolete pointer masking extension code.
      target/riscv: Add new CSR fields for S{sn, mn, m}pm extensions as part of Zjpm v1.0
      target/riscv: Add helper functions to calculate current number of masked bits for pointer masking
      target/riscv: Add pointer masking tb flags
      target/riscv: Update address modify functions to take into account pointer masking
      target/riscv: Apply pointer masking for virtualized memory accesses
      target/riscv: Enable updates for pointer masking variables and thus enable pointer masking extension
      target/riscv: Support Supm and Sspm as part of Zjpm v1.0

Atish Patra (5):
      target/riscv: Enable S*stateen bits for AIA
      target/riscv: Add properties for counter delegation ISA extensions
      target/riscv: Invoke pmu init after feature enable
      target/riscv: Add implied rule for counter delegation extensions
      target/riscv: Add configuration for S[m|s]csrind, Smcdeleg/Ssccfg

Clément Léger (9):
      target/riscv: Fix henvcfg potentially containing stale bits
      target/riscv: Add Ssdbltrp CSRs handling
      target/riscv: Implement Ssdbltrp sret, mret and mnret behavior
      target/riscv: Implement Ssdbltrp exception handling
      target/riscv: Add Ssdbltrp ISA extension enable switch
      target/riscv: Add Smdbltrp CSRs handling
      target/riscv: Implement Smdbltrp sret, mret and mnret behavior
      target/riscv: Implement Smdbltrp behavior
      target/riscv: Add Smdbltrp ISA extension enable switch

Craig Blackmore (2):
      target/riscv: rvv: fix typo in vext continuous ldst function names
      target/riscv: rvv: speed up small unit-stride loads and stores

Daniel Henrique Barboza (9):
      target/riscv: add shcounterenw
      target/riscv: add shvstvala
      target/riscv: add shtvala
      target/riscv: add shvstvecd
      target/riscv: add shvsatpa
      target/riscv: add shgatpa
      target/riscv/tcg: add sha
      target/riscv: use RISCVException enum in exception helpers
      target/riscv: add trace in riscv_raise_exception()

Frank Chang (1):
      target/riscv: Add Zicfilp support for Smrnmi

Jason Chien (1):
      hw/riscv/riscv-iommu.c: Introduce a translation tag for the page table cache

Kaiwen Xue (6):
      target/riscv: Add properties for Indirect CSR Access extension
      target/riscv: Decouple AIA processing from xiselect and xireg
      target/riscv: Support generic CSR indirect access
      target/riscv: Add counter delegation definitions
      target/riscv: Add select value range check for counter delegation
      target/riscv: Add counter delegation/configuration support

Philippe Mathieu-Daudé (3):
      target/riscv: Have kvm_riscv_get_timebase_frequency() take RISCVCPU cpu
      hw/riscv/virt: Remove unnecessary use of &first_cpu
      hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events

Tommy Wu (5):
      target/riscv: Add 'ext_smrnmi' in the RISCVCPUConfig
      target/riscv: Add Smrnmi CSRs
      target/riscv: Handle Smrnmi interrupt and exception
      target/riscv: Add Smrnmi mnret instruction
      target/riscv: Add Smrnmi cpu extension

Yanfeng Liu (1):
      riscv/gdbstub: add V bit to priv reg

 include/hw/riscv/riscv_hart.h                  |    4 +
 target/riscv/cpu.h                             |   65 +-
 target/riscv/cpu_bits.h                        |  157 ++-
 target/riscv/cpu_cfg.h                         |   13 +
 target/riscv/helper.h                          |    1 +
 target/riscv/internals.h                       |   54 +
 target/riscv/kvm/kvm_riscv.h                   |    4 +-
 target/riscv/pmp.h                             |    1 +
 target/riscv/insn32.decode                     |    3 +
 hw/char/riscv_htif.c                           |   15 +-
 hw/riscv/riscv-iommu.c                         |  205 +++-
 hw/riscv/riscv_hart.c                          |   41 +
 hw/riscv/virt.c                                |    2 +-
 target/riscv/cpu.c                             |   97 +-
 target/riscv/cpu_helper.c                      |  311 +++++-
 target/riscv/csr.c                             | 1257 +++++++++++++++++-------
 target/riscv/gdbstub.c                         |   23 +-
 target/riscv/kvm/kvm-cpu.c                     |    4 +-
 target/riscv/machine.c                         |   18 +-
 target/riscv/op_helper.c                       |  126 ++-
 target/riscv/pmp.c                             |   14 +-
 target/riscv/tcg/tcg-cpu.c                     |   50 +-
 target/riscv/translate.c                       |   49 +-
 target/riscv/vector_helper.c                   |   31 +-
 target/riscv/insn_trans/trans_privileged.c.inc |   20 +
 hw/char/trace-events                           |    4 +
 target/riscv/trace-events                      |    3 +
 tests/data/acpi/riscv64/virt/RHCT              |  Bin 332 -> 390 bytes
 28 files changed, 1852 insertions(+), 720 deletions(-)

