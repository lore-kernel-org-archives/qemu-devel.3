Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFDFC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CnT-0005rL-Kc; Sun, 28 Apr 2024 18:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CnR-0005qZ-5h
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:14:57 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CnP-0005Iy-Bg
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:14:56 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so60046191fa.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342493; x=1714947293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NkmGbudnrJtNwyNN6UVpWTp8hpDxi5DDSc2WDzHrtzE=;
 b=Of6c8GvIb1+MTcfSyKgpNr4mwdOzKFuynKp88ShhMZu4ggATSRY1nW7/AlaDd6SBHE
 ZVWmSK0GsvOW6oa4avVeGJaIS0pO7m+trSCrBWztKXX0f1Bau4KYBwfRO9T+khObzqxQ
 9Ec5hsAMNkY6ojmsTwbONmqFnYB9inqEJXQFM6YZK/4KIDzKt8DwJfHal9NUpYPAL6fL
 yWfzOcaYqW2VKEWGYFAv+ZI1beznKuT30B29w/RR2LJLeLdKJ1AXrmO9OsAmignQl8fV
 rCryTFao4D3FLfeA+jRTgG4DZ2FFB1t1gcKxJStQJQHw1BymgoznESHdZAdfgGWmikcr
 r/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342493; x=1714947293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NkmGbudnrJtNwyNN6UVpWTp8hpDxi5DDSc2WDzHrtzE=;
 b=HhQatGolMH0UUnviqlgcTxeekWQVkcFkb4g0+b+J/00MhookLn2y3RJeyxLg2ugOGJ
 dKeCU8hlFtPjzu6nybe+q3hXGALnRmiuBx8LTxVsK8Pfe/UU+y2RAC6NGnoWihtYYkL8
 1ekyk3Avj7Ga8FnB4UPNsqJ2k+iavxxIMrq5sTllPM8VkUkAKfepfovAR2pUjW/Mx9wT
 y8Mou3n1dDoN1J1qLsTCX1KKkk1UQOdUq1Uw29wwK0yijWZdYPmk5Cs3kbiCE5f9e3/9
 uumt0lp5bTG0Io9MV2o3XR8QBxB5NUFX5c2GHScd2Y0/H05TPx07FTalaNuDeYk5OfzA
 6umQ==
X-Gm-Message-State: AOJu0YyjDp643y6356AbKkfFrY6b6YXE+uxjci5TIHu8sq0kM1YoNTLi
 tfr1vdqPwmsHuQNLzLFsz4JYKPEw476BJkEsR/C/yj4b+RyQkV/ySahxfz2xsl5XrUbq+nwoAoN
 m
X-Google-Smtp-Source: AGHT+IFL/C/jIzaWFAQxnPs7vUpuknpb2Wich+p3hUwtdUOc0E8V9VX7B9lHjPyvAMxoG4bMh5Q/0A==
X-Received: by 2002:a2e:b162:0:b0:2e0:69b4:d65c with SMTP id
 a2-20020a2eb162000000b002e069b4d65cmr843565ljm.7.1714342493111; 
 Sun, 28 Apr 2024 15:14:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 hg7-20020a170906f34700b00a4e5a6b57a2sm13116213ejb.163.2024.04.28.15.14.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:14:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/24] exec: Rework around CPUState user fields (part 2)
Date: Mon, 29 Apr 2024 00:14:26 +0200
Message-ID: <20240428221450.26460-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

Finish extracting TCG fields from CPUState:
- Extract tcg_cpu_exit() from cpu_exit()
- Introduce AccelOpsClass::exit_vcpu_thread()
- cpu_exit() calls exit_vcpu_thread=tcg_cpu_exit for TCG
- Forward declare TaskState and more uses of get_task_state()
- Introduce TCG AccelCPUState
- Move TCG specific fields from CPUState to AccelCPUState
- Restrict "exec/tlb-common.h" to TCG
- Restrict iommu_notifiers, icount to system emulation

Based-on: <20240428214915.10339-1-philmd@linaro.org>

