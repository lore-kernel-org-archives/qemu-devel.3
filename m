Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BE7C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6to-00082t-Le; Mon, 17 Feb 2025 14:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6tQ-0007iB-Vy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:35:02 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6tO-0000Pe-MT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:35:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220d39a5627so67779735ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820896; x=1740425696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KAxsTWm6v4s+2jcR+PITVinek53Ik16QQwGPW+9US8=;
 b=FNb3Y5J8R7NprigDgciDJqa7nJS53Rz6LDlmzLYK7BXLpiSFU4FRwZgnf9/livS0J2
 C/lfROnYsQtQyAlrBuOWL8yGEKVbbsIGQ0nPNXCMu8CZBvLYHSMd7l3STJ6r44pe/LgL
 d4RFgV/H4MC5kVUHc6/4dsEoo44YWoiJLePTfCzql6/ip5Dhrd3pnDG3i/Q2ZirloUBQ
 ULo9CznTpK0bicxK6rO/xDECXCJveJXrUVbN4vT53of0VqrjXGh3dez9dP0dQDHHK3lO
 ctnVpmOaI5+9nMW/65f4TBlZwNBWeQpAWspRO+oOGFvjmF89emodx53rh3W+WEytcKfo
 78Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820896; x=1740425696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4KAxsTWm6v4s+2jcR+PITVinek53Ik16QQwGPW+9US8=;
 b=GeFFVhZ/r8pMNoNWWmXAYQWtwV9PY/bYRZseAVcJYGL5MEwo3DHJRZILGPg9lbwLAQ
 ZpGXzSly7ceImC4Z/l0p4IX8n3IFv1lwo9swo2LvkTE56q7genZhYp0qVJaT3hAd9qlN
 b1JdYtaTb+fzDLr8sNqsF92NN08nOXbp2h1n4HV2NbUFc5gz6QuIS5edxWo0pyhpQBr6
 KrEF4+mbv6mD82VM4Xep2QXFzUjSad3lyksIDbzx+/2e+ZZC0JjxQMmzsT6DkHgNgSXd
 qsLkvL484mox417H4HPPqE0I8XJ7Hvi9tsIMlEd4AxdO10a1D4+F9WpeHtSR+WPJDQYr
 tzYg==
X-Gm-Message-State: AOJu0Yx+PlCk4zrql4QGYwxS2miMjYd0adqZcW+qVcmGmYC3PFSZBs/V
 vuJ/i0/jaaDs4j1jd0N4eJo3pnP7Y9qNAyyCqSS3IbCXcaLoT87DQ2OXF/+GBUhUuHdkzc10m6F
 V
X-Gm-Gg: ASbGncvNuazo7CkYRzWKTnoe/qTkeUuicT/4daFxu9YyxR+E2vBEoBQDhUUzXVOVqg5
 a+aW9eM/G5wyF+QxdvEVUXB63SXtcFsWHlUVcqb8xX632PYT2sa34JMiG1Mew9TFsQTVkNOB8Qj
 OVyND4ANtcKVwUZ70pcX+WZzEwZiBGaDDYAZJXvR8VTKiSEA8N+rnCJqRB5/dHH3ir3JrINmkwo
 YaJLu/zgwQPMWnPIdZxSrN9w+1Ry/xBfnBQ2APX1ahnMIzPiqsTUJUD8vmVrsXpaiwclGZU8hNa
 Pl7waW16BulwZeiTW3Ifnlke1ZY5S8o77whrElvKpJlfbKU=
X-Google-Smtp-Source: AGHT+IF3d0yBeZhXpy3QxhUYY2rW8hsr3452fHOV1CnTO2ea09ywQMmrsEdCiwC1qguXOK0gl7QpAg==
X-Received: by 2002:a05:6a21:6e47:b0:1e0:d1c3:97d1 with SMTP id
 adf61e73a8af0-1ee8cc03463mr22437807637.29.1739820894841; 
 Mon, 17 Feb 2025 11:34:54 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326c87a86esm4128653b3a.132.2025.02.17.11.34.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:34:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2.5 00/27] tcg patch queue
Date: Mon, 17 Feb 2025 11:34:53 -0800
Message-ID: <20250217193453.2874125-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

v2: Fix target/loongarch printf formats for vaddr
    Include two more reviewed patches.

This time with actual pull urls.  :-/

r~


The following changes since commit db7aa99ef894e88fc5eedf02ca2579b8c344b2ec:

  Merge tag 'hw-misc-20250216' of https://github.com/philmd/qemu into staging (2025-02-16 20:48:06 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250215-2

for you to fetch changes up to a39bdd0f4ba96fcbb6b5bcb6e89591d2b24f52eb:

  tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64 (2025-02-17 09:52:07 -0800)

----------------------------------------------------------------
tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
tcg: Cleanups after disallowing 64-on-32
tcg: Introduce constraint for zero register
tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64
tcg/i386: Use tcg_{high,unsigned}_cond in tcg_out_brcond2
linux-user: Move TARGET_SA_RESTORER out of generic/signal.h
linux-user: Fix alignment when unmapping excess reservation
target/sparc: Fix register selection for all F*TOx and FxTO* instructions
target/sparc: Fix gdbstub incorrectly handling registers f32-f62
target/sparc: fake UltraSPARC T1 PCR and PIC registers

----------------------------------------------------------------
Andreas Schwab (1):
      linux-user: Move TARGET_SA_RESTORER out of generic/signal.h

Artyom Tarasenko (1):
      target/sparc: fake UltraSPARC T1 PCR and PIC registers

