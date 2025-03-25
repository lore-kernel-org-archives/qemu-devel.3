Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC328C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwO0-0003n8-5s; Tue, 25 Mar 2025 00:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNr-0003jk-0c
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNn-0005np-VP
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff187f027fso11092930a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878762; x=1743483562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rajTAshyyuf+9dBkelCHSUjwpcojpUqSjWQK0047Uzc=;
 b=c9nbrN4y2FeoWj7yNrAUT8ErYed606uT7psmUMVRBHACdLHCL+CepMerLODZZIfiT1
 1TkcjqanoaXBogq46OXuNH7AGph3aUQpzazRAQdP8NruL8CSo6OmzwKiUfQnyRNDbbbS
 2aFykKHP69nM5FhhiMrf1+ALxxICt/ICifx/Atzu3aw1E2YPuY7+tAs1lorOyZqzqLgG
 vi42eWiikH/LHV6Ta4ngWBbxxzlI8w+9hiIZlbzhuNxJiE3aA1Q9XvZbEOInea5fEBuR
 uNWlh743DxSbp/cX56siiFKooF8rLxOK6V61EX86T3G3AM0zq3iEECfOlSpXIcEGDGI2
 +H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878762; x=1743483562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rajTAshyyuf+9dBkelCHSUjwpcojpUqSjWQK0047Uzc=;
 b=RXunQDj+Ydyh+BV+LPYXLTbfgJqk+7XMb7tIh+kyAl/ndBfy3Tvq6evjTxXGQaBexZ
 z5mCDtQqOKMTFfi/LcSGPEbtqR16jQ5xkumDZhh/jcjUxZqvHDo44Pc7jA6o4w88/MF8
 U2AvayTvKAf79oFnU3eSHDf88zsgynpTSopHDysjxsv3CNe2S4rzajk9MbaZrAWnl30c
 VzfUq2eB5DBywoJ2VDo74nfKNBo3/lswWQWU7qQU4WXBBJeHd2PFPR6sITj/8tjl6mwJ
 qQ293Q9xEOPAn6gUDC9Lam5KIo1vhAQjzqjnFNpUsDbUoL7PsC1a+N1zRgwLU5MUcjeK
 zlLw==
X-Gm-Message-State: AOJu0YzuhtcXF8DILMi/OKLLvMQwyehsLxUnxiivzCczApR0QVDkvsjL
 PSrqx4BaB8fjG7P9rbQrSbUiOLahXJraiHvfsSfre9CKubdpTrFFFcZ8U71DVu4WCQpbjWntdzR
 0
X-Gm-Gg: ASbGnctcdBxqoodj47HaIU7DCaiVGujkOe6WuDlgkFhGNJmyGleEik5mYuIoW4YkPwW
 Y1R2mIkTmMDbr9btMBtqjmrNtiQ7XyltW/ZxLBHBFdGRoq2+jXyxITsZQFH0RK8Rn9/Vh3qIWHQ
 J0u+/ZRbnrb2tBQf3qAxQdRzl2VShFI3sXwaKPpq2L7YSNyQeJZND6fVZN5x+7tFN8gBfu3HRsl
 pRNkp7XPD+75W1UcbBP7mlUGZCi0FR6X0orukj/uw1U/FDWJknUaSl76CGZw6zXs5l9kcaDne5z
 vHZqHf6Bqc1D3lXivMy6WqJfxmuQmksvDfby/1KUvyxF
X-Google-Smtp-Source: AGHT+IEuyoNLVrmTssAXxfIaajKKAVuUdLb1GQFc5Uc47d6bqWDu7TeJ4gC61YmsDCrDsik7egiLGw==
X-Received: by 2002:a17:90a:e7c7:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-3030e148d42mr22800129a91.0.1742878761922; 
 Mon, 24 Mar 2025 21:59:21 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 00/29] single-binary: start make hw/arm/ common
Date: Mon, 24 Mar 2025 21:58:45 -0700
Message-Id: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series focuses on removing compilation units duplication in hw/arm. We
start with this architecture because it should not be too hard to transform it,
and should give us some good hints on the difficulties we'll meet later.

We first start by making changes in global headers to be able to not rely on
specific target defines. In particular, we completely remove cpu-all.h.
We then focus on removing those defines from target/arm/cpu.h.

From there, we modify build system to create a new hw common library (per base
architecture, "arm" in this case), instead of compiling the same files for every
target.

Finally, we can declare hw/arm/boot.c, and most of the boards as common as a
first step for this part.

- Based-on: 20250317183417.285700-1-pierrick.bouvier@linaro.org
("[PATCH v6 00/18] make system memory API available for common code")
https://lore.kernel.org/qemu-devel/20250317183417.285700-1-pierrick.bouvier@linaro.org/
- Based-on: 20250318213209.2579218-1-richard.henderson@linaro.org
("[PATCH v2 00/42] accel/tcg, codebase: Build once patches")
https://lore.kernel.org/qemu-devel/20250318213209.2579218-1-richard.henderson@linaro.org

