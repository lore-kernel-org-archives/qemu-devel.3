Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE23C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bDY-0000fs-No; Mon, 07 Sep 2026 11:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1x3bDT-0000en-AU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:25:03 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1x3bDP-00056R-2W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788794685; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=X1smG7YZrVv8w/+73atNrtl4NI3HBJ0T1S6dqZmUak8=;
 b=FxP1NkYEhc4Zw/lJA0QJh9wp4PQsXG1lOxzb/FwVQMPD3m/S90Fm3FXMzQuWPHVieOAx5+
 D4uPxqdZgIBWnf5SAoBS4kgVAIGWmT8UO8HCcTGCeb/mgtqPwWP7uXQnQvDPvdJKJF6QHa
 a+qD/i0nZWIGmRU77RKWREfb5jFlqgjVumWE2r7KnhWih2krr/QtlgkYfY4cOPfBWSa3wD
 4rVtiXb6VypoYDnTsMVl8NnizFlqqu5ElJKBgr+4stqAxSeH+GoKjw4AH5Xk7eZIpoCZt/
 XK4AZZShA2C4/YZo0Qohz3TNvKLSdYP1wv+Z2eMjbG3t3+jCcODPYP6dEZwpkQ==
Date: Mon,  7 Sep 2026 23:22:58 +0800
Mime-Version: 1.0
X-Original-From: Mingliang Liu <liumingliang.dev@bytedance.com>
Subject: [PATCH v3 0/3] target/riscv: Add experimental Zvabd extension support
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <daniel.barboza@oss.qualcomm.com>, 
 <chao.liu@processmission.com>, 
 "Mingliang Liu" <liumingliang.dev@bytedance.com>
From: "Mingliang Liu" <liumingliang.dev@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Message-Id: <20260907152301.1701394-1-liumingliang.dev@bytedance.com>
X-Lms-Return-Path: <lba+26a9ed73b+da0120+nongnu.org+liumingliang.dev@bytedance.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-1-113.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The series implement this instruction extension, including instruction
decoder, TCG translation, helpers, and tests, etc.

Changes in v1:
  - Added support for recognizing the vabs.v pseudo-instruction in the disassembler.
  - Added tests for the eight Zvabd instructions based on Daniel's tests.

Changes in v2:
  - Order the switch cases numerically in patch 1.
  - Use .insn instead of .word to encode instructions in patch 3.
  - Refine the commit messages for patches 1 and 3.

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
 tests/tcg/riscv64/Makefile.softmmu-target   |   8 +
 tests/tcg/riscv64/test-zvabd.S              | 659 ++++++++++++++++++++
 11 files changed, 835 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-zvabd.S

-- 
2.39.5

