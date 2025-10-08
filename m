Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3BCCCD187
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9O-0003wS-5a; Wed, 08 Oct 2025 17:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9M-0003vG-6Y
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:44 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c90-0006cJ-TC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:41 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so282983a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960575; x=1760565375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SfcXr5UWt0SadCwReY9na2q03gghzKTQ+9WscMeEZpg=;
 b=CgGOnqL4cFJtDNn/yhFWzSXZpOUmGn8XqmYhhQSbiUoBkd0PcpaF5OkxkmofdSCitq
 ZPU9Cf47W9s5eZHOdvMyEcZhV6p0baEZNYknAVGOdcRohwJ9wAnYo1p9TrsBy1ro9tIh
 SsR0bugZZRI1iVA7qdpTR/w8b7t0mVRBWTJcxUNJh4l8TUJmkzS6TeRFVJ1Do267yL2E
 FYEQUHrzxDy2s2pQaWjS8KbH52/cmX+3Gnm7rA2+fOd4j6oWr5K/yUBtykNdjhntT8hK
 GmqQay3aEfo1bx8rVL+aixyX9XSpPxmsANJ1ZovmJRkorNNZ6XOq5nvu70Y5/E96EIOG
 +FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960575; x=1760565375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfcXr5UWt0SadCwReY9na2q03gghzKTQ+9WscMeEZpg=;
 b=xFg/BBIJTHZ4gVkcRUXPRQuKobUUShQzm2gUWf6kdeCkBaW4YYdbsFEOUds+WU7iuN
 bCvD37QHrBjaXfj9Rbjr0P6w13jNT2vcbwapWwBc2On+f/+6TnUhINUwmSaPs+FxloPn
 tnoQcBd/qqcpE3oqAVPZE8bgYW+yUigdm94mX1tzQLqSlBw+oe7doaZdLOiDZ6bktlaR
 V6IkfoA2TEqRUDn4O6teGFytxpoyfEjIctu/OXzIpCkFFzZoUVsU6Kq4ZAXDVD3yaM79
 t5J/1RicrXFGnX6kV4rI16zA77tVlVjwMjW9do731l3PRiTLzDdop6bzq/DcO3Fa3YDK
 tFeQ==
X-Gm-Message-State: AOJu0YyBdvoWCjNyEi6pfyyYBnxxBIzQpPgg2jS1fvn+8UKoae2tqhqq
 l+dkQOzZjwuL1eBlgTX4FUASGh4yJAE9ViyUHHxxevDmOjdox5O2oP5QYaS0KdztocLbpmz0L2O
 xbmtRsTQ=
X-Gm-Gg: ASbGncsPFBCOo1hZ3u5IIGHaB9dBGWAXfEeSFsDZQIWHSXtgk27v1NYCK2MnFuUJHrd
 4SBjtv7DBVxUXXXJf0po2iMsVDsfcs+BhGltEUIqCVFvZadX+O5tlLywa2Cf+BSEk3mdP25/d1e
 b58aFoy/JCd3PxlAqr1OhYXRneDWmqQ1ja4sNFq+FEd/HKsLFovNNrmqwYeZ/Ynhkp+XI0IIOFP
 lm0tfJDhL+1cDpr3LZz+gkTdWlVUGg6nFJS+VmI9cPB6BQGi9KcP+m8JiIp+UIxJZlIAvj6c+ZP
 /u96jTf4DXhMdtXpCKcPlj6rt/s/os7icECSkxokLPb3cOrCWY9LfukKqM4Isb1zMaeXFFwPRMw
 BIQ3wEyttXRUkcx92uzcB0DkXgCeY/OKi/JjJpXPYD7RPDjUKe2mvcUV6
X-Google-Smtp-Source: AGHT+IEqOkBusYa9vJQSgd/uQIFbwD/J8wfgj4ZSJ5Ris2RDH/JQNYgwHEziMaoHBs5XzTo/0Um93w==
X-Received: by 2002:a17:903:3c6e:b0:267:ed5e:c902 with SMTP id
 d9443c01a7336-29027374b4fmr66808035ad.20.1759960574617; 
 Wed, 08 Oct 2025 14:56:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 00/73] target/arm: Implement FEAT_GCS
Date: Wed,  8 Oct 2025 14:55:00 -0700
Message-ID: <20251008215613.300150-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Changes from v6:
  - Resolve conflicts with master.
  - Fix size of TCGv cpu_gcssp[]
  - All patches now reviewed.

r~

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
  target/arm: Export cpsr_{read_for,write_from}_spsr_elx
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

 include/exec/memopidx.h                       |   9 +-
 include/hw/core/cpu.h                         |   7 +-
 linux-user/aarch64/gcs-internal.h             |  38 ++
 linux-user/aarch64/target_prctl.h             |  96 ++++
 linux-user/aarch64/target_signal.h            |   1 +
 linux-user/qemu.h                             |   5 +
 target/arm/cpregs.h                           |  22 +
 target/arm/cpu-features.h                     |  15 +
 target/arm/cpu.h                              | 243 ++--------
 target/arm/internals.h                        | 148 +-----
 target/arm/mmuidx-internal.h                  | 113 +++++
 target/arm/mmuidx.h                           | 241 ++++++++++
 target/arm/syndrome.h                         |  35 ++
 target/arm/tcg/helper-a64.h                   |   5 +-
 target/arm/tcg/translate.h                    |  46 +-
 tests/tcg/aarch64/gcs.h                       |  80 ++++
 accel/tcg/cputlb.c                            |   3 -
 linux-user/aarch64/cpu_loop.c                 |   5 +
 linux-user/aarch64/elfload.c                  |   1 +
 linux-user/aarch64/signal.c                   | 138 +++++-
 linux-user/syscall.c                          | 114 +++++
 target/arm/cpregs-gcs.c                       | 156 +++++++
 target/arm/cpu.c                              |  17 +-
 target/arm/gdbstub64.c                        |   2 +
 target/arm/helper.c                           | 283 ++++++++---
 target/arm/machine.c                          | 113 ++++-
 target/arm/mmuidx.c                           |  66 +++
 target/arm/ptw.c                              | 365 ++++++++++++---
 target/arm/tcg-stubs.c                        |   2 +-
 target/arm/tcg/cpu64.c                        |   3 +
 target/arm/tcg/helper-a64.c                   |  35 +-
 target/arm/tcg/hflags.c                       |  38 ++
 target/arm/tcg/mte_helper.c                   |   2 +-
 target/arm/tcg/op_helper.c                    |  11 +-
 target/arm/tcg/tlb-insns.c                    |  47 +-
 target/arm/tcg/tlb_helper.c                   |  18 +-
 target/arm/tcg/translate-a64.c                | 438 ++++++++++++++++--
 target/arm/tcg/translate.c                    |  78 +++-
 tests/tcg/aarch64/gcspushm.c                  |  71 +++
 tests/tcg/aarch64/gcsss.c                     |  74 +++
 tests/tcg/aarch64/gcsstr.c                    |  48 ++
 docs/system/arm/emulation.rst                 |   4 +
 target/arm/meson.build                        |   9 +-
 target/arm/tcg/a64.decode                     |   5 +
 .../aarch64/test_device_passthrough.py        |   4 +-
 tests/functional/aarch64/test_rme_sbsaref.py  |   4 +-
 tests/functional/aarch64/test_rme_virt.py     |   4 +-
 tests/tcg/aarch64/Makefile.target             |   5 +
 48 files changed, 2662 insertions(+), 605 deletions(-)
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


