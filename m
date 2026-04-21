Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF7F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rr-0008Cc-2z; Tue, 21 Apr 2026 01:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Qr-0007ug-FG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Qo-0006Jh-6a
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:13:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso1347836a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748432; x=1777353232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=km6yAkhjFVi62a1pEJuX+ckhQ7qaid3prVVIo0un0Bs=;
 b=RIZtfXFiKNZNPQqR0q/fJaGK+X+SOpKKzm3Wxl7yrv4vzSiDgHjScXoZDfz7Cen6Jw
 iImGwuHFERrYOlBMbBgpzTgSw3Ywh8ey2DXwnu9s0x2n+X/HevWWvrmqTZPBrIjtcoiq
 ThD0/DKb4YobF+6SOj0PdIYtZBId6IYIhRTf8V50U8vvDKRoX/BD1AqPPQpl3R3bo5KM
 dV4M4HRhD7BafhjsXr0sFnfvHBAk6N2ImtGnLwW2C8nBShQO+UqF3/6/2zXHsIYikZjD
 7nw8jHDMuNa/p0ivfsb46WeU8BnGedeyykFq2fonoqKIDeAyR8C4AOwd6yT6EqTrdOoG
 QYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748432; x=1777353232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km6yAkhjFVi62a1pEJuX+ckhQ7qaid3prVVIo0un0Bs=;
 b=bpx5qO5SPticY3ASmSH8pxk2DPntmoXL6tEn/nR8DjN3ldkHA5Euwim3oTJMW4x+Nc
 WRUhn/fuQ9vPd21FW/6iVKFRIQQLNpJABEG7MM+9T4R9f1kZRS/Kt93AzadcfudbK7Xx
 CNTIM1ubm83LRK1gC6SxKM899dAWkD6u8PDUHH5INs4ymV0aDejLT1p0d4LA/itX4dY8
 B/gX0oqfRHHi8dXaH6Xq4TdvFNkwqG8WAvjaVeuHEXqc8a+YuMezIA6y+IANS5S2cd5S
 sRL4lc7ulLaZpQuXORp8rVU6BwHgIGlMIBpB0ZTWiBkR1r9EIqbxx14Vs15EAv4WWRMn
 Wh2w==
X-Gm-Message-State: AOJu0YzHOF+Lllpx41n9VVFh77B7gWYIAosRIM6MEBRMMPCkzfJFj9GN
 iOzN6Ahvwnd4bVJ367q0hvF9Jsy+yxLvSB7TSscWwF2Sf2virp8ij4gEoRtB0q3Yp2K+onSEtb7
 MMtVhJIU=
X-Gm-Gg: AeBDievhGlnFIai6Z2ukUUPSSbkqXfO6FwFq7WPZ1QeI5xkSY+Svw81I/a8dsngeF2Z
 C6+uVqwZZUytK3EjD03Gbg3YqSBDT75d5r+5BPmr7CenF1ZP4aMFQqM5V0vdLWkxnip4YdE7Lpq
 dHXO1fNMn/L37tJGDcLTg8ZiwOD1z0uWLp0Fx30satdVgNr0xmnhpYlvRJvCYqmsBfIBIi+7ZIR
 4147qxkKbNwL/IlU/ompDb++QG3bdUucmCawWzyH15ndU7C2ciGRQnHYw9Ud7RBX69/WrRigTwH
 ZChCsPs46jBKLnKnmzRo/kyJfKGdcgqs683r1hrql3B1J6uHADJpARESC3N3G6Xtb/dSweLhmPh
 tsgbdKsxjlrwPLWhZiYMh8dpzVUoCGpiYqyEANLzyp80zk8AcJ/4f+No5aDnoBEAw3r8TRmBom1
 cSCRixygInV0u6HnQJ7IpCNdRiEGcykbcmL7peFNp5
X-Received: by 2002:a17:903:1904:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b5f9f6497dmr199534135ad.30.1776748432220; 
 Mon, 20 Apr 2026 22:13:52 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:13:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 00/37] target/arm: Implement FEAT_FAMINMAX, FEAT_FPMR, FEAT_FP8
Date: Tue, 21 Apr 2026 15:13:09 +1000
Message-ID: <20260421051346.41106-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Implement FEAT_FP8, the 8-bit conversion operations, and two prerequites.

Just now as I was writing the cover letter, I saw that FEAT_LUT is not yet
implemented.  The LUT instructions that I implemented before were just for
SME2, but FEAT_LUT is more that that.  Not really relevant to reviewing the
FP8 stuff, but something else that needs doing before enabling FEAT_FP8 at
the end.

There are lots more FP8 extensions, but this is large enough already.


r~


Richard Henderson (37):
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
  target/arm: Enable FEAT_FP8 for -cpu max

 include/fpu/softfloat.h          |  22 +-
 target/arm/cpregs.h              |   5 +
 target/arm/cpu-features.h        |  60 +++
 target/arm/cpu.h                 |  52 +--
 target/arm/helper-fp8.h          |  14 +
 target/arm/internals.h           |  13 +-
 target/arm/tcg/helper-a64-defs.h |  11 +
 target/arm/tcg/helper-fp8-defs.h |  25 ++
 target/arm/tcg/helper-sme-defs.h |   2 +-
 target/arm/tcg/helper-sve-defs.h |  14 +
 target/arm/tcg/translate-a64.h   |   1 +
 target/arm/tcg/translate.h       |   2 +
 target/arm/tcg/vec_internal.h    |  19 +
 target/arm/vector-type.h         |  44 ++
 fpu/softfloat.c                  |  73 ++-
 target/arm/helper.c              |  43 +-
 target/arm/machine.c             |  20 +
 target/arm/tcg/cpu64.c           |  12 +
 target/arm/tcg/fp8_helper.c      | 742 +++++++++++++++++++++++++++++++
 target/arm/tcg/hflags.c          |  41 ++
 target/arm/tcg/sme_helper.c      |   8 +-
 target/arm/tcg/sve_helper.c      |   8 +
 target/arm/tcg/translate-a64.c   |  94 ++++
 target/arm/tcg/translate-sme.c   |  85 +++-
 target/arm/tcg/translate-sve.c   |  43 ++
 target/arm/tcg/vec_helper64.c    |  51 +++
 docs/system/arm/emulation.rst    |   3 +
 target/arm/cpu-sysregs.h.inc     |   2 +
 target/arm/tcg/a64.decode        |  17 +
 target/arm/tcg/meson.build       |   1 +
 target/arm/tcg/sme.decode        |  28 +-
 target/arm/tcg/sve.decode        |  18 +
 32 files changed, 1495 insertions(+), 78 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 target/arm/vector-type.h
 create mode 100644 target/arm/tcg/fp8_helper.c

-- 
2.43.0


