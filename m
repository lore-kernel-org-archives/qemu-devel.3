Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE98C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJrk-000114-Vn; Sat, 18 Jan 2025 20:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrj-00010l-D0
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:39 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrh-00037H-Ex
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:39 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso4378527a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249155; x=1737853955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EcWGG17TpJC9w4/dKTMwfYIuQdOVA5FioRHCXe0U5BA=;
 b=Dy6+3cktShNVVqso1B934GQjJW0bzZlpbcxDq5VdNCIUntN557PK9+ZimnpFxyK7DS
 fdhv/Gvlw619QXgQmia3HdF9WXoMAttbJvKkOme+iXjrtYMtyhOCxqTQegzgwsLiMkea
 /NH9VdPV4T6hKGMUh2kMglzFy9/StFOHhdfmyidJcO163dIb+JS2w/ciPV4XVUtE/LMf
 an3M7HjPGMRdWUUuF5GQJUawGaZjNwuWNGaLyYrd0fdSPEoTWfRBeZcCxFB7NTrynfYH
 9uMjpLpRqPV8DCwa7OuVaXgFrP7sjP3tePM54NCkQ+y2Wpw1CB5lrE3IZEyu3zAaX9l/
 LViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249155; x=1737853955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EcWGG17TpJC9w4/dKTMwfYIuQdOVA5FioRHCXe0U5BA=;
 b=WbpYwsHnLtcwjqICAyUQqodslKTYVGWZ90CE6TN3aNGCoJcSKz0/L/pX8Br8OmWhzl
 08qISEBuKGtjOOWSkmIU5gD+kiIxYUV0v5wD2FoAIkG4aZ0OzBk8meR0e7ausFjM6351
 Twjb+xJcQ8gyymE+NjibnEHIisnAfowmVSOtfgnpID0hxxN6298ILkYFg4WS7uk59V8B
 jG7jouL0H6On8uDLaQ1SGjdsr/icwdq0sxqlMLwLMQd+xp/71FscHd4DjjSPMIvQqNR1
 1Fq3e72Jp/8Wh14XHGUN8weN8H1VWqk7lq5SC9GJpJjbhXILEy69gt+SvfysNa3Qraqm
 nGSA==
X-Gm-Message-State: AOJu0YzlUTvahgJWg3I2ROC5rLgT2QoOCLlzk+37AIbAsfQNeL6wcsP9
 jVffPqOFeQjnXBstDolyW6a/NKuuay41AbKwsDbW9cyas4c3NhF2noITsu31
X-Gm-Gg: ASbGncvs0AInwgxDDA1YuqsYW7RnWuxV3VNrZVS01sjBWD5ezYItQcamdF2vA+LQyRu
 xs6/Tu4cci6WWRNMsplZfhHklYZ+rEq6onhWL/YXpz6e6D81vOr3SIYRHaVfEVBP/2kCaoCkkZZ
 eLk4X+Ys4ypMT1RCcsXjsZblt4+ZrTON28UV0SkopnGoIDEfPt6dkeaZOKY8x9wE/9brYag2SoQ
 pH+B+HXHZPocaNPzl5nPtJ4JqssJ4H310tEfdHFG/8Q7BUujv5CNdCJQGQY1JvCbzUbEG6+3mdp
 UYTufchsVEiCqqsPmoQ4nsK4sFiFJ3O9iFYpBifeRRC5oLyjjxpStJlUhwYePRvAu7P/zNUpIg=
 =
X-Google-Smtp-Source: AGHT+IEanFAqSSXgPM5vTI6BHKoK7BqicBmJ+TA3/h96AWbTGgWGh4VkZT6fgknisygD4cexb6+hpQ==
X-Received: by 2002:a17:90b:270c:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f782d2c9a1mr9877014a91.23.1737249155101; 
 Sat, 18 Jan 2025 17:12:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:33 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 00/50] riscv-to-apply queue
Date: Sun, 19 Jan 2025 11:11:35 +1000
Message-ID: <20250119011225.11452-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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

The following changes since commit 0e3aff9ec34059512d597eacfcf4d1b5d4570c50:

  Merge tag 'pull-10.0-gdb-plugins-doc-updates-170125-1' of https://gitlab.com/stsquad/qemu into staging (2025-01-17 10:13:07 -0500)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20250119-1

for you to fetch changes up to f04cac4f8f254931f2af9d059b2175769e576afa:

  hw/char/riscv_htif: Convert HTIF_DEBUG() to trace events (2025-01-19 09:44:35 +1000)

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
* Convert htif debug prints to trace event

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
 target/riscv/tcg/tcg-cpu.c                     |   60 +-
 target/riscv/translate.c                       |   49 +-
 target/riscv/vector_helper.c                   |   31 +-
 target/riscv/insn_trans/trans_privileged.c.inc |   20 +
 hw/char/trace-events                           |    4 +
 target/riscv/trace-events                      |    3 +
 tests/data/acpi/riscv64/virt/RHCT              |  Bin 332 -> 390 bytes
 28 files changed, 1862 insertions(+), 720 deletions(-)

