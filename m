Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8373C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zf-0004Mn-W3; Fri, 31 May 2024 08:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zX-0004J7-95
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zQ-0003Nu-Ol
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:14 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b8254338dso1851145e87.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157044; x=1717761844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sgE6YxzTARKnwCB6Tq3lt/9DTqfCWthzeOBMZGeeSFU=;
 b=jqtR/mxi5VC11REiZYD1rw3LBQ0s453+pSUhU+OIFEbWEU1PpVg91WTiP3ROVxaiGK
 dTVIUEHBSIQzFU+yTbOj2TIm/Zep8FxahWpodwHfdKIULT2dDnv/n4zc5yWN+yZ4h4ZS
 WX4zmj2C1Q9zbzG2V3nScqMmfkDk2iAsG4ETGub6BeJ4auDBLf2DPAIp0Q9MIHI0+V8D
 S6r7PD22/UJjQAw5MUJ/EseW5YZJE0p2mystUlwX1KEEntatUxbclwNRAZKkt4VUt4/l
 REpH3O1F/mfKGFX0EINaRqAqRrp+1DDIHMkseYD6RnqkWip9R2pP/e3aRtYZ69zFvs8+
 LHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157044; x=1717761844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgE6YxzTARKnwCB6Tq3lt/9DTqfCWthzeOBMZGeeSFU=;
 b=c6id/Xo91sp0DKe1ldletv4mni5+MrKMpZqIz9NbzrSc/XIQ5mKEd75FftJOrdn60R
 vA+/soM0DfV6AewBo9K4K4UY3b1CO5H3EiDjUx40Nx2zwGL9M0g1qU6/J+r2bBXe5VEY
 CPL1j5fMjEC+oclAx4wnx2iToOXMMtgiwX8KBQZTIXR0iG64ljydjGDitAnxASswP7SP
 Ybb+spHN8duipQYN3dxb76FN/0vIBlsvDXykGnCoeRTznZgWYSaPfIQe9NWVkBEEwnus
 FssvpSsZTzvgfy1RwYBUHWVfGf6xWLIe778Fyk7JQh2zlh0luQTNthsKoaTIAQNlmxaQ
 JTbA==
X-Gm-Message-State: AOJu0Yx4jlefeZu6rYfiaL+ufX4Sg5R5zF4XoO13sVLnDJu+1lYovrXp
 XcHVq2EQMzajdObhhChdCkB70nX18doLH+xqh3DAKipnI695MPaNCtHVokClnvvT3TE7I5+4Q7u
 M
X-Google-Smtp-Source: AGHT+IGN7NwwludG+IpQOJ7uCxm+MdLnOgTD7DCA/emvEQkEGOEGH9yH5mlIA3F5nt95EG5eVSvRSg==
X-Received: by 2002:a05:6512:3456:b0:51d:a541:733 with SMTP id
 2adb3069b0e04-52b896dac80mr1008127e87.66.1717157043920; 
 Fri, 31 May 2024 05:04:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Fri, 31 May 2024 13:03:18 +0100
Message-Id: <20240531120401.394550-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 3b2fe44bb7f605f179e5e7feb2c13c2eb3abbb80:

  Merge tag 'pull-request-2024-05-29' of https://gitlab.com/thuth/qemu into staging (2024-05-29 08:38:20 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240531

for you to fetch changes up to 3c3c233677d4f2fe5f35c5d6d6e9b53df48054f4:

  hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT (2024-05-31 11:26:00 +0100)

----------------------------------------------------------------
target-arm:
 * hw/intc/arm_gic: Fix set pending of PPIs
 * hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
 * xilinx_zynq: Add cache controller
 * xilinx_zynq: Support up to two CPU cores
 * tests/avocado: update sbsa-ref firmware
 * sbsa-ref: move to Neoverse-N2 as default
 * More decodetree conversion of A64 ASIMD insns
 * docs/system/target-arm: Re-alphabetize board list
 * Implement FEAT WFxT and enable for '-cpu max'
 * hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT

----------------------------------------------------------------
David Hubbard (1):
      hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT

Marcin Juszkiewicz (3):
      tests/avocado: update sbsa-ref firmware
      arm/sbsa-ref: move to Neoverse-N2 as default
      target/arm: Disable SVE extensions when SVE is disabled

Peter Maydell (3):
      docs/system/target-arm: Re-alphabetize board list
      accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool for whether to halt
      target/arm: Implement FEAT WFxT and enable for '-cpu max'

