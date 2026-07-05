Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E7BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEbq-0004i3-E8; Sun, 05 Jul 2026 00:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbm-0004g8-Fg
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbh-0003wl-P4
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ca70925c25so22575265ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226247; x=1783831047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kjTtIsN3nY1hYvokr33aF50VbP0gmCj1u2mZaTHrD68=;
 b=bUeFw1ZxzZQeg+x/HR5Rw4uxaK9DkGBkPsP1y9Rbm6rEzjvZY8jhBrrpflwU1d53pe
 YC4BDHoX8AK4LvdGvhD+bHgFNoWIZ+MJbrcU9jog+jkr1gIgiKi58gQZ2KPONNc0KTDd
 xZT7LtndnDMwEtRJpEUddohLJEGRvMICQ5MnCHgHgD778cejT34sxeMHYc4LxAaQyeD5
 l83DW4mBR0fzdlwNH9hO8XtaqFGu5PDEljIbcGp1ShIk4ctfw9VWc4nk+dYq7TYrQozH
 u02GQSS0bt1jWzH23H5XXAPHkfdunDfHjd9zLyKeMq/DfO3P7XJ9JpuJ9rXlIMuAEaIX
 wuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226247; x=1783831047;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kjTtIsN3nY1hYvokr33aF50VbP0gmCj1u2mZaTHrD68=;
 b=feVxjoLyc+rm+gZBxinbckDUIafsX9Gu5+aSzLnNP/8mwSlH4I5Ab5MroDBSq1PlGt
 c0aw9flPltbUukTcrQrYmPj7qAzspB4CfO3pgIX5BjqdRSTYXm9pbTqN6YWMQE2YF1xu
 9IfLhDEVDXfAX81ebcd0wKqEqmoN8r8+a8EOh3Qf2ZlAJNNbhdQQSw/z31st4ZAA6KPj
 7SeAXI88Z8OY1pZD1FGwmQmx8Ej7VnUrKsebC4su5LQx8GX22qwcy/yNkEvR7gmur/QG
 x752h7vCwlXjkr6emWCUof08EQ40VaiFB+hYfLNP44pC0k/myadYmBqzPO649KRY0lB6
 EI/Q==
X-Gm-Message-State: AOJu0Yz3SvoZTKVEXtGEdjtBxZChrzckB4f+Zu3oTTiBeWLxqGNhF05L
 Q5nXaBos7t/vjfu1jsVNJYH9ra1KcAhuJC3VMQRaJrQbS4aBe+3T7hKn7ECyU2pzCQwPFQ+jnnn
 fREjh
X-Gm-Gg: AfdE7cl45MYE3+Uwzfgp8i2zU3Dhs1emGzuHIPeaRlY1RtKJb+9RYPQoLtWUIP8EzVH
 GjK4sGzcXzeV6e+1gYVPnXIvZ+2cepETqOps7/1LqYrgL0/oysiT9xa1vs1TATn6o+5AvB0wmOY
 jPqr8nyIKB9lQjcELg+JMOtOX5MUDtklbt8cyd10AFKFahB2gTIWelfj2VmylCMSLv7TDxVfBvC
 w4/gI4nA6OvTYpv4k4z4StDpUbSIs0HmqmusydrJAheySduYS2WlCcUCDhYufupJ9Vm8cD5LDTz
 OSka9AXZbvx4bKy14tPw/7qr/rvAtWTKkAk52GhogyumucDLIRobw3EOWDNQT3R3yiSIpP0IFZO
 uKEzn8y22/7XxNCCAl4JK0c6neyu7AwGaQB14IhmD6fcgaDw9COZ5/+g3JSW1vVL+EbBdP+eg8j
 PPZRNvwhon9aFcp9GmW7A7PzAp+Q/24GMjsnUXk+CeQSg7lPI=
X-Received: by 2002:a17:902:d551:b0:2c9:d55d:2d1 with SMTP id
 d9443c01a7336-2cbb9ebc1admr53990035ad.33.1783226247220; 
 Sat, 04 Jul 2026 21:37:27 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 00/46] accel/tcg: Use IntervalTree for breakpoints and
 watchpoints
