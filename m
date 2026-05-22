Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E48CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUaT-0004Yb-7d; Fri, 22 May 2026 14:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaP-0004Xz-9B
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaN-0004wM-B3
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso56994375ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474422; x=1780079222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OguH3ODWP2nkZHWzpE24Pyy5ZdCppS9CN9LZkMq+yZA=;
 b=Tz17RRcAbWz9n/U4oMRhotco7RpuhH0c92jkqLEE78+4NB5jZFLhZtjF/s1alAx2dq
 e3SbGLybls9hjR/DxD+6SC2+upO6fqJrqafFVtJJR4dVQN5Lp61Yeu4hXtSRig2TENQp
 Ouck664Ik3KMqiG/XKAB9ZgS3g7gWaqVceAQ2gFqo8/309veAFhq87ZCn6qdODyC2fwd
 DLTWLrgVTpLsCJWKZEK32NCuPKdlpK0TaRjqJh515hg6YUvINoGfpKu4D27Co/H7A0mX
 Z3dfDiPrt7sCr6D5DgzqoJiIpR3LEcYEO9jIqyFPaGbxA2Zbg1Fn93RZVFSODQzFHoty
 f66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474422; x=1780079222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OguH3ODWP2nkZHWzpE24Pyy5ZdCppS9CN9LZkMq+yZA=;
 b=g3pQds2gyz+Jo5IiXhbn02UQ20KO/mhssYpYbFsf/ooFVD+RfWpUH+e28OTmZBP2qL
 FIeNusqjYz70iMXDwVycl8XCdEvToX1pucrFBFjlvwwAD3E6z/NdWovDhrywHMOr7O5K
 Wq1m6vbiM+0oViqdDXB/4AjDqXM7t2O9tg5DCQ2xRxJYGn93L6e3fMxiFRhY8dZq8ddE
 jgzeDnuzXIZoov3DxQlZpFNXtwvYYLfDGQqoRVQPt2PMvmcTr6iWV4nVOdDr6C/z7fmm
 vwd4EP6bhDviVkQCEG9R5gI3STgUo7uzXEd1qJOOXrFkvhevh1Ny49JVsRKNWG3CtUfm
 HOqQ==
X-Gm-Message-State: AOJu0YwOKPWpBqYPPprsT+jVDcWJfZOYivEbtXE51smkGglcEYFAEeDZ
 Z2SrwERVOV0XUt3DCCDDhtxl3WKyd5y3EsJkvwned9dzI7m3d+QbjMdEKIXrJSW6utn+crE4COR
 kDvun
X-Gm-Gg: Acq92OEv85uau1h9Vh/z+uFip0WkHwBziWglgiSsJ5ybD3dnzRfKHakc95nEcSzhBB4
 EkCdI0lVBcPa+UFNLH/8dJCS6QfxNhvkGIVEHElpblyrG7NtOU1QOaGWWT9bq8s4STQAH/GRrJN
 8+Rwertw1xD0eD3S0qKyqbIf3EZbbwKOj/98oZFubZinROXUVWdbgx+eS5Q0eQIwxTgSG3QfRBu
 q019E8IadC0IyNauXd+Xbaep00WR7WoZ8O1d3wUJGZ8xZDtM+cpq4TOqu0SKRi0uRqcUmAlnByP
 cAMds9/sS37Z84fT57S75IBQOwEdbKnskUgmlirCTrT2uE67mFwIoeVuuRTvGcZjn7Fh0nTLXIL
 mBDufJviuvyMtSwtvCeDvJ9nwFuQsHQfOBeJuDEgjMYxlfFJ4AUY3vnzmccmF7J6qI0T+D5vCFq
 Boy27up0Wr1GZURuqCFaQYFk4+Cbvg
X-Received: by 2002:a17:903:2381:b0:2bc:ac76:c1c9 with SMTP id
 d9443c01a7336-2beb05e8633mr51213745ad.16.1779474421610; 
 Fri, 22 May 2026 11:27:01 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/30] fpu patch queue
Date: Fri, 22 May 2026 11:26:28 -0700
Message-ID: <20260522182658.184604-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The following changes since commit f5a2438405d4ae8b62de7c9b39fac0b2155ee544:

  Merge tag 'pull-qapi-2026-05-21' of https://repo.or.cz/qemu/armbru into staging (2026-05-21 09:00:22 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260522

