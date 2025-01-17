Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AAFC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1n-0003uJ-E5; Fri, 17 Jan 2025 13:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1l-0003tM-B1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:05 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1f-0007dW-VI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2164b1f05caso48356245ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138298; x=1737743098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rxtMmVi5kjzcY9X+bWQhblsXEQtu85y4HNCflmegC7M=;
 b=FBxHk5qvmtzTgapRf9KEh98LclgK0Qt5RSBRHoOfXI+GAqMDL2pcW+T45a8AhuqALC
 jKjSCr2PcKvYXTlRtL0a4sQlLUze7/JC5k9/X12gmRkprkBvzkw3Bi2rdyaEM8YBPHcx
 xhKq6w61lMtB07kXdA4EOhC0Eput/835Qo0M76103zaD1ENSYCcw3Q/7mf4L5iHV+FO1
 h56MrVoQ1yfGqQ5oVROV3SGJVvo8iO8vsjb4Chcvgr/NVNzmN7Wu4Xx0ajXsEqJZqitl
 Bua1l2hIRHbXqpoCB3coQiHskMF20YTXCcO52wM00lMxC59S6MNVFIwjpeaWffiDYMOL
 u2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138298; x=1737743098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxtMmVi5kjzcY9X+bWQhblsXEQtu85y4HNCflmegC7M=;
 b=u5wjZGeYjqFE124Yli1kxZFmn2DnH5Hfddnf8dWaXhdKga0ccjcC/G594a7paxKQgf
 d/TkjBzitqzFQP9XvpEf/KIYA5zT9ttgBKtFy+9XJ/TQQSTxYOe9RJ7T9FnOsnMLYKfA
 cf69QOaGVGoHwSFXVRzUVMYufgATFWBlcvdcMhSTd6/7GobA695bqS2BeayR3BODiGNM
 JVLB5u7gBS5wTfYdJrv9XCyLawmH4151eTu6KqvQfPLtqjHeV6D0NJGT+c/xjMiljBp7
 d4i39gjJiUxIFpND3ZV///oo0T5SCOhkYLJ0LuKP7e9ZDwwEGPs9wnIY4izSx1UVFhys
 bzBA==
X-Gm-Message-State: AOJu0YxFssEq4XiSEE/V6CbPSTvRbj4lZNMoK7IP10/9mBOJS5OA/ll8
 PbDFGgONEb1PJtiSa4CRJWgng5B8qvogJJBq4ZfiNLJZ8yRKPR0vERRdRKbU7vZG4RK+57Qw2wx
 p
X-Gm-Gg: ASbGnctonVQLYEMBhFn5iKqCgyPosPauLpmN+9SZqX5urpmndus96tsR/9Fd+bQswp3
 ytC9Uco9ugkZOne5icDN8HLOvuFIXsavdi7m/O4nWsLnJBIcaiU213i2JAzwU89/EqyOsdUgmJJ
 nnoFAmm9eavrVsggcMnVxqdLqYhPBnFF/A4uaC7LqnA/dIRgJKJ4RolBzNR5FQn3q1uabC7eaPG
 daOEUiAtfJX++MZtoiq8tFXfBg2R2/eKmdOt6a3wgL3B/6xbJ0iQ3/uPpfXwhkg+82QEGKh7JXp
 QVqKyfPlpcrVTdY=
X-Google-Smtp-Source: AGHT+IHXUtTOy5+rT5QZWXOmCA7LRQX2EwaHcewIMeUjOpnNfP6DovOJ0KMQez2b3mkZKOYFEf/t3Q==
X-Received: by 2002:a17:902:da88:b0:216:69ca:773b with SMTP id
 d9443c01a7336-21c352c7b99mr60299245ad.5.1737138298094; 
 Fri, 17 Jan 2025 10:24:58 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.24.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:24:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/68] tcg patch queue
