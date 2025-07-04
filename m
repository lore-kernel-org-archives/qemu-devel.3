Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F90C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDq-00086f-Us; Fri, 04 Jul 2025 12:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDp-00085f-6w
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDm-0005qo-MM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:08 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a528243636so651235f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646303; x=1752251103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=X57YnnM9HkiJVTGT4zNlALUCSBROTWBTouwdQnrgnCg=;
 b=Ofp93xvW5HtOKST2C0tniStnd7/ZYbLDXd7ZP8FYr3kXZWBm9akWoL3nlMIoznnCBa
 K0w2kZ8okT3QGI/RdxT7F+WCcTUYzbH6wStd9A1wB1RsD5pSnmW/4c5tpufZQCLkT9MZ
 bYqmc8PS2nJQLREdL7SuRzcAdibp8zSSCjfE3QIKVY+SRGmI26EnSqOSEtLVBjgkjXiB
 WqOdruk5jEjKf3vvmcmyOtw7okDEGLAj/onYnYKsQNQjIG+LgxpO2Ay0yzE6w/rrFFX9
 HAnYLO+23j3LqJqU/+ER6j9I0afNaae22Hx9G2c7uWV0sTCmDH8dj93kQhMXYnRvv9MQ
 E2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646303; x=1752251103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X57YnnM9HkiJVTGT4zNlALUCSBROTWBTouwdQnrgnCg=;
 b=Zoet+oqF/HmNQqz4uMsVrd8TI4iXM3Z7PQ+emHfxGaBYnXk+o3v4On4ErhEZkS3/4p
 3f6LNN9szER7poRPgmb2UxWyvkK9Klh5eUrCh1NndDstS2Oi8uRwMZNISHfeNRAa3Fjr
 V1pp8x5m6TufHSNCgGakLSPG8MJW5ExDOK4hHH/WNG144p3MfKYNiTjYPVFDbgoVWjmN
 Y7K58YzfAOBlYH2UXwPgw2G3fNIkxuGIaeX6FBq57XkhUoOqMvDzCWggafXiXHgdDGD6
 hrz/ODQFHPf1HcH1sZUhYHK3ClwHs6NZtWXr4MR/au/l3OrZhJ+8UbJHEsjw6h0R6AMH
 f0cw==
X-Gm-Message-State: AOJu0YxkY4VQeAMHJzgxFrcJ1SYTLDN0H+fCh1txzDhr7z3OJJDPU2sw
 lCBpYl4a6vI/7dgwbbaHfJd3t7LJvkeLVVFa1Gy1cm5maKfHb2EXB/ACkQAhTO4CdhpGEpzfVyw
 y6qVE
X-Gm-Gg: ASbGncvtwbaQZETaFK20er6DhGzZenAvaZ0mDxLB5w9R0kp23v7wEQWC9kF7fGBly1t
 +mgQu9qTUaktpAE9NGnxrGBERtoumg7nVHZ123NZLWvTQeOg0I0YxMO0fbflWWWZRoB7NL1VVY3
 GbY5WDeQF1zSOBQ+H4sUtj98U9qBvB8sD8Z69RVn7qs9p2FlDuczAuxYZZGE9olIsxNW7bDM5EF
 h+vlqWLfbqNIzdp44x7jBHU7pZXO25iwq0SUmaOKtKNbJLJFP61yQN+xJWvL5LfhjJEMxpygpbk
 re1fXPXV448U32hHPVSYva6dw8NDihnfTIo3dogyx1K1pV90MhIDh4MUnM16oBi09+jz0Olkow0
 mwKA=
X-Google-Smtp-Source: AGHT+IED61+N5qdg/LYDtQ2x0Kw7SGY1SEdlsd7IDXtNqd7VARUhTKWpgBf86+QRot2KBAFaedzpZA==
X-Received: by 2002:a05:6000:40e1:b0:3a4:ec32:e4da with SMTP id
 ffacd0b85a97d-3b4964c1482mr2689843f8f.15.1751646303162; 
 Fri, 04 Jul 2025 09:25:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 000/119] target-arm queue
Date: Fri,  4 Jul 2025 17:23:00 +0100
Message-ID: <20250704162501.249138-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Hi; here's a target-arm pullreq. Apologies for the size: this is
because it has all RTH's work to enable emulation of SME2p1 and
SVE2p1.

thanks
-- PMM

The following changes since commit c77283dd5d79149f4e7e9edd00f65416c648ee59:

  Merge tag 'pull-request-2025-07-02' of https://gitlab.com/thuth/qemu into staging (2025-07-03 06:01:41 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250704