Date: Sat,  4 Jul 2026 21:36:39 -0700
Message-ID: <20260705043725.1373137-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Beyond using interval-tree for breakpoints:

  - Pass the matching breakpoint to the target debug hook,
  - Allow the target to record an id/index for each BP or WP
    so that the target doesn't have to search for which item
    triggered, so that the target doesn't have to search again.
  - Convert both BP and WP to IntervalTree.
  - Merge CPUBreakpoint and CPUWatchpoint.
  - Clean up tcg_ops->debug_excp_hander implementations.

On the to-do list:

  - Handle ARMv6 BE-32 within debug_check_watchpoint,
    which will allow dropping adjust_watchpoint_address.
  - Change cpu_watchpoint_insert from addr+len to first+last.
    This will allow the entire address space to be covered with
    a single call (existing workaround in s390x; also possible with
    unimplemented Arm not-matched address trigger).
  - Breakpoint ranges, for Arm FEAT_BWE.


r~


Philippe Mathieu-Daudé (4):
  cpu: Move BREAKPOINT definitions to 'exec/breakpoint.h'
  cpu: Define BreakpointFlags type
  target/arm: Inline check_watchpoints() in arm_debug_check_watchpoint()
  accel/tcg: Improve docstrings around TCGCPUOps::*watchpoint* handlers

Richard Henderson (42):
  cpu: Move cpu_breakpoint_test out of line
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

 include/accel/tcg/cpu-ops.h         |  17 +--
 include/exec/breakpoint.h           |  47 ++++++--
 include/exec/watchpoint.h           |  18 ---
 include/hw/core/cpu.h               |  46 +-------
 include/qemu/typedefs.h             |   1 +
 target/arm/cpu.h                    |   4 +-
 target/arm/internals.h              |  13 +--
 target/i386/cpu.h                   |   4 +-
 target/i386/tcg/helper-tcg.h        |   4 +-
 target/ppc/cpu.h                    |   4 +-
 target/ppc/internal.h               |   6 +-
 target/riscv/cpu.h                  |   4 +-
 target/riscv/debug.h                |   5 +-
 target/s390x/tcg/tcg_s390x.h        |   2 +-
 target/xtensa/cpu.h                 |   8 +-
 accel/tcg/cpu-exec.c                |  76 +++++++------
 accel/tcg/cputlb.c                  |  12 +-
 accel/tcg/tcg-accel-ops.c           |  34 +++---
 accel/tcg/user-exec-stub.c          |  19 ++--
 accel/tcg/watchpoint.c              | 166 ++++++++++++++++------------
 accel/whpx/whpx-common.c            |   9 +-
 cpu-common.c                        |  69 +++++++-----
 gdbstub/system.c                    |  50 +++++----
 gdbstub/user.c                      |   9 +-
 hw/core/cpu-common.c                |   2 -
 linux-user/main.c                   |  14 ++-
 system/watchpoint.c                 |  73 ++++++------
 target/arm/debug_helper.c           |   2 +-
 target/arm/hvf/hvf.c                |   6 +-
 target/arm/hyp_gdbstub.c            |   7 +-
 target/arm/kvm.c                    |   5 +-
 target/arm/tcg/debug.c              | 120 +++++---------------
 target/arm/tcg/mte_helper.c         |   3 +-
 target/i386/cpu.c                   |   2 +-
 target/i386/kvm/kvm.c               |  11 +-
 target/i386/machine.c               |   2 +-
 target/i386/tcg/bpt_helper.c        |   2 +-
 target/i386/tcg/system/bpt_helper.c |  81 ++++++--------
 target/i386/tcg/tcg-cpu.c           |   2 +-
 target/i386/whpx/whpx-all.c         |  15 +--
 target/ppc/cpu.c                    |   9 +-
 target/ppc/cpu_init.c               |   2 +-
 target/ppc/kvm.c                    |  14 ++-
 target/ppc/tcg-excp_helper.c        |  85 ++++++--------
 target/riscv/cpu_helper.c           |   6 +-
 target/riscv/debug.c                | 159 ++++----------------------
 target/riscv/tcg/tcg-cpu.c          |   4 +-
 target/s390x/helper.c               |   1 -
 target/s390x/kvm/kvm.c              |   7 +-
 target/s390x/tcg/debug.c            |  22 ++--
 target/xtensa/cpu.c                 |   2 +-
 target/xtensa/dbg_helper.c          |  31 ++----
 target/xtensa/helper.c              |  46 +++-----
 53 files changed, 568 insertions(+), 794 deletions(-)
 delete mode 100644 include/exec/watchpoint.h

-- 
2.43.0


