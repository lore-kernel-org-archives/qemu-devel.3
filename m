Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F46CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXX9-0001Es-Nz; Thu, 14 Aug 2025 08:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXX5-0001Cj-Ss
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXWx-00047C-BV
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:14 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-32326e8005bso999029a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176280; x=1755781080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CzqTQNXRS0WT72NCvoAdES29N3YtY49HWTf9cUpP7tk=;
 b=EU5eBZdeCYDQQ3MFfNBf6ZY91pGFru9+xslBvV/Fuo3eL+FC6cNjl9WTQmZtE73YgX
 nZUQtWaXT4+QJT88KwM/0qHQa3A2b7K5zne9GU9pRdshrWZUgAKKsYLH36IqmPcvupoK
 39kfC9j+NgktC7TCEJhf8IoN427iSUakx0+QCLe2g1dL6uny+SusV2QUL6bUkUVzFt37
 ZBFWmAzLuRsz14B6UA38AvujwFdqv5fnYXSoopvypoNnEuBrtbQ2/0E+r1GUW8d6Nc1o
 3hZpj5YiOIswDv4u5p6WQo/9IWwpnzjZ+Fdfwb5/zQyJ60xc3uskHoxDSiwpyqaCgQrT
 ez/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176280; x=1755781080;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CzqTQNXRS0WT72NCvoAdES29N3YtY49HWTf9cUpP7tk=;
 b=kQIH1uvX3WaYW0AVje3FMq1/Iro8OJ6TzktgxKjhcuudJKi6aoFKZoncbjusn3FWQ6
 gjlxieW4orSZfGim5ZTiM/gx9M2G3j0wpEaeao2ArsFJ1+pAgNwpHwUdJJ89k8pI67jD
 1VC3Dh6Iu1a+F+UR4Pd0dbmLL6rUEDluTgC1Y6fECIFQW9abKmcXOIkVQ+xc0Hl7nE7J
 vkZU0REoT2UUAYb1RaCOjhlpfkDyD22jTRZQFvFA8tciSLH6oUdSkIkci/MY3EHhuvyD
 xiV+LZ75gXMTuqPcbrgNvu/yknCNAhIbe77z5YQSy6dZP1SrUl4VGytbf6eXOcF8lBf/
 Qxbw==
X-Gm-Message-State: AOJu0YwEeEGr9EPBEUHpZgobwYitJGhD6B1FbN+D6kGUCmxmZBQo8XNs
 bQ821/7CXEMEOES+tngwR35QB8vGVhtFsXipBT66cXUnXlXbWuzHZNlJIfBzX3+7X2aBidR46k7
 1mplRIoo=
X-Gm-Gg: ASbGnctnrwmDu2CEY+59t/kDUHn2yzPnZGJBQzVUDSfJ6+w9ogCxCwltrxl7hs+DYeE
 dbAZtCs8syzApz0EUw3ZwTnf8Wchspb0ojJCazDxHiJsOEgIyklE+joxrIVLH2jbcwYHveBLxVt
 P12pzn1Q+opCM/N3pdMMGNy53nvE/QqE2404OQ3eE0TaLOLbd0C4gMTQ9Mo4F4urs7L3WEa08S9
 NzORlXSx+BRuHSa3V2tq49WCbrBs8n4PCRgqAJ4UG+iI1AeFZQk9ISiBTbBZGVGGyFA3UcvMnOx
 lkSK0cEvqD29AzDLPRinrOhuwJj83TchlUofCdtqU2CuKzzt6kDD7bIahwTpW6Vot5OBZuGm4LJ
 bM12gAj9tqSElCLA0JJSwp5uxvAUCNs0COzDxsUrWqKbWFTA=
X-Google-Smtp-Source: AGHT+IE5dTsLXEbqVn30757hBcyH1R+erpqziU2w1jeTmx6JMuCAc4pxbAi0VMQ+UyBfS1rwgCt3Dw==
X-Received: by 2002:a17:90b:384e:b0:31f:104f:e4b1 with SMTP id
 98e67ed59e1d1-3232799e3f6mr5100803a91.7.1755176280432; 
 Thu, 14 Aug 2025 05:58:00 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:57:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 00/85] target/arm: Implement FEAT_GCS
Date: Thu, 14 Aug 2025 22:56:27 +1000
Message-ID: <20250814125752.164107-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Based-on: 20250727074202.83141-1-richard.henderson@linaro.org
("[PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu")

Tree: https://gitlab.com/rth7680/qemu/-/tree/tgt-arm-gcs

This includes the prerequisite features, ATS1A and S1PIE, and
not a prerequisite but closely related, S2PIE.

This passes the linux kselftests for gcs, with a 48-bit VA.
I also include a few smoke tests in tests/tcg/.

