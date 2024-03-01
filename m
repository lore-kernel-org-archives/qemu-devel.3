Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78985C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxV-0004pl-Ds; Fri, 01 Mar 2024 18:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxS-0004pF-Ew
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxQ-0004C7-Ef
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:26 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso22774625ad.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334383; x=1709939183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VY1F3L/5MzAZr9YEQgYOvnzssCdPayAhddtW7RGoPAA=;
 b=DCFUV7jPKu85wE7nyiZpFqEtifRlPDLz9RRK4diLfL1OEui+7L1befIEWMi/FPDrd5
 JiaoK/nZoQDqlL3zu+T4pu9JNbYHf3ORNcwe6Vf5AmcV/NKXH2XYLGDpMe7ZvdTlRScW
 LtSeJFcrF7WnZqpZN670hdB5qpB6A7hv5hGziqtYh+q4KjLep9Wv37L2eK11zi3Pem2s
 DtFIioeXAQRACc3hFMjesQNX9fGwoX847zjC8L5fTqE6uSEbn7NbO+mnRGl7lJ6W/y8n
 /DAIj8Vmao2oxXE5iR2kwcJdcx/6PAE9dWI95SJjZHr3+PJ2CaRXu5ucBuUimh4V1UmO
 I9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334383; x=1709939183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VY1F3L/5MzAZr9YEQgYOvnzssCdPayAhddtW7RGoPAA=;
 b=ZcDGwd5tlnnNb38HIf+a99sBir6FPMuV8Y11YXsgGfPDelMS//xw2a6Cscpd/whr+X
 lLPPljoNtQfrOAX9fGVuE7+WEO4qRdFZOrhQHo5zqhYI5KwqirmREh+dHBd2jwAKJawk
 qWUvbc2hLMFF3V7d1s9rn0A+ScxfCaObgTM/+XpfcuQImnA0Hw6meonohGKAZBu75Zrd
 WP8cR2s/Z8SPK9qmYcpIvAVqkIn3cK+NdG3AJiuJhCG7CXoQe+NGlpNou4tWMqyOQLz7
 tbukUz03Q8cQvVxUtpDJuE2083smPbOr+EgxKkmvmRT6ZzupDh9YTNmp59GfDaw+MHoE
 7wgg==
X-Gm-Message-State: AOJu0YzYbi02Pi31gUs9uVqTtDhGEBaRf+oc7Q+ovFc1TW48MRx9W38Y
 AJO3m3rI947SSf3b5k5K27EmF2MAqyaivNMaYnd0mnMm+Wsq+BrPN6SF1DuUitAhd2jbaxvXLSm
 O
X-Google-Smtp-Source: AGHT+IHVPhwtn2UdhfSSe9Tmo1ztEfrJCQDT7sEwuKl1+TVcEstjv1JCuivkBPKO2CN4j9rBEZ7etg==
X-Received: by 2002:a17:902:eb90:b0:1dc:d773:ac with SMTP id
 q16-20020a170902eb9000b001dcd77300acmr3988169plg.7.1709334382639; 
 Fri, 01 Mar 2024 15:06:22 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/60] linux-user and tcg patch queue
Date: Fri,  1 Mar 2024 13:05:19 -1000
Message-Id: <20240301230619.661008-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:

  Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240301

for you to fetch changes up to 04dadd22aed00e5a2955ab078d7edd676812cf41:

  tests/tcg: Check that shmat() does not break /proc/self/maps (2024-03-01 08:09:55 -1000)

----------------------------------------------------------------
linux-user: Rewrite elf coredump
tcg/aarch64: Apple does not align __int128_t in even registers
accel/tcg: Fixes for page tables in mmio memory
linux-user: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
migration: Remove qemu_host_page_size
hw/tpm: Remove qemu_host_page_size
softmmu: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
linux-user: Split and reorganize target_mmap.
*-user: Deprecate and disable -p pagesize
linux-user: Allow TARGET_PAGE_BITS_VARY
target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
linux-user: Remove pgb_dynamic alignment assertion
tcg/optimize: fix uninitialized variable
linux-user: Rewrite shmat

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg: Check that shmat() does not break /proc/self/maps

Jonathan Cameron (1):
      tcg: Avoid double lock if page tables happen to be in mmio memory.

Paolo Bonzini (1):
      tcg/optimize: fix uninitialized variable

Peter Maydell (1):
      accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

