Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E63CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pO-00075t-5E; Sun, 13 Oct 2024 18:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pM-00075T-Ew
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pK-0000tF-EN
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e3010478e6so1785512a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857557; x=1729462357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BUcNlrrEXrylRs7XbYRo7ccSUmqH8RPpjzZAaA0vSgw=;
 b=TRPJcviYM+1knba8368N+qaXN6TbsTLbHlffLOlBftloc3inh8+nbWbt0JWU7dzMuT
 41wb9YY1BApfWvlsxsfOCjI48kbqGLnp9V4nsIhLdvPl4jL1FvdBfTkGujLIH5JSs7k+
 j/sDQH+MJ1xxu00VXRrNGuMBZbleOrP8uCQr8HejHIPz+y6/berlpiIzgtjdzAZYETlY
 w8t/eFXrzJ0THzzU8AfrsREeffNssSXXVA/XkoeOzGGljW0Q8LUCUB+HEfdYp87BDQsF
 X/IPe//mh7Y/ynrZ9omOO7LbamWte0JWZ8AD0bD2GUU4qvNlKLvrTYSpgF3+fNt7Dllv
 XbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857557; x=1729462357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUcNlrrEXrylRs7XbYRo7ccSUmqH8RPpjzZAaA0vSgw=;
 b=nkLFIDySWFXIsiOO3gTu8GKe5e0ud/VgN5BTCehdif30zrgsoIA7uDC4NmaPGEcKM2
 4AcCjxxPUZC3zbd+YQGofxYHvIk6VcTboxBd+DySyyFjxQdWwF4J7wlC+9Lc7qpfrZ6O
 yfx8NAzTxIiRuo2Z6rxttNvgFRX9IazzI3w05xx1YV1DPKG6GrBt5bBEyv+G2IrwhhXP
 yovheVtfzMdTn5Ja7YzK97ReU34agfa7zJjEA/MmM0ruDS+E5zJjinkiIgO6XnX4vx6B
 g3Zg0xt+Kr3JMxOIPOJgJn2WK9ygI0Z+ESze5c3aTMO1Kx5lyEd/RjnJluurrsXPow5l
 GucA==
X-Gm-Message-State: AOJu0YwkmdsNDMqhtDJThlFJYUwc4SqZr3z7aOriGL32uSNRRw5hWH4E
 xkvJ7tIT+iN8lCs+OuXK5x6NvX70f1cp7RVZYEj4iN14dew9jCGyxSsyi0a9HfipTznV009+dxG
 z
X-Google-Smtp-Source: AGHT+IE278RlKHRJhGA3vmPMbhCEik7+CWYYXTUs6NR2Bo/K++j9BKSK7WYXCIn2fCmxMhEP+YsZ9A==
X-Received: by 2002:a17:90a:ba84:b0:2e2:cc6d:e724 with SMTP id
 98e67ed59e1d1-2e3152c8238mr7580884a91.14.1728857556646; 
 Sun, 13 Oct 2024 15:12:36 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] tcg + linux patch queue
Date: Sun, 13 Oct 2024 15:12:08 -0700
Message-ID: <20241013221235.1585193-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

The following changes since commit 7e3b6d8063f245d27eecce5aabe624b5785f2a77:

  Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2024-10-10 18:05:43 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241013

for you to fetch changes up to e530581ee06573fcf48c7f7a6c3f8ec6e5809243:

  target/arm: Fix alignment fault priority in get_phys_addr_lpae (2024-10-13 11:27:06 -0700)

----------------------------------------------------------------
linux-user/i386: Emulate orig_ax
linux-user/vm86: Fix compilation with Clang
tcg: remove singlestep_enabled from DisasContextBase
accel/tcg: Add TCGCPUOps.tlb_fill_align
target/hppa: Handle alignment faults in hppa_get_physical_address
target/arm: Fix alignment fault priority in get_phys_addr_lpae

----------------------------------------------------------------
Ilya Leoshkevich (5):
      include/exec: Introduce env_cpu_const()
      linux-user/i386: Emulate orig_ax
      target/i386/gdbstub: Factor out gdb_get_reg() and gdb_write_reg()
      target/i386/gdbstub: Expose orig_ax
      tests/tcg: Run test-proc-mappings.py on i386

