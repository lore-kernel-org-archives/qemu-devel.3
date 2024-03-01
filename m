Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03058C54E5A
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjG-0005KW-Kb; Fri, 01 Mar 2024 23:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC4G-0000PZ-51
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:13:28 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC41-0006aj-61
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:13:27 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e4560664b5so2239765b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334791; x=1709939591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+UbEHBMhoq2U4plWax72+xkfgutFWy+FXSOt1ZDpIEI=;
 b=nKdf4BnxKhWErMqw3zVcC/Dx+SfxkLTUE1rqodijGLOoIM+yb7VF5k/TlS5CZ8Y0nm
 R4LBocnptZbSVXfnqCUatb0wUmr639aAfEvUC3nHG2c3n1YPPMhgys5glktVFrEFdtBt
 XTQRZCKyxzegXZETfnjbEuQqtnklUvBwLEwDeEFs11ImYrTniWM+ZEtgQpN9+SI5L3tp
 Dx2vIXKYKW4LGmr3URYb5EIFo2J2k5WqE6BKYUW4r4Y3uw/OhQsMUHSve9/gbisWTfHk
 Q8QzNf4VdCiHi6s+U08kQSYQZE1DRudSvt4iX4guHhf261oAziWP4kw5QjvSBzhp/kTL
 KNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334791; x=1709939591;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UbEHBMhoq2U4plWax72+xkfgutFWy+FXSOt1ZDpIEI=;
 b=vsg7ngGdnPZzIAYJn5N3/0X4UjcOBwkzisAuxjcJRbgj4vsFmjxrAaMg104FO1WSsR
 ScpCtkVGdbljY44mTnVju3xsMZMstMCVJRMntrusrlLcA/RYnStvueK7rXnRqIq+VaVd
 KTtTqv5OILeXzduR2q+kKzJCoyBetS+tslbuYz4rr6HDguH481Dhbncp0ccjLvnZUEcm
 ij7Z2780TB6Jkh8OddrG3FTKzEn6avSViyVaMaOVtkEZiH+99k0pLHb2FzN307uPVzET
 R/33/F2LCyaweLi5OmKoRA//XXLgLa+CEEJSCJcphrq6Z9icrIimXtST1T0jorsb0H0V
 OK0w==
X-Gm-Message-State: AOJu0YzgIx9e3wN1ePMaWIlXQjRq2C5B+GUp+FF2ZrAaJ7pvTelv1e4X
 gQZUEkSj8G90A4iMaEJhihN1TWgFUjPdFSPZ6hlxuVfJKqtZPPT86263iitThonjaefbe4ohqSE
 g
X-Google-Smtp-Source: AGHT+IElUDl+3hx3pTL9c0yyuBbhCla93erESnMkMcJFfqmSn7aift5bvzzwy2grRXw6vuG5zfdFLA==
X-Received: by 2002:a05:6a20:244a:b0:1a1:2793:a386 with SMTP id
 t10-20020a056a20244a00b001a12793a386mr3945164pzc.19.1709334791155; 
 Fri, 01 Mar 2024 15:13:11 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 r7-20020aa79887000000b006e4e616e520sm3448946pfl.72.2024.03.01.15.13.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 15:13:10 -0800 (PST)
Message-ID: <6c613f56-6011-41be-830c-70208e7079dc@linaro.org>
Date: Fri, 1 Mar 2024 13:13:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PULL 00/60] linux-user and tcg patch queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240301230619.661008-1-richard.henderson@linaro.org>
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Arg.  PULL.


