Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BB6C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5N-0006P5-8T; Tue, 11 Feb 2025 11:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5H-0006NH-Eq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:03 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5D-00030i-25
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:03 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dc5764fc0so4403886f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291157; x=1739895957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9N7DCto/R1TRAhv/bwrZKREzJ8W3DXVfglrlnEd6kWE=;
 b=h7tibF/eVu5ieAlWN72RYu8WPyOFXzDyDxj1mCZV0BHNoNBEn33Q7O8odzQdbqQkjW
 qhxlDjkj8KRrEe/WJzJ5tU777Y6eLOMb6YEcKBezAVdNC2Vq159UdlNkLRmwyfJl8bES
 rbAD2Q8PHGS41+C9i1PpvC3yKYtzBjncB6jT3crU1IJuSwrj7WNJfGDuZvxRSe6Dl93Z
 YoGlO9vdnClsOARGYT6xBs3ZRxNSMJKfnluoPIbNO1PInDhBqXPH7SqKqc7BKaqwreCB
 zlQheRprG+RDi1wZzPVS4hE9vqI5Bis+v4OMLMMtE66v+WSOftBilDwjia1PFyb6SzZS
 t9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291157; x=1739895957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9N7DCto/R1TRAhv/bwrZKREzJ8W3DXVfglrlnEd6kWE=;
 b=fWROPdShxrlGr1uZfo5T0No4HZ5gRUflOgqz8GV8I/G/aPxzOfhtjo3SbkFxcQ8Ppv
 X0fa0EpaSRV2XdoXi6wk12AZOXJII06HOd/ieUprN2Ek3Zab6Y1IR7uP/b0z4/ixqA6I
 dr8daEQG32n0VBLXEOOzTgG5mh773Bb1nJ6jTLD7eCiKkNLlcT7p0tW6x9E27r6DvogS
 q+IrOgSGBFdYRmgZqNB1hIIHR4xCi7FM9mu+4qhQpkIT6J3DqEh2DWCiJJpPicQoE02c
 YhVAkDGKQ4CYDMf2S3D0bGRkN1QXif+ftSCPfKfdQ4tow3tvBxjSIy3EX4jmDPWHGrol
 /nHw==
X-Gm-Message-State: AOJu0YwAE/J8A5kYy5YnxrQehSidJLsd4YU93ELWqp0IwP7Wra2qGuee
 a4FDPZfbdPVmzaH0DbBmmhuBQG/8abrlFBz0/zTlLdh0F1G1Bf8OZ4skwnbYyJj3vMhCbXxyS32
 p
X-Gm-Gg: ASbGncsD5w9xYr3wQj8NEgMtZOBtvZ57ayAiHQuyO2dZrOTxwnMS1LGFBBhK+7Bn7NE
 Ogr07VN3UIDmV9Rt4F5Z2q7a8MAEk9Co2VkEx6oWjV/zHzaJh9Enbp0mS429iBAn89o8cuSJznV
 zeRsJoHpBbIBpV5zO7M+cz7mDliGDTHRYzF4vZaaEn0nJbRq2+GVF8Q4hUeLgzL7RfNYb5EVRPJ
 z7Y5MjY706G38Z7bpuK1UVuEfL9ku5bWTgxGTBOfm63Zng4vA3ggsuaQ6l4SJ+TlDGtXA4EpYvE
 vv21hpLqRz9B6ZhLX2b6
X-Google-Smtp-Source: AGHT+IHg78OZ3wTeaaGgy7nao3zCUBKIs2x7lxPBDECJhhx6tOgtcyVYdIwwMG41W2GP++XyXb79lQ==
X-Received: by 2002:a5d:59ad:0:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38de9003eb9mr426314f8f.0.1739291156889; 
 Tue, 11 Feb 2025 08:25:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.25.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:25:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/68] target-arm queue
Date: Tue, 11 Feb 2025 16:24:46 +0000
Message-Id: <20250211162554.4135349-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi; this pullreq contains only my FEAT_AFP/FEAT_RPRES patches
(plus a fix for a target/alpha latent bug that would otherwise
be revealed by the fpu changes), because 68 patches is already
longer than I prefer to send in at one time...

thanks
-- PMM

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250211

for you to fetch changes up to ca4c34e07d1388df8e396520b5e7d60883cd3690:

  target/arm: Sink fp_status and fpcr access into do_fmlal* (2025-02-11 16:22:08 +0000)

----------------------------------------------------------------
target-arm queue:
 * target/alpha: Don't corrupt error_code with unknown softfloat flags
 * target/arm: Implement FEAT_AFP and FEAT_RPRES

----------------------------------------------------------------
Peter Maydell (49):
      target/alpha: Don't corrupt error_code with unknown softfloat flags
      fpu: Add float_class_denormal
      fpu: Implement float_flag_input_denormal_used
      fpu: allow flushing of output denormals to be after rounding
      target/arm: Define FPCR AH, FIZ, NEP bits
      target/arm: Implement FPCR.FIZ handling
      target/arm: Adjust FP behaviour for FPCR.AH = 1
      target/arm: Adjust exception flag handling for AH = 1
      target/arm: Add FPCR.AH to tbflags
      target/arm: Set up float_status to use for FPCR.AH=1 behaviour
      target/arm: Use FPST_FPCR_AH for FRECPE, FRECPS, FRECPX, FRSQRTE, FRSQRTS
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

 docs/system/arm/emulation.rst   |   2 +
 include/fpu/softfloat-helpers.h |  11 +
 include/fpu/softfloat-types.h   |  25 ++
 target/arm/cpu-features.h       |  10 +
 target/arm/cpu.h                |  97 +++--
 target/arm/helper.h             |  26 ++
 target/arm/internals.h          |   6 +
 target/arm/tcg/helper-a64.h     |  13 +
 target/arm/tcg/helper-sve.h     | 120 ++++++
 target/arm/tcg/translate-a64.h  |  13 +
 target/arm/tcg/translate.h      |  54 +--
 target/arm/tcg/vec_internal.h   |  35 ++
 target/mips/fpu_helper.h        |   6 +
 fpu/softfloat.c                 |  66 +++-
 target/alpha/cpu.c              |   7 +
 target/alpha/fpu_helper.c       |   2 +
 target/arm/cpu.c                |  46 +--
 target/arm/helper.c             |   2 +-
 target/arm/tcg/cpu64.c          |   2 +
 target/arm/tcg/helper-a64.c     | 151 ++++----
 target/arm/tcg/hflags.c         |  13 +
 target/arm/tcg/mve_helper.c     |  44 +--
 target/arm/tcg/sme_helper.c     |   4 +-
 target/arm/tcg/sve_helper.c     | 367 ++++++++++++++-----
 target/arm/tcg/translate-a64.c  | 782 ++++++++++++++++++++++++++++++++--------
 target/arm/tcg/translate-sve.c  | 193 +++++++---
 target/arm/tcg/vec_helper.c     | 387 ++++++++++++++------
 target/arm/vfp_helper.c         | 374 +++++++++++++++----
 target/hppa/fpu_helper.c        |  11 +
 target/i386/tcg/fpu_helper.c    |   8 +
 target/mips/msa.c               |   9 +
 target/ppc/cpu_init.c           |   3 +
 target/rx/cpu.c                 |   8 +
 target/sh4/cpu.c                |   8 +
 target/tricore/helper.c         |   1 +
 tests/fp/fp-bench.c             |   1 +
 fpu/softfloat-parts.c.inc       | 127 +++++--
 37 files changed, 2325 insertions(+), 709 deletions(-)