Date: Fri, 17 Jan 2025 10:23:48 -0800
Message-ID: <20250117182456.2077110-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Note that I have refreshed the expiry of my public key.
and pushed to keys.openpgp.org.


r~


The following changes since commit 4d5d933bbc7cc52f6cc6b9021f91fa06266222d5:

  Merge tag 'pull-xenfv-20250116' of git://git.infradead.org/users/dwmw2/qemu into staging (2025-01-16 09:03:43 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250117

for you to fetch changes up to db1649823d4f27b924a5aa5f9e0111457accb798:

  softfloat: Constify helpers returning float_status field (2025-01-17 08:29:25 -0800)

----------------------------------------------------------------
tcg:
  - Add TCGOP_TYPE, TCGOP_FLAGS.
  - Pass type and flags to tcg_op_supported, tcg_target_op_def.
  - Split out tcg-target-has.h and unexport from tcg.h.
  - Reorg constraint processing; constify TCGOpDef.
  - Make extract, sextract, deposit opcodes mandatory.
  - Merge ext{8,16,32}{s,u} opcodes into {s}extract.
tcg/mips: Expand bswap unconditionally
tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
tcg/riscv: Use BEXTI for single-bit extractions
tcg/sparc64: Use SRA, SRL for {s}extract_i64

disas/riscv: Guard dec->cfg dereference for host disassemble
util/cpuinfo-riscv: Detect Zbs
accel/tcg: Call tcg_tb_insert() for one-insn TBs
linux-user: Add missing /proc/cpuinfo fields for sparc

----------------------------------------------------------------
Helge Deller (1):
      linux-user: Add missing /proc/cpuinfo fields for sparc

Ilya Leoshkevich (2):
      tcg: Document tb_lookup() and tcg_tb_lookup()
      accel/tcg: Call tcg_tb_insert() for one-insn TBs

LIU Zhiwei (1):
      disas/riscv: Guard dec->cfg dereference for host disassemble

Philippe Mathieu-Daudé (1):
      softfloat: Constify helpers returning float_status field

