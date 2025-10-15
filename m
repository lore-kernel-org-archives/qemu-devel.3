Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6D7CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeP-0001zD-MG; Wed, 15 Oct 2025 05:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe1-0001nC-01
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:08 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdj-0007Be-J9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:04 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo349914166b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519861; x=1761124661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GcrIHW/2gRFYm6+L50as/gXMubw/2sxT0paF0ebbfY0=;
 b=ZAMzyLxULdheAFmx18/XfdfLANTsK9dSLge3BZ6Or3p8/xuyC6zTiM/nEOTf+N43Ta
 B9jxvEnkuS3kG6nU61cad/E+m/zRqCkMv832aFZdPrHIJgwB1VjVMh9NkkingfiiXO/M
 b9az/bhFDNusWqRMMAMUDYE80tBBfmU07xiKENYW57ud36iD0IHs6dIGqZZn/8/LE/A3
 5nkdOPTe+uCiZMa1daZnkndkJSoJ3U1UQWjzfaOCbg/diYVd+s6igZQ0vzJ9vbKb5TAO
 7zBTHi5CUhAtcjgNkr5qmM5MVd90hpYGvLVatZEQJkTHHvufhxndddYGDXLMiySn1aiD
 0vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519861; x=1761124661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GcrIHW/2gRFYm6+L50as/gXMubw/2sxT0paF0ebbfY0=;
 b=Fm5o39X6qKYEXpJnEnS2iruKo1+ZnZOxHZVLgIrjZrqN8sh5lBSf3k5ic+KtlBbL6k
 7tWNbnwjb1tvvimyeZuQrQ5KZykZ8qLY7HUrG7+OpV0XqoG3YuZ3yInlmdh8BCd+nc0p
 LclNFnn9Wh5B3gqtj30gz54dVJhzLz+j097Ytr4hG0UtZAVnXwVnLp9Nr0sMWZ9N8uoT
 GBQBPfhW3y3EU6cjBqPEVYVAmxI3kKFGKjtNQjopmKmAuhOsA+W4jwESLLOhvw7Hv7gB
 8Ah44o77nMGQPffUX//WJNQQETQw/C23r9/QXRQORshGI77ceKH9LrBYZks+GRKEFgDc
 aW9Q==
X-Gm-Message-State: AOJu0Yy7FV51UhRyXCqe2zS2lEmPOn0jWrFabHrk57wAU1pG8BpuR8rq
 dGcEYAF/ZLZpLQjojCXdPIURXbk2r+fJScRyQSOcXUt/Oo3w3t6pw2stNVwJNwCoRw4=
X-Gm-Gg: ASbGncsA6foS471jrXez+Vc8T4QRsVfFWX5nLIRz0kyYvHbfd4EyTXJF5C30ePNF4Qb
 h7TQxdNVtZsm2KcwHiucQf7alPhbfpsFZucZLpAM1srqSgEyw8XNCZk0X4Hxo8XNqQoAt//Etx0
 z3uK3uSJJVrtc0O6JxM4QyRRTJPxkJ4oykmdqnIYfWtbHV78UKzuZXZw9UVnepVmDXDk8n+icYV
 bzrFczYcQm4VXmOZzD3UVbOoiAbm89FBUuLw4Yyfm6m0QrPMD7h2kg9QiyRyI9fYQwdHMEHkYbJ
 30XXyY15QIF90+cYl4RDuc6/MBhPSKGqYO4l96pQG4Y3DMQBpBngakY6YaNladTwUvSkPItmrt2
 zraEv3CrQWEo0nbpZlzFKeYTgYojvi+da2LgcPdOaX4hvTWVYOakRAoDxe8oaHKsA4S6tjIap
X-Google-Smtp-Source: AGHT+IHIt7mRT2qcLLcw7Wnj87DvQIG2jnPJD4UP3CXfpRdpwIAniXW2GjRTNPQz57Vhf8p2DTZVEg==
X-Received: by 2002:a17:907:948f:b0:b40:e7ee:b5ec with SMTP id
 a640c23a62f3a-b50ac6c92d4mr2796147566b.59.1760519861054; 
 Wed, 15 Oct 2025 02:17:41 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:40 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 00/14] hw/arm: add Beckhoff CX7200 board
Date: Wed, 15 Oct 2025 11:17:15 +0200
Message-ID: <20251015091729.33761-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

YannickV (14):
  hw/timer: Make frequency configurable
  hw/timer: Make PERIPHCLK divider configurable
  hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
  hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
  hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
    user mode
  hw/dma/zynq-devcfg: Simulate dummy PL reset
  hw/dma/zynq-devcfg: Indicate power-up status of PL
  hw/dma/zynq-devcfg: Fix register memory
  hw/misc: Add dummy ZYNQ DDR controller
  hw/misc/zynq_slcr: Add logic for DCI configuration
  hw/misc: Add Beckhoff CCAT device
  hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
  hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
  docs/system/arm: Add support for Beckhoff CX7200

 docs/system/arm/beckhoff-cx7200.rst |  57 ++++
 docs/system/target-arm.rst          |   1 +
 hw/arm/Kconfig                      |  18 ++
 hw/arm/beckhoff_CX7200.c            | 443 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   1 +
 hw/block/m25p80.c                   |   3 +-
 hw/dma/xlnx-zynq-devcfg.c           |  29 +-
 hw/misc/Kconfig                     |   6 +
 hw/misc/beckhoff_ccat.c             | 338 +++++++++++++++++++++
 hw/misc/meson.build                 |   2 +
 hw/misc/xlnx-zynq-ddrc.c            | 413 ++++++++++++++++++++++++++
 hw/misc/zynq_slcr.c                 |  31 ++
 hw/timer/a9gtimer.c                 |  26 +-
 hw/timer/arm_mptimer.c              |  32 +-
 include/hw/misc/xlnx-zynq-ddrc.h    | 148 ++++++++++
 include/hw/timer/a9gtimer.h         |   2 +
 include/hw/timer/arm_mptimer.h      |   4 +
 17 files changed, 1542 insertions(+), 12 deletions(-)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

-- 
2.47.3


