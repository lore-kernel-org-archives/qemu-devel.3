Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8A0CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHa-0004jr-1a; Mon, 11 May 2026 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHP-0004h2-Db
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:59 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHL-0002fB-Km
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:22:58 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47c7b282e21so1821572b6e.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523771; x=1779128571; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z3ureWKoOMlDqw9gE+YexbrlvEarMsLoY94URwwMm1Y=;
 b=GAY5+YkBeGOiEH1xHjZvpm+duh38u68cGWy/fmoEXbc8mv0BZoJweiFjQo4MloO1jf
 oZnTjAb1bbiVH0QMVidqhWrwWSQ93vdpCCrMsT5hItglbq6pvX9QmTOGZpOHowQldZQH
 UjXZpW9eyAPW46xCxOwSMvnm8/oICnuJllGKRM9zAKGRhpZlH7dO39zOwbTWhH+/kgFa
 Yt9zWedKwdjhi0I+ngUXrIXaWeZgC2cPKB4Rly448emtqRmtkKWNE8EQ18xCmfcMpKhU
 ngvkQc/dzEEZ/rzNt41tsUuCT/N/eNu0HPEhW1Zrxoi7jb5N1PPubIOwimc6OwGa6QoO
 ywQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523771; x=1779128571;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3ureWKoOMlDqw9gE+YexbrlvEarMsLoY94URwwMm1Y=;
 b=lFCkkXSKc6dHfKh+foSooUaqpzSJWdwKyvCqurAeQ1FLb5yt0IemO4j8dj8N0WCjjR
 VpZ3j9ONlvnMjHzOuROXRs1ZyKHQBqcv7PEAMYcKGh2x9YSYiGL+/a9t3+Io8VIcZn/1
 cHFmyq0zH8+Zpl9abWxMJ82VmH2kib+e6Sy110llyTy8rLVN17ROW1jTxFLehgqVCh7d
 ba/BNlvKCTaFdFeFhRTcnA9y9qyFef7FlS9DkW5iMaD4Wbmqt/RQjVN+ienArxEKFtgo
 NvubwpoybbHQ6TXAMG6z751bZ4BbNbmuHrvSSLeXMASxDH9vzb7mYi6CGejkL0K94T02
 7Hug==
X-Gm-Message-State: AOJu0YyFFedOjPySLHNBV8toH7PtgCXVgVQp1ZqArqRsE5Z5Qep4UNlB
 OJnHxxvnfCU8mvzWvenqhU6FwmAxxLA/hFhIw8D3lAsDoM+FC6gggFam
X-Gm-Gg: Acq92OHf1cgDZHtJL7aBXXHu2lK07zut4gitePgRrTquFa2dvzQKBjdKOoejQo/N/ZD
 urz4QQ76QkkEhkNWcswhsbLKDecCyzCIWbmI+jNvzgotaDSt57y/CN/xM6cPNBOAqRXrfIaR7Dz
 NrsipS1fZKudTQLghiPEbj1qSz5rijS2xcIozYekCdHZu98h63mLuvBxO1TCaWXjnzoIgTGtpe4
 hslqfkbpH+s2UETo5OuNPEmUtFBk0mt7Ab+aZaAH0GqyGZsS8LarBLm18bQCdZDznVrX0W9Cjx/
 F055yWRP3TRpyA48yIbutpcR1+guuKQsaXDarydrgOitKWLpJOTF0IT6KM5EQC/JH30JjUvYkif
 fgea1ta9fufgC77bY6UNqJXyvzUK20qsmGt8aURsjZxcceQAP+W9jll+BQ/lsP9LaRqiuXrt0CE
 9WGM7VF96+VRiL77CBejOYxumSreAac9YdYc0a3Rnd9h9mrGr7qh6dG96NJgA56Y3uQZs9AzCnH
 e7awW6eYiN5fATsReMbijZecOPZSsMOtu103dV1MUsFeEmyQVPprMpKP8PhmuAAUSF4
X-Received: by 2002:a05:6809:2d0:20b0:482:6b8a:33a6 with SMTP id
 5614622812f47-4826b8a34e6mr2823192b6e.23.1778523771289; 
 Mon, 11 May 2026 11:22:51 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v6 00/35] target/mips: add missing Octeon user-mode support
Date: Mon, 11 May 2026 12:22:31 -0600
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwWrDMAwG4FcpPs/DdmIn3mnvMXZIZCdVWewSZ
 Waj5N1nd4yFFhrQQT+I7wddGPkZPbGXw4XNPiFhDDmYpwODYxdGz9HlzJRQRtRK8AnPxCMsPoa
 8E2EYOQYKxJPi2htbNY2AQQHLxHn2A35d+bf330yf/cnDUsxycURa4vx97U+q3P1VycdVeQTvR
 GOlG2Tbgn0dpw4/niFOrFSl6h/Tot3Bqoz10HuwptKNu8PqLWZ3sDpjzhjrwAkNarjF9AaTOx9
 NumDaKWNaJ3XXb7F1XX8A3hq5MsEBAAA=
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series updates MIPS linux-user unaligned-access behavior and fills
in missing Octeon user-mode instruction support used by existing Octeon
binaries.

The first patches model the Linux/MIPS sysmips ABI pieces needed by
linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
MIPS_FIXADE policy used to control unaligned scalar access fixups.
User-mode unaligned scalar accesses default to software fixups and
sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.

The Octeon patches add integer, indexed memory, atomic, fixed-point
QMAC, multiplier, COP2 crypto, CHORD, LLM, and CvmCount RDHWR support.
The series also adds a small mips64/mips64el TCG guest test covering
representative Octeon integer, fixed-point, multiplier, RDHWR, and COP2
selector paths. The final patch corrects the Octeon68XX CP1 feature
bits and FCR defaults.

