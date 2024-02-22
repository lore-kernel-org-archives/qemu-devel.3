Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56CC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFum-0006vZ-4r; Thu, 22 Feb 2024 15:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFuk-0006rR-G4
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:30 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFui-0002ZU-0Y
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:43:30 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d7431e702dso2267835ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634606; x=1709239406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=e3ksIOvNEk9D5oFNIRRHPUvB1mnd7rvsTcn4yoh133o=;
 b=iH8SoWTlbwnKDRbfJhUK+p+8N+KA2OT+HtMwT1wJHi4treVzqKfa6aeKNU/zzuI1l4
 wXjCRkvkIycaRPqbuXdmlBFKxiRaJBnTiyPMIWAXQA6vkAYM2gQZaobnYo7DT3+gNdOU
 v1FK6wdfOyq9jaRWDA+WkruTXHh8R0vgAO0wDGZyVCSEjmgqN8FxFZ7J/0T4OXrcfe0L
 64TjR4WCpTJZzxTQ1Z1E1HfJe2S2+LQVusu2HF0ptOle3vnw02ppsWbgSE2fH7DRhtwX
 t+TJZVGUvzgaOnhI6w3C7mACkWrg7yXLbPUV9RQ7lmBLeEizVH5t1ru7ATkrQlnE66f0
 TEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634606; x=1709239406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e3ksIOvNEk9D5oFNIRRHPUvB1mnd7rvsTcn4yoh133o=;
 b=ZeCvmk0386d+6n0/Pdlg5REwZKg9pyQoUsdEfKWtKWxF5E1HvPz3BIMpyPNutHJ9ns
 RQNl4QDqtbqwlT/S+u8GzvmDR+EXWKoCKMaLFaObfQypv4tOOHHvtMM1aMtoZFB1KUqn
 agmYEofxUas4lwmzwIz2SMdLn56/53eF55MwVGYGM7FEYWuR5f5/UP0T8SaRKGIMJCCt
 LvNDABBG91irwPGO8uj6Dz2ZHbIWgkp1NlZoAcjqAlw/RHdaeELsLeTNCJ25ZgCyqDe8
 5BIBL7lTcgLCFPFKLVgUWsF91GC/pzrMV8jTS/CoTJH/nxitotRO6SvDGYDE/MtWyUA1
 oc7g==
X-Gm-Message-State: AOJu0YzU2XGCHF6fffHNebE6HvL9MHHI09wSCvWYdQxA7L2LF02omv82
 wzv7uhwBICqO122t66yn/n/PwPIc4KYZxRRywpmxWe8gvkbQLrq431w48VFhw6eSfxpo3diIDs4
 g
X-Google-Smtp-Source: AGHT+IENi5DQ6nWy+aGg36iiwlMJosYrWwWL/P0Aph5aAX2EyFAzD8PvA4GR3hjH+N4DxTsrf3YrgA==
X-Received: by 2002:a17:902:ea0d:b0:1db:e7a4:90a8 with SMTP id
 s13-20020a170902ea0d00b001dbe7a490a8mr15953550plg.10.1708634606150; 
 Thu, 22 Feb 2024 12:43:26 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.43.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:43:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] tcg and linux-user patch queue
Date: Thu, 22 Feb 2024 10:42:44 -1000
Message-Id: <20240222204323.268539-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The following changes since commit 6630bc04bccadcf868165ad6bca5a964bb69b067:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-02-22 12:42:52 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240222

for you to fetch changes up to a06efc2615a1283e139e35ae8a8875925766268f:

  linux-user: Remove pgb_dynamic alignment assertion (2024-02-22 09:04:05 -1000)

----------------------------------------------------------------
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

----------------------------------------------------------------
Jonathan Cameron (1):
      tcg: Avoid double lock if page tables happen to be in mmio memory.

Peter Maydell (1):
      accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper

Richard Henderson (37):
      tcg/aarch64: Apple does not align __int128_t in even registers
      accel/tcg: Remove qemu_host_page_size from page_protect/page_unprotect
      linux-user: Adjust SVr4 NULL page mapping
      linux-user: Remove qemu_host_page_{size, mask} in probe_guest_base
      linux-user: Remove qemu_host_page_size from create_elf_tables
      linux-user/hppa: Simplify init_guest_commpage
      linux-user/nios2: Remove qemu_host_page_size from init_guest_commpage
      linux-user/arm: Remove qemu_host_page_size from init_guest_commpage
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

 docs/about/deprecated.rst                 |  10 +
 docs/user/main.rst                        |   3 -
 bsd-user/qemu.h                           |   7 +
 include/exec/cpu-common.h                 |   7 -
 include/hw/core/cpu.h                     |   2 -
 target/alpha/cpu-param.h                  |  16 +-
 target/arm/cpu-param.h                    |   6 +-
 target/ppc/cpu-param.h                    |   9 +-
 tcg/aarch64/tcg-target.h                  |   6 +-
 accel/tcg/cpu-exec.c                      |   8 +
 accel/tcg/cputlb.c                        |  34 +-
 accel/tcg/translate-all.c                 |   1 -
 accel/tcg/user-exec.c                     |  31 +-
 bsd-user/main.c                           |  22 +-
 cpu-target.c                              |  13 -
 hw/tpm/tpm_ppi.c                          |   6 +-
 linux-user/elfload.c                      |  68 +--
 linux-user/main.c                         |  34 +-
 linux-user/mmap.c                         | 767 ++++++++++++++++++------------
 migration/ram.c                           |  22 +-
 system/physmem.c                          |  17 +-
 system/vl.c                               |   1 -
 target/arm/cpu.c                          |  51 +-
 tests/tcg/multiarch/linux/linux-madvise.c |   2 +
 tests/tcg/alpha/Makefile.target           |   3 -
 tests/tcg/arm/Makefile.target             |   3 -
 tests/tcg/hppa/Makefile.target            |   3 -
 tests/tcg/i386/Makefile.target            |   3 -
 tests/tcg/m68k/Makefile.target            |   3 -
 tests/tcg/multiarch/Makefile.target       |   9 -
 tests/tcg/ppc/Makefile.target             |  12 -
 tests/tcg/sh4/Makefile.target             |   3 -
 tests/tcg/sparc64/Makefile.target         |   6 -
 33 files changed, 700 insertions(+), 488 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