On 3/1/24 13:05, Richard Henderson wrote:
> The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:
> 
>    Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240301
> 
> for you to fetch changes up to 04dadd22aed00e5a2955ab078d7edd676812cf41:
> 
>    tests/tcg: Check that shmat() does not break /proc/self/maps (2024-03-01 08:09:55 -1000)
> 
> ----------------------------------------------------------------
> linux-user: Rewrite elf coredump
> tcg/aarch64: Apple does not align __int128_t in even registers
> accel/tcg: Fixes for page tables in mmio memory
> linux-user: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> migration: Remove qemu_host_page_size
> hw/tpm: Remove qemu_host_page_size
> softmmu: Remove qemu_host_page_{size,mask}, HOST_PAGE_ALIGN
> linux-user: Split and reorganize target_mmap.
> *-user: Deprecate and disable -p pagesize
> linux-user: Allow TARGET_PAGE_BITS_VARY
> target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
> target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
> target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
> linux-user: Remove pgb_dynamic alignment assertion
> tcg/optimize: fix uninitialized variable
> linux-user: Rewrite shmat
> 
> ----------------------------------------------------------------
> Ilya Leoshkevich (1):
>        tests/tcg: Check that shmat() does not break /proc/self/maps
> 
> Jonathan Cameron (1):
>        tcg: Avoid double lock if page tables happen to be in mmio memory.
> 
> Paolo Bonzini (1):
>        tcg/optimize: fix uninitialized variable
> 
> Peter Maydell (1):
>        accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper
> 
> Richard Henderson (56):
>        linux-user/elfload: Disable core dump if getrlimit fails
>        linux-user/elfload: Merge init_note_info and fill_note_info
>        linux-user/elfload: Tidy fill_note_info and struct elf_note_info
>        linux-user/elfload: Stack allocate struct mm_struct
>        linux-user/elfload: Latch errno before cleanup in elf_core_dump
>        linux-user/elfload: Open core file after vma_init
>        linux-user/elfload: Truncate core file on open
>        linux-user/elfload: Lock cpu list and mmap during elf_core_dump
>        linux-user/elfload: Size corefile before opening
>        linux-user/elfload: Write corefile elf header in one block
>        linux-user/elfload: Write process memory to core file in larger chunks
>        linux-user/elfload: Simplify vma_dump_size
>        linux-user/elfload: Rely on walk_memory_regions for vmas
>        linux-user/elfload: Unprotect regions before core dump
>        tcg/aarch64: Apple does not align __int128_t in even registers
>        accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
>        linux-user: Adjust SVr4 NULL page mapping
>        linux-user: Remove qemu_host_page_{size, mask} in probe_guest_base
>        linux-user: Remove qemu_host_page_size from create_elf_tables
>        linux-user/hppa: Simplify init_guest_commpage
>        linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
>        linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
>        linux-user: Remove qemu_host_page_size from elf_core_dump
>        linux-user: Remove qemu_host_page_{size, mask} from mmap.c
>        linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
>        linux-user: Remove HOST_PAGE_ALIGN from mmap.c
>        migration: Remove qemu_host_page_size
>        hw/tpm: Remove HOST_PAGE_ALIGN from tpm_ppi_init
>        softmmu/physmem: Remove qemu_host_page_size
>        softmmu/physmem: Remove HOST_PAGE_ALIGN
>        linux-user: Remove qemu_host_page_size from main
>        linux-user: Split out target_mmap__locked
>        linux-user: Move some mmap checks outside the lock
>        linux-user: Fix sub-host-page mmap
>        linux-user: Split out mmap_end
>        linux-user: Do early mmap placement only for reserved_va
>        linux-user: Split out do_munmap
>        linux-user: Use do_munmap for target_mmap failure
>        linux-user: Split out mmap_h_eq_g
>        linux-user: Split out mmap_h_lt_g
>        linux-user: Split out mmap_h_gt_g
>        tests/tcg: Remove run-test-mmap-*
>        tests/tcg: Extend file in linux-madvise.c
>        *-user: Deprecate and disable -p pagesize
>        cpu: Remove page_size_init
>        accel/tcg: Disconnect TargetPageDataNode from page size
>        linux-user: Allow TARGET_PAGE_BITS_VARY
>        target/arm: Enable TARGET_PAGE_BITS_VARY for AArch64 user-only
>        linux-user: Bound mmap_min_addr by host page size
>        target/ppc: Enable TARGET_PAGE_BITS_VARY for user-only
>        target/alpha: Enable TARGET_PAGE_BITS_VARY for user-only
>        linux-user: Remove pgb_dynamic alignment assertion
>        linux-user/x86_64: Handle the vsyscall page in open_self_maps_{2,4}
>        linux-user/loongarch64: Remove TARGET_FORCE_SHMLBA
>        linux-user: Add strace for shmat
>        linux-user: Rewrite target_shmat
> 
>   docs/about/deprecated.rst                    |  10 +
>   docs/user/main.rst                           |   3 -
>   bsd-user/qemu.h                              |   7 +
>   include/exec/cpu-common.h                    |   7 -
>   include/hw/core/cpu.h                        |   2 -
>   linux-user/loongarch64/target_syscall.h      |   7 -
>   target/alpha/cpu-param.h                     |  16 +-
>   target/arm/cpu-param.h                       |   6 +-
>   target/ppc/cpu-param.h                       |   9 +-
>   tcg/aarch64/tcg-target.h                     |   6 +-
>   accel/tcg/cpu-exec.c                         |   8 +
>   accel/tcg/cputlb.c                           |  34 +-
>   accel/tcg/translate-all.c                    |   1 -
>   accel/tcg/user-exec.c                        |  31 +-
>   bsd-user/main.c                              |  23 +-
>   cpu-target.c                                 |  16 -
>   hw/tpm/tpm_ppi.c                             |   6 +-
>   linux-user/elfload.c                         | 789 ++++++++--------------
>   linux-user/main.c                            |  34 +-
>   linux-user/mmap.c                            | 939 +++++++++++++++++----------
>   linux-user/strace.c                          |  24 +
>   linux-user/syscall.c                         |  16 +
>   migration/ram.c                              |  22 +-
>   system/physmem.c                             |  17 +-
>   system/vl.c                                  |   1 -
>   target/arm/cpu.c                             |  51 +-
>   tcg/optimize.c                               |   3 +-
>   tests/tcg/multiarch/linux/linux-madvise.c    |   2 +
>   tests/tcg/multiarch/linux/linux-shmat-maps.c |  55 ++
>   linux-user/strace.list                       |   2 +-
>   tests/tcg/alpha/Makefile.target              |   3 -
>   tests/tcg/arm/Makefile.target                |   3 -
>   tests/tcg/hppa/Makefile.target               |   3 -
>   tests/tcg/i386/Makefile.target               |   3 -
>   tests/tcg/m68k/Makefile.target               |   3 -
>   tests/tcg/multiarch/Makefile.target          |   9 -
>   tests/tcg/ppc/Makefile.target                |  12 -
>   tests/tcg/sh4/Makefile.target                |   3 -
>   tests/tcg/sparc64/Makefile.target            |   6 -
>   39 files changed, 1156 insertions(+), 1036 deletions(-)
>   create mode 100644 tests/tcg/multiarch/linux/linux-shmat-maps.c
>   delete mode 100644 tests/tcg/ppc/Makefile.target
>   delete mode 100644 tests/tcg/sparc64/Makefile.target


