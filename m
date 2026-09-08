Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0129C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3nkh-0004jn-9L; Tue, 08 Sep 2026 00:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x3nke-0004gM-Fd; Tue, 08 Sep 2026 00:48:08 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x3nkZ-00019A-Uk; Tue, 08 Sep 2026 00:48:08 -0400
Received: from [192.168.144.1] (unknown [124.16.137.194])
 by APP-01 (Coremail) with SMTP id qwCowACnfPB7k59qBn5uBw--.61717S2;
 Tue, 08 Sep 2026 12:47:56 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,    qemu-riscv@nongnu.org
Subject: [PATCH v3 0/5] target/riscv: fix privilege, PMP, CFI, envcfg checks
Date: Tue, 08 Sep 2026 12:47:55 +0800
Message-ID: <20260908124755-v3-0-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CM-TRANSID: qwCowACnfPB7k59qBn5uBw--.61717S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xtw48XrWfJw43uw1Utrb_yoW5XF4xpF
 4rGay3urZ5KF9Fkw4fAa17ZF15Wr4rGa1UXF1DXr1Fvay5CrWFqrs3Kw45Xa48JasrWw1a
 9FyqkrnYkFyYvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
 Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
 UvcSsGvfC2KfnxnUUI43ZEXa7IU5ZAwDUUUUU==
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series fixes five independent RISC-V emulation issues in the
XTheadCmo, XTheadBb, HLVX/PMP, Zicfilp, and environment-configuration
paths.

The first two patches correct XThead instruction handling. The third
adds the missing final PMP read check for HLVX. The fourth fixes
Zicfilp exception priority for tracked misaligned JALR targets. The
fifth canonicalizes reserved CBIE encoding while preserving the
defined CBIE=11 encoding.

Each patch is independently applicable and includes its own test
description and Signed-off-by line. The corresponding public QEMU
Work Items are linked in the commit messages:

  XTheadCmo U-mode privilege:
    https://gitlab.com/qemu-project/qemu/-/work_items/4412
  XTheadBb RV32 th.srri:
    https://gitlab.com/qemu-project/qemu/-/work_items/4413
  HLVX.WU execute-only PMP:
    https://gitlab.com/qemu-project/qemu/-/work_items/4414
  Zicfilp misaligned JALR:
    https://gitlab.com/qemu-project/qemu/-/work_items/4415
  CBIE reserved encoding:
    https://gitlab.com/qemu-project/qemu/-/work_items/4416

The series is based on d2843fbf, the first parent of current upstream
master ff1d2d19. No target/riscv path changed between those commits.

Validation performed:

  - QEMU 11.1.1 baseline and patched witness replays passed.
  - Every intermediate patch state built for qemu-system-riscv32,
    qemu-system-riscv64, qemu-riscv32, and qemu-riscv64.
  - The five patches pass checkpatch.pl and get_maintainer.pl review.

Please disregard v2 of this series. I missed QEMU's guidance to send
each new revision as a new top-level thread and to carry Reviewed-by
tags into the next revision. I apologize for missing these guidelines
and for the confusion. Please forgive the mistake.

Changes since v2:

  - Resend the complete five-patch series as a fresh top-level
    revision.
  - Carry Daniel's Reviewed-by tags on patches 1, 2, and 4.
  - Keep the code unchanged; patches 3 and 5 retain the requested
    `Tested:` terminology updates.

wangyang (5):
  target/riscv: enforce XTheadCmo U-mode privilege checks
  target/riscv: mask RV32 XTheadBb th.srri shift amount
  target/riscv: require read permission for HLVX accesses
  target/riscv: prioritize Zicfilp checks for misaligned JALR
  target/riscv: canonicalize reserved CBIE encoding

 target/riscv/internals.h                      |  6 ++++
 target/riscv/tcg/cpu_helper.c                 | 24 ++++++++++-----
 target/riscv/tcg/csr.c                        | 29 +++++++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  9 +++++-
 .../riscv/tcg/insn_trans/trans_xthead.c.inc   |  5 ++--
 target/riscv/tcg/op_helper.c                  | 11 ++++---
 6 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.55.0.windows.2