Philippe Mathieu-Daudé (24):
  exec/user: Move 'thunk.h' from 'exec/user' to 'user'
  coverity: Update user emulation regexp
  accel/tcg: Move user definition of cpu_interrupt() to user-exec.c
  accel/tcg: Duplicate cpu_exit() for user / system
  accel/tcg: Extract tcg_cpu_exit() from cpu_exit()
  accel: Introduce AccelOpsClass::exit_vcpu_thread() handler
  accel/tcg: Implement AccelOpsClass::exit_vcpu_thread() handler
  user: Forward declare TaskState type definition
  user: Declare get_task_state() once in 'accel/tcg/vcpu-state.h'
  user: Use get_task_state() helper
  accel/tcg: Allocate per-vCPU accel state in create_vcpu_thread()
  accel/tcg: Move TaskState from CPUState to TCG AccelCPUState
  accel/tcg: Update CPUNegativeOffsetState::can_do_io field
    documentation
  accel/tcg: Move plugin fields to CPUNegativeOffsetState
  accel/tcg: Restrict IcountDecr and CPUTLB to TCG
  accel/tcg: Move @jmp_env from CPUState to TCG AccelCPUState
  accel/tcg: Move @mem_io_pc from CPUState to TCG AccelCPUState
  accel/tcg: Move @cflags_next_tb from CPUState to TCG AccelCPUState
  accel/tcg: Move @iommu_notifiers from CPUState to TCG AccelCPUState
  accel/tcg: Move @tb_jmp_cache from CPUState to TCG AccelCPUState
  accel/tcg: Remove NULL check in tcg_flush_jmp_cache()
  accel/tcg: Move @tcg_cflags from CPUState to TCG AccelCPUState
  accel/tcg: Restrict icount to system emulation
  accel/tcg: Move icount fields from CPUState to TCG AccelCPUState

 accel/tcg/internal-common.h         |  3 ++
 accel/tcg/tb-jmp-cache.h            |  4 +-
 accel/tcg/tcg-accel-ops.h           |  1 +
 accel/tcg/vcpu-state.h              | 45 +++++++++++++++++++++++
 bsd-user/qemu.h                     | 12 ++----
 include/exec/tlb-common.h           |  4 ++
 include/hw/core/cpu.h               | 57 +++++++++++------------------
 include/qemu/plugin.h               |  2 +-
 include/qemu/typedefs.h             |  2 +-
 include/sysemu/accel-ops.h          |  1 +
 include/{exec => }/user/thunk.h     |  8 +++-
 linux-user/qemu.h                   | 10 ++---
 linux-user/user-internals.h         |  2 +-
 accel/tcg/cpu-exec-common.c         |  2 +-
 accel/tcg/cpu-exec.c                | 51 ++++++++++++++------------
 accel/tcg/cputlb.c                  |  4 +-
 accel/tcg/icount-common.c           |  7 ++--
 accel/tcg/plugin-gen.c              |  8 ++--
 accel/tcg/tb-maint.c                |  6 +--
 accel/tcg/tcg-accel-ops-icount.c    | 14 +++----
 accel/tcg/tcg-accel-ops-mttcg.c     |  2 +
 accel/tcg/tcg-accel-ops-rr.c        |  2 +
 accel/tcg/tcg-accel-ops.c           |  5 +++
 accel/tcg/translate-all.c           | 25 +++++--------
 accel/tcg/user-exec.c               | 14 +++++++
 accel/tcg/watchpoint.c              |  5 ++-
 bsd-user/main.c                     |  2 +-
 gdbstub/gdbstub.c                   |  3 +-
 gdbstub/user-target.c               |  4 +-
 hw/core/cpu-common.c                | 13 +------
 hw/misc/mips_itu.c                  |  3 +-
 linux-user/main.c                   |  4 +-
 linux-user/syscall.c                |  6 +--
 linux-user/thunk.c                  |  2 +-
 plugins/core.c                      |  8 ++--
 system/cpus.c                       |  8 ++++
 system/physmem.c                    | 37 ++++++++++++++-----
 target/i386/helper.c                |  3 +-
 scripts/coverity-scan/COMPONENTS.md |  2 +-
 39 files changed, 235 insertions(+), 156 deletions(-)
 create mode 100644 accel/tcg/vcpu-state.h
 rename include/{exec => }/user/thunk.h (97%)

-- 
2.41.0


