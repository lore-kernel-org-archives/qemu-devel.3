Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7990FC88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50Kw-0004JR-EW; Fri, 11 Sep 2026 08:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Kn-00045J-DH; Fri, 11 Sep 2026 08:26:25 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangyang25@otcaix.iscas.ac.cn>)
 id 1x50Ki-0006DB-QE; Fri, 11 Sep 2026 08:26:25 -0400
Received: from [172.21.96.1] (unknown [124.16.137.194])
 by APP-05 (Coremail) with SMTP id zQCowABHtD5k86NqyHDqBw--.17498S2;
 Fri, 11 Sep 2026 20:26:13 +0800 (CST)
Message-ID: <cover.1789125266.git.wangyang25@otcaix.iscas.ac.cn>
From: wangyang <wangyang25@otcaix.iscas.ac.cn>
Date: Fri, 11 Sep 2026 19:14:26 +0800
Subject: [PATCH v4 0/5] target/riscv: fix privilege, PMP, CFI, envcfg checks
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, qemu-riscv@nongnu.org
X-CM-TRANSID: zQCowABHtD5k86NqyHDqBw--.17498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1fGFyrKr15Ww1UXFW5ZFb_yoW8try7pF
 4rCay3XFWkGr93Aw1aya17XFy5Wr4fWw4UXF9FqryrZay5CrWrXrZ3K3y3Ka4DAF9xWr12
 9F1jkw13uF15AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
 82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
 Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF
 7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
 IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
 MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
 WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
 6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
 BIdaVFxhVjvjDU0xZFpf9x07bw5lnUUUUU=
X-Originating-IP: [124.16.137.194]
X-CM-SenderInfo: 5zdqw5xdqjjk46rwut1l0ox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=wangyang25@otcaix.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

This series is based on 209b2afaface001c7d4d981e38f186afe7b24a50,
the current upstream master.

Validation performed:

  - QEMU 11.1.1 baseline and patched test-case replays passed.
  - HLVX.HU and HLVX.WU execute-only PMP cases and tracked and
    untracked misaligned JALR controls were checked.
  - Every intermediate patch state built for qemu-system-riscv32,
    qemu-system-riscv64, qemu-riscv32, and qemu-riscv64.
  - RV32 XTheadBb imm6 0, 31, 32, and 63 cases pass with the
    extension enabled and remain illegal when it is disabled.
  - The v4 series passes checkpatch.pl, git diff --check, and
    independent apply checks.

Changes since v3:

  - Patch 2 now decodes the RV32 form with @sh5 and the RV64 form with
    @sh6, as suggested by Chao Liu, and adds a dedicated RV32
    translator.
  - The runtime shift-amount mask and the old Reviewed-by tag were
    removed from patch 2; unchanged reviewed patches retain their
    existing Reviewed-by tags.
  - Resend the complete series as a fresh v4 top-level thread.

wangyang (5):
  target/riscv: enforce XTheadCmo U-mode privilege checks
  target/riscv: decode RV32 XTheadBb th.srri shift amount
  target/riscv: require read permission for HLVX accesses
  target/riscv: prioritize Zicfilp checks for misaligned JALR
  target/riscv: canonicalize reserved CBIE encoding

 target/riscv/internals.h                      |  6 ++++
 target/riscv/tcg/cpu_helper.c                 | 24 ++++++++++-----
 target/riscv/tcg/csr.c                        | 29 +++++++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  9 +++++-
 .../riscv/tcg/insn_trans/trans_xthead.c.inc   | 12 ++++++--
 target/riscv/tcg/op_helper.c                  | 11 ++++---
 target/riscv/xthead.decode                    |  5 +++-
 7 files changed, 78 insertions(+), 18 deletions(-)

-- 
2.55.0.windows.2


