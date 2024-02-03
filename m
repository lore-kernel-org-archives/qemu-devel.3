Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA8C48291
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 07:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWA7L-0007GZ-1z; Sat, 03 Feb 2024 02:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7F-0007FU-Sx
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:06 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWA7B-0002Ya-U8
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 02:07:05 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d93ddd76adso21982205ad.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 23:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706944019; x=1707548819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HafVxfFyh60faHFPf2avOrzONmAKnvJ+hd+vcIcfZew=;
 b=S8p+kOK0p8vbenCWLefdHm696nkZdZQKQYxm0nPL5bltI9qY3+9oLGhtWtnenR2W+J
 68OZyvzD4OaTcHU7H9OV6us33y89Vz/Vi673AA8KjGv4ehSd6maNGzzY9b0gTJ9xWuXK
 UtvnDl8wsbHJN8L0YxK3t5sMoRbHHd+kjlIj0cvydO8MfWY9cBFYKKlsklruVhMuE5cS
 TSBo9nCAMqbWhKyYncwuHmVhXaBpKl4BbIVAwjq9uMgGpSyg7xGXutVle4xIDA132tfv
 Z8gArvmoqGwkCeaOmDqInC8AlcUN8GaWVHmzMlSvM0MNVbrIFwqZt6CufHMbrNaDRj9o
 1OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706944019; x=1707548819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HafVxfFyh60faHFPf2avOrzONmAKnvJ+hd+vcIcfZew=;
 b=hefTumnEKmlNWs8R+rRUhZUxowwWJI0Kf58FKPMoA5bp8Fj5+AlX+KFp7EG4+bXV/q
 aes8rpekXgf+Wx7Ibz2t6r9oZUKnFraF/7nnxMtYuriQnF7JR/WyDftHyWf7XKiuJoUU
 34XB/jWIxZClFH1BGbp+rMu+ZjiNV3fkM8K1ZA6Ypk4ny3ZjZ011FJgwzbrAiZz07R30
 W3vD2SYK5s6/OBpOYtb559YRjUF7B7eNOWz28v4fYyWQ9cYfBofer1UdWzW1nUoJvj20
 G043lV9iKIrcvPFmaIKy0qzbNUkOxnFHr2F2YylE+AyVjRoPEdd2oxq80PWAcPMIXCCM
 uBhA==
X-Gm-Message-State: AOJu0YwAjOEcaoSyrU9O7AChad3Gea+2meGUmAM9oAXgAb2O+Dw6kYCF
 bXT/Ja1d4wki4cV5rUz750RL2Fss0tFzqDYjRnD1i2ewK9zxKahRYEbspnv+HxPfZHaXStoAQYm
 10RQ=
X-Google-Smtp-Source: AGHT+IHJYXoys0/8/ynusulGkTbnVTNDbmSFMEEeJEKgMQXsCK9A1tXUZrUnKyLMx4YpXkHqk7Xczg==
X-Received: by 2002:a17:903:268b:b0:1d9:486e:ae47 with SMTP id
 jf11-20020a170903268b00b001d9486eae47mr6674254plb.33.1706944019273; 
 Fri, 02 Feb 2024 23:06:59 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d08b00b001d94665e9d3sm2658034plv.45.2024.02.02.23.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 23:06:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/58] tcg patch queue
Date: Sat,  3 Feb 2024 17:06:51 +1000
Message-Id: <20240203070654.982407-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

v2: Rebase and resolve target/loongarch conflicts.
    Include linux-user/aarch64 vdso fix.

r~

The following changes since commit 29b008927ef6e3fbb70e6607b25d3fcae26a5190:

  Merge tag 'pull-nic-config-2-20240202' of git://git.infradead.org/users/dwmw2/qemu into staging (2024-02-02 16:47:36 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240202-2

for you to fetch changes up to 6400be014f80e4c2c246eb8be709ea3a96428233:

  linux-user/aarch64: Add padding before __kernel_rt_sigreturn (2024-02-03 16:46:10 +1000)

----------------------------------------------------------------
tests/tcg: Fix multiarch/gdbstub/prot-none.py
hw/core: Convert cpu_mmu_index to a CPUClass hook
tcg/loongarch64: Set vector registers call clobbered
target/sparc: floating-point cleanup
linux-user/aarch64: Add padding before __kernel_rt_sigreturn

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg: Fix the /proc/self/mem probing in the PROT_NONE gdbstub test

Richard Henderson (57):
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
      linux-user/aarch64: Add padding before __kernel_rt_sigreturn

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
 target/loongarch/cpu_helper.c                      |   6 +-
 target/loongarch/tcg/tlb_helper.c                  |   2 +-
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
 linux-user/aarch64/vdso-be.so                      | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso-le.so                      | Bin 3216 -> 3224 bytes
 linux-user/aarch64/vdso.S                          |   4 +
 tests/tcg/multiarch/gdbstub/prot-none.py           |   2 +-
 97 files changed, 1064 insertions(+), 1191 deletions(-)

