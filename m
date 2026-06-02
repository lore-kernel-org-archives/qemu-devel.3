Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0CACD6E55
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFMu-0005hl-Nz; Mon, 01 Jun 2026 23:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wUFMt-0005hE-6s
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:00:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wUFMq-0002GJ-5q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:00:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxVXhORx5qeJUPAA--.18778S3;
 Tue, 02 Jun 2026 11:00:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxacFNRx5q5tqYAA--.13886S2;
 Tue, 02 Jun 2026 11:00:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 00/13] target/loongarch: Move CSR registers to struct
 CPUSysState
Date: Tue,  2 Jun 2026 11:00:16 +0800
Message-Id: <20260602030029.1476299-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxacFNRx5q5tqYAA--.13886S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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
v1 ... v2:
  1. Rename get_current_state with env_sys, variable name cur with sys,
     since cur/get_current_state is misleading.
  2. Add modification with files in directory linux-user/loongarch64/
---
Bibo Mao (13):
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
 target/loongarch/csr.h                        |   5 +
 target/loongarch/gdbstub.c                    |   3 +-
 target/loongarch/kvm/kvm.c                    | 228 +++++++++---------
 target/loongarch/machine.c                    | 118 ++++-----
 target/loongarch/tcg/constant_timer.c         |  10 +-
 target/loongarch/tcg/csr_helper.c             |  55 +++--
 .../tcg/insn_trans/trans_extra.c.inc          |   4 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
 target/loongarch/tcg/op_helper.c              |  45 ++--
 target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
 target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
 21 files changed, 542 insertions(+), 444 deletions(-)


base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
-- 
2.39.3


