Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6992D3B7ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSy9u-0000AQ-Ti; Tue, 09 Dec 2025 08:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9X-00007l-Go
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9T-0002cC-Qf
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wCPXVKRNgrsELABMxvbsZow+6lzooVlmJPoUmw/DF7Q=; b=sd5D6+1W/Pc+5Gw
 2ckbcNwYX4cvDbp/2Y0Ltvv8ZpxBY6RCrwMBExNDWb+6A++W6XrkY2bueaJFTJG4ckPQEXSPww2vZ
 4lYVwFzQMJZSIjXW3J0VF7C7H97KaCmouiifeLRI3JhNVlFvxbIfNOYhZTkrQZ08t4Z3nAA9OExDE
 uw=;
Subject: [PATCH 0/7] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
Date: Tue, 09 Dec 2025 14:56:01 +0100
Message-Id: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHEqOGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3YKMyuL4xJSUIt0kgzQT89REYwNDk0QloPqCotS0zAqwWdGxtbU
 ANdXtvlsAAAA=
X-Change-ID: 20251104-phys_addr-b0f47ea3014a
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
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

The target macro TARGET_PHYS_ADDR_SPACE_BITS is unused since commit

  2e8fe327eb6 ("accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS"),

replace the handful of remaining uses with runtime functions or
constants.

For discussion see:

  https://lore.kernel.org/qemu-devel/8f0db5c1-f20b-4b7a-8d6c-76ce7ec7b4e0@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Anton Johansson (7):
      target/alpha: Introduce alpha_phys_addr_space_bits()
      target/hppa: Define PA[20|1X] physical address space size
      target/i386: Drop physical address range checks
      target/loongarch: Introduce loongarch_palen_mask()
      hw/loongarch: Use loongarch_palen_mask()
      hw/riscv: Fix IOMMU PAS capability to 56 bits
      Drop TARGET_PHYS_ADDR_SPACE_BITS

 include/exec/cpu-defs.h           |  3 ---
 include/exec/poison.h             |  2 --
 include/hw/loongarch/boot.h       |  3 ++-
 linux-user/alpha/target_proc.h    |  2 +-
 target/alpha/cpu-param.h          |  3 ---
 target/alpha/cpu.h                |  1 +
 target/arm/cpu-param.h            |  2 --
 target/avr/cpu-param.h            |  1 -
 target/hexagon/cpu-param.h        |  1 -
 target/hppa/cpu-param.h           |  2 --
 target/i386/cpu-param.h           |  2 --
 target/i386/tcg/helper-tcg.h      |  2 --
 target/loongarch/cpu-mmu.h        |  1 +
 target/loongarch/cpu-param.h      |  1 -
 target/loongarch/internals.h      |  1 -
 target/m68k/cpu-param.h           |  1 -
 target/microblaze/cpu-param.h     |  2 --
 target/mips/cpu-param.h           |  2 --
 target/openrisc/cpu-param.h       |  1 -
 target/ppc/cpu-param.h            |  7 -------
 target/riscv/cpu-param.h          |  2 --
 target/rx/cpu-param.h             |  1 -
 target/s390x/cpu-param.h          |  1 -
 target/sh4/cpu-param.h            |  1 -
 target/sparc/cpu-param.h          |  2 --
 target/tricore/cpu-param.h        |  1 -
 target/xtensa/cpu-param.h         |  1 -
 hw/loongarch/boot.c               | 28 ++++++++++++++++------------
 hw/loongarch/virt.c               |  5 ++++-
 hw/riscv/riscv-iommu.c            | 12 +++++++++---
 target/alpha/helper.c             | 18 ++++++++++++++++++
 target/hppa/mem_helper.c          | 23 ++++++++++++++++++-----
 target/i386/cpu.c                 |  9 +++------
 target/i386/kvm/kvm.c             |  3 +--
 target/loongarch/cpu_helper.c     | 14 +++++++++++---
 target/loongarch/tcg/tlb_helper.c | 12 ++++++++----
 36 files changed, 93 insertions(+), 80 deletions(-)


