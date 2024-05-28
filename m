Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C394C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUe-0001TX-9H; Tue, 28 May 2024 10:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUd-0001TN-MW
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:07:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUb-000707-Mo
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:07:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b5898so6036515e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905276; x=1717510076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9wBMHvmpwwVbW3WzjalapVQouA52u9AwBMfIzVA1PM8=;
 b=YOEsM8ZIyH8FrgCKCi0iS34nxuvDtpnHv9FAlRrUizNZ7X2Dyk28txNd7qSCdF4/uu
 bG1I8BuqgxfTi50Vt9uHxy+gjhVz5Ux+E8xhnNkxVJ8LXcBY1deCguX+F4M7QYZq5K0Y
 L1am/8pIZdXUQNcFy/hy3myyD8uS9FU3aSq4plVcKq8zwmVVuG/T/iHYQMhT5AQ5/pYq
 cc+Ul13HV9h4x2NKvExyi13bKUf+rBGP/cfyBd/OETKIOrsomoC700/vWWn/FC+PSP1x
 rm/Qbs2n5ajYURqHMOLzvCcfKW0eb1kuQBzgGyrT22pRY2kaJYN3oF+8MWQh6LNIgDpQ
 NC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905276; x=1717510076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9wBMHvmpwwVbW3WzjalapVQouA52u9AwBMfIzVA1PM8=;
 b=KkgmGLTPmqVRcnqad4p93I0yqF+Q2mMp19MJ2f3ftvdr37HF7Ld0ICbBFyhblqFf9E
 zobhEBWR/31tboQlUWJzD3lKR2H8PSheVueqfXRXqhY02YtJLCmYuJ4iig5QM6FY2fHY
 iXGsx11kMLpFyyJ4Jo9hoFk9K6QiHZbRxfu4ZqU4yL2LKAGj9TyFY3xdWgOQ3POzL6j9
 myY4ZLIH2RQ0YjlFrJc+2RsV5zf5JBBnLvhhWTwBgQ6ZVPESQaLZ/qlio7XoaievxK7I
 3x3XV7qgRZdvMLAvEu6r+7IRo+/ti54mrXJY+4xv/jvJ/zchgn4F4EGm0Ea75zRU/iPT
 YAUA==
X-Gm-Message-State: AOJu0YyY8kE+VHjY7hXoyKBVP92pTDhiX5TcoF4vru5nDumVRv2t3t9Y
 NtSELcocBnwPrAaXrRyFqVPnzEqNsvvZTSQiNtcxaDJFSpJOquWXv7iO07UapVFkkMTJUIF4p3R
 k
X-Google-Smtp-Source: AGHT+IF+xeFu5RT7FcngHH+nHVmBQdInurdRHmh2/i5sYnOhxP/KMJfe8RWb234QYSO3FxSTBbq4lg==
X-Received: by 2002:a05:6000:4026:b0:357:7488:d22b with SMTP id
 ffacd0b85a97d-3577488d7aamr6055469f8f.58.1716905275114; 
 Tue, 28 May 2024 07:07:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/42] target-arm queue
Date: Tue, 28 May 2024 15:07:11 +0100
Message-Id: <20240528140753.3620597-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi; most of this is the first half of the A64 simd decodetree
conversion; the rest is a mix of fixes from the last couple of weeks.

v2 uses patches from the v2 decodetree series to avoid a few
regressions in some A32 insns.

(Richard: I'm still planning to review the second half of the
v2 decodetree series; I just wanted to get the respin of this
pullreq out today...)

thanks
-- PMM

The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:

  Merge tag 'pull-error-2024-05-27' of https://repo.or.cz/qemu/armbru into staging (2024-05-27 06:40:42 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240528

