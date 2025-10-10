Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E76CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cor-00067C-1n; Fri, 10 Oct 2025 09:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cok-00065F-9Y
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:54 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoY-0003kc-0Q
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so889652f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101530; x=1760706330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7wUD/X4agPPezVZD1GB/jD7PFqbWMElV706HPTNRBdA=;
 b=suepHKVtW5wyV4XNMPyS3TdmCEqj0txBbx1PAHuETiMDzXAzCtkLlPxiCoZWBUtRJu
 0EobmIXzwm20xGiU3a3nDofmgZJDN9J/ivRPde9eGKjJFp2BmVcNa2oWZPgPQ7/BaD9N
 2+U0CngVRn4VUDQAnb4oIOiM/VnfvXFz0z19wk4FyWAEGHVZrb1nWeVaHtKPgaak8jaB
 JPpoUn6HETYZjfsHWEll8uzxdpI7ewzBe+ZYIXvCO9GoxmLrDBlpl4/O1i+ESFAi9uvv
 WG5OzPqv6prq9mRHblQ377VOOcDVetJEi/i3oltI5QjiXZaUNu7gbhLdao0SroDrbzqZ
 nV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101530; x=1760706330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wUD/X4agPPezVZD1GB/jD7PFqbWMElV706HPTNRBdA=;
 b=Wny5aTr4tdNXF0bHRzl4WTcefqhn6BLBCLGjvhh+zMbB4qFuDQ4rido0fGzm04+88R
 jwZfA5A0KzMB2hOZsdB/U0uQPtH9bE8XoQ1UwPslBBiAm23Ye2bMzikH4/3TL+NwkqkW
 6ZoOfPDiQfRm/3lFlAbDCF9+YpyZCAW1DbRUTk3ABIa0c1LHAuoN+6aFGnOTczhf+mRU
 HW8nAMdr1vQokd6byX1KuU7/TREoiJkG83F4RSyC84h0417lkT0zON+K1NA3upyE/RH1
 2WMfjJLBdnIrrYmuNwh2nrKBfcFJ9rDl1RYOEplAYZGedB/Mhih6RZXtDGstvNt+o5B7
 ptXA==
X-Gm-Message-State: AOJu0YzaUGXa3PgEPyJVywgzPtqIy3nSBqL19fbvoRDZaDIt7aNldKnD
 ySdMF1F96aWBRrtXPAE39dGL3v07Oy5jmAV5pZ0+PlQKRhDKmCD8ME0eu9/TO2w6iu3z55UiUtD
 cEPsC
X-Gm-Gg: ASbGncuPM0APlZWd8UVIUZCDjaA7NBJt0mInJ/sg4c1uTaIWtPZ200vqFsnxRlWxZ/H
 J4zMeu+qcQ43PzyzEJGw6+O19ao98njtXu2r2ObglMIjgCEuP9MyTUudSoLmPBJk3OLC4TFQgwV
 KJreJ39R3/KqasW4/jwzHKC/qESJXHQbTpttxUkX4sOinYzMPz5Ut4g9g2yrREmsr0kgkJLliQS
 B/FYAKmIzAA1nA41i1Hr5VO5OSI0BKh/X+HgTma2ihDFuQjNklXA65gBycs5vX+BEKdNo9eyV2s
 wTB2flGvpOr9R2RRfpAnnqF/rV6tzRAHf5qGVzsn9tGCSnmBVJHwT+saRT0IwCYQZCMPpkhkhM+
 v09nyGfNwAv4NXJ9GavCFt4K3hHtLdEIGXtEv77ZeoukGs4mn1hGehYjhrEl0HQ==
X-Google-Smtp-Source: AGHT+IHiToZBRlpj9JicYy6U6xbwhP++ln0SKwq1MbrLuXsPGHjI7WxLp9gpOwK2zyerrlPdNmN+cg==
X-Received: by 2002:a5d:5d0c:0:b0:425:856f:70ff with SMTP id
 ffacd0b85a97d-4266e8e080fmr8540733f8f.45.1760101529961; 
 Fri, 10 Oct 2025 06:05:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/76] target-arm queue
Date: Fri, 10 Oct 2025 14:04:11 +0100
Message-ID: <20251010130527.3921602-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi; this is another target-arm pullreq. It's a big one but it's
only two series: FEAT_MEC and FEAT_GCS.

thanks
-- PMM

The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:

  Merge tag 'pull-loongarch-20251009' of https://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251010

