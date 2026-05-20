Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA891CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgNZ-0004uf-Q7; Wed, 20 May 2026 08:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgN3-0004Z2-LC; Wed, 20 May 2026 08:50:03 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgMv-0002c6-Fx; Wed, 20 May 2026 08:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
 :Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=8oUBw4BPNcw1cS7EyqgJWIbubKHGWwZbf3XA93srS5I=; b=Qfa2WSGJn4G5ee/
 YWm0kmE7FtsfgRbH3BiV9LEAmM2k5kMHaS7OPEj6/5dpwRLUSnAlhGQHClmXbjLyZo0Ij8O9WcKH/
 fzBVya1qHZl6WTj7RqIW2LJKa4ESvxnSBifo47DUP35dX/U1KEOvVUgbWvNgGw7waoahTFh8i97dP
 SA=;
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v7 00/27] single-binary: Make riscv cpu.h target independent
Date: Wed, 20 May 2026 14:53:38 +0200
Message-ID: <20260520125406.28693-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

this is a first patchset moving towards single-binary support for riscv.
Additional patchsets for hw/ and target/ are based on this one so it's
best to make sure the approach taken is ok.  Most patches in this set
concern fields in CPUArchState which are either widened (usually to
uint64_t) or fixed to a smaller size which handles all use cases.

General purpose registers and fields mapped to TCG are dealt with by
widening the type and applying an offset to tcg_global_mem_new() to
correctly handle 32-bit targets on big endian hosts.

Let me know what you think of the direction taken here and if you would
prefer something else.

Changes in v2:
  - Use BIT() to define misa extension bits in "Use 32 bits for misa
    extensions";

  - Squash "Fix size of mcause" into "Fix size of trivial CPUArchState
    fields";

  - Bump VMSTATE version_id and minimum_version_id for "cpu/pmp/entry",
    "cpu/pmp", "cpu/hyper", "cpu/vector", "cpu/rv128", "cpu/debug",
    "cpu/envcfg", "cpu/pmu", "cpu/jvt", "cpu/ssp", and "cpu".  Migration
    from older versions is broken.

Changes in v3:
  - Fix formatting issues during printing;

  - Move assert before extract64() in pmu_read_ctr();

  - Added patch 5/34 fixing a bug in rmw_cd_ctr_cfg() where bit 30 is
    zeroed instead of bit 62 (MHPMEVENTH_* vs MHPMEVENT_*);

  - Added privilege_mode_t typedef for storing PRV_* fields;

  - Added reviewed-bys.

Changes in v4:
  - Used target-specific includes (target/riscv/*) for csr.h and
    debug.h (Philippe);

  - Migrated mcontext (Philippe), migration entry is added to existing
    patch modifiying mcontext (patch 29 "Fix size of trigger data");

  - Added reviewed-bys and acked-bys.

Changes in v5:
  - Removed first 8 patches that were pulled out by Alistair;

  - Rebased on 20251103033713.904455-1-alistair.francis@wdc.com;

  - Added reviewed-bys and acked-bys.

Changes in v6:
  - Rebased on master since previous base has since been merged.

  - Patch 2/27: `target/riscv: Fix size of vector CSRs`, changed
    arguments of functions in vector_helper.c to match new expected
    types.

  - Patch 4/27: `target/riscv: Fix size of frm and fflags`, update
    missed `rm` function arguments to match env type.

  - Patch 10/27: `target/riscv: Fix size of excp_uw2`, update
    missed `excp_uw2` function arguments to match env type.

  - Patch 12/27: `target/riscv: Fix size of priv`, update
    missed function arguments to use privilege_mode_t.

  - Patch 13/27: `target/riscv: Fix size of gei fields`, masking when
    assigning gei fields is widened to 64-bit as geilen is already
    verified to be smaller than the target long size, and an
    out-of-bounds shift would be UB anyway

  - Added patch 26/27 `target/riscv: Pass address as uint64_t in
    cpu_set_exception_base()` to handle a new exposed function in cpu.h

  - Added patch 27/27 `target/riscv: Fix pmp.h/cpu.h circular inclusion`
    to address a circular dependency between pmp.h and cpu.h.

Changes in v7:
  - Change return type of riscv_cpu_xlen() from int to uint16_t (Philippe)

  - Update irq_overflow_left comment (Philippe)

  - Return RISCVException in externally facing CSR functions (Philippe).

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

 target/riscv/cpu.h                            | 264 +++++++-----------
 target/riscv/csr.h                            | 102 +++++++
 target/riscv/debug.h                          |   2 -
 target/riscv/internals.h                      |   4 +-
 target/riscv/pmp.h                            |  23 +-
 target/riscv/pmu.h                            |   2 +-
 hw/intc/riscv_imsic.c                         |  34 +--
 hw/riscv/riscv_hart.c                         |   7 +-
 linux-user/riscv/signal.c                     |   5 +-
 target/riscv/cpu.c                            |  22 +-
 target/riscv/cpu_helper.c                     |  65 +++--
 target/riscv/csr.c                            |  93 +++---
 target/riscv/debug.c                          |   1 +
 target/riscv/fpu_helper.c                     |  10 +-
 target/riscv/gdbstub.c                        |   3 +-
 target/riscv/kvm/kvm-cpu.c                    |   1 +
 target/riscv/machine.c                        |  81 +++---
 target/riscv/mips_csr.c                       |   1 +
 target/riscv/monitor.c                        |   3 +-
 target/riscv/op_helper.c                      |  28 +-
 target/riscv/pmp.c                            |  14 +-
 target/riscv/pmu.c                            |   9 +-
 target/riscv/riscv-qmp-cmds.c                 |   1 +
 target/riscv/tcg/tcg-cpu.c                    |   1 +
 target/riscv/th_csr.c                         |   1 +
 target/riscv/translate.c                      |  60 ++--
 target/riscv/vector_helper.c                  | 125 +++++----
 .../riscv/insn_trans/trans_privileged.c.inc   |   2 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  16 +-
 target/riscv/insn_trans/trans_rvm.c.inc       |  16 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |  22 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  22 +-
 32 files changed, 585 insertions(+), 455 deletions(-)
 create mode 100644 target/riscv/csr.h

-- 
2.52.0


