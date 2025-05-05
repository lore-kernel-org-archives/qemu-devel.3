Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F17CC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1pJ-0001Y8-Hy; Mon, 05 May 2025 15:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1pI-0001Xj-7Y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:50:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1pF-0004ja-7u
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:50:07 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-227a8cdd241so60111105ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746474603; x=1747079403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NX1WyDt5llvZw+TjBxl1DUL5O1DuefuFbcJV1TvUrGA=;
 b=OZxJUD2nwUB2+JWNWXeZ1Blbt3Mgdt4oC80cgKXloPsiuF7lDM5EJJaH/vBng0mb05
 fhFJ6YU7YClFgtZ8rug5CNgtmmPULKnUSKy/IDKVoEG5O1C1RogkpFz8m8cQdybz/8+O
 FzX8D3JwoTJDe1RLR8ppL+cfA3geHBI3yZY5zXJQ/IJi9JS7y0PgjOvBavMXCTO04p5F
 3M0x9Hbw5SXzVf5sywb+OUOr0hbzXG6noXuO2n/65wZKrTKAtoN6JFTPWK8fgkdilZbm
 DSRLKj76ZbgR7s3ddd5uSOYCtEQzEsId2T3Sil3WAkUjulhYZdu91A6ocJyGJmfwrSlP
 t93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746474603; x=1747079403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NX1WyDt5llvZw+TjBxl1DUL5O1DuefuFbcJV1TvUrGA=;
 b=B2SzPn9+dP5xWQXK/I+3ylut0hiLQEdKGNN5DHF+ycdE7jkh0L3wCJVO4SXEN7xDSV
 TUKdgqEvvxIHSf6skCk9z/F9Bf8uJmAKN4PgjSxrcA6lUD744FrEcNWpM2ciRbi+1WPS
 sdqOiUmapJY8ccsWihvBLuNCJXBuyPwF6/7sy+lgHvSvEIQZ3NWe0vS8sh0eVPQHWau2
 CHbxBAQTF4VpbHzA1LKV8DVXxnIQ8Usg81xDt7QSW8d3X6RE8Krm6YoWRtwtib7IHCk4
 qDkYl2s+2ERGeu5BzozU8ksxeInEJT9xgplEeM1w/cZLGQoBihgmuakhHVnNXhVS1fgm
 SlDw==
X-Gm-Message-State: AOJu0YxXNO9NkSyeIqazrgebwPzVa7xFplBNdUlCpUah82En4/tpB9jS
 N48wC8p8YBCq1roKPMWIf3yZYbO+oZd1d+aqavDufQ1zArrQQK9lKTeu6etVyOosUZUpNzXcqvM
 Y
X-Gm-Gg: ASbGncuzPKMmIuuqPh4lfHpg9fKd0A8PHpOlgxRj4bYMI8N7zmegq7lfUrPDn25JlCz
 2eDH5U8XeoZdSmN3f1KSFmW1iMa6rwyE4VOPnqxItEq93orpiL7qzPDN43M1uperb1ayDBk/oQK
 JXGpsHsVJMWh9pxS/WAJP0PG3fuhWNNwGk4dMG11IsZSXWW/qF9L+8ThXJ9mL9iHCujzsAC/P2g
 Kw/uKE3ilUmYuLc/+PhWLEf/31FWg+7Yj9YJA+nSAvqsBc8IT39OrWTCXIFx1KXhUGHLvJDk4tL
 GcaSMeDi36DiTj9hJUfNSC5Ooviu57vfoUryHkxg4DPRaYdW/qluqxUSLI6hQ3/7nhs88DXuEdM
 =
X-Google-Smtp-Source: AGHT+IFJo2PFEKyID8faN64l3vbdWlbzT+H6EagNtPFdv0J/1rAIJ9j98LlD8OkbyEl9WwC4E+uDcg==
X-Received: by 2002:a17:902:ecc1:b0:224:c76:5e57 with SMTP id
 d9443c01a7336-22e3637e732mr3892525ad.39.1746474602854; 
 Mon, 05 May 2025 12:50:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df2a6csm7275900b3a.81.2025.05.05.12.50.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 12:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/59] tcg patch queue
Date: Mon,  5 May 2025 12:50:00 -0700
Message-ID: <20250505195001.3479169-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

v2: Fix a bsd-user build error.

r~


The following changes since commit 5134cf9b5d3aee4475fe7e1c1c11b093731073cf:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2025-04-30 13:34:44 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250501-v2

