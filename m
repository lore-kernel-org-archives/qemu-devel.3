Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7F0E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslCj-0005Uo-Vo; Wed, 18 Feb 2026 12:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCO-0005PQ-EK
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:18:55 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vslCG-0005aZ-Hm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Yog9jPtAES0Jn63OVmBniBo9y/VkOCMQJJHTIyDoGno=; b=MrOQ/Shqo7LeVKu
 2MzcPiOKFxIMCKlTNGHCwxb3E6b3TV/qmXM/8Ow/r/AwaB8LwN8uKQ/NPVOEUSJwo4XHx5oExRssI
 C6bxdyKY3UoO03ShYRdB1nT95JV3sHpHPo2FY+OQAwr/n59ybSb/jgVwK03xUv7tP3SE8oYN18q/x
 Is=;
Subject: [PATCH v6 0/7] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
Date: Wed, 18 Feb 2026 18:21:26 +0100
Message-Id: <20260218-phys_addr-v6-0-a603bf363218@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1XOS27DIBSF4a1EjEt0H2BMR91HVVWER8zEiaCyG
 kXee0mipHh4rvh+cRU1lhyreN9dRYlLrvk0tzG87YSf3HyMMoe2BQFpRFDyPF3qtwuhyAMkZaJ
 jQOVEe38uMeXfe+vzq+0p159TudzTC96ujwqB7SoLSpCeR5M4GgrGfLRv7OejuCUW6hjqnlFjA
 7NzGCyRDxvGTzYAIvWMG9PJQgoHBajThql/Rgg9U40Z0k6PNo7sxw3TPRt6phsjGzRRQmbrX2x
 d1z/FwJN3ewEAAA==
X-Change-ID: 20251104-phys_addr-b0f47ea3014a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771435335; l=3743;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=cF/SKDDeS9pFbN8O0z4Rg2jBtPjLR3INVqUkjt4c4ng=;
 b=+izUq47c8FzTKYhURlJcuxhhdBZ48dHPY7GV7fbIakcocznkKW9q8gV8NIGe60F/Y5rlt1H5V
 3RwMELK/wqfCgqfc7qSi8Qvjcw5WEq5pMLLnQJ04S4QqbK+0Gh6ht4h
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
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

The target macro TARGET_PHYS_ADDR_SPACE_BITS is unused since commit

  2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS"),

replace the handful of remaining uses with runtime functions or
constants.

For discussion see:

  https://lore.kernel.org/qemu-devel/8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org/

Series fully reviewed.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v6:
- Added reviewed-bys
- Link to v5: https://lore.kernel.org/qemu-devel/20260216-phys_addr-v5-0-29d522f1339c@rev.ng

Changes in v5:
- Added RISCVIOMMUState::pas_bits property (Richard, Chao);
- Dropped already merged alpha patch (Philippe);
- Added reviewed-bys;
- Link to v4: https://lore.kernel.org/qemu-devel/20260210-phys_addr-v4-0-725a589e83c8@rev.ng

Changes in v4:
- Revert to using 40 bit physical addresses for HPPA to not break SeaBIOS
  functional tests. This will be addressed in a separate series;
- Added HPPA patch 3/8 to convert a missed 32-bit abs -> physical
  address conversion;
- Link to v3: https://lore.kernel.org/qemu-devel/20260112-phys_addr-v3-0-5f90fdb4015f@rev.ng

Changes in v3:
- Added reviewed-by;
- Widened CC;
- Link to v2: https://lore.kernel.org/qemu-devel/20251215-phys_addr-v2-0-633aa1d922cd@rev.ng

Changes in v2:
- Move alpha_phys_addr_space_bits() to linux-user/alpha/target_proc.h
  (Richard);
- Link to v1: https://lore.kernel.org/qemu-devel/20251209-phys_addr-v1-0-c387f3e72d77@rev.ng

---
Anton Johansson (7):
      target/hppa: Define PA[20|1X] physical address space size
      hw/hppa: Use hppa_abs_to_phys_pa1x()
      target/i386: Drop physical address range checks
      target/loongarch: Introduce loongarch_palen_mask()
      hw/loongarch: Use loongarch_palen_mask()
      hw/riscv: Set IOMMU PAS via property
      Drop TARGET_PHYS_ADDR_SPACE_BITS

 hw/riscv/riscv-iommu.h            |  1 +
 include/exec/cpu-defs.h           |  3 ---
 include/exec/poison.h             |  2 --
 include/hw/loongarch/boot.h       |  3 ++-
 target/alpha/cpu-param.h          |  3 ---
 target/arm/cpu-param.h            |  2 --
 target/avr/cpu-param.h            |  1 -
 target/hexagon/cpu-param.h        |  1 -
 target/hppa/cpu-param.h           |  3 ---
 target/hppa/cpu.h                 |  1 +
 target/i386/cpu-param.h           |  2 --
 target/i386/tcg/helper-tcg.h      |  2 --
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/cpu-param.h      |  1 -
 target/loongarch/internals.h      |  1 -
 target/m68k/cpu-param.h           |  1 -
 target/microblaze/cpu-param.h     |  2 --
 target/mips/cpu-param.h           |  2 --
 target/or1k/cpu-param.h           |  1 -
 target/ppc/cpu-param.h            |  7 -------
 target/riscv/cpu-param.h          |  2 --
 target/rx/cpu-param.h             |  1 -
 target/s390x/cpu-param.h          |  1 -
 target/sh4/cpu-param.h            |  1 -
 target/sparc/cpu-param.h          |  2 --
 target/tricore/cpu-param.h        |  1 -
 target/xtensa/cpu-param.h         |  1 -
 hw/hppa/machine.c                 |  2 +-
 hw/loongarch/boot.c               | 28 ++++++++++++++++------------
 hw/loongarch/virt.c               |  5 ++++-
 hw/riscv/riscv-iommu-pci.c        |  3 +++
 hw/riscv/riscv-iommu.c            |  8 ++++----
 hw/riscv/virt.c                   |  7 +++++++
 target/hppa/mem_helper.c          | 32 +++++++++++++++++++++++++++-----
 target/i386/cpu.c                 |  9 +++------
 target/i386/kvm/kvm.c             |  3 +--
 target/loongarch/cpu_helper.c     | 15 ++++++++++++---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++----
 38 files changed, 91 insertions(+), 82 deletions(-)


