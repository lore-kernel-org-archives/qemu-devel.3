Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA708C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liJ-0001FO-KC; Wed, 16 Sep 2026 05:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li5-0001BV-MA; Wed, 16 Sep 2026 05:13:45 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li2-00087d-Fp; Wed, 16 Sep 2026 05:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=FFmrXobKeyOFgnQ+FVfgxO2H+Z3kDZiEi9hBd05BICg=; b=dIV8Qdz+V2Yz+cU
 W/HNYnU3doeE7Q20TM3R5Fn3YXTPmbc2+I22Dy3yKB5z4u8V0DBw54jjITz/iS2iFagdbz2Fuh6xy
 Hy+huhko4REwUIQ2xiInKrBT2Ctt4q8Q5k8BSd07OmgGTk/Arb/ka3bX9NGrvLT+jb8nVXALHP5b4
 w8=;
Subject: [PATCH v4 00/12] single-binary: Compile hw/riscv once
Date: Wed, 16 Sep 2026 11:18:55 +0200
Message-Id: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Pyw7CIBBFf6VhLQYG+nLlfxgXFKYtG2qgoqbpv
 0ub1Gjs8t7knDszkYDeYiCnbCIeow12cCnIQ0Z0r1yH1JqUCTDIOXBG+wf1NuhI9e1OrRspK7B
 C5DXWgpGE3Ty29rkqL9eUexvGwb/WhciXdpOV/7LIKaMGpJJMVkYodU5HHV1HFlOELxr4Dg2Jx
 kbWpgSdN9D+0GKjC5bDziNRLNucg0BVCFPrDz3P8xtBPyccKQEAAA==
X-Change-ID: 20251210-hw-riscv-cpu-int-06e8ee19e930
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, Chao Liu <chao.liu.zevorn@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=4821;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=vBCWwAw3I8KiiRKK6allGYOeWG1XeGQtB5HWJTrbOmQ=;
 b=3ohdvfCyQFLWPcLS9kL+Oa/SAvYsGWa9kjnS7txBVHrQbXCOuSz+bnfQoc4udC2QKjMy7xx2E
 oCzrWz91IH7A3mb9NZKf4c+UjsXr3HAcZMrkHJCCQtThDVjJwsiQNTy
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
qemu-system-riscv64 by adopting the TargetInfo API.

All in all, the number of compilation units when building both
riscv[32|64]-softmmu is reduced by 11, and the binary size of
qemu-system-riscv[32|64] is increased by 0.11% and 0.026% respectively
(corresponding to 65k and 14k bytes). (data from v3).

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v4:
- Drop merged patches.
- Added reviewed-bys.
- `target/riscv: Replace TYPE_RISCV_CPU_BASE`, inlined replacement
  ternary and dropped machines-qom.h function, file has since been
  removed.
- `target/riscv: Replace TARGET_LONG_BITS in header exposed to common
  code`, #ifdef irq_local_guest_max to system-mode.
- `target/riscv: Widen riscv_new_csr_seed()`, new patch added to handle
  function introduced since last version.
- `target/riscv: Move riscv_pmu_read_ctr() to internal csr.h header`,
  dropped and moved to a follow up patchset.
- `target/riscv: Stub out kvm functions`, use a separate stub library
  (Philippe).
- `hw/riscv: Tenstorrent Atlantis, use hwaddr/vaddr over target_ulong`,
  new patch handling new cpu.
- 3 New patches added to filter targets with is_available.
- Link to v3: https://lore.kernel.org/qemu-devel/20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng

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
Anton Johansson (12):
      target/riscv: Replace TYPE_RISCV_CPU_BASE
      target/riscv: Remove ifdefs in cpu.h
      target/riscv: Replace TARGET_LONG_BITS in header exposed to common code
      target/riscv: Widen riscv_new_csr_seed()
      target/riscv: Stub out kvm functions
      target/riscv: Move target_long.h inclusion away from cpu.h
      hw/riscv: Define SiFive E/U CPUs using runtime conditions
      hw/riscv: Tenstorrent Atlantis, use hwaddr/vaddr over target_ulong
      hw: Add availfn arg to DEFINE_MACHINE_EXTENDED()
      target-info: Introduce target_riscv32
      hw/riscv: Filter for 32- or 64-bit machine types
      hw/riscv: Compile once

 include/hw/core/boards.h        | 11 ++++++---
 include/hw/riscv/sifive_cpu.h   | 31 ------------------------
 include/hw/riscv/sifive_e.h     |  1 -
 include/hw/riscv/sifive_u.h     |  1 -
 include/qemu/target-info.h      |  7 ++++++
 target/riscv/cpu.h              | 52 +++++++++++------------------------------
 target/riscv/cpu_bits.h         |  2 --
 target/riscv/internals.h        |  1 +
 target/riscv/tcg/pmu.h          |  1 +
 hw/arm/bananapi_m2u.c           |  2 +-
 hw/arm/cubieboard.c             |  2 +-
 hw/arm/imx8mm-evk.c             |  2 +-
 hw/arm/integratorcp.c           |  2 +-
 hw/arm/mcimx7d-sabre.c          |  2 +-
 hw/arm/orangepi.c               |  2 +-
 hw/intc/riscv_imsic.c           |  4 +++-
 hw/ppc/pegasos.c                |  3 ++-
 hw/riscv/boston-aia.c           |  3 ++-
 hw/riscv/k230.c                 |  3 +++
 hw/riscv/microblaze-v-generic.c |  4 +++-
 hw/riscv/microchip_pfsoc.c      |  3 +++
 hw/riscv/opentitan.c            |  3 +++
 hw/riscv/shakti_c.c             |  3 +++
 hw/riscv/sifive_e.c             |  3 ++-
 hw/riscv/sifive_u.c             |  7 ++++--
 hw/riscv/tt_atlantis.c          |  6 ++++-
 hw/riscv/virt.c                 |  4 +++-
 hw/riscv/xiangshan_kmh.c        |  3 +++
 target-info.c                   |  5 ++++
 target/riscv/cpu.c              | 22 +++++++++++++----
 target/riscv/kvm/kvm-cpu.c      |  1 +
 target/riscv/kvm/kvm-stub.c     | 23 ++++++++++++++++++
 hw/riscv/meson.build            | 47 +++++++++++++++++++------------------
 target/riscv/kvm/meson.build    |  1 +
 target/riscv/meson.build        |  3 +++
 35 files changed, 151 insertions(+), 119 deletions(-)


