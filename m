Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96173CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXxa-0007cY-6H; Fri, 22 May 2026 18:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxY-0007bi-SF
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxW-0007g7-2p
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:12 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-366330b6751so6133280a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487388; x=1780092188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OgfFCPbe91xG2u44Va9UJY9pN2E9NvIkzrmh/EKAB7E=;
 b=difVkg3BK/dnAqQZj8uVt/UMh7/GteEIU91yPBlA7l5BMJZcO2yohB3Ee9JSMQ+19A
 sPtHpDezHcyO9jesEJ9XDaIVaaWsMuoh8nm+uOX4mqF/E5/qzniniytoACiGz9UDFuwK
 ZzH80IWnBDh3eC+dDdEuhNLyK/7ochp74xa3Z+bOSUkuklAuDku63BB5yCeSX7JNTHWa
 sdIFdo0ujSB7FnUd5NaetP3+qhxG/EhnhEmsCsc9ud/8dMe9aG4j5EvkL2kOP7VL4gD6
 pTcNFprikQ2lR/JmUuwR7SSSWD/JHr3DRCnkXGHjP7DAD9U9kvAzIYJOo8VVQ2YRXMdN
 v9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487388; x=1780092188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgfFCPbe91xG2u44Va9UJY9pN2E9NvIkzrmh/EKAB7E=;
 b=Q8GBSTa8YajuXQMjCZuOMGFAyXptrL+OTOZAejLJZJp7c4cWlZxNQG8j/tH7dTU4y5
 ZGm3UWH0Kv0RkxsDmP4GTjW/MoY8iHP30VIIe9vXE/CpPZP8cJIPBSWNcnym2oEZ6Yyj
 vBlCzQjkf4EYX7txVftldMGR+p/c5yg2U06YHv8p6diDwnr4PPEbq6G7u+39PQQWYMNQ
 EdOO+12G553krO8AdEVbU0fFvtCPxOk2inpeA4Iat7VsZ0OzUyT8Dk8vsfGhqrbILv48
 HxxKE7hciFSBcIZDoQZrBvI+2rkt8Gg0K5wqD8Af7hKpC+zy7zqJu9dxR9Zn4a+b2wq0
 +rZA==
X-Gm-Message-State: AOJu0YwWsupgmSGtqDZ0WBfKYkoblfY3x9u6+6UQe+MxKKJflZiJf65p
 4qWduSlXQy3G1iDTHYFT0bDkCn+JKMOltiUZjP0ZjC3qlkPmIMuQ9hyFzjENiAEsC/9LCcW0dcN
 DcFRQ
X-Gm-Gg: Acq92OFt91LjvkqSE3n+IJOjqwcrONX601uCKJ1BTKd+ziQXMPISpsMdrxrwdrUGytZ
 3y5oK52zmFAV5jBF+zHre+s945ilkvoXUdWXaGbJSDRa8wPBt6YHuyhZ2HVP/fSSEChSWb4AiPB
 jsTG5xlRgote7WDEWR08qHvmkZpcwAhlo2SbPuxxdEon/1V5c7lwU7v5xrEQjuYOTr3dwiUwk5/
 a7Ok5PW2uVWlP9fefP1BoXJfmtkEBrkKNnofUjQozKm8Pu4NpC48JBbm8BpvMy+N9NCscuHWNTf
 9W5a6ndjbaiv+RmNoyUXqmL4lWCCqU3hssWkrUfniRKi+Z2JtZ5HpkgjQ/V1GZWKG3/pEpzZUr2
 d9g7+xYnAiuc72JkNPUKFy7y/etr2Mv+ODEOr3astjnD1kk48q+KU/3joYBm/jmWjXAN9WLukoP
 eqhBSzcYylR1YDOqPyOWhbnHZ0bCpt
X-Received: by 2002:a17:90b:390a:b0:36a:2a9b:3fb2 with SMTP id
 98e67ed59e1d1-36a677c82b0mr5362170a91.16.1779487388326; 
 Fri, 22 May 2026 15:03:08 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 00/64] target/arm: Implement FEAT_FP8
Date: Fri, 22 May 2026 15:02:02 -0700
Message-ID: <20260522220306.235200-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Based-on: 20260522182658.184604-1-richard.henderson@linaro.org
("[PULL 00/30] fpu patch queue")

Changes for v7:
  - Lots of patch feedback.
  - Split "Implement hwcap bits for fp8 features" into the
    various "Enable FEAT_FOO" patches so that we get 1 or 2
    at a time; previously missed F8MM8 and F8MM4.


r~


Pierrick Bouvier (1):
  tests/functional/aarch64/rme: update images to support FEAT_FP8

