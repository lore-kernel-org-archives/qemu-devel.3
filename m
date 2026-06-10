Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34442CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXG-0007YZ-8o; Wed, 10 Jun 2026 12:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXE-0007Xt-EB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXC-0005ON-20
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so61172345e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107924; x=1781712724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vQGFDL4RYImetriXO4xxE5fhZKedj1I/7twE8lmv9iQ=;
 b=sk7JY5kE25bMmT431qfICJ7OQx3DQbifGS40eHnmPPG4ZWaidboCX8OJjjXGJ2QZ3m
 dFPnW0E8s5DXEGzcq3JO11aAVrxcF8U+MS2GXshKtpJ9TuywMN9UD8x2wn21gkxIJ0mw
 eh/bGDz1gylU0FwqPBwYf3Ftm4jtMKTJA7RWksBUwNGDQzAw9vDRXbC/FhrVaEWjej0j
 SsQ3eLTMQvoGz2yKUHfnKdteP5WHvef4miJhxKDRmYrfVZxIw13j5W4qxkWMhasMdbL5
 PGjhtYy8UDi+dvlAqptvVfSPpUoIzfzSgd8tAPVfwlcE5AcIEVSq0NY4RZEe64oXLF8N
 a9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107924; x=1781712724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQGFDL4RYImetriXO4xxE5fhZKedj1I/7twE8lmv9iQ=;
 b=lCQDJh/McrbAInV9N1zz1vWTZSm7RoK1aEvZOqQ/eb0cMohZRzEt7/uQ6wLnApgvjt
 4RnmfaZlmuMMMjU5CXkr15ZoTX0gvhMLIIhIEMGEezN0wruXDLjGnSkPSpeIjp9y6UDS
 +gyrXOlRZSHntQXn632oWWL3bQ79weHCtuxIa1234Z1zCbfkWd+6nkTinPgzdQibG2Jg
 HH62ODb1qUI5X6Qo+glqkD/zNHWRbYlUOy7wmCU8vybvrZIOT1hSMrHdZNc4ua9YR6ml
 /hPL0kdVMDTs+Pkat/6+GFGxt/IDsZq3DaWv5WQip3402MANquO9m+zYfd8UfhSop56R
 RGfQ==
X-Gm-Message-State: AOJu0YzvxHnt2Y5KtEo2LygByYwa3jAQxzKhYZ/pS1EA63QMvwBPyoUA
 IC9Sw05o819Xq0Z8+wdz01aqqH0Lh/AT6OLbJVQ12iPi0GVqpnLAkkM8yn6PdmKDuh4MTAsGFu0
 xzGc0
X-Gm-Gg: Acq92OEU1nfoqrGNClJj+sez9UovQVxTL1o6KCQpSBpIgUkPVQJ//zk94jM+QNShOXb
 FLAureURXSgU0SIH5PC30aPuu76vx0D7rvmOUN9qBW/As6gAfK1umacCqFo+4VLSwtZ9HEjmQ8t
 +V8OJ44cBStvIDHSPUqXW6FVDZRzTgUkEhAiiFQbWA3yWXzDga4nUmzr9cI9zr4Ony7qWagb4op
 XloBumakMo8QnFHGSuDqQpv6JdjNNO4V9wV3hr9fd+ENkEWOKkkOSUDmFBWK3RJSK/Vt7Iepf2a
 qu7w9o7qfxoGiLRZRTw+ppj7CWdkE5lGlu5D5rKqWN58Xsz17IeDvXOrjE31ykHp9R5U/uDHClg
 z5xZdz+WnK01vzQctBYw5qBhlUSzg5oAMNJi8AUPPVwwFOjoEwimcfpw5wkJ0Lw57IdhdM8h9Me
 sP7i5Lw6/W6h3CJvkLoyWPRTVmy0M53ybsR1fQgDXqdQTejjbV6+VIxGA8SamL4+oJxhDnHr5zD
 rBkhhY9SfSo1IXIzM/h5VyLGqd+59cEHyoRBhaTRiw=
X-Received: by 2002:a05:600c:6096:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490c25c70cfmr426545475e9.11.1781107924378; 
 Wed, 10 Jun 2026 09:12:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/71] target-arm queue
Date: Wed, 10 Jun 2026 17:10:51 +0100
Message-ID: <20260610161202.2235298-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi; here's an arm pullreq. The biggest part of this is RTH's
patches implementing FEAT_FP8 and related features. Gabriel
Brookman's MTE4 emulation is also in here.

thanks
-- PMM

The following changes since commit de5d8bfd6105d3dd3ae668df9762df244a6d1506:

  Merge tag 'pull-loongarch-20260609' of https://github.com/gaosong715/qemu into staging (2026-06-09 14:00:28 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260610

