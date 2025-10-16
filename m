Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE695CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mts-00063a-RS; Thu, 16 Oct 2025 08:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtf-00061y-OX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:15:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MtT-00083Q-Ix
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:15:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso692815f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616935; x=1761221735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E+4YTGKP36pt6mvcQO+b8RWSJSAkWm5iLXUm8vLAp9A=;
 b=FXGL2Hr5kT8DESUuHTeSJ1NwX+u174LMbHpr21hRHxYeh/w9qRewymEbaMvKYo34Oi
 IsStEqWwuBDrq/CLG75pN6Bz6MXZwzQyQYryonIF7WiG0SIy02ctFCk0Ds9d+nZiW/yJ
 DsEZN4y3YgXUL/XVHNc+Jek8ZNHKlVQYWIkWokHIalCqgGUbnZ3YrWbPEU3IlGEcpHg5
 891en51AmidanfFTLGd+zNhrK7lw5OCglpLpm1EE5pzHFSaFtLsgOTqx/uN3Uoaccirt
 nuwFibrvp9ApTO6+BtcI4tFyF63e7nTcXbSY5H/9Ai8htFaAbV5Naa9cu+iRdzgbum+2
 ZPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616935; x=1761221735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E+4YTGKP36pt6mvcQO+b8RWSJSAkWm5iLXUm8vLAp9A=;
 b=kxU3TgtCvX1OjwZWKCfftlk3VbtsfP6t/ocLy1LtTifaSSm1VWmHeMzUljJp+SaT9T
 T9wYqzR4E7d2F2aGdCZMuzJQflmkPozrT/jIwZETEUs33o9/Zpc2hoD9bqEoglcHyHou
 mwMMm35UimMnZHPWbNcovUEc8sZ+pBDqxg2GV/AWXqWaEAkbwwMY4P8rrYkcZ6ffHNAG
 s7+lsGrVPBS3LqbjwOohhl/pKjzF7yFhSuEYJi5cadzk17Uk0AwoTePjIoaVvvFAre7p
 kG42NDqWnwqZQZ9FRhsHEApBnzH4DIX1uc4Ww/vRGUY7TEhFz8Z977DUsWj6q3uJOp6E
 DcZQ==
X-Gm-Message-State: AOJu0YwEA1W6O3KEde0FBOJ5NTJvgOiH5IONgRfxJTWiRLiKY5w5bCUL
 clBxjj5qfBVspiviktBj2ds0ODATApSoJ+TpWMU7PJhn/mD813OGIr0Y7gHi9TzaEpa+PaD/hks
 qYM3dzUo=
X-Gm-Gg: ASbGncsCmvFxhJGJ1doO56eoktGnfwavDwgl7kmnm7r27dU4ExdyzanEO7ZIdgyaBUm
 0PJCgGN/xKQcNglb1hTml3V//yC1Jfp0SKVzc7XzTvJUgnCOuB64f+KpJvO6roctbtQxUHl6XkK
 QP70YuxRvjtAHbg9goiaUv06dkTsVathaeG1frfhBU//oFwg8Qx685rTEAmdkhD/NOOva+MU431
 0RyTFWN+U5+MNQd0xFnAqJPAyb4fx5C0/XCh5snd1GIlGl6gxqIWsqBDnlHVlapZSSrv560vuIL
 YdOvGQixsc8mCJfvpgqf48l9ZhYM9fkae0oAOFyjkMVQNTHNKxS6H9rnqHdClbVOmfJEQr+E1fs
 E8etqwk3psZCnvWBdtKJVXwgkfLF7xIPfu7SYDUN+bx62QR2qHGD0Hq5f1bc7EC/KH5VO7NDGK/
 VmdVifSh5RG8LTd2sHqLDgNpPhPeEcMelqk3d88Y8ve6EqGA29gGL//Q==
X-Google-Smtp-Source: AGHT+IFHPuNUSe5COb9GZT0psYtgoNSwYDinFxSobl76Pd0ocqxGxhTYSCOUs5Dw9IRAN7f8Q8SXPQ==
X-Received: by 2002:a05:6000:26c5:b0:3ee:1357:e191 with SMTP id
 ffacd0b85a97d-4266e7d9252mr19308131f8f.30.1760616934558; 
 Thu, 16 Oct 2025 05:15:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe69sm35546984f8f.32.2025.10.16.05.15.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:15:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/75] Misc single binary patches for 2025-10-16
Date: Thu, 16 Oct 2025 14:14:16 +0200
Message-ID: <20251016121532.14042-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8:

  Merge tag 'pull-loongarch-20251015' of https://github.com/bibo-mao/qemu into staging (2025-10-15 14:49:51 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20251016

