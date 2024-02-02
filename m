Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC526C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmRr-00011z-At; Fri, 02 Feb 2024 00:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRp-00011e-Ey
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:45 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmRm-0001ZM-Ij
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:50:45 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ddc2a78829so1218936b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853041; x=1707457841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1yIfaInumP1HXQUEhpDmU6V/uy2JVZfMeWG/bkOO6Pw=;
 b=fTOvu/Tqin1XmoPvzdeOi/nBa1NzoEf2K8b/paqze8pmXIE0uQCzGtmlffpxJ3pk6Z
 b44cmFlJhASQwJ94yDLhgsO9nuTjr9dl0Zn228OHazRAfKZ5oH+NHmd6nkwKTEgNudE4
 XZMEKI2z/Q7vWlwyh9QHwfHX0HlvKPMPlCKm7ENwbQhqhznBoMGdt5S+Ew5NkSGQ3HPG
 SV+aPsAaADL++kra4fRrRZqQLpFCctEN6lFWf4onMxVZyLfaqsqJdJYX97H9Bq6cZojD
 FpXNH8jzZt7kkfo7ykgPgN2h2xUzjZdKnQ2J0Du8c0yFxhrLI8vp/yZN/JPSHKLNI1+B
 jnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853041; x=1707457841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yIfaInumP1HXQUEhpDmU6V/uy2JVZfMeWG/bkOO6Pw=;
 b=BAAMo4C7K6ObpLxXSApIAZcRU+soO54K/6Gagqk+weEQm0oDd16tNy2+3fG/zTqr3d
 FpBisro4hD+SA4q2bl7BMu2DBYOibz/f81Jy878WsH5Y4LNqaGiXDiXKVp8HH6Qt7oqu
 5cf/DhqrhbIYQ0Cw+RB69cD2ybh+oTNamQax1VlTl0hwLu4y9YgLsC1odT35m3HCaVG7
 9P81sdDBu76o1n0oKjoAic/bLk9A07NaEVhDJoilg+gKUr0BlWXnCkI+thxD50YfE5Hh
 p5O89GehwVKwNxkjjYF39I8IC/27P2akfjBLqwbFljkBFNGfcy22lpucjuzTjgicLQTV
 CsWg==
X-Gm-Message-State: AOJu0YwSX9AMa6T/EBi0xxFNNqYExKky4h0m+i75dtHMFLH8I4kPzEZR
 AFcOD+I+djjNYSmmUoUgE5aUzEdgyvBcIGF05Jv7r1LXXJU6Tju4HvE8HvtygniXSzW/lxLZDrA
 oOdY=
X-Google-Smtp-Source: AGHT+IHFHoAEixWFB2sehGjrDK8zzjiSQigF6/udsYvyQ2fqqfxN2f6rXmaWGIXDaMzAOY4HgPhbxA==
X-Received: by 2002:aa7:8381:0:b0:6db:d4f8:bb1d with SMTP id
 u1-20020aa78381000000b006dbd4f8bb1dmr1400256pfm.2.1706853040738; 
 Thu, 01 Feb 2024 21:50:40 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.50.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:50:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/57] tcg patch queue
Date: Fri,  2 Feb 2024 15:49:38 +1000
Message-Id: <20240202055036.684176-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 14639717bf379480e937716fcaf1e72b47fd4c5f:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-01-31 19:53:45 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240202

for you to fetch changes up to 73e095fc71dfeb8f5f767d9ac71078e562d935b0:

  target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK (2024-02-02 14:40:06 +1000)

----------------------------------------------------------------
tests/tcg: Fix multiarch/gdbstub/prot-none.py
hw/core: Convert cpu_mmu_index to a CPUClass hook
tcg/loongarch64: Set vector registers call clobbered
target/sparc: floating-point cleanup

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg: Fix the /proc/self/mem probing in the PROT_NONE gdbstub test

