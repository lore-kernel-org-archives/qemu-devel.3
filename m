Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6348FC282DC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdSZ-0007ph-MD; Tue, 04 Mar 2025 20:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSX-0007mc-I7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:05 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdST-0006t3-8H
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so40628875e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137719; x=1741742519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ngh/0QFDEK1KefUKxSamgqklsnsCaEo4eWiuSuzCkvs=;
 b=B+nFoOQ1FErYz7pg7WCmUtIqxAyoBRpqlrUa5YO2alRLlFseyRaX8P5YHE+/MEt8Gk
 5BIQLuMKga+Hn9JsNiijjfId6yrZkQKnMretpqXAGUvA+4WB6d1vHnHDLu9N293W9o/y
 vfA0amUk5H3KKSv2xZuexLTbfKPCMImUQgijNeMpjrzVrND0/ltGBgL+N7N3n93BSlIu
 xF2cIJn100HiZrBpKkRkZTO+L5Dkdl1aEyNQmA+EfsyhVn20dJrJwov5dMiGezXNmgEN
 k3eLRt8SUhUnqtJaTkcHarV6JpCtblpdxJT6lykjtF5Msz9DbaJ9IBOGD5fr7fsliTcW
 IzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137719; x=1741742519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ngh/0QFDEK1KefUKxSamgqklsnsCaEo4eWiuSuzCkvs=;
 b=v8QvuwA2CdXI2my2RppyEBC1iaOf3gC3HFVJXHoVuDWXyOQEdN8DEjtiAMsJqmvZJN
 BLvcexKHVK6QPaOpRtvmPWidFkU5bsNBbv3E9pbPX+WYCVHNcvVaYca0Tfx4WGQnMH66
 nrolazmb/htdxdFxDYjIXoZdZhb3O3e9foI566YW3SyIH/Ts/hRx8kuz3PkayuQeLJYE
 fr7ASzSDUnoTq3jGF6jZ1CY8tYJ2tPW873SQhSAkb1dvJCrTnaM9GZl08o0DwCPPki2G
 V/det5oMWrpG6WsrOH2YaLJ7eUSLkBcohZU74JXRGVYTeuDhxrVGjuAvkveLUA4/W2PQ
 f78g==
X-Gm-Message-State: AOJu0Yx6ZZcgJDV4Q3GWMKelLHwBxzmH/pBGkBlKuSq6zLuWvp3pU1QG
 O6h3WiK9O5US6edw5elH9oxWMu1JnnUjuD5ZX4U5bASbz6UJnb8Ax2El+OXwzD1klDxQpLL0ro/
 14OA=
X-Gm-Gg: ASbGncsH0NiR/ehKZCilGMMuEOcuREpBEIUbTyhpCfobo1h1fpRvQFkLalhqGf+CMqI
 IiadwwGtrfr3m6+i9kQ0z4sW+lo1QgOvQ/vhVJRRESPYwXuK020VcjJNOc26+9BkaGMI3mCSpQ/
 6CKXN98b/PMMLaQk6lNVVz/JfuNzWrOCtRPDiMnwRrKShiD1g9qnSDpS2y/KoNgk+QRZPrUbNNY
 nJQurs3fxRH18nrz3HTsqWS0+QNCR/HGdoZlZsvqjPwFDzaYf08d9B1rz5er13uXlH96aDE/zDw
 I1CYGvBKVQpG4lR9yCCJjyXcq9ZImUelqtkt+lAxtBuGuhDpYEv2L8FuHntakPuqJE/rh/mLXK9
 ZnNpfvGpbLpMRmRST9gs=
X-Google-Smtp-Source: AGHT+IFx9qbmPmvq8DiT+g+eF5LgvKKX1peAVSTwbBQRwMs/dm8yXFQ4bWGFiDPgc9WjjFMhB7foHQ==
X-Received: by 2002:a05:600c:35c5:b0:43b:c1ba:2186 with SMTP id
 5b1f17b1804b1-43bd29a0dbdmr5975575e9.18.1741137718803; 
 Tue, 04 Mar 2025 17:21:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42e53e0sm1928805e9.27.2025.03.04.17.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:21:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/41] Misc HW patches for 2025-03-05
Date: Wed,  5 Mar 2025 02:21:15 +0100
Message-ID: <20250305012157.96463-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56:

  scripts/checkpatch: Fix a typo (2025-03-04 09:30:26 +0800)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250305

