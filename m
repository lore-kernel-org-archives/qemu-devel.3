Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A91C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr38S-0004Yt-IV; Sat, 08 Mar 2025 17:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38N-0004UD-Ep
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:07 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38L-0005K0-DU
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:07 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22359001f1aso75154825ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474743; x=1742079543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UihH8FV8I3WaI8+feJvKker5AQ3UurTAvr56lvb4oSU=;
 b=L1bnRUSmq+0VaPQU+GGp6QWV/4BnEqsy+cUZQhai3JzzCsGlnd6AV1tViICtCMVp+F
 qY2vpO8grVu1cqVrWV0dhsH+LrUuh6jl1JZIGIoQlmEQxTzQlNUS2f77/ZT9cuN8DzwG
 uom9wmqfAsaNAZ5a2nwPFMVAWHa3CGN4xlAY52NNcaIylPRfLWSmAgmQtamtxWSG1mDt
 9HtvyPtsZ0dJGixVJQD3PtlYGT1bwZJRMvsmBJwdnNth9ekm7cfd1kCx2z+Bg886Yj2t
 0i4LpVJF/XHZOz4BxFqkHyfelkUuAeBlzlZ2fPmhrzQfivCox9S223RJMtRqDmY6qLe2
 oqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474743; x=1742079543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UihH8FV8I3WaI8+feJvKker5AQ3UurTAvr56lvb4oSU=;
 b=fwTrAvM0dQxv6UKSAfWEVrExYO+yizUjLqWzgG1rIVuSFROHBXWwHS4sPJJqTHp8Fm
 cXLU3yhMihNrhWvLRDkeGzPjyfJCXUmBSzQw4Q+qb7rYYmibW3hrfITrDQxWt81YaaiY
 LJhBKNvFO77Bv5JGnVbhul12FYcDV1KyIaqopDSWuzbeg6/0varS17har6flM6R0xhEx
 i2jb4XniIEXFXJmaY4bo78Mc/3JYPzSUcQek3OgwKq5OhtiDM9KwmtdfyMwGHVl7PxSw
 MBjlUnOnmwcOc+gWAKR5a9+lhlUL4ALuAELfVvnb0hyhpX64E4wk1J4D7GzzXndXPk7E
 Mjxw==
X-Gm-Message-State: AOJu0YxuhprHy4fY2imFuFFMoTBFLWNAFjMLy+XNMGjXnUi2lNL0m/D8
 MjJlHNrmOy4mpI7Xp7dBzF9xW9IUXZWQqnNMfROheLmexBU/yCihOZK4V2xAJdy1Y/V8LuOVm3P
 4
X-Gm-Gg: ASbGncuMN3uHJlzqC9M7myZyNDMU896aRrMlcQmPkZmX6267rmxCfKFDl3Hvfyr2UBC
 QzpT9k8+cCNihSJCG1T6ryJta6tx1iz5SUTAMBXJJ2Z4OBkKQuF+oHIbl+Lh+TEWetYpnIKHVqi
 6i07B0/bbZ+97/iHdvXXP7DHFs62K/7DPINMkyxlUgh86SD02ZHGBTrzWlk/1tBRuXvdrp2LKgH
 xSHQ2Mp2rQQHr8qMXKjwtXcIairavSWUUJYBkhtOD4708vKPGQI+lho8eAhJxPmXVN2rwbE1UZi
 EzPehv8UFnJ4v8lkuhSj/J3WmenytThUafAeSni1ghdniybDxrz3wmidqp7+PrT6AiIaHyu99hZ
 /
X-Google-Smtp-Source: AGHT+IE5bvuI+vucH+L3C0/dahGmyqWX9iDu5CbUVKzV9j3gb6hZ7lMX3zhAzefCFgoID6rKFR8/qw==
X-Received: by 2002:a17:903:1ca:b0:21b:d105:26b8 with SMTP id
 d9443c01a7336-2242887b209mr100897595ad.7.1741474743268; 
 Sat, 08 Mar 2025 14:59:03 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] tcg patch queue
Date: Sat,  8 Mar 2025 14:58:38 -0800
Message-ID: <20250308225902.1208237-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The following changes since commit 98c7362b1efe651327385a25874a73e008c6549e:

  Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into staging (2025-03-07 07:39:49 +0800)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250308

for you to fetch changes up to 9e2080766f037857fc366012aaefd6fead0a75f9:

  accel/tcg: Build tcg-runtime-gvec.c once (2025-03-08 10:06:48 -0800)

----------------------------------------------------------------
include/qemu: Tidy atomic128 headers.
include/exec: Split out cpu-interrupt.h
include/exec: Split many tlb_* declarations to cputlb.h
include/accel/tcg: Split out getpc.h
accel/tcg: system: Compile some files once
linux-user/main: Allow setting tb-size

----------------------------------------------------------------
Ilya Leoshkevich (1):
      linux-user/main: Allow setting tb-size

Philippe Mathieu-Daudé (11):
      accel/tcg: Restrict CPU_TLB_DYN_*_BITS definitions to accel/tcg/
      exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
      exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
      exec: Declare tlb_set_page_with_attrs() in 'exec/cputlb.h'
      exec: Declare tlb_set_page() in 'exec/cputlb.h'
      exec: Declare tlb_hit*() in 'exec/cputlb.h'
      exec: Declare tlb_flush*() in 'exec/cputlb.h'
      accel/tcg: Restrict GETPC_ADJ to 'tb-internal.h'
      qemu/atomic: Rename atomic128-cas.h headers using .h.inc suffix
      qemu/atomic: Rename atomic128-ldst.h headers using .h.inc suffix
      qemu/atomic128: Include missing 'qemu/atomic.h' header