v2:
- rebase on top of Richard series
- add target include in hw_common lib
- hw_common_lib uses -DCOMPILE_SYSTEM_VS_USER introduced by Richard series
- remove cpu-all header
- remove BSWAP_NEEDED define
- new tlb-flags header
- Cleanup i386 KVM_HAVE_MCE_INJECTION definition + move KVM_HAVE_MCE_INJECTION
- remove comment about cs_base in target/arm/cpu.h
- updated commit message about registers visibility between aarch32/aarch64
- tried remove ifdefs in target/arm/helper.c but this resulted in more a ugly
  result. So just comment calls for now, as we'll clean this file later.
- make most of the boards in hw/arm common

v3:
- rebase on top of Richard series and master
- BSWAP_NEEDED commit was already merged
- Update description for commits removing kvm related headers

Pierrick Bouvier (29):
  exec/cpu-all: extract tlb flags defines to exec/tlb-flags.h
  exec/cpu-all: move cpu_copy to linux-user/qemu.h
  include/exec/cpu-all: move compile time check for CPUArchState to
    cpu-target.c
  exec/cpu-all: remove system/memory include
  exec/cpu-all: remove exec/page-protection include
  exec/cpu-all: remove tswap include
  exec/cpu-all: remove exec/cpu-interrupt include
  exec/cpu-all: remove exec/cpu-defs include
  exec/cpu-all: remove exec/target_page include
  exec/cpu-all: remove hw/core/cpu.h include
  accel/tcg: fix missing includes for TCG_GUEST_DEFAULT_MO
  accel/tcg: fix missing includes for TARGET_HAS_PRECISE_SMC
  exec/cpu-all: remove cpu include
  exec/cpu-all: transfer exec/cpu-common include to cpu.h headers
  exec/cpu-all: remove this header
  exec/target_page: runtime defintion for TARGET_PAGE_BITS_MIN
  accel/kvm: move KVM_HAVE_MCE_INJECTION define to kvm-all.c
  exec/poison: KVM_HAVE_MCE_INJECTION can now be poisoned
  target/arm/cpu: always define kvm related registers
  target/arm/cpu: flags2 is always uint64_t
  target/arm/cpu: define same set of registers for aarch32 and aarch64
  target/arm/cpu: remove inline stubs for aarch32 emulation
  meson: add common hw files
  hw/arm/boot: make compilation unit hw common
  hw/arm/armv7m: prepare compilation unit to be common
  hw/arm/digic_boards: prepare compilation unit to be common
  hw/arm/xlnx-zynqmp: prepare compilation unit to be common
  hw/arm/xlnx-versal: prepare compilation unit to be common
  hw/arm: make most of the compilation units common

 meson.build                             |  37 +++++++-
 accel/tcg/internal-target.h             |   1 +
 accel/tcg/tb-internal.h                 |   1 -
 hw/s390x/ipl.h                          |   2 +
 include/exec/cpu_ldst.h                 |   1 +
 include/exec/exec-all.h                 |   1 +
 include/exec/poison.h                   |   4 +
 include/exec/target_page.h              |   3 +
 include/exec/{cpu-all.h => tlb-flags.h} |  26 +-----
 include/hw/core/cpu.h                   |   2 +-
 include/qemu/bswap.h                    |   2 +-
 include/system/kvm.h                    |   2 -
 linux-user/qemu.h                       |   3 +
 linux-user/sparc/target_syscall.h       |   2 +
 target/alpha/cpu.h                      |   4 +-
 target/arm/cpu.h                        |  40 ++------
 target/arm/internals.h                  |   1 +
 target/avr/cpu.h                        |   4 +-
 target/hexagon/cpu.h                    |   3 +-
 target/hppa/cpu.h                       |   5 +-
 target/i386/cpu.h                       |   5 +-
 target/i386/hvf/vmx.h                   |   1 +
 target/loongarch/cpu.h                  |   4 +-
 target/m68k/cpu.h                       |   4 +-
 target/microblaze/cpu.h                 |   4 +-
 target/mips/cpu.h                       |   4 +-
 target/openrisc/cpu.h                   |   4 +-
 target/ppc/cpu.h                        |   4 +-
 target/ppc/mmu-hash32.h                 |   2 +
 target/ppc/mmu-hash64.h                 |   2 +
 target/riscv/cpu.h                      |   4 +-
 target/rx/cpu.h                         |   4 +-
 target/s390x/cpu.h                      |   4 +-
 target/sh4/cpu.h                        |   4 +-
 target/sparc/cpu.h                      |   4 +-
 target/tricore/cpu.h                    |   3 +-
 target/xtensa/cpu.h                     |   4 +-
 accel/kvm/kvm-all.c                     |   5 +
 accel/tcg/cpu-exec.c                    |   3 +-
 accel/tcg/cputlb.c                      |   1 +
 accel/tcg/tb-maint.c                    |   1 +
 accel/tcg/translate-all.c               |   1 +
 accel/tcg/user-exec.c                   |   2 +
 cpu-target.c                            |   5 +
 hw/alpha/dp264.c                        |   1 +
 hw/alpha/typhoon.c                      |   1 +
 hw/arm/armv7m.c                         |   8 +-
 hw/arm/boot.c                           |   2 +
 hw/arm/digic_boards.c                   |   2 +-
 hw/arm/smmuv3.c                         |   1 +
 hw/arm/xlnx-versal.c                    |   2 -
 hw/arm/xlnx-zynqmp.c                    |   2 -
 hw/hppa/machine.c                       |   1 +
 hw/i386/multiboot.c                     |   1 +
 hw/i386/pc.c                            |   1 +
 hw/i386/pc_sysfw_ovmf.c                 |   1 +
 hw/i386/vapic.c                         |   1 +
 hw/loongarch/virt.c                     |   1 +
 hw/m68k/next-cube.c                     |   1 +
 hw/m68k/q800.c                          |   1 +
 hw/m68k/virt.c                          |   1 +
 hw/openrisc/boot.c                      |   1 +
 hw/pci-host/astro.c                     |   1 +
 hw/ppc/e500.c                           |   1 +
 hw/ppc/mac_newworld.c                   |   1 +
 hw/ppc/mac_oldworld.c                   |   1 +
 hw/ppc/ppc.c                            |   1 +
 hw/ppc/ppc_booke.c                      |   1 +
 hw/ppc/prep.c                           |   1 +
 hw/ppc/spapr_hcall.c                    |   1 +
 hw/ppc/spapr_ovec.c                     |   1 +
 hw/riscv/riscv-iommu-pci.c              |   1 +
 hw/riscv/riscv-iommu.c                  |   1 +
 hw/s390x/s390-pci-bus.c                 |   1 +
 hw/s390x/s390-pci-inst.c                |   1 +
 hw/s390x/s390-skeys.c                   |   1 +
 hw/sparc/sun4m.c                        |   1 +
 hw/sparc64/sun4u.c                      |   1 +
 hw/xtensa/pic_cpu.c                     |   1 +
 monitor/hmp-cmds-target.c               |   1 +
 semihosting/uaccess.c                   |   2 +-
 target/alpha/helper.c                   |   2 +
 target/arm/gdbstub64.c                  |   1 +
 target/arm/helper.c                     |   6 ++
 target/arm/hvf/hvf.c                    |   1 +
 target/arm/ptw.c                        |   1 +
 target/arm/tcg/helper-a64.c             |   1 +
 target/arm/tcg/hflags.c                 |   4 +-
 target/arm/tcg/mte_helper.c             |   1 +
 target/arm/tcg/sve_helper.c             |   1 +
 target/arm/tcg/tlb-insns.c              |   1 +
 target/avr/helper.c                     |   2 +
 target/hexagon/translate.c              |   1 +
 target/i386/arch_memory_mapping.c       |   1 +
 target/i386/helper.c                    |   2 +
 target/i386/hvf/hvf.c                   |   1 +
 target/i386/kvm/hyperv.c                |   1 +
 target/i386/kvm/kvm.c                   |   1 +
 target/i386/kvm/xen-emu.c               |   1 +
 target/i386/sev.c                       |   1 +
 target/i386/tcg/system/excp_helper.c    |   2 +
 target/i386/tcg/system/misc_helper.c    |   1 +
 target/i386/tcg/system/tcg-cpu.c        |   1 +
 target/i386/xsave_helper.c              |   1 +
 target/loongarch/cpu_helper.c           |   1 +
 target/loongarch/tcg/translate.c        |   1 +
 target/m68k/helper.c                    |   1 +
 target/microblaze/helper.c              |   1 +
 target/microblaze/mmu.c                 |   1 +
 target/mips/tcg/system/cp0_helper.c     |   1 +
 target/mips/tcg/translate.c             |   1 +
 target/openrisc/mmu.c                   |   1 +
 target/ppc/excp_helper.c                |   1 +
 target/ppc/mmu-book3s-v3.c              |   1 +
 target/ppc/mmu-hash64.c                 |   1 +
 target/ppc/mmu-radix64.c                |   1 +
 target/riscv/cpu_helper.c               |   1 +
 target/riscv/op_helper.c                |   1 +
 target/riscv/pmp.c                      |   1 +
 target/riscv/vector_helper.c            |   2 +
 target/rx/cpu.c                         |   1 +
 target/s390x/helper.c                   |   1 +
 target/s390x/ioinst.c                   |   1 +
 target/s390x/tcg/mem_helper.c           |   1 +
 target/sparc/ldst_helper.c              |   1 +
 target/sparc/mmu_helper.c               |   2 +
 target/tricore/helper.c                 |   1 +
 target/xtensa/helper.c                  |   1 +
 target/xtensa/mmu_helper.c              |   1 +
 target/xtensa/op_helper.c               |   1 +
 target/xtensa/xtensa-semi.c             |   1 +
 tcg/tcg-op-ldst.c                       |   2 +-
 hw/arm/meson.build                      | 117 ++++++++++++------------
 133 files changed, 286 insertions(+), 169 deletions(-)
 rename include/exec/{cpu-all.h => tlb-flags.h} (84%)

-- 
2.39.5


