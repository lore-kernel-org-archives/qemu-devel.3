Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC559CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 06:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPE3v-0000VV-8O; Tue, 19 May 2026 02:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wPE3t-0000Ux-2j
 for qemu-devel@nongnu.org; Tue, 19 May 2026 02:36:17 -0400
Received: from [2400:e920:0:e::2c] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wPE3q-0004IR-Qj
 for qemu-devel@nongnu.org; Tue, 19 May 2026 02:36:16 -0400
Received: from yuno-loong (unknown [IPv6:2400:e920:0:e::2c])
 by krgm.moe (Postfix) with ESMTPSA id 3C9EF2430982;
 Tue, 19 May 2026 14:30:57 +0800 (CST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: SignKirigami <prcups@krgm.moe>, Bibo Mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH 0/4] target/loongarch: add LVZ support for TCG
Date: Tue, 19 May 2026 14:30:39 +0800
Message-ID: <cover.1779171125.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2400:e920:0:e::2c (failed)
Received-SPF: pass client-ip=2400:e920:0:e::2c; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch implements Loongson VirtualiZation (LVZ) extension support for LoongArch's TCG target. With this patch, it is now possible to start a nested KVM-accelerated virtual machine on a TCG-emulated virtual machine.

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: xianglai li <lixianglai@loongson.cn>
Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>

SignKirigami (4):
  target/loongarch: add LVZ CPU state and CSR metadata
  target/loongarch: add LVZ guest runtime support
  target/loongarch: translate LVZ CSR and trap instructions
  target/loongarch: virtualize guest TLB and address translation

 target/loongarch/cpu-csr.h                    |  42 ++
 target/loongarch/cpu-mmu.h                    |  37 +-
 target/loongarch/cpu.c                        | 132 ++++
 target/loongarch/cpu.h                        | 125 +++-
 target/loongarch/cpu_helper.c                 | 119 ++--
 target/loongarch/csr.c                        | 122 ++++
 target/loongarch/csr.h                        |   3 +
 target/loongarch/disas.c                      |  10 +
 target/loongarch/insns.decode                 |  17 +
 target/loongarch/internals.h                  |   8 +-
 target/loongarch/kvm/kvm.c                    |   1 +
 target/loongarch/machine.c                    | 249 ++++---
 target/loongarch/tcg/constant_timer.c         |  62 +-
 target/loongarch/tcg/csr_helper.c             | 127 +++-
 target/loongarch/tcg/helper.h                 |  30 +-
 .../tcg/insn_trans/trans_privileged.c.inc     | 353 +++++++++-
 target/loongarch/tcg/op_helper.c              |  83 ++-
 target/loongarch/tcg/tcg_cpu.c                | 182 +++--
 target/loongarch/tcg/tcg_loongarch.h          |   6 +-
 target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
 target/loongarch/tcg/translate.c              |   6 +-
 target/loongarch/translate.h                  |   2 +
 22 files changed, 1909 insertions(+), 436 deletions(-)

-- 
2.52.0


