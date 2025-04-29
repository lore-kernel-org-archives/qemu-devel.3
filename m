Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773ACC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ozU-0006mW-Ba; Tue, 29 Apr 2025 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozQ-0006l0-6C
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9ozL-0006dw-GW
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:43:26 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2279915e06eso72891345ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745948602; x=1746553402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKmNsCWafN+eueAZcq0PRvnK5e4oIEBoCSxAWuOsC78=;
 b=E58K7hADzogE04LkYzU59yh1JxkfWZe0JUWTNx6zV1khpn0bb/W6uFK7IUtsXTKtBb
 l70r2rc8G+lkj9uLfaoM5i4jBiUfHUODRkxm9ze0r0iylpLtpPDnEnZGYEnhf6VpkQeM
 +h+8Xg+Qh6VFwHdLs/x/glE5WodD73HWtxdjIiZC+3BcUqEmApM5OtL85UffwQF3pYid
 70U4kQGaedUcHW/LKs2aX+BAvoQBN9ITD1zvRSH/+ulvuGjvwyMe5Gl7AlpuB4N2aaqm
 TWLoakK5w5qZRsuYjY+kGIfmbqaw2/Se77f6IUUtrZuUO7FJsTKhPgU211lTs8FG4XmZ
 BBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745948602; x=1746553402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DKmNsCWafN+eueAZcq0PRvnK5e4oIEBoCSxAWuOsC78=;
 b=nIznFF1MuheD1PCMa0fWrcXOi582D2/YCz2y49QNeMdc3NJSiCuFaoBGv5RMydO9x9
 HqczFBZokujABZ1RyE49yVtZ6c2zbq44ljhX2eBaX9vAfebsP8Jzj6PtM974OHVdl9pr
 jao0rNQDm0U/uz/kJHTVQXeJbjzpxPL50g5T6Ve6qKF1biYdzjPTXGDr3AcsvWu33+0I
 3FsA8VPdE+PVRh06+y2g67gpi6SVJ8GqSEaRo+7HhE8UPqVMNT0kXu5bh640ECPMuDgq
 BZNU7v0cfHpcVCc2PbfKhT/YTW0j9YOAGPJm1S/gzEqtUQTGcEgD9KZa9Amc2A/u4OU3
 uMGQ==
X-Gm-Message-State: AOJu0YxJG/o0Q4tuJGpbJlXcAv+WY54fGYPT16zV0/YCqQj/U2v6XXw4
 bafvN5TWAMJHQdYG1HtSR+H2280l4WXWaiiU9uclqkXiGdaHDr/Mr+Z+LG2ErGOKXhP1Ebdomzg
 t
X-Gm-Gg: ASbGncuvFFeTVzcncQeqgn9/IbR3tHtwY3UcpH0klxFhk5u1YG2lUn0I/KdOrFPu5F+
 DApHoeyWP1VIL0jzwXmDdmSGfl9AtM2j/ebKx32H6TmoELGQuSS9grtaQbvRrJfddXBIFD9vpNy
 qv+31Of78VF6Vj7/woD8QUFZ7NJJjiWVCpxbA6EAKSI9suHxHEyCAcUfLdZ79AhJNpLQmOnfQqY
 gPnouspf3hCfSSHlk9dekzLrTy9elKY1oEYSi83HNg+91iFH+NwmWVXHe7sIo/pUzMngt291WKt
 Nf5c4uSSJsS8b6meGvNxuJLGn/bRgb38QTiwCW/TRLUjTtO7C9zmxPU3qQbb7fHfoNAzQPTci4s
 =
X-Google-Smtp-Source: AGHT+IEn1YMufTy2O6sna73ZIkctfMfijUqml/iujxYs9tB2u7ea1R4h/SBNpy5N1y9mquPMKrTD5g==
X-Received: by 2002:a17:903:8c6:b0:22d:e458:96a5 with SMTP id
 d9443c01a7336-22df3600748mr3700345ad.38.1745948601160; 
 Tue, 29 Apr 2025 10:43:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4e0c385sm105795955ad.105.2025.04.29.10.43.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 10:43:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 000/161] tcg patch queue
Date: Tue, 29 Apr 2025 10:43:17 -0700
Message-ID: <20250429174320.1841700-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

For v2:
- Fixed a typo in patch 152 ("tcg: Convert st to TCGOutOpStore")
  affecting tcg/aarch64, and was visible as a sha512-vector failure.
- Include two extra tcg/sparc64 patches.


r~


The following changes since commit 73d29ea2417b58ca55fba1aa468ba38e3607b583:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2025-04-27 12:47:23 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250429

for you to fetch changes up to 70ab4f4ed9bbe9bcfdb105681291b4695f151522:

  tcg/sparc64: Implement CTPOP (2025-04-28 13:40:17 -0700)

----------------------------------------------------------------
Convert TCG backend code generators to TCGOutOp structures,
decomposing the monolithic tcg_out_op functions.

----------------------------------------------------------------
Richard Henderson (161):
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
      tcg/sparc64: Unexport use_vis3_instructions
      tcg/sparc64: Implement CTPOP

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
 tcg/sparc64/tcg-target-has.h         |   65 --
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
 tcg/sparc64/tcg-target.c.inc         | 1337 +++++++++++++++--------
 tcg/tci/tcg-target-opc.h.inc         |   11 +
 tcg/tci/tcg-target.c.inc             | 1175 +++++++++++++-------
 60 files changed, 12181 insertions(+), 9621 deletions(-)

