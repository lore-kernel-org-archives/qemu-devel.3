Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96941CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jmw-0005NU-E2; Wed, 24 Sep 2025 03:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmt-0005N0-DE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:39 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v1Jmo-0003Nk-GV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=gFJkB2OrJPTxGlQ0jsL1K5bpwLVi5sAs+TIYHi8sp+E=; b=kzVkCsLoIUcmfbv
 60GdzIITrPZNlbZw4AsdzOPNtzp1wD8ZwRpAv4cQ7B8YXB2Ex5pjAE/s+Sqtsc052esOV+sZm20yQ
 JjRe0hauT14uc7WEbP6Dmvbm2SiyxrXYd3rShWd3U4trg4BTj2yplh6p59ouobbnwJz+ZIibdUu8f
 Fc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com
Subject: [RFC PATCH 00/34] single-binary: Make riscv cpu.h target independent
Date: Wed, 24 Sep 2025 09:20:50 +0200
Message-ID: <20250924072124.6493-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
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

Quick question to correct my understanding. AFAICT riscv64-softmmu is a
superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
concerning single-binary do we for the time being only need to support
riscv64-softmmu?

Let me know what you think of the direction taken here and if you would
prefer something else.

Anton Johansson (34):
  target/riscv: Use 32 bits for misa extensions
  target/riscv: Fix size of trivial CPUArchState fields
  target/riscv: Fix size of mcause
  target/riscv: Fix size of mhartid
  target/riscv: Bugfix riscv_pmu_ctr_get_fixed_counters_val()
  target/riscv: Combine mhpmevent and mhpmeventh
  target/riscv: Combine mcyclecfg and mcyclecfgh
  target/riscv: Combine minstretcfg and minstretcfgh
  target/riscv: Combine mhpmcounter and mhpmcounterh
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

 target/riscv/cpu.h                            | 341 +++++++-----------
 target/riscv/csr.h                            |  93 +++++
 target/riscv/debug.h                          |   2 -
 target/riscv/pmp.h                            |  20 +-
 hw/intc/riscv_imsic.c                         |  34 +-
 hw/riscv/riscv_hart.c                         |   7 +-
 linux-user/riscv/signal.c                     |   5 +-
 target/riscv/cpu.c                            |  11 +-
 target/riscv/cpu_helper.c                     |  37 +-
 target/riscv/csr.c                            | 284 ++++++++-------
 target/riscv/debug.c                          |   1 +
 target/riscv/fpu_helper.c                     |   6 +-
 target/riscv/gdbstub.c                        |   1 +
 target/riscv/kvm/kvm-cpu.c                    |   1 +
 target/riscv/machine.c                        | 133 ++++---
 target/riscv/op_helper.c                      |   1 +
 target/riscv/pmp.c                            |  13 +-
 target/riscv/pmu.c                            | 150 ++------
 target/riscv/tcg/tcg-cpu.c                    |   3 +-
 target/riscv/th_csr.c                         |   1 +
 target/riscv/translate.c                      |  53 ++-
 target/riscv/vector_helper.c                  |  22 +-
 .../riscv/insn_trans/trans_privileged.c.inc   |   2 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  16 +-
 target/riscv/insn_trans/trans_rvm.c.inc       |  16 +-
 target/riscv/insn_trans/trans_rvv.c.inc       |  22 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  22 +-
 27 files changed, 644 insertions(+), 653 deletions(-)
 create mode 100644 target/riscv/csr.h

-- 
2.51.0