Richard Henderson (32):
      target/arm: Improve vector UQADD, UQSUB, SQADD, SQSUB
      target/arm: Assert oprsz in range when using vfp.qc
      target/arm: Convert SUQADD and USQADD to gvec
      target/arm: Inline scalar SUQADD and USQADD
      target/arm: Inline scalar SQADD, UQADD, SQSUB, UQSUB
      target/arm: Convert SQADD, SQSUB, UQADD, UQSUB to decodetree
      target/arm: Convert SUQADD, USQADD to decodetree
      target/arm: Convert SSHL, USHL to decodetree
      target/arm: Convert SRSHL and URSHL (register) to gvec
      target/arm: Convert SRSHL, URSHL to decodetree
      target/arm: Convert SQSHL and UQSHL (register) to gvec
      target/arm: Convert SQSHL, UQSHL to decodetree
      target/arm: Convert SQRSHL and UQRSHL (register) to gvec
      target/arm: Convert SQRSHL, UQRSHL to decodetree
      target/arm: Convert ADD, SUB (vector) to decodetree
      target/arm: Convert CMGT, CMHI, CMGE, CMHS, CMTST, CMEQ to decodetree
      target/arm: Use TCG_COND_TSTNE in gen_cmtst_{i32, i64}
      target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
      target/arm: Convert SHADD, UHADD to gvec
      target/arm: Convert SHADD, UHADD to decodetree
      target/arm: Convert SHSUB, UHSUB to gvec
      target/arm: Convert SHSUB, UHSUB to decodetree
      target/arm: Convert SRHADD, URHADD to gvec
      target/arm: Convert SRHADD, URHADD to decodetree
      target/arm: Convert SMAX, SMIN, UMAX, UMIN to decodetree
      target/arm: Convert SABA, SABD, UABA, UABD to decodetree
      target/arm: Convert MUL, PMUL to decodetree
      target/arm: Convert MLA, MLS to decodetree
      target/arm: Tidy SQDMULH, SQRDMULH (vector)
      target/arm: Convert SQDMULH, SQRDMULH to decodetree
      target/arm: Convert FMADD, FMSUB, FNMADD, FNMSUB to decodetree
      target/arm: Convert FCSEL to decodetree

Sebastian Huber (4):
      hw/intc/arm_gic: Fix set pending of PPIs
      hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
      hw/arm/xilinx_zynq: Add cache controller
      hw/arm/xilinx_zynq: Support up to two CPU cores

 docs/system/arm/emulation.rst            |    1 +
 docs/system/target-arm.rst               |    6 +-
 include/hw/core/tcg-cpu-ops.h            |   15 +-
 target/arm/cpu-features.h                |    5 +
 target/arm/cpu.h                         |    3 +
 target/arm/helper.h                      |   97 ++-
 target/arm/internals.h                   |    8 +
 target/arm/tcg/translate-a64.h           |   14 +
 target/arm/tcg/translate.h               |   44 +
 target/i386/tcg/helper-tcg.h             |    2 +-
 target/arm/tcg/a64.decode                |  119 +++
 target/arm/tcg/neon-dp.decode            |   37 +-
 accel/tcg/cpu-exec.c                     |    7 +-
 hw/arm/sbsa-ref.c                        |    2 +-
 hw/arm/xilinx_zynq.c                     |   55 +-
 hw/intc/arm_gic.c                        |   12 +-
 hw/usb/hcd-ohci.c                        |    5 +
 target/arm/cpu.c                         |   40 +
 target/arm/cpu64.c                       |    6 +-
 target/arm/helper.c                      |    4 +-
 target/arm/machine.c                     |   20 +
 target/arm/tcg/cpu64.c                   |    1 +
 target/arm/tcg/gengvec.c                 |  689 ++++++++++++++-
 target/arm/tcg/gengvec64.c               |  181 ++++
 target/arm/tcg/neon_helper.c             |  506 +++--------
 target/arm/tcg/op_helper.c               |   54 ++
 target/arm/tcg/translate-a64.c           | 1362 +++++++++++-------------------
 target/arm/tcg/translate-neon.c          |  118 +--
 target/arm/tcg/vec_helper.c              |  128 +++
 target/i386/tcg/sysemu/seg_helper.c      |    3 +-
 hw/arm/Kconfig                           |    1 +
 hw/usb/trace-events                      |    1 +
 tests/avocado/machine_aarch64_sbsaref.py |   20 +-
 33 files changed, 2034 insertions(+), 1532 deletions(-)

