Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9252FC02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGXd-0005wf-VZ; Sat, 01 Feb 2025 11:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXc-0005wM-Bu
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:20 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXa-00011W-4A
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso31074665e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428016; x=1739032816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VeJ7SEhgewX+In8e+Fd9CTGEg1cGsHs5t+QGi9HKAY8=;
 b=iiOyT/ZTedGNiQRDaJBaHhO6ZNugMe2FhhzOGtUHMz+4ys1Z0kMRplgxuSlPyQ1Pyy
 8x8X0ULObt62pupW2KXPczi7Ur9KH3E+o9MC0AKZXPf5qJhu9K/nILbu4Tb/B2AtE0eq
 X/XeqiaqGNY+naDs6XRV6Dxz9QJY5b9jXHItQL2bsIH5358om9neBoO0SE1hRat+0IgA
 aD+urZcosC6wq1t8pPmpgKhSykreBfapf+zBsglWLuwlTLmjidbvPqzHEHzJT1IngICy
 Qv9WP2c/rXxCxup7WtKIli8c2nuz1Ql2O3up563Y56Wwhqz8fIdHymSYwdebBaA7XKlD
 MetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428016; x=1739032816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VeJ7SEhgewX+In8e+Fd9CTGEg1cGsHs5t+QGi9HKAY8=;
 b=A14pGMlFjdnktLDq/ZS5XRJff2138HC3Z8PVKCSzpSQQ5D2aJAkvoh/KIdTaiyoHlq
 Ug/DCirsFw90FnJEn05vXQ3TyOKShLrswCmgjwLQ7BtkVXCnJOJUNEydTeIuuD1ZDqiT
 Lass92WWvJI1eZg23uNa1A7At0Kanvx1ZFcfc8t78GsBiH5cLLGNsRtVh5fkMaHOBvaL
 kLppjp7FWRjotnYRJBWlCIkB9v9YnmkKcHSX4sT1+oBzsjXKqEEA4OVLKidXWREoIn9R
 nmqI6fG4yBApDgI/RJ0eESSO/ssD6svanNgXWYuUoyipL1GwZG5wdmcODhrbWivbMP0e
 iXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4IWQ8KEj3+j73xCTDTAqNzyYXnmjaKbaIjjCnxLEVf7anDSce/XC+nY30SZArYVSSRAioC0Wx4FMf@nongnu.org
X-Gm-Message-State: AOJu0Yzyxkauk3poYvP3evT+KSaM3YkhSKAL28Ta/Ak9vyKViyhkuK0w
 8qHg1hYygWQcLFfPDEDAbZgGF8aFZox+maNMuRh+wMDG85Er+eKT4fAOX2mcOw9JNrC2vMtgUPX
 v
X-Gm-Gg: ASbGncvf1NLM8XPykXvVReXeU9QyBDVOjfjve+kqlU4yLe2DItpAlip46zDUVxnIL9J
 E4L5QXw+E24FANDPCfCYcLLxhH3l9CNqLTyhuHyjPiAruGg/Rjm4Csq5Wh5ygaqXNIqWHrUWf22
 yproZhld6zwGP9+E/euEhwoP9m4jxNpdDP9QyzUZi7loOAVlY0xq+FySsMn91OGslQTfSlT+uQ8
 rJSoF3Rsgj50eW4CHfTsZEVjL3pegofocNN67WFQpjYvC+u0hwQwcFruhekTau4PBC6AShJQ8Ho
 m31xJW4zAiRS3rAWkrbE
X-Google-Smtp-Source: AGHT+IFHe3Pw9Y6Nbou71OskMVZCHnZNJYyIex2BG3cFJncYUH/KOcUH7x/VRaFQL5OIzIM1K4XUSg==
X-Received: by 2002:a05:600c:3c88:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438dc3c2992mr171453985e9.11.1738428015675; 
 Sat, 01 Feb 2025 08:40:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/69] target/arm: FEAT_AFP and FEAT_RPRES
Date: Sat,  1 Feb 2025 16:39:03 +0000
Message-Id: <20250201164012.1660228-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

This patchset implements emulation of the Arm FEAT_AFP and FEAT_RPRES
extensions, which are floating-point related. (Summary of what
these are exactly is at the bottom of the cover letter.)

If you'd rather have these patches as a git branch:
 https://git.linaro.org/people/pmaydell/qemu-arm.git  feat-afp
with human readable web view at:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=feat-afp
  
