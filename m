Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B16CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDj-0006j7-Jg; Tue, 19 May 2026 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006co-8u
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDM-0000d3-0Y
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43a86d544c2so1730837fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207755; x=1779812555; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qfx+NqlLybx8gxygwUCnzVcl7DWHTDcQCiMjHhQzOZM=;
 b=IG2dGiXvn6b+XiAE/AOi7BopoiYiMh6edfOwAXjZFC0b8rh7SUMeReeShmv2zm2TOK
 HCXXKqZ4EWxswWX6n/qQfhkYJns5n3It/fqDw2piTjYqVuAYb91mzW1YgZRg8wh35IA0
 zwabz6Ha82JyXLtAe7QqKbfuYDUop5HnCowowc5tHNeSO4CkYIvIwj+3UcGLV7pMBoEG
 Dry//F7ybn2yWTkWgijNCpJzj21a+6SEvGIgssymEJjfLtMz1AKZkqvPZDHUNEGwI+Cr
 Lr4RNzqI3eVbrR8T4BnsTVbGh6ob/7bk8ha3FRU9XTGM/utfda7NT9Jk/mtkkEbSUKAS
 xlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207755; x=1779812555;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qfx+NqlLybx8gxygwUCnzVcl7DWHTDcQCiMjHhQzOZM=;
 b=gu++VeCqe7mFHjRGVAoF8W6ty39iwaciWBoI0Ek6My26ISwvbBicVrJfeZRkzE2Qv1
 mCIaUlUcZN9p8BLin90tLqmG9pnIHpZCU2dQEjSeWZ38mHfBpRov9boeTv/nFj4H6SXQ
 O6fDzWczPv5shoBuHCUeMSluMh6PhYCHzeVeYPRPZfZwYrofOQQAJzKLYpHMb0cC9HXm
 CoyREb/AWeUhkzxOzUcCGZ9ggKaxo6jsEioCdi780STsrET5J22borrnvsUV0G0MHUPg
 6edsjL1pJEwHsdoQIPVU8N03Hl97zL3PxBt3QmWVbnJ1wN4lZh48WUrl8UDsWkzRgRKG
 rFUw==
X-Gm-Message-State: AOJu0YxohuEvg0RqaLtmE+NmfVpJDSKkwD15nZUw6eqSOq1m2M0wiCws
 6AP3c81caiO17ZsH6g3IHKv0GyV95fcQsnJ1ZQsDDjvTH/dTXNnpHYoX
X-Gm-Gg: Acq92OHJwJphDnJLTv6PTlPrgDpCMIqWEMvx7U8C8P3Mf+48nu2Y82b11JvQAahCU1d
 c2OXOJfUsVy9JAHJoT7rGJteg0gZoltJlLQmGFEp2DIrWcTk+tbcgail3uvfIZQOMQm8hidaWjE
 8XRV9bEsQPSMEH/sE7qeo38AHcmeb+kwqEx78BXmwn8NbP1EplqYMhhsTYSGFXpJBk0DzFSAYJC
 7FbS0w4bJbt3Mi0Lsg5JwrEvOIOzWOxesehn0XUyKTgud9pejy6oRuXX7HzltZ3MEZzPratf2yR
 6C7/Q2TJdm/6/s8vGNSx/81IKRHg6Al1Idg21OAd5un14IaqA7xBFcppckL2HpR4jUpQm10DjK6
 nHG2+moMDUpGNvNYBC6USs9t9npCIhYtaY5WSVOSaqfLcq5tv1X1fIzZ4KAMeFUym01Vv5Z/CSD
 tq4zXF8EbIoPZvXwrfFUwrBlbTlp3n/gdCvGmgluX4YcNdhhQjIt1uukaIDN+EMbxpiPOZBdUKy
 +Endu21FgYlR9zwsQ+dBolAK3tkv1xheF7Zty1LxcsKxnOMA5OjwP1iQgEs6LJbZnZGxvfq3W+w
 zSo=
X-Received: by 2002:a05:6871:56ca:b0:430:2b69:8e9a with SMTP id
 586e51a60fabf-43a2dcc761emr13241731fac.5.1779207754642; 
 Tue, 19 May 2026 09:22:34 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v9 00/40] target/mips: add missing Octeon user-mode support
