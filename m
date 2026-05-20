Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F4ACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgU-00013r-S8; Wed, 20 May 2026 00:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgM-00012Z-FQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:22 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgH-0003l6-3v
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:20 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-47cacb4ed99so2796305b6e.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251834; x=1779856634; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WvDpcLrNPo78CfSkYXyd+JNsduV2ViOrkwXycUEFtQQ=;
 b=q1UcwuZXNdc/Hw7SPRViwHyXOfA4DZVVFhG/NP0H5pUk4ldW1KSGwA0KvctGVD3h3s
 H8CJV04xheXGMQny+249tNSGCpgt7P13qaIA0s8NkTNMdtwFISuFqNDFYW/qms4cJ1BS
 A7GptIfwgTtaGv3ympVr3TXPUuefpYUmHlIKar+z1eVNDdDSBK2IHRnD1On3zE+3OjB7
 Af1cpqEr0CcOuwOrCLlyCu06xmJ7PSHtAqEiVC9OkL0S2dorIM06Vo+6QwlhUdliU+mV
 tDa5T6cWJrf1s+TIOMxcMo65SWcdndKUwPXGS1T3PTMTAQC2L7gnR5Y+frrbXvRbxWWm
 Ma+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251834; x=1779856634;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvDpcLrNPo78CfSkYXyd+JNsduV2ViOrkwXycUEFtQQ=;
 b=n4ktmzJrd47GrxrsQQIiHI3Lq6sNcrR9HnoWMRKdgAcfAQSl9maKAWkBAJRdpbtTod
 ziuT6me5qQm9IvzWjp48+eubiU7NCjv1k+tYN3MKiwAa+czZOAg+1KfTZC00NQ3L1VjC
 qo3oihEslObQX+awUlo92Nx2xNzc+HLWscf7Ur01sIiewuyK2JzdSrMjDllbG9mTA2ET
 u+dgNMlQ8N4Hq5fxUMI1d4RrIvyG/fc+vuMQlGXPcbP96GMSvQkWGKTjixq0WVvcPSUq
 q7nv7swWqFRBbTXChhYCTZozQjQcQcy/HaVASkUPz1SbHqJE1zXzj7w4M1TXn1JYoRt0
 lCPg==
X-Gm-Message-State: AOJu0YyIi8HQKOkBLMiBeoLXbNSgnM3HyC1arCTyAkad/hmwGY5P9baX
 TeJ1oXJChw7oWWsAjYnfkFa5Ez7qvd6KnVydPBP7O7KZYqvHOaTy0+SH
X-Gm-Gg: Acq92OG7DHII7iEiennRiOuV3s51I1VOro6R+zQbrUW1knJy3/yFe8uBQlW44EixXgY
 /dJQ4alY+7nC0+uRv+vG0JgX1+gl2vdc9psD1W8NltiTnmVVtLyEsOoYfz0lupgbm1P4+GJNh1m
 hHEbk4uybAFsUJCNYM+lMrgNaTSSIQSaTxEoPxl4zcQevgkWPLN1yBqwFJLfuydobSI+uDYkORD
 Y10nNWIxDMh5BsqNhFJow1AvzmrYVA1V2heBfBobGxQlUdw/A25eVbc0sYiQc443J17WKY9ytGe
 e9lI7mUb9yHDztBc2kiUgp4GlDQH+R0TCKUwq+uwdFJSykk3whpvU9+AoMvvs5rSGDproPbxMu9
 e4Byyvq6893KBUFfwx7qQ5izXqCWwcgr+5KmrHEcC3T6O2nJ3OAMa6IAfqkT79uUBlcyIfC/wZ3
 Z9b+99bHhY4xQRIJzYVixdsc1ZgGs5zLHW/xXj5idmd8Dtr0chrWo9eHP05iopAFBGUSeW5IyNO
 tGICtzf2Jck4ml9ntIQWDeavvSgyz/Q3YBXGjO0a+QnsTIJRjHWC0PUZPnHUeP3nBmkx4K8KrLT
 CPI=
X-Received: by 2002:a05:6808:3a16:b0:479:3a08:b504 with SMTP id
 5614622812f47-482e57170a4mr13288100b6e.10.1779251834286; 
 Tue, 19 May 2026 21:37:14 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v10 00/45] target/mips: add missing Octeon user-mode
 support
Date: Tue, 19 May 2026 22:36:54 -0600
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XRzUrEMBAH8FdZcjaSpM2XJ99DPLQz027EtkuzF
 mXZdzdZEUMXDOSQCcNv/kwuLNIaKLKnw4WttIUYljkVUjwcGBy7eSQeMD0wJZQRrRJ8CqfIFzj
 TMqd7jGEeeZjjHPmmuCbjG2sFDApYIk4rDeHz5r+8/tTxo38jOGczdxxDPC/r1y3ApnLf7yj5/
 6h0BO+E9RIH6Rz453HqwvsjLBPLo7bmD9PCVbAmYT30BN402uId1paYr2BtwtAYj4BCgxr2mC4
 wWdnopjOmURnjUOqu32OmxGo7MwnTwijnPLTYwB6zJdZWMJswlXOZnlogucdcidkK5jImjNSSy
 Fq6S+ZLrPYBPu/MItpGEyBiiV2v12+gyxwJ9gIAAA==
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22b.google.com
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
into state, helper plumbing, per-engine helper patches, explicit
selector decode, CHORD/LLM, and smoke-test coverage, with each
functional block isolated. The series also adds a small
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
James Hilliard (43):
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
      target/mips: decode Octeon COP2 register selectors
      target/mips: decode Octeon CRC and GFM COP2 selectors
      target/mips: decode Octeon HSH and SHA3 COP2 selectors
      target/mips: decode Octeon ZUC and SNOW3G COP2 selectors
      target/mips: decode Octeon block-cipher COP2 selectors
      target/mips: decode Octeon CHORD and LLM COP2 selectors
      target/mips: add Octeon CvmCount RDHWR support
      tests/tcg/mips: cover Octeon COP2, QMAC and CvmCount
      target/mips: expose Octeon68XX floating-point support

Richard Henderson (2):
      tcg: Introduce tcg_gen_addN_i64
      tcg: Optimize INDEX_op_mul[us]2 for 0 and 1

 include/tcg/tcg-op-common.h                   |    1 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   78 +-
 target/mips/cpu.h                             |   44 +
 target/mips/helper.h                          |  125 ++
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  129 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |  259 ++-
 target/mips/tcg/octeon_crypto.c               | 2503 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  745 +++++++-
 target/mips/tcg/op_helper.c                   |   19 +-
 target/mips/tcg/translate.c                   |   43 +-
 target/mips/tcg/translate.h                   |    2 +
 tcg/optimize.c                                |   92 +-
 tcg/tcg-op.c                                  |   42 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  332 ++++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 23 files changed, 4431 insertions(+), 92 deletions(-)
---
base-commit: 6d17fd91f6cf88df5cb2205e578640d72605cc43
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


