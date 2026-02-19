Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD7FE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 04:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsvEz-0008Kl-TB; Wed, 18 Feb 2026 23:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvEy-0008KQ-Ey
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:12 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vsvEw-0001Cn-JW
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 23:02:12 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ab232cc803so2156905ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 20:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771473729; x=1772078529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g+k/37VNyM44S8IKpnLIeLYphIGYrb6n3z+1yI/fqF0=;
 b=EbnrHnDwk059TaOP9tp8JOexZ2XpH5a71mv56lIowm3K/3Nm0YM5u85HO/eth/41jd
 VCZSaSnBsaPld8pWHYZAvgjxIdrUwRyRcSlUA1WQ1N7Ma/ONJDNKllECcVC4cnGC3nUd
 cGmnTxKyG+myszeRXniRB1VR/emWojXVO0pTGyFLKD8YCmxGjLdZ2ggZMnnv/tMaeMd7
 mG8QeqK5n0vagtGc4ByJTiYdj66C+gzfCUiyGFcCpjUd3et/GzKHGYfVd7om7So63/e+
 yOswwJ9l2nCvaoOMX+tKu3okRk6j7EHeoRiHQ6594K46Uu9IjidvP0r3124V6KqpsnmX
 lPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771473729; x=1772078529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+k/37VNyM44S8IKpnLIeLYphIGYrb6n3z+1yI/fqF0=;
 b=IqFxcqcv2rnJt2b69MkYymmhgmH3YMjBjKbT5PdLp3EAuQFKSWIeKPPFMFSXV3iFit
 wGXb3KzEcEB8NQD39n9uHYTMTMyu5owUNxOnrzSWtTTM1gr+31NWS4Aw4fvE0p+vgBxl
 Lm/zUmcVnWUo/f3sRkbVYXSLQ1I7VC2L8LVGhic+FHBrtGp0pYlV2iDdVAhNGl+QUjsL
 g/fn89dBt/MtIWKxckEsrh/DmD11gmR3upAgo6kD6YX5dIhTKgI3FuRdr4MKEIQlNcRa
 a7H/9nz5LReFwtlDOQ4PTIKjEihh0UGcUKcGgWFPvSBByPZFQX+dx9FzQjKRCwNJTL3T
 BQ+g==
X-Gm-Message-State: AOJu0YzqsB4GBurkHvv0C6S1gXCoufT9d7GBYieSgiO7y//Atav8dmrn
 FTIVSQMTPXEXU7EwgEsm6Ff7milXq783BEtfWy0ivkGpQ430bBZiDSe3O3t0SoQkMYBq9fnXMUp
 1Hegp
X-Gm-Gg: AZuq6aKig76rODF+V/SG0amns21/9/AT1S0uiwdajrYMun1/CexhKJPz+uL8FaA6RiZ
 tveehtyCrkevV5aZP/bRAHib5xdqVd6M9+0R6Ch1T/q6NcLeFkdso1eG7LgJLqQMP+ezmHqTzVt
 NUhU96NwltwQhYuLMC95PLJb3z3Q6ouVJbsK7IlIbsLbZzf8WPjnfs6r1SwDjcb6Eqri0EWVGP6
 8bSyYRrC68/vEvkYQtnlEMC/F8v+Cik4xrSkc96v0z8tPZyjE4t/6nYSXKpKbXlWVfhyEyYAEdh
 A61Pb2A4sNT3JyyQ97HusKzJYnGrW3uHXw4c7GTEOcoEih6G4NZ+oKr5lhk1GE28Fg7qtUUEKT7
 WAK/dKqHYgjvcM7rd82VZVSBLzQ7dc7bDwERIp4AhnaBRe3SSp3Gqfhcs/hgbQgHTYzOPs2dZws
 xxEw+I9JOXu3LmaAcD9jk3vnoHZk3SzBAHw87oGorBYSVdDy1efY9M2oHDpF9O2FVfMMP/Dtm5X
 HXW8JP3IvNUaOA=
