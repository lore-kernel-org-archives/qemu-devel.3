Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCCFD637B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVen9-0001DY-RE; Tue, 16 Dec 2025 18:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemy-0001Ao-UT
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:10 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vVemw-0006l7-Q5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=c5p5dn3cbGy/fxxOEt11IGsmgf8nHj3mgDVrs6ZSIlI=; b=hfGizBNJqT/VdY4
 BiXt3sNfG5eR6xlJxkwPO7pIaF6Ww7staGdG1tBHQWl6yqxeCG+txvkHuh07J4udDvwFkxZeo+nN5
 5aS3FI0RNK+v6RCthGrSP9EX6rWMWCPjapQA46XARYkzdsJKAEfIZl6a0jF+gWV4wPfCmq//IVDt8
 VQ=;
Subject: [PATCH 00/14] single-binary: Compile hw/riscv once
Date: Wed, 17 Dec 2025 00:51:05 +0100
Message-Id: <20251217-hw-riscv-cpu-int-v1-0-d24a4048d3aa@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnwQWkC/x3MOwqAMBBF0a3I1A4kEcW4FbGQ+DTTREn8gbh3g
 +Up7n0oIQoSdcVDEackWUOGLgtyfgwLWKZsMsrU2mjF/uIoyZ3stoMl7KwatIC2sJWinG0Rs9z
 /sh/e9wP8HLoeYgAAAA==
X-Change-ID: 20251210-hw-riscv-cpu-int-06e8ee19e930
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
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
qemu-system-riscv[32|64] is increased by 0.14% and 0.11% respectively
(corresponding to 73k and 57k bytes).

This patches is based on the following patchsets, applied in descending
order:

    - "single-binary: Make riscv cpu.h target partially independent"
      (20251103033713.904455-1-alistair.francis@wdc.com);

    - "single-binary: Make riscv cpu.h target independent"
      (20251210132130.14465-1-anjo@rev.ng);

    - "hw/riscv: Treat kernel_start_addr as vaddr"
      (20251103171208.24355-1-anjo@rev.ng);

    - "single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS"
      (20251209-phys._5Faddr-v1-0-c387f3e72d77@rev.ng).

Branch passing CI can be found here:

  https://gitlab.com/AntonJohansson/qemu/-/pipelines/2215536778

Signed-off-by: Anton Johansson <anjo@rev.ng>
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
      target/riscv: Make pmu.h target-agnostic
      target/riscv: Stub out kvm functions
      hw/riscv: Define SiFive E/U CPUs using runtime conditions
      hw/riscv: Compile once

 include/hw/riscv/machines-qom.h   | 46 +++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_cpu.h     | 26 ++++++++++++++++------
 include/hw/riscv/virt.h           | 11 ++++++++++
 include/qemu/target-info.h        |  7 ++++++
 target/riscv/cpu.h                | 42 +++++++----------------------------
 target/riscv/cpu_bits.h           |  2 +-
 target/riscv/csr.h                |  3 +++
 target/riscv/pmu.h                |  4 +---
 configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++++++
 configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++++++
 hw/core/null-machine.c            |  3 +++
 hw/riscv/microblaze-v-generic.c   |  6 +++--
 hw/riscv/microchip_pfsoc.c        |  2 ++
 hw/riscv/opentitan.c              |  2 ++
 hw/riscv/shakti_c.c               |  2 ++
 hw/riscv/sifive_e.c               |  4 +++-
 hw/riscv/sifive_u.c               |  6 +++--
 hw/riscv/spike.c                  |  5 ++++-
 hw/riscv/virt.c                   |  5 ++++-
 hw/riscv/xiangshan_kmh.c          |  2 ++
 target-info-qom.c                 |  9 ++++++++
 target-info.c                     |  5 +++++
 target/riscv/kvm/kvm-stub.c       | 23 ++++++++++++++++++++
 target/riscv/machine.c            | 17 +++++++++++++++
 target/riscv/pmu.c                |  9 +++++---
 configs/targets/meson.build       |  1 +
 hw/riscv/meson.build              | 32 +++++++++++++--------------
 target/riscv/kvm/meson.build      |  1 +
 28 files changed, 256 insertions(+), 71 deletions(-)


