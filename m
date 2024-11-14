Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6273CD68B37
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHt-0004uG-4I; Thu, 14 Nov 2024 11:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHp-0004tq-F6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:37 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHm-0002Ap-5f
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:35 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e9b4a5862fso689559a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600092; x=1732204892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QVGSdFiqO43cr6UXltR0+MwH185de3YRvkOGzcDGoKM=;
 b=BFQ4Tvu0i1loArZRewax9ylvw3tGVr/RUak59kSHb/iH3Rbc88FOfxCULg3qQt7CEj
 /mFfpBnDRYBYVW2pUbmnCADHj0P94lGnLWzOL4kmu1zQhVmzqldTTzT6XX7h5FBlLFk4
 0VP5bvuLzwlIVMJ1qqFQCn53wqYc53MOwTUlplqavlaxdtE4FMhpWi6lhJbsIWxc50hU
 iLG/5Y/lOcuYj3D90APZi6pEJc0jcKBHsmfaHNC+sXRgS4rnGb1Uffgrks13x0gFHrZE
 2SnUN6aQ5h14FHw0+IWyrqgChkJCrJLBZnWUt6T8KpIni4WQlS4Vt/X+KLjIO+P2bVnx
 Q7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600092; x=1732204892;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QVGSdFiqO43cr6UXltR0+MwH185de3YRvkOGzcDGoKM=;
 b=KWvM3sfGVQE1AFkNY4vX3zzzuA9gpciAn7cG5AZHlWWQ1/JTb6H3nqNvSY+pPerGtU
 9xX691WV4mwc6k9TyCbLMvH+bJoanWLSREKZvpwwNowXrR4GBT8BpGKZ1yy4kBzfE0a7
 38Gxa5s9i6ZhHveBL7AMgPuqqoaBD8jGzfScsgR+NMzSKuan1YCN15+bYlDxZ/xJklpR
 rEJehyw0X0WRWMq3M4ZM1q3O/wDFg462l+6+oXrUVRbjfUMRCe2kNYetQWK1C276WqBv
 7mAt6IoWrcKg9BNpuh6Bb5qAzlHeaddJ0/sUcwdG40W2bCuAMNB27Al2ISYod/TPdcYl
 K5Yg==
X-Gm-Message-State: AOJu0Yz2jW4Dj1hf/9JzA/ZYvu/ImSOGAueWGMXIxbFZBWTrM2Df43C1
 Uy9MXFeKE5pmx+f8T5njf8T8XFF4yljDo1oQLjHSUZR86YP2YlzpRrk7Db3X+2WhhfPAFS8jH5z
 O
X-Google-Smtp-Source: AGHT+IHr7XqjA80mRhcQEo7QOcUBo6FOmux2L9l/kEv6qXO97fdzKXWRPY8zMw1SHXOB0VBPEpEfCg==
X-Received: by 2002:a17:90b:2e46:b0:2e0:853a:af47 with SMTP id
 98e67ed59e1d1-2e9e4ca07e5mr14320308a91.33.1731600092202; 
 Thu, 14 Nov 2024 08:01:32 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
Date: Thu, 14 Nov 2024 08:00:36 -0800
Message-ID: <20241114160131.48616-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

v1: 20241009150855.804605-1-richard.henderson@linaro.org

The initial idea was: how much can we do with an intelligent data
structure for the same cost as a linear search through an array?


r~


