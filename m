Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56752C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguRK-0001kz-8R; Tue, 29 Jul 2025 20:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEu-0001Gc-GV
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:15 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguEr-0003yh-7g
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:00:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76a3818eb9bso857402b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833607; x=1754438407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+x/nOpNVKdVVT2nnS9KFrbW2gm/f5lb53oKqHtPCQ9I=;
 b=lz8YVZgnRlGMgjkQU+of0CNuYIxHLqlp55Lxie2pzOhbTQPrhdxCFztAd03IhLcNfs
 2cT18ReFuT6btfbBdOBc1UDfdbNaCCTTkWsHk3DSHWtxuFWSUxv/49u4jtx0bV4QTZ8T
 25oK4ylALya92F7cUc9HMrzWMTfxHYAsBZwZBUxmdfDQy/x9AHx3f3ZXe/ItoAVb/NmF
 JoUerbXr76uQHbO5GAB+8LVvROfsGvv92CT53TMNjio0+QlbsUIv9+10jffQ0cLFo4kA
 jOpH+6fOgpajR4BOlUgyJrnb1eR77cKeOxtBimLaZey2dJZWvtpo+0W9aDcOC3kKd+qJ
 NzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833607; x=1754438407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+x/nOpNVKdVVT2nnS9KFrbW2gm/f5lb53oKqHtPCQ9I=;
 b=drbJ5VfHL0i7GUW6eu+kUYrUsvHROZeFPSkHmHqV4j8PQx1IG4W0uJMW9DQ4O2GQqE
 uPzu1XWdorIh3uTb1PkFjPsJvc6x7tv3Ca683QlgU6Z7SGvvsuvDysWFksGLA9YeOk+D
 BMlrwQ8i2UTHcZo5DZNzxUIR/5I+ugGAau4K3WgEqxSW+lYMs2f640aMnGXLgDJFXUKJ
 vmmC7RmkCctSxM66n3Wi0sEqL3Mb2ygOZoqd/roumPgrbRc4tWFSnuTaxUjaCTD69AzE
 4Js2LnZQ0zZJ1YFmHSyz9Z8/Zb4I4mYN+7BclL5W/wBDN1Jlde5QKroj8k1yllTPkNfM
 GgiQ==
X-Gm-Message-State: AOJu0YxcLYlnR7z/70CJRhbxJc0igomGySWRL5Lyfb+ZxMqQ5JiB/GDS
 2oyMFOed0I3iovvFtT8CukteMolvxj0bLh+bdtbWFB925MxywpJ5wLkMAZTvaDGCCtWAsKCp/qk
 I8Xo1
X-Gm-Gg: ASbGncsajEWivSJTf5sqmo81VPg42dS10G7z3Uewpoizg3K9VgsITJK08iR5vyuUUh/
 jhUwmPZru/AqzcR3dl6sQJ3CsfHTULpIzzrjZm/CXOPnf48GhK+r2ZnYloZKcUn6UV8p6o9G7yC
 KWUzyfwGdQ5kSxp/pmLRRRSCAmMOwoL1MBsQHQfepB9tjcH10i1uue17NU/lcCARxtYD4ubR2D0
 DWqws9/MFAUrX7AxYpDZRXAffU3nYm06d7PPSpTdGy3JkvmkiNixqeY4BA2+YSgskp14u6ueYQw
 3fukJZCaObhVLUcWt/f6XHpy3ZBH4lcrmX1T6+tnX/WXTYRnfhl8agDGUNhOh8kxA5I/0SEZIyE
 oJPHbv1UYYOtvTxqU0HYZIG/rs8eJHnP35I/EcfEU8Nf5SEoOGQCn7u6m4VgFcQUqJunIMKUUrb
 sINNDNOucYDQ==
X-Google-Smtp-Source: AGHT+IHn0lM0Wzb2gqsGIdYbEei+vQnNO7qxSCdKrIqG8XC05JsEXX3vX99mPvyp10xJ7UPFlUckjQ==
X-Received: by 2002:a05:6a20:5483:b0:232:1d30:cd6e with SMTP id
 adf61e73a8af0-23dc0eba2c0mr1938750637.41.1753833607038; 
 Tue, 29 Jul 2025 17:00:07 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-764090e178bsm9026087b3a.62.2025.07.29.17.00.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:00:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-10.2 00/89] linux-user: Split up elfload.c
Date: Tue, 29 Jul 2025 13:58:33 -1000
Message-ID: <20250730000003.599084-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The goal is to kill the massive target ifdef ladder in elfload.c.

The functions get moved to linux-user/target/elfload.c.
Define weak functions to provide a default value, or a
weak reference to determine if the function is provided.

The core dump types and functions are moved to
linux-user/target/target_coredump.h.

