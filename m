Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DF8C369C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4luP-0008OT-MU; Tue, 15 Apr 2025 15:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luL-0008M1-4e
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:21 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luI-0007uo-MV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:20 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4700376b3a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745117; x=1745349917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0CwB13g3FyhnJrnpLtFn5BhViH8plHyq9I+lH3fLP8=;
 b=f0umaaJQm3vWaA2CzvXOrhyD9U4vDwXq3GZ79rTuN3r0//h1FZIVQn+tspi15eqWii
 nHp/phlvpBOnPxElwYOe45jb6QB9D3S+0AxbP6dgWBa+RHMlCV5/HW6UZFaGSbKoXi4t
 qKLqqpTXiJipV+3Dj0Q9ZJAUljLYiFGAaenhLNX5hWJuO5zmGmm31BRCECfbiyAS/2Bu
 VkPfFQymR3qG8pPV8kzy09lzhdzDMQhTiZhYUVmen8rDevltadnYpXw+D3nsndZn2jor
 QmKTdd7yqpl/ISM2p0SMOzq1XNRzx4aUVQCbQTf2emVaLzsD25sLeEHq2JlI7nND2Er+
 2kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745117; x=1745349917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0CwB13g3FyhnJrnpLtFn5BhViH8plHyq9I+lH3fLP8=;
 b=qPASAZ1/OQoto6kC1LhfYBzSp9OULdnEB15P0jHMfevIlkG8KNwULKdjOIUA1zoilE
 rZPq2Y+hYwElOysarDLY3OfPumTIbQknO4wHtLUDw86ntIQv8oHXFAq6YJhAPAD1JDZQ
 KfEBcZzVWR0yOYPax8jCwMWoV2906CIjotpgNyFCp+1Cjh6BtuxT8miLC1EnXybXAYzz
 gJctHmzzDdOKABoxHXg6wY3wNB03PRClQQZGijZ9rFZzImeQMH1wQy0p2zMsSQKQq47R
 hLLd/NXfDQNNtjW1GE357Z/4JsYeewAtGXFrLT+GPVuFWsMuCYKFglpg3w0Km3ik8gYe
 lOew==
X-Gm-Message-State: AOJu0YwgBRYgrBpNzkwMq+QlghuNJ5UraKGs4cxFq9jDnEgI/ueeHgFl
 HLHkM2EfQwFNkKQgbL9Io2FeUq5FjIwt7WFGponxEtvnDo1ZI07s4P6eDQfjubLm8pZnHcnozG6
 U
X-Gm-Gg: ASbGncvJTk6pGMVLNBjPxbQOIDxajxeerr8UOCZeO/UrjsRiNo2PRBnC3D1DQeiNoxN
 AQhWcw8UmT9/z6aS9gNT5T05fHsMGRCxIoOKWiAxfSeFjaotzEcykcrXer9r+JRU92ECy7LAssp
 OhGYa0UQukcsMqfQ9SKlIruF+sGRngOoqgeXx4AreSbtOrg273mu5zkvoN1EHTdfYN0haUMrbwV
 pMkd+5AlYjFf6YXX2AxGUJptm/YOKLMLLknfb7UMWl7+01jrC7weFspbxY+xJUymFoI4gGOxLnR
 yhjpWjC4I3sW35EKivrV1m6T04KIZJvHlxo1A20Z5xQHa3UfADR2NDYw7+ukcTcWe1wTyu7nj+K
 rYbP9Urnb3Q==
X-Google-Smtp-Source: AGHT+IGs37zmgPO6Wq7rVqqCjG/XWvaiwhtXMKU2kOJvea5UY+X+OdKwrK14yYS/gBFIRmFIobQCSQ==
X-Received: by 2002:a05:6a00:889:b0:730:9637:b2ff with SMTP id
 d2e1a72fcca58-73c1fb014f3mr819916b3a.7.1744745116466; 
 Tue, 15 Apr 2025 12:25:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 000/163] tcg: Convert to TCGOutOp structures
Date: Tue, 15 Apr 2025 12:22:31 -0700
Message-ID: <20250415192515.232910-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

v2: 20250107080112.1175095-1-richard.henderson@linaro.org
v3: 20250216231012.2808572-1-richard.henderson@linaro.org

