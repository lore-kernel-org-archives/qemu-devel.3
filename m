Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8342CC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bl-0005M2-Oz; Tue, 21 Jul 2026 04:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bk-0005LI-9n
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:56 -0400
Received: from mail-wm2-x09.google.com ([2a00:1450:4864:31::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bi-0005fi-GZ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:50:56 -0400
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-49553da76dcso10038785e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623853; x=1785228653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1kyKn+GcUZJvG04ymgDR9MxyuSI0QZ12iCuSZmsG/QM=;
 b=YRQkcraKzx20feBxJd70/i8tGC2m+0xRrioyBCS7hiIinkqAtJJGE7wHGwP5PVjVrc
 8uXmFHRlOslo35yz+Fn//xCaJ2vauy6BnjApPvBGnDCMr2j6t4Gk26+Zk+lPTWuZ2nAq
 sg/A7GenzXL48UU0mOOx3plkJxgVFy2U661B/2Ebv56aca4uPd26hEiuZkkzZMe8ON9/
 ZvuNBQD/FeAv7P1NzfDuxXcIz7eQ3/6fX+ZKRocPeG+lfCtjz8O/lf3Yu7KXsL4GhRx+
 2CnBW/b0S3AwV/6X2/Sf3U+vUtfwsUldQhCRLoBYJftoDfz+xSPCTi8l02QfHmWIzJOj
 Y4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623853; x=1785228653;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1kyKn+GcUZJvG04ymgDR9MxyuSI0QZ12iCuSZmsG/QM=;
 b=gbNHfmWOLQLE/clUBvsWfI9dqhAd+UDKldSUJGi04jZ/ORI5VS6Kye11STZfzHaQU6
 cfcE7KeizRRApmyRkr5VtXN7H+pwm7/Ek/6xsbGWS03jlxifKR4v9n4Ka9ew5thMk8U2
 +RUkaNsq3+9wwOVzbWRCTKDZEv7B19+8F8gZ8KOdXp+JtzxnCQb9IMpdXFj+qBva9Z1Z
 YChFklFsdGteA+VTdvw36Eko1CYd+pqitqy/+V7+0KevzBEj6V0ja28QRq0YRBSOfAjj
 35reqs2SgHvi2mHnNwDkVMowILuwg29rSKERd+JTa00hM6twyeIN/XygUacsRjttzKwq
 xbhQ==
X-Gm-Message-State: AOJu0YxjHOfbnAVl0d86mA6T5puljrcDtphXfkJnMKHHA4dY7csGvCgX
 JBzv4zZVYXZdsb9ANtsZ4Y8/7InCnbXPWpl8BsXFxPhXAwI5pQ/KLd5yVRJ2Zz0vyUFcMa2z4LT
 gjayJAWNaDuAs
X-Gm-Gg: AfdE7cm0Sppx1yRbqUCpH/GERVzj0FA7i4euombpd533x4g3Sp7GCfR8EvcLWVmUyxV
 Mnsd/9WBa/b/vCGwd2UvLyQ2QSOlx2fvbdsJatBgpfjAs46dwQP4svyff+xrrdLNcawi3/n5N1X
 04d0B3In9rDFP/vlTpxDmjWVZ36OZXMo6UYN2epKKdqiiCldYJD4+yWa2T2AwQiGZffJPni2XBi
 ur63MxXCb2fD3sPs+wj0NZthKLledQA+MS2QR6ohviS0c0PV23mA05mLxBmdm36APmMLGCvXgGW
 6082AAXh1iza5jjHT9qmZADN+J3kdPYaZQdayqQ1eLCHZmSd+GfKlPNu0GEaAufqCDh2gVkm7YY
 Ivlcpf+CGBcPVtFzm0TpjY4NWEsp29QBiNsw2kxatJ1J70TPH5b0d/+pW/q1AK+nEVTL/yI2kLN
 Lmt5se172i3MuR1ptwL+7TFHLvURNwuXQN6oQZ/LA0NZpzGiQiIMaxniRobrF30u4B80a+B4UVI
 a7a6r9XYao=
X-Received: by 2002:a05:600c:3b1b:b0:493:ece1:86b9 with SMTP id
 5b1f17b1804b1-4954a3d649fmr201543905e9.8.1784623852866; 
 Tue, 21 Jul 2026 01:50:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] target-arm queue
Date: Tue, 21 Jul 2026 09:50:34 +0100
Message-ID: <20260721085050.421257-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::9;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x09.google.com
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

Hi; here's a pullreq for arm; these are all bug fixes.

thanks
-- PMM

The following changes since commit bd6079a7a1d14de0918a7715ef6db85dc32de3bb:

  Merge tag 'next-pull-request' of https://gitlab.com/peterx/qemu into staging (2026-07-20 11:12:38 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260721

for you to fetch changes up to b693da615a7ab2adae7383fecb87b0e13966256e:

  Revert "target/arm: Build cpu32-system.o as common object" (2026-07-20 19:05:30 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/char: imx_serial: add missing migration state
 * hw/net/xilinx_axienet: Fix PHY register 17 link status reporting
 * target/arm: GICv5 cpuif: gicr_cdia_read() ppibit should be 64 bits
 * target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can change IRQ/FIQ
 * target/ppc: Remove unused helper_lscbx()
 * target/arm: Fix testing of raw mtx value
 * hw/dma/omap_dma: don't allow guest to memcopy arbitrary memory
 * target/arm: restore missing A-profile CPU types to qemu-arm

----------------------------------------------------------------
Jay Chang (1):
      hw/net/xilinx_axienet: Fix PHY register 17 link status reporting

Peter Maydell (13):
      target/arm: GICv5 cpuif: gicr_cdia_read() ppibit should be 64 bits
      target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can change IRQ/FIQ
      target/ppc: Remove unused helper_lscbx()
      hw/dma/soc_dma: Remove soc_dma_port_fifo support
      hw/dma/soc_dma: Simplify soc_dma_ch_update()
      hw/dma/soc_dma: Remove union from memmap_entry_s struct
      hw/dma/omap_dma: Be more careful about overflow in transfer setup
      hw/dma/soc_dma: dma bytes is uint64_t
      hw/dma/soc_dma: Use physical_memory_map() for mem2mem transfers
      hw/dma/soc_dma: Remove unused mem.base, paddr fields
      include/hw/arm/omap_dma.h: Move to include/hw/dma
      MAINTAINERS: Add soc_dma to OMAP section
      Revert "target/arm: Build cpu32-system.o as common object"

Richard Henderson (1):
      target/arm: Fix testing of raw mtx value

Tao Ding (1):
      hw/char: imx_serial: add missing migration state

 MAINTAINERS                                |   2 +
 hw/arm/omap1.c                             |   8 +-
 hw/char/imx_serial.c                       |   5 +-
 hw/dma/omap_dma.c                          |  37 +++---
 hw/dma/soc_dma.c                           | 196 ++++++++++-------------------
 hw/net/xilinx_axienet.c                    |   3 +
 include/hw/{arm => dma}/soc_dma.h          |  33 ++---
 target/arm/tcg/{cpu32-system.c => cpu32.c} |  10 +-
 target/arm/tcg/gicv5-cpuif.c               |   4 +-
 target/arm/tcg/meson.build                 |   5 +-
 target/arm/tcg/mte_helper.c                |  25 ++--
 target/ppc/helper.h                        |   1 -
 target/ppc/mem_helper.c                    |  28 -----
 13 files changed, 136 insertions(+), 221 deletions(-)
 rename include/hw/{arm => dma}/soc_dma.h (70%)
 rename target/arm/tcg/{cpu32-system.c => cpu32.c} (99%)

