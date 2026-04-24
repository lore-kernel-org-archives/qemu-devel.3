Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F8FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Bl-0005jn-T8; Fri, 24 Apr 2026 00:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8BV-0005bX-7N
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:36 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8BR-0002UD-1r
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:32 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-404254ffe8aso5224827fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005026; x=1777609826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zpyGrLhoZP560GtENt5J7/ZICQCuG+HFtME5LI0/d6E=;
 b=TXfntDMPPrFpUlpNrRfqCvCvWzN/jfpwiwWlWUIO8wC3Ujsxd81Dy0hjM2gH5kj2EY
 IXm1JYEDqLfgkKq3hNdrmd1x+wrnyn9It3XdDwXFDj/eSOwmk1MeN4ie5JRFvD/xVs9K
 hU1k5aMWzvDhDBAQCNbae4IxGoVJvnmB6GTGmD2w+kwTBRRGhBHyg5hu2bgFL49iP/1c
 OgVcwDk3SKTZICidBHiYJXt7+j6+xPN8z9qYIpFqTIRcfJSdsh1KVIVETEtB83OAaQ3u
 /Ahw1Wc4K0rEcjrXoHbq0Zj/ab8+vtisdoq6n+P7ekLzCP8YV0Rmezy99nomkx0OAfQD
 yEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005026; x=1777609826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpyGrLhoZP560GtENt5J7/ZICQCuG+HFtME5LI0/d6E=;
 b=CWRd11Pq9M+5ESM2+D/gvgRm7oIAbLQFQvOWtVLHz6AEqI9rY4EWwW5ty8D8yAhF+b
 fWjZnwzrsxvYkwKnNDeaeaZZq3+mvyRqUt/o+c/bvvmUpOzKA7+W1B8aijYQLaisoKG0
 7aWYqjVWuRYt+P62B9PvK1V3AzLHvTlCjmb1Du1Odi4dRHUmLlsh/+dNNUVifGyr591X
 Butm+sHXi8Xjv0uPdtoxyikMPBLu0Dy27i/cDysgBbrmkqRu79tyLow7x9I5aWs40cP8
 9CtR1NiSU9IyEo+MYCfeWYGoSMpjzuI5CX7SsWdwLfGAEy7GVeShIkN27IfUXEKDwWX3
 fHyg==
X-Gm-Message-State: AOJu0Yxmnyvt4N+GEid/g34JxuYVPAXKKBNrGAgLMoEtE+qM2gYeCuy3
 97BETU2+7NC8mTLdlItcxt2e/Jn1087cialAydDcvkUUXQCV+Wm72zEB2SdDlhg1hNkwm0OQWQS
 fxjs2U/I=
X-Gm-Gg: AeBDieslXbFdIUZHFeCfRBwZWD0Y05AMW6cSa3FjKkyQWzDEJaP25r/8ZlcpIPYF6hr
 sKaNLCR2UZv1+dbCB8oeCm+hPFGLPH3zcuI/eHrB3fZ1MTbjBxUhagM7QYteXnu7hezP3OEgvjB
 UcdZtp/hxPNTCI46qykJu8jUQjOuobEVgUj7nR0iCBZgqpZgi5t9fDnxzEhbPvxcQZDAUKnxfce
 E+WOzpnrbdrr1yDLkY6W9E86zFkOF3435NTo36mtFqp73ybFzbYgHpUYpOwSeV5Gelr6C7oU7vu
 uu4+Cj/XngbMGmedu3FQ6l42GYS5fMK263gtFaoqNBBsbCVdaRHz7NUmjxCt7JnF2jG0LG6Bj56
 MXWFCoSu8vDjfQTwVujrgMi3iKp+cdH/8Dfsy3TLwOnWvkW63f3vpXPcvoXblHn0VhtzTi3Hldh
 R0kKwV63gRBsY8y7UF5Muyd7krPrePh3MOqsl9Ho/CLl6h41A81Tv2GL2r/hDVAg==
X-Received: by 2002:a05:6871:3689:b0:42c:ecb:233a with SMTP id
 586e51a60fabf-42c0ecb5202mr6779948fac.18.1777005025771; 
 Thu, 23 Apr 2026 21:30:25 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com,
 alex.bennee@linaro.org
Subject: [PATCH v2 00/40] target/arm: Implement FEAT_FP8
Date: Fri, 24 Apr 2026 14:29:34 +1000
Message-ID: <20260424043014.46305-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Changes for v2:
  - Implement FEAT_LUT, a prerequisite missed in v1.
    Sorted the final "enable FEAT_FP8" after "enable FEAT_LUT".

And I should have mentioned before: this needs a firmware update for

  tests/functional/aarch64/test_rme_virt.py
  tests/functional/aarch64/test_rme_sbsaref.py

for the new cpu state in FEAT_FPMR, as the kernel we run tries to use
the advertised FPMR and we get a trap to EL3.  Once again I wish TF-A
would filter the reported ID registers to match the features for which
it is configured.

Pierrick, are you happy to continue hosting these images, or should we
nominate a Linaro host for these?


r~


Cc: pierrick.bouvier@oss.qualcomm.com
Cc: alex.bennee@linaro.org


Richard Henderson (40):
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
  target/arm: Enable FEAT_FPMR for -cpu max
  target/arm: Implement ID_AA64FPFR0
  target/arm: Add isar_feature_aa64_f8cvt
  target/arm: Implement FSCALE for AdvSIMD
  target/arm: Implement FSCALE for SME
  fpu: Add scalbn argument to fp8 conversion routines
  fpu: Add conversions between float16 and float8 formats
  target/arm: Split vector-type.h from cpu.h
  target/arm: Move vectors_overlap to vec_internal.h
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

 include/fpu/softfloat.h          |  22 +-
 target/arm/cpregs.h              |   5 +
 target/arm/cpu-features.h        |  66 +++
 target/arm/cpu.h                 |  52 +--
 target/arm/helper-fp8.h          |  14 +
 target/arm/internals.h           |  13 +-
 target/arm/tcg/helper-a64-defs.h |  11 +
 target/arm/tcg/helper-defs.h     |   5 +
 target/arm/tcg/helper-fp8-defs.h |  25 ++
 target/arm/tcg/helper-sme-defs.h |   2 +-
 target/arm/tcg/helper-sve-defs.h |  14 +
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/translate.h       |  10 +
 target/arm/tcg/vec_internal.h    |  19 +
 target/arm/vector-type.h         |  44 ++
 fpu/softfloat.c                  |  73 ++-
 target/arm/helper.c              |  43 +-
 target/arm/machine.c             |  20 +
 target/arm/tcg/cpu64.c           |  13 +
 target/arm/tcg/fp8_helper.c      | 742 +++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c          |  41 ++
 target/arm/tcg/sme_helper.c      |   8 +-
 target/arm/tcg/sve_helper.c      |   8 +
 target/arm/tcg/translate-a64.c   | 133 ++++++
 target/arm/tcg/translate-sme.c   |  85 +++-
 target/arm/tcg/translate-sve.c   | 111 +++++
 target/arm/tcg/vec_helper.c      |  52 +++
 target/arm/tcg/vec_helper64.c    |  51 +++
 docs/system/arm/emulation.rst    |   4 +
 target/arm/cpu-sysregs.h.inc     |   2 +
 target/arm/tcg/a64.decode        |  23 +
 target/arm/tcg/meson.build       |   1 +
 target/arm/tcg/sme.decode        |  28 +-
 target/arm/tcg/sve.decode        |  29 +-
 34 files changed, 1691 insertions(+), 79 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/vector-type.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


