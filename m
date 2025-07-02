Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDC8C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwfh-0007Wp-HD; Wed, 02 Jul 2025 08:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfa-0007Rm-8y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:34 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfI-0000uS-Kf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:33 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c16e658f4so2262853a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459653; x=1752064453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BNNMHr09tTasVhE+8wqFbbS+T9GKbkOkcJYOlgxT0c0=;
 b=NBa7i8vdvo2o7txH7zY8TKcAGvO4FJDhdtjC2rJhm1uCeBGWvjhJmi0b4lNXp/VBEb
 oykJAMBkV8ZPxPWocRUSPFPBM5uA3tj7hYhI3SsQO/gB9BMr5pdVNbrRqwofLQJRfsxB
 tDmVziSMOoN+sXzq3r7rVa0UnG+zDyB4ijbwBZS4jy9PEWqncpftK22h1Kc+TbyVQx3e
 gVewlxlSsM6QdjQ1ZpBQOJruitnwcCNkAIRUFzygKlEYaKFPUMhq9X4VPWssPRt2jwCS
 YcMOMHFdGk2WzPpCnnjddWqx5BMLzcVtQWVFS/5SOSYI3CIzwHJUpH/na3mhJ/0cr/tR
 x+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459653; x=1752064453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BNNMHr09tTasVhE+8wqFbbS+T9GKbkOkcJYOlgxT0c0=;
 b=jvZbH2epDtTTQPCSPwzwLuLK8XQaBKWuBnSQtZ9ZNfnhYYnVsUmR5CXEXndOzpkQXI
 R66v1Z6MXc+hO8i5iUhEJQikDQJs1/D06eW8F431ZbL9Tlz2emodSMHxKvkrLBQstsWd
 LG1+olZc9szqGRv2nQ5oqlcuI04lVUd8ebiJo4iAFX84xqFvfS+IF0WRu7bKo42lTeg3
 vvdRd8/Jhma++IqG24vp3xNTEYJhft8IVBVtdMOmPg4pMP2NzpaGeO0PtJFYGJM0JOdn
 psI+lap7WVgVx2WOtbuGwCmzmCelBcKpj28otNVygj1KBtVbhN6kyLTelkZuDuJ2Km+E
 wrLQ==
X-Gm-Message-State: AOJu0YzwnHxBV7QiwhmIkYLNb3ehjxnmKhq3ZCKlTuNDX48waIIGj42l
 sRTepZ2+47lPDXSNPFO9WjyeGcExlW+1etTBmdg51GyrDe/rZrniEYInDDnPzuRmyj64q/g2gcU
 1iKqfobQ=
X-Gm-Gg: ASbGncu8Em91KaajZjC/wN7ku5fgsOGVw3JWKuJnr8t/1s5ft0I5/V/blXd0Dhi/Did
 qGvjbnbCQc5x+14Or0h4rD2zCj6Cs9fHVgAVeNP37b+TzmsZ3gs9SnFUhesGjwuRKt0kNkpKJA6
 GgIutzIB15KGtVU3jRhw0H2ZcHGCsUrW0XG26HbQ6tilxlL9IKQDeR9mXo52JJ/dHYAjE1y5qAo
 GrqtBMMJxv+6tYHQIK8xfSfaGUMIKttkqcyFp0npwpbHZgCOzDm7e3WVAOPWEhz4Rb86rN9//rl
 p1YNtFEUbaQnnmhToD2ygYoppQDR6nQ94DpMtmSabP7R87SE+f/R70VQw1i4p4+WJZ2zHJRttQE
 74gKg
X-Google-Smtp-Source: AGHT+IFJ3CQyymWCTjhrM+vJs2vpo0IBDvTX0BhyW2gK/gybKhhKF0cjGLwav2ytlRF4K63z2AKjvA==
X-Received: by 2002:a05:6830:2a0c:b0:727:876:c849 with SMTP id
 46e09a7af769-73b4d2863c1mr1984875a34.27.1751459653153; 
 Wed, 02 Jul 2025 05:34:13 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 00/97] target/arm: Implement FEAT_SME2p1
Date: Wed,  2 Jul 2025 06:32:33 -0600
Message-ID: <20250702123410.761208-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Based-on: 20250702122213.758588-1-richard.henderson@linaro.org
("[PATCH v3 00/10] target/arm: SME1/SVE2 fixes")

Since v2:
  - The tcg prep patches have been merged.
  - https://gitlab.arm.com/kleidi/kleidiai test suite now passes.
  - Too many other bug fixes to list.


r~


Peter Maydell (4):
  target/arm: Rename FMOPA_h to FMOPA_w_h
  target/arm: Rename BFMOPA to BFMOPA_w
  target/arm: Implement FMOPA (non-widening) for fp16
  target/arm: Implement SME2 BFMOPA (non-widening)