Richard Henderson (56):
      linux-user/elfload: Disable core dump if getrlimit fails
      linux-user/elfload: Merge init_note_info and fill_note_info
      linux-user/elfload: Tidy fill_note_info and struct elf_note_info
      linux-user/elfload: Stack allocate struct mm_struct
      linux-user/elfload: Latch errno before cleanup in elf_core_dump
      linux-user/elfload: Open core file after vma_init
      linux-user/elfload: Truncate core file on open
      linux-user/elfload: Lock cpu list and mmap during elf_core_dump
      linux-user/elfload: Size corefile before opening
      linux-user/elfload: Write corefile elf header in one block
      linux-user/elfload: Write process memory to core file in larger chunks
      linux-user/elfload: Simplify vma_dump_size
      linux-user/elfload: Rely on walk_memory_regions for vmas
      linux-user/elfload: Unprotect regions before core dump
      tcg/aarch64: Apple does not align __int128_t in even registers
      accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
      linux-user: Adjust SVr4 NULL page mapping
      linux-user: Remove qemu_host_page_{size, mask} in probe_guest_base
      linux-user: Remove qemu_host_page_size from create_elf_tables
      linux-user/hppa: Simplify init_guest_commpage
      linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
      linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
      linux-user: Remove qemu_host_page_size from elf_core_dump
      linux-user: Remove qemu_host_page_{size, mask} from mmap.c
      linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
      linux-user: Remove HOST_PAGE_ALIGN from mmap.c
      migration: Remove qemu_host_page_size
      hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
      softmmu/physmem: Remove qemu_host_page_size
      softmmu/physmem: Remove HOST_PAGE_ALIGN
      linux-user: Remove qemu_host_page_size from main
      linux-user: Split out target_mmap__locked
      linux-user: Move some mmap checks outside the lock
      linux-user: Fix sub-host-page mmap
      linux-user: Split out mmap_end
      linux-user: Do early mmap placement only for reserved_va
      linux-user: Split out do_munmap
      linux-user: Use do_munmap for target_mmap failure
      linux-user: Split out mmap_h_eq_g
      linux-user: Split out mmap_h_lt_g
      linux-user: Split out mmap_h_gt_g
      tests/tcg: Remove run-test-mmap-*
      tests/tcg: Extend file in linux-madvise.c
      *-user: Deprecate and disable -p pagesize
      cpu: Remove page_size_init
      accel/tcg: Disconnect TargetPageDataNode from page size
      linux-user: Allow TARGET_PAGE_BITS_VARY
      target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
      linux-user: Bound mmap_min_addr by host page size
      target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
      target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
      linux-user: Remove pgb_dynamic alignment assertion
      linux-user/x86_64: Handle the vsyscall page in open_self_maps_{2,4}
      linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
      linux-user: Add strace for shmat
      linux-user: Rewrite target_shmat

 docs/about/deprecated.rst                    |  10 +
 docs/user/main.rst                           |   3 -
 bsd-user/qemu.h                              |   7 +
 include/exec/cpu-common.h                    |   7 -
 include/hw/core/cpu.h                        |   2 -
 linux-user/loongarch64/target_syscall.h      |   7 -
 target/alpha/cpu-param.h                     |  16 +-
 target/arm/cpu-param.h                       |   6 +-
 target/ppc/cpu-param.h                       |   9 +-
 tcg/aarch64/tcg-target.h                     |   6 +-
 accel/tcg/cpu-exec.c                         |   8 +
 accel/tcg/cputlb.c                           |  34 +-
 accel/tcg/translate-all.c                    |   1 -
 accel/tcg/user-exec.c                        |  31 +-
 bsd-user/main.c                              |  23 +-
 cpu-target.c                                 |  16 -
 hw/tpm/tpm_ppi.c                             |   6 +-
 linux-user/elfload.c                         | 789 ++++++++--------------
 linux-user/main.c                            |  34 +-
 linux-user/mmap.c                            | 939 +++++++++++++++++----------
 linux-user/strace.c                          |  24 +
 linux-user/syscall.c                         |  16 +
 migration/ram.c                              |  22 +-
 system/physmem.c                             |  17 +-
 system/vl.c                                  |   1 -
 target/arm/cpu.c                             |  51 +-
 tcg/optimize.c                               |   3 +-
 tests/tcg/multiarch/linux/linux-madvise.c    |   2 +
 tests/tcg/multiarch/linux/linux-shmat-maps.c |  55 ++
 linux-user/strace.list                       |   2 +-
 tests/tcg/alpha/Makefile.target              |   3 -
 tests/tcg/arm/Makefile.target                |   3 -
 tests/tcg/hppa/Makefile.target               |   3 -
 tests/tcg/i386/Makefile.target               |   3 -
 tests/tcg/m68k/Makefile.target               |   3 -
 tests/tcg/multiarch/Makefile.target          |   9 -
 tests/tcg/ppc/Makefile.target                |  12 -
 tests/tcg/sh4/Makefile.target                |   3 -
 tests/tcg/sparc64/Makefile.target            |   6 -
 39 files changed, 1156 insertions(+), 1036 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

