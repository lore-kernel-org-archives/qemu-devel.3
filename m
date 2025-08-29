Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5CECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNjy-0007ln-Uu; Sat, 30 Aug 2025 11:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WQ-0002b7-DH
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7WN-0002R1-Bc
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:24:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7722d6cc437so1099806b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506273; x=1757111073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wPdF1Q6BRQCXdQIT3CmlrDupZ/UqwMznh7nqlbE0cz0=;
 b=OAeRnLO3ygRHFf9mGlK/xnwr+H3EEk5ldgygA+DPfRyi6GQsdJjFaFf0Fy3MFaGrTQ
 CyhQ8Nvub6vwB1XQRarviZYZipy5+TQsgAMNjO5ia0pd5nV8NvIOtCITKkJwE7oNJuyn
 eDPHXA3lpnr2gnmcYzHuichW+dTXfWEzARZcQVMtMJowBYXFpoTBh1+qBqOt3/K1LPqR
 ZuBh8abqBKcbrUzMSfiqH1r73Eki3J7TgxKC41rmB+lOEGWLvJnwYSkhANtW2c6yvnZe
 5pZWTOofk86yQDSdHpfTk0SHDRazl+LRl9ZnuPBSzTXLJdqlpfh0YcLS9d/cGzmizlrV
 2yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506273; x=1757111073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPdF1Q6BRQCXdQIT3CmlrDupZ/UqwMznh7nqlbE0cz0=;
 b=cYXpPK+rzSSMBQx6zUoByPOy7mKOw3snfYzpQu91LbV+hVhwzoBhbjXTHlY6WxZfVg
 n3GsGyCt3XR0dMwLOoZVvtuTUBZ+3aEPTafUOR1XxKsjiMjsTJxxoeDQKcj6sL5sn01E
 3hwFxIgYwYt01B0W/v8x1+t1Xn5Y6Bs1hcQiIWQ3CeG1cXC5QUj/dqyf8Tyf9/B2BiF0
 YymuMHfK3hMWkuRThr2bOkjLJyebxWsSBuDUxy/zH5RYYV1J86lgnTT8Ryh+NrW6+825
 6HF5AI5LCWg5RRVo1nd4BF0uxnTJISWI8S0q0Ske3Qok8CjuqrIt+0YPI+9V6zJPKSw/
 YKig==
X-Gm-Message-State: AOJu0YysPJ4E0OO7ktCMvJ1z6yyIgxRuiHudihdO28F5lKGPcgO62IKw
 uFFLhBDeQv3x6+hEPT4HGA3uBm0qpuo5O+zP5EWWnEeRlsVm6tm8fWDx0wA15kFVRFB+6SilJcZ
 7dw4WTmI=
X-Gm-Gg: ASbGnctMks31Hxc8evGcuAFT6VqgxwMsfK7ViRy4QAYX4Ou8vMUkKNT+9ePXtaE/zAc
 XpdcNtltv7Fws6Qt2nOplQ0EjggZDA8QEtPPiyy3xEngLl9W57veFS04ueLrwc1JycZRoIKxEVY
 UArMAblqZKmsBjJYrBZIys36nz6rQ98CYzh2XfSCWfL04NgF1Bacja1ne63eCNdu/NiFxv3MrN8
 uNA8sa4uWSokvUeWLpBnr7rwg+XT3e+sgPWzXpXPJYgemUS0YNkFb/Lw8BSmO7vz2s8n8TCT1FI
 li4/EnT8QBavfsLVKox42bvNApJjRIfJirce/YCfoxk8P4an1exN90ihK06MWqGlLHu0vDogleg
 bArz2ygQmRp+fpMOMXVRbwHqMljesjVml9PxoaT/6QlM0Erlq+Kp+dofT8X/t0PaILFVifZo=
X-Google-Smtp-Source: AGHT+IHV2M6x50LsbasZUPr749Ys0QidR+GhBKaX7umLzns+H/KxPC86J34vV/cQYMQNre2M4pFRKw==
X-Received: by 2002:a05:6a00:138e:b0:76e:7ab9:a239 with SMTP id
 d2e1a72fcca58-7723c5c841bmr961543b3a.16.1756506272857; 
 Fri, 29 Aug 2025 15:24:32 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.24.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:24:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/91] linux-user patch queue
Date: Sat, 30 Aug 2025 08:22:56 +1000
Message-ID: <20250829222427.289668-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:

  Merge tag 'pull-lu-20250828' of https://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20250830

for you to fetch changes up to 3f1b9dbdf5452a2baab00d46bd149f6f8192fe44:

  linux-user: Remove target_pt_regs from target_syscall.h (2025-08-30 07:04:04 +1000)

----------------------------------------------------------------
linux-user: Finish elfload.c split
linux-user: Drop deprecated -p option
linux-user: Tidy print_socket_protocol
hw/core: Dump cpu_reset in the reset.exit phase
hw/core: Use qemu_log_trylock/unlock in cpu_common_reset_exit

----------------------------------------------------------------
Peter Maydell (1):
      linux-user: Drop deprecated -p option