X-Received: by 2002:a17:903:2284:b0:2a9:2ab2:e50d with SMTP id
 d9443c01a7336-2ad17586af9mr127169705ad.51.1771473728472; 
 Wed, 18 Feb 2026 20:02:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a73200asm147636225ad.36.2026.02.18.20.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 20:02:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH v4 00/14] target/arm: single-binary
Date: Wed, 18 Feb 2026 20:01:36 -0800
Message-ID: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

This series continues cleaning target/arm, especially tcg folder.

For now, it contains some cleanups in headers, and it splits helpers per
category, thus removing several usage of TARGET_AARCH64.
First version was simply splitting 32 vs 64-bit helpers, and Richard asked
to split per sub category.

v4
--

- add two patches from Peter removing helper in non-tcg files
  20260216160349.3079657-1-peter.maydell@linaro.org
  This fixes build failure with kvm-only and xen-only builds on aarch64.
  I didn't split helper and gen_helper headers. If that really matters, it can
  be done in v5.

v3
--

- translate.h: missing vaddr replacement
- move tcg_use_softmmu to tcg/tcg-internal.h to avoid duplicating compilation
  units between system and user builds.
- eradicate TARGET_INSN_START_EXTRA_WORDS by calling tcg_gen_insn_start with
  additional 0 parameters if needed.

v2
--

- add missing kvm_enabled() in arm-qmp-cmds.c
- didn't extract arm_wfi for tcg/psci.c. If that's a hard requirement, I can do
  it in next version.
- restricted scope of series to helper headers, so we can validate things one
  step at a time. Series will keep on growing once all patches are reviewed.
- translate.h: use vaddr where appropriate, as asked by Richard.

Peter Maydell (2):
  target/arm: Move TCG-specific code out of debug_helper.c
  target/arm: Don't require helper prototypes in helper.c

