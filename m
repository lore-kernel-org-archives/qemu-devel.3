Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FAFC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg804-00077X-W4; Thu, 06 Feb 2025 14:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg802-00076F-Bo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg7zz-0000NY-4v
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so27805695ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871837; x=1739476637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jf2yGo1onw0qReRBUVYGLnwdRRuXBqoyLpotia/2CDI=;
 b=zDBnt6g1A0Zv9i2ckH2OvQ/zLtLEEWqf3NjEk5D+0kBgxTccE01JPqSRDc6B9dN+vF
 mijH4TKe8Ju2Xl4ZVdXvFDRx/F5I8E3RoNx79Hx3lIyIe/1AOYRF7OZvQkLAYZr64T3q
 QhHNWU4Ql83P4e1u1hhthRkNWomLBGEyMKapfrrp7y80PCqLj1Bn3uDcCiJDzrivnpHp
 G0V4KJ9JjUtX5x//sdAHukUEJ7UnUc+7snvVwNoiwkjzYo0J9ksstBcrcOc5jDL0hiMx
 3WCl4AO5t0vNeI2jLUiRbKwpIM9DLxTgghdyiHHcGyUmnFIZBQd5TVpQevcNKZ1mef8R
 VpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871837; x=1739476637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jf2yGo1onw0qReRBUVYGLnwdRRuXBqoyLpotia/2CDI=;
 b=cQZicmgMBAPFv01YTasjs1N5WsZQtUMOPpt8IsBIYQa1+Dx7y6Im1xAeHMoR31/ilx
 QoVc2v9gJYf2zLGfmkHwFEaEBmRT6YSqMqb01q6I+lkxxDqvS9zF0y+KOUA6qd0wCQvG
 Mo2be95YOXrw0VLTXC/xDLKxGIgCNqFqdmoyVC1E3y0MoXemfBYpCVPixoBEJqRmyETl
 T1DM+ulp1RC/4FoHoM+rRK2lT6k3ikynE+x9PDjesFor+p1J3UagL/XmgdoOkaDMr6hI
 lwYRzcT50+KgeJR5hNBXiuT3fnZmswmek44pTMKH7p+oumbdvRTIQ0hMea4ZOElZfGvF
 v5Cg==
X-Gm-Message-State: AOJu0YxcVG2k6bRDUPGvJW8TignHUsZOWSSTzQfRF7ahFAIE0kuq06ms
 FNzUg3q2QNlrrKwmDgOtTh1/fxFfNJ9MZm6MZih1smUXdpRjSLcZZahUV+7fPHSAsBc4ULJSRfj
 T
X-Gm-Gg: ASbGnctXDOr/LRK5/Zhp4VgpF630mQYnaIQBiUvIdy9TNkfcrsW8uZJllIMfg9Iyic/
 m82MLt4TfYT64JYJ2Aqr9doW+izvcZ6zsBQDZaeyrHD1frWAAEstT7ouWWswQvJ6C+vPnufbWC8
 Z0S8tb14Y0KT55HMzDjC41abzLQts6llQcQgUW00AvQ3c58oPOvbqRdD9Ze0nmC8YD50925Ry7m
 SxHa/Kuw8Awdj1tMxpaCdrK9HP56qoVLY0fmTROWQXnWxqREJH5pIaOGRKbnTSjdjfvRDxc7aA/
 jTLMjbOWGBXxmP9iV56i7l7W1K0G/8pC4RVOZhDOjOgBHUw=
X-Google-Smtp-Source: AGHT+IGnIoQzmj+Ym7/xofm2SMUmnQcL75mQzGAmQZUBODjELx63Gzhb3K/Rpq+5TJPIxrJz0LGx+A==
X-Received: by 2002:aa7:8894:0:b0:725:ebab:bb2e with SMTP id
 d2e1a72fcca58-7305d4684aamr751453b3a.11.1738871836915; 
 Thu, 06 Feb 2025 11:57:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/61] target/arm: Implement FEAT_SME2
Date: Thu,  6 Feb 2025 11:56:14 -0800
Message-ID: <20250206195715.2150758-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Based-on: 20250201164012.1660228-1-peter.maydell@linaro.org
("[PATCH v2 00/69] target/arm: FEAT_AFP and FEAT_RPRES")

This implements the Scalar Matrix Extensions, version 2, plus two
trivial extensions for float16 and bfloat16.

This hasn't been tested much at all; I need to either get FVP up and
running for RISU comparison, or write some stand-alone test cases.
But in the meantime this could use some eyes.