Richard Henderson (93):
  target/arm: Introduce FPST_ZA, FPST_ZA_F16
  target/arm: Use FPST_ZA for sme_fmopa_[hsd]
  target/arm: Rename zarray to za_state.za
  target/arm: Add isar feature tests for SME2p1, SVE2p1
  target/arm: Add ZT0
  target/arm: Add zt0_excp_el to DisasContext
  target/arm: Implement SME2 ZERO ZT0
  target/arm: Add alignment argument to gen_sve_{ldr,str}
  target/arm: Implement SME2 LDR/STR ZT0
  target/arm: Implement SME2 MOVT
  target/arm: Split get_tile_rowcol argument tile_index
  target/arm: Rename MOVA for translate
  target/arm: Split out get_zarray
  target/arm: Introduce ARMCPU.sme_max_vq
  target/arm: Implement SME2 MOVA to/from tile, multiple registers
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
  target/arm: Add helper_gvec{_ah}_bfmlsl{_nx}
  target/arm: Implement SME2 FMLAL, BFMLAL
  target/arm: Implement SME2 FDOT
  target/arm: Implement SME2 BFDOT
  target/arm: Implement SME2 FVDOT, BFVDOT
  target/arm: Rename helper_gvec_*dot_[bh] to *_4[bh]
  target/arm: Implemement SME2 SDOT, UDOT, USDOT, SUDOT
  target/arm: Rename SVE SDOT and UDOT patterns
  target/arm: Tighten USDOT (vectors) decode
  target/arm: Implement SDOT, UDOT (2-way) for SME2/SVE2p1
  target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
  target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
  target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
  target/arm: Implement SME2 FMLA, FMLS
  target/arm: Implement SME2 BFMLA, BFMLS
  target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
  target/arm: Implement SME2 ADD/SUB (array accumulator)
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
  target/arm: Implement SME2p1 Multiple Zero
  target/arm: Introduce pred_count_test
  target/arm: Fold predtest_ones into helper_sve_brkns
  target/arm: Split out do_whilel from helper_sve_whilel
  target/arm: Split out do_whileg from helper_sve_whileg
  target/arm: Move scale by esz into helper_sve_while*
  target/arm: Split trans_WHILE to lt and gt
  target/arm: Enable PSEL for SVE2p1
  target/arm: Implement SVE2p1 WHILE (predicate pair)
  target/arm: Implement SVE2p1 WHILE (predicate as counter)
  target/arm: Implement SVE2p1 PTRUE (predicate as counter)
  target/arm: Implement {ADD,SMIN,SMAX,UMIN,UMAX}QV for SVE2p1
  target/arm: Implement SVE2p1 PEXT
  target/arm: Implement SME2 SEL
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
  target/arm: Implement MOVAZ for SME2p1
  target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
  target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
  target/arm: Enable FEAT_SME2p1 on -cpu max
  linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1
  tests/tcg/aarch64: Add sme2-matmul test case

 target/arm/cpu-features.h          |   63 ++
 target/arm/cpu.h                   |   67 +-
 target/arm/syndrome.h              |    1 +
 target/arm/tcg/helper-sme.h        |  215 +++-
 target/arm/tcg/helper-sve.h        |  212 ++++
 target/arm/tcg/helper.h            |   91 +-
 target/arm/tcg/sve_ldst_internal.h |   89 ++
 target/arm/tcg/translate-a64.h     |   10 +-
 target/arm/tcg/translate.h         |    9 +
 target/arm/tcg/vec_internal.h      |  130 +++
 linux-user/aarch64/signal.c        |    4 +-
 linux-user/elfload.c               |    8 +
 target/arm/cpu.c                   |   11 +-
 target/arm/cpu64.c                 |    1 +
 target/arm/helper.c                |    8 +-
 target/arm/machine.c               |   22 +-
 target/arm/tcg/cpu64.c             |   10 +-
 target/arm/tcg/gengvec64.c         |   11 +
 target/arm/tcg/helper-a64.c        |    2 +
 target/arm/tcg/hflags.c            |   34 +-
 target/arm/tcg/mve_helper.c        |   21 -
 target/arm/tcg/neon_helper.c       |   30 +
 target/arm/tcg/sme_helper.c        | 1599 ++++++++++++++++++++++++++--
 target/arm/tcg/sve_helper.c        | 1424 ++++++++++++++++++++++---
 target/arm/tcg/translate-a64.c     |   16 +-
 target/arm/tcg/translate-neon.c    |   18 +-
 target/arm/tcg/translate-sme.c     | 1480 ++++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c     |  947 ++++++++++++++--
 target/arm/tcg/vec_helper.c        |  309 +++++-
 target/arm/tcg/vfp_helper.c        |   12 +-
 tests/tcg/aarch64/sme2-matmul-0.c  |  236 ++++
 docs/system/arm/emulation.rst      |    6 +
 target/arm/tcg/sme.decode          |  937 +++++++++++++++-
 target/arm/tcg/sve.decode          |  279 ++++-
 tests/tcg/aarch64/Makefile.target  |   11 +-
 tests/tcg/aarch64/sme2-matmul-1.S  |  321 ++++++
 36 files changed, 8046 insertions(+), 598 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme2-matmul-0.c
 create mode 100644 tests/tcg/aarch64/sme2-matmul-1.S

-- 
2.43.0


