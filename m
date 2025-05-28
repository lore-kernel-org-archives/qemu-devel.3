Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DBCC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwz-0000a3-NJ; Wed, 28 May 2025 04:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvb-0007u3-WD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvY-0005Ch-Nd
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so36106195e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420053; x=1749024853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zn2kS2/blDmE/dhNRdfZMHqO89DPMTyDSFgQ1HTtnak=;
 b=duMuhJQLic3gu0YK9MkXRGZ7sb+EXSMpkLuflfGtwDqyDtYVuVZttj3tyt5YHkpdyE
 ndbA8h1SFmcGO+lXehafc8jqBN89UWS/YiSIF2yWfqR30drWoKJviVctZ0hr96Egu3Fn
 BraRBR0erVmnUXUsKUzvGZX9paQcyqg0yQDAg7KSWOs23abqYCLfntEpaOZLaRiCkTeN
 +9ORgWJLjtpLk8CNF3Yk3uLZUtb3iy6IndlERMAr3f+pBhkCsrLd+bUTIkYtT0JXGdCY
 s1qF6O37T33+a4Ulbic6nBm9gwqhfJm5qKP6ve2yq5P0U93Ed3kjDAModm15OXPtZZlf
 p4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420053; x=1749024853;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zn2kS2/blDmE/dhNRdfZMHqO89DPMTyDSFgQ1HTtnak=;
 b=HiJLei9e8Ucp1UbyEr/uYk7Z9rz51sIRb1Ul0lX5hcMK9sfdXq8PWf6Aztf4Q/805w
 jzX9cM5Ga1Fmq/FDavkLhPf2IWI72Xc06jHXesDRRhzYlDV8O7H/L4hcSG5pRW8dl/8r
 cqJ3lGob3FyGJrYRRVgIP23WGOcMP27gAB53lycNx5f5ntrf2rh3hjIuZyNEzlkmkFI/
 fpmh9qQ0U4QfgRQ5bIdbzKlaXwQfb4w63VPfHrD5eTcZaVF19cyPdhnGyScW0eTh63V0
 3tNNriy5IlvMXA8SZQAwnqj68V0Ym//mLXoTbVSvwkNqNPY7xZ5ZVNufGqwAsTE9ddIA
 DEJA==
X-Gm-Message-State: AOJu0YyVnb7Dj40loIDZOC9PiZrCtcstzQ5PfzqSJCOqwK2ktqdKou0i
 PGI1shQWImbE+16jV34cM75Ei1DsXPt+5Z9vOHWIn0y9QO7aoUL1+flkJRRnQGF7I5XT+AAGSTF
 NI5kGAQv9yw==
X-Gm-Gg: ASbGnctfiQfDkHiy8Yhse12ri1lWBM5KnvaEhZt2dcZ63dWpPZpTfe/NyRNpXul3vCI
 RScENQK60Fhjs2Zy+0cd14mWPy8Cx79Z7qLePdorGmodl7+KRfflhXFljTRT8xsJuVp4w2qGHwJ
 7e9M2O6he4g2kp5QcnjHrX4srNmrGHxK8HsCA/CFYy+dSf0qzC2bYkCVOOr1yZVwJLs+Dzbmvfn
 i2F42kFgkOgJhknxLWTaEKlV+t0nzCQe4t11LQ+ksNvbRKZxQCQofjsVT0lNkyyZMfzGeo6c5gl
 lOPOISxpBiZn/YDd9jBeTEf3YUQla95JuvF7XS6GAyk3n6qyir7VPQX3
X-Google-Smtp-Source: AGHT+IHcK70+Ev+ABmgQGTBjIR4NywN+T6ZGeJWYoN5HP1qBxv3su/cs+hzdoux9fDcFJRZ9fUn7Xg==
X-Received: by 2002:a05:600c:4e0e:b0:43c:e70d:4504 with SMTP id
 5b1f17b1804b1-44c91dcc114mr128685215e9.19.1748420053007; 
 Wed, 28 May 2025 01:14:13 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] tcg patch queue
Date: Wed, 28 May 2025 09:13:42 +0100
Message-ID: <20250528081410.157251-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 80db93b2b88f9b3ed8927ae7ac74ca30e643a83e:

  Merge tag 'pull-aspeed-20250526' of https://github.com/legoater/qemu into staging (2025-05-26 10:16:59 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250528

for you to fetch changes up to 5c2891601ccdaa41427187ef95bc25c828b355e4:

  accel/tcg: Assert TCGCPUOps.pointer_wrap is set (2025-05-28 08:08:48 +0100)

