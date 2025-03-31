Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C58BC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL7h-00023m-WA; Mon, 31 Mar 2025 15:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7V-00023U-JT
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7T-0003I3-Ht
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso32447345e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450504; x=1744055304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oO1HSoKRpR65JVeTOlCEoMbWXvPhzf031J5G7i2xFyc=;
 b=t5ncRQRYZ69tvOzamoxoQjj542FekrfcP71p9YtucAJb7u5UYNAkNxpaLNgiMaRyKs
 T1WVrmGWLO/BIQNbTX1ix6CAXLdWE6UgTcGT4ApIJm53/gIWM6a6eo2C37PxC/ydnyRC
 XGvNCOCSu8anyHkJgAsLPguD8fcFKes+s+FDDy7F+jS/81OtPVhSqbIWZbS2H6+tz5xa
 uOtMtGmB+zfbMyrdAB/hl0XtsIRtwBZf0wQiNTmkeW2bKqnWf6oWlS1oG7WbXnhmNPwX
 953/OxAigsmsICphrxQGObI+ERAyV4YHxF/3HycZ8tEeacRfz7U9F9ua/vpcjOzQ0Qwf
 Ax1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450504; x=1744055304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oO1HSoKRpR65JVeTOlCEoMbWXvPhzf031J5G7i2xFyc=;
 b=tg/M1Tm48Yt6/OOvPBG4gbcOqll5RhtA8DF1ndZqmP9gOfCGXLo9pvtPU00GT7YV7M
 +OpG9myatc39RN0aUunKuU7DJya0ceSUp/Cf58svnSz9ButkIGWQNNRW/qzq1vu+moEN
 gAMZ+3I9xXRbgH1LeeMBZJBwhtw4ksI7fatAbHq9JXTYPijGKLhEB056M+f8OqZqpEfp
 B/YURLE2Y++/e4uzBlt05MWFfUXvxFBhDx8DnERq5CO/SJVlf9MmgJN75cIQLPFo9FVL
 zWpbW+sBaQXjiz6XVbJzv2oEMUPb7lQnx/d+5tk7XZ5RoxenayzxC7nJ9RPKAWIuWT6I
 9iiw==
X-Gm-Message-State: AOJu0YyYNgLhn3ZCmup1Tq9K/pRRkTylkD9FHhkW7hapNw6pdmBae6JT
 pBY6EtUaWvEvVkwdq16UBOx/i803Wt9hOpYnZbOp1II1U/aJC1efHWh+diX14hqZmLnOulOQWTD
 p
X-Gm-Gg: ASbGnctiFiW/O1AQTXBG5MN9kU838wONlIXbuGSfE4N79vfQE9nlDkjRNqfEb7pHoVn
 vfr1K9ffcql7rRF0ajRtRz5u07q7K183RZ7EqDb120R0ycFTwMcI42EpiNCrwxO1ZCnln5nUJdB
 NL9FkWQqHILmdhdJvFOlUcI8RfGUCTy13sMkQtvHTROw7UQejusF2K/yBE2gY7MSDNJO+Tb2T1Z
 uS2RW+wqwCFmQg+TzMoxXmI5e+Rc5c3hob0tN+UxEUN+af9w65asBXw5kVVO1XWsFv5yZ0iR5vD
 jAn9M/qz+2uSF93Ml0iDAKSeDQK65roeDxqdVwcqI8+YUlM0ta2KZ6GFIwNeK3OESlAhDJgKwjq
 SBfDEyZi31USsj2+dvqg=
X-Google-Smtp-Source: AGHT+IG21HYk/gUo1qk7hWH+mlT/X2Ikg6+UiQOzLeRLVuEvkQdAA5y4k6bviW39DfZhPXnIYaXDMA==
X-Received: by 2002:a05:6000:2512:b0:39c:1efc:b02 with SMTP id
 ffacd0b85a97d-39c1efc0b5amr3264120f8f.28.1743450503837; 
 Mon, 31 Mar 2025 12:48:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6588e9sm12405402f8f.14.2025.03.31.12.48.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/23] Misc HW fixes for 2025-03-31
Date: Mon, 31 Mar 2025 21:47:58 +0200
Message-ID: <20250331194822.77309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The following changes since commit 0f15892acaf3f50ecc20c6dad4b3ebdd701aa93e:

  Merge tag 'pull-riscv-to-apply-20250328' of https://github.com/alistair23/qemu into staging (2025-03-28 08:06:53 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250331

for you to fetch changes up to 256ba7715b109c080c0c77a3923df9e69736ba17:

  target/mips: Simplify and fix update_pagemask (2025-03-31 21:32:43 +0200)

