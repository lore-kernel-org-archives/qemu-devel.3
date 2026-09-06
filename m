Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B893BC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Fsa-0002xM-9s; Sun, 06 Sep 2026 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsY-0002vH-R6; Sun, 06 Sep 2026 12:38:02 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsP-000339-4N; Sun, 06 Sep 2026 12:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712650; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=Jnva7G+EKQXHvdzxR0/MqZrTxP+JeTB2Jf5wbbRBDQE=;
 b=kpoSKHIUw2AunEvXqoovbH/BT9E4PgFgaq8n9tMoj8H/z4fmG4FWxtaTuhCz7/Rir299p2XkWog+a/kg2QvymDUvEqZbx7uzIcBPNvtAC/z0UwSDFOeZGFZT/Bmeiwri05N5FSiAx0Hr7BfjnlLblrFeHijqZFAnUrO1D2KfFZA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIHK_1788712646; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIHK_1788712646 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:29 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH 00/14] RISC-V TCG PMU correctness fixes
Date: Mon, 07 Sep 2026 00:37:16 +0800
Message-Id: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALyWnWoC/yWOXQrCMBAGr1LybCTdan6KiPeQPiTpxi6YVpMqS
 vHuxvo4CzvzLSxjIsysrRaW8EmZprFAvamYH+x4QU59YQYCpNCgeKLsn/wWH9xPKaGfR8yZB6u
 1CL3xO92z8ntLGOi1es/dnxPeH0U//4/M2YxFESPNbeWgsRKUaqzSewnGeOcapQHlzkjtpDXgl
 YHwU8fSs+uutjqss4zYCwO6FlspBa95SDT74YpvNw2le7pES9dtaR1Z9/l8ARWszUfzAAAA
X-Change-ID: 20260827-riscv-pmu-correctness-fa880fd9c48d
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=4453;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=ez48eFypyBNYkMtPHDfDZicQdFpeKhfcge5jRt031xc=;
 b=+JJO3xMZQKSByjy7vPV7rFLu/nGPB6USquuRt4CqgQGImOOa4dZGEMOkDPS1SCTteT7TaAtK8
 oAB1N1POQmzAQKRsbrWnpBFyuVkdXvEZQTwGcrbAUdQovsc+hzTpTIj
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This series fixes RISC-V TCG PMU accounting, overflow notification, and
migration. It is based on Zephyr Li's "target/riscv: fix RV32 fixed
counter accesses" [1], which is a prerequisite and is not included here.

The patches allow multiple HPM counters to select the same event and
preserve counts across selector, privilege-filter, and inhibit writes.
They use consistent cycle/instruction sources and compute the shared
overflow deadline from all eligible counters. Timer callbacks queue
checks on the owner vCPU instead of racing MTTCG execution.

Migration saves counter values including pending increments and restores
destination-local source baselines, event mappings, and overflow
scheduling. A new cpu/pmu-fixed subsection carries mcyclecfg/minstretcfg
and identifies this format. All TCG CPUs require the subsection; loading
older TCG streams without it is rejected. Source and destination still
need compatible CPU configurations. KVM PMU migration is unchanged.

The reset changes preserve the final counts in the old privilege/V mode
before entering M-mode with V=0.

TCG tests cover RV32/RV64 counter accesses, delegated registers, selector
and filter changes, multiple counters per event, overflow notification
with and without Sscofpmf, instruction exceptions, and reset. The RV32
HPM tests also cover full-width accesses through the shared counter path.

[1] https://lore.kernel.org/qemu-devel/20260905092810.660-1-fritchleybohrer@gmail.com/
Based-on: <20260905092810.660-1-fritchleybohrer@gmail.com>

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
TANG Tiancheng (14):
      target/riscv: Preserve PMU state across event selector writes
      target/riscv: Support multiple counters per PMU event
      target/riscv: Use VM-elapsed sources for fixed PMU events
      target/riscv: Preserve MINH on delegated config reads
      target/riscv: Preserve minstretcfgh on RV32 minstretcfg writes
      target/riscv: Fix RV32 accesses to delegated PMU registers
      target/riscv: Preserve fixed counters across PMU state changes
      target/riscv: Require Sscofpmf for non-fixed event overflow
      target/riscv: Rebuild fixed-event PMU overflow deadlines
      target/riscv: Apply minstret exception accounting to HPM counters
      target/riscv: Process PMU timer expiry on the owner vCPU
      target/riscv: Migrate fixed PMU counter state
      target/riscv: Clear virtualization mode on reset
      target/riscv: Preserve fixed PMU state across reset

 system/cpu-timers.c                         |   4 +-
 system/cpus.c                               |   6 +-
 target/riscv/cpu.c                          |  17 +
 target/riscv/cpu.h                          |  14 +-
 target/riscv/machine.c                      |  92 +++-
 target/riscv/tcg/cpu_helper.c               |   2 +
 target/riscv/tcg/csr.c                      | 281 +++-------
 target/riscv/tcg/pmu.c                      | 793 +++++++++++++++++++---------
 target/riscv/tcg/pmu.h                      |  29 +-
 target/riscv/tcg/tcg-cpu.c                  |  10 +
 tests/tcg/riscv32/Makefile.softmmu-target   |  42 ++
 tests/tcg/riscv32/pmu-fixed-rv32.S          |  90 ++++
 tests/tcg/riscv32/pmu-minstretcfg-rv32.S    |  48 ++
 tests/tcg/riscv32/smcdeleg-counter-rv32.S   |  84 +++
 tests/tcg/riscv32/smcdeleg-event-rv32.S     |  69 +++
 tests/tcg/riscv32/smcdeleg-minh-rv32.S      |  70 +++
 tests/tcg/riscv32/sscofpmf-event-rv32.S     |  91 ++++
 tests/tcg/riscv64/Makefile.softmmu-target   |  63 ++-
 tests/tcg/riscv64/pmu-cycle-controls.S      | 104 ++++
 tests/tcg/riscv64/pmu-lpad.S                |  69 +++
 tests/tcg/riscv64/pmu-reset-vs.S            | 102 ++++
 tests/tcg/riscv64/smcdeleg-minh.S           |  70 +++
 tests/tcg/riscv64/smcdeleg-sxl32.S          | 219 ++++++++
 tests/tcg/riscv64/sscofpmf-cycle-overflow.S |  58 ++
 tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++
 tests/tcg/riscv64/sscofpmf-overflow.S       | 134 +++++
 tests/tcg/riscv64/test-minstret-ecall.S     |  26 +
 27 files changed, 2223 insertions(+), 467 deletions(-)
---
base-commit: b23a62773a7856299cbb3782e64968b6a92c792f
change-id: 20260827-riscv-pmu-correctness-fa880fd9c48d
prerequisite-message-id: <20260905092810.660-1-fritchleybohrer@gmail.com>
prerequisite-patch-id: 3dfb379e910f47acaa9e94ac5766045f86e76799

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


