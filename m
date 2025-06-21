Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C63C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z0-00053S-5L; Sat, 21 Jun 2025 19:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yv-00050c-V1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yr-0004QO-8a
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2412533b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549839; x=1751154639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CBaro+H443Ytkco4iye7Zj196ZSDqOXADhzcAwHlLRY=;
 b=umBw76mQxT4JKjlkqBJnhQCpS+mq01JO8snaXA31LZEGtfDoCGvRhZZRsE8W2ahN8L
 c5bj+gPFQB3uMar9YHv7F0o1jUeiKM+B+kVPKfy7n1Lma47VdSGjKHzQGyxWnqNnIsXR
 XdE3GVcj0Qkv998jxP67C34EajM9x3did7NomeS67zTuv3nSRJLsIKpcI4LCg2qUHuct
 3Uv5vOsaV9mvwRDgRgikyKXOVXV6jisa5fMAcc2frfQr2nTfrTekgpJ3Y3KYz+6vy5tq
 mccv4USRO1JRWtzJd5D+cxcSBUqcSvc9g9WEZG/7PyjT+/S6iwPKLbzyHdPnFoVZeUAb
 R30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549839; x=1751154639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CBaro+H443Ytkco4iye7Zj196ZSDqOXADhzcAwHlLRY=;
 b=K3krhHJE+9/u40G+FVDePSz/wRJZQk0kMrz/nWSek0UJYodbNX5Z+l+E6vDrBNTCjd
 x5ROElFoGN/rHpmt2J1vrF4t59WryvXWusUmHzoRswiTJ7Zimhg/rBKSIicsNXafIBIQ
 kFqoIpYhixUHpVbx1n39bugg7FQGemwG4i7nrJwXN7cwNQ6pOAH2RN9tkMLwdB0mqdj8
 EyYFbNkEFPmFKoe6w3VxmGOAr8BlozRpwv+T55U08XaVtTn36cXaJDlq5+oSO8f5Ot4Q
 pwd0WgOpKsdIpixIBcx0I4KLuiT9Tx0RT9V4JEA4i5G8LzEU5DAI4VexPUHu0dSzJXOe
 QtVA==
X-Gm-Message-State: AOJu0YyYZGe2yydjucWehvbWe2wE4+tsrIalQb1tTcVRv74ScZkWIlGi
 BqocAnMB3fLmGX9hoOYhINR4eEqkk9q9BhxznV1YUR2Q7DAwvQH0r4+gBvCCNuOQaiEjcV49V8u
 8g0iz
X-Gm-Gg: ASbGncsKLgof2VJWfObUzw0lluqDWcleHGDM739fSxiuGNhfgpQ5dCZKV7qr+Q/0aZz
 SzKJXRgdAOmLjntjUGJ+m2nmCIpiBkJrKUObEIl02Tt6NczLWiJIWbwP3soz9Jm9gH5jWoq0PL/
 U8QlKzlhE2P2JA8i5FlxnReu9lRRbORDotRnwR6YtAMrth1QNuQZ5cmnbtFPqVh3L3kgsV3NzfD
 vzEfxIgyJiaCnwwOOGR1BThRhu7CZMbmgMK/5zinf0jTQZDkAA8B9bYOHNuvuueFPgIDNNK5uKA
 u2x2y64AWoi2JWJm5vtlf7DAXhgcO202EW89N7FAxGAi9wyhp1T4nCk7mI9mrPChqEArqWnn4j3
 M3MmL8b0LEjE0TMyBwhkK
X-Google-Smtp-Source: AGHT+IEVmisAki919tEU/6KLtfQrwhgHVGKHjuDrqEQHNB3UsoO258lXRZoCH8RKkbzzUujzdBjzOw==
X-Received: by 2002:a05:6a20:938a:b0:215:e1cc:6360 with SMTP id
 adf61e73a8af0-22026e926d0mr11092904637.11.1750549838745; 
 Sat, 21 Jun 2025 16:50:38 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 000/101] target/arm: Implement FEAT_SME2p1
Date: Sat, 21 Jun 2025 16:48:56 -0700
Message-ID: <20250621235037.74091-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

v1: 20250206195715.2150758-1-richard.henderson@linaro.org

This implements the Scalar Matrix Extensions, version 2.1.

Version 1 only implemented FEAT_SME2, but it turns out that
all of the example code expects FEAT_SVE2p1 as well.
Since the presence of both SME2 and SVE2p1 requires SME2p1,
I've gone all the way to a point of consistency.

