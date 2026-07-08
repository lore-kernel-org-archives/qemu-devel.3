Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C288BC44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUzQ-00010l-Po; Wed, 08 Jul 2026 12:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzP-000108-PY
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1whUzM-0006st-B7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 12:19:11 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cace91f112so9695025ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783527546; x=1784132346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5fqipkyWSeoyAFF1Lx9OCugXn/sgrEYvlKLpBmqiR3s=;
 b=TkOfuS1QNBXGhhBOWAl5c88NyEpgnKD2ptNz1xbsrogvxaY3LUr1h951aoAxMVJqaD
 XUBCmtOO/aQPZ2PVePX2t55KJ0H08JnSt9F2IoSbhx+MHW22rRV0ckUkJcEzydrIcapp
 0yx8rJrhx9xKQ0EzP0acr+19agseRes/TC4+cLJixVs8ki4X61/0TrQUJi8GXkd9ntdo
 f9wFoZlYG9ofkdlYOMoCidliGBrNf5IcwFtXzQ/dnl9qfQS6csQtBQlxUfVJBZco/u+m
 PW4d9wtBmNjc4QwgdgcrvLiF0OAgTjBqLeBdsTtrVZ9XzXyb+nfgQ9Ut01+Bptopa31O
 xq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527546; x=1784132346;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5fqipkyWSeoyAFF1Lx9OCugXn/sgrEYvlKLpBmqiR3s=;
 b=b2YCACjy+US2o934F0vjwzEDa8eHAuNVqIYdzTeiIHKIBHNVDPhSnlXOcQCwO6p8Yy
 wSKe6XKEiqzX3MR/s9OOEZtblaHY8K8PCUWgO6yRViMXQhF6fTf36D67VE8tGAW44mDI
 PYQicwh7eFO1Ce7X3rfV3NYM0gjz6SYwsql8ofAEZfr0AsclN/yZqOMWRlAm0BL6Cgs5
 R6twzHjGtaGx4rLDm5cnhQshFRp99kY6EW0j73DKYKyXpwpOwdH4B0IzcG5ZWJUlMp8F
 Zfn9PXf8suVyiQ87RGoD3n4/Y1OZuaLJKuvE24nCeUYm3bh65hJQ77oT96hPs2yUnn9G
 GxCg==
X-Gm-Message-State: AOJu0YwwOHRmZSNG1ZuCSlUjDznm5h45DAhr07lx8YNM6KVyxj9pTFvx
 xJyCvXxp5c/C2K/hhilS82ABG2CmUzVCG2PYBq4E4VOyuOBkeFmJiFTTAn+wOodecF+I8ej8/29
 5N/sIlSMI12Zf5MAtLoclNxFkcaREvosM/qC1iFihC8/H9XNZBHG2arj3eDCcKMup3M5rv+v7uf
 ltLamiEJ35EF9xMaLUAtsA6UHRmFUSDLNbPdqzoYE=
X-Gm-Gg: AfdE7cmDv6Mh4bKRD1WeGhKZZ1qvex6s0+xY1P74fHhDZmL+0Gi//0B02QkZMclSExh
 q95EPM/JXZ/T93DuCSIAWhfDfT1T97h4FZGjpLdjN3BjdIRK4mZHlIjAF5CpQTQsKw19MMaKSks
 KB54PTBhDT69U6FNqWZvz1V8/WQvf4HC2oQLsP55wQXZgq4GeCY2WZHyt5SD1Zw/gPIV2lXsChj
 vDK1y2DpJpCFa8QbTPhHKYqLUawuTMjWTM05FiOGhyA9F6kkii5InebEEb78t1chgs+KgFuWOkp
 ib0bXXN0OI4jU+C319uf0iFH0Ddk8o3MiJNiDCTFLj3p7+4ZnIa6AtSTI1RRnzIFPZmnJQBmMTB
 06sn57+y68BRl4upseKbSmGscsCX2nxjdQHFJg9fWQy37wEXusUE98llRH3wJgFbuke8PC2zxRC
 XOgKU51swXXOeYOKJYSMllLVY8y21K6IDNyTVxYqHAJBTE9WdE+/nB/QJQv0qklKuCg05aTIzbG
 utExdcGBRwXHOCyfkGZiBSAauk=
X-Received: by 2002:a17:902:db04:b0:2cc:ae2b:b6d2 with SMTP id
 d9443c01a7336-2ccea3c852dmr29581475ad.15.1783527546298; 
 Wed, 08 Jul 2026 09:19:06 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb56fsm30789265ad.15.2026.07.08.09.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:05 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v6 0/9] target/riscv: Add RISC-V Zvfofp8min extension support
Date: Thu,  9 Jul 2026 00:18:50 +0800
Message-ID: <20260708161859.1124848-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patchset adds support for the RISC-V Zvfofp8min ISA extension that
provides conversion operations for OCP FP8 formats which provide the
foundation for the future vector matrix extensions.

Ratification status:
- Zvfofp8min is currently v0.9 and is going through the RVIA ratification
  process. This series tracks the v0.9 isa-manual tag below.
- riscv-isa-manual tag:
  https://github.com/riscv/riscv-isa-manual/releases/tag/zvfofp8min-0.9

Zvfofp8min (v0.9):
- The Zvfofp8min extension provides minimal vector conversion support for
  the OFP8 formats. It requires the Zve32f extension and leverages the
  altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
  E4M3 (altfmt=0) and E5M2 (altfmt=1) formats. Per the OCP FP8 spec and
  the extension definition:
  - Canonical NaN for both E4M3 and E5M2 is 0x7f.
  - All NaNs are treated as quiet NaNs.
  - Widening conversions are exact: no rounding and no exception flags.
