Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB08CCA0EE9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJN-0003Ws-Kw; Fri, 15 Aug 2025 05:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJL-0003WS-QJ; Fri, 15 Aug 2025 05:01:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJJ-0005Yw-UJ; Fri, 15 Aug 2025 05:01:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b281d25so7284725e9.3; 
 Fri, 15 Aug 2025 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248475; x=1755853275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2PbRyb6awW3kwqCeFDeQuAdnthWVGSx2eaw+EJCrits=;
 b=BDxQtGvDDjfVuXR3b9dTd+ifOv3kRVzAgqYKCFS7MjwQrzuBW5QyoLnRIxUYyJh8nh
 aXfPXmhXs9zYzR5u73SoCsYKwaHJXMh3jVjC+pZtxei9vedGDs+hyTK+H8pw8L3Xd1gV
 rNfayl6pWMBtqEF8vsBcovziPtcqNO4Bxg8whuphxHujqhCYjQMgj+ppLanHYMA8gCGy
 IuSEO/MBLzJU5rNxB9pkt3I41WnTuXXbgdXxY9WLcbMkgyz0DkYMUlumZzLW0dtWi9ja
 L2hE02MJu7t/SFXSLH4CKwCmB8EUM/ZspMSO8zpI/38/wBshXXzMcUMtY/IpyMtBfhPr
 E5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248475; x=1755853275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2PbRyb6awW3kwqCeFDeQuAdnthWVGSx2eaw+EJCrits=;
 b=JsX4LO/jE8lYyKxids1FTrIOILEVsopEQkH91FTnWI6kIWSLsDs1kzcVEzR/WptfWG
 3SekhymRFQdfwl7+BU8P3gO+eThnaxxZh5eOXAhp8KkdFj0q1qey0kENFDb3qbeO9YqJ
 vxDbLTZUt1bRt48KCOHTNreLPqbgocNz0w/5jc9lPr5E46at60QNYSzl756TiSzpirkS
 BHexNNWjy23NyO1LtSMw2HT9dbCi8llpWKpALwT4/ZvkUwPAOeLCZQj4SHhOeksx0aJ8
 56UX9LjP+kOEMRpSSGfJGDf2vo3cNmP1VDnwnVE0jCMFUpf9UCKKg8nqLEaiFP+mqURo
 0WSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViBEt5QRv+8BhaLFOBkt5/NfSE0benw8OCMH6pbdZ4KwRRXdIVWacixl0/JumH93BnP6sVfhefjaT6ww==@nongnu.org,
 AJvYcCWH6BrxI9KDPBvGH43ZSUi0bW55nmc7TNYupJc1VbnhyVlQ2bUAgNDyIsN0M+dDJOZXwcvYVVJ5VQ==@nongnu.org
X-Gm-Message-State: AOJu0YwqetRgqOo5THR1FKoRzKwK0NnA1bdrENQYwOIr5Rg9p33YyBB6
 8Vk8aR3SjUp8Zr1zO6ekXIg/uP0ahzRPP/3cZ0dwc4M5rOlajI68vRZ/G1LI5OiY
X-Gm-Gg: ASbGnctR/cFM/1DQLy0fcNRJLU4pBz552is/Zgu/B5G48q/P2zC/QPX7tELYnGzAmQh
 Pats2rggHrtCTmp035vYWt2pdzJnJ8DhWsok2V74ih8r9CMqAWUW6+tIQldvxRwaO5Gi0+UIQl5
 vobOE4i+pXIXgG5GwqvnnzuKkmzj4ipfI2Meogbv92R+tLMBIYOjXtZsWTPKmmTuGEUHHQwUo+G
 P69SxZXkur5W3BLIsaKnn0lspBhqYzbK9wV3j49nWrRgcOC1kCVSbRKmbdWhbrQzBK/4B0BWJC2
 eQxMdajTS5NL8ftMsTV3iDtDnsk2EaFYv7IS20eZjKkzVM9lt5X6uGO/Y2hlkAoId1FFKctnui2
 LRAsnmR4rTU/xDB6sIJ9iy7CxskMDWFbk61wnn7wbK5z10pa9Do23uilL
X-Google-Smtp-Source: AGHT+IE+4LR3txBHv1S6ystpw0uYUHl7vU5vSPcO0KaDqaNLgpWSkb6B0AcPDIy0GrIDY8FR/XPh0g==
X-Received: by 2002:a05:600c:3b8c:b0:456:2698:d4d9 with SMTP id
 5b1f17b1804b1-45a217f161emr14399075e9.3.1755248474645; 
 Fri, 15 Aug 2025 02:01:14 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:14 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 00/14] hw/arm: add Beckhoff CX7200 board
Date: Fri, 15 Aug 2025 11:00:58 +0200
Message-ID: <20250815090113.141641-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32e.google.com
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
  hw/timer: Make PERIPHCLK period configurable
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
 hw/arm/beckhoff_CX7200.c            | 440 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   1 +
 hw/block/m25p80.c                   |   3 +-
 hw/dma/xlnx-zynq-devcfg.c           |  29 +-
 hw/misc/Kconfig                     |   6 +
 hw/misc/beckhoff_ccat.c             | 365 +++++++++++++++++++++++
 hw/misc/meson.build                 |   2 +
 hw/misc/xlnx-zynq-ddrc.c            | 393 +++++++++++++++++++++++++
 hw/misc/zynq_slcr.c                 |  31 ++
 hw/timer/a9gtimer.c                 |  25 +-
 hw/timer/arm_mptimer.c              |  33 ++-
 include/hw/misc/xlnx-zynq-ddrc.h    | 140 +++++++++
 include/hw/timer/a9gtimer.h         |   2 +
 include/hw/timer/arm_mptimer.h      |   4 +
 17 files changed, 1538 insertions(+), 12 deletions(-)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

-- 
2.50.1


