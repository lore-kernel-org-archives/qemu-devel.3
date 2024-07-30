Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F77C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLI-0003UF-UD; Tue, 30 Jul 2024 05:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLH-0003SW-Cl
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLF-0000Wp-JV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso19861805e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332423; x=1722937223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=AwEczY42MhFblaALEOHIc9YDov6tfs1YZvL5O8SqFPU=;
 b=IXwZDCydcJmVH29LLAvz872DLeGkva2SEBybYzpdkA7yb/Wm8GhUM/Z6t3aOjETs3+
 P6+wsS9fRVOtCT8lQ9igkOUgDunE+GMjPZbMgORt24f9o4MUWAh5ilLgdyIA/6niLO2n
 yBZB3WDg/809C4fj606+c/0mC5aOrRKuI1faAkoPu34cG1JIJHPcdZbtIvlGDOOzNupE
 LNBj/KLWuHdKVQ+z1Pms4ciuA9Veeiu+5TGhIDIkCQbRLj2qd0mjrat2tt8DFiREJZDE
 ADD/T6K4eIdCeChezT6PjU8MDPKwJWB1nUwfSdnpm/KmArcgOlLxuOm2tK2im1SMCx15
 p7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332423; x=1722937223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AwEczY42MhFblaALEOHIc9YDov6tfs1YZvL5O8SqFPU=;
 b=ow37rs0OlgLhsW+SoN9/u3x5HbIF274r7/0r9Tc3Ztc9+OIu+ko6AJIfwnp6sT6GdS
 5qYvdmujcLl0whYLWoxZVAVsh+YXnhn3DcSKVuYnksFGk627C0kGmyAT7MBJF+CAyYyq
 /TMALTSbRRtGmvnnd0L4tY5n5pGC3XRcLMCUj622ZrH5fnEFSC1rutIRF3toXkfNN3iz
 ra9vXFw/VVeaYbfUxBF6iSDu+ISH/mkec0AFo6VyCzst1xAaNHFmTx4XNdwhwkvvB2pO
 PMmMccBQVgLWBLRbdTY8Am9P5BEeUppZQnMNaCm/PLDF5NmAI7hn17Y+wy0OucWMo8f7
 3iPw==
X-Gm-Message-State: AOJu0Yzo0xy0Xc3d/e3KalZEsvHrR3TTC4LjB4zYPR55zKJbm8wFXgaV
 WNn1V8twwjfa6erzVM5T8GEW+9yShhX3vi0Csoel1uV4TYjbNuCaBUddQ095CblHfC+GrfRh/1Y
 F
X-Google-Smtp-Source: AGHT+IF3I32S+fr1eINs8CRaWmbp0jmsudDB7wQRvhKuryTiEEGdII79YjL8YrRtQR+yHs5Atqr9GQ==
X-Received: by 2002:a05:6000:1b91:b0:368:7e54:baaa with SMTP id
 ffacd0b85a97d-36b5cf254e7mr8076144f8f.4.1722332422906; 
 Tue, 30 Jul 2024 02:40:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Tue, 30 Jul 2024 10:39:59 +0100
Message-Id: <20240730094020.2758637-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Arm pullreq: these are all bugfixes. I've included a handful
of my fixes for various non-arm minor Coverity issues too.

thanks
-- PMM

The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:

  Merge tag 'pull-ppc-for-9.1-2-20240726-1' of https://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240730

for you to fetch changes up to 73188068d7ba40c8a37b4763db38bb1ce24ca07d:

  system/physmem: Where we assume we have a RAM MR, assert it (2024-07-29 17:03:35 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/char/bcm2835_aux: Fix assert when receive FIFO fills up
 * hw/arm/smmuv3: Assert input to oas2bits() is valid
 * target/arm/kvm: Set PMU for host only when available
 * target/arm/kvm: Do not silently remove PMU
 * hvf: arm: Properly disable PMU
 * hvf: arm: Do not advance PC when raising an exception
 * hw/misc/bcm2835_property: several minor bugfixes
 * target/arm: Don't assert for 128-bit tile accesses when SVL is 128
 * target/arm: Fix UMOPA/UMOPS of 16-bit values
 * target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled
 * system/physmem: Where we assume we have a RAM MR, assert it
 * sh4, i386, m68k, xtensa, tricore, arm: fix minor Coverity issues

----------------------------------------------------------------
Akihiko Odaki (5):
      target/arm/kvm: Set PMU for host only when available
      target/arm/kvm: Do not silently remove PMU
      hvf: arm: Raise an exception for sysreg by default
      hvf: arm: Properly disable PMU
      hvf: arm: Do not advance PC when raising an exception

Frederik van Hövell (1):
      hw/char/bcm2835_aux: Fix assert when receive FIFO fills up

Mostafa Saleh (1):
      hw/arm/smmuv3: Assert input to oas2bits() is valid

Peter Maydell (14):
      hw/misc/bcm2835_property: Fix handling of FRAMEBUFFER_SET_PALETTE
      hw/misc/bcm2835_property: Avoid overflow in OTP access properties
      hw/misc/bcm2835_property: Restrict scope of start_num, number, otp_row
      hw/misc/bcm2835_property: Reduce scope of variables in mbox push function
      target/arm: Don't assert for 128-bit tile accesses when SVL is 128
      target/arm: Fix UMOPA/UMOPS of 16-bit values
      target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
      target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled
      target/tricore: Use unsigned types for bitops in helper_eq_b()
      target/xtensa: Make use of 'segment' in pptlb helper less confusing
      target/m68k: avoid shift into sign bit in dump_address_map()
      target/i386: Remove dead assignment to ss in do_interrupt64()
      target/sh4: Avoid shift into sign bit in update_itlb_use()
      system/physmem: Where we assume we have a RAM MR, assert it

 hw/arm/smmuv3-internal.h       |   3 +-
 hw/char/bcm2835_aux.c          |   2 +-
 hw/misc/bcm2835_property.c     |  91 +++++++------
 system/physmem.c               |  18 ++-
 target/arm/helper.c            |   2 +-
 target/arm/hvf/hvf.c           | 302 +++++++++++++++++++++--------------------
 target/arm/kvm.c               |   7 +-
 target/arm/tcg/sme_helper.c    |   8 +-
 target/arm/tcg/translate-sme.c |  10 +-
 target/arm/tcg/translate-sve.c |  18 ++-
 target/i386/tcg/seg_helper.c   |   5 +-
 target/m68k/helper.c           |   7 +-
 target/sh4/helper.c            |   2 +-
 target/tricore/op_helper.c     |   4 +-
 target/xtensa/mmu_helper.c     |   4 +-
 15 files changed, 262 insertions(+), 221 deletions(-)

