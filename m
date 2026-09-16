Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F1DC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jka-0005cb-NI; Wed, 16 Sep 2026 03:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkX-0005bj-KE; Wed, 16 Sep 2026 03:08:09 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1x6jkT-0008Ic-GR; Wed, 16 Sep 2026 03:08:09 -0400
Received: from xiaoou-ubuntu-02.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowACXaOxHQKpq3zYkCA--.4143S2;
 Wed, 16 Sep 2026 15:07:51 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Yin Zhang <zhangyin2018@iscas.ac.cn>,
 Dajun Huang <djhuang_1@std.uestc.edu.cn>,
 Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
Subject: [PATCH v3 00/19] target/riscv: Add support for RISC-V P extension
Date: Wed, 16 Sep 2026 07:07:02 +0000
Message-Id: <20260916070721.3279229-1-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACXaOxHQKpq3zYkCA--.4143S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW7WFy5uF13Jr1UWw4kWFg_yoW3AFW3pF
 Z3G34YyayktFWIqw1ftw48Cr15WF4rWa15C3WxXw10vwsxtryftFnFkw4jkFn8JF1kWw12
 9FnFkr15uF4UAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
 5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72
 CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
 M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
 8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
 wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
 v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
 Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUJHUDUUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.74,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

This series adds support for the RISC-V Packed SIMD (P) extension for
RV32 and RV64.

The P extension defines packed-SIMD fixed-point operations intended for
DSP workloads such as multimedia and signal processing. These
instructions operate on packed subword elements in general-purpose
registers, with register-pair forms for wider operands on RV32.

The implementation targets the V0.21 development draft of the RISC-V P
extension specification:

  https://github.com/riscv/riscv-p-spec

The local riscv-p-spec reference checkout is at commit:

  71b78d2c8d1d41cc01a036d75dc001920b8ac22e

P support is enabled with the experimental x-p CPU property. The series
includes instruction decoding and translation, helpers, extension-state
handling, and the specification-defined control of vxsat. The focus
remains functional correctness and instruction coverage; performance
optimization is left for future work.

This revision adds in-tree TCG tests for RV32 and RV64 and addresses the
review feedback on helper reuse, register overlap, shift semantics, and
code readability. It also fixes additional issues found while testing,
including zero register-pair handling and RV64 SHLR rounding.

Thanks to Daniel Henrique Barboza, Nutty Liu, Chao Liu, and Max Chou for
their reviews and suggestions.

Changes in v3:

  - Add descriptive commit messages explaining the purpose and behavior
    of the patches, and document helper macro definitions, including
    their interfaces and arithmetic semantics.

  - Add RV32 and RV64 assembly tests under tests/tcg/riscv, with shared
    test macros and integration into the TCG test Makefiles. Cover
    arithmetic, shifts, multiplication, narrowing, saturation, register
    overlap, and zero register-pair operands. The tests are freestanding
    Linux-user programs and do not require a target libc. Set PSIMD_CC
    to a P-capable Clang to build them; the assembler options use
    rv32gp0p21 and rv64gp0p21. Enable previously disabled tests using the
    P v0.21 mnemonics and update signed saturation immediate operands.

  - Correct register-controlled packed byte and halfword shifts to use
    the low five bits of rs2. Share the signed saturating/rounding shift
    implementation between scalar and packed forms: psshar_hs,
    psshar_ws, and sshar are all generated by GEN_PSIMD_VAR_SSHAR.
    Return zero for oversized SSHAR/SHAR right shifts, and widen
    rounding arithmetic before adding the rounding bit.

  - Clamp unsigned rounding right shifts to the element width so that
    the source MSB still participates in rounding for oversized shifts.
    Apply this to PSSHLR/SSHLR and RV64 SHLR. Use a wider intermediate
    for SHLR to preserve the carry when rounding UINT64_MAX right by
    one bit, and add regression tests for these cases.

  - Fix RV32 register-pair operations when the destination overlaps
    the scalar source by completing both results before writeback.
    Treat a zero register-pair selector as {x0, x0}, suppress both
    destination writes for a zero pair, and preserve vxsat side effects.
    Use tcg_gen_movi_i64() to initialize a zero source in narrowing
    translations, with a dedicated regression test.

  - Avoid undefined behavior in helper arithmetic by using unsigned
    operations where wraparound is intended and wider intermediates
    where needed. Handle oversized left shifts explicitly and handle
    zero shifts in SLX/SRX without shifting by the operand width.

  - Correct the RV32 REV encoding, reject unavailable translations
    instead of accepting them without an operation, and fix lane
    selection in PMQWACC.H and PMQRWACC.H.

  - Reuse qemu/bitops.h extract64() for lane extraction, correct
    misleading helper comments, and align macro continuation characters.

