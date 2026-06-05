Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7707CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPqy-0006QW-CR; Fri, 05 Jun 2026 04:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqv-0006QA-Qu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqs-0004gJ-Vm
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:29 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxX+qwhyJqj+MQAA--.45549S3;
 Fri, 05 Jun 2026 16:24:16 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S2;
 Fri, 05 Jun 2026 16:24:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 00/14] target/loongarch: Move CSR registers to struct
 CPUSysState
Date: Fri,  5 Jun 2026 16:25:38 +0800
Message-ID: <20260605082552.175336-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1fCrykCr1UZFy3WrWUZFc_yoW5CryUpr
 yxu343KF48JrZrJF1qqa43Xas8Xr17Wa1293Wftry8Cw45ZryfuF4kJa9F9F4UJ348WFy2
 q3W8Cw4UZFWUZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8hiSPUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Here new structure CPUSysState is added in CPULoongArchState, CSR
registers are moved to CPUSysState, qemu timer will be moved to this
structure in future. With incoming LVZ supported, there will be two copied
of CSR registers, so it is simply to add CPUSysState array.

Also new field sys_state is added which points to CPUSysState at
beginning, and it can be changed during VM exit/enter entry. There is no
function change, all is code movement or variable rename.

---
v2 ... v3:
  1. Modify the spell issue in the comments.
  2. Change type as unsigned int with return value of function
     get_csr_offset().
  2. Split patch 13 into two smaller version, macro CPU_CSR_OFFSET is
     added special for user mode rdtime emulation in one patch.

v1 ... v2:
  1. Rename get_current_state with env_sys, variable name cur with sys,
     since cur/get_current_state is misleading.
  2. Add modification with files in directory linux-user/loongarch64/
---
Bibo Mao (14):
  target/loongarch: Add new field curState in CPULoongArchState
  target/loongarch: Use sys_state in cpu.c when accessing CSR registers
  target/loongarch: Use sys_state in cpu_helper.c when accessing CSR
    registers
  target/loongarch: Use sys_state in file arch_dump.c when accessing CSR
    registers
  target/loongarch: Use sys_state in kvm.c when accessing CSR registers
  target/loongarch: Use sys_state in tlb_helper.c when accessing CSR
    registers
  target/loongarch: Use sys_state in tcg_cpu.c when accessing CSR
    registers
  target/loongarch: Use sys_state in csr_helper.c when accessing CSR
    registers
  target/loongarch: Use sys_state in op_helper.c when accessing CSR
    registers
  linux-user/loongarch64: Use sys_state when accessing CSR registers
  target/loongarch: Add default CSRFL_BASIC info with flags field
  target/loongarch: Add wrapper function get_csr_offset()
  target/loongarch: Add macro CSR_OFFSET and CPU_CSR_OFFSET
  target/loongarch: Add new structure CPUSysState

 hw/intc/loongarch_dintc.c                     |   4 +-
 linux-user/loongarch64/cpu_loop.c             |   5 +-
 linux-user/loongarch64/elfload.c              |   4 +-
 linux-user/loongarch64/signal.c               |  16 +-
 target/loongarch/arch_dump.c                  |   5 +-
 target/loongarch/cpu-mmu.h                    |   4 +-
 target/loongarch/cpu.c                        | 120 ++++-----
 target/loongarch/cpu.h                        |  49 ++--
 target/loongarch/cpu_helper.c                 |  41 ++--
 target/loongarch/csr.c                        |  10 +-
 target/loongarch/csr.h                        |  10 +
 target/loongarch/gdbstub.c                    |   3 +-
 target/loongarch/kvm/kvm.c                    | 228 +++++++++---------
 target/loongarch/machine.c                    | 118 ++++-----
 target/loongarch/tcg/constant_timer.c         |  10 +-
 target/loongarch/tcg/csr_helper.c             |  55 +++--
 .../tcg/insn_trans/trans_extra.c.inc          |   6 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
 target/loongarch/tcg/op_helper.c              |  45 ++--
 target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
 target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
 21 files changed, 549 insertions(+), 444 deletions(-)


base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
-- 
2.54.0


