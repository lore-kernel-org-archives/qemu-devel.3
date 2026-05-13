Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83761CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 11:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7JD-000775-Aj; Wed, 13 May 2026 06:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FS-00030z-PT
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FO-0001MV-HN
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso57966905e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669719; x=1779274519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqXB20e2lB1n4B/l+2XeP0j/2vhshqy0w7MeGRh9Fl8=;
 b=tNXIj1EFjbLiZ8zNWPk4lj+ndKh0HS+aur48Fbz5jdWmA8f0eoe1OwSzeH1fOs+sgF
 FWOp0hEBQuMEg84IL7kVUOmPZAl/hRlRqty/8kyM7VUoPCU50DBE3dEZ6OpMm4JOpDc8
 gFeFFgSjcFEaWeg2hvU2bLs6gBKO2OsXjTCJSxJxZf+hL4GBo0MLnUI85UheNwtf4N/D
 hxnhnXDcc4PLmXXCRn25+XI1xhhlaiSr/PeSkub3+XYzTGOp50bhFXzDUEzSzJAH5cTY
 kkBb2NOnfh+fxP/zglmdSySAMWNNG4sUeaNMUz/QC3aG136826y7+tMzRHtnhmqS3aoy
 v2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669719; x=1779274519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqXB20e2lB1n4B/l+2XeP0j/2vhshqy0w7MeGRh9Fl8=;
 b=Ldtga/R6tXXdj6gUvm9owCwGPBrjvYSHmFAmtYMeuDPvqGblOjVGvdC6fJ3ocZMh5N
 UuY+mtaVVi93cf2vkd9HYUwsBkuO9yWdlDakd1jw0zjXHtIqpadulk6l7IbDsunz6/oe
 x8Zc++BoH3mhP29ly8jw1EDmgSgqqa5T5kXx8WgT0CSs3q1uskljhQDVFwwTDIU/P8se
 SzNZtcrdRjZ+s4xTigH8uqVIHiuqI4CEifvpkC/HfTtH0J1nDNydxmWVwUQrivlFBqa6
 GzOleikeoo73qvEla8hQTHwWVGSXCCuMfB4Yc7TxDxg8v82xlbzYpO93TKbG+o+Utl52
 pgcw==
X-Gm-Message-State: AOJu0YyQ8eCb1oK3VF1n494eUcwGpZzqEP8DYBQJaCBHmyceufHxEbrS
 CpvFMqHe+BFXflx7U6e7AztnJtLPMOA28fVTH7qRnIn+iJ1AwiZM9BAxaPMkYNud
X-Gm-Gg: Acq92OGatpkyg281Gy5SBuqBYUMrIjhmCpcGpvLu01QmevBOfdHiTDRMpUicsOhC7bL
 7nisYrGg9/afo7Nv2gUBQHhzjDpGrj/ZqmqFbarkLmE+nSETWkN1FPKh5kwetnRQUBOleK569so
 iVsLTWxhF0M0hOf/tTmWKcGdfDuxY9daxu4WHqi9gGzHzcKDQqtJDJwOQBQB0VhNSRrFijiUR87
 5Ozy9yAXbtpfVfVYOgAG+Q9LwxLKlCJYLqUcKTGjEqXc+2cX7Vx94n627Hc8eydSPXKW8OHmkUy
 e6UiLYT4+jbjBynjjmKx2Imls+ssbHm5LK0lCuZ9CiMoIaesM26smcqBOj9B6EVzLvPlhGNc9dA
 s0UoAWaS8B4uVyUe/ILjyOxyEYWcqaiRMwNr3U2D/+4X5ReoT7mXhpM+QzwCFmeaxKugS0dNJt1
 ALSTvo4Lu6F9qcs8OCB+q/69F0Y46aAn5558gIT25xXIqW
X-Received: by 2002:a05:600c:8210:b0:489:ad:7b5b with SMTP id
 5b1f17b1804b1-48fc9a46ff0mr33761355e9.24.1778669719471; 
 Wed, 13 May 2026 03:55:19 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:18 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v6 00/15] hw/arm: add Beckhoff CX7200 board
Date: Wed, 13 May 2026 12:55:02 +0200
Message-ID: <20260513105517.146706-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Corvin Köhne <c.koehne@beckhoff.com>

Hi,

Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
platform. This commit series adds the Beckhoff CX7200 as new board variant to
QEMU.

The emulation is able to successfully boot an CX7200 image. The image includes
some self tests executed on every boot. Only the cache self test fails due to
QEMU emulating the cache as always being coherent. The self tests include f.e.:

* Network
* Flash
* CCAT DMA + EEPROM [1]
* TwinCAT (Beckhoff's automation control software [2])

[1] https://github.com/beckhoff/ccat
[2] https://www.beckhoff.com/en-us/products/automation/

YannickV (15):
  hw/timer: Make frequency configurable
  hw/timer: Make PERIPHCLK divider configurable
  hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
  hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
  hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
    user mode
  hw/dma/zynq-devcfg: Simulate dummy PL reset
  hw/dma/zynq-devcfg: Indicate power-up status of PL
  hw/misc: Add dummy ZYNQ DDR controller
  hw/misc/zynq_slcr: Add logic for DCI configuration
  hw/misc: Add Beckhoff CCAT device
  hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
  hw/arm/xilinx_zynq: Split xilinx_zynq into header and implementation
    files
  hw/arm/xilinx_zynq: Add flash-type property
  hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
  docs/system/arm: Add support for Beckhoff CX7200

 docs/system/arm/beckhoff-cx7200.rst |  57 ++++
 docs/system/target-arm.rst          |   1 +
 hw/arm/Kconfig                      |   7 +
 hw/arm/beckhoff_CX7200.c            | 104 +++++++
 hw/arm/meson.build                  |   1 +
 hw/arm/xilinx_zynq.c                |  54 ++--
 hw/block/m25p80.c                   |   3 +-
 hw/dma/xlnx-zynq-devcfg.c           |  27 +-
 hw/misc/Kconfig                     |   6 +
 hw/misc/beckhoff_ccat.c             | 339 +++++++++++++++++++++++
 hw/misc/meson.build                 |   2 +
 hw/misc/xlnx-zynq-ddrc.c            | 413 ++++++++++++++++++++++++++++
 hw/misc/zynq_slcr.c                 |  31 +++
 hw/timer/a9gtimer.c                 |  26 +-
 hw/timer/arm_mptimer.c              |  32 ++-
 include/hw/arm/xilinx_zynq.h        |  37 +++
 include/hw/misc/xlnx-zynq-ddrc.h    | 148 ++++++++++
 include/hw/timer/a9gtimer.h         |   2 +
 include/hw/timer/arm_mptimer.h      |   4 +
 19 files changed, 1263 insertions(+), 31 deletions(-)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/arm/xilinx_zynq.h
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

-- 
2.47.3


