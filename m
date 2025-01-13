Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24306C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 17:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXONJ-000304-Fg; Mon, 13 Jan 2025 12:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMK-0001yK-Gp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOMF-0006yD-5K
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 12:36:14 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so47997165e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736789767; x=1737394567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q37GwPcWX8n9vPzb7WiyVYW5/ZJsXkW9Ta5ysxbRvE0=;
 b=oQDx6a7XbeEsuc2KY4OqEsmTGJ+Q1WDZNDDV4mrG74EZYKv8xdspDHiVZqY5bYfzq5
 w4m0VCq1aSX0zjGsFW0wjNVyx846/VotjqQUIvW2GN7BhSjU2yHgh2Rof+UUOj1NcuaR
 3uUHr274WWfy2a7ySERPNrPnMHkiNNzDadD1Tg6IJzaN3xhemfCiDNZBup+n/wGfom+3
 cE9fqKnIxs0vp/lkSytj+L6mgptep91A+tDo9BehdY1u/2JNmm9x5xwniyO6hnMRlOVW
 CVt+q2UwNAiqGyM+P4QdwIFMsffqbv+vYevtu7ilNsFGuL7+JLLi/BfSv/zEe8ivuS6y
 eduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736789767; x=1737394567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q37GwPcWX8n9vPzb7WiyVYW5/ZJsXkW9Ta5ysxbRvE0=;
 b=EnOAmHZ+9hrhSLADAD1XZap1sxBYbjxx7teLVRRoC72nJui2hgDTcbqtaqArYixQb0
 IYWlaZ+dEZx2YF4HsSloO5eEnUQOYL7ubn9ODpBMqOG9T+j4ni1/geOcn4s2c+RDaxWp
 Y7WsuamE3rmhvffBoX/CxMGE8Gn0hmcy0ckKHJtstoy2aRqpCST4muVxakZC0DBbdB+b
 1RYKs+q23I9LeIl28367BJXaqB+Ndt4rCLaucl2mu6wfy0bILbgpyuNSivpmh96ambh8
 MWUHBGXhkloCpv2kKf0J2AeHqqir3O69pjO0supNq8ku1B/VSoIAHnARW7KVzvap+Qnq
 Ie3w==
X-Gm-Message-State: AOJu0YzjiS6pgSprHoehYI7XaNQlaJyQYhpRZjOUT5GgyL23LTW77Ilm
 AYOzZv9sz23Dm0Z8PBCynIZWun1dRxt79/gsW107U4iJ7IWR1iTKsoH8Mltw5r+7sWpM0NSuaIE
 fErk=
X-Gm-Gg: ASbGncsltLYi9cWXWemkt3fdo47aIp9hECC/h4cqKOfPyav/cmyQrkKrVJNQPA1Zs/w
 tm9/dQgOPnwA0JnwrYXI7cVIrzZ2zG1dxBxyjZQml1+PodTf6s3Gj3fPzaWZdUrMJcVFfgqVAoJ
 Xr3VH7CILbd2e3G0rv/mAhlitcS6UpArVAtiR7p11qJP6fWsPOlqznKEEbP3R1I0HxvkYOZjn3o
 HS057sFEWF5WWlkr+NWZ+PONhXFkE2Mb0nOL2LaXuIxlrS/fjGzb/8W0XZF9N3w9QnOX5nGz1IC
 1KDkbbRi9E+NWk3xQSyMhxCoU8C0PqA=
X-Google-Smtp-Source: AGHT+IEl5h3Cct54GzcvMx68ppWf8ZSFgA7NrA9Azbs5nVsUfIpYqd47o+UrJqSxJ6BtMobaMIvQTw==
X-Received: by 2002:a05:600c:3b25:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-436e26e2307mr175171135e9.21.1736789766842; 
 Mon, 13 Jan 2025 09:36:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fb99sm151807435e9.3.2025.01.13.09.36.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 09:36:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 00/55] Misc HW patches for 2025-01-12
Date: Mon, 13 Jan 2025 18:35:57 +0100
Message-ID: <20250113173604.46931-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The following changes since commit e8aa7fdcddfc8589bdc7c973a052e76e8f999455:

  Merge tag 'pull-target-arm-20250113' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2025-01-13 09:43:48 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20250113

