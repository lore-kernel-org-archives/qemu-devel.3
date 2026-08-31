Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E734BC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x125s-0006Ma-Gr; Mon, 31 Aug 2026 09:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1x125q-0006L1-AP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:30:34 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liumingliang.dev@bytedance.com>)
 id 1x125n-00084K-Ja
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788183019; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6i4pwkRLbFmq2zEgQqOHRQZhbm5KLyeVDQucYgNdsgg=;
 b=pavFGdIGJvDCFMQZC4dLON8fQSEm2P2TfTESFLsZdvoYpUN+lLuk7fCBI9EPH65aEcG4j9
 oPJfFBAXg6vxTcX++I01KgPnODBiZc8ZAP+9IluZQC4ZfYE8emku8roA9mqkrbjUnZ/uNe
 004p5jaVkcPZDls6BLben796Vl+7Pu+NXYJg20crdrrqkW5vobsnz+nfrx+9Hjcyc6e4W0
 3+qWpC1cBxs6iUgV0gZ7Uqa6Yv7+wwLPF1xOv7Z9qGkQNMWq2iL9uJ3b6y2cOK5WoZ2Zwt
 Uolm6d0PHqZ78p0B7XoWRgcyLff+wuIDXXXNd4ZpydlP7mXt5TCUFhjG/miH1g==
Mime-Version: 1.0
X-Original-From: Mingliang Liu <liumingliang.dev@bytedance.com>
X-Lms-Return-Path: <lba+26a9581e9+521c6f+nongnu.org+liumingliang.dev@bytedance.com>
Cc: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, 
 <Alistair.Francis@wdc.com>, <zhiwei_liu@linux.alibaba.com>, 
 <liwei1518@gmail.com>, <daniel.barboza@oss.qualcomm.com>, 
 <chao.liu@processmission.com>, 
 "Mingliang Liu" <liumingliang.dev@bytedance.com>
From: "Mingliang Liu" <liumingliang.dev@bytedance.com>
Date: Mon, 31 Aug 2026 21:29:57 +0800
Message-Id: <20260831133000.982059-1-liumingliang.dev@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/3] target/riscv: Add experimental Zvabd extension support
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.39.5
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=liumingliang.dev@bytedance.com; helo=va-1-111.ptr.blmpb.com
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

The draft Zvabd extension provides vector integer absolute-difference
operations for image, video, and other data-processing workloads. It
introduces eight new instructions:

  - vabd.vv, vabd.vx, vabdu.vv, and vabdu.vx support SEW values from
    8 through ELEN, with SEW 64 requiring Zve64x.
  - vwabda.vv, vwabda.vx, vwabdau.vv, and vwabdau.vx support SEW 8
    and 16 and accumulate into a double-width destination.

The specification is under review at:
https://github.com/riscv/riscv-isa-manual/pull/3279

These patch implement this instruction extension, including instruction
decoder, TCG translation, helpers, and tests, etc.

After the first review, this patch has been updated as follows:
  - Added support for recognizing the vabs.v pseudo-instruction in the disassembler.
  - Added tests for the eight Zvabd instructions based on Daniel's tests.

Mingliang Liu (2):
  disas/riscv: Support vabs.v pseudo-instruction
  tests/tcg/riscv64: Add tests for Zvabd extension

Zhibo Hong (1):
  target/riscv: Add experimental Zvabd extension support

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