for you to fetch changes up to 512f5147c8722c2caf730d1b5a09dbf36b03da57:

  fpu: Export floatN_minmax (2026-05-22 11:21:37 -0700)

----------------------------------------------------------------
fpu: Export partsN_{scalbn,muladd}
fpu: Export floatN_minmax
fpu: Simplifications to muladd, addsub
fpu: Introduce exp_scalbn
fpu: Introduce FloatExceptionFlags
fpu: Use float_status accessors everywhere
fpu: Compress float_status with bitfields
fpu: Fixes for E4M3 vs NaNs
target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
target/alpha: Use FloatExceptionFlags
target/s390x: Move float{32,64}_s390_divide_to_integer

----------------------------------------------------------------
Richard Henderson (30):
      fpu: Return struct from parts{64,128}_scalbn
      fpu: Reorganize partsN(muladd)
      fpu: Return struct from parts{64,128}_muladd
      fpu: Hoist nan check in partsN_addsub
      fpu: Simplify 0 +/- N case in parts_addsub
      fpu: Use parts64_round_to_int in parts_s390_divide_to_integer
      target/s390x: Move float{32,64}_s390_divide_to_integer
      fpu: Introduce exp_scalbn
      target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
      fpu: Introduce FloatExceptionFlags
      target/alpha: Use FloatExceptionFlags
      fpu: Introduce frac_msb_is_snan
      fpu: Introduce FloatSNaNRule
      fpu: Use {get,set}_float_rounding_mode everywhere
      fpu: Use of {get,set}_floatx80_rounding_precision everywhere
      fpu: Use get_floatx80_behaviour everywhere
      fpu: Use get_float_2nan_prop_rule in partsN_pick_nan
      fpu: Use get_float_3nan_prop_rule in partsN_pick_nan_muladd
      fpu: Use get_float_infzeronan_rule in partsN_pick_nan_muladd
      fpu: Use accessors for tininess_before_rounding
      fpu: Use {get,set}_flush_to_zero everywhere
      fpu: Use accessors for ftz_before_rounding
      fpu: Use {get,set}_flush_inputs_to_zero everywhere
      fpu: Use get_default_nan_mode everywhere
      fpu: Use get_float_default_nan_pattern in partsN_default_nan
      fpu: Add accessors for rebias_{underflow,overflow}
      fpu: Reorg float_status
      fpu: Introduce float_status.e4m3_nan_is_snan
      fpu: Fix NaN encoding for E4M3 in parts64_uncanon
      fpu: Export floatN_minmax

 include/fpu/softfloat-helpers.h |  37 ++--
 include/fpu/softfloat-parts.h   |  12 ++
 include/fpu/softfloat-types.h   |  89 ++++++---
 include/fpu/softfloat.h         | 112 ++++++-----
 target/i386/ops_sse.h           |  24 +--
 target/mips/fpu_helper.h        |   3 +-
 fpu/softfloat.c                 | 422 +++++++++++++---------------------------
 target/alpha/fpu_helper.c       |   8 +-
 target/alpha/helper.c           |   3 +-
 target/alpha/translate.c        |  18 +-
 target/arm/tcg/helper-a64.c     |  12 +-
 target/arm/tcg/vfp_helper.c     |  38 ++--
 target/hexagon/fma_emu.c        |   6 +-
 target/hppa/fpu_helper.c        |   2 +-
 target/i386/tcg/fpu_helper.c    |  65 ++++---
 target/m68k/softfloat.c         | 380 ++++++++++++++++++------------------
 target/mips/msa.c               |   4 +-
 target/ppc/cpu.c                |   4 +-
 target/ppc/fpu_helper.c         |  14 +-
 target/riscv/vector_helper.c    |   6 +-
 target/s390x/tcg/fpu_helper.c   | 139 ++++++++++++-
 target/sh4/cpu.c                |   2 +-
 target/xtensa/cpu.c             |   3 +-
 tests/fp/fp-bench.c             |   6 +-
 tests/fp/fp-test.c              |   6 +-
 fpu/softfloat-parts.c.inc       | 312 +++++++++++++++--------------
 fpu/softfloat-specialize.c.inc  | 117 ++++++-----
 tests/fp/wrap.c.inc             |  12 +-
 28 files changed, 936 insertions(+), 920 deletions(-)