for you to fetch changes up to f240df3c31b40e4cf1af1f156a88efc1a1df406c:

  target/arm: Convert disas_simd_3same_logic to decodetree (2024-05-28 14:29:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * xlnx_dpdma: fix descriptor endianness bug
 * hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers
 * hw/arm/npcm7xx: remove setting of mp-affinity
 * hw/char: Correct STM32L4x5 usart register CR2 field ADD_0 size
 * hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>
 * hw/input/tsc2005: Fix -Wchar-subscripts warning in tsc2005_txrx()
 * hw: arm: Remove use of tabs in some source files
 * docs/system: Remove ADC from raspi documentation
 * target/arm: Start of the conversion of A64 SIMD to decodetree

----------------------------------------------------------------
Alexandra Diupina (1):
      xlnx_dpdma: fix descriptor endianness bug

Andrey Shumilin (1):
      hw/intc/arm_gic: Fix handling of NS view of GICC_APR<n>

Dorjoy Chowdhury (1):
      hw/arm/npcm7xx: remove setting of mp-affinity

Inès Varhol (1):
      hw/char: Correct STM32L4x5 usart register CR2 field ADD_0 size

Philippe Mathieu-Daudé (1):
      hw/input/tsc2005: Fix -Wchar-subscripts warning in tsc2005_txrx()

Rayhan Faizel (1):
      docs/system: Remove ADC from raspi documentation

Richard Henderson (34):
      target/arm: Use PLD, PLDW, PLI not NOP for t32
      target/arm: Zero-extend writeback for fp16 FCVTZS (scalar, integer)
      target/arm: Fix decode of FMOV (hp) vs MOVI
      target/arm: Verify sz=0 for Advanced SIMD scalar pairwise (fp16)
      target/arm: Split out gengvec.c
      target/arm: Split out gengvec64.c
      target/arm: Convert Cryptographic AES to decodetree
      target/arm: Convert Cryptographic 3-register SHA to decodetree
      target/arm: Convert Cryptographic 2-register SHA to decodetree
      target/arm: Convert Cryptographic 3-register SHA512 to decodetree
      target/arm: Convert Cryptographic 2-register SHA512 to decodetree
      target/arm: Convert Cryptographic 4-register to decodetree
      target/arm: Convert Cryptographic 3-register, imm2 to decodetree
      target/arm: Convert XAR to decodetree
      target/arm: Convert Advanced SIMD copy to decodetree
      target/arm: Convert FMULX to decodetree
      target/arm: Convert FADD, FSUB, FDIV, FMUL to decodetree
      target/arm: Convert FMAX, FMIN, FMAXNM, FMINNM to decodetree
      target/arm: Introduce vfp_load_reg16
      target/arm: Expand vfp neg and abs inline
      target/arm: Convert FNMUL to decodetree
      target/arm: Convert FMLA, FMLS to decodetree
      target/arm: Convert FCMEQ, FCMGE, FCMGT, FACGE, FACGT to decodetree
      target/arm: Convert FABD to decodetree
      target/arm: Convert FRECPS, FRSQRTS to decodetree
      target/arm: Convert FADDP to decodetree
      target/arm: Convert FMAXP, FMINP, FMAXNMP, FMINNMP to decodetree
      target/arm: Use gvec for neon faddp, fmaxp, fminp
      target/arm: Convert ADDP to decodetree
      target/arm: Use gvec for neon padd
      target/arm: Convert SMAXP, SMINP, UMAXP, UMINP to decodetree
      target/arm: Use gvec for neon pmax, pmin
      target/arm: Convert FMLAL, FMLSL to decodetree
      target/arm: Convert disas_simd_3same_logic to decodetree

Tanmay Patil (1):
      hw: arm: Remove use of tabs in some source files

Zenghui Yu (1):
      hvf: arm: Fix encodings for ID_AA64PFR1_EL1 and debug System registers

 docs/system/arm/raspi.rst       |    1 -
 target/arm/helper.h             |   68 +-
 target/arm/tcg/helper-a64.h     |   12 +
 target/arm/tcg/translate-a64.h  |    4 +
 target/arm/tcg/translate.h      |   51 +
 target/arm/tcg/a64.decode       |  315 +++-
 target/arm/tcg/t32.decode       |   25 +-
 hw/arm/boot.c                   |    8 +-
 hw/arm/npcm7xx.c                |    3 -
 hw/char/omap_uart.c             |   49 +-
 hw/char/stm32l4x5_usart.c       |    2 +-
 hw/dma/xlnx_dpdma.c             |   68 +-
 hw/gpio/zaurus.c                |   59 +-
 hw/input/tsc2005.c              |  135 +-
 hw/intc/arm_gic.c               |    4 +-
 target/arm/hvf/hvf.c            |  130 +-
 target/arm/tcg/gengvec.c        | 1672 +++++++++++++++++++++
 target/arm/tcg/gengvec64.c      |  190 +++
 target/arm/tcg/neon_helper.c    |    5 -
 target/arm/tcg/translate-a64.c  | 3137 +++++++++++++--------------------------
 target/arm/tcg/translate-neon.c |  136 +-
 target/arm/tcg/translate-sve.c  |  145 +-
 target/arm/tcg/translate-vfp.c  |   93 +-
 target/arm/tcg/translate.c      | 1592 +-------------------
 target/arm/tcg/vec_helper.c     |  221 ++-
 target/arm/vfp_helper.c         |   30 -
 target/arm/tcg/meson.build      |    2 +
 27 files changed, 3860 insertions(+), 4297 deletions(-)
 create mode 100644 target/arm/tcg/gengvec.c
 create mode 100644 target/arm/tcg/gengvec64.c

