Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710DCCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvga-0001RY-5t; Fri, 29 May 2026 07:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgY-0001R3-PJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgW-00087c-7e
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso61557265e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055246; x=1780660046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=18l804VH4GWVQ+GjIPdSoK2yU9tGEgdKVDXJrMiBDiI=;
 b=nUIhi3+mga+snw1/lB5pQe4ayJwl0xRo9BowslDi/DS3ymX+GC+pqeqI3tCHED2+LD
 iY5gGvm2HjocNm8XGHSkVoaHSDh8BnG/AcShYrK3j3Z1g+PLWvnBt5VF4CBYcoGdYDPv
 2859o3PCZLRUsahshI3JjRK8pV2iLdXwKv0EKeyTKB+5qJ8afgMKdQh5wTeF8z9KOQfc
 btWebRC4oVlKfFMS3Qx8uMWgMxYaE8lCQULXqnopScR/jK5sOtRnbnRFgPDwqvZ6VL/S
 BopMWqtTcf/uYMsnuuw+56qXhaU2LKNy8je9Dmkt75BBkSUV06Q4AoUKzza4O+UxrXaK
 6FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055246; x=1780660046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=18l804VH4GWVQ+GjIPdSoK2yU9tGEgdKVDXJrMiBDiI=;
 b=XOUXrThqhX+5l+v6Yv2waiPv9PBGTSLIo2025yano7iNpOQdNI9R4VqIxGSfiv9Ugs
 dPVeylrC9F5jR0nonx+JdmhfMAOffJN76Y8ZkkUUXKcwPylJYIqEMcAOG5DUz+FdxKhu
 1pb/iThQ+8WZJg+yfu69NjqMOfONEBECvuXN05PueFldeIsW0EV/hja7kKs6M9DpsjQq
 AptrMHjBIp09u5L99cAlTVqxqrF42jcWcFuvfQKjjtj3r1BXQXJOzS9pPGuCzG57l6Y5
 c7UJPzzwR5HjrxqhQ8K7px2bYHqI7BDZw7493RAIzkalCpRLEpDD8tJ090RxVc5zvPbz
 Dt7g==
X-Gm-Message-State: AOJu0Ywrl1w39BnA1OPqAmhSAkLi5OGs7tim23gS9xuQe4v18fTXrgPK
 Q87p/DeXPA8OfzZLdoAuKqAWnTclcAuyR0h3HLZB/iq2NvNpUa4evwGRmL+EYGQ0lwdeQE8LhZU
 kE1KZ
X-Gm-Gg: Acq92OGwhvw/v9olJhhea2s7BWHwZq1o9m8hxsjnmJOlTxzcPsRYCU8IZ9b+5OwGVYo
 DeU9083PH1BhkpXXEis8Yn8WtyfxNecZ1sQ+9HBfL/ICZUYU8jKx2JraLTCUMu8CapzVaVkCNgV
 q/wSVWTRrPGHKQVWluKVQf5i9cYX3YnXvWBdHd76sMQmYOm0+B4TXrv8N6BoDJxDun7S6EP1Ofw
 TItHBl78Nmov6KKCk5r2zNQ5SXzR4Xl6I9MTEzmYGyGvGlIbZj/dvZqhS7f5SQ0oVRaySfA1KLI
 lAmbezdMvoi0Vo8uTRffY6RN8U0fVb6tXIFbl/VdOnJeETT/eAwGHE4yRLXMaGXIL/vliTIRt+n
 cGgRbYfgl6nwjAbW2BUy13Zy/Qag650Tlw4+PLQN7CHgnXHKcLn9DdCra5aUVYqtknWbPi1TTb1
 NkaZ8P1Am5KIaSNB6aYE4rh8gcGAfCoQzjQb2A3R1N31eD9Fdo+FmYv/0ai669bsqYsRRKzP6At
 gJ4IbddsX4RoGNnYkU1Mec4DgVKB8CfKooDar+v4g==
