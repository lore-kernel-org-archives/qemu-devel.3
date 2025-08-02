Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D6AC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLI5-0000Pm-95; Sat, 02 Aug 2025 19:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLHu-0000JU-H9
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:14 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLHs-000123-96
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:14 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-306db05b292so943000fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175910; x=1754780710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lZFKjQr5rI2rQ+eheJv8e1fNLv9PwMsegUjkFnNdz7w=;
 b=d4zBNSlYDSsR7R35v1WBKLDapbYNUYc74XGN5VgxtTL7o/JneaxFxi4sJoKx9+4nxx
 X6aBOc3v2URRNObMbLi5SH79vp1Te+0cqGAYwBxgUHsiOQmnunZkN/LP6tBQJnkrbGWz
 hL+nPDrvdUA3AKFlkmkTPEk1FnLMpmGplSo9K/8Xv/+Wavo8MCqMMqWqzAxiRXk2JaSW
 e+iyAvQDhLgF8S6CSqO9qFkWlvK/VEirqtuNpzXKAMcSSQlTnaz76Kd3ECTiJdHoGCQS
 +U5qECSrt6wsUgS1z3lv5Z84LOAvEhzneGNgoS8UgkxpSC6VzWAGhQ4hhFPcA0Td+DCu
 AwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175910; x=1754780710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lZFKjQr5rI2rQ+eheJv8e1fNLv9PwMsegUjkFnNdz7w=;
 b=DPOP4KPv8yzXO1kijq5R5czLkaaE01ibtcgwVMe8CBq+gC0c7cu0lgDDZonR6M5fQV
 xUTF/N5qY/uWr0ZRjDbuC8JLrNn6A31dm85/6aSeAERD7DfOmwnGKLGj9iXObhtq2kw2
 DgLlAj2kePAM1qdsPdodUfsiVA/xYlfb0gNob3yctxUtDOH387zTGqMbn1aecu/w3cvM
 2l5Q/A3VIQcy9FKqaTq2JryRXWWuRNjE3LOXt/Nsh8/wUCSSCBoAoUsY2ksD7yWQyLJ5
 qDiWB172wR8HaoEbAdu4Olcqv45SzAMIP8OeVbtqyeSerK+SSdpyJPViGJIk5esX6KOK
 bPag==
X-Gm-Message-State: AOJu0YwoLbZu2hCfzl/iVRbkhanwz7I4ipy1rJ2pPvcfhL6VUfyUtxAm
 IsVXaURHW4IXkX9uvxN8pxlQy66lpLKWPd8cm38N5dhayBM9ay1FCqCJYy+L2vnPYc2ISl3QDst
 +TyjOgYQ=
X-Gm-Gg: ASbGncuLfuHu/xtvjNPOKW6uJQ8VnGriTL5dPrSk3ks7FoTvfk4Y7Lxs2L6Rx7sTQuD
 TQ8Tt+ebyZETthv9m4tE5GGhC11vnFf6I5D6Z3vDNYs8f1nhu1JPtZHBmOnqc2bTWmgaeA9euxJ
 3wnLDc5FChnb/TrMy8D9vn5Bx7vy7SKcpVrzLf1efSIY5GeLMLdYCBQ4mZhXkWJqxouafGvo/uM
 0mgcNvXjezuNlBdhRoKqSN/rxUVjw8x/K/TZKpzu2uwEQTwgIAumPybbYCE4s3UuaxaridwxAY8
 wYZxLHYn2c6baAK8G2bx0X2YO+CVuqIuXIHNDMDWQanOsqbziA9Uz+GmyJBVtdo2+Ya0QRKx4aB
 4n7pYSxYf+i6uld2v+R1qEe4K80HktAHTuIjm7VCROwj9Be/4/+kSvc5DtvRLvS0=