Richard Henderson (54):
  util/interval-tree: Introduce interval_tree_free_nodes
  accel/tcg: Split out tlbfast_flush_locked
  accel/tcg: Split out tlbfast_{index,entry}
  accel/tcg: Split out tlbfast_flush_range_locked
  accel/tcg: Fix flags usage in mmu_lookup1, atomic_mmu_lookup
  accel/tcg: Assert non-zero length in tlb_flush_range_by_mmuidx*
  accel/tcg: Assert bits in range in tlb_flush_range_by_mmuidx*
  accel/tcg: Flush entire tlb when a masked range wraps
  accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
  accel/tcg: Populate IntervalTree in tlb_set_page_full
  accel/tcg: Remove IntervalTree entry in tlb_flush_page_locked
  accel/tcg: Remove IntervalTree entries in tlb_flush_range_locked
  accel/tcg: Process IntervalTree entries in tlb_reset_dirty
  accel/tcg: Process IntervalTree entries in tlb_set_dirty
  accel/tcg: Use tlb_hit_page in victim_tlb_hit
  accel/tcg: Pass full addr to victim_tlb_hit
  accel/tcg: Replace victim_tlb_hit with tlbtree_hit
  accel/tcg: Remove the victim tlb
  accel/tcg: Remove tlb_n_used_entries_inc
  include/exec/tlb-common: Move CPUTLBEntryFull from hw/core/cpu.h
  accel/tcg: Delay plugin adjustment in probe_access_internal
  accel/tcg: Call cpu_ld*_code_mmu from cpu_ld*_code
  accel/tcg: Check original prot bits for read in atomic_mmu_lookup
  accel/tcg: Preserve tlb flags in tlb_set_compare
  accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_full_mmu
  accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_full
  accel/tcg: Return CPUTLBEntryFull not pointer in probe_access_internal
  accel/tcg: Introduce tlb_lookup
  accel/tcg: Partially unify MMULookupPageData and TLBLookupOutput
  accel/tcg: Merge mmu_lookup1 into mmu_lookup
  accel/tcg: Always use IntervalTree for code lookups
  accel/tcg: Link CPUTLBEntry to CPUTLBEntryTree
  accel/tcg: Remove CPUTLBDesc.fulltlb
  target/alpha: Convert to TCGCPUOps.tlb_fill_align
  target/avr: Convert to TCGCPUOps.tlb_fill_align
  target/i386: Convert to TCGCPUOps.tlb_fill_align
  target/loongarch: Convert to TCGCPUOps.tlb_fill_align
  target/m68k: Convert to TCGCPUOps.tlb_fill_align
  target/m68k: Do not call tlb_set_page in helper_ptest
  target/microblaze: Convert to TCGCPUOps.tlb_fill_align
  target/mips: Convert to TCGCPUOps.tlb_fill_align
  target/openrisc: Convert to TCGCPUOps.tlb_fill_align
  target/ppc: Convert to TCGCPUOps.tlb_fill_align
  target/riscv: Convert to TCGCPUOps.tlb_fill_align
  target/rx: Convert to TCGCPUOps.tlb_fill_align
  target/s390x: Convert to TCGCPUOps.tlb_fill_align
  target/sh4: Convert to TCGCPUOps.tlb_fill_align
  target/sparc: Convert to TCGCPUOps.tlb_fill_align
  target/tricore: Convert to TCGCPUOps.tlb_fill_align
  target/xtensa: Convert to TCGCPUOps.tlb_fill_align
  accel/tcg: Drop TCGCPUOps.tlb_fill
  accel/tcg: Unexport tlb_set_page*
  accel/tcg: Merge tlb_fill_align into callers
  accel/tcg: Return CPUTLBEntryTree from tlb_set_page_full

 include/exec/cpu-all.h               |   3 +
 include/exec/exec-all.h              |  65 +-
 include/exec/tlb-common.h            |  68 +-
 include/hw/core/cpu.h                |  75 +-
 include/hw/core/tcg-cpu-ops.h        |  10 -
 include/qemu/interval-tree.h         |  11 +
 target/alpha/cpu.h                   |   6 +-
 target/avr/cpu.h                     |   7 +-
 target/i386/tcg/helper-tcg.h         |   6 +-
 target/loongarch/internals.h         |   7 +-
 target/m68k/cpu.h                    |   7 +-
 target/microblaze/cpu.h              |   7 +-
 target/mips/tcg/tcg-internal.h       |   6 +-
 target/openrisc/cpu.h                |   8 +-
 target/ppc/internal.h                |   7 +-
 target/riscv/cpu.h                   |   8 +-
 target/s390x/s390x-internal.h        |   7 +-
 target/sh4/cpu.h                     |   8 +-
 target/sparc/cpu.h                   |   8 +-
 target/tricore/cpu.h                 |   7 +-
 target/xtensa/cpu.h                  |   8 +-
 accel/tcg/cputlb.c                   | 994 +++++++++++++--------------
 target/alpha/cpu.c                   |   2 +-
 target/alpha/helper.c                |  23 +-
 target/arm/ptw.c                     |  10 +-
 target/arm/tcg/helper-a64.c          |   4 +-
 target/arm/tcg/mte_helper.c          |  15 +-
 target/arm/tcg/sve_helper.c          |   6 +-
 target/avr/cpu.c                     |   2 +-
 target/avr/helper.c                  |  19 +-
 target/i386/tcg/sysemu/excp_helper.c |  36 +-
 target/i386/tcg/tcg-cpu.c            |   2 +-
 target/loongarch/cpu.c               |   2 +-
 target/loongarch/tcg/tlb_helper.c    |  17 +-
 target/m68k/cpu.c                    |   2 +-
 target/m68k/helper.c                 |  32 +-
 target/microblaze/cpu.c              |   2 +-
 target/microblaze/helper.c           |  33 +-
 target/mips/cpu.c                    |   2 +-
 target/mips/tcg/sysemu/tlb_helper.c  |  29 +-
 target/openrisc/cpu.c                |   2 +-
 target/openrisc/mmu.c                |  39 +-
 target/ppc/cpu_init.c                |   2 +-
 target/ppc/mmu_helper.c              |  21 +-
 target/riscv/cpu_helper.c            |  22 +-
 target/riscv/tcg/tcg-cpu.c           |   2 +-
 target/rx/cpu.c                      |  19 +-
 target/s390x/cpu.c                   |   4 +-
 target/s390x/tcg/excp_helper.c       |  23 +-
 target/sh4/cpu.c                     |   2 +-
 target/sh4/helper.c                  |  24 +-
 target/sparc/cpu.c                   |   2 +-
 target/sparc/mmu_helper.c            |  44 +-
 target/tricore/cpu.c                 |   2 +-
 target/tricore/helper.c              |  19 +-
 target/xtensa/cpu.c                  |   2 +-
 target/xtensa/helper.c               |  28 +-
 util/interval-tree.c                 |  20 +
 util/selfmap.c                       |  13 +-
 59 files changed, 938 insertions(+), 923 deletions(-)

-- 
2.43.0