for you to fetch changes up to 838cf72b5d2cd875897d8bdfea4b23f6d9fdc602:

  Add a b4 configuration file (2025-01-13 17:21:46 +0100)

----------------------------------------------------------------
Misc HW patches queue

- Silent unuseful DTC warnings (Philippe)
- Unify QDev hotplug decision logic (Akihiko)
- Rework XilinX EthLite RAM buffers (Philippe)
- Convert vmcoreinfo to 3-phase reset (Philippe)
- Convert HPPA CPUs to 3-phase reset (Helge)
- Fix UFS endianness issue (Keoseong)
- Introduce pci_set_enabled (Akihiko)
- Clarify Enclave and Firecracker relationship (Alexander)
- Set SDHCI DMA interrupt status bit in correct place (Bernhard)
- Fix leak in cryptodev-vhost-user backend (Gabriel)
- Fixes on PCI USB XHCI (Phil)
- Convert DPRINTF to trace events (Nikita, Bernhard)
- Remove &first_cpu in TriCore machine (Philippe)
- Checkpatch style cleanups (Bibo)
- MAINTAINERS updates (Marcin, Gustavo, Akihiko)
- Add default configuration for b4 tool (Jiaxun)

----------------------------------------------------------------

Akihiko Odaki (8):
  hw/qdev: Pass bus argument to qdev_hotplug_allowed()
  hw/qdev: Factor qdev_hotunplug_allowed() out
  hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
  hw/qdev: Check DevClass::hotpluggable in hotplug_unplug_allowed_common
  hw/qdev: Check qbus_is_hotpluggable in hotplug_unplug_allowed_common
  hw/qdev: Check machine_hotplug_handler in
    hotplug_unplug_allowed_common
  hw/pci: Rename has_power to enabled
  MAINTAINERS: Update path to coreaudio.m

Alexander Graf (1):
  docs/nitro-enclave: Clarify Enclave and Firecracker relationship

Bernhard Beschow (7):
  hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
  hw/timer/imx_gpt: Remove unused define
  tests/qtest/libqos: Reuse TYPE_IMX_I2C define
  hw/misc/imx6_src: Convert DPRINTF() to trace events
  hw/char/imx_serial: Turn some DPRINTF() statements into trace events
  hw/i2c/imx_i2c: Convert DPRINTF() to trace events
  hw/gpio/imx_gpio: Turn DPRINTF() into trace events

Bibo Mao (1):
  hw/loongarch/virt: Checkpatch cleanup

Gabriel Barrantes (1):
  backends/cryptodev-vhost-user: Fix local_error leaks

Gustavo Romero (1):
  MAINTAINERS: Add me as the maintainer for ivshmem-flat

Helge Deller (4):
  target/hppa: Convert hppa_cpu_init() to ResetHold handler
  hw/hppa: Reset vCPUs calling resettable_reset()
  target/hppa: Set PC on vCPU reset
  target/hppa: Speed up hppa_is_pa20()

Jiaxun Yang (1):
  Add a b4 configuration file

Keoseong Park (1):
  hw/ufs: Adjust value to match CPU's endian format

Marcin Juszkiewicz (1):
  MAINTAINERS: remove myself from sbsa-ref

Nikita Shubin (1):
  hw/char/stm32f2xx_usart: replace print with trace

Phil Dennis-Jordan (2):
  hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
  hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported

