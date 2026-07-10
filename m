Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BEDC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIEc-00012R-Qc; Fri, 10 Jul 2026 16:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEa-00011e-SG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIEX-0000ao-Aq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:54:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-848643382fcso1373182b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783716844; x=1784321644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fEZ0JdYQPiF4MtB15bZdOuQ7ReQG0VTLPTQcrU1J7Cc=;
 b=gysxetSOvhfUCa9SJXAnasldheiJfNqY5h6Nblfgas6/N7GMWKx4Eue7v8KMOJTq9T
 U+/whYnABGF5ylOpsp4Bs1yXf9mYjnfCTFPWig0tk7JoaCIca4qgeMlOZN/ZznPlX9ri
 +VmJSkLjqi+AlE2wFfnpM1vl3rgkbKiuZ/p6slwL4J7n/b8soeLhEKseUqsRmhhHz2Al
 UEJfbdi4+YlSDPLgdtvKhaHyTtQrI8sEQOD8h1pcaiuZECq906bcSHDK5Jo/ouJJIO5a
 ly/2LbuKmetYWUMRcBQ980VNY18qHWdXS4EgN82i8BI3uGRtxDzt6OIVkHHULueLjOnJ
 ogNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783716844; x=1784321644;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fEZ0JdYQPiF4MtB15bZdOuQ7ReQG0VTLPTQcrU1J7Cc=;
 b=Y91UfRNmIx7uxuvTzIXvwmEP/l7XfX4n9NWyGNjXp2p4qAb6JkCK3/+wlAmexAlRGR
 GaEBu9q/SgIvHoKjc2ZvKC/DInHkJtgWoR4TZW98gDhKZVJhlNhMMstzQA4FbOu+x38j
 YywKvXotan8yCcMlM50p7Hu3wWQevR4SDhg/2Aokerwu3oZgOqkS0DC9PtH86NGpaApW
 1278q2n3YNtTLgWvicETENsYKcWV3RL83Mls3u6cpz8VfvkPKOe2Qdfp9wB6mcquRzHC
 Q9jGY3npkO/8MqLaZU6EYKu5QgNZDlJhmaYh1DP1NLWWQE8tRYVy8vZBnsNFNIJyV3HH
 MfWA==
X-Gm-Message-State: AOJu0YwioF6N2dlPe+E0m6++/xKt2/1IyV52IidZ30I8BUtZx76O9MXo
 7Gji8NMPF3e3gZ3p3OuoTdPTPtzfha3S77XMY3sym2dlqufz9+tjPUjA1UklQxS6RJMZ36AWQBV
 DvC1Q
X-Gm-Gg: AfdE7cl8l61Uyygr2fTD/fuhX9HQ74MPHJBbN3aqY0NSRcx45DcrctuSA7ie0xK4c3p
 z7lgbTwsKe8MFkkQV656njvDHKqwKlNPaluDjuFmmBSjbVNOaSOXI0zkTL/nxKxYeiZ/yHSaOpV
 YIfZJpYx8EZVwxaKPOc9R6WJlPZQDNkBCWbwbkatTKKCixk8K/cIj71JP8HbXT1/3NIJuGjhJuJ
 WZheci8cF62xWxdzOoBCLpPrgc6AbtLs6hOBdmn9eeW7b6leSpl2CwyQ/z7w5LTJh0L3Uoju/09
 DdS2aKU51xX2r5mfO8GrdewnN55PGTxb40c+Z9P8p1y3EvnIQ0wt5gqBNnhkTXC1EwkwmkhkXyc
 RmwWdcDlQI1pS2sRO3vCnKaA+szzqJsiMFV1ZVKfly+8RBGyF1Imv0IlRZQu7xSDgWsR85PcIYP
 +ZliaVSgU7b+1blb3UEw==
X-Received: by 2002:a05:6a00:21cc:b0:848:7443:f2de with SMTP id
 d2e1a72fcca58-8488961c141mr519521b3a.13.1783716843457; 
 Fri, 10 Jul 2026 13:54:03 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6d76106sm10780574b3a.40.2026.07.10.13.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:54:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
