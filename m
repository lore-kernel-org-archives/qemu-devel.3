Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD7FC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCN-0007LZ-TA; Tue, 18 Aug 2026 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCM-0007Ko-Kn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCK-0004c7-MD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso242403b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072519; x=1787677319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=038OwxhUeVHFyOB+JyyRloviESPkcrjGWCGDxg/DQ/E=;
 b=uuHrYp7GB9nsWd1PtJ9gCIS1T6PyzMJPcFuvemBrmXhKkT0PK1UIdVCTl81JD3kWTE
 4UPbtR8SqGcPX1a7TzKoPMsNiOsrntteMJgg3w7dbAOSZtKV8vYb6Q40mHowX95QAWGB
 vIzqsUkaZXQE1dc0/fE3hgdVo9Nc4LNaLaZUWlUx9NMh1+2NPoV810uutvyN/aFRhwBt
 +RRAm7DNcKQH3JPiDBJqhAy5M7opS0RFBXiYFAyaD99UlEyjwvXbIxTdiU2Vw3NvDPB/
 +SL8ZoRSkfc3XXY5KwHwt8FGPAXTmElnZW7eDJPX+Y64HDZfXnQGFmbNdVCvIPCv5XGS
 SIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072519; x=1787677319;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=038OwxhUeVHFyOB+JyyRloviESPkcrjGWCGDxg/DQ/E=;
 b=X8UqSpS/ydvXkwQkim6rYtk1V/SCzJ/3MUm+FEtigCpqflclfPCnb3GrN9eFMo4a5P
 hdW/8NPPQVLKniI25sEFsMjIMLEn/y8S934/lFYsjKCsGub/cq+SRrodyIcaafeOaOTA
 sCRp4+VtmvzpO0lRwQ1h/0InI6BmTJ8sShlimPPGQVVZzV/RD4pqKcCpg62jy47JkrdL
 LFQDC5avEJ0ROI9Vzoi0tX1oCVo/LKBNTO+1BMur4rl2vBMzVoOiqUN4n77O5mlo1H+g
 vu89sIpM1bSrmDRIhex3N5BKg2TnqBwQOy8xR9LmkLEoxjIDN1pXJbkfG9OgqP8nN3Ro
 eYlA==
X-Gm-Message-State: AOJu0YzTh01Y5FvUiJxKHE+HKfgcxvW98PNoHBjV61v75ia2PRX8M2c0
 /vWIwjGr0QT8kqFnIC4RE8uPpdgoZA5UMy0mvX0T2G4U4Fjye0GONuIaQQlKFWcj1fl02YKJFyU
 OoEaA660=
X-Gm-Gg: AR+sD12iEurCnnEsfWIRjKj1By3pRNgMIG9BamxioAwTQfPONYjsCfj+X1H3k/W4H4v
 CzwZiGFZyLwBZpkaBATbPjRqyN3hluxcmP3odTxBUKDSw7Ar8L/8vx6W364P2wYYZbZPxNtwvJD
 /odBDKnxr2/IU0dNASstILx0Uacb0ar7+HAa6HxC8Kkekb8kZGKnHLfgq65NTYOmAm6/Rmm/bBn
 c/TaITVBx/zLuFSzn+mkrmYXhiwkZg472/QFaLkVUbDATm1ehly7hTmhRNje5A+bV0pFKy3zgRJ
 mf6vG14h9Yx+eyNwLj/7FEcCW1q5OJORiPKva0LyYJDwaDOn3BrSFD3QN0FgyMq8Ekf5rIIowwe
 1G6zvSmXQRGanbUBxmoIKI6t83X0akTVnKr5g4coDRqWoZ0LBpLiToTnybk3wo32Iy+RvIOaFgl
 HgzAP30AaiciuL6ZHzrSds1arPEQh9XMCAGepwTQzMJ03pZVZsCuwW+tEqBcZCikm9qh45iQSf3
 VjNL5gpP8gmoYhF9gAT51mtHtyJmxzTb1s=
X-Received: by 2002:a05:6a00:2392:b0:848:56d4:3288 with SMTP id
 d2e1a72fcca58-84fddf92abamr36901686b3a.4.1787072518600; 
 Tue, 18 Aug 2026 10:01:58 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.01.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] tcg patch queue
Date: Tue, 18 Aug 2026 10:01:17 -0700
Message-ID: <20260818170155.1907006-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


The following changes since commit fa19879df1658f96ac07365fca8835b7decd6995:

  Merge tag 'pull-block-jobs-2026-08-17' of https://gitlab.com/vsementsov/qemu into staging (2026-08-17 15:37:53 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260818

for you to fetch changes up to ff90861d1c4a1eda23d83cdb18c3647f2e2b0128:

  target/mips: Enable disassembly via capstone (2026-08-18 09:06:53 -0700)

----------------------------------------------------------------
accel/tcg: Allow overlapping reads in record_save
tcg/optimize: INDEX_op_mul is commutative
tcg/optimize: Fix s_mask computation for shifts
tcg: Defer tb_flush when initial thread region alloc fails
tcg: Add revbit{8,32,64} opcodes
tcg: Add integer min/max opcodes
disas: Updates for capstone v6

----------------------------------------------------------------
Ilya Chichkov (1):
      accel/tcg: Allow overlapping reads in record_save