for you to fetch changes up to 15571873d76b8fdd6cafb1d268415a1327ae3a6f:

  hw/nvram/eeprom_at24c: Reorganise init to avoid overwriting values (2025-03-05 02:13:38 +0100)

"Line over 80 chars" checkpatch.pl warnings in vmapple patches deliberately ignored.

----------------------------------------------------------------
Misc HW patches

- Remove TCG dependency on ARM_GICV3 (Philippe)
- Add MMIO interface to PVPanic device (Alexander)
- Add vmapple machine (Alexander & Phil)
- Restrict part of sPAPR PAGE_INIT hypercall to TCG (Philippe)
- Make ghes_record_cper_errors() scope static (Gavin)
- Do not expose the ARM virt machines on Xen-only binary (Philippe)
- Xen header cleanups (Philippe)
- Set Freescale eTSEC network device description & category (Zoltan)
- Improve RX FIFO depth for various UARTs (Philippe)
- Prevent TX FIFO memory leak in SiFive UART (Alistair)
- Cleanups in MacIO and AT24C EEPROM (Zoltan)
- Add UFS temperature event notification support & test (Keoseong)
- Remove printf() calls in hw/arm/ (Peter)
----------------------------------------------------------------

Alexander Graf (7):
  hw/misc/pvpanic: Add MMIO interface
  hw: Add vmapple subdir
  hw/vmapple/aes: Introduce aes engine
  hw/vmapple/bdif: Introduce vmapple backdoor interface
  hw/vmapple/cfg: Introduce vmapple cfg region
  hw/vmapple/virtio-blk: Add support for apple virtio-blk
  hw/vmapple/vmapple: Add vmapple machine type

Alistair Francis (1):
  hw/char/sifive_uart: Free fifo on unrealize

BALATON Zoltan (7):
  hw/net/fsl_etsec: Set eTSEC device description and category
  hw/misc/macio: Improve trace logs
  hw/misc/macio/gpio: Add constants for register bits
  hw/nvram/eeprom_at24c: Use OBJECT_DECLARE_SIMPLE_TYPE
  hw/nvram/eeprom_at24c: Remove ERR macro that calls fprintf to stderr
  hw/nvram/eeprom_at24c: Remove memset after g_malloc0
  hw/nvram/eeprom_at24c: Reorganise init to avoid overwriting values

Gavin Shan (1):
  hw/acpi/ghes: Make ghes_record_cper_errors() static

Keoseong Park (2):
  hw/ufs: Add temperature event notification support
  tests/qtest/ufs-test: Add test code for the temperature feature

Peter Maydell (5):
  hw/arm/omap1: Convert raw printfs to qemu_log_mask()
  hw/arm/omap1: Drop ALMDEBUG ifdeffed out code
  hw/arm/omap1: Convert information printfs to tracepoints
  hw/arm/omap_sx1: Remove ifdeffed out debug printf
  hw/arm/versatilepb: Convert printfs to LOG_GUEST_ERROR

Phil Dennis-Jordan (1):
  hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode

