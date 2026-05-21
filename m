Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F0DCD5BB5
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mu-0000Au-S6; Thu, 21 May 2026 14:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mp-00009e-If
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:23 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7ml-00020z-Sa
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479eb8bcacbso4339223b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386778; x=1779991578; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PWu5FDCGXtvLERfhaeb60N08AParktjlqNM5ROskBcY=;
 b=XHOl3m83CPyQ2mgnQuLgtObx/pg5S8UZd4hRCLGelYuNQ/rwV81K4K37j43GtdPozo
 I7/HTmkatFjQpBTQOQnQOdT5D4Nm/qpSaFHPdXOTjPnz8n7cQwBNdctKO09t02HiVGl5
 jL2ZmSEmo6gMnTzC6wr9Me+OYwSA3NVeVaKrde6V3m9SM8qFCqrPcy5kUimsyhpetKsR
 5V9FHQIjIev5h6HY0SXFq9OM2oE7gh/uu+v6sRH9PSTYgpml7pp6jZecvi5sf5jUWVr+
 PRjaEBTOs4fR37B8Dn5qic67k7UBW3hRpLjMQzitFPxU6NhXCsijJI6kP+Xif+2vdz/U
 6zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386778; x=1779991578;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWu5FDCGXtvLERfhaeb60N08AParktjlqNM5ROskBcY=;
 b=cu00qjM3djGN98UlqxXO44IhzUTzYGNkUy4wmfi0FIPuoupuXlDBMrkJ51poD/tfzL
 jU0qdQBobTHNlRfLa28pm7qHwmBG7sL4cNfvXIo1nsCZxyJ3sAonNAHyoOv/429RIF53
 NTvSVzgDiiRnGv/unX34gftpNUILGhBGcHNPXwzH0tN6sRTAAwFH0/1L9wgvZ7SmErju
 aU5AEcWFvbCQLozefWm1A55d+3Td/00VizPdYKvdzN+3NtuK1e0Hyvbwjl1y8Xu7K10e
 xSLwXH4atW8TDCmdmBNAK4tFxmmhwXSQV7n11aWWPdXPFvxGwr3Z900ksXr1fNKKOP9M
 nm9g==
X-Gm-Message-State: AOJu0Yx6GpbmNMGPoF+5mGh4WEhYIGDvb1GGrYVN/pOekPUyRv2Z6zGD
 +xCwDYnVVTEGFySFlqRb5XhiKJqSmSxXjmpN0gfunzK28OymD/iWztGS
X-Gm-Gg: Acq92OHrCAlcaVTy+qZvjB8iEwHyqfmhsePfuPWZx3uTqjlCfOlMgsgAo+U27FGEGxY
 9cGjrLyOTquB2cGj1Qn+V41AzyWoAZ9tL29koLXyIiBqYqmJ21Chuk0T2Ujn2I/8L+P6c9lwEG2
 Ql1IqPLct80sWOht3MBQGA/GI514YpRTw8UJ7bJ1heIBqIoEpTQfmmwcjDRk3Wx72avaRF7B/ia
 vxtnlgvI6ocwbmrs7EYnaSzGT7sKAOn4xMEQs6EfxB5Y6cr18o2YAsmTnWZ/Zux8xLTJXvWJzzV
 zpDQXNgpxeeCRIoLG72gJyQTeX0AOJw7Ocs81E2Bd6vtNZ9x1YswaLovQrYcOuEcEJcm4kZyVe5
 D7TgnSy5GtdTz53Qg6WkBwlINQ0Bk1GFyBjOLi0MQlytNnH6s4YTyLwYzzXVuou9yvRPwXBQIXJ
 QfkUsVufpLfqwehE3a0mduuBcS+cP73J9eULvbuMcz2sHaymV8oc0Pw7vxC5pTpNL+4E9RmkcZO
 DY2qjO7l7yqAlXdNl6xFRGiOTua+atIW2Zq9H/sW5pKjPzgJqfhpOHqG5z0ETiXnB6CdZjJbgH+
 /0Q=
X-Received: by 2002:a05:6808:c2f5:b0:467:1458:2a8f with SMTP id
 5614622812f47-4854a48941amr36470b6e.37.1779386777527; 
 Thu, 21 May 2026 11:06:17 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v13 00/22] target/mips: add missing Octeon user-mode
 support
Date: Thu, 21 May 2026 12:05:53 -0600
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XTzU7DMAwA4FdBPZPKTpo/TnsPxKFN3C5obadmV
 KBp704yQJQOUSHlkETxZ8tWzkWkKVAsHu7OxURziGEc0gHF/V3h9vXQEQs+XRQcuIKKA+vDMbL
 RnWgc0j7GMHQsDHGIbOZMkrJCa3Atd0UijhO14fXqPz59nONL80zulM38Yh/iaZzergXMPL/7S
 oV/p0oLWA3aom/RGGd3XV+HQ+nGvsipZvGNSTAbmEhY4xpyVgmp/Q1WLTG7gVUJ80pZ7zxIx9s
 1JhcYbnR0lhmTnitlPMq6WWNqiW31TCVMguLGWFd54daYXmLVBqYTxnNdqqHKEa4xs8T0BmYyB
 golEmlNN5XZJbY1AJt7pr3XQpLz3q8xhP9oaUTABKjWkm8J5c0IEBccBwQ0oEtrNTJkx3049H5
 3CEM9jeU4dZ8x/GeM5gJFydPn0b8HXS6Xd2K2jMOuAwAA
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
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

