Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8700C79F90
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2mqg-0004qX-BX; Sat, 05 Sep 2026 05:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqc-0004n1-L4; Sat, 05 Sep 2026 05:38:06 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x2mqY-0002d2-GQ; Sat, 05 Sep 2026 05:38:06 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowABHUT_u4ptqIsvvBg--.16071S2;
 Sat, 05 Sep 2026 17:37:51 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Subject: [PATCH 0/5] target/riscv: fix privilege, PMP, CFI, envcfg checks
Date: Sat,  5 Sep 2026 17:37:44 +0800
Message-ID: <20260905093749.491-1-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUT_u4ptqIsvvBg--.16071S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fGFyrKr15Ww1UCFy7Awb_yoW8trWfpF
 4rCay3uFZ5Ga42yr4Sya1UZF15Wrs5Ga1UXFn7Xr1Fvay5AFWFqrs3Kw43X3W8JFyDWw1a
 9Fyqkr109a4Yv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
 rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUh6p9UUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
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