X-Received: by 2002:a05:600c:4e55:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-4909c0a7eeemr51457885e9.16.1780055245567; 
 Fri, 29 May 2026 04:47:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Fri, 29 May 2026 12:47:01 +0100
Message-ID: <20260529114723.42040-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi; here's an arm pullreq. This is mostly bug fixes; the
new features are emulation of a couple of small Arm CPU features.

thanks
-- PMM


The following changes since commit 2db91528542672cf0db78b3f2cc0e22b36302b38:

  Merge tag 'pull-vfio-20260527' of https://github.com/legoater/qemu into staging (2026-05-27 14:45:58 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260529

for you to fetch changes up to 44f2c7f3df0028de7991385f568add12e24aca47:

  hw/dma/omap_dma: Fix indentation after ifdef removal (2026-05-29 10:18:11 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Implement FEAT_CMPBR emulation
 * target/arm: Implement FEAT_RNG_TRAP emulation
 * target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
 * target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16 behaviors"
 * target/arm: Enable REVD for SVE2.1
 * zynq: Various minor bug fixes
 * hw/misc: Add dummy ZYNQ DDR controller
 * hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
 * hw/dma/omap_dma: Remove unused ifdeffed out code

----------------------------------------------------------------
Jason Wright (2):
      target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
      target/arm: advertise FEAT_RNG_TRAP on cortex-max

Peter Maydell (5):
      target/arm: Don't assert if 64-bit EL2 AT insn sees a Domain fault
      target/arm: SME BFCVT, BFCVTN have "Alternate BFloat16 behaviors"
      hw/dma/omap_dma: Remove unused ifdeffed out code
      hw/dma/omap_dma: Fix coding style in omap_dma_transfer_setup()
      hw/dma/omap_dma: Fix indentation after ifdef removal

Richard Henderson (5):
      target/arm: Enable REVD for SVE2.1
      target/arm: Add feature predicate for FEAT_CMPBR
      target/arm: Implement CB, CBB, CBH
      target/arm: Implement CB (immediate)
      target/arm: Enable FEAT_CMPBR for -cpu max

YannickV (9):
      hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
      hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
      hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in user mode
      hw/dma/zynq-devcfg: Simulate dummy PL reset
      hw/dma/zynq-devcfg: Indicate power-up status of PL
      hw/misc: Add dummy ZYNQ DDR controller
      hw/misc/zynq_slcr: Add logic for DCI configuration
      hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
      hw/arm/xilinx_zynq: Split xilinx_zynq into header and implementation files

 MAINTAINERS                      |   2 +
 docs/system/arm/emulation.rst    |   2 +
 hw/arm/Kconfig                   |   1 +
 hw/arm/xilinx_zynq.c             |  29 ++-
 hw/block/m25p80.c                |   3 +-
 hw/dma/omap_dma.c                | 247 ++++++++---------------
 hw/dma/xlnx-zynq-devcfg.c        |  27 ++-
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/xlnx-zynq-ddrc.c         | 421 +++++++++++++++++++++++++++++++++++++++
 hw/misc/zynq_slcr.c              |  31 +++
 include/hw/arm/xilinx_zynq.h     |  30 +++
 include/hw/misc/xlnx-zynq-ddrc.h | 147 ++++++++++++++
 linux-user/aarch64/elfload.c     |   1 +
 target/arm/cpu-features.h        |  10 +
 target/arm/helper.c              |  58 +++++-
 target/arm/internals.h           |  10 +
 target/arm/tcg/a64.decode        |  11 +
 target/arm/tcg/cpu64.c           |   3 +-
 target/arm/tcg/translate-a64.c   |  86 ++++++++
 target/arm/tcg/translate-sme.c   |   4 +-
 target/arm/tcg/translate-sve.c   |   3 +-
 22 files changed, 939 insertions(+), 191 deletions(-)
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/arm/xilinx_zynq.h
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

