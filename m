Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C55ECD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfCv-000109-5A; Mon, 08 Jun 2026 15:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCl-0000vG-G2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:11 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCi-0006ah-6V
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:10 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4863eae453eso2113903b6e.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945206; x=1781550006; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oyuCw200D+omRtRGarneh/HuQmwBGtuXoPxevJrKtEw=;
 b=SZssvq+Smz+mm0LMN1HE99FhyvceBOj2ih4DdUS07FD5hKDX5TNX0cMGv/cF4qacWC
 CL1UJh+Zx5KQqa0IGl0qlnsMm9gH07RKKmkfdlMnRBPIooR2ixErcVh8wDDUpB3NsT9h
 YKsuK7osoiwiu0eNo/GQX2K2fFZLQEXGzlwSR2KdxDyKosCA8mPumsb1IDmvabtCUWPI
 lLRBeWjKEC+k8yQKzYJhLVpqBc1VgFREKNuzpUNkeyddmH/dxDVycVc8e02z4yUF5mhg
 xpb5LDYGqvJrnIYGMJZVP3+GoHYm17vsD8kiSXOH0O1OPcPiwMG05dSueH6USN4031op
 ZuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945206; x=1781550006;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyuCw200D+omRtRGarneh/HuQmwBGtuXoPxevJrKtEw=;
 b=bt98eEt5NKEOLZDBSW2S0GHdk0/DftZHzhC+H+CpZmoXqRY0u5LxFBAY04WCm0fy4E
 /CsnF/C6vyGbJNuTtIlot4yTMRJ5hP/7jN56qjlX8Qc4Ceg/DjvDVJXyKP3nQe2Z9Y8M
 u15g876Vi4ADoyB7TbpJzGeQHlvOfOj4ZnI9Mxq43RF+Y63orYcECdtsGV2zLxqxf7zL
 r3XjqbM3KMC/8zNpD+Ktb11eCh0liU/c5NBY7PU/ohHLiTFNUBscTVbsXwj2sROPc7Mj
 IAkX+woVF76wvPZrK7B7wRJoOXP9GWt12U889HVOfDH+eQrckJ5LudE8HnBCiUphWjxC
 uqXw==
X-Gm-Message-State: AOJu0YzVURtIAMXwNUbRfh+PkFHDFgvaxm03ZzfW4tD7hPiovH+UyinB
 FdmJ/hU3GQv8mUph1hOHgC0kUmjrLOiJceuKmBEtZre2W2oUjFxRi5uWmQ+zWHpXnq4=
X-Gm-Gg: Acq92OFy+6Os4sRTFgDt6mYW9KyYIuqRPMDWA+O1Z8mLIoNnk0bAd0GS88NIzAh40Lw
 1VJJTP7s+YAcq/M+9FN3NON0hXvdu0XzVu9PYZNFpuWiscoR7as6n+YNM0KDAG2ixRYHTWC8hTk
 XWH5VI1YrrZreGW1PMvwTGMrsthLNccaJ321mwvn4mbQDAJoQk+7iFFT7iesA3SkR6B1nS68G5m
 yLIxfaN770yxPF2jyA0XolstAUcxRzm4XqGqBKoFpuVETjTaQSzwls/LBKA4HqaRd7pPGqwhg+V
 RFxl7TUvbQbTWxzxR9duNITjs3W/WQxyUgRtv42yIa7e+1AUz+s9krkAOhidV64b6PKj8rx/Qti
 wCL/4bTbXhCYwupAK8bFW1aPF509fE+2UfmmvsK8yLt/j0OYa55mdMVrw9MvRKpVE6uWiKsa+Vt
 +UZarsHF24/8MoSMHfuULO58aai2kEH2VHJpkcslMzebdi7FjKIdOQNzJ6qvxU9BK029BKeitAJ
 0MzTzLFUr4HSSzdIfVu75JAUY3ECK51E+TOUsoY7PmMAde6NCQZ4sLa0zQLoY0o35LSw39md04b
 CVIOlaJPectT+kxBUJxDUGop4R7Q/IX0
