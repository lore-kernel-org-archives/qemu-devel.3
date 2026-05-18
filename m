Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsUj-0000oI-5F; Mon, 18 May 2026 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUL-0000fo-Ci
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUH-0000Bs-I1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso24098585e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089643; x=1779694443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kAgSRBIgRfg5Ci/kYkem6tx0tKkzNP30+dM14vaMmgA=;
 b=ck1PzqB7kbNuRecxQXdSM/gsXKjXYkXS3j9kaZDieB0+PG5TFp6CugRAJEe9pYB5pJ
 lAQ1UdAaZbEJQZOh2iUqn1xxgm3yABiKIXkqx9f35M6LSEJaaer9ZOf9tRobloRgPxe8
 tQLAgOm7AytrT35rKm0ALw//XTRu+t1AjtZsKMnHKwEwqBpvacOlKqSqBoP+NA6WQSzP
 ncXpaZpV9Y1/efMIutZdIe6RVEBlgQP1WCWvNYn/rwQevYW88Q6bR1goBTO5BiXPccAd
 8d18lu19GwkhhGaQTmo1+zsH8boRvPr8RcgdAYSvq4OZMwx/bg7pE2hazvATWIY4tGa9
 dyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089643; x=1779694443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAgSRBIgRfg5Ci/kYkem6tx0tKkzNP30+dM14vaMmgA=;
 b=KWL7AiFnHCLZMDHhIIc2Bu43mclRY95814C7Iogl4RoBAPA0x5HIOIogwC7b/xQEtD
 /iBCrNW/MIWg/LbxexF1Ad4BCtyc9QjoBe87k4kMZucBl9hxRBUgg72EDX49/LycZt9/
 X468cxsilfEx/dls4lxc60xB+zTymqDPPTbQCWMgOO36ANXnW4NYB7zP8zK0v3Osloon
 nQApGjSp9SWwLb/oY3Nm1RTuZgi6c/NFZSSXbX05OAlR6/MJp1a4aE+p7eIaFtbiTei8
 6FsYRnLiPRhFnj7yvfRe6+/lrys3yi3mVzRHznefl2TUb1fDpnHMoajO29k+zsnkIGQJ
 5z+Q==
X-Gm-Message-State: AOJu0Yw0FhIx2EO3CmroZZITrAS9pd78eaexiPZ+BDlPvHu2p3z/qY3z
 tTmsXHWwFmFxg/O50IE98dzyxXTs0UXkbF0+Jr2v5F9bTnYGBeWzTMN8tgo11Knr
X-Gm-Gg: Acq92OF8G7HKnxHfJgRmTdiy/QYYNci7Yy3lqMsGI4ok1TMdaYDr+IJmzgzXy+Wxw59
 5Q0RIIeWcX9myM4WM7nJXZovwwr1HE9bjwSuQuq9wHKH/pxtspeVU/Vxb+ZDPk9CXsBDsXIWofV
 2ZHLVlWHCW053LrmNbcF5n9h3EDlD7ktPBj8q1mDxBITFKdL5hDp6Ftz01V0ugn3UEQtDBHiqAk
 JAUk7ujyUnk205bxqEYWcJy/SA9don6/obxc4RDVNz9YsfZ0NeB8CWU5dhdR/QJzL0G/bi38ycK
 2ayMOuDPMnUgegp5g2PEGYEMcbhwrONPZvo0jwdKwuIHTYLD/wjbXV0AIOIgOtIPPlRUhA+YMh+
 gvCJp07qN47Sb3ck2qMzeskPy2sNpR9iR6HE1LUefCcgN2N0DZhSVvKPna9m+RM6SXiQwf6k4R6
 HQbCsCHIjxdZgu9t646mg9JSB4hRM/tYfHg8gXE9mox6YFOw==
X-Received: by 2002:a05:6000:2c07:b0:45e:75c5:1a6a with SMTP id
 ffacd0b85a97d-45e75c51b5emr7245024f8f.33.1779089643289; 
 Mon, 18 May 2026 00:34:03 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:02 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 00/16] hw/arm: add Beckhoff CX7200 board
Date: Mon, 18 May 2026 09:33:45 +0200
Message-ID: <20260518073401.11279-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32a.google.com
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

YannickV (16):
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
  hw/arm/xilinx_zynq: Add flash type as machine class property
  hw/misc/zynq_slcr: Add CPU clock outputs and ratios
  hw/timer,cpu: Add Clock API support to A9MPCore timers
  hw/arm/xilinx_zynq: Make PS frequency configurable
  hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
  docs/system/arm: Add support for Beckhoff CX7200

 MAINTAINERS                         |  11 +
 docs/system/arm/beckhoff-cx7200.rst |  62 ++++
 docs/system/target-arm.rst          |   1 +
 hw/arm/Kconfig                      |   8 +
 hw/arm/beckhoff_CX7200.c            |  80 ++++++
 hw/arm/meson.build                  |   1 +
 hw/arm/xilinx_zynq.c                |  54 ++--
 hw/block/m25p80.c                   |   3 +-
 hw/cpu/a9mpcore.c                   |  12 +
 hw/dma/xlnx-zynq-devcfg.c           |  27 +-
 hw/misc/Kconfig                     |   6 +
 hw/misc/beckhoff_ccat.c             | 339 ++++++++++++++++++++++
 hw/misc/meson.build                 |   2 +
 hw/misc/xlnx-zynq-ddrc.c            | 421 ++++++++++++++++++++++++++++
 hw/misc/zynq_slcr.c                 |  71 +++++
 hw/timer/a9gtimer.c                 |  18 +-
 hw/timer/arm_mptimer.c              |  20 +-
 include/hw/arm/xilinx_zynq.h        |  38 +++
 include/hw/cpu/a9mpcore.h           |   1 +
 include/hw/misc/xlnx-zynq-ddrc.h    | 147 ++++++++++
 include/hw/timer/a9gtimer.h         |   1 +
 include/hw/timer/arm_mptimer.h      |   2 +
 22 files changed, 1292 insertions(+), 33 deletions(-)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/arm/xilinx_zynq.h
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

-- 
2.47.3


