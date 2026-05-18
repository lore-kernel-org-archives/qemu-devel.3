Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6C4CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYz-00081k-Pt; Mon, 18 May 2026 01:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXl-0006s0-Us
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:37 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXc-0003QT-2U
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:28 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-439c00ed7e0so1764544fac.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082161; x=1779686961; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cj6f+FmKRCZmVlchOFBL5oK5in4UoKw3XeVZ96L4ZKs=;
 b=ob91cOE6Q7Szd3APWviV0vf8oRZ+h31OberuMWUpFuA4CkFNC1fz06NgmWmdLGHOoI
 1NuqopPvgOp4u5jYtBaw5RWw2fhWp0Q1yxnK2AuOOPtnKGEDoowyUEKdvz5xOEOK8Ota
 woumUZQosSym+Yxw5jPMmx/xxJ2C0wXbv7YTZsgXbNK8iuCVY3NVDUaxD0uH2cDRQoPB
 EanFqkGo6GHw5R/VqoaGOA6ZEQzSbTbeConkGib7cRnvUp//hubCQksF7IeJFfI0/h1x
 keQIzx2AIb2ZWyTmb8WPysB16ub8WdkEKUDvTepA+fatXYN5s14jyzg4VuTRBdcJJzFF
 biUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082161; x=1779686961;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cj6f+FmKRCZmVlchOFBL5oK5in4UoKw3XeVZ96L4ZKs=;
 b=ck1o3aEZFGuev9YO0dZl4Pi8bObvQWJgsT0lB0hFsufhPA0816kThORhQc+shsZigy
 64XfvdSgkIu0a8fEm4TqIgX6puWdKOLUQXlhHM1mP8NVtmWih3biKgjtu7qix5DEdBV0
 I7/2YI/c/jsL7hxfcTLnlIdVFB0Rdo6lZHUxGNFtu3eG7kjfw6g41KiZ9g1QRgxM2tNG
 KdgpoOuIJYdUy1o7sJRDxzIse1FEPnD8wlEcWFrBNZrpKRmPTvryddtljRDR5O+b26nw
 BKyAGZxku9LIG/9q8uF0k5P9yHHpILl2pZgb42mLx1c7bQ/LB8d2Glm7UY516atx1S23
 hWew==
X-Gm-Message-State: AOJu0YwdBdIcf2iqYxwkw0hXQbDtC/MBqOCVyUA8rGYPgcZ0QaAfNUX9
 wiye7FzJzkXWSR/oegvExAtsyC/cCvln++p/p9hbZiPxD9wqkL1Cqzmb
X-Gm-Gg: Acq92OFBk/VPgmbayBQNvHRE09oi2HvJQIMdGNMoXzbqyC8iyWrCjOAwisP59aDl2CZ
 N4SxtbIZLQ9FrhPtkspdBQVXTGPHAtabT4UjzOYjOAkUkNRWtZGn6SfuViU8CHAwA9rbKFR1jL8
 T5U6lg2Ga0Sx9VxtUlmDoChWbACejV40T95ZqyZ9tPDigiCT5EqPNtIAdR8nIRMcnyCkpLEqJ37
 /6ogJ4VfvWxBEHzyuhhx6+GqBYIYdXMBcZgC4aqmVb5jxLj5ExZIb3ut24jNwSqQUqo6Hnk7amZ
 SBTbX2XAPGzGIqzJrd0X17J2nWhjjwEmXaSPIOCEFprbePlG2qkUyGT28zVwuXcnmudkkqfOJdR
 XEZzk8DkrZZtp8ZFRA2ZPYT+3h0cvpNLuVN/f3qvNM/37CEsM4U9c0JuCeikxerbESX+3L6/J+d
 gUdD7AYBOL+88Xui43wyJq3N/z8naKywsUJaXD1Q/k20YdHWVvVQP3qiOYijr7Y5KnXDQF47VWK
 DcJw3B937rqdxtmisiiWZ8XJuX7YhoXE91/9ktWpgj+rE+fjgfYHQceIcTrvQY/ihYDmks=
X-Received: by 2002:a05:6808:150a:b0:467:14c7:a8b5 with SMTP id
 5614622812f47-482e562ef31mr8851051b6e.10.1779082160693; 
 Sun, 17 May 2026 22:29:20 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v8 00/35] target/mips: add missing Octeon user-mode support
Date: Sun, 17 May 2026 23:28:57 -0600
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwWrEIBAG4FdZPNeiRkfdU9+j9JCMJmtpdIlpa
 Fny7tUtpSGFBjzMD8P3y9xI9lPwmZxPNzL5JeSQYgnm4UTw0sbB0+BKJoIJYFIwOoZrpglnn2K
 Zcw5xoCHmmOkiqPJgG60Z9gJJIa6T78PHnX9++c75vXv1OFezblxCntP0ee9fRN37qeL/V5XHa
 Mu05a7nxqB9GsY2vD1iGkmtWppfTDFzgDUF67DzaKFR2v3B5BazB5gsmAOwDh1TKPo9pjYYP7j
 ooiqmnAAwjqu222OwxY5uBgVTDIQxFqVrcI/pLSYPMF0wUf8FnZfo+RZb1/ULmCERQFsCAAA=
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2a.google.com
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

