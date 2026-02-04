Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E0CE8B39B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHF-0007Fb-KL; Wed, 04 Feb 2026 00:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHD-0007EI-T2
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:07 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHB-0007kB-MP
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:07 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35480b0827bso316466a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182284; x=1770787084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KsZtQ2ObvMVIf7+Wa+FKkcQGRYG3ndXn6b5+kmvwKhk=;
 b=hWZ2aJs676yqn2zEFVeCFw0TY0RYIZwV80REY1UEka9/8Yj7RAAGD3gbqace9d1t8f
 8BHVQuqyFdlZKtvD6oOdMwgLR3GmCDpLBiA+hACCPahbRnuMXAGDcOEkANsVa2Y2lgQs
 qijqyX9fVm2qGHYnVkSKqayhCziHi6MWEsOjvtAdvJQHlClH/G+2yAfXfNJCVs0sAUsj
 qhXoUbjRpaPyicIhKoP1MWq3R0uQHy4LMZuf1eGNkUSfBqEUS8Cry8AHAt94638v5E8P
 JkW3hMVfrnaEI8zbbZPxAZwP0BTITnNF8Wq+JoHaOaCCz/vaWlA6japlgwlLLRgRH3KO
 yYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182284; x=1770787084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsZtQ2ObvMVIf7+Wa+FKkcQGRYG3ndXn6b5+kmvwKhk=;
 b=Kr5eLAufhAZ0buLtb20kdBWLnf/S2uNHvUKebBghD7EuQB91Mt8FHq/WF6LKB8KPoz
 pA48KopDGIcdLLtM4Y4xiI/qxim+QYE8SfiRe8P27l2soGIyrqhDFXsGjaJi8Rp6JLEH
 lDPC+CofV0JEDHgPd1mzC+B+cyq9t6mFo3VCg2Eo2VOWNJthc7/R5sZEAlU8yO3E2Jfx
 +8i077vR9+Hst25RkNYPlUFvpu+6vXl22ZQYKIUV+sji/PH8VTdRjt3wnK4OrAh78ImZ
 sk/RB91mBG3PKnc2MB6KIiUSMf6y7PwPeeMPMmBmCfN6x51u6/k844zHOhPU87xSeHuN
 zcAA==
X-Gm-Message-State: AOJu0Yxkbc/RaJESBqS4syI4ts2P53zOzKTHhmW4RSDAXE10c+XPavdQ
 vgCifCN0tDjj58Njo8qI2qvs4IUL4SGp6i93TJWR+XXf8eD2KNdZoKunAh0ZhF+ke9ZN4I2brgc
 pSr+d2Bhz5lv3Gc2KYPL+NS8DGXpcauLIhcCDAQeggf4VHkRFnoFghdAwKKV+o+FFP2V4yXt2g4
 qEMmDCMhXXgD6sDRRI1JHU+WlrbnDxn7XfPfxCHlC2jMLA
X-Gm-Gg: AZuq6aIPZEhgvUO1cApKY76rHoBsaadNvRw0mBI2ZJv27g8VeFjNtQtNh+7BiUyTKwI
 CPiK2QQRbiIyGfABcF8YlGaVaKyEpLwUkrWFn4juUmyr7QoucmR288k4cf3BusKNYD4GiWK5S5X
 BeyxVBfUB1iIQVMTNw/NcPeIvcv5+GqwrZOhYpLL2UEBBSIZ/hvWnklM3Xsiac2IO3EsY3KfvF3
 LyYaPbzO0kI6MCvRuCNuhBib/1gjKrim5oTPnYvpZvXy5CXXJpfcydgvIWMekZ50GZLwuq5pBz+
 CMqG8hf3pge2yHTuUUwyK1VeYaKYkuetj7fW9kDWlynVuejvqsWKtUJTZ9cz2CN5GpDM6oant7l
 ScwwTYYZjZ9OwACgeoXZn0FaBy5o36WF6U/yxxUwnPo/ES7U+zGefJJHH3uwYN9Vu7ltJhKZtBt
 3HIXhMLBxA8rC9su7ZHaMhrsb++Z1IwuC+Gvp4ziBSW5FGmptgdJlnXR0Smp5sug5s6Vmn0N6rX
 rjAKcJaY21T/E0=
X-Received: by 2002:a17:90b:5705:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-35486cab0b4mr1798519a91.12.1770182283652; 
 Tue, 03 Feb 2026 21:18:03 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:03 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 00/19] Add OCP FP8/FP4 and RISC-V Zvfofp8min/Zvfofp4min
 extension support
Date: Wed,  4 Feb 2026 13:17:36 +0800
Message-ID: <20260204051756.667397-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102d.google.com
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

This patchset adds support for the OCP (Open Compute Project) 8-bit and
4-bit floating-point formats, along with the RISC-V Zvfofp8min and
Zvfofp4min vector extensions that provide conversion operations for
these formats.

OCP Floating-Point Formats
* The OCP FP8 specification defines two 8-bit floating-point formats:
  - E4M3: 4-bit exponent, 3-bit mantissa
    * No infinity representation; only 0x7f and 0xff are NaN
  - E5M2: 5-bit exponent, 2-bit mantissa
    * IEEE-like format with infinity representation
    * Multiple NaN encodings supported
* The OCP FP4 specification defines the E2M1 format:
  - E2M1: 2-bit exponent, 1-bit mantissa
    * No NaN representation

