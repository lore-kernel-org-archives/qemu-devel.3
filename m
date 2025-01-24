Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12BDC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYQ-0003ti-Ma; Fri, 24 Jan 2025 11:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMY7-0003ah-JK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMXw-0005L6-Nd
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso15017045e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736119; x=1738340919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=m4yTbDAfs8iCaTC3mSkb2I7MDyFILwuzBVQec5lWumc=;
 b=ABFh6TnuRc22MBWvm4daX7AhzmMe6R+7A76Ac/BwXBCbl1jiZh73P/XRPccFJb6/PI
 8CinOCbpAh9hEtr/rUj5LwF1XVNCuchRzZqHF4IT8yWZTKXEVhZbgxCtcHf8BYciRi5M
 UF8XxExE6aJEY+2c9MdtVZ1y/WF6lVpH1F0HwCpug8cdX2WRp7+wxZzpZ96SS3zBoS6Y
 mwzrPdIHGRhiWogT5bQ1K7p38iJVW7WvpJ27cplye43MbHrjOvrhVHWmITow/rFVGdwS
 27QWNZRbSGFZSP0a+rKDinhIGBfQ/8LIe/V4Q9QW9ypE39lFBzxgyDJyPO+0WYr7b22R
 MMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736119; x=1738340919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4yTbDAfs8iCaTC3mSkb2I7MDyFILwuzBVQec5lWumc=;
 b=HJSzUYXyZ2WqHLu6hE9i3gVY/6DKuD2u0RqqIEpaZV47DmGfygSw2q4216rfYU44xV
 ZMYAsiGaL9qH0olWR9Pwb44W1mBRRn135EHdJL8vOzWFe2549ngjmCADzhSmmu61NGHi
 TMobyz7FFdSrhZUOXLqy6gMyE/zW5Vlhr5kmquyEXk+U2eZ60OkdK4rl28Apn52zd55M
 0WA55bqHOzTW9ivIFwHzIA21PJBFIH2fOXtIshFEiJa/+I0T1gtlYxmq77eLfPflPrbA
 1/iy6rvkpQIR0WPNKbyJxKKpj3BYc5S5+hJdFGe8ER6kVdVp1zpBOQKP0ArXVauFAxWO
 xINQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOFIPKUw0HRoTzyc1ZxrRFRSQzRlfXYxqVcAd6K9Lfssl2TNtiv8/u3gpRhYmIV41flxFib0Ryjgic@nongnu.org
X-Gm-Message-State: AOJu0Yxy0fMBcKtd3fPkmwYLXeu2/nRCKYrxNOlKeriqIC8N6m12TeSk
 ViD3SGN+VuhsV814Oapo45ktv/yvzJTJHlsesvztJX+bFe1EcjjXwPxbmUBkeJptucxCHzKNrs1
 7
X-Gm-Gg: ASbGnct+isae0IJondoeiQURl5rmLJfgrrCza2Mcpm5Qu6xcrVX1xgTVDATybl+Rd3+
 5ij1xvdCECJBNGvig4cIb49ljyDgERpi5dAIVTuaTRaiPwFm7L+OOb/SGXI+qXVmZe4/QgpuAUo
 HQCBLf36qSkuTj00y9nz3T4zmrU65j6va0K5sb1Ok8SpHByks8gqH7ACKoTDIM0okDEnqVeJoaT
 2bgykNzSZvOwSblshy0Fx8e/69i9j47L0Uz/IqwXwKja69eyTftrN+eZAi2vcJfXPMGXSYlCQFM
 LkoF4ch1Mco=
X-Google-Smtp-Source: AGHT+IGDiTS6wt82jLEegIIKbb93QjQREYpQNPjBDwjqwoWVSbNxo5SCHUWAYMrbsncLY/kZ67mbdg==
X-Received: by 2002:a05:600c:1c93:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-43891429c77mr262015145e9.24.1737736118943; 
 Fri, 24 Jan 2025 08:28:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/76] target/arm: Implement FEAT_AFP and FEAT_RPRES
Date: Fri, 24 Jan 2025 16:27:20 +0000
Message-Id: <20250124162836.2332150-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This patchset implements emulation of the Arm FEAT_AFP and FEAT_RPRES
extensions, which are floating-point related. It's based on the
small i386 bugfix series I sent out a while back:

