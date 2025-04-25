Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA1C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R0g-0007DL-GV; Fri, 25 Apr 2025 17:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0e-0007Ca-CU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:00 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0b-0000I2-PU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:00 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2505549b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618095; x=1746222895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=41RP72iINcoaFtzLeoBo0s8QKFEIVkJzXPipULbk1BQ=;
 b=i/xDLji6Q/kzTlArxo6n1Az5ohNW0O4hTmuPj+SQbrAX5+okHpb43e5ZcbEEiWmgLO
 Xfrs0rGMepVCficIi2wPXQFBFIL72PB6I7fdH2BgdKOjYIZe0JZLLsM/6RIQsTkhY64k
 8YUdwuFxk5A10xfou4yFmI51lACTOC8FraVTeies9Qw2pG6Ts8PCAADpjewpKvfOmWJa
 LU8eIaGWAswBRL7Xk/9F9XkhOK3ZT2SR1Lhn3f8ZbTfPG9yGSXXAMgTK8gZng79XAYqt
 geN6kWQt9L6e1vThJ1lSAyGaEKRUWlT9LAxNSvKGV0P/cTtHCKmEHxMXFHAmeGvwfWnW
 dsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618095; x=1746222895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=41RP72iINcoaFtzLeoBo0s8QKFEIVkJzXPipULbk1BQ=;
 b=PvddQXyuogCyqO7oJSvoNa7MwQLtbWRSB4NPPPRxl8u33qPVUDnAT+9KbXqZ8geqkq
 VQYU11VnRyrn7Z1ArlJGf3r/8v5kNpbPSIqkVxvYvi8LIx8FnHVvI8l0njVTo9eHrckt
 6zGc5gr4oMSqcYDvYrik1zhOFetrVxlaDAG+F34CpznrSJ8+67XyXCWiisVQ7KqHwS18
 /z555pVP40q3DwC/HTqqep5VqByS21Ihu5+aMW2huZKyrgBM7i4NaHB0XN0jDAsgXqFz
 QAm0Gie+PTXWvBdB3F0gfxIdQXkiykhxqdiSMUE1jt96YCC00A1LyY1OaGDkH8pAFH0Y
 eZmg==
X-Gm-Message-State: AOJu0YzRT0xGBFrGepwts0eMmJo7t+z5UxBfYAFbnSa0dZCV4zBcFSzn
 z/F+BRv95liQSVnIs2QH0lbf3ZOf5gpBofs03wYq2BdzzuIwOyd3IMYzUMQkbZ9UdQhUwD4uqM3
 D
X-Gm-Gg: ASbGncuEubjLVLEh+xehB5A14T1UpAXJxtczjg2dYcj9/neCxIeF7++Fw6pGapUGtqm
 2ovjMixBSeQT4SU8u4bgt87TPHswmPP+LAsxfmTCfjyKmnIniEJy1k8hgPi33OXudQ795Gg3Ix2
 LSSn8SN8gKVgQAmcAHORD6b9rVyGH3HkFRrT74r7I4kWIMb3AFwJvJ9WDhZvGWjQi4CSj1gRJDq
 k7EBUbabLZTSzZqcSh2E+MDplB72+L08bYCEZ0VrFLJpDA5HpBTS3yXBwufA3v0UVveIlJEmNyr
 SNIyH7n8A96DSePfj3Z9nZuIojPu5y5BQ7qMBlC5fDwS+GRrlK3skErQ3jlhto3Nq/Mn/3tgpDI
 =
X-Google-Smtp-Source: AGHT+IGDhdS2W5BmI/labBLX1wcTu6R2E+q6G27uLjUM2D0gzlv2RoWAgKctY+zyQVusfupHsVyKEQ==
X-Received: by 2002:a05:6a00:b4a:b0:73e:10ea:b1e9 with SMTP id
 d2e1a72fcca58-73fd6defd3emr4800005b3a.6.1745618094995; 
 Fri, 25 Apr 2025 14:54:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.54.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:54:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 000/159] tcg patch queue
