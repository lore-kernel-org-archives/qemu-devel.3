Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE3CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgf0-0004kD-RC; Wed, 20 May 2026 09:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgey-0004iT-Bj; Wed, 20 May 2026 09:08:28 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgew-000133-Eh; Wed, 20 May 2026 09:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=rA0Piz/dDSiwSzNPDKiaz6w3T5sBkBR4dsNFyBT3VOI=; b=gyez8fG7se575AH
 uctzKk6ymxjAcbqBhbSDFWuKj8HxtboAHGtZzUwtC5m54kKV5G21DNH4QNF2JLGfSjkGsbc+1E24W
 UckKGAZ46lQ+hnyGjchX8ZPN3JzsCH+iTOm2xCM9PuU49ZJQyP3veRuA6VKeGX/rwuNDat2mc45W1
 Ng=;
Subject: [PATCH v3 00/14] single-binary: Compile hw/riscv once
Date: Wed, 20 May 2026 15:12:52 +0200
Message-Id: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr0K6dkw7FAFX3sO4KHSA2RTTYtUQ7
 m4h0Zjo8k3y3p9ZBPJMQRyzWXiKHHh0CfJdJtrBuJ6AbWKBEguFSsJwB8+hjdBeb8BuAnmgikj
 VVOdSJO3qqePHljxfEg8cptE/t4Wo1us7Vv7GogIJFrXRUlc2N+aUntq7XqyliF82qj82JpsaX
 dsS26LB7mMvy/ICfiOOWusAAAA=
X-Change-ID: 20251210-hw-riscv-cpu-int-06e8ee19e930
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=4505;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=WQ8L/h9nAA1HLU1+ckce/pX4+Rtr1edz4eOiFjt2Ky4=;
 b=r1F8GWfuQrMVprZutKW/Q89bFCgif4aua4B+lzwPW3TwHl1iwHKxtM09q+x9OP7nXRlJ+1S6c
 02JWzf77T8oDS2vYW4XzqF4PIb8sw1039vCnBGMJ95ZeBBCnH7TaPO3
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Compiles hw/riscv a single time for both qemu-system-riscv32 and
qemu-system-riscv64 by adopting the TargetInfo API and by moving
machine definitions to generic QOM interfaces. This is the same approach
as taken by Philippe in

    "single-binary: Make hw/arm/ common"
    (20251021205741.57109-1-philmd@linaro.org).

All in all, the number of compilation when building both
riscv[32|64]-softmmu is reduced by 11, and the binary size of
qemu-system-riscv[32|64] is increased by 0.11% and 0.026% respectively
(corresponding to 65k and 14k bytes).

This patchset is based on:

    "single-binary: Make riscv cpu.h target independent"
    (20260520125406.28693-1-anjo@rev.ng).

Branch passing CI can be found here:

  https://gitlab.com/AntonJohansson/qemu/-/pipelines/2215536778

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v3:
- Dropped merged prequisite patchsets.
- patch 5/14 "configs/target: Implement per-binary TargetInfo structure
  for riscv": Use new target_info_init() TargetInfo registration.
- patch 7/14 "target/riscv: Replace TYPE_RISCV_CPU_BASE": Rename
  virt_default_cpu_type() -> riscv_default_cpu_type() and define in
  machines-qom.h.
- Dropped patch "[PATCH v2 11/14] target/riscv: Make pmu.h target-agnostic":
  This patch replaced target_ulongs with privilege_mode_t and has been folded
  into the prerequisite patchset introducing the typedef. 
- Added patch 12/14 "target/riscv: Move target_long.h inclusion
  away from cpu.h": Moves target_long.h inclusion to target specific
  header. 
- Link to v2: https://lore.kernel.org/qemu-devel/20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng

Changes in v2:
- Inlined sifive_cpu.h runtime functions and removed header (Philippe);
- Moved IRQ_LOCAL_GUEST_MAX macro to field in RISCVCPUDef (Philippe);
- Added reviewed-bys;
- Link to v1: https://lore.kernel.org/qemu-devel/20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng.

---
Anton Johansson (14):
      hw/riscv: Register generic riscv[32|64] QOM interfaces
      hw/riscv: Add macros and globals for simplifying machine definitions
      hw/riscv: Filter machine types for qemu-system-riscv32/64 binaries
      hw/core: Add riscv[32|64] to "none" machine
      configs/target: Implement per-binary TargetInfo structure for riscv
      target-info: Add target_riscv64()
      target/riscv: Replace TYPE_RISCV_CPU_BASE
      target/riscv: Remove ifdefs in cpu.h
      target/riscv: Replace TARGET_LONG_BITS in header exposed to common code
      target/riscv: Move riscv_pmu_read_ctr() to internal csr.h header
      target/riscv: Stub out kvm functions
      target/riscv: Move target_long.h inclusion away from cpu.h
      hw/riscv: Define SiFive E/U CPUs using runtime conditions
      hw/riscv: Compile once

 include/hw/riscv/machines-qom.h   | 58 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_cpu.h     | 31 ---------------------
 include/hw/riscv/sifive_e.h       |  1 -
 include/hw/riscv/sifive_u.h       |  1 -
 include/qemu/target-info.h        |  7 +++++
 target/riscv/cpu.h                | 44 ++++++-----------------------
 target/riscv/cpu_bits.h           |  2 --
 target/riscv/csr.h                |  3 ++
 target/riscv/internals.h          |  1 +
 target/riscv/pmu.h                |  2 --
 configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++
 configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++
 hw/core/null-machine.c            |  3 ++
 hw/intc/riscv_imsic.c             |  4 ++-
 hw/riscv/boston-aia.c             |  3 +-
 hw/riscv/microblaze-v-generic.c   |  5 ++--
 hw/riscv/microchip_pfsoc.c        |  2 ++
 hw/riscv/opentitan.c              |  2 ++
 hw/riscv/shakti_c.c               |  2 ++
 hw/riscv/sifive_e.c               |  5 +++-
 hw/riscv/sifive_u.c               |  9 ++++--
 hw/riscv/spike.c                  |  4 ++-
 hw/riscv/virt.c                   |  5 +++-
 hw/riscv/xiangshan_kmh.c          |  2 ++
 target-info-qom.c                 |  9 ++++++
 target-info.c                     |  5 ++++
 target/riscv/cpu.c                | 14 ++++++++--
 target/riscv/kvm/kvm-stub.c       | 23 ++++++++++++++++
 target/riscv/machine.c            | 17 ++++++++++++
 target/riscv/pmu.c                |  1 +
 configs/targets/meson.build       |  1 +
 hw/riscv/meson.build              | 36 ++++++++++++------------
 target/riscv/kvm/meson.build      |  1 +
 33 files changed, 254 insertions(+), 101 deletions(-)


