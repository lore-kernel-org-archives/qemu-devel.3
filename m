Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C96CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 06:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRlci-0002Gk-Mx; Tue, 26 May 2026 02:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wRlcb-0002Ft-Cw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wRlcV-0000Z4-FA
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxVumxQhVqTkwNAA--.32145S3;
 Tue, 26 May 2026 14:50:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBx68GwQhVqMF6RAA--.10913S2;
 Tue, 26 May 2026 14:50:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH 00/12] target/loongarch: Move CSR registers to struct
 CPUSysState
Date: Tue, 26 May 2026 14:50:11 +0800
Message-Id: <20260526065023.1639371-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68GwQhVqMF6RAA--.10913S2
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
registers are move in CPUSysState. In later with LVZ supported, there will
be two copied of CSR registers, so it is simply to add CPUSysState array.

Also new field curState is added which points to CPUSysState at
beginning, and it can be changed during VM exit/enter entry. There is no
function change, all is code movement or variable rename.

Bibo Mao (12):
  target/loongarch: Add new field curState in CPULoongArchState
  target/loongarch: Use curState in cpu.c when accessing CSR registers
  target/loongarch: Use curState in cpu_helper.c when accessing CSR
    registers
  target/loongarch: Use curState in file arch_dump.c when accessing CSR
    registers
  target/loongarch: Use curState in kvm.c when accessing CSR registers
  target/loongarch: Use curState in tlb_helper.c when accessing CSR
    registers
  target/loongarch: Use curState in tcg_cpu.c when accessing CSR
    registers
  target/loongarch: Use curState in csr_helper.c when accessing CSR
    registers
  target/loongarch: Use curState in op_helper.c when accessing CSR
    registers
  target/loongarch: Add default CSRFL_BASIC info with flags field
  target/loongarch: Add wrapper function get_csr_offset()
  target/loongarch: Add new structure CPUSysState

 hw/intc/loongarch_dintc.c                     |   4 +-
 target/loongarch/arch_dump.c                  |   5 +-
 target/loongarch/cpu-mmu.h                    |   4 +-
 target/loongarch/cpu.c                        | 120 ++++-----
 target/loongarch/cpu.h                        |  49 ++--
 target/loongarch/cpu_helper.c                 |  41 ++--
 target/loongarch/csr.c                        |  10 +-
 target/loongarch/csr.h                        |   5 +
 target/loongarch/gdbstub.c                    |   3 +-
 target/loongarch/kvm/kvm.c                    | 228 +++++++++---------
 target/loongarch/machine.c                    | 116 ++++-----
 target/loongarch/tcg/constant_timer.c         |  10 +-
 target/loongarch/tcg/csr_helper.c             |  55 +++--
 .../tcg/insn_trans/trans_extra.c.inc          |  11 +-
 .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
 target/loongarch/tcg/op_helper.c              |  45 ++--
 target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
 target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
 18 files changed, 531 insertions(+), 435 deletions(-)


base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
-- 
2.39.3


