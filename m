Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D98606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lGPEspC6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRRSJ-0002E0-73; Thu, 12 Nov 2026 04:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRa-0001mw-9a; Thu, 12 Nov 2026 04:50:12 -0500
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xRRRT-0002yE-3P; Thu, 12 Nov 2026 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794476969; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
 bh=/jq9r82VQx/txUkVPQPQAQudxoA0MAURQRGJJ4fHafI=;
 b=lGPEspC6lVcvQc7SiWXMDVQlTh3qdvqm5zMhwFDyG6F1NzGP3bClhI4QLRq4nriisyqMLM/roROyjNwTybagZyzocskz2CsYCBPyevMwBqIzfWXmLfRRbdtfY+BMyB0Nwf1J3tF1oYHEq9d+GN+QbJSJuN1XdVWF0mnSY6e3VA4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XEbfdYI_1794476966; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XEbfdYI_1794476966 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 12 Nov 2026 17:49:27 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Subject: [PATCH v4 00/14] RISC-V TCG PMU correctness fixes
Date: Thu, 12 Nov 2026 17:49:06 +0800
Message-Id: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOL9WoC/3XNQQ7CIBQE0KsY1mL4SC248h7GBaUf/Ym2FVqiM
 b27VBN1YZczybx5sIiBMLLt4sECJorUNjmo5YK5k22OyKnOmUkhN0LLkgeKLvHuMnDXhoCubzB
 G7q3WwtfGKV2zvO0Cerq93P3hnQNeh8z33/JEsW/D/fWdYGrfN0bM3STgghcevAJVaKPN7kzNc
 FvZM1W2sivXXtgkJ/mjgZjT5KTVtoDCWOE2ak5bfzQQ89o6ayXIymtQtqzwnzaO4xOGB2oecwE
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794476967; l=5216;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=buWs0xHM4Lv57puWyr6FxXI4eXVCDpGPrt79QDJQeIA=;
 b=ScZVa/MRTP3lWT1S+afeojusEgdY14bV6ecrAKCW5JtxBwLkZTabjyD3k/+TFrCwjp2eWtxuL
 4a5wFSXZSacD1lv8GC17h/ivYVirdAiO6Pi6/SaSs9/oTCLrvUg0en2
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes RISC-V TCG PMU accounting, overflow notification, and
migration.

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

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
Changes in v4:
- Rebase on riscv-to-apply.next bf67d56f282c, which includes the
  RV32 prerequisite and the PMU timer upper-half fix.
- Integrate PMU timer resume with the Sdext execution-entry hook
  (patch 9).
- Link to v3: https://lore.kernel.org/qemu-devel/20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com

Changes in v3:
- Rebase on master f9587d4045c6 and Zephyr Li's RV32 fix v3.
- Replace "Earlier expiries" with "Timer expirations before the flag
  is cleared" in patch 11's commit message.
- Add a Fixes trailer to the virtualization-reset fix (patch 13).
- Link to v2: https://lore.kernel.org/qemu-devel/20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com

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
 target/riscv/tcg/pmu.c                      | 801 +++++++++++++++++++---------
 target/riscv/tcg/pmu.h                      |  29 +-
 target/riscv/tcg/tcg-cpu.c                  |  13 +-
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
 26 files changed, 2250 insertions(+), 479 deletions(-)
---
base-commit: bf67d56f282c1ee25b67dfda3f8ca54d2bd4648e
change-id: 20260827-riscv-pmu-correctness-fa880fd9c48d

Best regards,
-- 
TANG Tiancheng <lyndra@linux.alibaba.com>


