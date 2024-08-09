Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 18:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scU2d-000109-Q5; Fri, 09 Aug 2024 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2c-0000wx-3m
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scU2Z-0007Bs-Pl
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 14:08:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so15733955e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723226917; x=1723831717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=tc0AyMsLxgF/Y4POZoK/SeaYpPE9EiBv0EtvcvxDBFQ=;
 b=gE/F4sZYlB1h5W0C4viPYLT9jvN2GHf6DKE0Bmz+nj9zu7WISjzu/pyTlICYAJez6b
 eRoRlyQZ0vvLhpcNOT1MWyjtya8IciT4cq11PdH3PfEu/aUiDsCDyQY8TcVu0cw6rxEc
 q+NCznojDCNHQuwehYpsMvStXgcXLlLCKXWQFzUUu12IXLxZLq1KEwiUAgUiawnP1i8E
 aA2mPTQdWYV5LPBUNcyRdxFc5U+6SwiRsSRpFoNH1BLjUBDybXf+sfalmE7RUAbmE+Fe
 vNDjWRQdGIryVcn3wkvRi14O7aM3ewy6F+H1kfNdCkP+dV/RkmvKqi7KR2QweGFTQrTk
 +D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226917; x=1723831717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tc0AyMsLxgF/Y4POZoK/SeaYpPE9EiBv0EtvcvxDBFQ=;
 b=SHvg7Kn1pwO48FfgRdnzaD/0Lww6KmYuHYq1kip+E6CMEqmb7RXYe6RkL95O+YHbLs
 5Hl80EzbhzgrBiQJAt/VbvK4ByvT+BuzwZggwFhq3mctrHphPiQodKIVKCr3timHfdPo
 0yU+bH1VghqVd37umpg6N6U8TTXAsS2PW1GrO0ow6XmzIByn9yNKXarSjOt5MrwxFWCH
 +V9e0oRHDlIDL1p8DLIpz6CnrLKTkY9n0rhUqLo03zXqfnosVgd6TyTR1o0Zb7cEL1wD
 iuB07nzb2yHtVhEgyLvogOyifp5nxjqFTfwxCeYnQd5hapGQocVRima1LjBrDlkjhEev
 wXdw==
X-Gm-Message-State: AOJu0YybkgNh+7FMvjm28hBBW6WoOSiXUTOGSY9yfDK505xSRRzk8kNq
 lXW5YajxsrLFVr2bVdYXKsG4Pyg2QpPSSjLUuMzMLMK5dfUXE1lJy/b+gTwwKV9pT1rXlsWBL+u
 h
X-Google-Smtp-Source: AGHT+IG0qazA9rwe5m2u0fWCLBAGV91OpI8Fjtip95kBcPskQCY/AQ/BFzEuqBRxemxjMkbgSySvvg==
X-Received: by 2002:a05:6000:b0d:b0:36c:b5a1:f108 with SMTP id
 ffacd0b85a97d-36d616e9d55mr1628457f8f.39.1723226917357; 
 Fri, 09 Aug 2024 11:08:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c937b6esm132262f8f.32.2024.08.09.11.08.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 11:08:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] target-arm queue
Date: Fri,  9 Aug 2024 19:08:24 +0100
Message-Id: <20240809180835.1243269-1-peter.maydell@linaro.org>
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

Hi; this pullreq contains some minor bug fixes, and also
the txt-to-rST document conversions I did. The latter are not
strictly speaking bugfixes but I think for rc2 they're OK. Let
me know if you'd rather I respin this without them.

thanks
-- PMM

The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:

  Merge tag 'pull-nbd-2024-08-08' of https://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240809

for you to fetch changes up to 77100e100d76a568800e19ee20c7e9255053b84a:

  arm/virt: place power button pin number on a define (2024-08-09 17:37:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix BTI versus CF_PCREL
 * include: Fix typo in name of MAKE_IDENTFIER macro
 * docs: Various txt-to-rST conversions
 * add support for PMUv3 64-bit PMCCNTR in AArch32 mode
 * hw/core/ptimer: fix timer zero period condition for freq > 1GHz
 * arm/virt: place power button pin number on a define

----------------------------------------------------------------
Alex Richardson (1):
      target/arm: add support for PMUv3 64-bit PMCCNTR in AArch32 mode

Eric Blake (1):
      docs: Typo fix in live disk backup

Jianzhou Yue (1):
      hw/core/ptimer: fix timer zero period condition for freq > 1GHz

Mauro Carvalho Chehab (1):
      arm/virt: place power button pin number on a define

Peter Maydell (6):
      include: Fix typo in name of MAKE_IDENTFIER macro
      docs/specs/rocker.txt: Convert to rST
      docs/interop/nbd.txt: Convert to rST
      docs/interop/parallels.txt: Convert to rST
      docs/interop/prl-xml.txt: Convert to rST
      docs/interop/prl-xml.rst: Fix minor grammar nits

Richard Henderson (1):
      target/arm: Fix BTI versus CF_PCREL

 MAINTAINERS                                   |   7 +-
 docs/interop/index.rst                        |   3 +
 docs/interop/live-block-operations.rst        |   4 +-
 docs/interop/nbd.rst                          |  89 ++++++++++++
 docs/interop/nbd.txt                          |  72 ----------
 docs/interop/{parallels.txt => parallels.rst} | 108 ++++++++-------
 docs/interop/prl-xml.rst                      | 192 ++++++++++++++++++++++++++
 docs/interop/prl-xml.txt                      | 158 ---------------------
 docs/specs/index.rst                          |   1 +
 docs/specs/{rocker.txt => rocker.rst}         | 181 ++++++++++++------------
 include/hw/arm/virt.h                         |   3 +
 include/qapi/qmp/qobject.h                    |   2 +-
 include/qemu/atomic.h                         |   2 +-
 include/qemu/compiler.h                       |   2 +-
 include/qemu/osdep.h                          |   6 +-
 target/arm/tcg/helper-a64.h                   |   3 +
 target/arm/tcg/translate.h                    |   2 -
 hw/arm/virt-acpi-build.c                      |   6 +-
 hw/arm/virt.c                                 |   7 +-
 hw/core/ptimer.c                              |   4 +-
 target/arm/helper.c                           |   6 +
 target/arm/tcg/helper-a64.c                   |  39 ++++++
 target/arm/tcg/translate-a64.c                |  64 ++-------
 tests/unit/ptimer-test.c                      |  33 +++++
 24 files changed, 553 insertions(+), 441 deletions(-)
 create mode 100644 docs/interop/nbd.rst
 delete mode 100644 docs/interop/nbd.txt
 rename docs/interop/{parallels.txt => parallels.rst} (72%)
 create mode 100644 docs/interop/prl-xml.rst
 delete mode 100644 docs/interop/prl-xml.txt
 rename docs/specs/{rocker.txt => rocker.rst} (91%)