There's something subtly wrong with a 52-bit VA.  Most everything
works fine, but the first GCS lookup faults on a missing level 3
page table entry: a Translation fault, not a Permission fault.
The kernel then panics.  Either there's something amiss with our
implementation of FEAT_LPA2, or there's a kernel bug.

This includes a best-effort linux-user implementation.  Since we
don't have softmmu in user-only (yet), gcs stack pages get normal
read/write access.  This means we cannot write-protect the pages
in the same way the system implementation can.  But all of the
other parts of GCS work fine, which is good enough for testing.

Changes for v3:
  - Use tcg global for gcsptr_elx, rather than explicit load/store.
    Surprisingly, searching for gcsptr in the op_opt dump was the
    easiest way to find the needle in the exception haystack that
    was Thiago's SIGSEGV vs SIGBUS problem.  Once I'd done it, I
    decided to keep it.
  - Force align gcspr_elx on write.
  - Collect r-b and review comments.


r~


Richard Henderson (85):
  linux-user/aarch64: Split out signal_for_exception
  linux-user/aarch64: Check syndrome for EXCP_UDEF
  linux-user/aarch64: Generate ESR signal records
  target/arm: Add prot_check parameter to pmsav8_mpu_lookup
  target/arm: Add in_prot_check to S1Translate
  target/arm: Skip permission check from
    arm_cpu_get_phys_page_attrs_debug
  target/arm: Introduce get_phys_addr_for_at
  target/arm: Skip AF and DB updates for AccessType_AT
  target/arm: Add prot_check parameter to do_ats_write
  target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
  target/arm: Remove outdated comment for ZCR_EL12
  target/arm: Implement FEAT_ATS1A
  target/arm: Add isar feature test for FEAT_S1PIE, FEAT_S2PIE
  target/arm: Enable TCR2_ELx.PIE
  target/arm: Implement PIR_ELx, PIRE0_ELx, S2PIR_EL2 registers
  target/arm: Force HPD for stage2 translations
  target/arm: Cache NV1 early in get_phys_addr_lpae
  target/arm: Populate PIE in aa64_va_parameters
  target/arm: Implement get_S1prot_indirect
  target/arm: Implement get_S2prot_indirect
  target/arm: Do not migrate env->exception
  target/arm: Expand CPUARMState.exception.syndrome to 64 bits
  target/arm: Expand syndrome parameter to raise_exception*
  target/arm: Implement dirtybit check for PIE
  target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu max
  include/hw/core/cpu: Introduce MMUIdxMap
  include/hw/core/cpu: Introduce cpu_tlb_fast
  include/hw/core/cpu: Invert the indexing into CPUTLBDescFast
  target/hppa: Adjust mmu indexes to begin with 0
  include/exec/memopidx: Adjust for 32 mmu indexes
  include/hw/core/cpu: Widen MMUIdxMap
  target/arm: Split out mmuidx.h from cpu.h
  target/arm: Convert arm_mmu_idx_to_el from switch to table
  target/arm: Remove unused env argument from regime_el
  target/arm: Convert regime_el from switch to table
  target/arm: Convert regime_has_2_ranges from switch to table
  target/arm: Remove unused env argument from regime_is_pan
  target/arm: Convert regime_is_pan from switch to table
  target/arm: Remove unused env argument from regime_is_user
  target/arm: Convert regime_is_user from switch to table
  target/arm: Convert arm_mmu_idx_is_stage1_of_2 from switch to table
  target/arm: Convert regime_is_stage2 to table
  target/arm: Introduce mmu indexes for GCS
  target/arm: Introduce regime_to_gcs
  target/arm: Support page protections for GCS mmu indexes
  target/arm: Implement gcs bit for data abort
  target/arm: Add GCS cpregs
  target/arm: Add GCS enable and trap levels to DisasContext
  target/arm: Implement FEAT_CHK
  target/arm: Expand pstate to 64 bits
  target/arm: Add syndrome data for EC_GCS
  target/arm: Implement EXLOCKException for ELR_ELx and SPSR_ELx
  target/arm: Split {arm,core}_user_mem_index
  target/arm: Introduce delay_exception{_el}
  target/arm: Emit HSTR trap exception out of line
  target/arm: Emit v7m LTPSIZE exception out of line
  target/arm: Implement GCSSTR, GCSSTTR
  target/arm: Implement GCSB
  target/arm: Implement GCSPUSHM
  target/arm: Implement GCSPOPM
  target/arm: Implement GCSPUSHX
  target/arm: Implement GCSPOPX
  target/arm: Implement GCSPOPCX
  target/arm: Implement GCSSS1
  target/arm: Implement GCSSS2
  target/arm: Add gcs record for BL
  target/arm: Add gcs record for BLR
  target/arm: Add gcs record for BLR with PAuth
  target/arm: Load gcs record for RET
  target/arm: Load gcs record for RET with PAuth
  target/arm: Copy EXLOCKEn to EXLOCK on exception to the same EL
  target/arm: Implement EXLOCK check during exception return
  target/arm: Enable FEAT_GCS with -cpu max
  linux-user/aarch64: Implement prctls for GCS
  linux-user/aarch64: Allocate new gcs stack on clone
  linux-user/aarch64: Release gcs stack on thread exit
  linux-user/aarch64: Implement map_shadow_stack syscall
  target/arm: Enable GCSPR_EL0 for read in user-mode
  linux-user/aarch64: Inject SIGSEGV for GCS faults
  linux-user/aarch64: Generate GCS signal records
  linux-user: Change exported get_elf_hwcap to abi_ulong
  linux-user/aarch64: Enable GCS in HWCAP
  tests/tcg/aarch64: Add gcsstr
  tests/tcg/aarch64: Add gcspushm
  tests/tcg/aarch64: Add gcsss

 include/exec/cputlb.h              |  32 +--
 include/exec/memopidx.h            |   9 +-
 include/hw/core/cpu.h              |  25 +-
 linux-user/aarch64/gcs-internal.h  |  38 +++
 linux-user/aarch64/target_prctl.h  |  96 +++++++
 linux-user/aarch64/target_signal.h |   1 +
 linux-user/loader.h                |   2 +-
 linux-user/qemu.h                  |   5 +
 target/arm/cpregs.h                |  46 ++-
 target/arm/cpu-features.h          |  20 ++
 target/arm/cpu.h                   | 242 ++--------------
 target/arm/internals.h             | 169 ++----------
 target/arm/mmuidx-internal.h       | 113 ++++++++
 target/arm/mmuidx.h                | 241 ++++++++++++++++
 target/arm/syndrome.h              |  35 +++
 target/arm/tcg/translate.h         |  46 ++-
 target/hppa/cpu.h                  |  28 +-
 tests/tcg/aarch64/gcs.h            |  80 ++++++
 accel/tcg/cputlb.c                 |  49 ++--
 linux-user/aarch64/cpu_loop.c      | 167 ++++++++---
 linux-user/aarch64/signal.c        | 170 +++++++++++-
 linux-user/elfload.c               |  11 +-
 linux-user/syscall.c               | 114 ++++++++
 target/arm/cpregs-gcs.c            | 152 ++++++++++
 target/arm/cpu.c                   |  17 +-
 target/arm/gdbstub64.c             |   2 +
 target/arm/helper.c                | 270 ++++++++++++++----
 target/arm/machine.c               |  62 ++++-
 target/arm/mmuidx.c                |  66 +++++
 target/arm/ptw.c                   | 429 +++++++++++++++++++++-------
 target/arm/tcg-stubs.c             |   2 +-
 target/arm/tcg/cpregs-at.c         |  69 +++--
 target/arm/tcg/cpu64.c             |   4 +
 target/arm/tcg/helper-a64.c        |  13 +-
 target/arm/tcg/hflags.c            |  38 +++
 target/arm/tcg/m_helper.c          |   4 +-
 target/arm/tcg/mte_helper.c        |   2 +-
 target/arm/tcg/op_helper.c         |   8 +-
 target/arm/tcg/tlb-insns.c         |  47 +++-
 target/arm/tcg/tlb_helper.c        |  18 +-
 target/arm/tcg/translate-a64.c     | 430 ++++++++++++++++++++++++++---
 target/arm/tcg/translate.c         |  78 ++++--
 tcg/tcg.c                          |   3 +-
 tests/tcg/aarch64/gcspushm.c       |  71 +++++
 tests/tcg/aarch64/gcsss.c          |  74 +++++
 tests/tcg/aarch64/gcsstr.c         |  48 ++++
 docs/system/arm/emulation.rst      |   5 +
 target/arm/meson.build             |   9 +-
 target/arm/tcg/a64.decode          |   5 +
 tcg/aarch64/tcg-target.c.inc       |   2 +-
 tcg/arm/tcg-target.c.inc           |   2 +-
 tests/tcg/aarch64/Makefile.target  |   5 +
 52 files changed, 2938 insertions(+), 736 deletions(-)
 create mode 100644 linux-user/aarch64/gcs-internal.h
 create mode 100644 target/arm/mmuidx-internal.h
 create mode 100644 target/arm/mmuidx.h
 create mode 100644 tests/tcg/aarch64/gcs.h
 create mode 100644 target/arm/cpregs-gcs.c
 create mode 100644 target/arm/mmuidx.c
 create mode 100644 tests/tcg/aarch64/gcspushm.c
 create mode 100644 tests/tcg/aarch64/gcsss.c
 create mode 100644 tests/tcg/aarch64/gcsstr.c

-- 
2.43.0


