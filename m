Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CD7C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6X-0001Ha-Qj; Tue, 28 Jan 2025 05:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5x-00017L-E7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5v-0003Uk-1D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:25 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so2778318f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061121; x=1738665921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dRwvcaraC/scDv+rDmHLiP+gKuIdNL5huOLcky7sR+E=;
 b=lTjakx5nICWKTRkb8z9V2KAVdlWVmGkMzcYgj2znIz+SoKAROjxY5njOew+3npW1tX
 cZeKSFK+rrCDJ2ClxvdSm4RH9EzfG/wzGWN6leC2s14SMFu93uXQQGz7YAFoelPpxVD/
 gZIYcr2pEnBb1YtqXUcwj1EaH2tSgEDrLvmmuiClfCeYU+v99BLXqfgXW2znyao46wSx
 OkqFK3wHvVbKDhfjPHQeV3chTsVxuGOWb1AY7euy56gqpmhR+jYICAqICbdmkdacaU97
 Bx27MxHou79kC2f8zjrjI3gS9fXWbdUp77y46SpPH4CAZx5Cfwa190X5lBtjtyIKMUlG
 j2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061121; x=1738665921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRwvcaraC/scDv+rDmHLiP+gKuIdNL5huOLcky7sR+E=;
 b=u5CAR/m3MbzMJYJTasm6lum08sJamp4bK/9rHPtHM5/pVSn+4p73JMgz22DIjRCjEk
 mR16yy8ZS/bXvyCNUqBC6wI/PyH7n1gs+3f2Z2jzS7QlKujIMkouLIvcn5v63ZbtA3U3
 f7LZR4KTdYi6MnP1b+3O3AD45+r6PfgxZC8QEJnqkATPkh6/qw7sBXxV5PPyKuof2wQI
 x9sVpeMongMLD69BmlSLcSGzqpsPPdlPAKluK9YP0A8KPrUbm5ZOI0wzaTeYJ/k1AAC7
 tzDUZzhoHQeE2uGCpIlq/4Lj1BHjh/2JV29hAZvZTwkvub0/WD6ZGFPT952m4J9QCCJI
 FX2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjmtnb58mK2avEZH4zADoi3bONv5rdh1Dwubyc3ARRQNRWJY2DnpfwN2K+XDyojt7gVtRtrOyRDus/@nongnu.org
X-Gm-Message-State: AOJu0Ywlg0pAY41Gckvf/eBZOO+gEBJwIXnxMfPNii6ZEp9DPYOKExDU
 HS/3oNXO/y1rW8rI1X4ra+R4rkj+fitEOUB5Gmq88hmr5hRqCPYfBSouV/NASo0=
X-Gm-Gg: ASbGncuDFp7jDwf27/2yQzLgH6faYO/wX5gYMxdbXDV2QJdnsY/vsXBFZrgZUKPVgtA
 iraKclxYE0HZzCM7yoGwmnBcBTc2Eiby3RN+gJXBcK1f9oylWnjCwx0BduAh2lAeXsJN0/4L3qh
 WIiw6sEcpIvIt15yYrMVga2mXv13gRl2Cc/iQLMmGYyVxFTpDLpZHKtmxtP0tsborROmS0ZBD2K
 GJKt4GEdkXCBi4Jbr7hvLlyWJrFberNNnr0Ah/AioJcneV9QXj5zqutXYsCkxAoOXkdrFsmiDRX
 43YO4OyrsbfoG4KF783Z
X-Google-Smtp-Source: AGHT+IFH7fE0zC3Wt9/CqRONiwAZ8E24AWL+MXn/JVP13yIM27fpgsUPui07dMCEJyEVKvJAgX/5Ug==
X-Received: by 2002:a5d:490b:0:b0:38b:ef22:d8ba with SMTP id
 ffacd0b85a97d-38bf57b3fdcmr32477971f8f.44.1738061121318; 
 Tue, 28 Jan 2025 02:45:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 00/11] hw/sd: QOMify omap-mmc, remove legacy APIs
Date: Tue, 28 Jan 2025 10:45:08 +0000
Message-Id: <20250128104519.3981448-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This series QOMifies the omap-mmc device. The main reason for
this is that this device is now the only remaining in-tree
user of the legacy SD APIs defined in sdcard_legacy.h.
The first 8 patches QOMify the device and do some minor
cleanup on it. Patches 9 to 11 then remove the unused
legacy APIs, deleting sdcard_legacy.h entirely. This includes
letting us get rid of the me_no_qdev_me_kill_mammoth_with_rocks
codepaths in sd.c.

thanks
-- PMM

Peter Maydell (11):
  hw/sd/omap_mmc: Do a minimal conversion to QDev
  hw/sd/omap_mmc: Convert remaining 'struct omap_mmc_s' uses to
    OMAPMMCState
  hw/sd/omap_mmc: Convert output qemu_irqs to gpio and sysbus IRQ APIs
  hw/sd/omap_mmc: Convert to SDBus API
  hw/sd/omap_mmc: Use similar API for "wire up omap_clk" to other OMAP
    devices
  hw/arm/omap1: Inline creation of MMC
  hw/sd/omap_mmc: Remove unused coverswitch qemu_irq
  hw/sd/omap_mmc: Untabify
  hw/sd: Remove unused 'enable' method from SDCardClass
  hw/sd: Remove unused legacy functions, stop killing mammoths
  hw/sd: Remove unused SDState::enable

 include/hw/arm/omap.h         |  17 ++-
 include/hw/sd/sd.h            |   1 -
 include/hw/sd/sdcard_legacy.h |  50 -------
 hw/arm/omap1.c                |  26 +++-
 hw/sd/omap_mmc.c              | 256 +++++++++++++++++++---------------
 hw/sd/sd.c                    |  94 +++----------
 6 files changed, 190 insertions(+), 254 deletions(-)
 delete mode 100644 include/hw/sd/sdcard_legacy.h

-- 
2.34.1