for you to fetch changes up to c45b02cb24ee20ffee2508f50278b392526427eb:

  target/arm: Enable FEAT_F8F16MM for -cpu max (2026-06-10 16:54:40 +0100)

----------------------------------------------------------------
target-arm queue:
 * Emulate various FP8 related features: FEAT_F8F16MM, FEAT_F8F32MM,
   FEAT_FP8DOT2, FEAT_SSVE_FP8DOT2, FEAT_FP8DOT4, FEAT_SSVE_FP8DOT4,
   FEAT_FP8FMA, FEAT_SSVE_FP8FMA, FEAT_SME_LUTv2, FEAT_FP8, FEAT_LUT
 * Emulate MTE4 features: FEAT_MTE_CANONICAL_TAGS,
   FEAT_MTE_NO_ADDRESS_TAGS, FEAT_MTE_PERM,FEAT_MTE_STORE_ONLY,
   FEAT_MTE_TAGGED_FAR
 * target/arm: fix WFET typo in syndrome
 * target/arm: Preparatory patches for implementing WFE
 * hw/dma/pl080: Don't use hw_error() for unimplemented features
 * hw/intc/exynos4210_combiner: Avoid hw_error for guest errors
 * hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet
 * hw/core/qdev-clock: Fix potential null pointer dereference

----------------------------------------------------------------
Alex Bennée (4):
      target/arm: fix WFET typo in syndrome
      target/arm: teach arm_cpu_has_work about halting reasons
      target/arm: redefine event stream fields
      target/arm: ensure aarch64 DISAS_WFE will exit

Gabriel Brookman (15):
      target/arm: implement MTE_PERM
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: mte_check unemitted on STORE_ONLY load
      linux-user: add MTE_STORE_ONLY to prctl
      target/arm: emit tag check when MTX without TBI
      target/arm: add MTX to MTEDESC and DisasContext
      target/arm: add canonical tag check helper
      target/arm: add canonical MTE check logic
      target/arm: load on canonical tag loads ext bits
      target/arm: fault on tag store to canonical tag
      target/arm: skip tag bit bounds check if MTX is on
      target/arm: tag is not a part of PAuth with MTX
      docs: add MTE4 features to docs
      tests/tcg: add test for MTE FAR
      tests/tcg: add test for MTE_STORE_ONLY

Munkhbaatar Enkhbaatar (2):
      hw/usb/hcd-ohci: Assert isochronous TDs are never deferred
      hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet

Peter Maydell (2):
      hw/intc/exynos4210_combiner: Avoid hw_error for guest errors
      hw/dma/pl080: Don't use hw_error() for unimplemented features

Richard Henderson (47):
      fpu: Handle all rounding modes in partsN_uncanon_normal
      fpu: Handle all rounding modes in partsN_round_to_int_normal
      target/arm: Use FloatParts64 in bfdotadd_ebf
      target/arm: Drop oddstatus from is_ebf and bfdotadd_ebf
      target/arm: Use FloatParts64 in f16_dotadd
      target/arm: Generalize TRANS_FEAT_STREAMING_SME2
      target/arm: Introduce arm_init_fp_status
      target/arm: Set e4m3_nan_is_snan
      target/arm: Implement BF1CVTL, BF1CVTL2, BF2CVTL, BF2CVTL2 for AdvSIMD
      target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, BF2CVTLT for SVE
      target/arm: Rename SME BFCVT patterns to BFCVT_hs
      target/arm: Implement BF1CVT, BF1CVTL, BF2CVT, BF2CVTL for SME
      target/arm: Implement F1CVTL, F1CVTL2, F2CVTL, F2CVTL2 for AdvSIMD
      target/arm: Implement F1CVT, F1CVTLT, F2CVT, F2CVTLT for SVE
      target/arm: Implement F1CVT, F1CVTL, F2CVT, F2CVTL for SME
      target/arm: Implement BFCVTN for SVE
      target/arm: Implement FCVTN (16- to 8-bit fp) for AdvSIMD
      target/arm: Implement FCVTN, FCVTN2 (32- to 8-bit fp) for AdvSIMD
      target/arm: Implement FCVTN (16- to 8-bit fp) for SVE
      target/arm: Implement FCVTNB, FCVTNT for SVE
      target/arm: Implement FCVT (FP16 to FP8) for SME
      target/arm: Implement FCVT, FCVTN (FP32 to FP8) for SME
      target/arm: Implement LUTI2, LUTI4 for AdvSIMD
      target/arm: Implement LUTI2, LUTI4 for SVE
      target/arm: Enable FEAT_LUT for -cpu max
      target/arm: Enable FEAT_FP8 for -cpu max
      target/arm: Update ID_AA64SMFR0_EL1 fields to ARM M.b
      target/arm: Implement MOVT (vector to table)
      target/arm: Implement LUTI4 (four registers, 8-bit)
      target/arm: Enable FEAT_SME_LUTv2 for -cpu max
      target/arm: Implement FMLALB, FMLALT for AdvSIMD
      target/arm: Implement FMLALB, FMLALT (FP8 to FP16) for SVE
      target/arm: Implement FMLALL{BB, BT, TB, TT} for AdvSIMD
      target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
      target/arm: Enable FEAT_FP8FMA, FEAT_SSVE_FP8FMA for -cpu max
      target/arm: Implement FDOT (FP8 to FP32) for AdvSIMD
      target/arm: Implement FDOT (FP8 to FP32) for SVE
      target/arm: Enable FEAT_FP8DOT4, FEAT_SSVE_FP8DOT4 for -cpu max
      target/arm: Implement FDOT (FP8 to FP16) for AdvSIMD
      target/arm: Implement FDOT (FP8 to FP16) for SVE
      target/arm: Enable FEAT_FP8DOT2, FEAT_SSVE_FP8DOT2 for -cpu max
      target/arm: Implement FMMLA (FP8 to FP32) for AdvSIMD
      target/arm: Implement FMMLA (FP8 to FP32) for SVE
      target/arm: Enable FEAT_F8F32MM for -cpu max
      target/arm: Implement FMMLA (FP8 to FP16) for AdvSIMD
      target/arm: Implement FMMLA (FP8 to FP16) for SVE
      target/arm: Enable FEAT_F8F16MM for -cpu max

