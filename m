Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E54C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fwm-0002z9-MR; Thu, 10 Sep 2026 10:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwk-0002yS-EJ; Thu, 10 Sep 2026 10:40:14 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x4fwd-0003Pv-1H; Thu, 10 Sep 2026 10:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789051193; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=u7N3eGlGkyBhbccUTQf2di4Utk6axCBqdoBb8i9P2hg=;
 b=hcGYMJDEmAAyt63V07fVHi9yPJaG4eP+kXjpC2xLEwGlj0l0p1HTTkiGIe/63ghxOBhqRy/V8hdDym0SDgPQRfJYhDWOnC1QkGJghM5KxSdRDIFuuj2LTM69JO0nZbB8JEa31UhOo7bHK/CJITB+ZI6xTUk/IvqGkcQz/12r6Xw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XAhkcDH_1789051190; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XAhkcDH_1789051190 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 10 Sep 2026 22:39:52 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v2 00/14] RISC-V TCG PMU correctness fixes
Date: Thu, 10 Sep 2026 22:39:37 +0800
Message-Id: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACnBomoC/3WPy26DMBBFfwV5XSO/sVFV5T+qLIyxw0gYUhtQo
 oh/ryHdVrO6I825Z14o+wQ+o7Z6oeQ3yDBPJbCPCrnBTjePoS8ZMcIU0azBCbLb8D2u2M0pebd
 MPmccrNYk9MYJ3aNye08+wOPkfl/fOfmfteCX9xJ1NvuCiBGWtqJ9YFIFaZT2JjSOOyE5t5Rr3
 pGGOiKE5apXBzqWPnt6tdXnqWXKNIxLVQvWaIEpDgkWN4z+2c1Dab7cooWxLm1f6LAZIC9zep5
 Pb/TU+QP9999GMcEy0CCokNpocxlhWh+1HaGznT3Q6Lrv+y/tX042UAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789051191; l=4911;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=JFBDUVqoNBZTCeJsBG5s2ldPNHMqtcpp901usypkVM0=;
 b=qU3fX0JQFVWsisbsZzA1Lx1tL0Ki1rvuMslAMl6ZsyXeClPjGJv5JtrAaVApJ7svnobVFbGeD
 J+RgFLawaZcA847m+/utGlNimAQvbF4KwptNFpnVYI+A80qEe1ekEmR
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
migration. It is based on v2 of Zephyr Li's "target/riscv: fix RV32
fixed counter accesses" [1], which is not included here.

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

[1] https://lore.kernel.org/qemu-devel/20260909072356.42784-1-fritchleybohrer@gmail.com/
Based-on: <20260909072356.42784-1-fritchleybohrer@gmail.com>

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
Changes in v2:
- Rebase on current master and Zephyr Li's RV32 fix v2.
- Register the system TCG tests with Meson and use -bios loading.
- Merge smcdeleg-counter-rv32.S and smcdeleg-event-rv32.S into
  smcdeleg-rv32.S (patch 6).
- Use CSR names or local CSR-number macros in tests.
- Use UINT32_MAX for delegated high-half write-mask checks (patch 6).
  The caller already requires XLEN=32.
- Link to v1: https://lore.kernel.org/qemu-devel/20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com

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
 target/riscv/tcg/csr.c                      | 278 +++-------
 target/riscv/tcg/pmu.c                      | 793 +++++++++++++++++++---------
 target/riscv/tcg/pmu.h                      |  29 +-
 target/riscv/tcg/tcg-cpu.c                  |  10 +
 tests/tcg/riscv32/pmu-fixed-rv32.S          |  90 ++++
 tests/tcg/riscv32/pmu-minstretcfg-rv32.S    |  52 ++
 tests/tcg/riscv32/smcdeleg-minh-rv32.S      |  78 +++
 tests/tcg/riscv32/smcdeleg-rv32.S           | 115 ++++
 tests/tcg/riscv32/sscofpmf-event-rv32.S     |  99 ++++
 tests/tcg/riscv32/system/meson.build        |  35 ++
 tests/tcg/riscv64/pmu-cycle-controls.S      | 107 ++++
 tests/tcg/riscv64/pmu-lpad.S                |  72 +++
 tests/tcg/riscv64/pmu-reset-vs.S            | 105 ++++
 tests/tcg/riscv64/smcdeleg-minh.S           |  78 +++
 tests/tcg/riscv64/smcdeleg-sxl32.S          | 233 ++++++++
 tests/tcg/riscv64/sscofpmf-cycle-overflow.S |  58 ++
 tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++
 tests/tcg/riscv64/sscofpmf-overflow.S       | 134 +++++
 tests/tcg/riscv64/system/meson.build        |  88 +++
 tests/tcg/riscv64/test-minstret-ecall.S     |  26 +
 26 files changed, 2252 insertions(+), 466 deletions(-)
---
base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
change-id: 20260827-riscv-pmu-correctness-fa880fd9c48d
prerequisite-message-id: <20260909072356.42784-1-fritchleybohrer@gmail.com>
prerequisite-patch-id: f7a8b2a8cc67f360d6abb1adf002b000e7b2eb4d

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


