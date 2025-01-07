Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A3E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Wk-0000CQ-Er; Tue, 07 Jan 2025 03:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4We-0000Bb-Gk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:20 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wb-0002sY-W3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:20 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216395e151bso161390315ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236875; x=1736841675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wuo+RJED4gKortGRfj6WXDphAJOqG3auHfUnvOZE2lM=;
 b=qGzRgDFCURgmArVLq1ShFamnpC9ZvUU615H9Cd8H0pctcImSVIdh5L6xK0jx2vSlUk
 qB/CNL5Y0fpAAWL2Dr4CWprlTEAgjquP9TzaLHcN5ziUS9oEGTANbeTHBbKBoA7/Tmxd
 OmPIUxj5y/vHLRPjBJriGBargJRZs9ThhyEfQTFZcNGf22RGI2MkHycfAKWICERwzRdp
 HcGWSnWYgZtTbXAPH6Rn5PEdejzhDJFFJwKNGhuayisqu/Yno7OfPLIzA0UHsKUF+d6a
 /9OTAa+/07c6rnF3jYEE5DcNFCovWacxU//8M/sUBQkp3YbfF/rRIy4cXL8IemHeHXyh
 GtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236875; x=1736841675;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wuo+RJED4gKortGRfj6WXDphAJOqG3auHfUnvOZE2lM=;
 b=edYq0AJORm7Wo3HSv9RkauI9W6SDbA7oo41khS7tbhyimfD4grBbA2ymKO4yHiWIVW
 oNwbOUW+LRiyEUHQC7JfBXJk6XnrIlq5NOcAepCcZhC74opUs9+84rr48gObkR9yn7fM
 e+FG1mDttH6R+qzWNlIqwz9mMzVXU3FgzBd/GuvA+97zDru4qEivERjp24yvQOw1bJab
 s56uphZJVNQDVFs9DAITJQOqKvLqWlQKtjMjrcaUe5MpfI+rtb2WsD9N4G3q7pS03gj1
 3vx5yruUxrzLleWlRm12tIAdZMh0yeNSVD88J1KHrqAvYj1hy1ee2Fi/fwPS8pAx8hkq
 +Bxg==
X-Gm-Message-State: AOJu0Yze/muYJQC68aHv8Ik0nFjZ1oIzf9cay9HiDtdxQZvNkbuJew79
 mi8YAZF6BtlJgvRSBcqwoOcNsolIS+Vk1B0FIqMFm59xygzi+tip9mD/6vSlpOdq6Mo9w5No5+I
 x
X-Gm-Gg: ASbGnctsyoxjvzfbfHosgA2Bak9ATi5yGiFq7tAgaK/ksr15es4ufIRDuck0U4TyT5w
 zpmO4VQ1B0VnhfHO6z6ZaYEcH6LOeRjOUdD5vAshO8eFv+n+N4eO8DaDMy7QGQh0KfnMrRs0Gv6
 EHHAT7GUJnANO9WsZhBdzPbD6kVXWXpF6/maB3JifgfRh3CZFJV3UpLm8EEc/bvhy1XmNAfecco
 NJaStbxlLMLiOmgs9MBUP4nLykQwG3nbFbE5xsiFdFmYCSzQMfpTBeIj1oApf+7zmVFoTMlSGhS
 ExlzMnM5JG9hZIm0fQ==
X-Google-Smtp-Source: AGHT+IEMKArpfDNuXcDdWPCczZ1O4+Xk9IPEhNh8EWGbNBaAiGjO0Zt9OXOIVt9mj738fgusUOAE1w==
X-Received: by 2002:a17:902:d481:b0:215:58be:334e with SMTP id
 d9443c01a7336-21a7a225796mr29455265ad.10.1736236874387; 
 Tue, 07 Jan 2025 00:01:14 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [RFC PATCH v2 00/81] tcg: Merge *_i32 and *_i64 opcodes
Date: Mon,  6 Jan 2025 23:59:51 -0800
Message-ID: <20250107080112.1175095-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Currently we have individual opcodes for each integer type.
This makes things difficult in tcg/optimize.c when we want
to transform the opcode stream.

Add TCGOP_TYPE() and use that instead.  Merge the opcodes that are
common to both TCG_TYPE_I32 and TCG_TYPE_I64.  We could eventually
merge some of the vector opcodes too, but that is a larger job.

This also moves quite a lot of the tcg backend implementation out
of the publicly exposed headers.  After this patchset is complete,
we will not rebuild target translators for most changes to the tcg
backend.

Changes for v2:
  - Begin reorganizing the tcg backends.  Create structures that
    encapsulate availability, constraints, and output routines.
    The intent is to keep everything related to an opcode together,
    so that code for a specific opcode is not scattered around
    multiple functions and multiple files.

    This conversion is incomplete.  I've completed the basic
    arithmetic opcodes.

    This is the place where I'd like feedback on readability.

  - Replace TCGOp.type with TCGOP_TYPE.
  - Add TCGOP_FLAGS, not used so far in v2, but intended to
    be used with especially load/store opcodes.