hemanshu.khilari.foss (1):
      hw/core/qdev-clock: Fix potential null pointer dereference

 docs/system/arm/emulation.rst        |  16 +
 fpu/softfloat-parts.c.inc            |   5 +
 hw/core/qdev-clock.c                 |   9 +-
 hw/dma/pl080.c                       |   6 +-
 hw/intc/exynos4210_combiner.c        |  29 +-
 hw/usb/hcd-ohci.c                    |  10 +-
 linux-user/aarch64/elfload.c         |  13 +
 linux-user/aarch64/mte_user_helper.c |  11 +-
 linux-user/aarch64/mte_user_helper.h |  14 +-
 linux-user/aarch64/target_prctl.h    |   6 +-
 target/arm/arm-powerctl.c            |   6 +-
 target/arm/cpu-features.h            |  98 ++++
 target/arm/cpu.c                     |  60 ++-
 target/arm/cpu.h                     |  21 +
 target/arm/gdbstub64.c               |   2 +-
 target/arm/helper-fp8.h              |  14 +
 target/arm/helper.c                  |  44 +-
 target/arm/internals.h               |  62 ++-
 target/arm/kvm.c                     |   5 +-
 target/arm/machine.c                 |   2 +-
 target/arm/ptw.c                     |  60 ++-
 target/arm/syndrome.h                |   2 +-
 target/arm/tcg/a64.decode            |  39 ++
 target/arm/tcg/cpu64.c               |  21 +
 target/arm/tcg/fp8_helper.c          | 859 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-a64-defs.h     |  16 +-
 target/arm/tcg/helper-a64.c          |   7 +-
 target/arm/tcg/helper-defs.h         |   6 +
 target/arm/tcg/helper-fp8-defs.h     |  40 ++
 target/arm/tcg/helper-sme-defs.h     |   2 +-
 target/arm/tcg/hflags.c              |  25 +-
 target/arm/tcg/meson.build           |   1 +
 target/arm/tcg/mte_helper.c          | 146 +++++-
 target/arm/tcg/op_helper.c           |   3 +
 target/arm/tcg/pauth_helper.c        |  18 +-
 target/arm/tcg/sme.decode            |  25 +-
 target/arm/tcg/sme_helper.c          | 109 ++---
 target/arm/tcg/sve.decode            |  48 +-
 target/arm/tcg/sve_helper.c          |   6 +-
 target/arm/tcg/translate-a64.c       | 229 ++++++++--
 target/arm/tcg/translate-a64.h       |   1 +
 target/arm/tcg/translate-sme.c       |  71 ++-
 target/arm/tcg/translate-sve.c       | 245 +++++++++-
 target/arm/tcg/translate.h           |  10 +-
 target/arm/tcg/vec_helper.c          | 194 +++++---
 target/arm/tcg/vec_internal.h        |  12 +-
 tests/tcg/aarch64/Makefile.target    |   2 +-
 tests/tcg/aarch64/mte-10.c           |  49 ++
 tests/tcg/aarch64/mte-9.c            |  48 ++
 tests/tcg/aarch64/mte.h              |   7 +-
 50 files changed, 2428 insertions(+), 306 deletions(-)
 create mode 100644 target/arm/helper-fp8.h
 create mode 100644 target/arm/tcg/fp8_helper.c
 create mode 100644 target/arm/tcg/helper-fp8-defs.h
 create mode 100644 tests/tcg/aarch64/mte-10.c
 create mode 100644 tests/tcg/aarch64/mte-9.c