X-Google-Smtp-Source: AGHT+IHNcZ34UgLun9l/Go7c1b7/G3QkVZu8Y+REnMK4191d8G8ATeQcVzuZ3XNAQRh8FCorvFVVTA==
X-Received: by 2002:a05:6808:6551:20b0:433:f58e:416 with SMTP id
 5614622812f47-433f58e0fcamr1129889b6e.2.1754175910036; 
 Sat, 02 Aug 2025 16:05:10 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/95] linux-user: Split up elfload.c
Date: Sun,  3 Aug 2025 09:03:24 +1000
Message-ID: <20250802230459.412251-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
The macros get moved to linux-user/target/target_elf.h.
These are mostly use to parameterize include/elf.h or elfload.c.

The init_thread functions, storing into target_pt_regs, have been
merged with target_cpu_copy_regs, copying out of target_pt_regs
into CPUArchState.  Merging these found a few bits of silliness
where pt_regs fields were initialized but not used.  To encourage
this never to return, remove most target_pt_regs and hide the rest
within the relevant signal.c.

Changes for v2:
  - Cleanup semihosting user-only SYS_HEAPINFO.
  - No more weak functions.  Replaced with HAVE_* macros and
    strong fallback functions.  If the HAVE_* macro is missing
    and the target provides its own function, we'll get a link
    error for duplicate symbols.
  - No more target_coredump.c.inc.  This required killing
    target_elf_gregset_t so that the function signatures could
    match for all targets.
  - Misc other changes from review.


r~