Richard Henderson (11):
      include/exec: Move TARGET_PAGE_{SIZE,MASK,BITS} to target_page.h
      include/exec: Split out exec/cpu-interrupt.h
      accel/tcg: Compile watchpoint.c once
      system: Build watchpoint.c once
      accel/tcg: Build tcg-accel-ops.c once
      accel/tcg: Build tcg-accel-ops-icount.c once
      accel/tcg: Build tcg-accel-ops-rr.c once
      accel/tcg: Build tcg-accel-ops-mttcg.c once
      accel/tcg: Split out getpc.h
      accel/tcg: Build tcg-runtime.c once
      accel/tcg: Build tcg-runtime-gvec.c once

 accel/tcg/internal-common.h                        |   2 +
 accel/tcg/tb-internal.h                            |  40 +++-
 host/include/aarch64/host/atomic128-cas.h          |   2 +-
 include/accel/tcg/getpc.h                          |  24 ++
 include/exec/cpu-all.h                             |  97 +-------
 include/exec/cpu-defs.h                            |  26 --
 include/exec/cpu-interrupt.h                       |  70 ++++++
 include/exec/cputlb.h                              | 263 ++++++++++++++++++++-
 include/exec/exec-all.h                            | 262 +-------------------
 include/exec/poison.h                              |  17 --
 include/exec/ram_addr.h                            |   1 +
 include/exec/target_page.h                         |  58 ++++-
 include/qemu/atomic128.h                           |   5 +-
 accel/tcg/cputlb.c                                 |  23 ++
 accel/tcg/tcg-accel-ops-icount.c                   |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c                    |   1 -
 accel/tcg/tcg-accel-ops-rr.c                       |   2 +-
 accel/tcg/tcg-accel-ops.c                          |   2 +-
 accel/tcg/tcg-runtime-gvec.c                       |   1 -
 accel/tcg/tcg-runtime.c                            |   8 +-
 accel/tcg/watchpoint.c                             |   5 +-
 cpu-target.c                                       |   1 +
 hw/intc/armv7m_nvic.c                              |   2 +-
 hw/ppc/spapr_nested.c                              |   1 +
 hw/sh4/sh7750.c                                    |   1 +
 linux-user/main.c                                  |  12 +
 page-target.c                                      |  18 --
 page-vary-target.c                                 |   2 -
 system/physmem.c                                   |   1 +
 system/watchpoint.c                                |   3 +-
 target/alpha/helper.c                              |   2 +-
 target/alpha/sys_helper.c                          |   2 +-
 target/arm/helper.c                                |   1 +
 target/arm/tcg/tlb-insns.c                         |   2 +-
 target/avr/helper.c                                |   2 +-
 target/hppa/mem_helper.c                           |   1 +
 target/i386/helper.c                               |   2 +-
 target/i386/machine.c                              |   2 +-
 target/i386/tcg/fpu_helper.c                       |   2 +-
 target/i386/tcg/misc_helper.c                      |   2 +-
 target/i386/tcg/system/excp_helper.c               |   2 +-
 target/i386/tcg/system/misc_helper.c               |   2 +-
 target/i386/tcg/system/svm_helper.c                |   2 +-
 target/loongarch/tcg/csr_helper.c                  |   2 +-
 target/loongarch/tcg/tlb_helper.c                  |   1 +
 target/m68k/helper.c                               |   1 +
 target/microblaze/helper.c                         |   2 +-
 target/microblaze/mmu.c                            |   2 +-
 target/mips/system/cp0.c                           |   2 +-
 target/mips/tcg/system/cp0_helper.c                |   2 +-
 target/mips/tcg/system/tlb_helper.c                |   1 +
 target/openrisc/mmu.c                              |   2 +-
 target/openrisc/sys_helper.c                       |   1 +
 target/ppc/helper_regs.c                           |   2 +-
 target/ppc/misc_helper.c                           |   1 +
 target/ppc/mmu_helper.c                            |   1 +
 target/riscv/cpu_helper.c                          |   1 +
 target/riscv/csr.c                                 |   1 +
 target/riscv/op_helper.c                           |   1 +
 target/riscv/pmp.c                                 |   2 +-
 target/rx/cpu.c                                    |   2 +-
 target/s390x/gdbstub.c                             |   2 +-
 target/s390x/sigp.c                                |   1 +
 target/s390x/tcg/excp_helper.c                     |   1 +
 target/s390x/tcg/mem_helper.c                      |   1 +
 target/s390x/tcg/misc_helper.c                     |   1 +
 target/sh4/helper.c                                |   1 +
 target/sparc/ldst_helper.c                         |   1 +
 target/sparc/mmu_helper.c                          |   2 +-
 target/tricore/helper.c                            |   2 +-
 target/xtensa/helper.c                             |   2 +-
 target/xtensa/mmu_helper.c                         |   1 +
 accel/tcg/meson.build                              |  14 +-
 .../{atomic128-ldst.h => atomic128-ldst.h.inc}     |   0
 .../host/{atomic128-cas.h => atomic128-cas.h.inc}  |   0
 .../{atomic128-ldst.h => atomic128-ldst.h.inc}     |   0
 .../{atomic128-ldst.h => atomic128-ldst.h.inc}     |   0
 .../{atomic128-ldst.h => atomic128-ldst.h.inc}     |   2 +-
 .../x86_64/host/load-extract-al16-al8.h.inc        |   2 +-
 system/meson.build                                 |   2 +-
 80 files changed, 552 insertions(+), 486 deletions(-)
 create mode 100644 include/accel/tcg/getpc.h
 create mode 100644 include/exec/cpu-interrupt.h
 rename host/include/aarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/generic/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)
 rename host/include/generic/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/loongarch64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (100%)
 rename host/include/x86_64/host/{atomic128-ldst.h => atomic128-ldst.h.inc} (96%)