for you to fetch changes up to 083fef73585dfa03f72055ace6de8dec4912d0b0:

  linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1 (2025-07-04 15:53:23 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement emulation of SME2p1 and SVE2p1
 * Correctly enforce alignment checks for v8M loads and
   stores done via helper functions
 * Mark the "highbank" and the "midway" machine as deprecated

----------------------------------------------------------------
Peter Maydell (4):
      target/arm: Rename FMOPA_h to FMOPA_w_h
      target/arm: Rename BFMOPA to BFMOPA_w
      target/arm: Implement FMOPA (non-widening) for fp16
      target/arm: Implement SME2 BFMOPA (non-widening)

Richard Henderson (103):
      target/arm: Fix SME vs AdvSIMD exception priority
      target/arm: Fix sve_access_check for SME
      target/arm: Fix 128-bit element ZIP, UZP, TRN
      target/arm: Replace @rda_rn_rm_e0 in sve.decode
      target/arm: Fix FMMLA (64-bit element) for 128-bit VL
      target/arm: Disable FEAT_F64MM if maximum SVE vector size too small
      target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
      target/arm: Fix f16_dotadd vs nan selection
      target/arm: Fix bfdotadd_ebf vs nan selection
      target/arm: Remove CPUARMState.vfp.scratch
      target/arm: Introduce FPST_ZA, FPST_ZA_F16
      target/arm: Use FPST_ZA for sme_fmopa_[hsd]
      target/arm: Rename zarray to za_state.za
      target/arm: Add isar feature tests for SME2p1, SVE2p1
      target/arm: Add ZT0
      target/arm: Add zt0_excp_el to DisasContext
      target/arm: Implement SME2 ZERO ZT0
      target/arm: Add alignment argument to gen_sve_{ldr, str}
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
      target/arm: Implement SME2 ADD/SUB (array results, multiple and single vector)
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
      target/arm: Expand do_zero inline
      target/arm: Split out do_whilel from helper_sve_whilel
      target/arm: Split out do_whileg from helper_sve_whileg
      target/arm: Move scale by esz into helper_sve_while*
      target/arm: Split trans_WHILE to lt and gt
      target/arm: Enable PSEL for SVE2p1
      target/arm: Implement SVE2p1 WHILE (predicate pair)
      target/arm: Implement SVE2p1 WHILE (predicate as counter)
      target/arm: Implement SVE2p1 PTRUE (predicate as counter)
      target/arm: Implement {ADD, SMIN, SMAX, UMIN, UMAX}QV for SVE2p1
      target/arm: Implement SVE2p1 PEXT
      target/arm: Implement SME2 SEL
      target/arm: Implement ANDQV, ORQV, EORQV for SVE2p1
      target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1
      target/arm: Implement BFMLSLB{L, T} for SME2/SVE2p1
      target/arm: Implement CNTP (predicate as counter) for SME2/SVE2p1
      target/arm: Implement DUPQ for SME2p1/SVE2p1
      target/arm: Implement EXTQ for SME2p1/SVE2p1
      target/arm: Implement PMOV for SME2p1/SVE2p1
      target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
      target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
      target/arm: Implement SME2 counted predicate register load/store
      target/arm: Split the ST_zpri and ST_zprr patterns
      target/arm: Implement {LD1, ST1}{W, D} (128-bit element) for SVE2p1
      target/arm: Move ld1qq and st1qq primitives to sve_ldst_internal.h
      target/arm: Implement {LD, ST}[234]Q for SME2p1/SVE2p1
      target/arm: Implement LD1Q, ST1Q for SVE2p1
      target/arm: Implement MOVAZ for SME2p1
      target/arm: Implement LUTI2, LUTI4 for SME2/SME2p1
      target/arm: Support FPCR.AH in SME FMOPS, BFMOPS
      target/arm: Enable FEAT_SME2p1 on -cpu max
      linux-user/aarch64: Set hwcap bits for SME2p1/SVE2p1

Thomas Huth (1):
      hw/arm/highbank: Mark the "highbank" and the "midway" machine as deprecated

William Kosasih (11):
      target/arm: Bring VLSTM/VLLDM helper store/load closer to the ARM pseudocode
      target/arm: Fix BLXNS helper store alignment checks
      target/arm: Fix function_return helper load alignment checks
      target/arm: Fix VLDR helper load alignment checks
      target/arm: Fix VSTR helper store alignment checks
      target/arm: Fix VLDR_SG helper load alignment checks
      target/arm: Fix VSTR_SG helper store alignment checks
      target/arm: Fix VLD4 helper load alignment checks
      target/arm: Fix VLD2 helper load alignment checks
      target/arm: Fix VST4 helper store alignment checks
      target/arm: Fix VST2 helper store alignment checks

 docs/about/deprecated.rst          |    7 +
 docs/system/arm/emulation.rst      |    6 +
 target/arm/cpu-features.h          |   63 ++
 target/arm/cpu.h                   |   70 +-
 target/arm/syndrome.h              |    1 +
 target/arm/tcg/helper-sme.h        |  215 ++++-
 target/arm/tcg/helper-sve.h        |  212 +++++
 target/arm/tcg/helper.h            |   91 +-
 target/arm/tcg/sve_ldst_internal.h |   89 ++
 target/arm/tcg/translate-a64.h     |   10 +-
 target/arm/tcg/translate.h         |    9 +
 target/arm/tcg/vec_internal.h      |  148 ++++
 target/arm/tcg/sme.decode          |  937 +++++++++++++++++++-
 target/arm/tcg/sve.decode          |  327 +++++--
 hw/arm/highbank.c                  |    2 +
 linux-user/aarch64/signal.c        |    4 +-
 linux-user/elfload.c               |    8 +
 target/arm/cpu.c                   |   11 +-
 target/arm/cpu64.c                 |    8 +
 target/arm/helper.c                |    8 +-
 target/arm/machine.c               |   22 +-
 target/arm/tcg/cpu64.c             |   10 +-
 target/arm/tcg/gengvec64.c         |   11 +
 target/arm/tcg/helper-a64.c        |    2 +
 target/arm/tcg/hflags.c            |   34 +-
 target/arm/tcg/m_helper.c          |   33 +-
 target/arm/tcg/mve_helper.c        |  183 ++--
 target/arm/tcg/neon_helper.c       |   30 +
 target/arm/tcg/sme_helper.c        | 1674 +++++++++++++++++++++++++++++++++---
 target/arm/tcg/sve_helper.c        | 1201 +++++++++++++++++++++-----
 target/arm/tcg/translate-a64.c     |   45 +-
 target/arm/tcg/translate-neon.c    |   18 +-
 target/arm/tcg/translate-sme.c     | 1480 ++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c     | 1019 +++++++++++++++++++---
 target/arm/tcg/vec_helper.c        |  384 +++++++--
 target/arm/tcg/vfp_helper.c        |   12 +-
 36 files changed, 7605 insertions(+), 779 deletions(-)