Subject: [PATCH v3 00/51] accel/tcg: Use IntervalTree for breakpoints and
 watchpoints
Date: Fri, 10 Jul 2026 13:53:10 -0700
Message-ID: <20260710205401.836304-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Changes for v3:
  - Handle ARMv6 BE-32 within debug_check_watchpoint.
  - Drop adjust_watchpoint_address.
  - Change cpu_watchpoint_insert from addr+len to first+last.
    - Change tlb_flush_range_by_mmuidx to use first+last.
    - Use tlb_flush_range_by_mmuidx in cpu_watchpoint_insert.


r~


Philippe Mathieu-Daudé (1):
  cpu: Define BreakpointFlags type

Richard Henderson (50):
  exec/breakpoint: Move BP declarations from hw/core/cpu.h
  exec/breakpoint: Merge watchpoint.h
  qemu/typedefs: Declare CPUBreakpoint and CPUWatchpoint globally
  hw/core/cpu: Remove exec/breakpoint.h include
  exec/breakpoint: Add CPUBreakpoint.id
  exec/watchpoint: Add CPUWatchpoint.id
  accel/tcg: Pass CPUBreakpoint to debug_check_breakpoint
  target/arm: Split is_wp out of bp_wp_matches
  target/arm: Use bp argument in arm_debug_check_breakpoint
  target/arm: Use wp argument in arm_debug_check_watchpoint
  target/riscv: Use bp argument in riscv_cpu_debug_check_breakpoint
  target/riscv: Use bp argument in riscv_cpu_debug_check_watchpoint
  target/xtensa: Use bp argument in xtensa_debug_check_breakpoint
  cpu: Use interval-tree for CPUBreakpoint
  target/arm: Make check_watchpoint_in_range static
  gdbstub: Report actual watchpoint trigger address
  cpu: Use interval-tree for CPUWatchpoint
  exec/breakpoint: Return the new bp from cpu_breakpoint_insert
  system: Remove cpu_watchpoint_insert error return path
  exec/breakpoint: Return the new wp from cpu_watchpoint_insert
  system: Validate flags in cpu_watchpoint_insert
  cpu-common: Validate flags in cpu_breakpoint_insert
  exec/breakpoint: Add CPUWatchpoint.hitlast
  exec/breakpoint: Merge CPUBreakpoint and CPUWatchpoint
  accel/tcg: Pass watchpoint hit to debug_excp_handler
  accel/tcg: Pass breakpoint hit to debug_excp_handler
  target/arm: Use CPUBreakpoint arg in arm_debug_excp_handler
  target/i386: Pass wp_hit to check_hw_breakpoints
  target/i386: Use CPUBreakpoint arg in breakpoint_handler
  target/ppc: Use CPUBreakpoint arg in breakpoint_handler
  target/ppc: Simplify ppc_cpu_debug_check_breakpoint
  target/ppc: Simplify ppc_cpu_debug_check_watchpoint
  target/s390x: Use CPUBreakpoint arg in breakpoint_handler
  target/riscv: Simplify riscv_cpu_debug_excp_handler
  target/riscv: Set badaddr in riscv_cpu_debug_excp_handler
  target/riscv: Merge riscv_cpu_debug_check_{break,watch}point
  target/xtensa: Restrict xtensa_breakpoint_handler to system mode
  target/xtensa: Rename xtensa_breakpoint_handler
  target/xtensa: Simplify xtensa_cpu_debug_excp_handler
  accel/tcg: Clear BP_WATCHPOINT_HIT after use
  accel/tcg: Merge CPUState.{break,watch}point_hit
  target/arm: Simplify v6 watchpoints
  accel/tcg: Remove TCGCPUOps.adjust_watchpoint_address
  accel/tcg: Move ALL_MMUIDX_BITS to hw/core/cpu.h
  accel/tcg: Drop stale assert for vaddr
  accel/tcg: Use addr/last in tlb_flush_range_locked
  target/arm: Be more defensive for invalid tlbi_aa64_get_range
  accel/tcg: Change tlb_flush_range_* to use addr/last
  system: Use tlb_flush_range_by_mmuidx in cpu_watchpoint_insert
  accel/tcg: Change cpu_watchpoint_insert to use addr/last

 include/accel/tcg/cpu-ops.h         |  17 +-
 include/exec/breakpoint.h           |  36 ++--
 include/exec/cputlb.h               |  12 +-
 include/exec/watchpoint.h           |  18 --
 include/hw/core/cpu.h               |  21 +--
 include/qemu/typedefs.h             |   1 +
 target/arm/cpu.h                    |   4 +-
 target/arm/internals.h              |  18 +-
 target/i386/cpu.h                   |   4 +-
 target/i386/tcg/helper-tcg.h        |   4 +-
 target/ppc/cpu.h                    |   4 +-
 target/ppc/internal.h               |   6 +-
 target/riscv/cpu.h                  |   4 +-
 target/riscv/debug.h                |   5 +-
 target/s390x/tcg/tcg_s390x.h        |   2 +-
 target/xtensa/cpu.h                 |   8 +-
 accel/tcg/cpu-exec.c                |  76 ++++----
 accel/tcg/cputlb.c                  | 113 ++++++------
 accel/tcg/tcg-accel-ops.c           |  37 ++--
 accel/tcg/user-exec-stub.c          |  19 +-
 accel/tcg/watchpoint.c              | 170 +++++++++---------
 accel/whpx/whpx-common.c            |   9 +-
 cpu-common.c                        |  68 +++----
 gdbstub/system.c                    |  49 +++---
 gdbstub/user.c                      |   9 +-
 hw/core/cpu-common.c                |   2 -
 linux-user/main.c                   |  14 +-
 system/watchpoint.c                 |  80 ++++-----
 target/arm/cpu.c                    |   1 -
 target/arm/debug_helper.c           |  14 +-
 target/arm/hvf/hvf.c                |   6 +-
 target/arm/hyp_gdbstub.c            |   7 +-
 target/arm/kvm.c                    |   5 +-
 target/arm/tcg/cpu-v7m.c            |   1 -
 target/arm/tcg/debug.c              | 263 +++++++++++++---------------
 target/arm/tcg/mte_helper.c         |   3 +-
 target/arm/tcg/tlb-insns.c          |  23 +--
 target/hppa/mem_helper.c            |   3 +-
 target/i386/cpu.c                   |   2 +-
 target/i386/kvm/kvm.c               |  11 +-
 target/i386/machine.c               |   2 +-
 target/i386/tcg/bpt_helper.c        |   2 +-
 target/i386/tcg/system/bpt_helper.c |  81 ++++-----
 target/i386/tcg/tcg-cpu.c           |   2 +-
 target/i386/whpx/whpx-all.c         |  15 +-
 target/loongarch/tcg/tlb_helper.c   |   5 +-
 target/ppc/cpu.c                    |   9 +-
 target/ppc/cpu_init.c               |   2 +-
 target/ppc/kvm.c                    |  14 +-
 target/ppc/mmu_helper.c             |   4 +-
 target/ppc/tcg-excp_helper.c        |  85 ++++-----
 target/riscv/cpu_helper.c           |   6 +-
 target/riscv/debug.c                | 159 +++--------------
 target/riscv/tcg/tcg-cpu.c          |   4 +-
 target/s390x/helper.c               |   1 -
 target/s390x/kvm/kvm.c              |   7 +-
 target/s390x/tcg/debug.c            |  28 +--
 target/xtensa/cpu.c                 |   2 +-
 target/xtensa/dbg_helper.c          |  31 ++--
 target/xtensa/helper.c              |  46 ++---
 60 files changed, 732 insertions(+), 922 deletions(-)
 delete mode 100644 include/exec/watchpoint.h

-- 
2.43.0