Richard Henderson (37):
      tcg/optimize: INDEX_op_mul is commutative
      tcg/optimize: Fix s_mask computation for shifts
      tcg: Return success from tcg_region_alloc__locked
      tcg: Return success from tcg_region_alloc
      tcg: Defer tb_flush when initial thread region alloc fails
      tcg: Fix opcode dump for bswap
      tcg: Add tcg_gen_revbit{8,32,64}
      tcg: Simplify bswap/hswap expansion using bitswap
      target/arm: Use generic tcg_gen_revbit*
      target/loongarch: Use generic tcg_gen_revbit*
      target/mips: Expand octeon reflections inline
      target/riscv: Use generic tcg_gen_revbit8
      tcg: Add revbit{8,32,64} opcodes
      tcg/optimize: Handle revbit{8,32,64}
      tcg/aarch64: Implement revbit{32,64}
      tcg/loongarch64: Import REVBIT insns
      tcg/loongarch64: Implement revbit{8,32,64}
      util/cpuinfo-riscv: Detect Zbkb
      tcg/riscv64: Implement revbit8
      tests/tcg/loongarch64: Tidy test_bit.c
      tests/tcg/loongarch64: Add bitrev smoke tests
      tcg: Add integer min/max opcodes
      tcg/optimize: Handle min/max opcodes
      util/cpuinfo-aarch64: Detect FEAT_CSSC
      tcg/aarch64: Implement min/max with FEAT_CSSC
      target/riscv64: Implement min/max with Zbb
      tcg/aarch64: Implement ctpop with FEAT_CSSC
      tcg/aarch64: Use CTZ from FEAT_CSSC
      target/riscv: Improve riscv_has_ext
      disas/capstone: Allow for cap_insn_unit > length
      target/riscv: Enable disassembly via capstone
      target/sh4: Enable disassembly via capstone
      target/tricore: Enable disassembly via capstone
      target/loongarch: Enable disassembly via capstone
      target/s390x: Update capstone disassembly to v6
      target/m68k: Enable disassembly via capstone
      target/mips: Enable disassembly via capstone

 host/include/aarch64/host/cpuinfo.h             |   1 +
 host/include/riscv64/host/cpuinfo.h             |   1 +
 include/disas/capstone.h                        | 115 ++-
 include/tcg/tcg-op-common.h                     |   5 +
 include/tcg/tcg-op.h                            |   7 +
 include/tcg/tcg-opc.h                           |   7 +
 target/arm/tcg/helper-a64-defs.h                |   1 -
 target/arm/tcg/helper-defs.h                    |   1 -
 target/loongarch/tcg/helper.h                   |   4 -
 target/mips/helper.h                            |   7 -
 target/riscv/cpu.h                              |   2 +-
 target/riscv/helper.h                           |   1 -
 tcg/aarch64/tcg-target-con-set.h                |   2 +
 tcg/aarch64/tcg-target-con-str.h                |   2 +
 tcg/tcg-internal.h                              |   2 +-
 accel/tcg/translator.c                          |  14 +-
 disas/capstone.c                                |  29 +-
 target/arm/tcg/helper-a64.c                     |   5 -
 target/arm/tcg/op_helper.c                      |   5 -
 target/arm/tcg/translate-a64.c                  |   4 +-
 target/arm/tcg/translate.c                      |   2 +-
 target/loongarch/cpu.c                          |   8 +
 target/loongarch/tcg/op_helper.c                |  21 -
 target/m68k/cpu.c                               |  65 +-
 target/mips/cpu.c                               |  60 +-
 target/mips/tcg/octeon_crypto.c                 |  35 -
 target/mips/tcg/octeon_translate.c              |  49 +-
 target/riscv/cpu.c                              |  81 +-
 target/riscv/tcg/bitmanip_helper.c              |  15 -
 target/s390x/cpu.c                              |   4 +-
 target/sh4/cpu.c                                |  14 +
 target/tricore/cpu.c                            |  31 +
 tcg/optimize.c                                  | 142 +++-
 tcg/region.c                                    |  40 +-
 tcg/tcg-op.c                                    | 234 ++++--
 tcg/tcg.c                                       |  41 +-
 tests/tcg/i386/test-i386-opt-shr.c              |  21 +
 tests/tcg/loongarch64/test_bit.c                |  77 +-
 util/cpuinfo-aarch64.c                          |   2 +
 util/cpuinfo-riscv.c                            |  17 +-
 docs/devel/tcg-ops.rst                          |  28 +
 target/loongarch/tcg/insn_trans/trans_bit.c.inc |  13 +-
 target/riscv/tcg/insn_trans/trans_rvb.c.inc     |   2 +-
 tcg/aarch64/tcg-target.c.inc                    | 197 ++++-
 tcg/loongarch64/tcg-insn-defs.c.inc             | 960 +++++++++++++-----------
 tcg/loongarch64/tcg-target.c.inc                |  56 ++
 tcg/ppc64/tcg-target.c.inc                      |  28 +
 tcg/riscv64/tcg-target.c.inc                    |  79 ++
 tcg/s390x/tcg-target.c.inc                      |  28 +
 tcg/sparc64/tcg-target.c.inc                    |  28 +
 tcg/tci/tcg-target.c.inc                        |  28 +
 tcg/x86_64/tcg-target.c.inc                     |  28 +
 52 files changed, 1869 insertions(+), 780 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-opt-shr.c

