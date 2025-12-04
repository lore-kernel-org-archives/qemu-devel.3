Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82035D1F9A1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kO-0001Ks-Bm; Thu, 04 Dec 2025 04:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5jz-000187-Tt
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5jv-0003Mm-JK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:10 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640a0812658so1211833a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840904; x=1765445704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqXB20e2lB1n4B/l+2XeP0j/2vhshqy0w7MeGRh9Fl8=;
 b=TyIi2G8VJxOPSCjGGxyI5K4EoGOWy1KMevji/IfSWCVA5t+EnnrMQlkQW3lp+60NVA
 XdynBm17U/YIY0MKb96UKcdHyoXrW+DXmFUx/9ABYBIewEKvb1p0mfXTp0pwqYRPLoPt
 b/cbn6wt4DK2a+OX6Q7lT+Dzt+W/Unt5hG2afqgjoYCT8A06YVu3e7xEbVSfCzsGRUTf
 GkD+3JeGn516BQW2u4ndkyl1GQRriNWX+CWk8qySGvC0YvvL5zdrICp+mAVo1DmjVo9d
 6c3S8R9FCgluaRVi5n+C0e/RR6YpOQrH7rXMXx8oOK+BMJuLEKK5AkqmvnmS1bSHPeC9
 VEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840904; x=1765445704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqXB20e2lB1n4B/l+2XeP0j/2vhshqy0w7MeGRh9Fl8=;
 b=LUh1JJJ+kdyznHqvLPwFDvaNJ5jqmW4yvNegVfnU36935/axNAxwTafRYexxuC3z3q
 IsxyNCIJU/3rPMXOvcvOXxrho/KSuvFzYb+ow4gRZQ7a/ApKRDCojgqsiv0s6LIU3ShP
 Y4CFYT2KvN/L8a5yMXoRZey1F+fSnxr7eaLAIXEwUjdC8Jl4Jk0L65GTgQhX8OBWE6Nh
 +KeMRK/qrRTHTe4J3NgfZ3UDEW5DvMQtAepWylsQT+hJRJBjb88+l/MoUrJS8ha4odhc
 5guCpBoVX+v+nYaDJvwZ8+iVX7QuAMzvEPZMAL3PusbKlMt0tSZ56NkCGkL9OhUb8sW2
 /KMg==
X-Gm-Message-State: AOJu0YypnOS+E9Imj8L9tIO+F9wKvPZ0YfuS6Ud7mjj1kRrgrEC3XHgn
 BQvtEcsLaKSTAMrXWyi/oGP80OYov/GXSwBpbPz4kK5rxGYA5M1mSpeOOp0k4Gay
X-Gm-Gg: ASbGncuUBkqwNgnclkL4DAdwypbY9rtE2pytIvV6dijBRjDu3c2wzQvSu99cuFmZ6iV
 IHqmUseMTJ76mvie44VZUlw0Qv/8fNWQCoz6VAOFIwSuWz4K6piCh0lZlzpD1p0GoF3vZRmL1Ez
 sE6mGzvAOtHJ+EGcVTs6F9gOUWek0ap3Yix7OexPKLSBIPgCoBge6l0geclmDBEb2i4d8u3flh+
 d2aqpPKD0SrO2/jtt7AAYrQuF75SZhHO/YP/x6QAGNuNtpNc5eIlBF2ohNxBIrwdEZueTgFmL/W
 lmrVr5V5EOqDYmHPrQwutMIyt5KzWtQx9JULm1YSrDmyd39IVDgWxuF45Xz/Aadv3/q4fOXAEpT
 8ZFGjq8d8W2/oEFNh5NRpraUNMCjFK7OoevJXae56fwLyFIQObKQJ1rDBSaSDiHLrt6kNejYRmv
 57tlZt/O174JQKY/A7CycuFqEYSBsoTbw=
X-Google-Smtp-Source: AGHT+IFXJPAsiSg1t3VMpgzmtqC9Z6hzPe6Xl1uRYNo6+QzxfVHcLvJKMImj2WZNoeWpUgq1SATHXQ==
X-Received: by 2002:a05:6402:2790:b0:647:6ec9:8d8b with SMTP id
 4fb4d7f45d1cf-647abe05e9fmr2019788a12.34.1764840903658; 
 Thu, 04 Dec 2025 01:35:03 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:03 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>
Subject: [PATCH v5 00/15] hw/arm: add Beckhoff CX7200 board
Date: Thu,  4 Dec 2025 10:34:47 +0100
Message-ID: <20251204093502.50582-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52c.google.com
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


