Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79838C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATb-0007y4-Uv; Thu, 23 May 2024 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007jr-DU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATF-0002Ri-D7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41fc5645bb1so51084685e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478507; x=1717083307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf0hQsGVSqS++3HNrIAL2Y7P8r1tW6aT95KUaTxIu7k=;
 b=saIJ7hqA2DzYo5r8+KJFVfqzTn0khuRoZiBQsaByKX0xQO34870OrEJVijPmCiBzLb
 ieDAbo4ItLD53JkdxNHs0tNZeeutkTVbNHmHEru2Uk9vCOHVNVOP4Ni/pepzPmFc03Ba
 mVgXmo+JQaOLkN/8W17uEgCZ4IktaGQH1992LGKISOYOG/Pw6iZjZZvnxii7qgJpufIf
 Y6AicJ5bQiYMkihXdHrRWT3faThvYGK0+/gtn3OXwZ9xGO3yrD8O1WLDHFYMiCPrqZ6u
 BXyZTqkKIOu8DCj5pTCyFxbXxvPEfmE3YmUGlvR50GYVDTejKcqfkOWYhHDneW+nkPCn
 9WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478507; x=1717083307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bf0hQsGVSqS++3HNrIAL2Y7P8r1tW6aT95KUaTxIu7k=;
 b=srJQk6UVyMYNqHiEXe/Yb4FEu5OBw3Cz5MaYNSbqBTWA7znqw8LTAP6vbg7mVweRsz
 8EaGvO/r7Hz9Y0ILIS9mPwk7w0prNKdiTYTNz2sWu2DYm6+GyCqMtPirI3IVOjunihqu
 Cs6gX0w/zbTNX3b8cFHVjMuDSINv26wdOjEp/u1sVQRd/HE/hRu0q7zSzhRBfDxx3AW3
 /ymnzGzhSxACJlQIhqYhsL2XRaS6VW/A+H+W8c2qAkyfOdpW6TA0pHoAWq2U9SeEqTGC
 XyXYvUAVT/ov23vmr3PXbnl6oRsFiousAMfaqststxvKdzm9SI/S6201lWKFJc2bSk6N
 M4DA==
X-Gm-Message-State: AOJu0YzXHRK5LcMPE2gkneLFuWGJJB7mh9mqyCLoWJjjZ7NQ5ulU0Pa3
 6cveR4hySzxnr0Lsd9SHdNYZm+GR5lX1cjybZiBnWKDm8DPnaXLrCaY5/BHzlo3hPyRTybn2fvg
 v
X-Google-Smtp-Source: AGHT+IGujDTwUvH4wY+/0j7160WVmcr2UQ0Pa+YG/kzoAR916AatUVMwsElS90hEs7Z3IU9LepXfAg==
X-Received: by 2002:a05:6000:36d:b0:34a:1a7a:9d60 with SMTP id
 ffacd0b85a97d-354da7b4b64mr4453915f8f.62.1716478507274; 
 Thu, 23 May 2024 08:35:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/37] target-arm queue
Date: Thu, 23 May 2024 16:34:28 +0100
Message-Id: <20240523153505.2900433-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Hi; most of this is the first half of RTH's decodetree conversion;
the rest is a mix of fixes from the last couple of weeks.

thanks
-- PMM

The following changes since commit 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e:

  Merge tag 'migration-20240522-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-05-22 15:32:25 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240523

for you to fetch changes up to 051aca523db178ad4c49d5ed736ad26308d1df7b:

  target/arm: Convert disas_simd_3same_logic to decodetree (2024-05-23 16:06:29 +0100)

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

Richard Henderson (29):
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
 target/arm/tcg/translate-a64.c  | 3110 +++++++++++++--------------------------
 target/arm/tcg/translate-neon.c |  136 +-
 target/arm/tcg/translate-sve.c  |  145 +-
 target/arm/tcg/translate-vfp.c  |   54 +-
 target/arm/tcg/translate.c      | 1588 --------------------
 target/arm/tcg/vec_helper.c     |  221 ++-
 target/arm/vfp_helper.c         |   30 -
 target/arm/tcg/meson.build      |    2 +
 26 files changed, 3807 insertions(+), 4255 deletions(-)
 create mode 100644 target/arm/tcg/gengvec.c
 create mode 100644 target/arm/tcg/gengvec64.c