SME2 is the first vector-like extension we've had that has dynamic
indexing of registers: ZArray[(rv + offset) % svl], where RV is a
general register.  So the first thing I do is extend TCG's gvec
support to handle TCGv_ptr base + offset addressing.  I only changed
enough to handle what I needed within SME2; changing it all would be
a big job, and it would (at least for the moment) remain unused.

Still to-do are few more extensions for SME2p1.


r~


Richard Henderson (61):
  tcg: Add dbase argument to do_dup_store
  tcg: Add dbase argument to do_dup
  tcg: Add dbase argument to expand_clr
  tcg: Add base arguments to check_overlap_[234]
  tcg: Split out tcg_gen_gvec_2_var
  tcg: Split out tcg_gen_gvec_3_var
  tcg: Split out tcg_gen_gvec_mov_var
  tcg: Split out tcg_gen_gvec_{add,sub}_var
  target/arm: Introduce FPST_ZA, FPST_ZA_F16
  target/arm: Use FPST_ZA for sme_fmopa_[hsd]
  target/arm: Rename zarray to za_state.za
  target/arm: Add isar_feature_aa64_sme2*
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
  target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT, USVDOT
  target/arm: Implement SME2 SMLAL, SMLSL, UMLAL, UMLSL
  target/arm: Implement SME2 SMLALL, SMLSLL, UMLALL, UMLSLL
  target/arm: Rename gvec_fml[as]_[hs] with _nf_ infix
  target/arm: Implement SME2 FMLA, FMLS
  target/arm: Implement SME2 BFMLA, BFMLS
  target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
  target/arm: Remove CPUARMState.vfp.scratch
  target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN
  target/arm: Implement SME2 FCVT (widening), FCVTL
  target/arm: Implement SME2 FCVTZS, FCVTZU
  target/arm: Implement SME2 SCVTF, UCVTF
  target/arm: Implement SME2 FRINTN, FRINTP, FRINTM, FRINTA
  target/arm: Introduce do_[us]sat_[bhs] macros
  target/arm: Use do_[us]sat_[bhs] in sve_helper.c
  target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
  target/arm: Implement SME2 SUNPK, UUNPK
  target/arm: Implement SME2 ZIP, UZP (four registers)
  target/arm: Move do_urshr, do_srshr to vec_internal.h
  target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
  target/arm: Implement SME2 ZIP, UZP (two registers)
  target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
  target/arm: Implement SME2 SEL
  target/arm: Enable FEAT_SME2, FEAT_SME_F16F16, FEAT_SVE_B16B16 on -cpu
    max

 include/tcg/tcg-op-gvec-common.h |   20 +
 target/arm/cpu-features.h        |   35 +
 target/arm/cpu.h                 |   68 +-
 target/arm/helper.h              |   47 +-
 target/arm/syndrome.h            |    1 +
 target/arm/tcg/helper-sme.h      |  164 ++++
 target/arm/tcg/translate-a64.h   |    4 +
 target/arm/tcg/translate.h       |   11 +
 target/arm/tcg/vec_internal.h    |   32 +
 linux-user/aarch64/signal.c      |    4 +-
 target/arm/cpu.c                 |   11 +-
 target/arm/helper.c              |    2 +-
 target/arm/machine.c             |   23 +-
 target/arm/tcg/cpu64.c           |    7 +-
 target/arm/tcg/gengvec.c         |    6 +
 target/arm/tcg/gengvec64.c       |   11 +
 target/arm/tcg/helper-a64.c      |    2 +
 target/arm/tcg/hflags.c          |   34 +-
 target/arm/tcg/mve_helper.c      |   21 -
 target/arm/tcg/sme_helper.c      |  867 +++++++++++++++++++--
 target/arm/tcg/sve_helper.c      |  137 ++--
 target/arm/tcg/translate-a64.c   |   15 +-
 target/arm/tcg/translate-neon.c  |   18 +-
 target/arm/tcg/translate-sme.c   | 1238 +++++++++++++++++++++++++++++-
 target/arm/tcg/translate-sve.c   |   28 +-
 target/arm/tcg/vec_helper.c      |  162 +++-
 target/arm/vfp_helper.c          |   10 +
 tcg/tcg-op-gvec.c                |  363 +++++----
 docs/system/arm/emulation.rst    |    3 +
 target/arm/tcg/sme.decode        |  823 +++++++++++++++++++-
 30 files changed, 3719 insertions(+), 448 deletions(-)

-- 
2.43.0