RISC-V ISA Extensions
* Zvfofp8min (Version 0.2.1):
  The Zvfofp8min extension provides minimal vector conversion support
  for OFP8 formats. It requires the Zve32f extension and leverages the
  altfmt field in the VTYPE CSR (introduced by Zvfbfa) to select between
  E4M3 (altfmt=0) and E5M2 (altfmt=1) formats.
  - Canonical NaN for both E4M3 and E5M2 is 0x7f
  - All NaNs are treated as quiet NaNs
  Instructions added/extended:
  - vfwcvtbf16.f.f.v: OFP8 to BF16 widening conversion
  - vfncvtbf16.f.f.w: BF16 to OFP8 narrowing conversion
  - vfncvtbf16.sat.f.f.w: BF16 to OFP8 with saturation (new)
  - vfncvt.f.f.q: FP32 to OFP8 quad-narrowing conversion (new)
  - vfncvt.sat.f.f.q: FP32 to OFP8 with saturation (new)

* Zvfofp4min (Version 0.1):
  The Zvfofp4min extension provides minimal vector conversion support
  for the OFP4 E2M1 format. It requires the Zve32f extension.
  Instructions added:
  - vfext.vf2: OFP4 E2M1 to OFP8 E4M3 widening conversion

Modifications
* Softfloat library:
  - Refactored IEEE format NaN classification to share code (new in v2)
  - New float8_e4m3 and float8_e5m2 types with NaN checking functions
  - New float4_e2m1 type for OFP4 support
  - Conversion functions: bfloat16/float32 <-> float8_e4m3/float8_e5m2
  - Conversion function: float4_e2m1 -> float8_e4m3
  - Implementation uses capability-based FloatFmt flags for format behavior
* RISC-V target:
  - CPU configuration properties for Zvfofp8min and Zvfofp4min
  - Extension implied rules (Zvfofp8min requires Zve32f and Zvfbfa)
  - Vector helper functions for OFP8/OFP4 conversion instructions
  - Disassembler support for new instructions

Changes in v3:
- Add floatN_nan_is_snan to simply the quiet/signaling NaN checking flow
  in patch 2 & 3
- Add patch 4 to fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers

Changes in v2:
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

References
* OCP FP8 specification:
  https://www.opencompute.org/documents/ocp-8-bit-floating-point-specification-ofp8-revision-1-0-2023-12-01-pdf-1
* Zvfofp8min specification (v0.2.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp8min.adoc
* Zvfofp4min specification (v0.1 commit e1e20a7):
  https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfofp4min.adoc

PS: This series depends on the Zvfbfa extension patchset which introduces:
  - The altfmt field in VTYPE CSR
  - BF16 vector operations infrastructure
  - vfwcvtbf16.f.f.v and vfncvtbf16.f.f.w base instructions

v2: <20260127063723.442734-1-max.chou@sifive.com>
v1: <20260108151650.16329-1-max.chou@sifive.com>

Based-on: <20260127014227.406653-1-max.chou@sifive.com>

Max Chou (19):
  target/riscv: rvv: Fix NOP_UU_B vs2 width
  fpu/softfloat: Refactor IEEE format NaN classification to share code
  fpu/softfloat: Refactor floatx80 format NaN classification to share
    code
  target/i386: Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
  fpu/softfloat: Support OCP(Open Compute Project) OFP8 data type
  fpu/softfloat: Support OCP(Open Compute Project) OFP4 data type
  target/riscv: Add cfg properity for Zvfofp8min extension
  target/riscv: Add implied rules for Zvfofp8min extension
  target/riscv: rvv: Make vfwcvtbf16.f.f.v support OFP8 to BF16
    conversion for Zvfofp8min extension
  target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16 to OFP8
    conversion for Zvfofp8min extension
  target/riscv: rvv: Add vfncvtbf16.sat.f.f.w instruction for Zvfofp8min
    extension
  target/riscv: rvv: Add vfncvt.f.f.q and vfncvt.sat.f.f.q instructions
    for Zvfofp8min extension
  target/riscv: Expose Zvfofp8min properity
  disas/riscv: Add support of Zvfofp8min extension
  target/riscv: Add cfg properity for Zvfofp4min extension
  target/riscv: Add implied rules for Zvfofp4min extension
  target/riscv: rvv: Add vfext.vf2 instruction for Zvfofp4min extension
  target/riscv: Expose Zvfofp4min properity
  disas/riscv: Add support of Zvfofp4min extension

 disas/riscv.c                              |  12 +
 fpu/softfloat-parts.c.inc                  | 159 +++++++++---
 fpu/softfloat-specialize.c.inc             | 287 +++++++++++----------
 fpu/softfloat.c                            | 220 +++++++++++++++-
 include/fpu/softfloat-types.h              |  17 ++
 include/fpu/softfloat.h                    | 128 ++++++++-
 target/i386/tcg/fpu_helper.c               |  30 +--
 target/riscv/cpu.c                         |  32 ++-
 target/riscv/cpu_cfg_fields.h.inc          |   2 +
 target/riscv/helper.h                      |  15 ++
 target/riscv/insn32.decode                 |   8 +
 target/riscv/insn_trans/trans_rvbf16.c.inc |  32 ++-
 target/riscv/insn_trans/trans_rvofp4.c.inc |  43 +++
 target/riscv/insn_trans/trans_rvofp8.c.inc | 105 ++++++++
 target/riscv/insn_trans/trans_rvv.c.inc    |  39 +++
 target/riscv/tcg/tcg-cpu.c                 |  10 +
 target/riscv/translate.c                   |   2 +
 target/riscv/vector_helper.c               | 135 +++++++++-
 18 files changed, 1072 insertions(+), 204 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
 create mode 100644 target/riscv/insn_trans/trans_rvofp8.c.inc

-- 
2.52.0