for you to fetch changes up to 768cb76d14f1a50c00d60fbb1d393996c76645d8:

  accel/tcg: Build user-exec.c once (2025-05-05 09:24:10 -0700)

----------------------------------------------------------------
include: Remove 'exec/exec-all.h'
accel/tcg: Build tb-maint.c twice
accel/tcg: Build cpu-exec.c twice
accel/tcg: Build translate-all.c twice
accel/tcg: Build tcg-all.c twice
accel/tcg: Build cputlb.c once
accel/tcg: Build user-exec.c once

----------------------------------------------------------------
Philippe Mathieu-Daudé (10):
      include/exec: Include missing headers in exec-all.h
      target/riscv: Include missing 'accel/tcg/getpc.h' in csr.c
      accel/tcg: Include 'accel/tcg/getpc.h' in 'exec/helper-proto'
      physmem: Move TCG IOTLB methods around
      physmem: Restrict TCG IOTLB code to TCG accel
      accel/tcg: Extract probe API out of 'exec/exec-all.h'
      include: Remove 'exec/exec-all.h'
      system/vl: Filter machine list available for a particular target binary
      qemu/target_info: Add %target_cpu_type field to TargetInfo
      qemu: Introduce target_long_bits()

Richard Henderson (49):
      accel/tcg: Add CPUState argument to page_unprotect
      accel/tcg: Add CPUState argument to tb_invalidate_phys_page_unwind
      accel/tcg: Add CPUState arg to tb_invalidate_phys_page_range__locked
      accel/tcg: Merge tb_invalidate_phys_range{__locked}
      accel/tcg: Add CPUState arg to tb_invalidate_phys_range
      accel/tcg: Add CPUState arg to tb_invalidate_phys_range_fast
      accel/tcg: Convert TARGET_HAS_PRECISE_SMC to TCGCPUOps.precise_smc
      accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
      accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
      accel/tcg: Merge internal-target.h into internal-common.h
      accel/tcg: Reduce scope of tb_phys_invalidate, tb_set_jmp_target
      accel/tcg: Use vaddr for walk_memory_regions callback
      accel/tcg: Use vaddr in user/page-protection.h
      include/exec: Move tb_invalidate_phys_range to translation-block.h
      accel/tcg: Compile tb-maint.c twice
      accel/tcg: Remove #error for non-tcg in getpc.h
      accel/tcg: Generalize fake_user_interrupt test
      accel/tcg: Unconditionally use CPU_DUMP_CCOP in log_cpu_exec
      accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
      target/i386: Split out x86_cpu_exec_reset
      accel/tcg: Hoist cpu_get_tb_cpu_state decl to accl/tcg/cpu-ops.h
      target/arm: Move cpu_get_tb_cpu_state to hflags.c
      target/arm: Unexport assert_hflags_rebuild_correctly
      target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
      accel/tcg: Return TCGTBCPUState from cpu_get_tb_cpu_state
      accel/tcg: Move cpu_get_tb_cpu_state to TCGCPUOps
      accel/tcg: Pass TCGTBCPUState to tb_lookup
      accel/tcg: Pass TCGTBCPUState to tb_htable_lookup
      accel/tcg: Use TCGTBCPUState in struct tb_desc
      accel/tcg: Pass TCGTBCPUState to tb_gen_code
      accel/tcg: Split out accel/tcg/helper-retaddr.h
      accel/tcg: Compile cpu-exec.c twice
      tcg: Define INSN_START_WORDS as constant 3
      accel/tcg: Don't use TARGET_LONG_BITS in decode_sleb128
      accel/tcg: Use target_long_bits() in translate-all.c
      accel/tcg: Build translate-all.c twice
      accel/tcg: Build tcg-all.c twice
      accel/tcg: Use vaddr in cpu_loop.h
      accel/tcg: Move user-only tlb_vaddr_to_host out of line
      accel/tcg: Move tlb_vaddr_to_host declaration to probe.h
      accel/tcg: Use target_long_bits() in cputlb.c
      accel/tcg: Use vaddr for plugin_{load,store}_cb
      accel/tcg: Build cputlb.c once
      include/user: Convert GUEST_ADDR_MAX to a variable
      include/user: Use vaddr in guest-host.h
      accel/tcg: Move TARGET_TAGGED_ADDRESSES to TCGCPUOps.untagged_addr
      accel/tcg: Remove TARGET_PAGE_DATA_SIZE
      accel/tcg: Avoid abi_ptr in user-exec.c
      accel/tcg: Build user-exec.c once

 accel/tcg/internal-common.h                    |  37 +++++-
 accel/tcg/internal-target.h                    |  46 -------
 accel/tcg/tb-hash.h                            |   3 +-
 accel/tcg/tb-internal.h                        |   8 +-
 accel/tcg/tlb-bounds.h                         |  21 +---
 bsd-user/qemu.h                                |   1 -
 include/accel/tcg/cpu-ldst.h                   |  58 ---------
 include/accel/tcg/cpu-ops.h                    |  23 ++++
 include/accel/tcg/getpc.h                      |   4 -
 include/accel/tcg/helper-retaddr.h             |  43 +++++++
 include/accel/tcg/iommu.h                      |  41 +++++++
 include/{exec/exec-all.h => accel/tcg/probe.h} |  67 +++-------
 include/accel/tcg/tb-cpu-state.h               |  18 +++
 include/exec/helper-proto-common.h             |   2 +
 include/exec/poison.h                          |   1 -
 include/exec/translation-block.h               |   4 +
 include/qemu/target-info-impl.h                |   6 +
 include/qemu/target-info.h                     |  15 +++
 include/system/ram_addr.h                      |   1 -
 include/tcg/insn-start-words.h                 |  11 +-
 include/tcg/tcg-op.h                           |  17 ++-
 include/tcg/tcg-opc.h                          |   3 +-
 include/tcg/tcg.h                              |  12 +-
 include/user/cpu_loop.h                        |  12 +-
 include/user/guest-host.h                      |  49 +++-----
 include/user/page-protection.h                 |  30 +++--
 linux-user/user-internals.h                    |   1 -
 target/alpha/cpu.h                             |  11 --
 target/arm/cpu-param.h                         |   7 +-
 target/arm/cpu.h                               |  39 +-----
 target/arm/internals.h                         |   4 +-
 target/arm/tcg/translate.h                     |   1 -
 target/avr/cpu.h                               |  18 ---
 target/hexagon/cpu.h                           |  15 ---
 target/hexagon/mmvec/macros.h                  |   1 +
 target/hppa/cpu.h                              |   3 -
 target/i386/cpu.h                              |  18 ---
 target/i386/tcg/helper-tcg.h                   |   1 -
 target/loongarch/cpu.h                         |  12 --
 target/m68k/cpu.h                              |  16 ---
 target/microblaze/cpu.h                        |   8 --
 target/mips/cpu.h                              |   9 --
 target/openrisc/cpu.h                          |  10 --
 target/ppc/cpu.h                               |  13 --
 target/ppc/internal.h                          |   3 +
 target/riscv/cpu.h                             |   3 -
 target/rx/cpu.h                                |   9 --
 target/s390x/cpu.h                             |  11 --
 target/sh4/cpu.h                               |  15 ---
 target/sparc/cpu.h                             |   3 -
 target/tricore/cpu.h                           |  12 --
 target/xtensa/cpu.h                            |  68 ----------
 accel/hvf/hvf-accel-ops.c                      |   1 -
 accel/tcg/cpu-exec.c                           | 164 ++++++++++---------------
 accel/tcg/cputlb.c                             |  34 ++---
 accel/tcg/tb-maint.c                           | 100 ++++++---------
 accel/tcg/tcg-all.c                            |   6 +-
 accel/tcg/translate-all.c                      |  95 +++++---------
 accel/tcg/user-exec.c                          | 145 ++++++++++++----------
 bsd-user/main.c                                |   9 +-
 bsd-user/signal.c                              |   4 +-
 hw/ppc/spapr_nested.c                          |   1 -
 hw/riscv/riscv-iommu-sys.c                     |   1 -
 hw/sh4/sh7750.c                                |   1 -
 linux-user/elfload.c                           |  21 ++--
 linux-user/main.c                              |   9 +-
 linux-user/signal.c                            |   4 +-
 linux-user/syscall.c                           |   8 +-
 semihosting/uaccess.c                          |   2 +-
 system/physmem.c                               |  58 +++++----
 system/vl.c                                    |   3 +-
 target-info-stub.c                             |   9 +-
 target-info.c                                  |  15 +++
 target/alpha/cpu.c                             |  18 ++-
 target/alpha/fpu_helper.c                      |   1 -
 target/alpha/int_helper.c                      |   1 -
 target/alpha/mem_helper.c                      |   1 -
 target/alpha/translate.c                       |   1 -
 target/alpha/vax_helper.c                      |   1 -
 target/arm/cpu.c                               |  30 ++++-
 target/arm/debug_helper.c                      |   1 -
 target/arm/helper.c                            | 113 +----------------
 target/arm/ptw.c                               |   2 +-
 target/arm/tcg-stubs.c                         |   4 -
 target/arm/tcg/cpu-v7m.c                       |   2 +
 target/arm/tcg/helper-a64.c                    |   3 +-
 target/arm/tcg/hflags.c                        | 117 +++++++++++++++++-
 target/arm/tcg/m_helper.c                      |   1 -
 target/arm/tcg/mte_helper.c                    |   6 +-
 target/arm/tcg/mve_helper.c                    |   1 -
 target/arm/tcg/op_helper.c                     |   2 +-
 target/arm/tcg/pauth_helper.c                  |   1 -
 target/arm/tcg/sme_helper.c                    |   2 +-
 target/arm/tcg/sve_helper.c                    |   3 +-
 target/arm/tcg/tlb_helper.c                    |   1 -
 target/arm/tcg/translate-a64.c                 |   1 -
 target/avr/cpu.c                               |  21 +++-
 target/avr/helper.c                            |   1 -
 target/avr/translate.c                         |   1 -
 target/hexagon/cpu.c                           |  21 +++-
 target/hexagon/op_helper.c                     |   2 +-
 target/hppa/cpu.c                              |  16 +--
 target/hppa/fpu_helper.c                       |   1 -
 target/hppa/helper.c                           |   1 -
 target/hppa/mem_helper.c                       |   2 +-
 target/hppa/op_helper.c                        |   2 +-
 target/hppa/sys_helper.c                       |   1 -
 target/hppa/translate.c                        |   1 -
 target/i386/helper.c                           |   2 +-
 target/i386/tcg/access.c                       |   2 +-
 target/i386/tcg/excp_helper.c                  |   1 -
 target/i386/tcg/int_helper.c                   |   1 -
 target/i386/tcg/mem_helper.c                   |   1 -
 target/i386/tcg/mpx_helper.c                   |   1 -
 target/i386/tcg/seg_helper.c                   |   2 +-
 target/i386/tcg/system/bpt_helper.c            |   1 -
 target/i386/tcg/system/excp_helper.c           |   1 +
 target/i386/tcg/tcg-cpu.c                      |  34 ++++-
 target/i386/tcg/translate.c                    |   1 -
 target/i386/tcg/user/excp_helper.c             |   1 -
 target/i386/tcg/user/seg_helper.c              |   1 -
 target/loongarch/cpu.c                         |  20 ++-
 target/loongarch/tcg/fpu_helper.c              |   1 -
 target/loongarch/tcg/iocsr_helper.c            |   1 -
 target/loongarch/tcg/op_helper.c               |   1 -
 target/loongarch/tcg/tlb_helper.c              |   1 -
 target/loongarch/tcg/vec_helper.c              |   1 -
 target/m68k/cpu.c                              |  24 +++-
 target/m68k/fpu_helper.c                       |   1 -
 target/m68k/helper.c                           |   1 -
 target/m68k/op_helper.c                        |   1 -
 target/m68k/translate.c                        |   1 -
 target/microblaze/cpu.c                        |  17 ++-
 target/microblaze/op_helper.c                  |   1 -
 target/microblaze/translate.c                  |   1 -
 target/mips/cpu.c                              |  14 ++-
 target/mips/system/physaddr.c                  |   1 -
 target/mips/tcg/exception.c                    |   1 -
 target/mips/tcg/fpu_helper.c                   |   1 -
 target/mips/tcg/ldst_helper.c                  |   1 -
 target/mips/tcg/msa_helper.c                   |   2 +-
 target/mips/tcg/op_helper.c                    |   1 -
 target/mips/tcg/system/special_helper.c        |   1 -
 target/mips/tcg/system/tlb_helper.c            |   1 -
 target/openrisc/cpu.c                          |  18 ++-
 target/openrisc/exception.c                    |   1 -
 target/openrisc/exception_helper.c             |   1 -
 target/openrisc/fpu_helper.c                   |   1 -
 target/openrisc/interrupt.c                    |   1 -
 target/openrisc/interrupt_helper.c             |   1 -
 target/openrisc/sys_helper.c                   |   3 +-
 target/openrisc/translate.c                    |   1 -
 target/ppc/cpu_init.c                          |   3 +-
 target/ppc/excp_helper.c                       |   1 -
 target/ppc/fpu_helper.c                        |   1 -
 target/ppc/helper_regs.c                       |  19 ++-
 target/ppc/machine.c                           |   1 -
 target/ppc/mem_helper.c                        |   3 +-
 target/ppc/misc_helper.c                       |   1 -
 target/ppc/mmu-hash32.c                        |   1 -
 target/ppc/mmu-hash64.c                        |   1 -
 target/ppc/mmu-radix64.c                       |   1 -
 target/ppc/mmu_common.c                        |   1 -
 target/ppc/mmu_helper.c                        |   1 -
 target/ppc/power8-pmu.c                        |   1 -
 target/ppc/tcg-excp_helper.c                   |   1 -
 target/ppc/timebase_helper.c                   |   1 -
 target/ppc/translate.c                         |   1 -
 target/ppc/user_only_helper.c                  |   1 -
 target/riscv/cpu.c                             |   1 -
 target/riscv/cpu_helper.c                      |  98 ---------------
 target/riscv/crypto_helper.c                   |   1 -
 target/riscv/csr.c                             |   2 +-
 target/riscv/debug.c                           |   1 -
 target/riscv/fpu_helper.c                      |   1 -
 target/riscv/m128_helper.c                     |   1 -
 target/riscv/op_helper.c                       |   2 +-
 target/riscv/tcg/tcg-cpu.c                     | 101 ++++++++++++++-
 target/riscv/translate.c                       |   1 -
 target/riscv/vcrypto_helper.c                  |   1 -
 target/riscv/vector_helper.c                   |   2 +-
 target/riscv/zce_helper.c                      |   1 -
 target/rx/cpu.c                                |  16 ++-
 target/rx/op_helper.c                          |   1 -
 target/rx/translate.c                          |   1 -
 target/s390x/cpu.c                             |  18 ++-
 target/s390x/interrupt.c                       |   1 -
 target/s390x/mmu_helper.c                      |   1 -
 target/s390x/sigp.c                            |   1 -
 target/s390x/tcg/cc_helper.c                   |   1 -
 target/s390x/tcg/crypto_helper.c               |   1 -
 target/s390x/tcg/excp_helper.c                 |   1 -
 target/s390x/tcg/fpu_helper.c                  |   1 -
 target/s390x/tcg/int_helper.c                  |   1 -
 target/s390x/tcg/mem_helper.c                  |   3 +-
 target/s390x/tcg/misc_helper.c                 |   1 -
 target/s390x/tcg/translate.c                   |   1 -
 target/s390x/tcg/vec_fpu_helper.c              |   1 -
 target/s390x/tcg/vec_helper.c                  |   1 -
 target/sh4/cpu.c                               |  29 ++++-
 target/sh4/helper.c                            |   1 -
 target/sh4/op_helper.c                         |   1 -
 target/sh4/translate.c                         |   1 -
 target/sparc/cpu.c                             |  20 +--
 target/sparc/fop_helper.c                      |   1 -
 target/sparc/helper.c                          |   1 -
 target/sparc/ldst_helper.c                     |   1 -
 target/sparc/machine.c                         |   1 -
 target/sparc/translate.c                       |   1 -
 target/sparc/win_helper.c                      |   1 -
 target/tricore/cpu.c                           |  16 ++-
 target/tricore/op_helper.c                     |   1 -
 target/tricore/translate.c                     |   1 -
 target/xtensa/cpu.c                            |  79 +++++++++++-
 target/xtensa/dbg_helper.c                     |   1 -
 target/xtensa/exc_helper.c                     |   1 -
 target/xtensa/fpu_helper.c                     |   1 -
 target/xtensa/mmu_helper.c                     |   2 +-
 target/xtensa/op_helper.c                      |   1 -
 target/xtensa/translate.c                      |   1 -
 target/xtensa/win_helper.c                     |   1 -
 tcg/perf.c                                     |   5 +-
 tcg/tcg.c                                      |  12 +-
 MAINTAINERS                                    |   3 +-
 accel/tcg/ldst_common.c.inc                    |   4 +-
 accel/tcg/meson.build                          |  20 +--
 226 files changed, 1232 insertions(+), 1366 deletions(-)
 delete mode 100644 accel/tcg/internal-target.h
 create mode 100644 include/accel/tcg/helper-retaddr.h
 create mode 100644 include/accel/tcg/iommu.h
 rename include/{exec/exec-all.h => accel/tcg/probe.h} (64%)
 create mode 100644 include/accel/tcg/tb-cpu-state.h