Richard Henderson (56):
      include/hw/core: Add mmu_index to CPUClass
      target/alpha: Split out alpha_env_mmu_index
      target/alpha: Populate CPUClass.mmu_index
      target/arm: Split out arm_env_mmu_index
      target/arm: Populate CPUClass.mmu_index
      target/avr: Populate CPUClass.mmu_index
      target/cris: Cache mem_index in DisasContext
      target/cris: Populate CPUClass.mmu_index
      target/hppa: Populate CPUClass.mmu_index
      target/i386: Populate CPUClass.mmu_index
      target/loongarch: Populate CPUClass.mmu_index
      target/loongarch: Rename MMU_IDX_*
      target/m68k: Populate CPUClass.mmu_index
      target/microblaze: Populate CPUClass.mmu_index
      target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill
      target/mips: Split out mips_env_mmu_index
      target/mips: Populate CPUClass.mmu_index
      target/nios2: Populate CPUClass.mmu_index
      target/openrisc: Populate CPUClass.mmu_index
      target/ppc: Split out ppc_env_mmu_index
      target/ppc: Populate CPUClass.mmu_index
      target/riscv: Rename riscv_cpu_mmu_index to riscv_env_mmu_index
      target/riscv: Replace cpu_mmu_index with riscv_env_mmu_index
      target/riscv: Populate CPUClass.mmu_index
      target/rx: Populate CPUClass.mmu_index
      target/s390x: Split out s390x_env_mmu_index
      target/s390x: Populate CPUClass.mmu_index
      target/sh4: Populate CPUClass.mmu_index
      target/sparc: Populate CPUClass.mmu_index
      target/tricore: Populate CPUClass.mmu_index
      target/xtensa: Populate CPUClass.mmu_index
      include/exec: Implement cpu_mmu_index generically
      include/exec: Change cpu_mmu_index argument to CPUState
      tcg/loongarch64: Set vector registers call clobbered
      target/sparc: Use tcg_gen_qemu_{ld, st}_i128 for ASI_M_BCOPY
      target/sparc: Use tcg_gen_qemu_{ld, st}_i128 for ASI_M_BFILL
      target/sparc: Remove gen_dest_fpr_F
      target/sparc: Introduce gen_{load,store}_fpr_Q
      target/sparc: Inline FNEG, FABS
      target/sparc: Use i128 for FSQRTq
      target/sparc: Use i128 for FADDq, FSUBq, FMULq, FDIVq
      target/sparc: Use i128 for FqTOs, FqTOi
      target/sparc: Use i128 for FqTOd, FqTOx
      target/sparc: Use i128 for FCMPq, FCMPEq
      target/sparc: Use i128 for FsTOq, FiTOq
      target/sparc: Use i128 for FdTOq, FxTOq
      target/sparc: Use i128 for Fdmulq
      target/sparc: Remove qt0, qt1 temporaries
      target/sparc: Introduce cpu_get_fsr, cpu_put_fsr
      target/sparc: Split ver from env->fsr
      target/sparc: Clear cexc and ftt in do_check_ieee_exceptions
      target/sparc: Merge check_ieee_exceptions with FPop helpers
      target/sparc: Split cexc and ftt from env->fsr
      target/sparc: Remove cpu_fsr
      target/sparc: Split fcc out of env->fsr
      target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK

 include/exec/cpu-all.h                             |   4 +
 include/exec/cpu-common.h                          |  21 +
 include/hw/core/cpu.h                              |   3 +
 target/alpha/cpu.h                                 |   2 +-
 target/arm/cpu.h                                   |  13 -
 target/arm/internals.h                             |   5 +
 target/avr/cpu.h                                   |   7 -
 target/cris/cpu.h                                  |   4 -
 target/hexagon/cpu.h                               |   9 -
 target/hppa/cpu.h                                  |  13 -
 target/i386/cpu.h                                  |   7 -
 target/loongarch/cpu.h                             |  18 +-
 target/m68k/cpu.h                                  |   4 -
 target/microblaze/cpu.h                            |  15 -
 target/mips/cpu.h                                  |   6 +-
 target/nios2/cpu.h                                 |   6 -
 target/openrisc/cpu.h                              |  12 -
 target/ppc/cpu.h                                   |   2 +-
 target/riscv/cpu.h                                 |   4 +-
 target/rx/cpu.h                                    |   5 -
 target/s390x/cpu.h                                 |   2 +-
 target/sh4/cpu.h                                   |  10 -
 target/sparc/cpu.h                                 |  69 +-
 target/sparc/helper.h                              | 116 ++-
 target/tricore/cpu.h                               |   5 -
 target/xtensa/cpu.h                                |   5 -
 accel/tcg/cputlb.c                                 |  22 +-
 linux-user/sparc/cpu_loop.c                        |   2 +-
 linux-user/sparc/signal.c                          |  14 +-
 semihosting/uaccess.c                              |   2 +-
 target/alpha/cpu.c                                 |   6 +
 target/alpha/translate.c                           |   2 +-
 target/arm/cpu.c                                   |   6 +
 target/arm/helper.c                                |   2 +-
 target/arm/tcg/helper-a64.c                        |   4 +-
 target/arm/tcg/mte_helper.c                        |  18 +-
 target/arm/tcg/sve_helper.c                        |   8 +-
 target/arm/tcg/tlb_helper.c                        |   2 +-
 target/avr/cpu.c                                   |   6 +
 target/cris/cpu.c                                  |   6 +
 target/cris/translate.c                            |  14 +-
 target/hppa/cpu.c                                  |  12 +
 target/hppa/mem_helper.c                           |   2 +-
 target/hppa/op_helper.c                            |   8 +-
 target/i386/cpu.c                                  |  10 +
 target/i386/tcg/translate.c                        |   2 +-
 target/loongarch/cpu.c                             |  11 +
 target/loongarch/tcg/tlb_helper.c                  |   8 +-
 target/loongarch/tcg/translate.c                   |   2 +-
 target/m68k/cpu.c                                  |   6 +
 target/m68k/op_helper.c                            |   2 +-
 target/microblaze/cpu.c                            |  18 +-
 target/microblaze/helper.c                         |   3 +-
 target/microblaze/mmu.c                            |   2 +-
 target/microblaze/translate.c                      |   2 +-
 target/mips/cpu.c                                  |   6 +
 target/mips/sysemu/physaddr.c                      |   2 +-
 target/mips/tcg/msa_helper.c                       |  10 +-
 target/mips/tcg/sysemu/cp0_helper.c                |   2 +-
 target/mips/tcg/sysemu/special_helper.c            |   2 +-
 target/mips/tcg/sysemu/tlb_helper.c                |  34 +-
 target/nios2/cpu.c                                 |   7 +
 target/nios2/translate.c                           |   2 +-
 target/openrisc/cpu.c                              |  13 +
 target/openrisc/translate.c                        |   2 +-
 target/ppc/cpu_init.c                              |   8 +-
 target/ppc/mem_helper.c                            |  10 +-
 target/ppc/mmu_common.c                            |   4 +-
 target/riscv/cpu.c                                 |   6 +
 target/riscv/cpu_helper.c                          |   6 +-
 target/riscv/op_helper.c                           |   4 +-
 target/riscv/vector_helper.c                       |   9 +-
 target/rx/cpu.c                                    |   6 +
 target/s390x/cpu.c                                 |   6 +
 target/s390x/tcg/mem_helper.c                      |  34 +-
 target/sh4/cpu.c                                   |  16 +
 target/sparc/cpu.c                                 |  61 +-
 target/sparc/fop_helper.c                          | 510 +++++++------
 target/sparc/gdbstub.c                             |   8 +-
 target/sparc/ldst_helper.c                         |   5 +-
 target/sparc/machine.c                             |  36 +-
 target/sparc/mmu_helper.c                          |   2 +-
 target/sparc/translate.c                           | 799 +++++++--------------
 target/tricore/cpu.c                               |   6 +
 target/tricore/helper.c                            |   2 +-
 target/tricore/translate.c                         |   2 +-
 target/xtensa/cpu.c                                |   6 +
 target/xtensa/mmu_helper.c                         |   2 +-
 accel/tcg/ldst_common.c.inc                        |  42 +-
 target/cris/translate_v10.c.inc                    |   6 +-
 .../tcg/insn_trans/trans_privileged.c.inc          |   2 +-
 tcg/loongarch64/tcg-target.c.inc                   |   2 +-
 tests/tcg/multiarch/gdbstub/prot-none.py           |   2 +-
 93 files changed, 1060 insertions(+), 1191 deletions(-)