X-Received: by 2002:a05:6808:1997:b0:47b:c8d0:512e with SMTP id
 5614622812f47-4868dea4facmr9147044b6e.34.1780945205443; 
 Mon, 08 Jun 2026 12:00:05 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v16 00/21] target/mips: add missing Octeon user-mode
 support
Date: Mon, 08 Jun 2026 12:59:25 -0600
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XTzW7bMAwA4FcpfK4CUv/aqe8x9GCLcqIisQMrN
 TYUefdJ3YaqNlChgA+WIH4kKOqtS2GJIXU/Ht66JawxxXnKC9SPD50/9dMxsEh5o+PANUgO7BK
 vic3+FuYp/6cUpyOLU5oSWzlTQTthDPiR+y4T1yWM8de7//P57zq9Di/B34pZTpxius3L7/cCV
 l7O/U+FX6fKH7AejEMa0Vrvno6XPp4Pfr50JdUqPjAFtoGJjA1+CN5poQztMFljroHJjJHWjjy
 B8nzcYqrCsNHRVRVMEdfaEqp+2GK6xlo90xlToLm1zksSfouZGpMNzGSMl7r0EKQPuMVsjZkGZ
 gsGGhWGYEzYVeZqrHUBrvTMEBmhgieiLYbwHS1fETABenSBxoBqdwWIFccBAS2Yg3MGGbLrKZ4
 v9HSOU7/Mh3k5/ovhn2MMFygOPD8e80VQPdPNB4JlqFUv/WDzXHsSu7rlt7gy1uMwgg2opRWw4
 +q55rzFlcEerRHYK2vJ85q73+9/AAzaUuSbBAAA
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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

This series carries the remaining Octeon COP2 crypto state and helpers,
explicit COP2 selector decode, CHORD/LLM, CvmCount RDHWR support, and the
extended Octeon smoke coverage.  The COP2 work is
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
Changes in v16:
- Rebased on current qemu.git master.
- Dropped the TCG mul[us]2 optimization patch, which is now upstream as
  c9349965ce ("tcg: Optimize INDEX_op_mul[us]2 for 0 and 1").
- No changes to the remaining Octeon target patches since v15.
- Link to v15: https://lore.kernel.org/qemu-devel/20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com

Changes in v15:
- Addressed Richard Henderson's v14 GFM review by documenting the
  validated reflected-polynomial reduction form and sharing the 64-bit
  UIA2 shortcut for normal and reflected XORMUL1.
- Modeled SHA3 as a direct 25-lane architectural view, used direct TCG
  moves and XORs for SHA3 DAT/XORDAT selectors, and removed the unused
  STARTOP operand.
- Kept ZUC runtime state in the documented HASHIV window and generated the
  third MAC lookahead word on demand instead of mirroring it through HSH
  DAT aliases.
- Added Richard Henderson's Reviewed-by and Acked-by tags for the COP2
  selector decode and QMAC test patches.
- Link to v14: https://lore.kernel.org/qemu-devel/20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com

Changes in v14:
- Added Richard Henderson's Reviewed-by tags for the Octeon COP2 crypto
  state and helper plumbing patches.
- Fixed HSH DAT/IV DMFC2/DMTC2 selector transfers to use paired low-32
  architectural words.
- Added missing HSH DAT readback selectors and smoke coverage.
- Moved the Octeon COP2 undefined-selector fallback into the register
  selector decode patch.
- Removed the redundant AES RESINP translator path.
- Link to v13: https://lore.kernel.org/qemu-devel/20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com

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
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>

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

 target/mips/cpu.c                             |   68 +
 target/mips/cpu.h                             |   31 +
 target/mips/helper.h                          |   61 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |   94 +
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |  213 +++
 target/mips/tcg/octeon_crypto.c               | 2314 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  396 +++++
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   19 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 +++
 12 files changed, 3434 insertions(+), 1 deletion(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