Since it has been 2 months, I don't recall specific changes from v3 to v4.
It's mostly application of r-b tags.  There is one more patch, which I
believe was Phil asking for one patch to be split.

Patches still requiring review: 29, 41-43, 46, 47, 49-51, 55, 57, 59-62,
  64, 66-68, 70, 72-78, 80, 82-87, 89, 91, 93, 95, 97-102, 104, 106-162.


r~


Richard Henderson (163):
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
  tcg/i386: Remove support for add2/sub2
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
  tcg/aarch64: Remove support for add2/sub2
  tcg/arm: Implement add/sub carry opcodes
  tcg/arm: Remove support for add2/sub2
  tcg/ppc: Implement add/sub carry opcodes
  tcg/ppc: Remove support for add2/sub2
  tcg/s390x: Honor carry_live in tcg_out_movi
  tcg/s390: Add TCG_CT_CONST_N32
  tcg/s390x: Implement add/sub carry opcodes
  tcg/s390x: Use ADD LOGICAL WITH SIGNED IMMEDIATE
  tcg/s390x: Remove support for add2/sub2
  tcg/sparc64: Hoist tcg_cond_to_bcond lookup out of tcg_out_movcc
  tcg/sparc64: Implement add/sub carry opcodes
  tcg/sparc64: Remove support for add2/sub2
  tcg/tci: Implement add/sub carry opcodes
  tcg/tci: Remove support for add2/sub2
  tcg: Remove add2/sub2 opcodes
  tcg: Formalize tcg_out_mb
  tcg: Formalize tcg_out_br
  tcg: Formalize tcg_out_goto_ptr
  tcg: Assign TCGOP_TYPE in liveness_pass_2
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
 include/tcg/tcg-opc.h                |  212 +--
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
 tcg/loongarch64/tcg-target-has.h     |   60 -
 tcg/mips/tcg-target-con-set.h        |   15 +-
 tcg/mips/tcg-target-con-str.h        |    1 -
 tcg/mips/tcg-target-has.h            |   64 -
 tcg/ppc/tcg-target-con-set.h         |   12 +-
 tcg/ppc/tcg-target-con-str.h         |    1 +
 tcg/ppc/tcg-target-has.h             |   59 -
 tcg/riscv/tcg-target-con-set.h       |    7 +-
 tcg/riscv/tcg-target-con-str.h       |    2 -
 tcg/riscv/tcg-target-has.h           |   61 -
 tcg/s390x/tcg-target-con-set.h       |    7 +-
 tcg/s390x/tcg-target-con-str.h       |    1 +
 tcg/s390x/tcg-target-has.h           |   57 -
 tcg/sparc64/tcg-target-con-set.h     |    9 +-
 tcg/sparc64/tcg-target-has.h         |   59 -
 tcg/tcg-has.h                        |   47 -
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
 tcg/optimize.c                       | 1066 ++++++++------
 tcg/tcg-op-ldst.c                    |   74 +-
 tcg/tcg-op.c                         | 1242 ++++++++--------
 tcg/tcg.c                            | 1303 ++++++++++++-----
 tcg/tci.c                            |  766 ++++------
 docs/devel/tcg-ops.rst               |  220 ++-
 target/i386/tcg/emit.c.inc           |   12 +-
 tcg/aarch64/tcg-target.c.inc         | 1626 ++++++++++++---------
 tcg/arm/tcg-target.c.inc             | 1556 ++++++++++++--------
 tcg/i386/tcg-target.c.inc            | 1850 ++++++++++++++----------
 tcg/loongarch64/tcg-target.c.inc     | 1425 +++++++++++--------
 tcg/mips/tcg-target.c.inc            | 1703 ++++++++++++----------
 tcg/ppc/tcg-target.c.inc             | 1978 ++++++++++++++------------
 tcg/riscv/tcg-target.c.inc           | 1375 +++++++++---------
 tcg/s390x/tcg-target.c.inc           | 1945 +++++++++++++------------
 tcg/sparc64/tcg-target.c.inc         | 1295 +++++++++++------
 tcg/tci/tcg-target-opc.h.inc         |   11 +
 tcg/tci/tcg-target.c.inc             | 1175 +++++++++------
 59 files changed, 12100 insertions(+), 9570 deletions(-)

-- 
2.43.0