Date: Fri, 25 Apr 2025 14:52:14 -0700
Message-ID: <20250425215454.886111-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The following changes since commit 019fbfa4bcd2d3a835c241295e22ab2b5b56129b:

  Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging (2025-04-24 13:44:57 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250425

for you to fetch changes up to 8038bbe0339fac90fa88970bf635cc9036cf6be9:

  tcg: Remove tcg_out_op (2025-04-25 13:18:24 -0700)

----------------------------------------------------------------
Convert TCG backend code generators to TCGOutOp structures,
decomposing the monolithic tcg_out_op functions.

----------------------------------------------------------------
Richard Henderson (159):
      tcg/loongarch64: Fix vec_val computation in tcg_target_const_match
      tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP
      tcg/optimize: Introduce opt_insert_{before,after}
      tcg: Add TCGType to tcg_op_insert_{after,before}
      tcg: Add all_outop[]
      tcg: Use extract2 for cross-word 64-bit extract on 32-bit host
      tcg: Remove INDEX_op_ext{8,16,32}*
      tcg: Merge INDEX_op_mov_{i32,i64}
      tcg: Convert add to TCGOutOpBinary
      tcg: Merge INDEX_op_add_{i32,i64}
      tcg: Convert and to TCGOutOpBinary
      tcg: Merge INDEX_op_and_{i32,i64}
      tcg/optimize: Fold andc with immediate to and
      tcg/optimize: Emit add r,r,-1 in fold_setcond_tst_pow2
      tcg: Convert andc to TCGOutOpBinary
      tcg: Merge INDEX_op_andc_{i32,i64}
      tcg: Convert or to TCGOutOpBinary
      tcg: Merge INDEX_op_or_{i32,i64}
      tcg/optimize: Fold orc with immediate to or
      tcg: Convert orc to TCGOutOpBinary
      tcg: Merge INDEX_op_orc_{i32,i64}
      tcg: Convert xor to TCGOutOpBinary
      tcg: Merge INDEX_op_xor_{i32,i64}
      tcg/optimize: Fold eqv with immediate to xor
      tcg: Convert eqv to TCGOutOpBinary
      tcg: Merge INDEX_op_eqv_{i32,i64}
      tcg: Convert nand to TCGOutOpBinary
      tcg: Merge INDEX_op_nand_{i32,i64}
      tcg/loongarch64: Do not accept constant argument to nor
      tcg: Convert nor to TCGOutOpBinary
      tcg: Merge INDEX_op_nor_{i32,i64}
      tcg/arm: Fix constraints for sub
      tcg: Convert sub to TCGOutOpSubtract
      tcg: Merge INDEX_op_sub_{i32,i64}
      tcg: Convert neg to TCGOutOpUnary
      tcg: Merge INDEX_op_neg_{i32,i64}
      tcg: Convert not to TCGOutOpUnary
      tcg: Merge INDEX_op_not_{i32,i64}
      tcg: Convert mul to TCGOutOpBinary
      tcg: Merge INDEX_op_mul_{i32,i64}
      tcg: Convert muluh to TCGOutOpBinary
      tcg: Merge INDEX_op_muluh_{i32,i64}
      tcg: Convert mulsh to TCGOutOpBinary
      tcg: Merge INDEX_op_mulsh_{i32,i64}
      tcg: Convert div to TCGOutOpBinary
      tcg: Merge INDEX_op_div_{i32,i64}
      tcg: Convert divu to TCGOutOpBinary
      tcg: Merge INDEX_op_divu_{i32,i64}
      tcg: Convert div2 to TCGOutOpDivRem
      tcg: Merge INDEX_op_div2_{i32,i64}
      tcg: Convert divu2 to TCGOutOpDivRem
      tcg: Merge INDEX_op_divu2_{i32,i64}
      tcg: Convert rem to TCGOutOpBinary
      tcg: Merge INDEX_op_rem_{i32,i64}
      tcg: Convert remu to TCGOutOpBinary
      tcg: Merge INDEX_op_remu_{i32,i64}
      tcg: Convert shl to TCGOutOpBinary
      tcg: Merge INDEX_op_shl_{i32,i64}
      tcg: Convert shr to TCGOutOpBinary
      tcg: Merge INDEX_op_shr_{i32,i64}
      tcg: Convert sar to TCGOutOpBinary
      tcg: Merge INDEX_op_sar_{i32,i64}
      tcg: Do not require both rotr and rotl from the backend
      tcg: Convert rotl, rotr to TCGOutOpBinary
      tcg: Merge INDEX_op_rot{l,r}_{i32,i64}
      tcg: Convert clz to TCGOutOpBinary
      tcg: Merge INDEX_op_clz_{i32,i64}
      tcg: Convert ctz to TCGOutOpBinary
      tcg: Merge INDEX_op_ctz_{i32,i64}
      tcg: Convert ctpop to TCGOutOpUnary
      tcg: Merge INDEX_op_ctpop_{i32,i64}
      tcg: Convert muls2 to TCGOutOpMul2
      tcg: Merge INDEX_op_muls2_{i32,i64}
      tcg: Convert mulu2 to TCGOutOpMul2
      tcg: Merge INDEX_op_mulu2_{i32,i64}
      tcg/loongarch64: Support negsetcond
      tcg/mips: Support negsetcond
      tcg/tci: Support negsetcond
      tcg: Remove TCG_TARGET_HAS_negsetcond_{i32,i64}
      tcg: Convert setcond, negsetcond to TCGOutOpSetcond
      tcg: Merge INDEX_op_{neg}setcond_{i32,i64}`
      tcg: Convert brcond to TCGOutOpBrcond
      tcg: Merge INDEX_op_brcond_{i32,i64}
      tcg: Convert movcond to TCGOutOpMovcond
      tcg: Merge INDEX_op_movcond_{i32,i64}
      tcg/ppc: Drop fallback constant loading in tcg_out_cmp
      tcg/arm: Expand arguments to tcg_out_cmp2
      tcg/ppc: Expand arguments to tcg_out_cmp2
      tcg: Convert brcond2_i32 to TCGOutOpBrcond2
      tcg: Convert setcond2_i32 to TCGOutOpSetcond2
      tcg: Convert bswap16 to TCGOutOpBswap
      tcg: Merge INDEX_op_bswap16_{i32,i64}
      tcg: Convert bswap32 to TCGOutOpBswap
      tcg: Merge INDEX_op_bswap32_{i32,i64}
      tcg: Convert bswap64 to TCGOutOpUnary
      tcg: Rename INDEX_op_bswap64_i64 to INDEX_op_bswap64
      tcg: Convert extract to TCGOutOpExtract
      tcg: Merge INDEX_op_extract_{i32,i64}
      tcg: Convert sextract to TCGOutOpExtract
      tcg: Merge INDEX_op_sextract_{i32,i64}
      tcg: Convert ext_i32_i64 to TCGOutOpUnary
      tcg: Convert extu_i32_i64 to TCGOutOpUnary
      tcg: Convert extrl_i64_i32 to TCGOutOpUnary
      tcg: Convert extrh_i64_i32 to TCGOutOpUnary
      tcg: Convert deposit to TCGOutOpDeposit
      tcg/aarch64: Improve deposit
      tcg: Merge INDEX_op_deposit_{i32,i64}
      tcg: Convert extract2 to TCGOutOpExtract2
      tcg: Merge INDEX_op_extract2_{i32,i64}
      tcg: Expand fallback add2 with 32-bit operations
      tcg: Expand fallback sub2 with 32-bit operations
      tcg: Do not default add2/sub2_i32 for 32-bit hosts
      tcg/mips: Drop support for add2/sub2
      tcg/riscv: Drop support for add2/sub2
      tcg: Move i into each for loop in liveness_pass_1
      tcg: Sink def, nb_iargs, nb_oargs loads in liveness_pass_1
      tcg: Add add/sub with carry opcodes and infrastructure
      tcg: Add TCGOutOp structures for add/sub carry opcodes
      tcg/optimize: Handle add/sub with carry opcodes
      tcg/optimize: With two const operands, prefer 0 in arg1
      tcg: Use add carry opcodes to expand add2
      tcg: Use sub carry opcodes to expand sub2
      tcg/i386: Honor carry_live in tcg_out_movi
      tcg/i386: Implement add/sub carry opcodes
      tcg/i386: Special case addci r, 0, 0
      tcg: Add tcg_gen_addcio_{i32,i64,tl}
      target/arm: Use tcg_gen_addcio_* for ADCS
      target/hppa: Use tcg_gen_addcio_i64
      target/microblaze: Use tcg_gen_addcio_i32
      target/openrisc: Use tcg_gen_addcio_* for ADDC
      target/ppc: Use tcg_gen_addcio_tl for ADD and SUBF
      target/s390x: Use tcg_gen_addcio_i64 for op_addc64
      target/sh4: Use tcg_gen_addcio_i32 for addc
      target/sparc: Use tcg_gen_addcio_tl for gen_op_addcc_int
      target/tricore: Use tcg_gen_addcio_i32 for gen_addc_CC
      tcg/aarch64: Implement add/sub carry opcodes
      tcg/arm: Implement add/sub carry opcodes
      tcg/ppc: Implement add/sub carry opcodes
      tcg/s390x: Honor carry_live in tcg_out_movi
      tcg/s390x: Add TCG_CT_CONST_N32
      tcg/s390x: Implement add/sub carry opcodes
      tcg/s390x: Use ADD LOGICAL WITH SIGNED IMMEDIATE
      tcg/sparc64: Hoist tcg_cond_to_bcond lookup out of tcg_out_movcc
      tcg/sparc64: Implement add/sub carry opcodes
      tcg/tci: Implement add/sub carry opcodes
      tcg: Remove add2/sub2 opcodes
      tcg: Formalize tcg_out_mb
      tcg: Formalize tcg_out_br
      tcg: Formalize tcg_out_goto_ptr
      tcg: Convert ld to TCGOutOpLoad
      tcg: Merge INDEX_op_ld*_{i32,i64}
      tcg: Convert st to TCGOutOpStore
      tcg: Merge INDEX_op_st*_{i32,i64}
      tcg: Stash MemOp size in TCGOP_FLAGS
      tcg: Remove INDEX_op_qemu_st8_*
      tcg: Merge INDEX_op_{ld,st}_{i32,i64,i128}
      tcg: Convert qemu_ld{2} to TCGOutOpLoad{2}
      tcg: Convert qemu_st{2} to TCGOutOpLdSt{2}
      tcg: Remove tcg_out_op

 include/tcg/tcg-op-common.h          |    4 +
 include/tcg/tcg-op.h                 |    2 +
 include/tcg/tcg-opc.h                |  212 ++--
 include/tcg/tcg.h                    |   15 +-
 tcg/aarch64/tcg-target-con-set.h     |    5 +-
 tcg/aarch64/tcg-target-has.h         |   57 -
 tcg/arm/tcg-target-con-set.h         |    5 +-
 tcg/arm/tcg-target-has.h             |   27 -
 tcg/i386/tcg-target-con-set.h        |    4 +-
 tcg/i386/tcg-target-con-str.h        |    2 +-
 tcg/i386/tcg-target-has.h            |   57 -
 tcg/loongarch64/tcg-target-con-set.h |    9 +-
 tcg/loongarch64/tcg-target-con-str.h |    1 -
 tcg/loongarch64/tcg-target-has.h     |   60 --
 tcg/mips/tcg-target-con-set.h        |   15 +-
 tcg/mips/tcg-target-con-str.h        |    1 -
 tcg/mips/tcg-target-has.h            |   64 --
 tcg/ppc/tcg-target-con-set.h         |   12 +-
 tcg/ppc/tcg-target-con-str.h         |    1 +
 tcg/ppc/tcg-target-has.h             |   59 -
 tcg/riscv/tcg-target-con-set.h       |    7 +-
 tcg/riscv/tcg-target-con-str.h       |    2 -
 tcg/riscv/tcg-target-has.h           |   61 --
 tcg/s390x/tcg-target-con-set.h       |    7 +-
 tcg/s390x/tcg-target-con-str.h       |    1 +
 tcg/s390x/tcg-target-has.h           |   57 -
 tcg/sparc64/tcg-target-con-set.h     |    9 +-
 tcg/sparc64/tcg-target-has.h         |   59 -
 tcg/tcg-has.h                        |   47 -
 tcg/tcg-internal.h                   |    4 +-
 tcg/tci/tcg-target-has.h             |   59 -
 target/arm/tcg/translate-a64.c       |   10 +-
 target/arm/tcg/translate-sve.c       |    2 +-
 target/arm/tcg/translate.c           |   17 +-
 target/hppa/translate.c              |   17 +-
 target/microblaze/translate.c        |   10 +-
 target/openrisc/translate.c          |    3 +-
 target/ppc/translate.c               |   11 +-
 target/s390x/tcg/translate.c         |    6 +-
 target/sh4/translate.c               |   36 +-
 target/sparc/translate.c             |    3 +-
 target/tricore/translate.c           |   12 +-
 tcg/optimize.c                       | 1080 +++++++++++--------
 tcg/tcg-op-ldst.c                    |   74 +-
 tcg/tcg-op.c                         | 1242 ++++++++++-----------
 tcg/tcg.c                            | 1313 +++++++++++++++-------
 tcg/tci.c                            |  766 +++++--------
 docs/devel/tcg-ops.rst               |  228 ++--
 target/i386/tcg/emit.c.inc           |   12 +-
 tcg/aarch64/tcg-target.c.inc         | 1626 ++++++++++++++++------------
 tcg/arm/tcg-target.c.inc             | 1556 ++++++++++++++++----------
 tcg/i386/tcg-target.c.inc            | 1850 ++++++++++++++++++-------------
 tcg/loongarch64/tcg-target.c.inc     | 1473 ++++++++++++++-----------
 tcg/mips/tcg-target.c.inc            | 1703 ++++++++++++++++-------------
 tcg/ppc/tcg-target.c.inc             | 1978 +++++++++++++++++++---------------
 tcg/riscv/tcg-target.c.inc           | 1375 ++++++++++++-----------
 tcg/s390x/tcg-target.c.inc           | 1945 ++++++++++++++++++---------------
 tcg/sparc64/tcg-target.c.inc         | 1306 ++++++++++++++--------
 tcg/tci/tcg-target-opc.h.inc         |   11 +
 tcg/tci/tcg-target.c.inc             | 1175 +++++++++++++-------
 60 files changed, 12156 insertions(+), 9609 deletions(-)