Richard Henderson (90):
      hw/core: Dump cpu_reset in the reset.exit phase
      hw/core: Use qemu_log_trylock/unlock in cpu_common_reset_exit
      linux-user: Tidy print_socket_protocol
      linux-user/x86_64: Convert target_elf_gregset_t to a struct
      linux-user/i386: Convert target_elf_gregset_t to a struct
      linux-user/arm: Convert target_elf_gregset_t to a struct
      linux-user/aarch64: Convert target_elf_gregset_t to a struct
      linux-user/ppc: Convert target_elf_gregset_t to a struct
      linux-user/loongarch64: Convert target_elf_gregset_t to a struct
      linux-user/mips: Convert target_elf_gregset_t to a struct
      linux-user/microblaze: Convert target_elf_gregset_t to a struct
      linux-user/openrisc: Convert target_elf_gregset_t to a struct
      linux-user/sh4: Convert target_elf_gregset_t to a struct
      linux-user/m68k: Convert target_elf_gregset_t to a struct
      linux-user/s390x: Convert target_elf_gregset_t to a struct
      linux-user/xtensa: Convert target_elf_gregset_t to a struct
      linux-user: Update comment for target_elf_gregset_t
      linux-user: Declare elf_core_copy_regs in loader.h
      linux-user: Rename USE_ELF_CORE_DUMP to HAVE_ELF_CORE_DUMP
      linux-user: Move elf_core_copy_regs to {i386,x86_64}/elfload.c
      linux-user: Move elf_core_copy_regs to arm/elfload.c
      linux-user: Move elf_core_copy_regs to aarch64/elfload.c
      linux-user: Move elf_core_copy_regs to ppc/elfload.c
      linux-user: Move elf_core_copy_regs to loongarch64/elfload.c
      linux-user: Move elf_core_copy_regs to mips/elfload.c
      linux-user: Move elf_core_copy_regs to microblaze/elfload.c
      linux-user: Move elf_core_copy_regs to openrisc/elfload.c
      linux-user: Move elf_core_copy_regs to sh4/elfload.c
      linux-user: Move elf_core_copy_regs to m68k/elfload.c
      linux-user: Move elf_core_copy_regs to s390x/elfload.c
      linux-user: Move elf_core_copy_regs to xtensa/elfload.c
      linux-user: Remove target_elf_greg_t, tswapreg from elfload.c
      linux-user/i386: Create target_ptrace.h
      linux-user/i386: Expand target_elf_gregset_t
      linux-user/x86_64: Create target_ptrace.h
      linux-user/x86_64: Expand target_elf_gregset_t
      linux-user/x86_64: Fix dump of fs_base, gs_base
      linux-user/aarch64: Create target_ptrace.h
      linux-user/aarch64: Expand target_elf_gregset_t
      linux-user/arm: Create target_ptrace.h
      linux-user/arm: Expand target_elf_gregset_t
      linux-user/loongarch64: Create target_ptrace.h
      linux-user/loongarch64: Expand target_elf_gregset_t
      linux-user/m68k: Expand target_elf_gregset_t
      linux-user/microblaze: Create target_ptrace.h
      linux-user/microblaze: Fold target_pt_regs.r* to an array
      linux-user/microblaze: Expand target_elf_gregset_t
      linux-user/mips: Create target_ptrace.h
      linux-user/mips: Use target_ulong for target_elf_greg_t
      linux-user/openrisc: Create target_ptrace.h
      linux-user/openrisc: Expand target_elf_gregset_t
      linux-user/ppc: Create target_ptrace.h
      linux-user/ppc: Expand target_elf_gregset_t
      linux-user/s390x: Create target_ptrace.h
      linux-user/s390x: Expand target_elf_gregset_t
      linux-user/sh4: Create target_ptrace.h
      linux-user/sh4: Expand target_elf_gregset_t
      linux-user/xtensa: Create target_ptrace.h
      linux-user/xtensa: Expand target_elf_gregset_t
      linux-user: Move init_guest_commpage to x86_64/elfload.c
      linux-user: Move init_guest_commpage to arm/elfload.c
      linux-user: Move init_guest_commpage to hppa/elfload.c
      linux-user: Replace init_guest_commpage macro with function
      linux-user: Move get_vdso_image_info to arm/elfload.c
      linux-user: Remove ELF_EXEC_PAGESIZE
      linux-user: Remove redundant ELF_DATA definitons
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
      linux-user/sparc: Create target_ptrace.h
      linux-user: Remove target_pt_regs from target_syscall.h

 linux-user/aarch64/target_elf.h         |  21 +
 linux-user/aarch64/target_ptrace.h      |  14 +
 linux-user/aarch64/target_syscall.h     |   7 -
 linux-user/alpha/target_elf.h           |   3 +
 linux-user/alpha/target_syscall.h       |  40 --
 linux-user/arm/target_elf.h             |  18 +
 linux-user/arm/target_ptrace.h          |  16 +
 linux-user/arm/target_syscall.h         |   8 -
 linux-user/hexagon/target_elf.h         |   3 +
 linux-user/hexagon/target_syscall.h     |   5 -
 linux-user/hppa/target_elf.h            |   8 +
 linux-user/hppa/target_syscall.h        |  18 -
 linux-user/i386/target_elf.h            |  33 ++
 linux-user/i386/target_ptrace.h         |  32 ++
 linux-user/i386/target_syscall.h        |  18 -
 linux-user/loader.h                     |  21 +
 linux-user/loongarch64/target_elf.h     |  13 +
 linux-user/loongarch64/target_ptrace.h  |  15 +
 linux-user/loongarch64/target_syscall.h |  23 -
 linux-user/m68k/target_elf.h            |  27 +
 linux-user/m68k/target_syscall.h        |  16 -
 linux-user/microblaze/target_elf.h      |  17 +
 linux-user/microblaze/target_ptrace.h   |  20 +
 linux-user/microblaze/target_syscall.h  |  44 --
 linux-user/mips/target_elf.h            |  15 +
 linux-user/mips/target_ptrace.h         |  17 +
 linux-user/mips/target_syscall.h        |  19 -
 linux-user/mips64/target_elf.h          |  21 +
 linux-user/mips64/target_ptrace.h       |  16 +
 linux-user/mips64/target_syscall.h      |  16 -
 linux-user/openrisc/target_elf.h        |  15 +
 linux-user/openrisc/target_ptrace.h     |  13 +
 linux-user/openrisc/target_syscall.h    |  11 -
 linux-user/ppc/target_elf.h             |  56 ++
 linux-user/ppc/target_ptrace.h          |  26 +
 linux-user/ppc/target_syscall.h         |  28 -
 linux-user/riscv/target_elf.h           |  10 +
 linux-user/riscv/target_syscall.h       |  35 --
 linux-user/s390x/target_elf.h           |  15 +
 linux-user/s390x/target_ptrace.h        |  18 +
 linux-user/s390x/target_syscall.h       |  22 -
 linux-user/sh4/target_elf.h             |  14 +
 linux-user/sh4/target_ptrace.h          |  18 +
 linux-user/sh4/target_syscall.h         |  11 -
 linux-user/sparc/target_elf.h           |  11 +
 linux-user/sparc/target_ptrace.h        |  24 +
 linux-user/sparc/target_syscall.h       |  19 -
 linux-user/x86_64/target_elf.h          |  16 +
 linux-user/x86_64/target_ptrace.h       |  40 ++
 linux-user/x86_64/target_syscall.h      |  28 -
 linux-user/xtensa/target_elf.h          |  15 +
 linux-user/xtensa/target_ptrace.h       |  22 +
 linux-user/xtensa/target_syscall.h      |  35 --
 bsd-user/main.c                         |   8 -
 hw/core/cpu-common.c                    |  21 +-
 linux-user/aarch64/elfload.c            |  29 +
 linux-user/arm/elfload.c                |  76 +++
 linux-user/elfload.c                    | 918 ++------------------------------
 linux-user/hppa/elfload.c               |  31 ++
 linux-user/i386/elfload.c               |  22 +
 linux-user/loongarch64/elfload.c        |  15 +
 linux-user/m68k/elfload.c               |  25 +
 linux-user/main.c                       |  12 -
 linux-user/microblaze/elfload.c         |  13 +
 linux-user/microblaze/signal.c          |  71 +--
 linux-user/mips/elfload.c               |  18 +
 linux-user/openrisc/elfload.c           |  10 +
 linux-user/openrisc/signal.c            |   3 +-
 linux-user/ppc/elfload.c                |  15 +
 linux-user/s390x/elfload.c              |  14 +
 linux-user/s390x/signal.c               |   1 +
 linux-user/sh4/elfload.c                |  15 +
 linux-user/sparc/signal.c               |   2 +
 linux-user/strace.c                     | 102 ++--
 linux-user/x86_64/elfload.c             |  52 ++
 linux-user/xtensa/elfload.c             |  20 +
 docs/about/deprecated.rst               |  10 -
 docs/about/removed-features.rst         |   8 +
 docs/user/main.rst                      |   3 -
 79 files changed, 1119 insertions(+), 1441 deletions(-)
 create mode 100644 linux-user/aarch64/target_ptrace.h
 create mode 100644 linux-user/arm/target_ptrace.h
 create mode 100644 linux-user/i386/target_ptrace.h
 create mode 100644 linux-user/loongarch64/target_ptrace.h
 create mode 100644 linux-user/microblaze/target_ptrace.h
 create mode 100644 linux-user/mips/target_ptrace.h
 create mode 100644 linux-user/mips64/target_ptrace.h
 create mode 100644 linux-user/openrisc/target_ptrace.h
 create mode 100644 linux-user/ppc/target_ptrace.h
 create mode 100644 linux-user/s390x/target_ptrace.h
 create mode 100644 linux-user/sh4/target_ptrace.h
 create mode 100644 linux-user/sparc/target_ptrace.h
 create mode 100644 linux-user/x86_64/target_ptrace.h
 create mode 100644 linux-user/xtensa/target_ptrace.h

