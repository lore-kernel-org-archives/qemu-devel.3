Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECF8C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gB-0006kX-4U; Thu, 25 Jan 2024 11:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g9-0006gf-CF
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g7-00027c-Hc
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40eb2f392f0so39313905e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200449; x=1706805249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=axVRnZ7u7ABFdbz3e9o0Vpy+ahV/YOtAd/CyIOYX/5o=;
 b=pnodVZ3jhQgtzdzxgyrdFrez1o+4XqXJfmxbv/BzS8x0f0k+qbsWLgy0XHBhhx92Xj
 hNfRyzTzg7/XZID205vkzLDJLGfOuiGE9vlpGB1gW7HliiZnUE5tUYVwEstElx8blE7C
 5Dm3tJDNJKJzku3iKW8SCRn+e5Bv3eTEutC1JQ+0DacExhrEXmo7Uk+6P0aQY//LYHE6
 u5kmudcXiR/uwp8jlxjgRpr1SI0zrBUs9T6sRNE3BdnW+Dg23rbZJIUk0Uq++SXIkKBA
 tHvjWeeuZlLfu9oE4LAXZY29jKIsqCcehnQHS38CHKH8zgCtryZOpquBnaGI2L01LzqG
 NleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200449; x=1706805249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axVRnZ7u7ABFdbz3e9o0Vpy+ahV/YOtAd/CyIOYX/5o=;
 b=NPEfGkB+bTlOj9MVWI/DgmXo5UpxZiAZ3NVyiE0taU6fUVxv4UJJr55Ib0+Da7DHpF
 XfyzhblJcdKivhmABSiLH5QNrsezlarzHrRhjFW14H4htgD4sArWdnO78Vy9M9SEEWCw
 WLJzn0vGu3p0bF9IMj9gkg+Satw0ZV7k2jTFrZPvupLZ6nRLzxh/HPWnOwdFt0FHUlI3
 b8FOgswXYD5kdn9Vokj5KIHAG2hbRr8aOXbTLCpTgwj8dr/jsTvhOSdhyhW85AvHquAW
 oRJUVOtDuIXMJ+x55biK8w3o6Bz4QYx8TxoP+qunvOn+TMqHY1FsrWp1pQMdyZuxq5Pk
 1QDw==
X-Gm-Message-State: AOJu0YxOeYHKvBPYW7G0MypiVCqog0CjpPK2/IB8PE6PM2J3BU2q5Pbz
 XEE6gx0SCp4vVgWynGcO0+UrDl120GjYPP7owLDEt8qaNSQ0GM+1BA5dTKuGGPU+rTuwirkr5rZ
 h
X-Google-Smtp-Source: AGHT+IHeNsvO78xaZnAcEfDzJk5r9vEizQyoKfkse3x8pliftF0ve+dRMZ0xBo1b7uVENlOD/bYuOg==
X-Received: by 2002:a05:600c:4e4b:b0:40e:d2c1:f21 with SMTP id
 e11-20020a05600c4e4b00b0040ed2c10f21mr544163wmq.122.1706200449571; 
 Thu, 25 Jan 2024 08:34:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 00/10] Clean up includes
Date: Thu, 25 Jan 2024 16:33:58 +0000
Message-Id: <20240125163408.1595135-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

This series makes a bunch of automated edits with the clean-includes
script. The script performs three related cleanups:

 * Ensure .c files include qemu/osdep.h first.
 * Including it in a .h is redundant, since the .c  already includes
   it.  Drop such inclusions.
 * Likewise, including headers qemu/osdep.h includes is redundant.
   Drop these, too.

I created the series by looking at a run of the script across the
whole tree (./scripts/clean-includes --git includes --all) produces,
and then disentangling that into (a) different cohesive parts and (b)
files that needed to go into the script's exclude-list.

After this series, the tree is still not entirely clean -- there
are 20 other files the script wants to change. But at least some
of them are things that should be on the exclude list, and some
are things which I didn't feel like taking the time to try to
decide whether they should be fixed or excluded. I might come
back to these at some later date, but I figured this series was
enough to be going on with.

thanks
-- PMM

Peter Maydell (10):
  scripts/clean-includes: Update exclude list
  hyperv: Clean up includes
  disas/riscv: Clean up includes
  aspeed: Clean up includes
  acpi: Clean up includes
  m68k: Clean up includes
  include: Clean up includes
  cxl: Clean up includes
  riscv: Clean up includes
  misc: Clean up includes

 disas/riscv.h                             | 1 -
 hw/arm/aspeed_eeprom.h                    | 1 -
 hw/hyperv/hv-balloon-internal.h           | 1 -
 hw/hyperv/hv-balloon-our_range_memslots.h | 1 -
 hw/hyperv/hv-balloon-page_range_tree.h    | 1 -
 include/hw/arm/raspberrypi-fw-defs.h      | 1 -
 include/hw/audio/asc.h                    | 1 -
 include/hw/m68k/q800-glue.h               | 1 -
 include/hw/mem/memory-device.h            | 1 -
 include/hw/nvram/fw_cfg_acpi.h            | 1 -
 include/hw/ppc/spapr_nested.h             | 1 -
 include/hw/virtio/virtio-acpi.h           | 1 -
 include/hw/xen/xen-hvm-common.h           | 1 -
 include/qemu/qtree.h                      | 1 -
 include/ui/rect.h                         | 2 --
 target/riscv/vector_internals.h           | 1 -
 tests/qtest/qtest_aspeed.h                | 2 --
 audio/pwaudio.c                           | 1 -
 disas/riscv-xthead.c                      | 1 +
 disas/riscv-xventana.c                    | 1 +
 hw/arm/aspeed_eeprom.c                    | 1 +
 hw/cxl/cxl-events.c                       | 4 +---
 hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
 hw/hyperv/hv-balloon-page_range_tree.c    | 1 +
 hw/hyperv/hv-balloon.c                    | 1 +
 hw/nvram/fw_cfg-acpi.c                    | 1 +
 hw/virtio/virtio-acpi.c                   | 1 +
 net/af-xdp.c                              | 1 -
 plugins/core.c                            | 1 -
 plugins/loader.c                          | 1 -
 target/riscv/vector_internals.c           | 1 +
 util/userfaultfd.c                        | 1 -
 scripts/clean-includes                    | 2 +-
 33 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.34.1