Based-on: 20250116112536.4117889-1-peter.maydell@linaro.org
("target/i386: Fix 0 * Inf + QNaN regression")

(It would also have been based on an initial refactoring series
I sent out on Monday, but AFAICT the list just ate those emails
and they never arrived anywhere :-(  So you get a bigger series
here than I'd hoped.)

If you'd rather have these patches as a git branch:
 https://git.linaro.org/people/pmaydell/qemu-arm.git  feat-afp
with human readable web view at:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=feat-afp


FEAT_AFP defines three new control bits in the FPCR, whose
operations are basically independent of each other:
 * FPCR.AH: "alternate floating point mode"; this changes floating
   point behaviour in a variety of ways, including:
    - the sign of a default NaN is 1, not 0
    - if FPCR.FZ is also 1, denormals detected after rounding
      with an unbounded exponent has been applied are flushed to zero
    - FPCR.FZ does not cause denormalized inputs to be flushed to zero
    - miscellaneous other corner-case behaviour changes
 * FPCR.FIZ: flush denormalized numbers to zero on input for
   most instructions
 * FPCR.NEP: makes scalar SIMD operations merge the result with
   higher vector elements in one of the source registers, instead
   of zeroing the higher elements of the destination

FEAT_RPRES makes single-precision FRECPE and FRSQRTE use a 12-bit
mantissa precision instead of 8-bit when FPCR.AH is set.

Because FPCR.AH implies quite a lot of changes to corner cases
of floating point handling, the resulting patchseries is regrettably
quite big.

Structure of the patchseries:
 * patch 1 fixes a silly bug in arm_reset_sve_state() which only
   has a major bad effect once FEAT_AFP is implemented
 * patches 2-16 are a refactoring which splits the existing
   fp_status and fp_status_f16 so that each have separate a32 and
   a64 versions. We need this because the FEAT_AFP bits only have
   an effect for A64 insns, not A32 insns
 * patches 17-22 add some more functionality to softfloat that we
   need for FEAT_AFP:
    - an exception flag float_flag_input_denormal_used is set when
      an input to an fp op is denormal, is not squashed to zero,
      and is actually consumed (i.e. not an invalid operation or
      an operation where the other input was a NaN)
    - a control setting float_detect_ftz which lets the target
      control whether flush-to-zero of outputs should be done
      before or after rounding
   (Both these are needed for correct x86 FP emulation, incidentally.)
 * patches 23-28 define the FPCR bits and implement the parts of the
   functionality which can be handled by setting softfloat control
   knobs and adjusting how we handle softfloat exception flags.
   (This includes all of the FPCR.FIZ behaviour.)
 * patches 29-33 implement FPCR.AH handling of a small group of
   insns (FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS, BFCVT*, BFMLAL*,
   BFMLSL*) which must:
    - never update FPSR exception flags
    - always round-to-nearest-even
    - always flush single and double denormal inputs and outputs to zero
   We implement this via some new float_status fields that we use for
   this group of insns.
 * patches 34-42 implement the FPCR.NEP "merge high vector elements of
   a source register with  the result of a scalar operation" behaviour
 * patches 43-49 implement FPCR.AH semantics for FMIN and FMAX:
    - comparing two zeroes (even of different sign) or comparing a NaN
      with anything always returns the second argument (possibly
      squashed to zero)
    - denormal outputs are not squashed to zero regardless of FZ or FZ16
 * patches 50-65 implement FPCR.AH semantics for abs and neg of floating
   point values: they must not change the sign bit of a NaN. This applies
   not just to the ABS and NEG insns but to any other insn whose
   pseudocode has it doing an FPAbs() or FPNeg() operation (e.g.
   FMLS, FRECPS, FTSSEL).
 * at this point patch 66 can enable FEAT_AFP for -cpu max
 * patches 67-70 implement FEAT_RPRES

I have also some patchs which make target/i386 use the "detect
flush to zero after rounding" and "report when input denormal is
consumed" softfloat features added here; I don't include them in
this patchset (though you can find them in that git branch I
mentioned earlier) becaus I haven't done as much testing on the
i386 side and in any case this patchset is already pretty long.
I expect I'll send them out when this series has been merged.


thanks
-- PMM


Peter Maydell (76):
  target/i386: Do not raise Invalid for 0 * Inf + QNaN
  tests/tcg/x86_64/fma: Test some x86 fused-multiply-add cases
  target/arm: arm_reset_sve_state() should set FPSR, not FPCR
  target/arm: Use FPSR_ constants in vfp_exceptbits_from_host()
  target/arm: Use uint32_t in vfp_exceptbits_from_host()
  target/arm: Define new fp_status_a32 and fp_status_a64
  target/arm: Use vfp.fp_status_a64 in A64-only helper functions
  target/arm: Use fp_status_a32 in vjvct helper
  target/arm: Use fp_status_a32 in vfp_cmp helpers
  target/arm: Use FPST_FPCR_A32 in A32 decoder
  target/arm: Use FPST_FPCR_A64 in A64 decoder
  target/arm: Remove now-unused vfp.fp_status and FPST_FPCR
  target/arm: Define new fp_status_f16_a32 and fp_status_f16_a64
  target/arm: Use fp_status_f16_a32 in AArch32-only helpers
  target/arm: Use fp_status_f16_a64 in AArch64-only helpers
  target/arm: Use FPST_FPCR_F16_A32 in A32 decoder
  target/arm: Use FPST_FPCR_F16_A64 in A64 decoder
  target/arm: Remove now-unused vfp.fp_status_f16 and FPST_FPCR_F16
  fpu: Rename float_flag_input_denormal to
    float_flag_input_denormal_flushed
  fpu: Rename float_flag_output_denormal to
    float_flag_output_denormal_flushed
  fpu: Fix a comment in softfloat-types.h
  fpu: Add float_class_denormal
  fpu: Implement float_flag_input_denormal_used
  fpu: allow flushing of output denormals to be after rounding
  target/arm: Remove redundant advsimd float16 helpers
  target/arm: Use FPST_FPCR_F16_A64 for halfprec-to-other conversions
  target/arm: Define FPCR AH, FIZ, NEP bits
  target/arm: Implement FPCR.FIZ handling
  target/arm: Adjust FP behaviour for FPCR.AH = 1
  target/arm: Adjust exception flag handling for AH = 1
  target/arm: Add FPCR.AH to tbflags
  target/arm: Set up float_status to use for FPCR.AH=1 behaviour
  target/arm: Use FPST_FPCR_AH for FRECPE, FRECPS, FRECPX, FRSQRTE,
    FRSQRTS
  target/arm: Use FPST_FPCR_AH for BFCVT* insns
  target/arm: Use FPST_FPCR_AH for BFMLAL*, BFMLSL* insns
  target/arm: Add FPCR.NEP to TBFLAGS
  target/arm: Define and use new write_fp_*reg_merging() functions
  target/arm: Handle FPCR.NEP for 3-input scalar operations
  target/arm: Handle FPCR.NEP for BFCVT scalar
  target/arm: Handle FPCR.NEP for 1-input scalar operations
  target/arm: Handle FPCR.NEP in do_cvtf_scalar()
  target/arm: Handle FPCR.NEP for scalar FABS and FNEG
  target/arm: Handle FPCR.NEP for FCVTXN (scalar)
  target/arm: Handle FPCR.NEP for NEP for FMUL, FMULX scalar by element
  target/arm: Implement FPCR.AH semantics for scalar FMIN/FMAX
  target/arm: Implement FPCR.AH semantics for vector FMIN/FMAX
  target/arm: Implement FPCR.AH semantics for FMAXV and FMINV
  target/arm: Implement FPCR.AH semantics for FMINP and FMAXP
  target/arm: Implement FPCR.AH semantics for SVE FMAXV and FMINV
  target/arm: Implement FPCR.AH semantics for SVE FMIN/FMAX immediate
  target/arm: Implement FPCR.AH semantics for SVE FMIN/FMAX vector
  target/arm: Implement FPCR.AH handling of negation of NaN
  target/arm: Implement FPCR.AH handling for scalar FABS and FABD
  target/arm: Handle FPCR.AH in vector FABD
  target/arm: Handle FPCR.AH in SVE FNEG
  target/arm: Handle FPCR.AH in SVE FABS
  target/arm: Handle FPCR.AH in SVE FABD
  target/arm: Handle FPCR.AH in negation steps in FCADD
  target/arm: Handle FPCR.AH in negation steps in SVE FCADD
  target/arm: Handle FPCR.AH in FMLSL
  target/arm: Handle FPCR.AH in FRECPS and FRSQRTS scalar insns
  target/arm: Handle FPCR.AH in FRECPS and FRSQRTS vector insns
  target/arm: Handle FPCR.AH in negation step in FMLS (indexed)
  target/arm: Handle FPCR.AH in negation in FMLS (vector)
  target/arm: Handle FPCR.AH in negation step in SVE FMLS (vector)
  target/arm: Handle FPCR.AH in SVE FTSSEL
  target/arm: Handle FPCR.AH in SVE FTMAD
  target/arm: Enable FEAT_AFP for '-cpu max'
  target/arm: Plumb FEAT_RPRES frecpe and frsqrte through to new helper
  target/arm: Implement increased precision FRECPE
  target/arm: Implement increased precision FRSQRTE
  target/arm: Enable FEAT_RPRES for -cpu max
  target/i386: Detect flush-to-zero after rounding
  target/i386: Use correct type for get_float_exception_flags() values
  target/i386: Wire up MXCSR.DE and FPUS.DE correctly
  tests/tcg/x86_64/fma: add test for exact-denormal output

 docs/system/arm/emulation.rst    |   2 +
 include/fpu/softfloat-helpers.h  |  11 +
 include/fpu/softfloat-types.h    |  51 +-
 target/arm/cpu-features.h        |  10 +
 target/arm/cpu.h                 |  32 +-
 target/arm/helper.h              |  12 +
 target/arm/internals.h           |   6 +
 target/arm/tcg/helper-a64.h      |  21 +-
 target/arm/tcg/helper-sve.h      | 120 +++++
 target/arm/tcg/translate.h       |  63 ++-
 target/i386/ops_sse.h            |  16 +-
 target/mips/fpu_helper.h         |   6 +
 fpu/softfloat.c                  |  71 ++-
 target/alpha/cpu.c               |   7 +
 target/arm/cpu.c                 |  32 +-
 target/arm/helper.c              |   4 +-
 target/arm/tcg/cpu64.c           |   2 +
 target/arm/tcg/helper-a64.c      | 173 ++++---
 target/arm/tcg/hflags.c          |  13 +
 target/arm/tcg/sme_helper.c      |   6 +-
 target/arm/tcg/sve_helper.c      | 301 ++++++++---
 target/arm/tcg/translate-a64.c   | 850 ++++++++++++++++++++++++-------
 target/arm/tcg/translate-sme.c   |   4 +-
 target/arm/tcg/translate-sve.c   | 280 ++++++----
 target/arm/tcg/translate-vfp.c   |  78 +--
 target/arm/tcg/vec_helper.c      | 174 ++++++-
 target/arm/vfp_helper.c          | 369 +++++++++++---
 target/hppa/fpu_helper.c         |  11 +
 target/i386/tcg/fpu_helper.c     | 110 ++--
 target/m68k/fpu_helper.c         |   2 +-
 target/mips/msa.c                |   9 +
 target/mips/tcg/msa_helper.c     |   4 +-
 target/ppc/cpu_init.c            |   3 +
 target/rx/cpu.c                  |   8 +
 target/rx/op_helper.c            |   4 +-
 target/sh4/cpu.c                 |   8 +
 target/tricore/fpu_helper.c      |   6 +-
 target/tricore/helper.c          |   1 +
 tests/fp/fp-bench.c              |   1 +
 tests/tcg/x86_64/fma.c           | 116 +++++
 fpu/softfloat-parts.c.inc        | 136 ++++-
 tests/tcg/x86_64/Makefile.target |   1 +
 42 files changed, 2443 insertions(+), 691 deletions(-)
 create mode 100644 tests/tcg/x86_64/fma.c

-- 
2.34.1


