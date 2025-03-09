Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F58C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKoy-00058S-Nq; Sun, 09 Mar 2025 13:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKow-000589-Su
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:14 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKou-0004mv-DB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:14 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso2906084f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542730; x=1742147530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uU8WULxu6dVP2LF9qDMDNW07pyxmrtGdWeVgtgF3eyk=;
 b=g8z2uzh+4i9LvMmbsmkPd9/7Qd8fDcGuH2ZPHiseov1h9DN+bs338d7WB9UPUHv5kX
 uulGQvUBEoxoj/H5wy1+q2KnmLgmH1fTywtrAhk5tmf21Kl61hoEhFcTcWPXln+cR8O2
 hCX+IOYnRat83Y2R3tml0lSBrmZdJSkUx+itTkyYr1QZXxSm5wQieMGm8AjwG09Z5rG5
 BzGRh/F/hi+kk6zEtpdNtq8oZK1/usX8S2PanHSyxXGxi6RFhxik1GRlVC1XtiZ/xana
 fSsXwoNpAm42mqPXd+T/Qz848mbltZXj0SYTzeJD3EtWr3pm6o/m+xBszRj2uwnwSooV
 g1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542730; x=1742147530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uU8WULxu6dVP2LF9qDMDNW07pyxmrtGdWeVgtgF3eyk=;
 b=FH9zmOOI229s1a0e87Z+1GPVP+32H/KSKS0qduDZtGFknGHGn0UTkZe/MAVPJk3xL1
 RYyXw2Tu8V0WlkWeG6wDIfJEcq39eFowG6ToyPC8ZjypAV2K7IDFqOjK3V3svo+mbHhg
 JUP0fV7NrmsdfbtH4/3F1+IO6CN5uLUKcxB+BqsX7z72d1+XGTKpzjgWw6C0feGxtSgH
 l2PBPd/uL5+zasqixygE37MMjwoecHboKjF63aE0UDLDCxuQkIHlmun3bEJeX1kadjTS
 z5l5MJf4aZ9osDzfNXLoNtJD6RslJvlqosEGYEF/NZ1D8h3ify46A0z7rkHS7NMeteho
 LNtg==
X-Gm-Message-State: AOJu0YwGkqL/QcndC76QjDX4zj9oqjkeygveAh+iVYecm+2V3G8mK4rq
 rSsaStm+ml7zHJpXeTH2Ohj+EPRVQPUA8nSIDhd2n6Wsd+SutO7pq4PiVj4lgNSm8TvUgqlMn4f
 lCm0=
X-Gm-Gg: ASbGncsgAkOMnzx+J9RabJXhD/Pu/2+XnQwiVgVBlxkz1gCmkhyyUrkm1ngzFw86QY6
 C11PoAQWUNx7tJI27LTH4CTFWXkJ9PmWv9jjTnvRB9oDgPNetj83lr849TrVOt95aAANMyKCVJP
 KQ5TqgNL/CKcaVogZG34aXoDA5IZ3N4fpBKIEYmUa3C5vCgYj9lMHwQhEjSeMHcN1GWzcxOnY8M
 s+Bzf/JjOpvIEHE1+Ce75KzOiYsdwgidmanEtnwmpbfBz6AWmUdFSPG8afs8FIgucna+Gmsmdmw
 QmUmqkp27gMmOwgmlq9Dtx3dhIFgbxrYb0YD6dToq3kAZ86rZZNGZHNoGj66mCUFqCpMcSykOyU
 mX+rVIzCESwvNuMXuTFE=
X-Google-Smtp-Source: AGHT+IHKan3/onRTa2uSj+CTdb3F157hnmjc2f6aDGF4GfkPD+WKKxMAxM2EQ8ZlIn4yVkIMBvNAwg==
X-Received: by 2002:a05:6000:1862:b0:390:fe4b:70b9 with SMTP id
 ffacd0b85a97d-39132d6c5demr8880759f8f.21.1741542729552; 
 Sun, 09 Mar 2025 10:52:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195casm12645156f8f.53.2025.03.09.10.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] Accelerators & CPU patches for 2025-03-09
Date: Sun,  9 Mar 2025 18:51:29 +0100
Message-ID: <20250309175207.43828-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

The following changes since commit d9a4282c4b690e45d25c2b933f318bb41eeb271d:

  Merge tag 'pull-tcg-20250308' of https://gitlab.com/rth7680/qemu into staging (2025-03-09 11:45:00 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-cpus-20250309

for you to fetch changes up to 8ff6ff09b9890ba390395d7510eca1025f7284df:

  MAINTAINERS: Consolidate core exec/vCPU handling section (2025-03-09 17:00:47 +0100)

----------------------------------------------------------------
Generic CPUs / accelerators patch queue

- Reduce "exec/tb-flush.h" inclusion on linux-user
- Consider alignment in bsd-user's mmap_find_vma()
- Unify MMAP common user emulation API
- Simplify cpu-target.c further
- Prefer cached CpuClass over CPU_GET_CLASS() macro
- Restrict CPU has_work() handlers to system emulation
- Consolidate core exec/vCPU section in MAINTAINERS

Following spurious checkpatch error deliberately ignored:

  8/38 Checking commit e27fa95fb9d1 (accel: Prefer cached CpuClass over CPU_GET_CLASS() macro)
  ERROR: space prohibited after that '&&' (ctx:ExW)
  #112: FILE: accel/tcg/watchpoint.c:120:
  +                && cpu->cc->tcg_ops->debug_check_watchpoint
                  ^

  total: 1 errors, 0 warnings, 74 lines checked

----------------------------------------------------------------