Paolo Bonzini (1):
      tcg: remove singlestep_enabled from DisasContextBase

Richard Henderson (20):
      accel/tcg: Assert noreturn from write-only page for atomics
      include/exec/memop: Move get_alignment_bits from tcg.h
      include/exec/memop: Rename get_alignment_bits
      include/exec/memop: Introduce memop_atomicity_bits
      accel/tcg: Add TCGCPUOps.tlb_fill_align
      accel/tcg: Use the alignment test in tlb_fill_align
      target/hppa: Add MemOp argument to hppa_get_physical_address
      target/hppa: Perform access rights before protection id check
      target/hppa: Fix priority of T, D, and B page faults
      target/hppa: Handle alignment faults in hppa_get_physical_address
      target/hppa: Implement TCGCPUOps.tlb_fill_align
      target/arm: Pass MemOp to get_phys_addr
      target/arm: Pass MemOp to get_phys_addr_with_space_nogpc
      target/arm: Pass MemOp to get_phys_addr_gpc
      target/arm: Pass MemOp to get_phys_addr_nogpc
      target/arm: Pass MemOp through get_phys_addr_twostage
      target/arm: Pass MemOp to get_phys_addr_lpae
      target/arm: Move device detection earlier in get_phys_addr_lpae
      target/arm: Implement TCGCPUOps.tlb_fill_align
      target/arm: Fix alignment fault priority in get_phys_addr_lpae

Thomas Huth (1):
      linux-user/vm86: Fix compilation with Clang

 include/exec/cpu-common.h                         |  13 +-
 include/exec/memop.h                              |  47 +++++++
 include/exec/translator.h                         |   2 -
 include/hw/core/cpu.h                             |   4 +-
 include/hw/core/tcg-cpu-ops.h                     |  26 ++++
 include/qemu/typedefs.h                           |   1 +
 include/tcg/tcg.h                                 |  23 ----
 linux-user/qemu.h                                 |   4 +
 target/arm/internals.h                            |  12 +-
 target/hppa/cpu.h                                 |   8 +-
 target/i386/cpu.h                                 |   1 +
 accel/tcg/cputlb.c                                | 160 +++++++++++-----------
 accel/tcg/translator.c                            |   1 -
 accel/tcg/user-exec.c                             |   4 +-
 linux-user/elfload.c                              |   6 +-
 linux-user/i386/cpu_loop.c                        |   3 +
 linux-user/vm86.c                                 |  65 ---------
 target/arm/cpu.c                                  |   2 +-
 target/arm/helper.c                               |   9 +-
 target/arm/ptw.c                                  | 141 ++++++++++---------
 target/arm/tcg/cpu-v7m.c                          |   2 +-
 target/arm/tcg/m_helper.c                         |   8 +-
 target/arm/tcg/tlb_helper.c                       |  49 +++----
 target/arm/tcg/translate-a64.c                    |   4 +-
 target/hppa/cpu.c                                 |   2 +-
 target/hppa/int_helper.c                          |   2 +-
 target/hppa/mem_helper.c                          |  55 +++++---
 target/hppa/op_helper.c                           |   2 +-
 target/i386/cpu.c                                 |   1 +
 target/i386/gdbstub.c                             | 102 +++++++++++---
 target/mips/tcg/translate.c                       |   5 +-
 target/xtensa/translate.c                         |   2 +-
 tcg/tcg-op-ldst.c                                 |   6 +-
 tcg/tcg.c                                         |   2 +-
 configs/targets/i386-linux-user.mak               |   2 +-
 configs/targets/x86_64-linux-user.mak             |   2 +-
 gdb-xml/i386-32bit-linux.xml                      |  11 ++
 gdb-xml/i386-64bit-linux.xml                      |  11 ++
 tcg/arm/tcg-target.c.inc                          |   4 +-
 tcg/sparc64/tcg-target.c.inc                      |   2 +-
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py |  17 +--
 41 files changed, 464 insertions(+), 359 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-linux.xml
 create mode 100644 gdb-xml/i386-64bit-linux.xml