----------------------------------------------------------------
accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
linux-user: implement pgid field of /proc/self/stat
target/sh4: Use MO_ALIGN for system UNALIGN()
target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
accel/tcg: Add TCGCPUOps.pointer_wrap
target/*: Populate TCGCPUOps.pointer_wrap

----------------------------------------------------------------
Andreas Schwab (1):
      linux-user: implement pgid field of /proc/self/stat

Pierrick Bouvier (1):
      system/main: comment lock rationale

Richard Henderson (26):
      accel/tcg: Fix atomic_mmu_lookup vs TLB_FORCE_SLOW
      target/microblaze: Split out mb_unaligned_access_internal
      target/microblaze: Introduce helper_unaligned_access
      target/microblaze: Split out mb_transaction_failed_internal
      target/microblaze: Implement extended address load/store out of line
      target/microblaze: Use uint64_t for CPUMBState.ear
      target/microblaze: Use TCGv_i64 for compute_ldst_addr_ea
      target/microblaze: Fix printf format in mmu_translate
      target/microblaze: Use TARGET_LONG_BITS == 32 for system mode
      target/microblaze: Drop DisasContext.r0
      target/microblaze: Simplify compute_ldst_addr_type{a,b}
      tcg: Drop TCGContext.tlb_dyn_max_bits
      tcg: Drop TCGContext.page_{mask,bits}
      target/sh4: Use MO_ALIGN for system UNALIGN()
      accel/tcg: Add TCGCPUOps.pointer_wrap
      target: Use cpu_pointer_wrap_notreached for strict align targets
      target: Use cpu_pointer_wrap_uint32 for 32-bit targets
      target/arm: Fill in TCGCPUOps.pointer_wrap
      target/i386: Fill in TCGCPUOps.pointer_wrap
      target/loongarch: Fill in TCGCPUOps.pointer_wrap
      target/mips: Fill in TCGCPUOps.pointer_wrap
      target/ppc: Fill in TCGCPUOps.pointer_wrap
      target/riscv: Fill in TCGCPUOps.pointer_wrap
      target/s390x: Fill in TCGCPUOps.pointer_wrap
      target/sparc: Fill in TCGCPUOps.pointer_wrap
      accel/tcg: Assert TCGCPUOps.pointer_wrap is set

 include/accel/tcg/cpu-ops.h              |  13 ++++
 include/tcg/tcg.h                        |   4 -
 target/microblaze/cpu.h                  |   2 +-
 target/microblaze/helper.h               |  22 ++++--
 accel/tcg/cpu-exec.c                     |   1 +
 accel/tcg/cputlb.c                       |  37 +++++++--
 accel/tcg/translate-all.c                |   6 --
 linux-user/syscall.c                     |   3 +
 system/main.c                            |  13 ++++
 target/alpha/cpu.c                       |   1 +
 target/arm/cpu.c                         |  24 ++++++
 target/arm/tcg/cpu-v7m.c                 |   1 +
 target/avr/cpu.c                         |   6 ++
 target/hppa/cpu.c                        |   1 +
 target/i386/tcg/tcg-cpu.c                |   7 ++
 target/loongarch/cpu.c                   |   7 ++
 target/m68k/cpu.c                        |   1 +
 target/microblaze/cpu.c                  |   1 +
 target/microblaze/helper.c               |  71 ++++++++++-------
 target/microblaze/mmu.c                  |   3 +-
 target/microblaze/op_helper.c            | 110 +++++++++++++++++++-------
 target/microblaze/translate.c            | 128 ++++++++++++++++---------------
 target/mips/cpu.c                        |   9 +++
 target/openrisc/cpu.c                    |   1 +
 target/ppc/cpu_init.c                    |   7 ++
 target/riscv/tcg/tcg-cpu.c               |  26 +++++++
 target/rx/cpu.c                          |   1 +
 target/s390x/cpu.c                       |   9 +++
 target/sh4/cpu.c                         |   1 +
 target/sh4/translate.c                   |   2 +-
 target/sparc/cpu.c                       |  13 ++++
 target/tricore/cpu.c                     |   1 +
 target/xtensa/cpu.c                      |   1 +
 tcg/perf.c                               |   2 +-
 tcg/tcg-op-ldst.c                        |   3 +-
 tcg/tcg.c                                |   1 +
 configs/targets/microblaze-softmmu.mak   |   4 +-
 configs/targets/microblazeel-softmmu.mak |   4 +-
 tcg/aarch64/tcg-target.c.inc             |  10 +--
 tcg/arm/tcg-target.c.inc                 |  10 +--
 tcg/i386/tcg-target.c.inc                |  10 +--
 tcg/loongarch64/tcg-target.c.inc         |   4 +-
 tcg/mips/tcg-target.c.inc                |   6 +-
 tcg/ppc/tcg-target.c.inc                 |  14 ++--
 tcg/riscv/tcg-target.c.inc               |   4 +-
 tcg/s390x/tcg-target.c.inc               |   4 +-
 tcg/sparc64/tcg-target.c.inc             |   4 +-
 47 files changed, 427 insertions(+), 186 deletions(-)

