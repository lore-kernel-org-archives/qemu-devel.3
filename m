Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F058C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWgv-00062v-BG; Tue, 18 Mar 2025 09:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWgf-0005G9-3r; Tue, 18 Mar 2025 09:08:53 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWga-00035O-7Y; Tue, 18 Mar 2025 09:08:52 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so956050166b.1; 
 Tue, 18 Mar 2025 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303326; x=1742908126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g0yzrsHOZw8jJRUdrnkye8+q3BRXaAEp0577L+ULu0o=;
 b=etxcsJ0wkjdpdP4CGOV1M2DBxaJiXv9kmShaSDX7YS+5+2L4DIERZqxzkYSVoOButk
 P5eQpH+bbs3ysW5x6myAEBPq9dAZhKDl3++rlZVcCyhywZIqxjx4uRUu3a6noXP/vCX2
 CHMVuCnMOzUmnrBKbOwY1y8o80IaoK92fTkDgJk9AlzQzm18DkorfpwtTJ+9Ex8nKOOX
 njJLYaj65wK7QjLxqOyqHlXR+lGj77bPn5KTml6o7Gaot2Wmnb0d/ytDH9LfkyzqGrK0
 54MadNceBhZj5mOdahNCBRYOywZnuY4OjgrmkLrqmfEnwBSAnXy48umj/aiMZDG5hy+n
 fcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303326; x=1742908126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0yzrsHOZw8jJRUdrnkye8+q3BRXaAEp0577L+ULu0o=;
 b=ozeyW+iub/DTvYxAKzQkBuFVZgJAngND6x+eUG78cB6mK5mRPAwISPCGZUBQaipE7N
 SMkqCs55R5Ape+9ThBYOpI0U5mh6nZYYyEvRvcI9zZGZkylLim9cDOgNqq0S86mdYC/Y
 ogZwIVSJD74VbOLWxQ9duyZaPE311ewvEOMI8xc+J5tBzE+XnJik4Q+AwCmH6ZGTR30S
 chvaJrYs1oJDgGJI9lWgza0o7y5KGHowWsCMalGPg6sG5Upw/zPA+7sbXw6EIih9ru29
 FKe72BfYSSlpJijMBGheMJCR4wEqmV1tkvh6xp8iuHrXEo9R8E8NeNHn9cjr84Aejh0Y
 7onA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP/ZnHeHFBM0YMR/qlBEaqCLODruVICwKMZiRA8peC6mw8J7xgBrof2thgeGYPvOyJveU2hXtRAg==@nongnu.org
X-Gm-Message-State: AOJu0YztzpQ2cdHD8Re/JV2LLGUdRw6Le2+CuWQIsuUnmcYuiEkZ1J/9
 SKXAMlZjVH6oVWCH5Y/mq2qyQUBCfvWF3hVyY6JORt3VdsjoBTFsdhYrUxJa
X-Gm-Gg: ASbGncuyU8VA5UyGCt3E6KGbP4OD9kkIY3INclJy2390NjnEhM7I2cN/7htG/KBi9er
 UUNE18kWlxo/dATpqCdMJCN0QDq8hsoN17woy1Lq8rm2VzxCGlhmtFBbxtpRXdf9ntzUlLpiPQU
 OuojY+afXLUw0d/g1gWh0AMPc/7BIaqfIHtEt8xZ6ccb8lc8DmV7upbc4OFyrXlAT8mGaSCo+dY
 U5x/0cRrg5gXMUAgxBBFn1dZIU/BxoSmzHYwyGCdvtctYXS6qpxjZk0LvS3722WGZgMOKiOdR3L
 4qRepdpu8bzruJQLfm33f2eqw33ReZhvW5OkSfm3uyPA15gfGpxxmxiybCCsgxN6GDc=
X-Google-Smtp-Source: AGHT+IEqpYvK6pS6BJKs4Q4TTHaqumiLkAnZaVFL/Nd8HsVYIEtKwoBRRn7hTlQ40IBqQ8dzrVV9cw==
X-Received: by 2002:a17:907:928c:b0:ac3:154e:1386 with SMTP id
 a640c23a62f3a-ac3301df978mr1864173666b.6.1742303303815; 
 Tue, 18 Mar 2025 06:08:23 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:08:18 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 00/21] Hi,
Date: Tue, 18 Mar 2025 14:07:51 +0100
Message-ID: <20250318130817.119636-1-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x635.google.com
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