Changes since v1:
- Split BADDU/DMUL destination fixes into a separate patch.
- Split the SEQ/SNE decode refactoring into a separate patch.
- Moved Octeon multiplier state to uint64_t arrays and updated VMState.
- Switched Octeon helper ABIs to i64/uint64_t where applicable.
- Moved COP2 selector decode/support logic into octeon_translate.c.
- Added in-tree TCG tests for mips64 and mips64el linux-user.
- Used switch ranges and g_assert_not_reached() for SHA3/ZUC shared
  selector handling.
- Dropped Octeon prefixes from generic Camellia helper routines.
- Replaced the reflected GFM 64-bit carryless multiply loop with
  crypto/clmul.h.
- Moved the Octeon68XX CP1 CPU-model correction to the end of the
  series.
- Added migration coverage for Octeon COP2 crypto and LLM sparse state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v6:
- Added Octeon QMAC/QMACS fixed-point accumulator support and smoke
  coverage.
- Added Octeon RDHWR $31/CvmCount support and smoke coverage.
- Clarified MTM0/VMM0 deterministic handling of architecturally
  unpredictable multiplier lanes.
- Fixed MTP0 to zero P1 per the CN71XX register-state table and added
  smoke coverage.
- Fixed VMM0 to apply the full MTM0-style multiplier-state reset and
  added smoke coverage for MPL1.
- Cleaned up internal VMUL, LA*, COP2 payload/state, and COP2 selector
  naming to better match hardware register/selector terminology.
- Renamed the MIPS_FIXADE TB flag, HSH register word-packing helpers,
  and sparse LLM backing fields to match ABI and hardware terminology.
- Link to v5: https://lore.kernel.org/qemu-devel/20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com

Changes in v5:
- Added Richard Henderson's Reviewed-by tags for LBX, LHUX, LWUX, SAA,
  and SAAD, plus Acked-by tags for ZCB and ZCBT.
- Dropped the separate Octeon+ feature bit; QEMU has a single Octeon CPU
  model today, so SAA/SAAD stay under the existing Octeon feature bucket.
- Folded ZCBT into the ZCB decodetree entry with a selector comment.
- Link to v4: https://lore.kernel.org/qemu-devel/20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com

Changes in v4:
- Added Richard Henderson's Reviewed-by tags to the reviewed sysmips and
  Octeon translator cleanup patches.
- Kept the Octeon3 MPL3-MPL5/P3-P5 high-lane multiplier state
  documented by Cavium SDK/toolchain sources.
- Documented the Octeon3 two-source MTM/MTP forms and preserved the rt
  high-lane operands while legacy one-source encodings use rt == $zero.
- Simplified SAA/SAAD translation to use the i64 TCG atomic add path for
  both word and doubleword sizes.
- Marked SAA/SAAD as Octeon+ instructions and gated them behind a
  separate Octeon+ feature bit.
- Simplified LA* translation to use i64 TCG atomic helpers for word and
  doubleword operations, with MO_SL selecting word result sign-extension.
- Link to v3: https://lore.kernel.org/qemu-devel/20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com

Changes in v3:
- Rebased on current qemu.git master.
- Split sysmips support into separate MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET,
  and MIPS_FIXADE patches.
- Made MIPS_ATOMIC_SET always use the MIPS separate error-result register
  path for successful returns.
- Removed redundant Octeon MIPS64 checks and target-long guards from the
  translator paths.
- Removed zero-register fast paths where gen_store_gpr() already handles
  discarded writes.
- Reworked SEQ/SNE decode and LA* translator helpers as requested.
- Split the Octeon arithmetic/memory patch into narrower state, indexed
  load, SAA/SAAD, ZCB, multiplier, and test patches.
- Switched Octeon multiplier limb accumulation to uadd64_overflow().
- Link to v2: https://lore.kernel.org/qemu-devel/20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com

To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>

---
James Hilliard (35):
      linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
      linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: split Octeon SEQ/SNE decode
      target/mips: drop Octeon zero-register fast paths
      target/mips: add Octeon multiplier state
      target/mips: add Octeon LBX instruction
      target/mips: add Octeon LHUX instruction
      target/mips: add Octeon LWUX instruction
      target/mips: add Octeon SAA instruction
      target/mips: add Octeon SAAD instruction
      target/mips: add Octeon ZCB instruction
      target/mips: add Octeon ZCBT instruction
      target/mips: add Octeon MTM0 instruction
      target/mips: add Octeon MTP0 instruction
      target/mips: add Octeon MTP1 instruction
      target/mips: add Octeon MTP2 instruction
      target/mips: add Octeon MTM1 instruction
      target/mips: add Octeon MTM2 instruction
      target/mips: add Octeon VMULU instruction
      target/mips: add Octeon VMM0 instruction
      target/mips: add Octeon V3MULU instruction
      target/mips: add Octeon QMAC instructions
      tests/tcg/mips: add Octeon instruction smoke test
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto core support
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon QMAC and CvmCount
      target/mips: expose Octeon68XX floating-point support

 MAINTAINERS                                   |    2 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   75 +-
 target/mips/cpu.h                             |  257 +++
 target/mips/helper.h                          |    9 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   51 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  569 +++++-
 target/mips/tcg/op_helper.c                   |  176 +-
 target/mips/tcg/translate.c                   |   34 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  332 ++++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 22 files changed, 4188 insertions(+), 59 deletions(-)
---
base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


