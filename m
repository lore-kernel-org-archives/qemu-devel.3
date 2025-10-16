Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990F1CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PdV-0001JZ-Ot; Thu, 16 Oct 2025 11:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PdQ-0001Ex-Hm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:21 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PdN-0002GC-2m
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:11:20 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso838729f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627470; x=1761232270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9xxF7jdm74YStnRJY7Jlt06coOhjqbzVEk9fPNwpOA=;
 b=Xp3eldv6NeiUy5O4xBo0Xnoq9xbJKOfjqnm8SJJwjpfxXMvBFb1eXy09ob81IvHCS+
 1NTjcUoaatfwKGXHqrMflO6ja73qSpbGSKN3XwmNlGxPu3n75KQsEkvxhVxdKFmOWQUX
 DgHxgAfV7twEhZQUigkkMskM0j31h+MEbDps6681+HTAY6aHIHkQSwyvmU4tu3C7ztrq
 vFgvlvF7jUTcWJF6WRYRrcsegEq6plVF5pf1hMsVNOGCU04UKTObgH7aSwq4taBEcCTh
 /rYM4YLrskMKtSHuKIGwddF37vUHroq6l0jDDi4TI9mxtn20qWS/IOm/SYJPTnHK1vVm
 1ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627470; x=1761232270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9xxF7jdm74YStnRJY7Jlt06coOhjqbzVEk9fPNwpOA=;
 b=hNsQUx5Hsdrsbi3kVMfABXlqni71cxH/lbkfsUidMEVQ2IBD2dO8Gh5zrRSwEeQTPH
 2cktjb0tPPo0gS1EPkjE5PKRhiKT3171U40k1gQl05zZLP6CuRsQmHcdf9kgBy1FbM5I
 M7FR+j6q3Hlx+rWkWPY80XKWJaQ2lU6VzPTxpk9Mo5e4ImpFDNrgGz8rOdJ9LEle96Qk
 PM33roNgwAY9PpgXgaJBsaU0UhLVQwjiNku1d8IeY8KS8XLdq5/VuaIw7dpCFU6j7pHV
 ub1o4vI5gV3dQrhSat9kXVc1ZQVSZXn9wEElQkVVsfMaUwSKqaKm9NZgbAlA6Hxa6vgp
 JLsw==
X-Gm-Message-State: AOJu0YykcyEAAdg9hFVwOZIAI7V5+8Ci48x40wtyxTrnt3tQgPYbuCjP
 jwdZdu4q74+idvI8FI1w5Hm5IwMB8w47NfXcyKO0glKFClXMgA8JX/M58m+pCguL80OPjBRSmmU
 BWdTYP+g=
X-Gm-Gg: ASbGnctOhNYyI5cavTGgdx6+6Df5r9HJ/HxNWTNlLCYAab4a1mfWYHWMRdbjKSc5hy7
 spWSfyJcX0vP3DQL7cwytVk6gdNdlcov0xDOYzDduuTenytvI9qcFUSzqCJ22IENdZndqjlsJV5
 AO5GEpsh94QiC7qg2HQJ2rWD0ZpIszfo/kXNKoOxpNuR51zXl0iswPDoGupLFP4QYO6ZhklbcIT
 KwyzB1F3NQuWRSnFtdfgrQYb87O25dd6bYp1mQz1y4OomKCyCe7BWRVvy/cZ9Bxu2TA/3ecHAam
 4+pDC6HtThwSOFHgVyIg/fZbI4bhe47KLUWUR0VV7DCRwkLLo5Z/QxwmN3Q929biYSeFuJnvBXR
 L7PEVNttEtWnhumC7JBCGw0PPfaOGV4LSrffn69kgzA8Bk7UQxOMeDZbIf9hDDlUBESB3lLwetd
 qBk5vKCl8vEIe3A1hbebK0d77AC67kmln3LqxkEzHnCUg75JIUQw==
X-Google-Smtp-Source: AGHT+IHRwijmfEpEWDqiimGZq/jcFqktGAo9faLowCALyurIHuXwUokfga560M47A/SStYtz6Zoojw==
X-Received: by 2002:a05:6000:2883:b0:3fd:bf1d:15ac with SMTP id
 ffacd0b85a97d-42704d86d0emr416249f8f.20.1760627470223; 
 Thu, 16 Oct 2025 08:11:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42700072619sm3717345f8f.46.2025.10.16.08.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 08:11:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/75] Misc single binary patches for 2025-10-16
Date: Thu, 16 Oct 2025 17:11:03 +0200
Message-ID: <20251016151108.18442-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The following changes since commit 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8:

  Merge tag 'pull-loongarch-20251015' of https://github.com/bibo-mao/qemu into staging (2025-10-15 14:49:51 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/single-binary-20251016

for you to fetch changes up to 8dd133fa85bb49e2e61c489a566ab8460478dc24:

  mailmap: Unify Clément Mathieu--Drif emails (2025-10-16 17:07:52 +0200)

v2: Remove legacy cpu_physical_memory_*() calls

----------------------------------------------------------------
Various patches related to single binary work:

- Remove some VMSTATE_UINTTL() uses
- Replace target_ulong by vaddr / hwaddr / uint[32,64]_t
- Expand TCGv to TCGv_i32 for 32-bit targets
- Remove some unnecessary checks on TARGET_LONG_BITS
- Replace few HOST_BIG_ENDIAN preprocessor #ifdef by compile-time if() check
- Expand MO_TE to either MO_BE or MO_LE

Also:

- Remove legacy cpu_physical_memory_*() calls
- Fix HPPA FMPYADD opcode
- Unify Clément Mathieu--Drif email addresses
----------------------------------------------------------------

Anton Johansson (1):
  target/riscv: Use 32 bits for misa extensions

Gabriel Brookman (1):
  target/hppa: correct size bit parity for fmpyadd

Philippe Mathieu-Daudé (77):
  accel/tcg: Name gen_goto_tb()'s TB slot index as @tb_slot_idx
  target/alpha: Access CPUState::cpu_index via helper
  target/alpha: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
  target/i386/monitor: Propagate CPU address space to 'info mem'
    handlers
  target/i386/monitor: Replace legacy cpu_physical_memory_read() calls
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
  target/riscv/kvm: Replace legacy cpu_physical_memory_read/write()
    calls
  target/riscv/monitor: Replace legacy cpu_physical_memory_read() call
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
 target/i386/monitor.c                         |  134 +-
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
 target/riscv/kvm/kvm-cpu.c                    |    6 +-
 target/riscv/monitor.c                        |   12 +-
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
 66 files changed, 2925 insertions(+), 2888 deletions(-)

-- 
2.51.0


