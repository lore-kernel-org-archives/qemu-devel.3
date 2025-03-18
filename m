Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C2DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWev-0004Mp-Ud; Tue, 18 Mar 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWdy-0003os-Oj; Tue, 18 Mar 2025 09:06:12 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWdw-0002hh-KF; Tue, 18 Mar 2025 09:06:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so505780566b.0; 
 Tue, 18 Mar 2025 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303161; x=1742907961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g0yzrsHOZw8jJRUdrnkye8+q3BRXaAEp0577L+ULu0o=;
 b=alU9cK6Z3VMAM+ep0n7QHpZvXQt4FK9gzNXvvZKdMytodjVth9QDeK3gF0cvzRbbJN
 dw1L3JB50jNeGW+WePkerSOxwW3k0o6JxPmo+P2lauymFutQIegXvhEqAKD6hTk/qJ/t
 nW78My0CVFAGDZEjS8915PbKmCkxPazBNcYNIHtEkpWwFs6IRzkFs70H2GfLNjjTf6U7
 Qu2tWLIMdNaTvK1Em5lqeYgl1tFa8cpYHLJmai0NHIiUYXfqrs9kFrn8iQhNTMQIq4rE
 4dXWtVsO8da8uQ45p1a55KG7AVf1+4VTiZg8VGqXQJZTyrIALwWKk4qnN4YptRb3+UMQ
 fFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303161; x=1742907961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0yzrsHOZw8jJRUdrnkye8+q3BRXaAEp0577L+ULu0o=;
 b=YATC5JLo7XEgId58B+iTKyZWsTQebc8WPmN0qDoB6f72JKFhHm5xy2qxh2CnKBv1OZ
 CZWg+sPyXUYTD2wV85TJ5+1CN9X0rtI1Sf6kvSKN+zg2SQB+XHZWZ6NAnJVOpfhtIq5U
 qLIps1zFbvi4i2eUWf52UM0rnX7SJt/JwBOwjeBkzVO/o8t/EqSJ5uZ6EmaiRlWTaV8G
 f4XGpdvH9Zw1InP9FgH38ciHqPUC7wiA29mLQszh+8H13xv1hJo7waqwSLmi6vn0Fagn
 aVqXSXGAtFNfAmQTG4gPVpUQKfBLsjP8xVmpwouokS7A09kFobJWsg9ASub0CB3vmkDX
 Ha0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxd2GBDLeBNriSILR8WJ30GGFxW9Xsx2TfgprNG5singN0RdP1jDROHHTCaXyQSA8+IxYdYoQaAQ==@nongnu.org
X-Gm-Message-State: AOJu0YyoA/RFmWOPbTYis8ldXDNxz85a/1GnfnVA7kOB+zn95Zqbrd4N
 LNAuPumyztoDRYTvo1tWcyDiWhE0AjQXhwdvo7ntk5XljMh9cGdf9Vq5WCoz
X-Gm-Gg: ASbGncuHclwjpDySNtpqtWwDXY+K9lK0Hms5wvnKb1sbQAPS1BpHpe35K+vaO6SplCh
 TkmkfDu/qziItk/ahKsVHjmbIf/tOwOzjas1qEhsQ9uFN1fnSWusN17sgGB5xjCWGczYbl5jBZ/
 W6keJgjlCSZmuNfgLrT0qmFK0eDg6i/L3iG672fc61sNaVQCJS03vTEKtUyPaUlIVA7xr/4GWKP
 G6IrkiD0fXOvNd/DLIooulTg1dOeE3apNBdcW/AnxvsAP4OC2YB5s8EHkyNvDP0tjUi2ZjkdLmS
 3ZNerPasVLyMzzwSp0xqHuEA4NFBbaTlio2w8r7oN97PM2NrYL57yzgIobNDK2+jYK0=
X-Google-Smtp-Source: AGHT+IFtfs5HIDedcu9USdaNt2xbz0ODpqrJy81rM4gGCMUlbs1Z8XLtbg23AP8M4kYPLur//6H5aw==
X-Received: by 2002:a17:907:748:b0:ac2:a1fd:551e with SMTP id
 a640c23a62f3a-ac38d8d2e1dmr356340466b.55.1742303149478; 
 Tue, 18 Mar 2025 06:05:49 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3149cfbbesm846984266b.100.2025.03.18.06.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:05:28 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 00/21] Hi,
Date: Tue, 18 Mar 2025 14:05:00 +0100
Message-ID: <20250318130526.116026-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x636.google.com
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

Corvin Köhne (1):
  MAINTAINERS: add myself as reviewer for Beckhoff devices

YannickV (20):
  hw/timer: Make frequency configurable
  hw/timer: Make PERIPHCLK period configurable
  hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
  hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
  hw/dma/zynq: Notify devcfg on FPGA reset via SLCR control
  hw/dma/zynq-devcfg: Simulate dummy PL reset
  hw/dma/zynq-devcfg: Indicate power-up status of PL
  hw/dma/zynq-devcfg: Fix register memory
  hw/misc: Add dummy ZYNQ DDR controller
  hw/misc/zynq_slcr: Add logic for DCI configuration
  hw/misc: Add Beckhoff CCAT device
  hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
  hw/arm/beckhoff_CX7200: Remove second SD controller
  hw/arm/beckhoff_CX7200: Remove second GEM
  hw/arm/beckhoff_CX7200: Adjust Flashes and Busses
  hw/arm/beckhoff_CX7200: Remove usb interfaces
  hw/arm/beckhoff_CX7200: Remove unimplemented devices
  hw/arm/beckhoff_CX7200: Set CPU frequency and PERIPHCLK period
  hw/arm/beckhoff_CX7200: Add CCAT to CX7200
  hw/arm/beckhoff_CX7200: Add dummy DDR CTRL to CX7200

 MAINTAINERS                       |   7 +
 hw/arm/Kconfig                    |  18 ++
 hw/arm/beckhoff_CX7200.c          | 440 ++++++++++++++++++++++++++++++
 hw/arm/meson.build                |   1 +
 hw/dma/xlnx-zynq-devcfg.c         |  36 ++-
 hw/misc/Kconfig                   |   6 +
 hw/misc/beckhoff_ccat.c           | 365 +++++++++++++++++++++++++
 hw/misc/meson.build               |   2 +
 hw/misc/zynq_ddr-ctrl.c           | 331 ++++++++++++++++++++++
 hw/misc/zynq_slcr.c               |  47 ++++
 hw/timer/a9gtimer.c               |  25 +-
 hw/timer/arm_mptimer.c            |  33 ++-
 include/hw/dma/xlnx-zynq-devcfg.h |   3 +
 include/hw/timer/a9gtimer.h       |   2 +
 include/hw/timer/arm_mptimer.h    |   4 +
 15 files changed, 1309 insertions(+), 11 deletions(-)
 create mode 100644 hw/arm/beckhoff_CX7200.c
 create mode 100644 hw/misc/beckhoff_ccat.c
 create mode 100644 hw/misc/zynq_ddr-ctrl.c

-- 
2.49.0