----------------------------------------------------------------
Misc HW patches

- Expose v7M System Control Space as little endian (Philippe)
- Deprecate MipsSim machine (Thomas)
- Improve some devices categories / descriptions (Philippe)
- Correct memory_rw_debug() prototype (Richard)
- Do not expose i.MX 8M SoC as user-creatable (Bernhard)
- Do not expose some PLL & eFuse devices as user-creatable (Philippe)
- Do not reset Goldfish RTC time on machine reset (Heinrich)
- Fix incorrect BCM2835 AUX interrupt ID when RX disabled (Chung-Yi)
- Fix DesignWare PCI host bridge ATU_UPPER_TARGET register access (Philippe)
- Memory leak fixes (Bernhard & Zheng Huang)
- Prevent out-of-bound access in avr_print_insn (Richard)
- Fixes around MIPS page mask (Richard)

----------------------------------------------------------------

Bernhard Beschow (3):
  hw/arm/imx8mp-evk: Fix reference count of SoC object
  hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
    TYPE_SYS_BUS_DEVICE
  hw/arm/fsl-imx8mp: Remove unused define

Chung-Yi Chen (1):
  hw/char/bcm2835_aux: Fix incorrect interrupt ID when RX disabled

Heinrich Schuchardt (1):
  hw/rtc/goldfish: keep time offset when resetting

Philippe Mathieu-Daudé (9):
  hw/arm/armv7m: Expose and access System Control Space as little endian
  hw/block/m25p80: Categorize and add description
  hw/display/dm163: Add description
  hw/dma/i82374: Categorize and add description
  hw/misc/pll: Do not expose as user-creatable
  hw/nvram/xlnx-efuse: Do not expose as user-creatable
  hw/pci-host/designware: Fix ATU_UPPER_TARGET register access
  target/hppa: Remove duplicated CPU_RESOLVING_TYPE definition
  target/sparc: Log unimplemented ASI load/store accesses

Richard Henderson (5):
  hw/core/cpu: Use size_t for memory_rw_debug len argument
  target/avr: Fix buffer read in avr_print_insn
  target/mips: Revert TARGET_PAGE_BITS_VARY
  target/mips: Require even maskbits in update_pagemask
  target/mips: Simplify and fix update_pagemask

Thomas Huth (1):
  hw/mips: Mark the "mipssim" machine as deprecated

Zheng Huang (3):
  hw/scsi/lsi53c895a: fix memory leak in lsi_scsi_realize()
  hw/sd/sdhci: free irq on exit
  hw/ufs: free irq on exit

 docs/about/deprecated.rst           | 13 ++++++++++++
 include/hw/arm/fsl-imx8mp.h         |  4 ++--
 include/hw/core/cpu.h               |  2 +-
 target/hppa/cpu.h                   |  2 --
 target/mips/cpu-param.h             |  5 -----
 target/mips/tcg/tcg-internal.h      |  2 +-
 target/sparc/cpu.h                  |  2 +-
 hw/arm/armv7m.c                     | 14 ++++++-------
 hw/arm/fsl-imx8mp.c                 |  2 +-
 hw/arm/imx8mp-evk.c                 |  2 +-
 hw/block/m25p80.c                   |  2 ++
 hw/char/bcm2835_aux.c               |  2 +-
 hw/display/dm163.c                  |  2 +-
 hw/dma/i82374.c                     |  2 ++
 hw/mips/fuloong2e.c                 |  1 -
 hw/mips/loongson3_virt.c            |  1 -
 hw/misc/bcm2835_cprman.c            |  8 ++++++++
 hw/misc/npcm_clk.c                  |  6 ++++++
 hw/misc/stm32l4x5_rcc.c             |  4 ++++
 hw/nvram/xlnx-efuse.c               |  2 ++
 hw/pci-host/designware.c            |  2 +-
 hw/rtc/goldfish_rtc.c               | 13 ++++++------
 hw/scsi/lsi53c895a.c                |  2 +-
 hw/sd/sdhci-pci.c                   |  2 ++
 hw/ufs/ufs.c                        |  3 +++
 target/avr/disas.c                  | 21 ++++++++++++-------
 target/mips/tcg/system/cp0_helper.c | 32 +++++++++--------------------
 target/mips/tcg/system/tlb_helper.c |  4 ++--
 target/sparc/ldst_helper.c          |  6 ++++++
 target/sparc/mmu_helper.c           |  2 +-
 30 files changed, 99 insertions(+), 66 deletions(-)

-- 
2.47.1


