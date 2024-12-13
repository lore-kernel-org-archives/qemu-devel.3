Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB64E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF7j-00026Q-1F; Fri, 13 Dec 2024 18:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7h-00026A-Iy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:05 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7c-0002xG-2L
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:05 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1035180f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132658; x=1734737458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJqzrK27HC5TEaqb+1BUrxjhcsWle6KpvNsTAkGGR64=;
 b=ypdWkQZ99cK59OwM3iBR1M6sZNZxdlvM3jPy+7Kf9Zza48ytMyAXzvRZzvlx9b2jno
 zRE8F4Qs42xMYgth4tADyniuXU6qNB6dx4/CBzlzlgBCW17cTNe48s44zA1urAyPoNYr
 OyartdzsfBO11et3zkZdpm9PTYVL300nO9xEXIdf4yd0UWspXScDvFbYD8UTdJ0Yv4Wi
 HEckzrX/8Horw0J51B3I1R6GyRm1pQIodUrpZyAaOQZQJAOiL9ay1sYHOHnlBe0sKpyn
 9R/Ikg24GlapU0sKP4s2x+eTRj0hxslvrlC+2zqHKa4sGiP9qLFNMwBttBIZDI7Z3mQI
 rdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132658; x=1734737458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qJqzrK27HC5TEaqb+1BUrxjhcsWle6KpvNsTAkGGR64=;
 b=xD8Iwydv0/8oBw/beBKJ6jJnHgIisjizX9MrpIS5wCLCKjuzuITEB4ZO1+8gxHkoy7
 FUzZ711/VVH/Zuxf1wz1LTHy36tlSj6rwsLrmwBJwrtc/1IdQDWzEu86DhTQYVt+FxCk
 l5HCiQTUe9+R9aKb1gKao8aSTBY18aIuXCcNPFBxX5y3WFt7rmYb3Ir/81A0f3Ytbk09
 lOGkmBifOkHDePOanVk+kS4goK0U84h37LsK4Fyv3mKvv5aQcLKu9SLneuhWWDAQJONF
 P8Tx8oqqir5c/Vp0WsPdVengXQd3oIOcOTzFZnM0VPhGhaYYylSV36V3uwfNCbgc7Spl
 dmgQ==
X-Gm-Message-State: AOJu0YzwCrOULbySiKB/9KkKWSfTXelIzbhaD7wo0c8M2CZ5aXixJX/9
 4c2VxWlWhRlMq7HXWaH7V10rr5RRxhw4zrJJ7RvWr/Gw2mg9ewdjSEihbB9Gm8HgjS4rUiuOVOB
 Bh3I=
X-Gm-Gg: ASbGncvxO4FU8jtNKsI4E0+OPYfuTDJ79ut8dojmapf/yM6ZBoLm36YmrNNlsqFvPO6
 XMYqiItYdGlr7LUXN0F91VDzhisAR6Hj7e4x/SYAVmuWvWTO9I6Gihpz4gs1x9dMgvo6G7FzkRJ
 ApJ/1IQtvUgrfnRr+7rQ2ch30K9wQRgoQHRxDG9nwJOJbjlucmFNlRfHzBEaZQSq4CWUc1Oaj87
 K/BTrb3/ZYLGp1iZm1Ng9pPjuQwcEEhByKC2cow4SM0hhWKkouP0VN223jc7LVOTFwzEF4b0GvI
 5hbmDA==
X-Google-Smtp-Source: AGHT+IHWXq2f3c9cFhy1YIMX9o55yLFH2mja7pAEkNFzNCcEmdzXU9UuHdCXRtOWH6tRSIUHaiz+Lg==
X-Received: by 2002:a5d:5984:0:b0:385:fc32:1ec6 with SMTP id
 ffacd0b85a97d-3888e0c081bmr3304716f8f.50.1734132658139; 
 Fri, 13 Dec 2024 15:30:58 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046ca6sm817664f8f.83.2024.12.13.15.30.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:30:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/20] Misc HW patches for 2024-12-14
Date: Sat, 14 Dec 2024 00:30:35 +0100
Message-ID: <20241213233055.39574-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The following changes since commit 83aaec1d5a49f158abaa31797a0f976b3c07e5ca:

  Merge tag 'pull-tcg-20241212' of https://gitlab.com/rth7680/qemu into staging (2024-12-12 18:45:39 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20241214