for you to fetch changes up to 00936783abf77ebb47a78312a2e6500c6a13d938:

  target/arm: Enable FEAT_MEC in -cpu max (2025-10-10 13:22:05 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement FEAT_GCS
 * Implement FEAT_MEC

----------------------------------------------------------------
Gustavo Romero (3):
      target/arm: Add a cpreg flag to indicate no trap in NV
      target/arm: Implement FEAT_MEC registers
      target/arm: Enable FEAT_MEC in -cpu max

Pierrick Bouvier (1):
      tests/functional: update tests using TF-A/TF-RMM to support FEAT_GCS

Richard Henderson (72):
      target/arm: Add isar feature test for FEAT_S1PIE, FEAT_S2PIE
      target/arm: Enable TCR2_ELx.PIE
      target/arm: Implement PIR_ELx, PIRE0_ELx, S2PIR_EL2 registers
      target/arm: Force HPD for stage2 translations
      target/arm: Cache NV1 early in get_phys_addr_lpae
      target/arm: Populate PIE in aa64_va_parameters
      target/arm: Implement get_S1prot_indirect
      target/arm: Implement get_S2prot_indirect
      target/arm: Expand CPUARMState.exception.syndrome to 64 bits
      target/arm: Expand syndrome parameter to raise_exception*
      target/arm: Implement dirtybit check for PIE
      target/arm: Enable FEAT_S1PIE and FEAT_S2PIE on -cpu max
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
      target/arm: Make helper_exception_return system-only
      target/arm: Export cpsr_{read_for, write_from}_spsr_elx
      target/arm: Expand pstate to 64 bits
      target/arm: Add syndrome data for EC_GCS
      target/arm: Add arm_hcr_el2_nvx_eff
      target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
      target/arm: Split out access_nv1_with_nvx
      target/arm: Implement EXLOCKException for ELR_ELx and SPSR_ELx
      target/arm: Split {full,core}_a64_user_mem_index
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
      linux-user/aarch64: Enable GCS in HWCAP
      tests/tcg/aarch64: Add gcsstr
      tests/tcg/aarch64: Add gcspushm
      tests/tcg/aarch64: Add gcsss

 docs/system/arm/emulation.rst                      |   7 +
 include/exec/memopidx.h                            |   9 +-
 include/hw/core/cpu.h                              |   7 +-
 linux-user/aarch64/gcs-internal.h                  |  38 ++
 linux-user/aarch64/target_prctl.h                  |  96 +++++
 linux-user/aarch64/target_signal.h                 |   1 +
 linux-user/qemu.h                                  |   5 +
 target/arm/cpregs.h                                |  42 +-
 target/arm/cpu-features.h                          |  20 +
 target/arm/cpu.h                                   | 253 ++----------
 target/arm/internals.h                             | 151 ++-----
 target/arm/mmuidx-internal.h                       | 113 ++++++
 target/arm/mmuidx.h                                | 241 ++++++++++++
 target/arm/syndrome.h                              |  35 ++
 target/arm/tcg/helper-a64.h                        |   5 +-
 target/arm/tcg/translate.h                         |  46 ++-
 tests/tcg/aarch64/gcs.h                            |  80 ++++
 target/arm/tcg/a64.decode                          |   5 +
 accel/tcg/cputlb.c                                 |   3 -
 linux-user/aarch64/cpu_loop.c                      |   5 +
 linux-user/aarch64/elfload.c                       |   1 +
 linux-user/aarch64/signal.c                        | 138 ++++++-
 linux-user/syscall.c                               | 114 ++++++
 target/arm/cpregs-gcs.c                            | 156 ++++++++
 target/arm/cpu.c                                   |  20 +-
 target/arm/gdbstub64.c                             |   2 +
 target/arm/helper.c                                | 391 +++++++++++++++---
 target/arm/machine.c                               | 113 +++++-
 target/arm/mmuidx.c                                |  66 ++++
 target/arm/ptw.c                                   | 365 +++++++++++++----
 target/arm/tcg-stubs.c                             |   2 +-
 target/arm/tcg/cpu64.c                             |   4 +
 target/arm/tcg/helper-a64.c                        |  35 +-
 target/arm/tcg/hflags.c                            |  38 ++
 target/arm/tcg/mte_helper.c                        |   2 +-
 target/arm/tcg/op_helper.c                         |  11 +-
 target/arm/tcg/tlb-insns.c                         |  47 ++-
 target/arm/tcg/tlb_helper.c                        |  18 +-
 target/arm/tcg/translate-a64.c                     | 438 +++++++++++++++++++--
 target/arm/tcg/translate.c                         |  78 +++-
 tests/tcg/aarch64/gcspushm.c                       |  71 ++++
 tests/tcg/aarch64/gcsss.c                          |  74 ++++
 tests/tcg/aarch64/gcsstr.c                         |  48 +++
 target/arm/meson.build                             |   9 +-
 .../functional/aarch64/test_device_passthrough.py  |   4 +-
 tests/functional/aarch64/test_rme_sbsaref.py       |   4 +-
 tests/functional/aarch64/test_rme_virt.py          |   4 +-
 tests/tcg/aarch64/Makefile.target                  |   5 +
 48 files changed, 2810 insertions(+), 610 deletions(-)
 create mode 100644 linux-user/aarch64/gcs-internal.h
 create mode 100644 target/arm/mmuidx-internal.h
 create mode 100644 target/arm/mmuidx.h
 create mode 100644 tests/tcg/aarch64/gcs.h
 create mode 100644 target/arm/cpregs-gcs.c
 create mode 100644 target/arm/mmuidx.c
 create mode 100644 tests/tcg/aarch64/gcspushm.c
 create mode 100644 tests/tcg/aarch64/gcsss.c
 create mode 100644 tests/tcg/aarch64/gcsstr.c