Richard Henderson's v7.5 multiplier/QMAC rework is incorporated directly
as nine patches: two TCG preparatory patches and seven Octeon
multiplier/QMAC patches. The Octeon multiplier and QMAC translations now
expand inline in TCG, and the COP2 selector path is explicitly decoded by
decodetree so simple register transfers avoid a second selector decode.

The remaining Octeon patches add integer, indexed memory, atomic, COP2
crypto, CHORD, LLM, and CvmCount RDHWR support. The series also adds a
small mips64/mips64el TCG guest test covering representative Octeon
integer, fixed-point, multiplier, RDHWR, and COP2 selector paths. The
final patch corrects the Octeon68XX CP1 feature bits and FCR defaults.

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
Changes in v8:
- Incorporated Richard Henderson's v7.5 9-patch multiplier/QMAC rework
  directly into the stack rather than as a follow-up cleanup.
- Added the two v7.5 TCG prep patches as standalone patches:
  tcg_gen_addN_i64 and mul[us]2 zero/one optimization.
- Replaced the helper-backed Octeon multiplier/QMAC sequence with the
  seven v7.5-shaped patches: multiplier state, MTM, MTP, VMULU, VMM0,
  V3MULU, and QMAC.
- Split Octeon COP2 crypto core support into state/migration, helper
  implementation, explicit selector decode, and selector readback test
  patches.
- Decoded Octeon COP2 selectors explicitly in decodetree and used direct
  TCG loads/stores for simple COP2 register moves.
- Kept COP2 helper calls for operation selectors and shared-window state
  that require side effects.
- Folded ZCB/ZCBT into one patch so the decodetree wildcard is
  introduced in final form.
- Added new Reviewed-by tags from Richard Henderson for MTM/MTP, LA*,
  CvmCount, and QMAC/CvmCount test patches.
- Link to v7: https://lore.kernel.org/qemu-devel/20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com

Changes in v7:
- Rebased on current qemu.git staging (edcc429e9e).
- Reordered the zero-register cleanup after the BADDU/DMUL destination fix
  and moved the multiplier-state patch next to the MTM/MTP instruction
  patches.
- Applied Philippe's MIPS_FIXADE TB-flag readability tweak.
- Used explicit MO_32/MO_64 MemOps for SAA/SAAD atomic transaction sizes.
- Folded ZCB/ZCBT decode with a decodetree wildcard and zero the cache
  block with 128-bit stores.
- Added new Reviewed-by tags from Philippe Mathieu-Daudé and Richard
  Henderson.
- Link to v6: https://lore.kernel.org/qemu-devel/20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com

Changes in v6:
- Added Octeon QMAC/QMACS fixed-point accumulator support and smoke
  coverage.
- Added Octeon RDHWR $31/CvmCount support and smoke coverage.
- Clarified MTM0/VMM0 reset behavior against the CN71XX
  register-state tables.
- Fixed MTP0 to zero P1 per the CN71XX register-state table and added
  smoke coverage.
- Fixed VMM0 MPL1 reset handling and added smoke coverage for MPL1.
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
  load, SAA/SAAD, ZCB/ZCBT, multiplier, and test patches.
- Reworked Octeon multiplier limb accumulation as requested.
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

---
James Hilliard (33):
      linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
      linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: drop Octeon zero-register fast paths
      target/mips: split Octeon SEQ/SNE decode
      target/mips: add Octeon LBX instruction
      target/mips: add Octeon LHUX instruction
      target/mips: add Octeon LWUX instruction
      target/mips: add Octeon SAA instruction
      target/mips: add Octeon SAAD instruction
      target/mips: add Octeon ZCB and ZCBT instructions
      target/mips: add Octeon multiplier state
      target/mips: add Octeon MTM instructions
      target/mips: add Octeon MTP instructions
      target/mips: add Octeon VMULU instruction
      target/mips: add Octeon VMM0 instruction
      target/mips: add Octeon V3MULU instruction
      target/mips: add Octeon QMAC instructions
      tests/tcg/mips: add Octeon instruction smoke test
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto state
      target/mips: add Octeon COP2 crypto helpers
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: decode Octeon COP2 selectors explicitly
      tests/tcg/mips: cover Octeon COP2 selector readback
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon QMAC and CvmCount
      target/mips: expose Octeon68XX floating-point support

Richard Henderson (2):
      tcg: Introduce tcg_gen_addN_i64
      tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 MAINTAINERS                                   |    2 +
 include/tcg/tcg-op-common.h                   |    1 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   78 +-
 target/mips/cpu.h                             |  257 +++
 target/mips/helper.h                          |    4 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |  259 ++-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  755 +++++++-
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   43 +-
 target/mips/tcg/translate.h                   |    2 +
 tcg/optimize.c                                |   92 +-
 tcg/tcg-op.c                                  |   42 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  332 ++++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 25 files changed, 4535 insertions(+), 92 deletions(-)
---
base-commit: ac6721b88df944ade0048822b2b74210f543d656
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