Philippe Mathieu-Daudé (17):
  hw/intc: Remove TCG dependency on ARM_GICV3
  hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to TCG
  hw/arm: Do not expose the virt machine on Xen-only binary
  hw/xen: Link XenPVH with GPEX PCIe bridge
  hw/xen/xen-pvh: Reduce included headers
  hw/xen/xen-hvm: Reduce included headers
  hw/xen/xen-bus: Reduce included headers
  hw/xen/xen-legacy-backend: Remove unused 'net/net.h' header
  hw/char/pl011: Warn when using disabled receiver
  hw/char/pl011: Simplify a bit pl011_can_receive()
  hw/char/pl011: Improve RX flow tracing events
  hw/char/pl011: Really use RX FIFO depth
  hw/char/bcm2835_aux: Really use RX FIFO depth
  hw/char/imx_serial: Really use RX FIFO depth
  hw/char/mcf_uart: Use FIFO_DEPTH definition instead of magic values
  hw/char/mcf_uart: Really use RX FIFO depth
  hw/char/sh_serial: Return correct number of empty RX FIFO elements

 MAINTAINERS                         |   8 +
 docs/system/arm/vmapple.rst         |  65 +++
 docs/system/target-arm.rst          |   1 +
 meson.build                         |   1 +
 qapi/virtio.json                    |  14 +
 hw/ufs/ufs.h                        |   2 +
 hw/usb/hcd-xhci-pci.h               |   1 +
 hw/usb/hcd-xhci.h                   |   5 +
 hw/vmapple/trace.h                  |   2 +
 include/block/ufs.h                 |  13 +-
 include/hw/acpi/ghes.h              |   2 -
 include/hw/misc/pvpanic.h           |   1 +
 include/hw/pci/pci_ids.h            |   1 +
 include/hw/qdev-properties-system.h |   6 +
 include/hw/virtio/virtio-blk.h      |  11 +-
 include/hw/vmapple/vmapple.h        |  23 ++
 include/hw/xen/xen-bus.h            |   3 +-
 include/hw/xen/xen-hvm-common.h     |  14 +-
 include/hw/xen/xen-legacy-backend.h |   1 -
 include/hw/xen/xen-pvh-common.h     |   8 +-
 include/qemu/cutils.h               |  15 +
 hw/acpi/ghes.c                      |   6 +-
 hw/arm/omap1.c                      | 125 ++----
 hw/arm/omap_sx1.c                   |   4 -
 hw/arm/versatilepb.c                |   7 +-
 hw/arm/xen-stubs.c                  |   5 +-
 hw/block/virtio-blk.c               |  17 +-
 hw/char/bcm2835_aux.c               |   6 +-
 hw/char/imx_serial.c                |   8 +-
 hw/char/mcf_uart.c                  |  16 +-
 hw/char/pl011.c                     |  30 +-
 hw/char/sh_serial.c                 |  30 +-
 hw/char/sifive_uart.c               |  44 +-
 hw/core/qdev-properties-system.c    |   9 +
 hw/i386/xen/xen-hvm.c               |   6 +
 hw/i386/xen/xen-pvh.c               |   1 +
 hw/misc/macio/gpio.c                |  21 +-
 hw/misc/pvpanic-mmio.c              |  60 +++
 hw/net/fsl_etsec/etsec.c            |   2 +
 hw/nvram/eeprom_at24c.c             |  23 +-
 hw/ppc/spapr_hcall.c                |   4 +-
 hw/ufs/ufs.c                        |  78 +++-
 hw/usb/hcd-xhci-pci.c               |  24 ++
 hw/usb/hcd-xhci.c                   |   3 +-
 hw/vmapple/aes.c                    | 581 ++++++++++++++++++++++++++
 hw/vmapple/bdif.c                   | 274 ++++++++++++
 hw/vmapple/cfg.c                    | 195 +++++++++
 hw/vmapple/virtio-blk.c             | 204 +++++++++
 hw/vmapple/vmapple.c                | 618 ++++++++++++++++++++++++++++
 hw/xen/xen-hvm-common.c             |   7 +
 hw/xen/xen-pvh-common.c             |   5 +-
 tests/qtest/ufs-test.c              |  24 ++
 util/hexdump.c                      |  18 +
 accel/Kconfig                       |   1 +
 contrib/vmapple/uuid.sh             |  12 +
 hw/Kconfig                          |   1 +
 hw/arm/Kconfig                      |   1 +
 hw/arm/trace-events                 |   7 +
 hw/char/trace-events                |   7 +-
 hw/intc/Kconfig                     |   6 +-
 hw/intc/meson.build                 |   4 +-
 hw/meson.build                      |   1 +
 hw/misc/Kconfig                     |   4 +
 hw/misc/macio/trace-events          |   3 +-
 hw/misc/meson.build                 |   1 +
 hw/vmapple/Kconfig                  |  34 ++
 hw/vmapple/meson.build              |   7 +
 hw/vmapple/trace-events             |  21 +
 68 files changed, 2558 insertions(+), 204 deletions(-)
 create mode 100644 docs/system/arm/vmapple.rst
 create mode 100644 hw/vmapple/trace.h
 create mode 100644 include/hw/vmapple/vmapple.h
 create mode 100644 hw/misc/pvpanic-mmio.c
 create mode 100644 hw/vmapple/aes.c
 create mode 100644 hw/vmapple/bdif.c
 create mode 100644 hw/vmapple/cfg.c
 create mode 100644 hw/vmapple/virtio-blk.c
 create mode 100644 hw/vmapple/vmapple.c
 create mode 100755 contrib/vmapple/uuid.sh
 create mode 100644 hw/vmapple/Kconfig
 create mode 100644 hw/vmapple/meson.build
 create mode 100644 hw/vmapple/trace-events

-- 
2.47.1