Philippe Mathieu-Daudé (38):
  linux-user: Only include 'exec/tb-flush.h' header when necessary
  bsd-user: Always use mmap_find_vma_aligned() in target_mmap()
  bsd-user: Propagate alignment argument to mmap_find_vma()
  user: Extract common MMAP API to 'user/mmap.h'
  cpus: Register VMState per user / system emulation
  cpus: Build cpu_exec_[un]realizefn() methods once
  cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
  accel: Prefer cached CpuClass over CPU_GET_CLASS() macro
  user: Prefer cached CpuClass over CPU_GET_CLASS() macro
  disas: Prefer cached CpuClass over CPU_GET_CLASS() macro
  gdbstub: Prefer cached CpuClass over CPU_GET_CLASS() macro
  hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS() macro
  target/arm: Prefer cached CpuClass over CPU_GET_CLASS() macro
  cpus: Restrict cpu_has_work() to system emulation
  cpus: Un-inline cpu_has_work()
  cpus: Introduce SysemuCPUOps::has_work() handler
  target/alpha: Move has_work() from CPUClass to SysemuCPUOps
  target/arm: Move has_work() from CPUClass to SysemuCPUOps
  target/avr: Move has_work() from CPUClass to SysemuCPUOps
  target/hexagon: Remove CPUClass:has_work() handler
  target/hppa: Move has_work() from CPUClass to SysemuCPUOps
  target/i386: Move has_work() from CPUClass to SysemuCPUOps
  target/loongarch: Move has_work() from CPUClass to SysemuCPUOps
  target/m68k: Move has_work() from CPUClass to SysemuCPUOps
  target/microblaze: Move has_work() from CPUClass to SysemuCPUOps
  target/mips: Move has_work() from CPUClass to SysemuCPUOps
  target/openrisc: Move has_work() from CPUClass to SysemuCPUOps
  target/ppc: Move has_work() from CPUClass to SysemuCPUOps
  target/riscv: Move has_work() from CPUClass to SysemuCPUOps
  target/rx: Move has_work() from CPUClass to SysemuCPUOps
  target/s390x: Restrict I/O handler installers to system emulation
  target/s390x: Move has_work() from CPUClass to SysemuCPUOps
  target/sh4: Move has_work() from CPUClass to SysemuCPUOps
  target/sparc: Move has_work() from CPUClass to SysemuCPUOps
  target/tricore: Move has_work() from CPUClass to SysemuCPUOps
  target/xtensa: Move has_work() from CPUClass to SysemuCPUOps
  cpus: Remove CPUClass::has_work() handler
  MAINTAINERS: Consolidate core exec/vCPU handling section

 MAINTAINERS                      |  14 +--
 bsd-user/bsd-mem.h               |   4 +-
 bsd-user/qemu.h                  |  12 +--
 include/accel/tcg/cpu-ops.h      |   2 +-
 include/hw/core/cpu.h            |  35 +++---
 include/hw/core/sysemu-cpu-ops.h |   4 +
 include/user/mmap.h              |  32 ++++++
 linux-user/alpha/target_proc.h   |   2 +-
 linux-user/user-internals.h      |   1 -
 linux-user/user-mmap.h           |  19 +---
 target/i386/cpu.h                |   4 +-
 target/mips/internal.h           |   4 +-
 target/riscv/internals.h         |   4 +-
 target/s390x/s390x-internal.h    |   5 +
 accel/accel-target.c             |  12 +--
 accel/tcg/tcg-accel-ops.c        |   3 +-
 accel/tcg/translate-all.c        |   2 +-
 accel/tcg/watchpoint.c           |   9 +-
 bsd-user/mmap.c                  |  17 +--
 bsd-user/signal.c                |   4 +-
 cpu-common.c                     |  10 +-
 cpu-target.c                     | 146 -------------------------
 disas/disas-common.c             |   5 +-
 gdbstub/gdbstub.c                |  26 ++---
 gdbstub/system.c                 |   7 +-
 gdbstub/user-target.c            |   6 +-
 gdbstub/user.c                   |   7 +-
 hw/acpi/cpu.c                    |   4 +-
 hw/acpi/cpu_hotplug.c            |   3 +-
 hw/core/cpu-common.c             |  47 +++++---
 hw/core/cpu-system.c             | 179 +++++++++++++++++++++++++------
 hw/core/cpu-user.c               |  17 +++
 linux-user/mmap.c                |   1 +
 linux-user/signal.c              |   4 +-
 linux-user/syscall.c             |   1 +
 target/alpha/cpu.c               |   4 +-
 target/arm/cpu.c                 |   7 +-
 target/arm/tcg/cpu-v7m.c         |   3 +-
 target/avr/cpu.c                 |   2 +-
 target/hexagon/cpu.c             |   6 --
 target/hppa/cpu.c                |   4 +-
 target/i386/cpu.c                |   8 +-
 target/loongarch/cpu.c           |   8 +-
 target/m68k/cpu.c                |   4 +-
 target/microblaze/cpu.c          |   4 +-
 target/mips/cpu.c                |   4 +-
 target/openrisc/cpu.c            |   4 +-
 target/ppc/cpu_init.c            |   4 +-
 target/riscv/cpu.c               |   8 +-
 target/rx/cpu.c                  |   2 +-
 target/s390x/cpu-system.c        |  18 ++++
 target/s390x/cpu.c               |  18 ----
 target/s390x/interrupt.c         |   8 +-
 target/sh4/cpu.c                 |   4 +-
 target/sparc/cpu.c               |   4 +-
 target/tricore/cpu.c             |   2 +-
 target/xtensa/cpu.c              |  12 +--
 57 files changed, 384 insertions(+), 406 deletions(-)
 create mode 100644 include/user/mmap.h

-- 
2.47.1