Changes between v1 and v2:
 * first part of the series has been upstreamed
 * I've left the first two x86 patches in here, just to avoid having
   to use a Based-on: tag. They've both been taken by Paolo already,
   they just haven't landed upstream yet.
 * the tail-end patches fixing x86 denormal support are not posted
   here (indeed I didn't mean to send them in v1!); I'll send those
   separately once the underlying softfloat patches are upstream
 * the renaming of the FPST_ constants (already upstream) is
   carried through into these patches
 * name changes in the "allow flushing of output denormals to be
   after rounding" patch:
   now set_float_ftz_detection(), get_float_ftz_detection(),
   float_ftz_after_rounding and float_ftz_before_rounding
 * moved select_fpst to translate-a64.h and renamed to select_ah_fpst
 * use vec_full_reg_offset() in the write_fp_*reg_merging fns
 * drop no-longer-nedeed float*_input_flush2() calls in the
   float*_hs_compare() fns in "implement float_flag_input_denormal_used"
 * adopted RTH's patchset, by a mix of merging in fixes to my
   patches and adding his (partly on the end, and partly sorted
   into the series at appropriate places). I updated commit messages
   in a few places (notably standardising them onto "Handle X for
   <some insn>" rather than "for <some QEMU function>")

Patches that still need review:
04 fpu: Implement float_flag_input_denormal_used
05 fpu: allow flushing of output denormals to be after rounding
06 target/arm: Define FPCR AH, FIZ, NEP bits

RTH: I kept your r-by tags on the patches where I squashed
in your fixes from your followup series (mostly this is the
changes to use the muladd flags). If you want to re-review
to check that I did the squashing right, those are patches:

37 target/arm: Handle FPCR.AH in negation steps in SVE FCADD
38 target/arm: Handle FPCR.AH in negation steps in FCADD
41 target/arm: Handle FPCR.AH in negation step in FMLS (indexed)
42 target/arm: Handle FPCR.AH in negation in FMLS (vector)
43 target/arm: Handle FPCR.AH in negation step in SVE FMLS (vector)
44 target/arm: Handle FPCR.AH in SVE FTSSEL
45 target/arm: Handle FPCR.AH in SVE FTMAD

Summary of what FEAT_AFP/FEAT_RPRES are, from v1 cover letter:

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

thanks
-- PMM

Peter Maydell (50):
  target/i386: Do not raise Invalid for 0 * Inf + QNaN
  tests/tcg/x86_64/fma: Test some x86 fused-multiply-add cases
  fpu: Add float_class_denormal
  fpu: Implement float_flag_input_denormal_used
  fpu: allow flushing of output denormals to be after rounding
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
  target/arm: Handle FPCR.AH in negation steps in SVE FCADD
  target/arm: Handle FPCR.AH in negation steps in FCADD
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

Richard Henderson (19):
  target/arm: Handle FPCR.AH in vector FCMLA
  target/arm: Handle FPCR.AH in FCMLA by index
  target/arm: Handle FPCR.AH in SVE FCMLA
  target/arm: Handle FPCR.AH in FMLSL (by element and vector)
  target/arm: Handle FPCR.AH in SVE FMLSL (indexed)
  target/arm: Handle FPCR.AH in SVE FMLSLB, FMLSLT (vectors)
  target/arm: Introduce CPUARMState.vfp.fp_status[]
  target/arm: Remove standard_fp_status_f16
  target/arm: Remove standard_fp_status
  target/arm: Remove ah_fp_status_f16
  target/arm: Remove ah_fp_status
  target/arm: Remove fp_status_f16_a64
  target/arm: Remove fp_status_f16_a32
  target/arm: Remove fp_status_a64
  target/arm: Remove fp_status_a32
  target/arm: Simplify fp_status indexing in mve_helper.c
  target/arm: Simplify DO_VFP_cmp in vfp_helper.c
  target/arm: Read fz16 from env->vfp.fpcr
  target/arm: Sink fp_status and fpcr access into do_fmlal*

 docs/system/arm/emulation.rst    |   2 +
 include/fpu/softfloat-helpers.h  |  11 +
 include/fpu/softfloat-types.h    |  41 +-
 target/arm/cpu-features.h        |  10 +
 target/arm/cpu.h                 |  97 ++--
 target/arm/helper.h              |  26 +
 target/arm/internals.h           |   6 +
 target/arm/tcg/helper-a64.h      |  13 +
 target/arm/tcg/helper-sve.h      | 120 +++++
 target/arm/tcg/translate-a64.h   |  13 +
 target/arm/tcg/translate.h       |  54 +--
 target/arm/tcg/vec_internal.h    |  35 ++
 target/mips/fpu_helper.h         |   6 +
 fpu/softfloat.c                  |  66 ++-
 target/alpha/cpu.c               |   7 +
 target/arm/cpu.c                 |  46 +-
 target/arm/helper.c              |   2 +-
 target/arm/tcg/cpu64.c           |   2 +
 target/arm/tcg/helper-a64.c      | 151 +++---
 target/arm/tcg/hflags.c          |  13 +
 target/arm/tcg/mve_helper.c      |  44 +-
 target/arm/tcg/sme_helper.c      |   4 +-
 target/arm/tcg/sve_helper.c      | 367 +++++++++++----
 target/arm/tcg/translate-a64.c   | 782 +++++++++++++++++++++++++------
 target/arm/tcg/translate-sve.c   | 193 ++++++--
 target/arm/tcg/vec_helper.c      | 387 ++++++++++-----
 target/arm/vfp_helper.c          | 372 ++++++++++++---
 target/hppa/fpu_helper.c         |  11 +
 target/i386/tcg/fpu_helper.c     |  13 +-
 target/mips/msa.c                |   9 +
 target/ppc/cpu_init.c            |   3 +
 target/rx/cpu.c                  |   8 +
 target/sh4/cpu.c                 |   8 +
 target/tricore/helper.c          |   1 +
 tests/fp/fp-bench.c              |   1 +
 tests/tcg/x86_64/fma.c           | 109 +++++
 fpu/softfloat-parts.c.inc        | 132 +++++-
 tests/tcg/x86_64/Makefile.target |   1 +
 38 files changed, 2452 insertions(+), 714 deletions(-)
 create mode 100644 tests/tcg/x86_64/fma.c

-- 
2.34.1