SME2 is the first vector-like extension we've had that has dynamic
indexing of registers: ZArray[(rv + offset) % svl], where RV is a
general register.  So the first thing I do is extend TCG's gvec
support to handle TCGv_ptr base + offset addressing.  I only changed
enough to handle what I needed within SME2; changing it all would be
a big job, and it would (at least for the moment) remain unused.

This has been only lightly tested, with the testcase in the
final patch.  I intend to do more testing next week, but as
there is significant interest, I wanted to get this out earlier.


r~


Richard Henderson (101):
  tcg: Add dbase argument to do_dup_store
  tcg: Add dbase argument to do_dup
  tcg: Add dbase argument to expand_clr
  tcg: Add base arguments to check_overlap_[234]
  tcg: Split out tcg_gen_gvec_2_var
  tcg: Split out tcg_gen_gvec_3_var
  tcg: Split out tcg_gen_gvec_mov_var
  tcg: Split out tcg_gen_gvec_{add,sub}_var
  tcg: Split out tcg_gen_gvec_dup_imm_var
  linux-user/aarch64: Update hwcap bits from 6.14
  target/arm: Remove CPUARMState.vfp.scratch
  target/arm: Introduce FPST_ZA, FPST_ZA_F16
  target/arm: Use FPST_ZA for sme_fmopa_[hsd]
  target/arm: Rename zarray to za_state.za
  target/arm: Add isar feature tests for SME2, SVE2p1
  target/arm: Add ZT0
  target/arm: Add zt0_excp_el to DisasContext
  target/arm: Implement SME2 ZERO ZT0
  target/arm: Implement SME2 LDR/STR ZT0
  target/arm: Implement SME2 MOVT
  target/arm: Split get_tile_rowcol argument tile_index
  target/arm: Rename MOVA for translate
  target/arm: Implement SME2 MOVA to/from tile, multiple registers
  target/arm: Split out get_zarray
  target/arm: Implement SME2 MOVA to/from array, multiple registers
  target/arm: Implement SME2 BMOPA
  target/arm: Implement SME2 SMOPS, UMOPS (2-way)
  target/arm: Introduce gen_gvec_sve2_sqdmulh
  target/arm: Implement SME2 Multiple and Single SVE Destructive
  target/arm: Implement SME2 Multiple Vectors SVE Destructive
  target/arm: Implement SME2 ADD/SUB (array results, multiple and single
    vector)
  target/arm: Implement SME2 ADD/SUB (array results, multiple vectors)
  target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
  target/arm: Implement SME2 FMLAL, BFMLAL
  target/arm: Implement SME2 FDOT
  target/arm: Implement SME2 BFDOT
  target/arm: Implement SME2 FVDOT, BFVDOT
  target/arm: Rename helper_gvec_*dot_[bh] to *_4[bh]
  target/arm: Remove helper_gvec_sudot_idx_4b
  target/arm: Implemement SME2 SDOT, UDOT, USDOT, SUDOT
  target/arm: Rename SVE SDOT and UDOT patterns
  target/arm: Tighten USDOT (vectors) decode
  target/arm: Implement SDOT, UDOT (2-way) for SME2/SVE2p1
  target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
  target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
  target/arm: Implement SME2 SMLALL, SMLSLL, UMLALL, UMLSLL
  target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
  target/arm: Implement SME2 FMLA, FMLS
  target/arm: Implement SME2 BFMLA, BFMLS
  target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
  target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
  target/arm: Implement SME2 FCVT (widening), FCVTL
  target/arm: Implement SME2 FCVTZS, FCVTZU
  target/arm: Implement SME2 SCVTF, UCVTF
  target/arm: Implement SME2 FRINTN, FRINTP, FRINTM, FRINTA
  target/arm: Introduce do_[us]sat_[bhs] macros
  target/arm: Use do_[us]sat_[bhs] in sve_helper.c
  target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
  target/arm: Implement SQCVTN, UQCVTN, SQCVTUN for SME2/SVE2p1
  target/arm: Implement SME2 SUNPK, UUNPK
  target/arm: Implement SME2 ZIP, UZP (four registers)
  target/arm: Move do_urshr, do_srshr to vec_internal.h
  target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
  target/arm: Implement SME2 ZIP, UZP (two registers)
  target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
  target/arm: Enable SCLAMP, UCLAMP for SVE2p1
  target/arm: Implement FCLAMP for SME2, SVE2p1
  target/arm: Implement SME2 SEL
  target/arm: Implement SME2p1 Multiple Zero
  target/arm: Introduce pred_count_test
  target/arm: Fold predtest_ones into helper_sve_brkns
  target/arm: Split out do_whilel from helper_sve_whilel
  target/arm: Split out do_whileg from helper_sve_whileg
  target/arm: Move scale by esz into helper_sve_while*
  target/arm: Split trans_WHILE to lt and gt
  target/arm: Implement SVE2p1 WHILE (predicate pair)
  target/arm: Implement SVE2p1 WHILE (predicate as counter)
  target/arm: Implement SVE2p1 PTRUE (predicate as counter)
  target/arm: Enable PSEL for SVE2p1
  target/arm: Implement {ADD,SMIN,SMAX,UMIN,UMAX}QV for SVE2p1
  target/arm: Implement SVE2p1 PEXT
  target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
  target/arm: Implement FADDQV, F{MIN,MAX}{NM}QV for SVE2p1
  target/arm: Implement BFMLSLB{L,T} for SME2/SVE2p1
  target/arm: Implement CNTP (predicate as counter) for SME2/SVE2p1
  target/arm: Implement DUPQ for SME2p1/SVE2p1
  target/arm: Implement EXTQ for SME2p1/SVE2p1
  target/arm: Implement PMOV for SME2p1/SVE2p1
  target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
  target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
  target/arm: Implement SME2 counted predicate register load/store
  target/arm: Split the ST_zpri and ST_zprr patterns
  target/arm: Implement {LD1,ST1}{W,D} (128-bit element) for SVE2p1
  target/arm: Move ld1qq and st1qq primitives to sve_ldst_internal.h
  target/arm: Implement {LD,ST}[234]Q for SME2p1/SVE2p1
  target/arm: Implement LD1Q, ST1Q for SVE2p1
  target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
  target/arm: Implement MOVAZ for SME2p1
  linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1
  target/arm: Enable FEAT_SME2p1 on -cpu max
  tests/tcg/aarch64: Add sme2-matmul test case

 include/tcg/tcg-op-gvec-common.h   |   23 +
 target/arm/cpu-features.h          |   55 +
 target/arm/cpu.h                   |   68 +-
 target/arm/syndrome.h              |    1 +
 target/arm/tcg/helper-sme.h        |  198 ++++
 target/arm/tcg/helper-sve.h        |  212 ++++
 target/arm/tcg/helper.h            |   57 +-
 target/arm/tcg/sve_ldst_internal.h |   89 ++
 target/arm/tcg/translate-a64.h     |    4 +
 target/arm/tcg/translate.h         |   11 +
 target/arm/tcg/vec_internal.h      |   47 +
 linux-user/aarch64/signal.c        |    4 +-
 linux-user/elfload.c               |   83 +-
 target/arm/cpu.c                   |   11 +-
 target/arm/helper.c                |    2 +-
 target/arm/machine.c               |   22 +-
 target/arm/tcg/cpu64.c             |   10 +-
 target/arm/tcg/gengvec.c           |    6 +
 target/arm/tcg/gengvec64.c         |   11 +
 target/arm/tcg/helper-a64.c        |    2 +
 target/arm/tcg/hflags.c            |   34 +-
 target/arm/tcg/mve_helper.c        |   21 -
 target/arm/tcg/sme_helper.c        | 1081 +++++++++++++++++--
 target/arm/tcg/sve_helper.c        | 1568 ++++++++++++++++++++++++----
 target/arm/tcg/translate-a64.c     |   15 +-
 target/arm/tcg/translate-neon.c    |   18 +-
 target/arm/tcg/translate-sme.c     | 1359 +++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c     |  895 ++++++++++++++--
 target/arm/tcg/vec_helper.c        |  218 +++-
 target/arm/tcg/vfp_helper.c        |   10 +
 tcg/tcg-op-gvec.c                  |  371 ++++---
 tests/tcg/aarch64/sme2-matmul-0.c  |  236 +++++
 docs/system/arm/emulation.rst      |    6 +
 target/arm/tcg/sme.decode          |  928 +++++++++++++++-
 target/arm/tcg/sve.decode          |  281 ++++-
 tests/tcg/aarch64/Makefile.target  |   11 +-
 tests/tcg/aarch64/sme2-matmul-1.S  |  321 ++++++
 37 files changed, 7598 insertions(+), 691 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme2-matmul-0.c
 create mode 100644 tests/tcg/aarch64/sme2-matmul-1.S

-- 
2.43.0