r~


Richard Henderson (81):
  tcg: Move call abi parameters from tcg-target.h to tcg-target.c.inc
  tcg: Replace TCGOP_VECL with TCGOP_TYPE
  tcg: Move tcg_op_insert_{after,before} decls to tcg-internal.h
  tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}
  tcg: Add TCGOP_FLAGS
  tcg: Add type and flags arguments to tcg_op_supported
  target/arm: Do not test TCG_TARGET_HAS_bitsel_vec
  target/arm: Use tcg_op_supported
  target/tricore: Use tcg_op_supported
  tcg: Add tcg_op_deposit_valid
  target/i386: Remove TCG_TARGET_extract_tl_valid
  target/i386: Use tcg_op_deposit_valid
  target/i386: Use tcg_op_supported
  tcg: Remove TCG_TARGET_NEED_LDST_LABELS and
    TCG_TARGET_NEED_POOL_LABELS
  tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
  tcg/tci: Move TCI specific opcodes to tcg-target-opc.h.inc
  tcg: Move fallback tcg_can_emit_vec_op out of line
  tcg: Split out tcg-target-has.h and tcg-has.h
  tcg: Split out tcg-target-mo.h
  tcg: Use C_NotImplemented in tcg_target_op_def
  tcg: Change have_vec to has_type in tcg_op_supported
  tcg: Reorg process_op_defs
  tcg: Remove args_ct from TCGOpDef
  tcg: Constify tcg_op_defs
  tcg: Validate op supported in opcode_args_ct
  tcg: Add TCG_OPF_NOT_PRESENT to opcodes without inputs or outputs
  tcg: Pass type and flags to tcg_target_op_def
  tcg: Add TCGType argument to tcg_out_op
  tcg: Remove TCG_OPF_64BIT
  tcg: Drop implementation checks from tcg-opc.h
  tcg: Replace IMPLVEC with TCG_OPF_VECTOR
  tcg/mips: Expand bswap unconditionally
  tcg/i386: Handle all 8-bit extensions for i686
  tcg/i386: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/aarch64: Provide TCG_TARGET_{s}extract_valid
  tcg/aarch64: Expand extract with offset 0 with andi
  tcg/arm: Add full [US]XT[BH] into {s}extract
  tcg/loongarch64: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/mips: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/ppc: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/riscv64: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/riscv: Use SRAIW, SRLIW for {s}extract_i64
  tcg/s390x: Fold the ext{8,16,32}[us] cases into {s}extract
  tcg/sparc64: Use SRA, SRL for {s}extract_i64
  tcg/tci: Provide TCG_TARGET_{s}extract_valid
  tcg/tci: Remove assertions for deposit and extract
  tcg: Remove TCG_TARGET_HAS_{s}extract_{i32,i64}
  tcg: Remove TCG_TARGET_HAS_deposit_{i32,i64}
  tcg: Remove INDEX_op_ext{8,16,32}*
  tcg: Add all_outop[]
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

 accel/tcg/internal-target.h                   |   1 +
 include/tcg/tcg-opc.h                         | 346 +++----
 include/tcg/tcg.h                             | 148 +--
 tcg/aarch64/tcg-target-has.h                  |  95 ++
 tcg/aarch64/tcg-target-mo.h                   |  12 +
 tcg/aarch64/tcg-target.h                      | 126 ---
 tcg/arm/tcg-target-con-set.h                  |   1 +
 tcg/arm/tcg-target-has.h                      |  90 ++
 tcg/arm/tcg-target-mo.h                       |  13 +
 tcg/arm/tcg-target.h                          |  86 --
 tcg/i386/tcg-target-con-set.h                 |   2 +-
 tcg/i386/tcg-target-has.h                     | 147 +++
 tcg/i386/tcg-target-mo.h                      |  19 +
 tcg/i386/tcg-target.h                         | 162 ----
 tcg/loongarch64/tcg-target-con-set.h          |   1 -
 tcg/loongarch64/tcg-target-con-str.h          |   1 -
 tcg/loongarch64/tcg-target-has.h              |  97 ++
 tcg/loongarch64/tcg-target-mo.h               |  12 +
 tcg/loongarch64/tcg-target.h                  | 115 ---
 tcg/mips/tcg-target-con-set.h                 |   1 -
 tcg/mips/tcg-target-has.h                     | 110 +++
 tcg/mips/tcg-target-mo.h                      |  13 +
 tcg/mips/tcg-target.h                         | 130 ---
 tcg/ppc/tcg-target-con-set.h                  |   3 +-
 tcg/ppc/tcg-target-has.h                      | 107 +++
 tcg/ppc/tcg-target-mo.h                       |  12 +
 tcg/ppc/tcg-target.h                          | 126 ---
 tcg/riscv/tcg-target-con-set.h                |   3 +-
 tcg/riscv/tcg-target-con-str.h                |   2 -
 tcg/riscv/tcg-target-has.h                    | 107 +++
 tcg/riscv/tcg-target-mo.h                     |  12 +
 tcg/riscv/tcg-target.h                        | 116 ---
 tcg/s390x/tcg-target-con-set.h                |   2 -
 tcg/s390x/tcg-target-has.h                    | 115 +++
 tcg/s390x/tcg-target-mo.h                     |  12 +
 tcg/s390x/tcg-target.h                        | 126 ---
 tcg/sparc64/tcg-target-con-set.h              |   1 +
 tcg/sparc64/tcg-target-has.h                  |  65 ++
 tcg/sparc64/tcg-target-mo.h                   |  12 +
 tcg/sparc64/tcg-target.h                      |  91 --
 tcg/tcg-has.h                                 |  89 ++
 tcg/tcg-internal.h                            |  18 +-
 tcg/tci/tcg-target-has.h                      |  59 ++
 tcg/tci/tcg-target-mo.h                       |  17 +
 tcg/tci/tcg-target.h                          |  94 --
 target/arm/tcg/translate-a64.c                |  10 +-
 target/arm/tcg/translate-sve.c                |  22 +-
 target/arm/tcg/translate.c                    |   2 +-
 target/sh4/translate.c                        |  20 +-
 target/tricore/translate.c                    |   4 +-
 tcg/optimize.c                                | 316 +++---
 tcg/tcg-common.c                              |   5 +-
 tcg/tcg-op-gvec.c                             |   1 +
 tcg/tcg-op-ldst.c                             |  29 +-
 tcg/tcg-op-vec.c                              |   9 +-
 tcg/tcg-op.c                                  | 665 +++++--------
 tcg/tcg.c                                     | 904 ++++++++++++------
 tcg/tci.c                                     | 138 +--
 docs/devel/tcg-ops.rst                        |  29 +-
 target/i386/tcg/emit.c.inc                    |  14 +-
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   4 +-
 tcg/aarch64/tcg-target.c.inc                  | 340 +++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   6 +-
 tcg/arm/tcg-target.c.inc                      | 305 ++++--
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |  22 +-
 tcg/i386/tcg-target.c.inc                     | 384 +++++---
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   0
 tcg/loongarch64/tcg-target.c.inc              | 370 +++----
 tcg/mips/tcg-target-opc.h.inc                 |   1 +
 tcg/mips/tcg-target.c.inc                     | 318 +++---
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |  12 +-
 tcg/ppc/tcg-target.c.inc                      | 394 ++++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   0
 tcg/riscv/tcg-target.c.inc                    | 380 ++++----
 ...{tcg-target.opc.h => tcg-target-opc.h.inc} |   6 +-
 tcg/s390x/tcg-target.c.inc                    | 589 ++++++------
 tcg/sparc64/tcg-target-opc.h.inc              |   1 +
 tcg/sparc64/tcg-target.c.inc                  | 234 +++--
 tcg/tcg-ldst.c.inc                            |  65 --
 tcg/tcg-pool.c.inc                            | 162 ----
 tcg/tci/tcg-target-opc.h.inc                  |   4 +
 tcg/tci/tcg-target.c.inc                      | 341 ++++---
 82 files changed, 4631 insertions(+), 4392 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h
 create mode 100644 tcg/aarch64/tcg-target-mo.h
 create mode 100644 tcg/arm/tcg-target-has.h
 create mode 100644 tcg/arm/tcg-target-mo.h
 create mode 100644 tcg/i386/tcg-target-has.h
 create mode 100644 tcg/i386/tcg-target-mo.h
 create mode 100644 tcg/loongarch64/tcg-target-has.h
 create mode 100644 tcg/loongarch64/tcg-target-mo.h
 create mode 100644 tcg/mips/tcg-target-has.h
 create mode 100644 tcg/mips/tcg-target-mo.h
 create mode 100644 tcg/ppc/tcg-target-has.h
 create mode 100644 tcg/ppc/tcg-target-mo.h
 create mode 100644 tcg/riscv/tcg-target-has.h
 create mode 100644 tcg/riscv/tcg-target-mo.h
 create mode 100644 tcg/s390x/tcg-target-has.h
 create mode 100644 tcg/s390x/tcg-target-mo.h
 create mode 100644 tcg/sparc64/tcg-target-has.h
 create mode 100644 tcg/sparc64/tcg-target-mo.h
 create mode 100644 tcg/tcg-has.h
 create mode 100644 tcg/tci/tcg-target-has.h
 create mode 100644 tcg/tci/tcg-target-mo.h
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (82%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (72%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (83%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (75%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 delete mode 100644 tcg/tcg-ldst.c.inc
 delete mode 100644 tcg/tcg-pool.c.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

-- 
2.43.0


