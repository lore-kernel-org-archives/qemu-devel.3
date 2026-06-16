Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF01CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQfu-00052O-Uq; Tue, 16 Jun 2026 06:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQfs-000520-Fi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:40 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQfp-0002zK-VB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:05:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c85d8615b09so2564417a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604336; x=1782209136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wrXId/fdnuuqzNwkDQ7tJCfZ/9ieBVucc0HqHfq+3Kg=;
 b=BLNgefgsC45ykpYns+EhaW2SGYkCPWOxdFhYUvW29LJi6B2+pX8iUv+zN51l4eiX9V
 HTMdAgnmzN1xsMUgJGVoi9EH3+y1QtL6Wz9g0WAH7699Qg5ks7DQm/F6IV8pH4IM9/NE
 MBoyd3pgvLHRu5qX0z0RniAxN8n1slrp2/YwWO3YN4OjUekLsw5CKeuHSTdKA2EXXNAU
 F8Z/Y6dg728SdvJrZSupgcOnfDFFHVDEK7fHrdlBuHcKjEPOPpkawJD6S6q6U9gqXbt3
 6kNvh1+SIEDoVY2/j7xdGMHSpTAq+GOQUpNFNss/Tq5zMO7drcyEWhb7Sf0WUcO37IQh
 80ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604336; x=1782209136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrXId/fdnuuqzNwkDQ7tJCfZ/9ieBVucc0HqHfq+3Kg=;
 b=iFNyGTYmEM0DUaEDrY27dKUrAv1aXeghsl708CcZW1778KOO/cMWPkUf3nIAtFJMrT
 HUeFhjnr8M8DNz/qKcQESzGuDGntB7sVBtR5XXpF02lecV4DzGhiSxbyQoMSA/C5wYfs
 GXCOu2usl0aG0xQ5RtrGQU4lYgqy8YbNEvUBZMeSS+Z/wGKHFHdB13ZfRkrV27h7Fxzz
 XvVQou7UeR+ftiIQEjTwAVj7+BDga4FoyGi1okdaHC0j1t6EuqfEshDnJNCCfiyl6Kp2
 Y1VtPaQrXEsww7OfP1I3tTJ9TAmkYYPcTUsETnCZO1VRwUg/mJRlu/ILtuBw7a1b/OiU
 i/QQ==
X-Gm-Message-State: AOJu0YyPufSCNpeiEO1hlUgWHR6DBsHCJ2raxxVWGR4IuhBqFQ7eScCA
 k0bLJO1tlyKxXayTNpLsbG1HEfmuXT89Zu6lpR5JziZQxK22K2Kbi21IiyYJ6l8U
X-Gm-Gg: Acq92OFfpITlIm45+zVAER1Du8ONGLiGzcBnEqyFWjRbrSgIeq25nH51WsQaSpfR4A2
 Y+kqFb1CMpznon0meVm5dptwXRTQ+TqCrAFCcLeND0jLRQeDk3obmbMtAgPjG9e1ksTaLk1G94y
 n+VnnmFWJ6UG4PyYc5F7zXraDKguzD7p6q1cat8t1ctI/o61bf1m8gCYguX4w0eHFzfRn8phhZ0
 VkHdgWloTUbimcoYqAbCRV1A3Wc2DHw/mmM/4IVfxhWDDZMry8xdb67SvySbnEpUQk/khFutRZC
 Rs3RUulRmv/64RuVFG0h8uK8kRsLbvvoQVogKiHi/WT9JeeOHUPwVqKRbjPB/2j6Riq7GOdUD/q
 ah3yrAt3bMGmPHKm8cDBOt4Tst4EMVHsTB1tetWySnrn2SHRWj1p3cRk2tiiylqIhXl66iAQLrj
 QdcX+GA8HdB+h4c1qKZ/l0EufyR3ARGSn7DWiSpPBuTeBbNWdEx1k=
X-Received: by 2002:a05:6a20:3d8e:b0:3b4:b2db:d784 with SMTP id
 adf61e73a8af0-3b7e44b4711mr3581863637.2.1781604336081; 
 Tue, 16 Jun 2026 03:05:36 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:05:35 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/83] riscv-to-apply queue