Date: Tue, 19 May 2026 10:22:02 -0600
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQ3UrEMBAF4FdZcm0kSfPrle8hXrSTaTdi06WpR
 Vn67iYrYq1gIBc5MHxnmCtJOAdM5OF0JTOuIYUp5uDuTgTObRyQBp8zEUxoJgWjY7gkOsGCU8z
 /lEIcaIgpJroKqlC7xhgGvQCSicuMfXi/8U/PXzm9dS8ISzHLxDmkZZo/bv2rKHPfVfz/qvwYb
 Zlx3PfcWnCPw9iG13uYRlKq1uYHU8xWsCZjHXQITjfK+D+Y3GOugsmMea2dB88UiP6IqR3GKxd
 dVcGUF1pbz1XbHTG9x2o30xlTTAtrHUjfwBEze0xWMJMxUfbSHUpAfsTsHjMVzBaMaa44ojH4a
 7Nt2z4BJOyk36gCAAA=
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
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2e.google.com
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
expand inline in TCG.

The remaining Octeon patches add integer, indexed memory, atomic, COP2
crypto, CHORD, LLM, and CvmCount RDHWR support. The COP2 work is split
into state, helper plumbing, per-engine helper batches, explicit
selector decode, CHORD/LLM, and smoke-test coverage so each functional
block can be reviewed independently. The series also adds a small
mips64/mips64el TCG guest test covering representative Octeon integer,
fixed-point, multiplier, RDHWR, and COP2 selector paths. The final patch
corrects the Octeon68XX CP1 feature bits and FCR defaults.

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
- Split COP2 helper implementation by functional subcategory and added
  helper.h declarations alongside the side-effecting selector
  operations.
- Removed the shared COP2 selector enum; selectors are now either
  decoded by decodetree or kept as helper-local constants for shared
  register-window arithmetic.
- Used signed 32-bit DMFC2 direct loads for 32-bit COP2 register
  readback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v9:
- Used MO_ATOM_NONE for the 128-bit ZCB/ZCBT zero stores.
- Reused octeon_zero_partial_product_state() in the VMM0 translator.
- Removed the shared MIPSOcteonCop2Sel enum from CPU state headers.
- Replaced generic selector-dispatch COP2 helpers with per-operation
  helper functions.
- Split COP2 helper implementation into smaller functional subcategory
  patches: plumbing, CRC, GFM, SHA3, ZUC, SNOW3G, AES, SMS4, 3DES/KASUMI,
  Camellia, HSH, and CHORD/LLM.
- Added COP2 helper declarations to helper.h alongside the per-engine
  helper implementation commits.
- Used signed 32-bit DMFC2 direct loads for 32-bit COP2 register
  readback.
- Documented the AESRESINP input/readback state split in the translator.
- Combined COP2 selector readback with QMAC/CvmCount smoke coverage.
- Link to v8: https://lore.kernel.org/qemu-devel/20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com

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
James Hilliard (38):
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
      target/mips: add Octeon COP2 crypto helper plumbing
      target/mips: add Octeon CRC COP2 helpers
      target/mips: add Octeon GFM COP2 helpers
      target/mips: add Octeon SHA3 COP2 helpers
      target/mips: add Octeon ZUC COP2 helpers
      target/mips: add Octeon SNOW3G COP2 helpers
      target/mips: add Octeon AES COP2 helpers
      target/mips: add Octeon SMS4 COP2 helpers
      target/mips: add Octeon 3DES and KASUMI COP2 helpers
      target/mips: add Octeon Camellia COP2 helpers
      target/mips: add Octeon HSH COP2 helpers
      target/mips: add Octeon CHORD and LLM COP2 helpers
      target/mips: decode Octeon COP2 selectors explicitly
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon COP2, QMAC and CvmCount
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
 target/mips/cpu.h                             |   70 +
 target/mips/helper.h                          |  123 ++
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |  259 ++-
 target/mips/tcg/octeon_crypto.c               | 2543 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  751 +++++++-
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   43 +-
 target/mips/tcg/translate.h                   |    2 +
 tcg/optimize.c                                |   92 +-
 tcg/tcg-op.c                                  |   42 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  332 ++++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 24 files changed, 4516 insertions(+), 92 deletions(-)
---
base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