for you to fetch changes up to 3b283e98d7f3b1cec795bfac0213265e41fbecfe:

  mailmap: Unify Clément Mathieu--Drif emails (2025-10-16 14:08:44 +0200)

----------------------------------------------------------------
Various patches related to single binary work:

- Remove some VMSTATE_UINTTL() uses
- Replace target_ulong by vaddr / hwaddr / uint[32,64]_t
- Expand TCGv to TCGv_i32 for 32-bit targets
- Remove some unnecessary checks on TARGET_LONG_BITS
- Replace few HOST_BIG_ENDIAN preprocessor #ifdef by compile-time if() check
- Expand MO_TE to either MO_BE or MO_LE

Also:

- Fix HPPA FMPYADD opcode
- Unify Clément Mathieu--Drif email addresses
----------------------------------------------------------------

Anton Johansson (1):
  target/riscv: Use 32 bits for misa extensions

Gabriel Brookman (1):
  target/hppa: correct size bit parity for fmpyadd

Philippe Mathieu-Daudé (73):
  accel/tcg: Name gen_goto_tb()'s TB slot index as @tb_slot_idx
  target/alpha: Access CPUState::cpu_index via helper
  target/alpha: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
  target/hppa: Use hwaddr type for HPPATLBEntry::pa
  target/hppa: Have hppa_form_gva*() return vaddr type
  target/hppa: Explode MO_TExx -> MO_TE | MO_xx
  target/hppa: Conceal MO_TE within do_load()
  target/hppa: Conceal MO_TE within do_load_32/64()
  target/hppa: Conceal MO_TE within do_store()
  target/hppa: Conceal MO_TE within do_store_32/64()
  target/hppa: Introduce mo_endian() helper
  target/hppa: Replace MO_TE -> MO_BE
  target/loongarch: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
  target/loongarch: Remove target_ulong use in gen_goto_tb()
  target/loongarch: Remove target_ulong use in gdb_write_register
    handler
  target/loongarch: Do not use target_ulong type for LDDIR level
  target/m68k: Remove unused @cpu_exception_index TCGv
  target/m68k: Remove pointless @cpu_halted TCGv
  target/microblaze: Remove target_ulong use in cpu_handle_mmu_fault()
  target/microblaze: Remove target_ulong uses in
    get_phys_page_attrs_debug
  target/microblaze: Remove target_ulong use in gen_goto_tb()
  target/microblaze: Remove target_ulong use in helper_stackprot()
  target/microblaze: Have compute_ldst_addr_type[ab] return TCGv_i32
  target/microblaze: Have do_load/store() take a TCGv_i32 address
    argument
  target/microblaze: Convert CPUMBState::res_addr field to uint32_t type
  target/openrisc: Replace VMSTATE_UINTTL() -> VMSTATE_UINT32()
  target/openrisc: Do not use target_ulong for @mr in MTSPR helper
  target/openrisc: Remove unused cpu_openrisc_map_address_*() handlers
  target/openrisc: Remove target_ulong use in raise_mmu_exception()
  target/openrisc: Use vaddr type for $pc jumps
  target/openrisc: Remove 'TARGET_LONG_BITS != 32' dead code
  target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
  target/openrisc: Conceal MO_TE within do_load()
  target/openrisc: Conceal MO_TE within do_store()
  target/openrisc: Introduce mo_endian() helper
  target/openrisc: Replace MO_TE -> MO_BE
  target/openrisc: Inline tcg_gen_trunc_i64_tl()
  target/openrisc: Replace target_ulong -> uint32_t
  target/riscv: Replace HOST_BIG_ENDIAN #ifdef with if() check
  target/rx: Replace target_ulong -> vaddr for translator API uses
  target/rx: Use MemOp type in gen_ld[u]() and gen_st()
  target/rx: Propagate DisasContext to generated helpers
  target/rx: Propagate DisasContext to push() / pop()
  target/rx: Propagate DisasContext to gen_ld[u]() and gen_st()
  target/rx: Factor mo_endian() helper out
  target/rx: Replace MO_TE -> MO_LE
  target/rx: Expand TCG register definitions for 32-bit target
  target/rx: Un-inline various helpers
  target/s390x: Replace HOST_BIG_ENDIAN #ifdef with if() check
  target/sh4: Convert CPUSH4State::sr register to uint32_t type
  target/sh4: Remove target_ulong use in cpu_sh4_is_cached()
  target/sh4: Use hwaddr type for hardware addresses
  target/sh4: Remove target_ulong uses in superh_cpu_get_phys_page_debug
  target/sh4: Use vaddr type for TLB virtual addresses
  target/sh4: Remove target_ulong use in gen_goto_tb()
  target/sparc: Reduce inclusions of 'exec/cpu-common.h'
  target/tricore: Remove target_ulong use in gen_goto_tb()
  target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
  target/tricore: Remove target_ulong use in translate_insn() handler
  target/tricore: Remove target_ulong use in gen_addi_d()
  target/tricore: Remove unnecessary cast to target_ulong
  target/tricore: Replace target_ulong -> uint32_t in op_helper.c
  target/tricore: Declare registers as TCGv_i32
  target/tricore: Inline tcg_gen_ld32u_tl()
  target/tricore: Expand TCG helpers for 32-bit target
  target/tricore: Pass DisasContext as first argument
  target/tricore: Un-inline various helpers
  target/tricore: Expand TCGv type for 32-bit target
  target/xtensa: Replace legacy cpu_physical_memory_[un]map() calls
  target/xtensa: Remove target_ulong use in xtensa_tr_translate_insn()
  target/xtensa: Remove target_ulong use in xtensa_get_tb_cpu_state()
  linux-user/microblaze: Fix little-endianness binary
  mailmap: Unify Clément Mathieu--Drif emails

 target/alpha/helper.h                         |    1 +
 target/hppa/cpu.h                             |   10 +-
 target/loongarch/cpu-mmu.h                    |    2 +-
 target/loongarch/tcg/helper.h                 |    2 +-
 target/microblaze/cpu.h                       |    2 +-
 target/microblaze/helper.h                    |    2 +-
 target/microblaze/mmu.h                       |    2 +-
 target/openrisc/cpu.h                         |   31 +-
 target/openrisc/helper.h                      |    8 +-
 target/riscv/cpu.h                            |    4 +-
 target/sh4/cpu.h                              |    6 +-
 target/sparc/cpu.h                            |    1 -
 target/hppa/insns.decode                      |    8 +-
 linux-user/microblaze/elfload.c               |    3 +-
 target/alpha/machine.c                        |   34 +-
 target/alpha/sys_helper.c                     |    5 +
 target/alpha/translate.c                      |   11 +-
 target/arm/tcg/translate-a64.c                |    8 +-
 target/arm/tcg/translate.c                    |    8 +-
 target/avr/translate.c                        |    7 +-
 target/hexagon/translate.c                    |    8 +-
 target/hppa/helper.c                          |    4 +-
 target/hppa/mem_helper.c                      |    2 +-
 target/hppa/translate.c                       |   24 +-
 target/loongarch/cpu_helper.c                 |    2 +-
 target/loongarch/gdbstub.c                    |    2 +-
 target/loongarch/machine.c                    |    4 +-
 target/loongarch/tcg/tlb_helper.c             |    4 +-
 target/loongarch/tcg/translate.c              |    6 +-
 target/m68k/translate.c                       |   17 +-
 target/microblaze/helper.c                    |    3 +-
 target/microblaze/machine.c                   |    6 +-
 target/microblaze/mmu.c                       |    4 +-
 target/microblaze/op_helper.c                 |    4 +-
 target/microblaze/translate.c                 |   83 +-
 target/mips/tcg/translate.c                   |    7 +-
 target/openrisc/fpu_helper.c                  |    8 +-
 target/openrisc/machine.c                     |   20 +-
 target/openrisc/mmu.c                         |    7 +-
 target/openrisc/sys_helper.c                  |    7 +-
 target/openrisc/translate.c                   |  463 +-
 target/ppc/translate.c                        |    7 +-
 target/riscv/translate.c                      |    9 +-
 target/riscv/vector_helper.c                  |   32 +-
 target/rx/translate.c                         |  462 +-
 target/s390x/tcg/translate.c                  |    6 +-
 target/sh4/helper.c                           |   34 +-
 target/sh4/translate.c                        |   10 +-
 target/sparc/helper.c                         |    1 +
 target/sparc/int64_helper.c                   |    1 +
 target/sparc/translate.c                      |    6 +-
 target/tricore/cpu.c                          |    2 +-
 target/tricore/helper.c                       |    4 +-
 target/tricore/op_helper.c                    |  219 +-
 target/tricore/translate.c                    | 3978 +++++++++--------
 target/xtensa/cpu.c                           |    6 +-
 target/xtensa/translate.c                     |    2 +-
 target/xtensa/xtensa-semi.c                   |   11 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |    2 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |   16 +-
 target/s390x/tcg/translate_vx.c.inc           |    6 +-
 .mailmap                                      |    1 +
 target/hppa/trace-events                      |    6 +-
 63 files changed, 2848 insertions(+), 2813 deletions(-)

-- 
2.51.0