Date: Tue, 16 Jun 2026 20:04:03 +1000
Message-ID: <20260616100527.1939565-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alistair Francis <alistair.francis@wdc.com>

The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:

  Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20260616

for you to fetch changes up to e968e487acf082279118667f495a3f4275a59d59:

  hw/riscv: add create_fdt_socket_cpu_sifive() (2026-06-16 20:01:11 +1000)

----------------------------------------------------------------
RISC-V PR for 11.1

* Disable svpbmt if satp_mode is less then sv39
* Fix PMP address alignment
* Mstatus write bug fixes
* Add 'cbo' insns to disassembler
* Do not hide Sstc CSRs from gdbstub
* Reject Svinval instructions in U-mode
* Save opcode before zicbo helpers
* Fault with reserved PTE.PBMT val
* Allow LOAD_ADDR_MIS promotion to AMO fault
* Make riscv cpu.h target independent
* Add PMA access fault
* Disable svnapot if satp_mode is less then sv39
* Fix disassembler inst_length calculation
* Add RISC-V big-endian target support
* Add the implied rules for G and B extensions
* Print privilege level and ELP in riscv_cpu_dump_state
* Improve alignment in riscv_cpu_dump_state
* Mask vxrm csrw write to the low 2 bits
* Reorder Smrnmi CPU fields above CPU reset line
* Supplement cpu topology arguments
* Don't insert DDT cache in Bare mode
* Fix 'iommu-map' FDT entry
* Fix mstatus.FS dirty tracking for FP exception-raising instructions
* Enable `mnret` disassembly
* Add support for K230 board
* FDT creation helpers

----------------------------------------------------------------
Abhigyan Kumar (1):
      target/riscv: mask vxrm csrw write to the low 2 bits

Anton Blanchard (2):
      target/riscv: Print privilege level and ELP in riscv_cpu_dump_state
      target/riscv: Improve alignment in riscv_cpu_dump_state

Anton Johansson (27):
      target/riscv: Fix size of gpr and gprh
      target/riscv: Fix size of vector CSRs
      target/riscv: Fix size of pc, load_[val|res]
      target/riscv: Fix size of frm and fflags
      target/riscv: Fix size of badaddr and bins
      target/riscv: Fix size of guest_phys_fault_addr
      target/riscv: Fix size of priv_ver and vext_ver
      target/riscv: Fix size of retxh
      target/riscv: Fix size of ssp
      target/riscv: Fix size of excp_uw2
      target/riscv: Fix size of sw_check_code
      target/riscv: Fix size of priv
      target/riscv: Fix size of gei fields
      target/riscv: Fix size of [m|s|vs]iselect fields
      target/riscv: Fix arguments to board IMSIC emulation callbacks
      target/riscv: Fix size of irq_overflow_left
      target/riscv: Indent PMUFixedCtrState correctly
      target/riscv: Replace target_ulong in riscv_cpu_get_trap_name()
      target/riscv: Replace target_ulong in riscv_ctr_add_entry()
      target/riscv: Fix size of trigger data
      target/riscv: Fix size of mseccfg
      target/riscv: Move debug.h include away from cpu.h
      target/riscv: Move CSR declarations to separate csr.h header
      target/riscv: Introduce externally facing CSR access functions
      target/riscv: Make pmp.h target_ulong agnostic
      target/riscv: Pass address as uint64_t in cpu_set_exception_base()
      target/riscv: Fix pmp.h/cpu.h circular inclusion

Chao Liu (5):
      target/riscv: add thead-c908 cpu support
      hw/riscv: add k230 board initial support
      hw/watchdog: add k230 watchdog initial support
      tests/qtest: add test for K230 watchdog
      docs/system/riscv: add documentation for k230 machine