Testing:

  The P extension TCG tests were built with LLVM/Clang 24.0.0git
  (/opt/llvm/bin/clang), llvm-project commit:

    96295a1412f9afbee9d4a3c2701e83f5a529a9cc

  Built qemu-riscv32, qemu-riscv64, qemu-system-riscv32, and
  qemu-system-riscv64 successfully. Both P extension TCG suites pass
  with the new regression cases:

    make -C build/tests/tcg/riscv32-linux-user \
        PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv32
    make -C build/tests/tcg/riscv64-linux-user \
        PSIMD_CC=/opt/llvm/bin/clang run-psimd-rv64

  The test targets enable x-p, zmmul, zba, and zbb on the corresponding
  rv32 or rv64 CPU. The P-aware compiler path is configurable through
  PSIMD_CC.

Changes in v2:

  - Refactored translation and helper code using macros for common
    implementation patterns.
  - Consolidated P extension prerequisite checks in
    riscv_cpu_validate_p().
  - Removed the Zbkb dependency to match the specification.
  - Added the specification-defined vxsat control mechanism.

Previous versions:

  v2: https://lists.nongnu.org/archive/html/qemu-riscv/2026-07/msg00697.html
  v1: https://lists.nongnu.org/archive/html/qemu-riscv/2026-04/msg00301.html

Feedback on the implementation and tests would be appreciated.

Co-authored-by: Yin Zhang <zhangyin2018@iscas.ac.cn>
Co-authored-by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
Co-authored-by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>

Molly Chen (19):
  target/riscv: Add packed SIMD extension state
  target/riscv: Add packed SIMD helper framework
  target/riscv: Add packed SIMD arithmetic instructions
  target/riscv: Add packed SIMD averaging and rounding instructions
  target/riscv: Add packed SIMD absolute, difference, compare and mask
    instructions
  target/riscv: Add packed SIMD shift instructions
  target/riscv: Add packed SIMD exchange instructions
  target/riscv: Add packed SIMD horizontal reduction instructions
  target/riscv: Add packed SIMD pack, merge and count-leading
    instructions
  target/riscv: Add packed SIMD pure multiplication instructions
  target/riscv: Add packed SIMD multiply-accumulate instructions
  target/riscv: Add packed SIMD Q-format multiplication instructions
  target/riscv: Add packed SIMD Q-format MAC instructions
  target/riscv: Add packed SIMD two-way multiply-add/subtract
    instructions
  target/riscv: Add packed SIMD four-way multiply-add instructions
  target/riscv: Add packed SIMD load-replicate instructions
  target/riscv: Add packed SIMD RV32 only instructions
  target/riscv: Remove Zbkb dependency from P extension to align with
    the spec
  tests/tcg/riscv: Add tests for the P extension

 target/riscv/cpu.c                          |    5 +-
 target/riscv/cpu.h                          |    8 +
 target/riscv/cpu_bits.h                     |    2 +
 target/riscv/helper.h                       |  529 +++
 target/riscv/insn32.decode                  |  830 +++++
 target/riscv/machine.c                      |   19 +
 target/riscv/tcg/csr.c                      |   39 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc |    4 +-
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 1439 ++++++++
 target/riscv/tcg/meson.build                |    3 +-
 target/riscv/tcg/psimd_helper.c             | 3536 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |   46 +
 target/riscv/tcg/translate.c                |    6 +
 tests/tcg/riscv/psimd-common.S              | 1105 ++++++
 tests/tcg/riscv/psimd-rv32.S                | 1256 +++++++
 tests/tcg/riscv/psimd-rv64.S                |  578 +++
 tests/tcg/riscv/psimd-test-macros.inc       |  952 +++++
 tests/tcg/riscv32/Makefile.target           |   30 +
 tests/tcg/riscv64/Makefile.target           |   25 +
 19 files changed, 10406 insertions(+), 6 deletions(-)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc
 create mode 100644 target/riscv/tcg/psimd_helper.c
 create mode 100644 tests/tcg/riscv/psimd-common.S
 create mode 100644 tests/tcg/riscv/psimd-rv32.S
 create mode 100644 tests/tcg/riscv/psimd-rv64.S
 create mode 100644 tests/tcg/riscv/psimd-test-macros.inc
 create mode 100644 tests/tcg/riscv32/Makefile.target


base-commit: b23a62773a7856299cbb3782e64968b6a92c792f
-- 
2.34.1


