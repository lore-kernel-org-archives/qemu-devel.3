Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD815C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLX-0004e1-SG; Sun, 27 Jul 2025 04:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLV-0004Ke-Or
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLT-0003xm-CK
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-23ffa7b3b30so3139735ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603378; x=1754208178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kGrFKsLSwAq589UJRt8AQw5NA54l8v/cnUUsIGEtovA=;
 b=Njeje02ttSAOnaXYjdYs05k+k6Z3pzWirRof1jZ78ZIyIuTA1/sLzG+1HI6awdoWn+
 3DXtEzksxyv94ngZREdQ3c/nEiPj7D9ld4nauU4gvE2Y2EQdLHodfr9CLBgDPpTbWnTp
 hVZt31h/Kj4yS2QtrKAYUC2fIG9a/w6STEsvkWIKiofl3k6R4pCc9eUwHlD+xGh13Rv6
 kCsyv6mnto6NRM2gd73XTWEKc3r9xexqrJNWUh7rWp4XpKn+UH9U1LXMiSQLsCv0gtfZ
 GDuyK553CSB9jBbtjIaPlStzjC3vd2rr0MTQBrg1MbX+CK5FNHls0qWmQKo/DJOlL082
 74vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603378; x=1754208178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kGrFKsLSwAq589UJRt8AQw5NA54l8v/cnUUsIGEtovA=;
 b=VOv+LXNfvIHrbyuyDpGC/aqG1OUSpYhI/kCOdjyZY0WQxHCJuUZVOlfQnytaT8aYHi
 IMLi2Ltq21oOC5XDhYHtDsrQioRs06/Lo/1zWP8lldupWrRGh+Q+Nb80jHOpcx3wENt1
 HVnl7b0bSJdb4GW9crKN2/Zjl9oSyuqyDQ+VkNZLbd0J82ZdJX8zJ0J5eoFD+f7m1wn4
 pKxPzJMF2lV+F/tSv6cS6MLjgGdUnTMW0DlWTiQrKw2ean+K+O5Ngn/+jT1+HBtVbuOj
 SmbRl8ZG0m9DRdETOSbUmq9QoDtGRaEV67FLnwuKFcCID1gkPVa0DrrnmBCeI7rqC4UI
 ilDA==
X-Gm-Message-State: AOJu0YwGFfMyWJr7k3Z6zJMHUQd2BDJVxkMIzqjp1U6+GA1ywJalAvVP
 +ah32nEWbaYw9x0Yz2CHZvEwwy3Rsnk+Emsn1WRrmJtExKvCi9dU9qR/gDhMQ/g1W0Wy2HUdpiL
 voRCl
X-Gm-Gg: ASbGnctoVy5LkcgVqjuLwBXJNyMZ6jtrC8airt0EBYofE14ctxdD5SeHJB0WHg19yiM
 xANrrFPc+qxrAUkFwDLrRjYLgUBXbnoP2GR/+HNEl2CZPJUL6B+dP29Iqhr2SgEtZxty4enDyx+
 AfTeoUePml/A1zy+3rYOGXAYsz9LzgPHpvHQJfW+O4h8M04hTGJvI21lXnECRy5PkDIs/INmvQA
 4swR0QpidV20xPN1zToXlyhiIu8ktWDo0mGD+6e153Tg8tG+03KeMTWo/8DG2/e3zvBfdDfmf2l
 MdPvS0La7schxZ61mi1CRD782blESfKzCAEdFo152u9f2C2laKm06Yj+dIsolszzGjZ+c12zUPo
 EewNplQqGW3VZAHCKQ3V9U+RDe2Ltdx7wudHm1qeGN1N6hNZOS8cPPGHsrNEVcREfI3MvMt3sCN
 0ZmimFHSsh5w==
X-Google-Smtp-Source: AGHT+IGUsm0tPeK7LAhWC5aukN0Gov22/7Lw0Aqw/eVUr+AQ4h0IEB0AEZuGywtJgiw88Fv8aflt8A==
X-Received: by 2002:a17:903:3b88:b0:235:ef67:b5a0 with SMTP id
 d9443c01a7336-23fb3155715mr112070665ad.36.1753603377821; 
 Sun, 27 Jul 2025 01:02:57 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:02:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-10.2 00/82] target/arm: Implement FEAT_GCS
Date: Sat, 26 Jul 2025 22:01:32 -1000
Message-ID: <20250727080254.83840-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Based-on: 20250725230849.13026-1-richard.henderson@linaro.org
("[PATCH for-10.2 v2 0/3] linux-user/aarch64: Syndrome fixes and enhancements")

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


r~


Richard Henderson (82):
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
 include/hw/core/cpu.h              |  20 +-
 linux-user/aarch64/gcs-internal.h  |  38 +++
 linux-user/aarch64/target_prctl.h  |  96 +++++++
 linux-user/aarch64/target_signal.h |   1 +
 linux-user/loader.h                |   2 +-
 linux-user/qemu.h                  |   5 +
 target/arm/cpregs.h                |  46 ++-
 target/arm/cpu-features.h          |  20 ++
 target/arm/cpu.h                   | 242 ++--------------
 target/arm/internals.h             | 170 ++---------
 target/arm/mmuidx-internal.h       | 111 ++++++++
 target/arm/mmuidx.h                | 241 ++++++++++++++++
 target/arm/syndrome.h              |  35 +++
 target/arm/tcg/translate.h         |  46 ++-
 target/hppa/cpu.h                  |  28 +-
 tests/tcg/aarch64/gcs.h            |  80 ++++++
 accel/tcg/cputlb.c                 |  49 ++--
 linux-user/aarch64/cpu_loop.c      |   5 +
 linux-user/aarch64/signal.c        | 129 ++++++++-
 linux-user/elfload.c               |  11 +-
 linux-user/syscall.c               | 114 ++++++++
 target/arm/cpregs-gcs.c            | 141 ++++++++++
 target/arm/cpu.c                   |  17 +-
 target/arm/gdbstub64.c             |   1 +
 target/arm/helper.c                | 270 ++++++++++++++----
 target/arm/machine.c               |  62 +++-
 target/arm/mmuidx.c                |  66 +++++
 target/arm/ptw.c                   | 430 +++++++++++++++++++++-------
 target/arm/tcg-stubs.c             |   2 +-
 target/arm/tcg/cpregs-at.c         |  69 +++--
 target/arm/tcg/cpu64.c             |   4 +
 target/arm/tcg/helper-a64.c        |  13 +-
 target/arm/tcg/hflags.c            |  38 +++
 target/arm/tcg/m_helper.c          |   4 +-
 target/arm/tcg/mte_helper.c        |   2 +-
 target/arm/tcg/op_helper.c         |   8 +-
 target/arm/tcg/tlb-insns.c         |  47 +++-
 target/arm/tcg/tlb_helper.c        |  13 +-
 target/arm/tcg/translate-a64.c     | 437 ++++++++++++++++++++++++++---
 target/arm/tcg/translate.c         |  78 +++--
 tcg/tcg.c                          |   3 +-
 tests/tcg/aarch64/gcspushm.c       |  77 +++++
 tests/tcg/aarch64/gcsss.c          |  74 +++++
 tests/tcg/aarch64/gcsstr.c         |  48 ++++
 docs/system/arm/emulation.rst      |   5 +
 target/arm/meson.build             |   9 +-
 target/arm/tcg/a64.decode          |   5 +
 tests/tcg/aarch64/Makefile.target  |   5 +
 50 files changed, 2764 insertions(+), 694 deletions(-)
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


