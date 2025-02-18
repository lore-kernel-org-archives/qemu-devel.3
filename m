Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83837C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkR5T-0006Xb-15; Tue, 18 Feb 2025 12:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkR5Q-0006WS-Ib
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:08:44 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tkR5O-00067x-Bo
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:08:44 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so8425353a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739898521; x=1740503321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H5SgQ3yiTHqSl31A9mmoaDJJwkfe0ETYGKP3KExKfVo=;
 b=Xp8ke0Q353OC96U9tgXktrMH4SnuP5rO3WSOSKqBgc9vBcyYDMGMlA+8Pso9Dvua4N
 ua8j7ksFs50U7/8nVdHjENk0n/Z19FXd1tkqOAnknfn6HGeUpQkZ1bpUpLnU9BOz2iH0
 QgjZuGG1uPNRyrmlOtgKYuv8puvdIthSKuqOIEdKuKPKmTxofq1h8gSSbJOymo3ZuR1m
 LEKimMPcgJ6bjOZjme777pn3y7NLccAeB4li0LWQ4ntBym+w/OxBgwnaYeHYR333l+0K
 RY34DD7LBnjkKfRY+Bja4W2Ug/05w3qkB77tlHuoRd5oQ+Vik/ZhjmBsKVwcvr7lIb30
 QH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898521; x=1740503321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5SgQ3yiTHqSl31A9mmoaDJJwkfe0ETYGKP3KExKfVo=;
 b=mAi+HMzueM7QV6UnI0F5ZkGvLReNy9ZPJXe0fVxQDOQXAQ1atNE/ckvlBJvTUP2JoD
 nNyU6o2nJloFZWoS/7gSUDZvXJKyhE1tZwKj5RG21Oifz/tKIQACHDDu8o0HcxQpUIXe
 HllVlc4aozVI5e1aqfjtYm9IZy9Wi3hXC85NoM2XLuccAFFtLCE2qLbg8TRkrdQsleyW
 Nuz7emqjAY2tGk2prpJTggnlM8KFlRNMtabCzFVia6FrxQ/G+l1yCh33DySM/ZQY4x82
 rypC72XM2bzNDXFQco9m+yNQqV4SrgbEeT0ORn5CdCF3vYGnDWSdMTKRRES654P0t1n0
 Xvdw==
X-Gm-Message-State: AOJu0YzVgIyIV5YZjOlj8iE35nXnPHx7PZ/u2U6aWANIvglh5VeLzXjy
 yFPSQxU/wDjROMOYlDP7yP/gKAUVFVKGp1X48LBPEeFBOr7OgDvk4jMMD9GK7rHuRbLdVf7umY3
 9
X-Gm-Gg: ASbGnctlIoRWm8IsTAeHttfrJoVjyTlUiJ23lUps9/2lgnP4N0UD32Myo58xdI9NBxa
 jlHKOeolo08D9YaGMdsBY7yuGftZB4S9q1dMbIFMMtV1Z1l8MdAiFeN8DY0fesYk+JXhpu9zZkG
 akx+mZsOKIdrwddWB6XFNlEtVsePeiI6J6tfCI1ASgEkkTt3tUHfxWgnf/Cmlo97DgZOZD7+Gb5
 o1ERFO86wCN2f2wHWCHhJDGmDWzfRtN2ZDrKa9B5vwtgNizkhVEMjXrzpobLUxoqXNHMfHVIqQm
 yA1E+M76dm9f2JAsDLZzxxwjgLkP15d6X1m8+du1z09BV8E=
X-Google-Smtp-Source: AGHT+IEzbN/yuUp6MGpzUqdA5u0H9GycD9pyEjess/ODEnYaR3mX0yyrwfJcDW6BO2o50RcpU4wRMQ==
X-Received: by 2002:a17:90b:1e46:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-2fc40d14e35mr21239144a91.5.1739898520810; 
 Tue, 18 Feb 2025 09:08:40 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5585faasm91917875ad.225.2025.02.18.09.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:08:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/28] tcg patch queue
Date: Tue, 18 Feb 2025 09:08:38 -0800
Message-ID: <20250218170839.81501-1-richard.henderson@linaro.org>
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

v3: One more try to fix macos issues.


r~



The following changes since commit e0209297cddd5e10a07e15fac5cca7aa1a8e0e59:

  Merge tag 'pull-ufs-20250217' of https://gitlab.com/jeuk20.kim/qemu into staging (2025-02-18 10:58:48 +0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250215-3

for you to fetch changes up to e726f65867087d86436de05e9f372a86ec1381a6:

  tcg: Remove TCG_TARGET_HAS_{br,set}cond2 from riscv and loongarch64 (2025-02-18 08:29:03 -0800)

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

Richard Henderson (23):
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
      target/mips: Use VADDR_PRIx for logging pc_next
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
 target/mips/tcg/octeon_translate.c                 |   4 +-
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
 62 files changed, 550 insertions(+), 1162 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h