Pierrick Bouvier (12):
  target/arm: extract helper-mve.h from helper.h
  target/arm: extract helper-a64.h from helper.h
  target/arm: extract helper-sve.h from helper.h
  target/arm: extract helper-sme.h from helper.h
  tcg: move tcg_use_softmmu to tcg/tcg-internal.h
  target/arm: move exec/helper-* plumbery to helper.h
  target/arm/tcg/psci.c: make compilation unit common
  target/arm/tcg/cpu-v7m.c: make compilation unit common
  target/arm/tcg/vec_helper.c: make compilation unit common
  target/arm/tcg/translate.h: replace target_ulong with vaddr
  target/arm/tcg/translate.h: replace target_long with int64_t
  include/tcg/tcg-op.h: eradicate TARGET_INSN_START_EXTRA_WORDS

 include/tcg/tcg-op-common.h                   |   8 +
 include/tcg/tcg-op.h                          |  29 -
 include/tcg/tcg.h                             |   6 -
 target/alpha/cpu-param.h                      |   2 -
 target/arm/cpu-param.h                        |   7 -
 target/arm/helper-a64.h                       |  14 +
 target/arm/helper-mve.h                       |  14 +
 target/arm/helper-sme.h                       |  14 +
 target/arm/helper-sve.h                       |  14 +
 target/arm/helper.h                           |  17 +-
 .../tcg/{helper-a64.h => helper-a64-defs.h}   |   0
 target/arm/tcg/{helper.h => helper-defs.h}    |   0
 .../tcg/{helper-mve.h => helper-mve-defs.h}   |   0
 .../tcg/{helper-sme.h => helper-sme-defs.h}   |   0
 .../tcg/{helper-sve.h => helper-sve-defs.h}   |   0
 target/arm/tcg/translate-a32.h                |   2 +-
 target/arm/tcg/translate.h                    |  22 +-
 target/arm/tcg/vec_internal.h                 |  49 ++
 target/avr/cpu-param.h                        |   2 -
 target/hexagon/cpu-param.h                    |   2 -
 target/hppa/cpu-param.h                       |   2 -
 target/i386/cpu-param.h                       |   2 -
 target/loongarch/cpu-param.h                  |   2 -
 target/m68k/cpu-param.h                       |   2 -
 target/microblaze/cpu-param.h                 |   2 -
 target/mips/cpu-param.h                       |   2 -
 target/or1k/cpu-param.h                       |   2 -
 target/ppc/cpu-param.h                        |   2 -
 target/riscv/cpu-param.h                      |   7 -
 target/rx/cpu-param.h                         |   2 -
 target/s390x/cpu-param.h                      |   2 -
 target/sh4/cpu-param.h                        |   2 -
 target/sparc/cpu-param.h                      |   2 -
 target/tricore/cpu-param.h                    |   2 -
 target/xtensa/cpu-param.h                     |   2 -
 tcg/tcg-internal.h                            |   6 +
 target/alpha/translate.c                      |   4 +-
 target/arm/debug_helper.c                     | 769 -----------------
 target/arm/helper.c                           |   5 +-
 target/arm/tcg/arith_helper.c                 |   4 +-
 target/arm/tcg/crypto_helper.c                |   4 +-
 target/arm/tcg/debug.c                        | 780 ++++++++++++++++++
 target/arm/tcg/gengvec64.c                    |   3 +-
 target/arm/tcg/helper-a64.c                   |   6 +-
 target/arm/tcg/hflags.c                       |   4 +-
 target/arm/tcg/m_helper.c                     |   2 +-
 target/arm/tcg/mte_helper.c                   |   3 +-
 target/arm/tcg/mve_helper.c                   |   6 +-
 target/arm/tcg/neon_helper.c                  |   4 +-
 target/arm/tcg/op_helper.c                    |   2 +-
 target/arm/tcg/pauth_helper.c                 |   3 +-
 target/arm/tcg/psci.c                         |   4 +-
 target/arm/tcg/sme_helper.c                   |   5 +-
 target/arm/tcg/sve_helper.c                   |   6 +-
 target/arm/tcg/tlb_helper.c                   |   4 +-
 target/arm/tcg/translate-a64.c                |   3 +
 target/arm/tcg/translate-mve.c                |   1 +
 target/arm/tcg/translate-sme.c                |   3 +
 target/arm/tcg/translate-sve.c                |   3 +
 target/arm/tcg/translate.c                    |  28 +-
 target/arm/tcg/vec_helper.c                   | 224 +----
 target/arm/tcg/vec_helper64.c                 | 142 ++++
 target/arm/tcg/vfp_helper.c                   |   4 +-
 target/avr/translate.c                        |   2 +-
 target/hexagon/translate.c                    |   2 +-
 target/i386/tcg/translate.c                   |   2 +-
 target/loongarch/tcg/translate.c              |   2 +-
 target/m68k/translate.c                       |   2 +-
 target/microblaze/translate.c                 |   2 +-
 target/or1k/translate.c                       |   2 +-
 target/ppc/translate.c                        |   2 +-
 target/rx/translate.c                         |   2 +-
 target/sh4/translate.c                        |   4 +-
 target/sparc/translate.c                      |   2 +-
 target/tricore/translate.c                    |   2 +-
 target/xtensa/translate.c                     |   2 +-
 tcg/tcg.c                                     |   4 -
 target/arm/tcg/meson.build                    |  13 +-
 78 files changed, 1165 insertions(+), 1149 deletions(-)
 create mode 100644 target/arm/helper-a64.h
 create mode 100644 target/arm/helper-mve.h
 create mode 100644 target/arm/helper-sme.h
 create mode 100644 target/arm/helper-sve.h
 rename target/arm/tcg/{helper-a64.h => helper-a64-defs.h} (100%)
 rename target/arm/tcg/{helper.h => helper-defs.h} (100%)
 rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)
 rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)
 rename target/arm/tcg/{helper-sve.h => helper-sve-defs.h} (100%)
 create mode 100644 target/arm/tcg/debug.c
 create mode 100644 target/arm/tcg/vec_helper64.c

-- 
2.47.3