Richard Henderson (63):
  target/arm: Implement ID_AA64ISAR3
  target/arm: Implement FEAT_FAMINMAX for AdvSIMD
  target/arm: Implement FEAT_FAMINMAX for SME
  target/arm: Implement FEAT_FAMINMAX for SVE
  target/arm: Enable FEAT_FAMINMAX for -cpu max
  target/arm: Update SCR bits for Arm ARM M.a.a
  target/arm: Update HCRX bits for Arm ARM M.a.a
  target/arm: Introduce FPMR
  target/arm: Update SCTLR bits for FEAT_FPMR
  target/arm: Enable EnFPM bits for FEAT_FPMR
  target/arm: Clear FPMR on ResetSVEState
  target/arm: Add FPMR_EL to TBFLAGS
  target/arm: Trap direct acceses to FPMR
  target/arm: Dump FPMR when present
  linux-user/aarch64: Implement FPMR signal frames
  target/arm: Enable FEAT_FPMR for -cpu max
  target/arm: Implement ID_AA64FPFR0
  target/arm: Add isar_feature_aa64_f8cvt
  target/arm: Implement FSCALE for AdvSIMD
  target/arm: Implement FSCALE for SME
  target/arm: Split vector-type.h from cpu.h
  target/arm: Move vectors_overlap to vec_internal.h
  target/arm: Introduce arm_init_fp_status
  target/arm: Set e4m3_nan_is_snan
  target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL, BF2CVTL2 for AdvSIMD
  target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, BF2CVTLT for SVE
  target/arm: Rename SME BFCVT patterns to BFCVT_hs
  target/arm: Implement BF1CVT, BF1CVTL, BF2CVT, BF2CVTL for SME
  target/arm: Implement F1CVTL, F1CVTL2, F2CVTL, F2CVTL2 for AdvSIMD
  target/arm: Implement F1CVT, F1CVTLT, F2CVT, F2CVTLT for SVE
  target/arm: Implement F1CVT, F1CVTL, F2CVT, F2CVTL for SME
  target/arm: Implement BFCVTN for SVE
  target/arm: Implement FCVTN (16- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN, FCVTN2 (32- to 8-bit fp) for AdvSIMD
  target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
  target/arm: Implement FCVTNB, FCVTNT for SVE
  target/arm: Implement FCVT (FP16 to FP8) for SME
  target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
  target/arm: Implement LUTI2, LUTI4 for AdvSIMD
  target/arm: Implement LUTI2, LUTI4 for SVE
  target/arm: Enable FEAT_LUT for -cpu max
  target/arm: Enable FEAT_FP8 for -cpu max
  target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
  target/arm: Implement MOVT (vector to table)
  target/arm: Implement LUTI4 (four registers, 8-bit)
  target/arm: Enable FEAT_SME_LUTv2 for -cpu max
  target/arm: Implement FMLALB, FMLALT for AdvSIMD
  target/arm: Implement FMLALB, FMLALT (FP8 to FP16) for SVE
  target/arm: Implement FMLALL{BB,BT,TB,TT} for AdvSIMD
  target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
  target/arm: Enable FEAT_FP8FMA, FEAT_SSVE_FP8FMA for -cpu max
  target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP32) for SVE
  target/arm: Enable FEAT_FP8DOT4, FEAT_SSVE_FP8DOT4 for -cpu max
  target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
  target/arm: Implement FDOT (FP8 to FP16) for SVE
  target/arm: Enable FEAT_FP8DOT2, FEAT_SSVE_FP8DOT2 for -cpu max
  target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP32) for SVE
  target/arm: Enable FEAT_F8F32MM for -cpu max
  target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
  target/arm: Implement FMMLA (FP8 to FP16) for SVE
  target/arm: Enable FEAT_F8F16MM for -cpu max

 target/arm/cpregs.h                          |   5 +
 target/arm/cpu-features.h                    | 137 +++
 target/arm/cpu.h                             |  52 +-
 target/arm/helper-fp8.h                      |  14 +
 target/arm/internals.h                       |  13 +
 target/arm/tcg/helper-a64-defs.h             |  11 +
 target/arm/tcg/helper-defs.h                 |   6 +
 target/arm/tcg/helper-fp8-defs.h             |  40 +
 target/arm/tcg/helper-sme-defs.h             |   2 +-
 target/arm/tcg/helper-sve-defs.h             |  14 +
 target/arm/tcg/translate-a64.h               |   1 +
 target/arm/tcg/translate.h                   |  10 +
 target/arm/tcg/vec_internal.h                |  21 +
 target/arm/vector-type.h                     |  44 +
 linux-user/aarch64/elfload.c                 |  15 +
 linux-user/aarch64/signal.c                  |  44 +-
 target/arm/cpu.c                             |  57 +-
 target/arm/helper.c                          |  43 +-
 target/arm/machine.c                         |  20 +
 target/arm/tcg/cpu64.c                       |  24 +
 target/arm/tcg/fp8_helper.c                  | 858 +++++++++++++++++++
 target/arm/tcg/hflags.c                      |  42 +
 target/arm/tcg/sme_helper.c                  |   8 +-
 target/arm/tcg/sve_helper.c                  |  14 +-
 target/arm/tcg/translate-a64.c               | 186 ++++
 target/arm/tcg/translate-sme.c               | 109 ++-
 target/arm/tcg/translate-sve.c               | 253 ++++++
 target/arm/tcg/vec_helper.c                  |  66 ++
 target/arm/tcg/vec_helper64.c                |  42 +
 docs/system/arm/emulation.rst                |  13 +
 target/arm/cpu-sysregs.h.inc                 |   2 +
 target/arm/tcg/a64.decode                    |  47 +
 target/arm/tcg/meson.build                   |   1 +
 target/arm/tcg/sme.decode                    |  36 +-
 target/arm/tcg/sve.decode                    |  50 +-
 tests/functional/aarch64/test_rme_sbsaref.py |   7 +-
 tests/functional/aarch64/test_rme_virt.py    |   7 +-
 37 files changed, 2224 insertions(+), 90 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/vector-type.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