for you to fetch changes up to 456b247eeab067095b680fa4b0fec48137969593:

  hw/xtensa: Include missing 'exec/tswap.h' header (2024-12-14 00:16:20 +0100)

----------------------------------------------------------------
Misc HW patch queue

- Support string data for extendPCR in VirtIO NSM device (Dorjoy)
- Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE (Phil)
- Decouple AHCI from PCI (Bernhard)
- Add status to usb_msd_packet_complete (Nick)
- Header cleanups (Alex, Phil)

----------------------------------------------------------------

Alex Bennée (1):
  hw/net/can: clean-up unnecessary includes

Bernhard Beschow (2):
  hw/ide/ahci: Decouple from PCI
  hw/ide/ahci: Extract TYPE_SYSBUS_AHCI into dedicated file

Dorjoy Chowdhury (3):
  docs/nitro-enclave: Fix terminal commands formatting
  hw/core/eif: Use stateful qcrypto apis
  hw/virtio/virtio-nsm: Support string data for extendPCR

Nicholas Piggin (1):
  hw/usb/msd: Add status to usb_msd_packet_complete() function

Phil Dennis-Jordan (1):
  hw/usb/hcd-xhci-pci: Indentation fix

Philippe Mathieu-Daudé (12):
  hw/riscv/virt: Remove pointless GPEX_HOST() cast
  hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
  hw/nvram/fw_cfg: Pass QOM parent to fw_cfg_add_file_from_generator()
  hw/nvram/fw_cfg: Skip FW_CFG_DATA_GENERATOR when no data to generate
  hw/pci: Have PCI_BUS implement TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
  hw/pci: Add pci_bus_add_fw_cfg_extra_pci_roots() helper
  hw: Use pci_bus_add_fw_cfg_extra_pci_roots()
  hw/nvram/fw_cfg: Remove fw_cfg_add_extra_pci_roots()
  hw/usb/hcd-xhci-nec: Remove unused XHCINecState::flags field
  hw/mips: Include missing 'exec/tswap.h' header
  hw/sh4/r2d: Include missing 'exec/tswap.h' header
  hw/xtensa: Include missing 'exec/tswap.h' header

 docs/system/i386/nitro-enclave.rst |   8 +-
 hw/ide/ahci-internal.h             |   1 -
 hw/xtensa/bootparam.h              |   1 +
 include/hw/i386/nitro_enclave.h    |  16 +--
 include/hw/ide/ahci-pci.h          |   2 +
 include/hw/ide/ahci.h              |   2 -
 include/hw/nvram/fw_cfg.h          |  32 ++---
 include/hw/pci/pci.h               |   3 +
 hw/arm/virt.c                      |   3 +-
 hw/core/eif.c                      | 202 +++++++++++------------------
 hw/hppa/machine.c                  |   2 +-
 hw/i386/nitro_enclave.c            |  12 +-
 hw/i386/pc.c                       |   3 +-
 hw/ide/ahci-sysbus.c               |  91 +++++++++++++
 hw/ide/ahci.c                      | 106 +--------------
 hw/ide/ich.c                       |  19 ++-
 hw/mips/fuloong2e.c                |   1 +
 hw/mips/malta.c                    |   1 +
 hw/net/can/can_kvaser_pci.c        |   4 -
 hw/net/can/can_mioe3680_pci.c      |   4 -
 hw/net/can/can_pcm3680_pci.c       |   4 -
 hw/net/can/can_sja1000.c           |   2 +-
 hw/net/can/ctucan_core.c           |   3 +-
 hw/net/can/ctucan_pci.c            |   4 -
 hw/nvram/fw_cfg.c                  |  37 ++----
 hw/pci/pci.c                       |  53 ++++++++
 hw/riscv/virt.c                    |  20 ++-
 hw/sh4/r2d.c                       |   1 +
 hw/usb/dev-storage.c               |  17 ++-
 hw/usb/hcd-xhci-nec.c              |   5 +-
 hw/usb/hcd-xhci-pci.c              |   2 +-
 hw/virtio/virtio-nsm.c             |  21 ++-
 hw/xtensa/xtfpga.c                 |   1 +
 system/vl.c                        |   3 +-
 hw/arm/Kconfig                     |  10 +-
 hw/ide/Kconfig                     |   4 +
 hw/ide/meson.build                 |   1 +
 37 files changed, 343 insertions(+), 358 deletions(-)
 create mode 100644 hw/ide/ahci-sysbus.c

-- 
2.45.2