Daniel Henrique Barboza (24):
      target/riscv/tcg: disable svpbmt if satp_mode < sv39
      target/riscv/csr.c: do not allow mstatus MPV/GVA writes
      target/riscv/csr.c: fix mstatus.UXL reserved value
      disas/riscv.c: add 'cbo' insns to disassembler
      target/riscv/insn_trans/trans_rvzicbo.c.inc: save opcode before helpers
      target/riscv/cpu_helper.c: fault with reserved PTE.PBMT val
      target/riscv/cpu_helper.c: allow LOAD_ADDR_MIS promotion to AMO fault
      target/riscv/cpu_helper.c: add PMA access fault
      target/riscv/tcg: disable svnapot if satp_mode < sv39
      disas/riscv.c: fix inst_length()
      hw/riscv/virt.c: fix 'iommu-map' FDT entry
      hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
      hw/riscv: add fdt-common helper
      hw/riscv/numa: make numa_enabled() public
      hw/riscv: add create_fdt_socket_memory() helper
      hw/riscv/sifive_u.c: add intc_phandles array
      hw/riscv/spike.c: add intc_phandles array
      hw/riscv: add create_fdt_clint() helper
      hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
      hw/riscv: add fdt_create_cpu_socket_subnode() helper
      hw/riscv: add create_fdt_socket_cpus()
      hw/riscv/spike.c: use create_fdt_socket_cpus()
      hw/riscv/fdt_common.c: create create_fdt_socket_cpu_internal()
      hw/riscv: add create_fdt_socket_cpu_sifive()

Djordje Todorovic (6):
      target/riscv: Implement runtime data endianness via MSTATUS bits
      target/riscv: Fix page table walk endianness for big-endian harts
      target/riscv: Add big-endian CPU configuration field and reset logic
      hw/riscv/boot: Honour data endianness
      target/riscv: Expose and document the CPU 'big-endian' property
      tests/functional: Add RISC-V endianness test

Frank Chang (2):
      target/riscv: Add standard B extension implied rule
      target/riscv: Reorder Smrnmi CPU fields above CPU reset line

Jay Chang (4):
      target/riscv: Align pmp size to pmp-granularity
      target/riscv: Improve PMP address alignment readability
      hw/riscv: Don't insert DDT cache in Bare mode
      hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode handling

Jim Shu (1):
      target/riscv: Add the implied rule for G extension

Max Chou (2):
      target/riscv: Set mstatus.FS dirty when scalar FP raises exceptions
      target/riscv: rvv: Set mstatus.FS dirty when vector FP raises exceptions

Philippe Mathieu-Daudé (5):
      target/riscv: Initialize DisasContext::mo_endian once
      target/riscv: De-indent some code in get_physical_address()
      target/riscv: Remove target_ulong use in get_physical_address()
      hw/riscv/boot: Rewrite setup_rom_reset_vec() using load/store API
      hw/riscv/boot: Replace cpu_to_le32() -> const_le32()

Xuemei Liu (1):
      hw/riscv/numa.c: Supplement cpu topology arguments

Zephyr Li (2):
      target/riscv: Do not hide Sstc CSRs from gdbstub
      target/riscv: Reject Svinval instructions in U-mode

