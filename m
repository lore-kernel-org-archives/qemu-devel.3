Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD75CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH1rg-0000EI-UQ; Wed, 14 Oct 2026 12:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rJ-00005U-DF; Wed, 14 Oct 2026 12:29:41 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1xH1rH-000690-6I; Wed, 14 Oct 2026 12:29:41 -0400
Received: from DESKTOP-7FLBREN (unknown [124.16.137.194])
 by APP-03 (Coremail) with SMTP id rQCowACXmDbrrc9q4kXBCg--.37629S4;
 Thu, 15 Oct 2026 00:29:32 +0800 (CST)
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 christoph.muellner@vrull.eu
Subject: [PATCH v5 0/5] target/riscv: fix privilege, PMP, CFI, envcfg checks
Date: Thu, 15 Oct 2026 00:29:25 +0800
Message-ID: <20261014162930.251-1-wangyang25@otcaix.iscas.ac.cn>
X-Mailer: git-send-email 2.55.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmDbrrc9q4kXBCg--.37629S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fGFyrKr15Ww1UXrW8Zwb_yoW8trWUpF
 4rGayaqFWkGry7Awn3AF4UXr15Wr4fGw45X3srXryrZay5CFyFqrZ3K34aga4DJ3Z8Ww12
 9F1qkw13uF15ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
 Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
 c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
 kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
 WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
 0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
 JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
 IYCTnIWIevJa73UjIFyTuYvjxUkcTQUUUUU
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

This series is based on 209b2afaface001c7d4d981e38f186afe7b24a50.

Validation performed:

  - QEMU 11.1.1 baseline and patched test-case replays passed.
  - HLVX.HU and HLVX.WU execute-only PMP cases and tracked and
    untracked misaligned JALR controls were checked.
  - Every intermediate patch state built for qemu-system-riscv32,
    qemu-system-riscv64, qemu-riscv32, and qemu-riscv64.
  - RV32 XTheadBb imm6 0, 31, 32, and 63 cases pass with the
    extension enabled and remain illegal when it is disabled.
  - The series passes checkpatch.pl, git diff --check, and
    independent apply checks.

Changes since v4:

  - Patch 2 masks the shift amount in the translator again, as
    suggested by Richard Henderson, instead of splitting the decodetree
    pattern. The original code and its Reviewed-by tag are restored.
  - Patches 3 and 5 carry the Reviewed-by tags they received during
    review of v3; both patches are byte-identical to the reviewed
    version.
  - Reword the test descriptions in the commit messages to refer to
    test cases, as requested during review.

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