Richard Henderson (63):
      tcg: Move call abi parameters from tcg-target.h to tcg-target.c.inc
      tcg: Replace TCGOP_VECL with TCGOP_TYPE
      tcg: Move tcg_op_insert_{after,before} decls to tcg-internal.h
      tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}
      tcg: Add TCGOP_FLAGS
      tcg: Add type and flags arguments to tcg_op_supported
      target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
      target/arm: Use tcg_op_supported
      target/tricore: Use tcg_op_supported
      tcg: Add tcg_op_deposit_valid
      target/i386: Remove TCG_TARGET_extract_tl_valid
      target/i386: Use tcg_op_deposit_valid
      target/i386: Use tcg_op_supported
      tcg: Remove TCG_TARGET_NEED_LDST_LABELS and TCG_TARGET_NEED_POOL_LABELS
      tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
      tcg/tci: Move TCI specific opcodes to tcg-target-opc.h.inc
      tcg: Move fallback tcg_can_emit_vec_op out of line
      tcg/ppc: Remove TCGPowerISA enum
      tcg: Extract default TCG_TARGET_HAS_foo definitions to 'tcg-has.h'
      tcg/aarch64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/arm: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/i386: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/loongarch64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/mips: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/ppc: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/riscv: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/s390x: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/sparc64: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg/tci: Extract TCG_TARGET_HAS_foo defs to 'tcg-target-has.h'
      tcg: Include 'tcg-target-has.h' once in 'tcg-has.h'
      tcg: Only include 'tcg-has.h' when necessary
      tcg: Split out tcg-target-mo.h
      tcg: Use C_NotImplemented in tcg_target_op_def
      tcg: Change have_vec to has_type in tcg_op_supported
      tcg: Reorg process_op_defs
      tcg: Remove args_ct from TCGOpDef
      tcg: Constify tcg_op_defs
      tcg: Validate op supported in opcode_args_ct
      tcg: Add TCG_OPF_NOT_PRESENT to opcodes without inputs or outputs
      tcg: Pass type and flags to tcg_target_op_def
      tcg: Add TCGType argument to tcg_out_op
      tcg: Remove TCG_OPF_64BIT
      tcg: Drop implementation checks from tcg-opc.h
      tcg: Replace IMPLVEC with TCG_OPF_VECTOR
      tcg/mips: Expand bswap unconditionally
      tcg/i386: Handle all 8-bit extensions for i686
      tcg/i386: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
      tcg/aarch64: Expand extract with offset 0 with andi
      tcg/arm: Add full [US]XT[BH] into {s}extract
      tcg/loongarch64: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/mips: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/ppc: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/riscv64: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
      tcg/s390x: Fold the ext{8,16,32}[us] cases into {s}extract
      tcg/sparc64: Use SRA, SRL for {s}extract_i64
      tcg/tci: Provide TCG_TARGET_{s}extract_valid
      tcg/tci: Remove assertions for deposit and extract
      tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
      tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
      util/cpuinfo-riscv: Detect Zbs
      tcg/riscv: Use BEXTI for single-bit extractions

 accel/tcg/internal-target.h                        |   1 +
 host/include/riscv/host/cpuinfo.h                  |   5 +-
 include/fpu/softfloat-helpers.h                    |  25 +-
 include/tcg/tcg-opc.h                              | 355 +++++-------
 include/tcg/tcg.h                                  | 187 ++----
 linux-user/sparc/target_proc.h                     |  20 +-
 tcg/aarch64/tcg-target-has.h                       | 117 ++++
 tcg/aarch64/tcg-target-mo.h                        |  12 +
 tcg/aarch64/tcg-target.h                           | 126 ----
 tcg/arm/tcg-target-has.h                           | 100 ++++
 tcg/arm/tcg-target-mo.h                            |  13 +
 tcg/arm/tcg-target.h                               |  86 ---
 tcg/i386/tcg-target-has.h                          | 169 ++++++
 tcg/i386/tcg-target-mo.h                           |  19 +
 tcg/i386/tcg-target.h                              | 162 ------
 tcg/loongarch64/tcg-target-has.h                   | 119 ++++
 tcg/loongarch64/tcg-target-mo.h                    |  12 +
 tcg/loongarch64/tcg-target.h                       | 115 ----
 tcg/mips/tcg-target-has.h                          | 135 +++++
 tcg/mips/tcg-target-mo.h                           |  13 +
 tcg/mips/tcg-target.h                              | 130 -----
 tcg/ppc/tcg-target-has.h                           | 131 +++++
 tcg/ppc/tcg-target-mo.h                            |  12 +
 tcg/ppc/tcg-target.h                               | 126 ----
 tcg/riscv/tcg-target-has.h                         | 135 +++++
 tcg/riscv/tcg-target-mo.h                          |  12 +
 tcg/riscv/tcg-target.h                             | 116 ----
 tcg/s390x/tcg-target-has.h                         | 137 +++++
 tcg/s390x/tcg-target-mo.h                          |  12 +
 tcg/s390x/tcg-target.h                             | 126 ----
 tcg/sparc64/tcg-target-has.h                       |  87 +++
 tcg/sparc64/tcg-target-mo.h                        |  12 +
 tcg/sparc64/tcg-target.h                           |  91 ---
 tcg/tcg-has.h                                      | 101 ++++
 tcg/tcg-internal.h                                 |  18 +-
 tcg/tci/tcg-target-has.h                           |  81 +++
 tcg/tci/tcg-target-mo.h                            |  17 +
 tcg/tci/tcg-target.h                               |  94 ---
 accel/tcg/cpu-exec.c                               |  15 +-
 accel/tcg/translate-all.c                          |  29 +-
 disas/riscv.c                                      |  23 +-
 target/arm/tcg/translate-a64.c                     |  10 +-
 target/arm/tcg/translate-sve.c                     |  22 +-
 target/arm/tcg/translate.c                         |   2 +-
 target/tricore/translate.c                         |   4 +-
 tcg/optimize.c                                     |  27 +-
 tcg/tcg-common.c                                   |   5 +-
 tcg/tcg-op-gvec.c                                  |   1 +
 tcg/tcg-op-ldst.c                                  |  29 +-
 tcg/tcg-op-vec.c                                   |   9 +-
 tcg/tcg-op.c                                       | 149 ++---
 tcg/tcg.c                                          | 643 ++++++++++++++-------
 tcg/tci.c                                          |  13 +-
 util/cpuinfo-riscv.c                               |  18 +-
 docs/devel/tcg-ops.rst                             |  15 +-
 target/i386/tcg/emit.c.inc                         |  14 +-
 .../{tcg-target.opc.h => tcg-target-opc.h.inc}     |   4 +-
 tcg/aarch64/tcg-target.c.inc                       |  33 +-
 tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} |   6 +-
 tcg/arm/tcg-target.c.inc                           |  71 ++-
 .../{tcg-target.opc.h => tcg-target-opc.h.inc}     |  22 +-
 tcg/i386/tcg-target.c.inc                          | 121 +++-
 .../{tcg-target.opc.h => tcg-target-opc.h.inc}     |   0
 tcg/loongarch64/tcg-target.c.inc                   |  59 +-
 tcg/mips/tcg-target-opc.h.inc                      |   1 +
 tcg/mips/tcg-target.c.inc                          |  55 +-
 tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} |  12 +-
 tcg/ppc/tcg-target.c.inc                           |  39 +-
 .../{tcg-target.opc.h => tcg-target-opc.h.inc}     |   0
 tcg/riscv/tcg-target.c.inc                         |  66 ++-
 .../{tcg-target.opc.h => tcg-target-opc.h.inc}     |   6 +-
 tcg/s390x/tcg-target.c.inc                         |  59 +-
 tcg/sparc64/tcg-target-opc.h.inc                   |   1 +
 tcg/sparc64/tcg-target.c.inc                       |  29 +-
 tcg/tcg-ldst.c.inc                                 |  65 ---
 tcg/tcg-pool.c.inc                                 | 162 ------
 tcg/tci/tcg-target-opc.h.inc                       |   4 +
 tcg/tci/tcg-target.c.inc                           |  53 +-
 78 files changed, 2856 insertions(+), 2269 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h
 create mode 100644 tcg/aarch64/tcg-target-mo.h
 create mode 100644 tcg/arm/tcg-target-has.h
 create mode 100644 tcg/arm/tcg-target-mo.h
 create mode 100644 tcg/i386/tcg-target-has.h
 create mode 100644 tcg/i386/tcg-target-mo.h
 create mode 100644 tcg/loongarch64/tcg-target-has.h
 create mode 100644 tcg/loongarch64/tcg-target-mo.h
 create mode 100644 tcg/mips/tcg-target-has.h
 create mode 100644 tcg/mips/tcg-target-mo.h
 create mode 100644 tcg/ppc/tcg-target-has.h
 create mode 100644 tcg/ppc/tcg-target-mo.h
 create mode 100644 tcg/riscv/tcg-target-has.h
 create mode 100644 tcg/riscv/tcg-target-mo.h
 create mode 100644 tcg/s390x/tcg-target-has.h
 create mode 100644 tcg/s390x/tcg-target-mo.h
 create mode 100644 tcg/sparc64/tcg-target-has.h
 create mode 100644 tcg/sparc64/tcg-target-mo.h
 create mode 100644 tcg/tcg-has.h
 create mode 100644 tcg/tci/tcg-target-has.h
 create mode 100644 tcg/tci/tcg-target-mo.h
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (82%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (72%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (83%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 delete mode 100644 tcg/tcg-ldst.c.inc
 delete mode 100644 tcg/tcg-pool.c.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