imaginos (1):
      disas/riscv: enable `mnret` disassembly

 MAINTAINERS                                    |  11 +
 docs/system/riscv/k230.rst                     | 113 ++++++
 docs/system/target-riscv.rst                   |  30 ++
 include/hw/riscv/fdt-common.h                  |  33 ++
 include/hw/riscv/k230.h                        | 149 +++++++
 include/hw/riscv/numa.h                        |   8 +
 include/hw/watchdog/k230_wdt.h                 | 121 ++++++
 target/riscv/cpu-qom.h                         |   2 +
 target/riscv/cpu.h                             | 287 +++++---------
 target/riscv/csr.h                             | 102 +++++
 target/riscv/debug.h                           |   2 -
 target/riscv/internals.h                       |  33 +-
 target/riscv/pmp.h                             |  23 +-
 target/riscv/pmu.h                             |   2 +-
 target/riscv/cpu_cfg_fields.h.inc              |   1 +
 target/riscv/insn32.decode                     |   2 +-
 disas/riscv.c                                  |  56 ++-
 hw/intc/riscv_imsic.c                          |  34 +-
 hw/riscv/boot.c                                |  95 ++---
 hw/riscv/fdt-common.c                          | 202 ++++++++++
 hw/riscv/k230.c                                | 526 +++++++++++++++++++++++++
 hw/riscv/numa.c                                |  32 +-
 hw/riscv/riscv-iommu.c                         |  34 +-
 hw/riscv/riscv_hart.c                          |   7 +-
 hw/riscv/sifive_u.c                            |  88 +----
 hw/riscv/spike.c                               | 123 ++----
 hw/riscv/virt.c                                | 185 ++-------
 hw/watchdog/k230_wdt.c                         | 296 ++++++++++++++
 linux-user/riscv/signal.c                      |   5 +-
 target/riscv/cpu.c                             | 140 ++++++-
 target/riscv/cpu_helper.c                      | 180 ++++++---
 target/riscv/csr.c                             | 116 ++++--
 target/riscv/debug.c                           |   1 +
 target/riscv/fpu_helper.c                      | 167 ++++++--
 target/riscv/gdbstub.c                         |   3 +-
 target/riscv/kvm/kvm-cpu.c                     |   1 +
 target/riscv/machine.c                         |  81 ++--
 target/riscv/mips_csr.c                        |   1 +
 target/riscv/monitor.c                         |   3 +-
 target/riscv/op_helper.c                       |  28 +-
 target/riscv/pmp.c                             |  34 +-
 target/riscv/pmu.c                             |   9 +-
 target/riscv/riscv-qmp-cmds.c                  |   1 +
 target/riscv/tcg/tcg-cpu.c                     |  63 ++-
 target/riscv/th_csr.c                          | 377 +++++++++++++++++-
 target/riscv/translate.c                       |  82 ++--
 target/riscv/vector_helper.c                   | 366 +++++++++--------
 tests/qtest/k230-wdt-test.c                    | 189 +++++++++
 target/riscv/insn_trans/trans_privileged.c.inc |   2 +-
 target/riscv/insn_trans/trans_rva.c.inc        |   4 +-
 target/riscv/insn_trans/trans_rvd.c.inc        |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc        |   4 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |  24 +-
 target/riscv/insn_trans/trans_rvm.c.inc        |  16 +-
 target/riscv/insn_trans/trans_rvv.c.inc        |  22 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc    |   4 +-
 target/riscv/insn_trans/trans_rvzalasr.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzce.c.inc      |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc      |   4 +-
 target/riscv/insn_trans/trans_rvzicbo.c.inc    |   8 +
 target/riscv/insn_trans/trans_rvzicfiss.c.inc  |  26 +-
 target/riscv/insn_trans/trans_svinval.c.inc    |  12 +
 target/riscv/insn_trans/trans_xmips.c.inc      |   8 +-
 target/riscv/insn_trans/trans_xthead.c.inc     |  16 +-
 target/riscv/insn_trans/trans_zilsd.c.inc      |   4 +-
 hw/riscv/Kconfig                               |  11 +
 hw/riscv/meson.build                           |   3 +-
 hw/watchdog/Kconfig                            |   4 +
 hw/watchdog/meson.build                        |   1 +
 hw/watchdog/trace-events                       |   9 +
 tests/functional/riscv64/meson.build           |   1 +
 tests/functional/riscv64/test_endianness.py    |  57 +++
 tests/qtest/meson.build                        |   3 +-
 73 files changed, 3544 insertions(+), 1155 deletions(-)
 create mode 100644 docs/system/riscv/k230.rst
 create mode 100644 include/hw/riscv/fdt-common.h
 create mode 100644 include/hw/riscv/k230.h
 create mode 100644 include/hw/watchdog/k230_wdt.h
 create mode 100644 target/riscv/csr.h
 create mode 100644 hw/riscv/fdt-common.c
 create mode 100644 hw/riscv/k230.c
 create mode 100644 hw/watchdog/k230_wdt.c
 create mode 100644 tests/qtest/k230-wdt-test.c
 create mode 100644 tests/functional/riscv64/test_endianness.py