Fabiano Rosas (1):
      elfload: Fix alignment when unmapping excess reservation

Mikael Szreder (2):
      target/sparc: Fix register selection for all F*TOx and FxTO* instructions
      target/sparc: Fix gdbstub incorrectly handling registers f32-f62

Richard Henderson (22):
      tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
      tcg: Remove TCG_OVERSIZED_GUEST
      tcg: Drop support for two address registers in gen_ldst
      tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
      tcg/arm: Drop addrhi from prepare_host_addr
      tcg/i386: Drop addrhi from prepare_host_addr
      tcg/mips: Drop addrhi from prepare_host_addr
      tcg/ppc: Drop addrhi from prepare_host_addr
      tcg: Replace addr{lo,hi}_reg with addr_reg in TCGLabelQemuLdst
      plugins: Fix qemu_plugin_read_memory_vaddr parameters
      accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
      target/loongarch: Use VADDR_PRIx for logging pc_next
      include/exec: Change vaddr to uintptr_t
      include/exec: Use uintptr_t in CPUTLBEntry
      tcg: Introduce the 'z' constraint for a hardware zero register
      tcg/aarch64: Use 'z' constraint
      tcg/loongarch64: Use 'z' constraint
      tcg/mips: Use 'z' constraint
      tcg/riscv: Use 'z' constraint
      tcg/sparc64: Use 'z' constraint
      tcg/i386: Use tcg_{high,unsigned}_cond in tcg_out_brcond2
      tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64

 include/exec/tlb-common.h                          |  10 +-
 include/exec/vaddr.h                               |  16 +-
 include/qemu/atomic.h                              |  18 +-
 include/tcg/oversized-guest.h                      |  23 ---
 include/tcg/tcg-opc.h                              |  28 +--
 include/tcg/tcg.h                                  |   3 +-
 linux-user/aarch64/target_signal.h                 |   2 +
 linux-user/arm/target_signal.h                     |   2 +
 linux-user/generic/signal.h                        |   1 -
 linux-user/i386/target_signal.h                    |   2 +
 linux-user/m68k/target_signal.h                    |   1 +
 linux-user/microblaze/target_signal.h              |   2 +
 linux-user/ppc/target_signal.h                     |   2 +
 linux-user/s390x/target_signal.h                   |   2 +
 linux-user/sh4/target_signal.h                     |   2 +
 linux-user/x86_64/target_signal.h                  |   2 +
 linux-user/xtensa/target_signal.h                  |   2 +
 tcg/aarch64/tcg-target-con-set.h                   |  12 +-
 tcg/aarch64/tcg-target.h                           |   2 +
 tcg/loongarch64/tcg-target-con-set.h               |  15 +-
 tcg/loongarch64/tcg-target-con-str.h               |   1 -
 tcg/loongarch64/tcg-target-has.h                   |   2 -
 tcg/loongarch64/tcg-target.h                       |   2 +
 tcg/mips/tcg-target-con-set.h                      |  26 +--
 tcg/mips/tcg-target-con-str.h                      |   1 -
 tcg/mips/tcg-target.h                              |   2 +
 tcg/riscv/tcg-target-con-set.h                     |  10 +-
 tcg/riscv/tcg-target-con-str.h                     |   1 -
 tcg/riscv/tcg-target-has.h                         |   2 -
 tcg/riscv/tcg-target.h                             |   2 +
 tcg/sparc64/tcg-target-con-set.h                   |  12 +-
 tcg/sparc64/tcg-target-con-str.h                   |   1 -
 tcg/sparc64/tcg-target.h                           |   3 +-
 tcg/tci/tcg-target.h                               |   1 -
 accel/tcg/cputlb.c                                 |  32 +---
 accel/tcg/tcg-all.c                                |   9 +-
 linux-user/elfload.c                               |   4 +-
 plugins/api.c                                      |   2 +-
 target/arm/ptw.c                                   |  34 ----
 target/loongarch/tcg/translate.c                   |   2 +-
 target/riscv/cpu_helper.c                          |  13 +-
 target/sparc/gdbstub.c                             |  18 +-
 target/sparc/translate.c                           |  19 +++
 tcg/optimize.c                                     |  21 +--
 tcg/tcg-op-ldst.c                                  | 103 +++--------
 tcg/tcg.c                                          |  97 +++++------
 tcg/tci.c                                          | 119 +++----------
 docs/devel/multi-thread-tcg.rst                    |   1 -
 docs/devel/tcg-ops.rst                             |   4 +-
 target/loongarch/tcg/insn_trans/trans_atomic.c.inc |   2 +-
 target/sparc/insns.decode                          |  19 ++-
 tcg/aarch64/tcg-target.c.inc                       |  86 ++++------
 tcg/arm/tcg-target.c.inc                           | 114 ++++---------
 tcg/i386/tcg-target.c.inc                          | 190 +++++----------------
 tcg/loongarch64/tcg-target.c.inc                   |  72 +++-----
 tcg/mips/tcg-target.c.inc                          | 169 ++++++------------
 tcg/ppc/tcg-target.c.inc                           | 164 +++++-------------
 tcg/riscv/tcg-target.c.inc                         |  56 +++---
 tcg/s390x/tcg-target.c.inc                         |  40 ++---
 tcg/sparc64/tcg-target.c.inc                       |  45 ++---
 tcg/tci/tcg-target.c.inc                           |  60 ++-----
 61 files changed, 548 insertions(+), 1160 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h