Richard Henderson (95):
  semihosting: Retrieve stack top from image_info
  semihosting: Initialize heap once per process
  linux-user: Create target/elfload.c files
  linux-user: Move ppc uabi/asm/elf.h workaround to osdep.h
  linux-user: Move get_elf_cpu_model to target/elfload.c
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
  linux-user: Create do_init_main_thread
  linux-user/i386: Create init_main_thread
  linux-user/arm: Create init_main_thread
  linux-user/arm: Remove a.out startup remenents
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
  linux-user: Remove target_elf_greg_t
  linux-user: Replace tswapreg with tswapl
  linux-user: Unify elf_core_copy_regs signatures
  linux-user: Declare elf_core_copy_regs in loader.h
  linux-user: Remove USE_ELF_CORE_DUMP
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
  linux-user/sparc: Move target_pt_regs to signal.c
  linux-user/microblaze: Move target_pt_regs to signal.c
  linux-user/openrisc: Move target_pt_regs to signal.c
  linux-user/s390x: Move target_psw_t to signal.c
  linux-user: Remove struct target_pt_regs from target_syscall.h

 include/qemu/osdep.h                    |    8 +
 include/user/cpu_loop.h                 |    4 -
 linux-user/aarch64/target_elf.h         |   21 +-
 linux-user/aarch64/target_syscall.h     |    7 -
 linux-user/alpha/target_elf.h           |    8 +-
 linux-user/alpha/target_syscall.h       |   40 -
 linux-user/arm/target_elf.h             |   17 +-
 linux-user/arm/target_proc.h            |    4 +-
 linux-user/arm/target_syscall.h         |    8 -
 linux-user/hexagon/target_elf.h         |   30 +-
 linux-user/hexagon/target_syscall.h     |    5 -
 linux-user/hppa/target_elf.h            |   15 +-
 linux-user/hppa/target_syscall.h        |   18 -
 linux-user/i386/target_elf.h            |   38 +-
 linux-user/i386/target_syscall.h        |   18 -
 linux-user/loader.h                     |   36 +-
 linux-user/loongarch64/target_elf.h     |   16 +-
 linux-user/loongarch64/target_syscall.h |   23 -
 linux-user/m68k/target_elf.h            |   15 +-
 linux-user/m68k/target_syscall.h        |   16 -
 linux-user/microblaze/target_elf.h      |   12 +-
 linux-user/microblaze/target_syscall.h  |   44 -
 linux-user/mips/target_elf.h            |   21 +-
 linux-user/mips/target_syscall.h        |   19 -
 linux-user/mips64/target_elf.h          |   43 +-
 linux-user/mips64/target_syscall.h      |   16 -
 linux-user/openrisc/target_elf.h        |   11 +-
 linux-user/openrisc/target_syscall.h    |   11 -
 linux-user/ppc/target_elf.h             |   50 +-
 linux-user/ppc/target_syscall.h         |   28 -
 linux-user/qemu.h                       |    8 +-
 linux-user/riscv/target_elf.h           |   17 +-
 linux-user/riscv/target_syscall.h       |   35 -
 linux-user/s390x/target_elf.h           |   14 +-
 linux-user/s390x/target_proc.h          |    2 +-
 linux-user/s390x/target_syscall.h       |   22 -
 linux-user/sh4/target_elf.h             |   13 +-
 linux-user/sh4/target_syscall.h         |   11 -
 linux-user/sparc/target_elf.h           |   18 +-
 linux-user/sparc/target_syscall.h       |   19 -
 linux-user/x86_64/target_elf.h          |   21 +-
 linux-user/x86_64/target_syscall.h      |   28 -
 linux-user/xtensa/target_elf.h          |    9 +-
 linux-user/xtensa/target_syscall.h      |   35 -
 hw/core/loader.c                        |    4 -
 linux-user/aarch64/cpu_loop.c           |   22 +-
 linux-user/aarch64/elfload.c            |  378 ++++
 linux-user/alpha/cpu_loop.c             |   11 +-
 linux-user/alpha/elfload.c              |   11 +
 linux-user/arm/cpu_loop.c               |   75 +-
 linux-user/arm/elfload.c                |  276 +++
 linux-user/elfload.c                    | 2159 +----------------------
 linux-user/hexagon/cpu_loop.c           |    8 +-
 linux-user/hexagon/elfload.c            |   35 +
 linux-user/hppa/cpu_loop.c              |   18 +-
 linux-user/hppa/elfload.c               |   47 +
 linux-user/i386/cpu_loop.c              |   48 +-
 linux-user/i386/elfload.c               |   46 +
 linux-user/linuxload.c                  |    6 +-
 linux-user/loongarch64/cpu_loop.c       |   11 +-
 linux-user/loongarch64/elfload.c        |   83 +
 linux-user/m68k/cpu_loop.c              |   32 +-
 linux-user/m68k/elfload.c               |   42 +
 linux-user/main.c                       |   13 +-
 linux-user/microblaze/cpu_loop.c        |   39 +-
 linux-user/microblaze/elfload.c         |   28 +
 linux-user/microblaze/signal.c          |   44 +
 linux-user/mips/cpu_loop.c              |   16 +-
 linux-user/mips/elfload.c               |  165 ++
 linux-user/mips64/elfload.c             |    1 +
 linux-user/openrisc/cpu_loop.c          |   11 +-
 linux-user/openrisc/elfload.c           |   22 +
 linux-user/openrisc/signal.c            |    9 +-
 linux-user/ppc/cpu_loop.c               |   26 +-
 linux-user/ppc/elfload.c                |  150 ++
 linux-user/riscv/cpu_loop.c             |   15 +-
 linux-user/riscv/elfload.c              |   23 +
 linux-user/s390x/cpu_loop.c             |   15 +-
 linux-user/s390x/elfload.c              |   93 +
 linux-user/s390x/signal.c               |    5 +
 linux-user/sh4/cpu_loop.c               |   10 +-
 linux-user/sh4/elfload.c                |   66 +
 linux-user/sparc/cpu_loop.c             |   16 +-
 linux-user/sparc/elfload.c              |   42 +
 linux-user/sparc/signal.c               |   20 +
 linux-user/x86_64/elfload.c             |   72 +
 linux-user/xtensa/cpu_loop.c            |   22 +-
 linux-user/xtensa/elfload.c             |   43 +
 semihosting/arm-compat-semi.c           |   28 +-
 meson.build                             |    6 +-
 90 files changed, 2255 insertions(+), 2911 deletions(-)
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

-- 
2.43.0


