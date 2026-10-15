Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDEFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLl3-0008A9-J9; Thu, 15 Oct 2026 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLl1-00089l-1N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:44:31 -0400
Received: from va-2-112.ptr.blmpb.com ([209.127.231.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1xHLkw-0008QB-RB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792071855; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TmXDFpuCXS7xhoAYMlnofimPCuP5Boi38+8AWaFhTcc=;
 b=KCMRYhYPMnynY7yYBntxY+1PCHJAfAge2TgmxiD6JAWmMGpqlpQv1vuUNILHUDJlw/3sRU
 X1V6hHdLSv1GigPoGCdHRjgA+tZY2XRkb9vWvxVJ/Ldzpd4VOUB7VEErKCCihHE55xlQyM
 6iLSXXA/YFqD1kfw3RXYSgv1ljgGwgO6jIzBVI6enursNUTH96KFeUu33jRnhKnqNDiUFJ
 kVhNxSYlg7I0EjWpZUjI++BRv1FDVSIynyDO1yIfHF22sbAKUjlr56WASQM4e+a+z/Z3ae
 H5Z2a3MxjBlEJ27Sc3wUBXyhXEO9S8i9U/yHMSjJe7JpgkoeS2veL16pvzNtlA==
X-Original-From: Mingliang Liu <liumingliang.dev@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <daniel.barboza@oss.qualcomm.com>, 
 <chao.liu@processmission.com>, <richard.henderson@linaro.org>, 
 "Mingliang Liu" <liumingliang.dev@bytedance.com>
Date: Thu, 15 Oct 2026 21:43:34 +0800
Mime-Version: 1.0
Subject: [PATCH v4 0/3] target/riscv: Add experimental Zvabd extension support
Message-Id: <20261015134337.3354723-1-liumingliang.dev@bytedance.com>
To: <qemu-devel@nongnu.org>
X-Mailer: git-send-email 2.39.5
From: "Mingliang Liu" <liumingliang.dev@bytedance.com>
X-Lms-Return-Path: <lba+26ad0d8ad+47a911+nongnu.org+liumingliang.dev@bytedance.com>
Received-SPF: pass client-ip=209.127.231.112;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-2-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series adds support for version 0.9 of the draft RISC-V Zvabd
extension. The extension provides vector integer absolute-difference
instructions for image, video, and other data-processing workloads.
It introduces eight new instructions:

  - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
    8 through ELEN, with SEW 64 requiring Zve64x.
  - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
    and 16 and accumulate into a double-width destination.

The specification is currently under review at:
https://github.com/riscv/riscv-isa-manual/pull/3279

The series implements this instruction extension, including instruction
decoder, TCG translation, helpers, and tests.

Changes in v2:
  - Added support for recognizing the vabs.v pseudo-instruction in the
    disassembler.
  - Added tests for the eight Zvabd instructions based on Daniel's tests.

Changes in v3:
  - Order the switch cases numerically in patch 1.
  - Use .insn instead of .word to encode instructions in patch 3.
  - Refine the commit messages for patches 1 and 3.

Changes in v4:
  - Fix the conflict in patch 3/3 encountered during the PULL stage
    by building `tests/tcg/riscv64/test-zvabd.S` with Meson instead
    of Make.

Mingliang Liu (2):
  disas/riscv: Support vabs.v pseudo-instruction
  tests/tcg/riscv64: Add Zvabd extension tests

Zhibo Hong (1):
  target/riscv: Add support for the Zvabd extension

 disas/riscv-op.c.inc                        |   9 +
 disas/riscv.c                               |  14 +
 target/riscv/cpu.c                          |   1 +
 target/riscv/cpu_cfg_fields.h.inc           |   1 +
 target/riscv/helper.h                       |  26 +
 target/riscv/insn32.decode                  |  10 +
 target/riscv/tcg/insn_trans/trans_rvv.c.inc |  45 ++
 target/riscv/tcg/tcg-cpu.c                  |   6 +
 target/riscv/tcg/vector_helper.c            |  56 ++
 tests/tcg/riscv64/system/meson.build        |   1 +
 tests/tcg/riscv64/test-zvabd.S              | 659 ++++++++++++++++++++
 11 files changed, 828 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zvabd.S

-- 
2.39.5