- These conversions are the data-movement primitives that feed and drain
  the OFP8 vector/matrix compute pipeline.
- The LLVM RISC-V backend emits these instructions as of LLVM 22.1.0:
  https://releases.llvm.org/22.1.0/docs/ReleaseNotes.html#changes-to-the-risc-v-backend

Instructions:
  Extended (existing instructions taught to handle OFP8):
  - vfwcvtbf16.f.f.v   : OFP8 to BF16 widening conversion
  - vfncvtbf16.f.f.w   : BF16 to OFP8 narrowing conversion
  New:
  - vfncvtbf16.sat.f.f.w : BF16 to OFP8 narrowing with saturation
  - vfncvt.f.f.q         : FP32 to OFP8 quad-width (4x) narrowing conversion
  - vfncvt.sat.f.f.q     : FP32 to OFP8 quad-width narrowing with saturation

Verification:
- riscv-tests (fork https://github.com/riscv-software-src/riscv-tests):
  https://github.com/rnax/riscv-tests/tree/dev/rnax/support_zvfofp8min
  - Require LLVM 22.1.0
    https://releases.llvm.org/22.1.0/docs/ReleaseNotes.html#changes-to-the-risc-v-backend
  - Zvfofp8min test target: rv64uzvfofp8min/rv32uzvfofp8min
  - Both Spike and QEMU applied this patchset could pass the riscv-tests

References:
- OCP FP8 specification:
  https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1


Changes in v6
- Add patch 1 to fix the biased exponent write bug in the
  parts_float_to_e5m2() saturate path. FloatParts64.exp holds an
  unbiased exponent, so exp_bias must be subtracted when storing
  the max-normal biased exponent value.
- Initialize float_e4m3_nan_is_snan to false in riscv_cpu_reset_hold()
  to ensure consistent NaN handling for OFP8 E4M3 operations.
- Merge "Expose Zvfofp8min property" into "Add cfg property for
  Zvfofp8min extension" to keep the property registration together
  with the cfg field definition.
- Fix indentation of cbo.* opcode table entries in the disas patch.
- Rebase on riscv-to-apply.next (commit 267b5a2)

Changes in v5
- Drop Zvfofp4min which is not going through the RVIA ratification
  process yet.
- Fix typos.
- Rebase on riscv-to-apply.next (commit bf76a00)

Changes in v4
- Rebase on riscv-to-apply.next (commit 21101a7)
- Remove the softfloat library related patches (Thanks for RH's help to
  split this part)
- Add missing illegal ALTFMT SEW pattern checking for Zvfofp8min in
  patch 4 (target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
  conversion for Zvfofp8min extension)

Changes in v3
- Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
  in patch 2 & 3
- Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers

Changes in v2
- Merged v1 patch 2 & 3 to v2 patch 3, v1 patch 4 & 5 to v2 patch 4
- Added new v2 patch 2 to refactor the IEEE format NaN classification
  functions (float16, bfloat16, float32, float64) to use internal helper
  functions, reducing code duplication and improving maintainability.
  The OCP FP8 NaN classification functions follow the same pattern.
- Refactored softfloat implementation to use capability-based FloatFmt
  flags (no_infinity, limited_nan, overflow_raises_invalid, normal_frac_max)
  instead of monolithic flags
- Removed ocp_fp8e5m2_no_signal_nan and ocp_fp8_same_canonical_nan flags
  from float_status; now using local float_status with no_signaling_nans
  and default_nan_pattern for RISC-V Zvfofp8min instructions
- Rebased on latest riscv-to-apply.next with zvfbfa v3 patchset

v5: 20260427060928.2322570-1-max.chou@sifive.com
v4: 20260304134006.2908449-1-max.chou@sifive.com
v3: 20260204051756.667397-1-max.chou@sifive.com
v2: 20260127063723.442734-1-max.chou@sifive.com
v1: 20260108151650.16329-1-max.chou@sifive.com


Max Chou (9):
  fpu: Fix biased exponent write in parts_float_to_e5m2 saturate path
  target/riscv: rvv: Fix NOP_UU_B vs2 width
  target/riscv: Add cfg property for Zvfofp8min extension
  target/riscv: Add implied rules for Zvfofp8min extension
  target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
    conversion for Zvfofp8min extension
  target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
    conversion for Zvfofp8min extension
  target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
    extension
  target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
    for Zvfofp8min extension
  disas/riscv: Add support of Zvfofp8min extension

 disas/riscv.c                                 |  19 ++-
 fpu/softfloat.c                               |   3 +-
 target/riscv/cpu.c                            |  13 +-
 target/riscv/cpu_cfg_fields.h.inc             |   1 +
 target/riscv/helper.h                         |  12 ++
 target/riscv/insn32.decode                    |   5 +
 .../riscv/tcg/insn_trans/trans_rvbf16.c.inc   |  32 +++--
 .../riscv/tcg/insn_trans/trans_rvofp8.c.inc   | 105 +++++++++++++++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc   |  40 ++++++
 target/riscv/tcg/tcg-cpu.c                    |   5 +
 target/riscv/tcg/translate.c                  |   1 +
 target/riscv/tcg/vector_helper.c              | 120 +++++++++++++++++-
 12 files changed, 338 insertions(+), 18 deletions(-)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvofp8.c.inc

-- 
2.55.0