The macros get moved to linux-user/target/target_elf.h.
These are mostly use to parameterize include/elf.h, but
there are some other outliers.

The init_thread functions, storing into target_pt_regs, have been
merged with target_cpu_copy_regs, copying out of target_pt_regs
into CPUArchState.  Merging these found a few bits of silliness
where pt_regs fields were initialized but not used.  To encourage
this never to return, remove most target_pt_regs and hide the rest
within the relevant signal.c.


r~


Richard Henderson (89):
  linux-user: Create target/elfload.c files
  linux-user: Move get_elf_hwcap to {i386,x86_64}/elfload.c
  linux-user: Move hwcap functions to {arm,aarch64}/elfload.c
  linux-user: Move get_elf_hwcap to sparc/elfload.c
  linux-user: Move hwcap functions to ppc/elfload.c
  linux-user: Move get_elf_hwcap to loongarch64/elfload.c
  linux-user: Move get_elf_hwcap to mips/elfload.c
  linux-user: Move get_elf_hwcap to sh4/elfload.c
  linux-user: Move hwcap functions to s390x/elfload.c
  linux-user: Move get_elf_hwcap to riscv/elfload.c
  linux-user: Remove ELF_HWCAP
  linux-user: Remove ELF_HWCAP2
  linux-user: Move get_elf_platform to {i386,x86_64}/elfload.c
  linux-user/i386: Return const data from get_elf_platform
  linux-user: Move get_elf_platform to arm/elfload.c
  linux-user/loongarch64: Create get_elf_platform
  linux-user/hppa: Create get_elf_platform
  linux-user: Remove ELF_PLATFORM
  linux-user: Move get_elf_base_platform to mips/elfload.c
  linux-user: Move target_cpu_copy_regs decl to qemu.h
  linux-user: Unify init of semihosting fields in TaskState
  linux-user: Create do_init_main_thread
  linux-user/i386: Create init_main_thread
  linux-user/arm: Create init_main_thread
  linux-user/aarch64: Create init_main_thread
  linux-user/sparc: Create init_main_thread
  linux-user/ppc: Create init_main_thread
  linux-user/loongarch64: Create init_main_thread
  linux-user/mips: Create init_main_thread
  linux-user/microblaze: Create init_main_thread
  linux-user/openrisc: Create init_main_thread
  linux-user/sh4: Create init_main_thread
  linux-user/m68k: Create init_main_thread
  linux-user/alpha: Create init_main_thread
  linux-user/s390x: Create init_main_thread
  linux-user/riscv: Create init_main_thread
  linux-user/hppa: Create init_main_thread
  linux-user/xtensa: Create init_main_thread
  linux-user/hexagon: Create init_main_thread
  linux-user: Remove do_init_main_thread
  linux-user/x86_64: Split out target_coredump.c.inc
  linux-user/i386: Split out target_coredump.c.inc
  linux-user/arm: Split out target_coredump.c.inc
  linux-user/aarch64: Split out target_coredump.c.inc
  linux-user/ppc: Split out target_coredump.c.inc
  linux-user/loongarch64: Split out target_coredump.c.inc
  linux-user/mips: Split out target_coredump.c.inc
  linux-user/microblaze: Split out target_coredump.c.inc
  target/openrisc: Split out target_coredump.c.inc
  target/sh4: Split out target_coredump.c.inc
  linux-user/m68k: Split out target_coredump.c.inc
  linux-user/s390x: Split out target_coredump.c.inc
  linux-user/xtensa: Split out target_coredump.c.inc
  linux-user: Unify the include of target_coredump.c.inc
  linux-user: Move init_guest_commpage to x86_64/elfload.c
  linux-user: Move init_guest_commpage to arm/elfload.c
  linux-user: Move init_guest_commpage to hppa/elfload.c
  linux-user: Remove INIT_GUEST_COMMPAGE
  linux-user: Move get_vdso_image_info to arm/elfload.c
  linux-user: Remove ELF_EXEC_PAGESIZE
  linux-user: Move get_elf_cpu_model to target/elfload.c
  linux-user: Move ppc uabi/asm/elf.h workaround to osdep.h
  linux-user: Move elf parameters to {i386,x86_64}/target_elf.h
  linux-user: Move elf parameters to {arm,aarch64}/target_elf.h
  linux-user: Move elf parameters to sparc/target_elf.h
  linux-user: Move elf parameters to ppc/target_elf.h
  linux-user: Move elf parameters to loongarch64/target_elf.h
  linux-user: Move elf parameters to {mips,mips64}/target_elf.h
  linux-user: Move elf parameters to microblaze/target_elf.h
  linux-user: Move elf parameters to openrisc/target_elf.h
  linux-user: Move elf parameters to sh4/target_elf.h
  linux-user: Move elf parameters to m68k/target_elf.h
  linux-user: Move elf parameters to alpha/target_elf.h
  linux-user: Move elf parameters to s390x/target_elf.h
  linux-user: Move elf parameters to riscv/target_elf.h
  linux-user: Move elf parameters to hppa/target_elf.h
  linux-user: Move elf parameters to xtensa/target_elf.h
  linux-user: Move elf parameters to hexagon/target_elf.h
  linux-user: Standardize on ELF_MACHINE not ELF_ARCH
  linux-user: Rename elf_check_arch
  linux-user: Remove ELIBBAD from elfload.c
  linux-user: Remove MAP_DENYWRITE from elfload.c
  linux-user: Move arch_parse_elf_property to aarch64/elfload.c
  linux-user: Remove a.out declarations from elfload.c
  linux-user/sparc: Move target_pt_regs to signal.c
  linux-user/microblaze: Move target_pt_regs to signal.c
  linux-user/openrisc: Move target_pt_regs to signal.c
  linux-user/s390x: Move target_psw_t to signal.c
  linux-user: Remove struct target_pt_regs from target_syscall.h

 include/qemu/osdep.h                         |    8 +
 include/user/cpu_loop.h                      |    4 -
 linux-user/aarch64/target_elf.h              |   16 +-
 linux-user/aarch64/target_syscall.h          |    7 -
 linux-user/alpha/target_elf.h                |    8 +-
 linux-user/alpha/target_syscall.h            |   40 -
 linux-user/arm/target_elf.h                  |   12 +-
 linux-user/arm/target_proc.h                 |    4 +-
 linux-user/arm/target_syscall.h              |    8 -
 linux-user/hexagon/target_elf.h              |   30 +-
 linux-user/hexagon/target_syscall.h          |    5 -
 linux-user/hppa/target_elf.h                 |   13 +-
 linux-user/hppa/target_syscall.h             |   18 -
 linux-user/i386/target_elf.h                 |   28 +-
 linux-user/i386/target_syscall.h             |   18 -
 linux-user/loader.h                          |   33 +-
 linux-user/loongarch64/target_elf.h          |   11 +-
 linux-user/loongarch64/target_syscall.h      |   23 -
 linux-user/m68k/target_elf.h                 |   13 +-
 linux-user/m68k/target_syscall.h             |   16 -
 linux-user/microblaze/target_elf.h           |   10 +-
 linux-user/microblaze/target_syscall.h       |   44 -
 linux-user/mips/target_elf.h                 |   16 +-
 linux-user/mips/target_syscall.h             |   19 -
 linux-user/mips64/target_elf.h               |   39 +-
 linux-user/mips64/target_syscall.h           |   16 -
 linux-user/openrisc/target_elf.h             |    9 +-
 linux-user/openrisc/target_syscall.h         |   11 -
 linux-user/ppc/target_elf.h                  |   45 +-
 linux-user/ppc/target_syscall.h              |   28 -
 linux-user/qemu.h                            |    6 +-
 linux-user/riscv/target_elf.h                |   15 +-
 linux-user/riscv/target_syscall.h            |   35 -
 linux-user/s390x/target_elf.h                |   11 +-
 linux-user/s390x/target_proc.h               |    2 +-
 linux-user/s390x/target_syscall.h            |   22 -
 linux-user/sh4/target_elf.h                  |    9 +-
 linux-user/sh4/target_syscall.h              |   11 -
 linux-user/sparc/target_elf.h                |   16 +-
 linux-user/sparc/target_syscall.h            |   19 -
 linux-user/x86_64/target_elf.h               |   10 +-
 linux-user/x86_64/target_syscall.h           |   28 -
 linux-user/xtensa/target_elf.h               |    7 +-
 linux-user/xtensa/target_syscall.h           |   35 -
 linux-user/aarch64/cpu_loop.c                |   22 +-
 linux-user/aarch64/elfload.c                 |  367 +++
 linux-user/alpha/cpu_loop.c                  |   11 +-
 linux-user/alpha/elfload.c                   |   11 +
 linux-user/arm/cpu_loop.c                    |   80 +-
 linux-user/arm/elfload.c                     |  267 +++
 linux-user/elfload.c                         | 2116 +-----------------
 linux-user/hexagon/cpu_loop.c                |    8 +-
 linux-user/hexagon/elfload.c                 |   35 +
 linux-user/hppa/cpu_loop.c                   |   18 +-
 linux-user/hppa/elfload.c                    |   47 +
 linux-user/i386/cpu_loop.c                   |   31 +-
 linux-user/i386/elfload.c                    |   25 +
 linux-user/linuxload.c                       |    6 +-
 linux-user/loongarch64/cpu_loop.c            |   11 +-
 linux-user/loongarch64/elfload.c             |   63 +
 linux-user/m68k/cpu_loop.c                   |   32 +-
 linux-user/m68k/elfload.c                    |   18 +
 linux-user/main.c                            |   18 +-
 linux-user/microblaze/cpu_loop.c             |   39 +-
 linux-user/microblaze/elfload.c              |   11 +
 linux-user/microblaze/signal.c               |   44 +
 linux-user/mips/cpu_loop.c                   |   16 +-
 linux-user/mips/elfload.c                    |  124 +
 linux-user/mips64/elfload.c                  |    1 +
 linux-user/openrisc/cpu_loop.c               |   11 +-
 linux-user/openrisc/elfload.c                |   11 +
 linux-user/openrisc/signal.c                 |   12 +
 linux-user/ppc/cpu_loop.c                    |   26 +-
 linux-user/ppc/elfload.c                     |  131 ++
 linux-user/riscv/cpu_loop.c                  |   15 +-
 linux-user/riscv/elfload.c                   |   23 +
 linux-user/s390x/cpu_loop.c                  |   15 +-
 linux-user/s390x/elfload.c                   |   68 +
 linux-user/s390x/signal.c                    |    5 +
 linux-user/sh4/cpu_loop.c                    |   10 +-
 linux-user/sh4/elfload.c                     |   38 +
 linux-user/sparc/cpu_loop.c                  |   16 +-
 linux-user/sparc/elfload.c                   |   42 +
 linux-user/sparc/signal.c                    |   20 +
 linux-user/x86_64/elfload.c                  |   41 +
 linux-user/xtensa/cpu_loop.c                 |   22 +-
 linux-user/xtensa/elfload.c                  |   11 +
 linux-user/aarch64/target_coredump.c.inc     |   14 +
 linux-user/arm/target_coredump.c.inc         |   28 +
 linux-user/i386/target_coredump.c.inc        |   32 +
 linux-user/loongarch64/target_coredump.c.inc |   24 +
 linux-user/m68k/target_coredump.c.inc        |   30 +
 linux-user/microblaze/target_coredump.c.inc  |   21 +
 linux-user/mips/target_coredump.c.inc        |   46 +
 linux-user/mips64/target_coredump.c.inc      |    1 +
 linux-user/openrisc/target_coredump.c.inc    |   15 +
 linux-user/ppc/target_coredump.c.inc         |   24 +
 linux-user/s390x/target_coredump.c.inc       |   31 +
 linux-user/sh4/target_coredump.c.inc         |   32 +
 linux-user/x86_64/target_coredump.c.inc      |   42 +
 linux-user/xtensa/target_coredump.c.inc      |   38 +
 meson.build                                  |    6 +-
 102 files changed, 2259 insertions(+), 2841 deletions(-)
 create mode 100644 linux-user/aarch64/elfload.c
 create mode 100644 linux-user/alpha/elfload.c
 create mode 100644 linux-user/arm/elfload.c
 create mode 100644 linux-user/hexagon/elfload.c
 create mode 100644 linux-user/hppa/elfload.c
 create mode 100644 linux-user/i386/elfload.c
 create mode 100644 linux-user/loongarch64/elfload.c
 create mode 100644 linux-user/m68k/elfload.c
 create mode 100644 linux-user/microblaze/elfload.c
 create mode 100644 linux-user/mips/elfload.c
 create mode 100644 linux-user/mips64/elfload.c
 create mode 100644 linux-user/openrisc/elfload.c
 create mode 100644 linux-user/ppc/elfload.c
 create mode 100644 linux-user/riscv/elfload.c
 create mode 100644 linux-user/s390x/elfload.c
 create mode 100644 linux-user/sh4/elfload.c
 create mode 100644 linux-user/sparc/elfload.c
 create mode 100644 linux-user/x86_64/elfload.c
 create mode 100644 linux-user/xtensa/elfload.c
 create mode 100644 linux-user/aarch64/target_coredump.c.inc
 create mode 100644 linux-user/arm/target_coredump.c.inc
 create mode 100644 linux-user/i386/target_coredump.c.inc
 create mode 100644 linux-user/loongarch64/target_coredump.c.inc
 create mode 100644 linux-user/m68k/target_coredump.c.inc
 create mode 100644 linux-user/microblaze/target_coredump.c.inc
 create mode 100644 linux-user/mips/target_coredump.c.inc
 create mode 100644 linux-user/mips64/target_coredump.c.inc
 create mode 100644 linux-user/openrisc/target_coredump.c.inc
 create mode 100644 linux-user/ppc/target_coredump.c.inc
 create mode 100644 linux-user/s390x/target_coredump.c.inc
 create mode 100644 linux-user/sh4/target_coredump.c.inc
 create mode 100644 linux-user/x86_64/target_coredump.c.inc
 create mode 100644 linux-user/xtensa/target_coredump.c.inc

-- 
2.43.0