Philippe Mathieu-Daudé (26):
  pc-bios/meson.build: Silent unuseful DTC warnings
  target: Replace DEVICE(object_new) -> qdev_new()
  hw: Replace DEVICE(object_new) -> qdev_new()
  hw/usb: Inline usb_try_new()
  hw/usb: Inline usb_new()
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/net/xilinx_ethlite: Map MDIO registers (as unimplemented)
  hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
  hw/net/xilinx_ethlite: Introduce rxbuf_ptr() helper
  hw/net/xilinx_ethlite: Access TX_GIE register for each port
  hw/net/xilinx_ethlite: Access TX_LEN register for each port
  hw/net/xilinx_ethlite: Access TX_CTRL register for each port
  hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map TX_LEN as MMIO
  hw/net/xilinx_ethlite: Map TX_GIE as MMIO
  hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
  hw/net/xilinx_ethlite: Map the RAM buffer as RAM memory region
  hw/net/xilinx_ethlite: Rename 'mmio' MR as 'container'
  hw/net/xilinx_ethlite: Map RESERVED I/O as unimplemented
  hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE -> TYPE_VMCOREINFO
  hw/misc/vmcoreinfo: Convert to three-phase reset interface
  hw/sd/sdhci: Factor sdhci_sdma_transfer() out
  tests/qtest/boot-serial-test: Correct HPPA machine name
  tests: Add functional tests for HPPA machines
  target/hppa: Only set PSW 'M' bit on reset
  hw/tricore/triboard: Remove unnecessary use of &first_cpu

 MAINTAINERS                                |  13 +-
 docs/system/i386/nitro-enclave.rst         |   2 +-
 include/hw/misc/vmcoreinfo.h               |   7 +-
 include/hw/pci/pci.h                       |   1 +
 include/hw/pci/pci_device.h                |   2 +-
 include/hw/qdev-core.h                     |   3 +-
 include/hw/usb.h                           |  12 +-
 target/hppa/cpu.h                          |  11 +-
 backends/cryptodev-vhost-user.c            |   3 +-
 hw/arm/musicpal.c                          |   2 +-
 hw/char/imx_serial.c                       |  58 ++--
 hw/char/stm32f2xx_usart.c                  |  49 ++--
 hw/core/qdev-hotplug.c                     |  45 ++-
 hw/gpio/imx_gpio.c                         |  18 +-
 hw/hppa/machine.c                          |   6 +-
 hw/i2c/imx_i2c.c                           |  21 +-
 hw/intc/xilinx_intc.c                      |   4 +
 hw/loongarch/acpi-build.c                  |   3 +-
 hw/loongarch/boot.c                        |   4 +-
 hw/loongarch/virt.c                        |   8 +-
 hw/misc/imx6_src.c                         |  23 +-
 hw/misc/vmcoreinfo.c                       |  14 +-
 hw/net/xilinx_ethlite.c                    | 312 ++++++++++++++-------
 hw/pci/pci.c                               |  17 +-
 hw/pci/pci_host.c                          |   4 +-
 hw/sd/sdhci.c                              |  33 ++-
 hw/sparc/sun4m.c                           |   4 +-
 hw/timer/imx_gpt.c                         |   4 -
 hw/timer/xilinx_timer.c                    |   4 +
 hw/tricore/triboard.c                      |   6 +-
 hw/ufs/ufs.c                               |   2 +-
 hw/usb/bus.c                               |   5 +-
 hw/usb/dev-serial.c                        |   2 +-
 hw/usb/hcd-xhci-pci.c                      |   1 +
 hw/usb/hcd-xhci.c                          |   4 +
 system/qdev-monitor.c                      |  37 +--
 target/hppa/cpu.c                          |  22 +-
 target/mips/cpu.c                          |   2 +-
 target/xtensa/cpu.c                        |   2 +-
 tests/qtest/boot-serial-test.c             |   2 -
 tests/qtest/libqos/arm-imx25-pdk-machine.c |   5 +-
 tests/qtest/libqos/i2c-imx.c               |   4 +-
 tests/qtest/ufs-test.c                     |   2 +-
 .b4-config                                 |  14 +
 hw/char/trace-events                       |  11 +
 hw/gpio/trace-events                       |   5 +
 hw/i2c/trace-events                        |   5 +
 hw/misc/trace-events                       |   6 +
 pc-bios/meson.build                        |   3 +-
 tests/functional/meson.build               |   4 +
 tests/functional/test_hppa_seabios.py      |  35 +++
 tests/qtest/meson.build                    |   2 +-
 52 files changed, 558 insertions(+), 310 deletions(-)
 create mode 100644 .b4-config
 create mode 100755 tests/functional/test_hppa_seabios.py

-- 
2.47.1