This series completes the remaining Octeon user-mode support work
after v12 covered the sysmips/FIXADE pieces, Octeon integer/indexed
memory/atomic instructions, multiplier/QMAC support, CP1 exposure, and
per-instruction smoke tests.

This series carries the remaining TCG optimization, Octeon COP2 crypto
state and helpers, explicit COP2 selector decode, CHORD/LLM, CvmCount
RDHWR support, and the extended Octeon smoke coverage.  The COP2 work is
split into state, helper plumbing, per-engine helper patches, explicit
selector decode by functional group, and smoke-test coverage so each
functional block can be reviewed independently.

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
- Reworked GFM helpers to keep the architectural 128-bit state and
  direct RESINP XOR paths.
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
Changes in v13:
- Rebased the remaining TCG/COP2/CvmCount patches on current qemu.git
  staging after v12.
- Dropped patches already covered by v12.
- Kept the explicit Octeon COP2 selector decode split by register,
  CRC/GFM, HSH/SHA3, stream-cipher, block-cipher, and CHORD/LLM groups.
- Folded the COP2 state/decode review fixes into the series, including
  architectural HSH shared-window state, direct reflected GFM register
  helpers, CRC/AES length masking, and corrected selector naming.
- Folded COP2 readback, reflected-selector, and CvmCount smoke coverage
  into the related implementation commits.
- Added standalone QMAC/QMACS smoke coverage.
- Link to v12: https://lore.kernel.org/qemu-devel/20260520172313.23777-1-philmd@linaro.org/

Changes in v12:
- Rebased v12 on rth/tcg-next.
- Addressed Richard's review comments, including comment rewording.
- Passed gen_atomic_*() through do_atomic_ld().
- Used tcg_zero_i128() for ZCB/ZCBT zero stores.
- Reordered the indexed-load TRANS() entries.
- Link to v11: https://lore.kernel.org/qemu-devel/20260520101807.9971-1-philmd@linaro.org/

Changes in v11:
- Split the previously submitted v10 series for review.
- Added tests alongside each instruction patch instead of collecting all
  instruction coverage at the end.
- Split SEQNE/SEQNEI into separate SEQ/SNE and SEQI/SNEI decode patches
  to ease review.
- Link to v10: https://lore.kernel.org/qemu-devel/20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com

Changes in v10:
- Split the explicit Octeon COP2 selector decode patch into register,
  CRC/GFM, HSH/SHA3, stream-cipher, block-cipher, and CHORD/LLM
  patches.
- Added Philippe's Reviewed-by tag and local MemOp cleanup for ZCB/ZCBT.
- Added Philippe's Tested-by tags for VMULU, VMM0, and Octeon68XX CP1.
- Restored the original constant-fold output ordering in the TCG mul[us]2
  optimization patch.
- Kept Octeon COP2 crypto state architectural by dropping shared-mode and
  AES, GFM, SHA3, ZUC, and SNOW3G shadow state.
- Ordered Octeon COP2 crypto CPU state and VMState fields by architectural
  selector groups.
- Reworked GFM reflected helpers around the full 128-bit architectural state
  and direct RESINP XOR operations.
- Preserved the 64-bit UIA2 GFM reduction path used by SNOW3G F9.
- Added Richard's Reviewed-by tag for the CRC COP2 helpers and masked
  variable-length CRC writes to CRCLEN<3:0>.
- Link to v9: https://lore.kernel.org/qemu-devel/20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com

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
- Documented the AESRESINP direct register-transfer handling in the translator.
- Combined COP2 selector readback with QMAC/CvmCount smoke coverage.
- Link to v8: https://lore.kernel.org/qemu-devel/20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com

Changes in v8:
- Incorporated Richard Henderson's v7.5 9-patch multiplier/QMAC rework
  directly into the series.
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
James Hilliard (21):
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
      target/mips: decode Octeon COP2 register selectors
      target/mips: decode Octeon CRC and GFM COP2 selectors
      target/mips: decode Octeon HSH and SHA3 COP2 selectors
      target/mips: decode Octeon ZUC and SNOW3G COP2 selectors
      target/mips: decode Octeon block-cipher COP2 selectors
      target/mips: decode Octeon CHORD and LLM COP2 selectors
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon QMAC instructions

Richard Henderson (1):
      tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 target/mips/cpu.c                             |   68 +
 target/mips/cpu.h                             |   26 +
 target/mips/helper.h                          |   83 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |   94 +
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |  206 +++
 target/mips/tcg/octeon_crypto.c               | 2432 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  340 ++++
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   19 +
 tcg/optimize.c                                |   92 +-
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  198 ++
 13 files changed, 3548 insertions(+), 33 deletions(-)
---
base-commit: f5a2438405d4ae8b62de7c9b39fac0b2155ee544
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


