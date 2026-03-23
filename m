Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1494F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iVv-0001La-OR; Mon, 23 Mar 2026 12:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iVu-0001LK-O3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iVs-0000RJ-OT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so37373925e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284741; x=1774889541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lUs6HYcCGyQoS3qF3eBKXsPnU9GcyZPEs22Bpr3lj58=;
 b=mBeBGjJjYo9X3X1hLEWezRe92Jwq9ZUIWjAOWoQi6OW2SdLgOdKwEGZDNiXY2yUSCA
 ne7QclZt8HdsLzUHV/VYeojL27YSJa3IitNG8/tMvbEZpJa2TEK9rutn82NvXlhc2RUY
 Cb49UyeZ3WcNNFHywrmuycqRCyqe4pcpLXrDomfc+EV9iuMeom31D6rp7qWtWSli7zGU
 alxVN85eurweUzSYdLsBEOopVh71bmEP2dvDVyrQR1fW/3pHHY/otUhTPSUh/kaz/lWZ
 DJrl0y9kc83OWohYcak09ZcDyo23KHPJIwzgCTmdgjdQ8/EAjq1GQcR+gKyoAyB+LW1r
 lAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284741; x=1774889541;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUs6HYcCGyQoS3qF3eBKXsPnU9GcyZPEs22Bpr3lj58=;
 b=lnSvf6eaEh8e1GMkglnQsZ2MTRSp6h+PT3Z6N9aJ3D/DeuJRTQ5gCtYc2SaAlBJhDP
 WCHfvWDdAoSkLRBH2eDJE1wK1kdWypiJ7NyIiWmaNdhSVLOYGYC3OrGzcLnmpWOJbrOy
 bqA3f822DVuPJHumK4oUwlxPkQqWjIjKR4Khjn5l6etQT8yWFQL4wuA4L1b9vmcGBf/f
 40oWwXjGmIs6PLzZpBjqaKk0RIupDmXMVroFGB9azZixYvsmjcxCfD5aPcRMZ9/ouEbk
 9O0APeuBnUFNbc7guYevLxDZbDJjxkyYlTe3xtHO+h+qgdzDAHk1zNwZMABHMQIusKo4
 Uq4w==
X-Gm-Message-State: AOJu0YxS7O+QKiurJ7wnaV66k9CdjrGzdq1vKYU7gSQz7PP6b40wzTmj
 VNGT4kd7FxRSGdzeK+ChXP2+wJD9q9ac8ECOGEZSsdsjYH/b8mq96WETvSzrBil+D5M2H+NCHGC
 B3U3C75w=
X-Gm-Gg: ATEYQzy81mYAGR6Ns1mY4P+55YO4vQZZNNE1Iyegmw4n6hvkeJqF1jLTSjTvgeIB+AO
 FxaBZ8DVMBnxVf9GjBT32mxVGZKBl2hMQC9jZn5P8A54QEVe3jUQ/gOLk/spr90Vf2Sg+AGqikE
 wPr8lUj5pSskK9lI1sc9PDX7cHgljpgTKgjilnRQuPoj25wHO0b1QB9AiwnjalRhQsHOiGhSyqn
 lvOcNjgWSElFGOVOvf2DnxLuloPdQUNfsfXJ8JlWZ0uEldzjxH1NnC5ZhG93l9d7EihkaZh42hs
 zanuQCizshHvLBTWhOkduezXSHw86lPRfoAFQSRnDllwWF8KkM6Ry75hPMB+PTTW7Zul+EpULMJ
 MkhD0bza522Iia/LvxbNC9nW+3fwJL5vj1uKoSYsnuFlz0uzRbkLpZDPnymHTaWcVA5+34oS1R/
 IX8OqS29aOAimy+R/DsTiJFELUKlDyGRpbIfHduhO0pwfYvmudx4nDo59n8Z1BIII8brhaQ9V8q
 r2cZYb0Ytk=
X-Received: by 2002:a05:600c:6309:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-4870f1f40d3mr4386845e9.6.1774284740428; 
 Mon, 23 Mar 2026 09:52:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487004e7bc4sm120303315e9.2.2026.03.23.09.52.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] Misc HW patches for 2026-03-23
Date: Mon, 23 Mar 2026 17:51:51 +0100
Message-ID: <20260323165218.96607-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
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

The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27:

  Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging (2026-03-23 10:55:20 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260323

for you to fetch changes up to 070fc710251809c4d8d2a84f24527a174e843423:

  hw/hyperv: add QEMU_PACKED to uapi structs (2026-03-23 17:50:50 +0100)

----------------------------------------------------------------
Misc HW patches

- Fix guest-triggerable abort in FTGMAC100 Gigabit Ethernet
- Fix uninitialized value in DesignWare I3C controller
- Clear dangling GLib event source tag in virtio-console
- Mark RISC-V specific peripherals as little-endian
- Correct virtual address formatting in monitor
- Improve error handling path in core loader
- Improve error hints in IOMMU FD
- Prevent hang in USB OHCI
- ATI VGA, HyperV & CXL fixes

----------------------------------------------------------------

Alireza Sanaee (1):
  hw/cxl: Use HPA in cxl_cfmws_find_device() rather than offset in
    window.

Ani Sinha (2):
  hw/i386/pc_sysfw: stub out x86_firmware_configure
  hw/i386/hyperv: add stubs for synic enablement

BALATON Zoltan (8):
  ati-vga: Fix colors when frame buffer endianness does not match host
  ati-vga: Also switch mode on HW cursor enable bit change
  ati-vga: Do not add crtc offset to src and dst data address
  ati-vga: Avoid warnings about sign extension
  ati-vga: Fix display updates in non-32 bit modes
  ati-vga: Add work around for fuloong2e
  ati-vga: Simplify pointer image handling
  ati-vga: Make sure hardware cursor data is within vram

Cédric Le Goater (1):
  hw/net/ftgmac100: Improve DMA error handling

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

Jamin Lin (1):
  hw/i3c/dw-i3c: Fix uninitialized data use in short transfer

Jenny Guanni Qu (1):
  hw/usb/hcd-ohci: check for MPS=0 to avoid infinite loop

Magnus Kulke (1):
  hw/hyperv: add QEMU_PACKED to uapi structs

Matthew Penney (1):
  hw/char/virtio-console: clear dangling GLib event source tag

Philippe Mathieu-Daudé (2):
  hw/riscv: Mark RISC-V specific peripherals as little-endian
  monitor: Correctly display virtual addresses while dumping memory

Pierrick Bouvier (2):
  backends/iommufd: report error when /dev/iommu is not available
  hw/vfio/iommufd: report hint to user when vfio-dev/vfio*/dev is
    missing

Sourav Poddar (1):
  hw/hyperv: Fix SynIC not initialized except on first vCPU

Trieu Huynh (4):
  hw/core/loader: fix error handling for load_image_targphys callers
  hw/core/loader: fix error handling for get_image_size callers
  util/event_notifier: fix error handling for event_notifier_init
    callers
  hw/pci/msix: fix error handling for msix_init callers

 hw/display/ati_int.h           |  1 +
 include/hw/hyperv/hvgdk_mini.h | 35 ++++++++-----
 include/hw/hyperv/hvhdk.h      | 12 ++---
 include/hw/hyperv/hyperv.h     |  1 +
 target/i386/kvm/hyperv.h       |  1 +
 backends/iommufd.c             |  3 ++
 hw/alpha/dp264.c               |  2 +-
 hw/char/ibex_uart.c            |  2 +-
 hw/char/shakti_uart.c          |  2 +-
 hw/char/sifive_uart.c          |  2 +-
 hw/char/virtio-console.c       |  2 +-
 hw/cxl/cxl-host.c              |  7 +--
 hw/cxl/cxl-mailbox-utils.c     | 27 +++++------
 hw/display/ati.c               | 89 +++++++++++++++++++---------------
 hw/display/ati_2d.c            | 47 ++++++++++++------
 hw/hppa/machine.c              |  2 +-
 hw/hyperv/hyperv.c             |  9 +++-
 hw/hyperv/vmbus.c              |  4 +-
 hw/i386/pc_sysfw.c             | 32 ------------
 hw/i386/pc_sysfw_ovmf-stubs.c  |  5 ++
 hw/i386/pc_sysfw_ovmf.c        | 33 +++++++++++++
 hw/i3c/dw-i3c.c                | 14 ++++--
 hw/ipmi/ipmi_bmc_sim.c         |  2 +
 hw/m68k/next-cube.c            | 11 ++++-
 hw/m68k/q800.c                 |  2 +-
 hw/m68k/virt.c                 |  2 +-
 hw/microblaze/boot.c           |  3 +-
 hw/mips/fuloong2e.c            |  1 +
 hw/misc/sifive_e_aon.c         |  2 +-
 hw/misc/sifive_e_prci.c        |  2 +-
 hw/misc/sifive_u_otp.c         |  2 +-
 hw/misc/sifive_u_prci.c        |  2 +-
 hw/net/ftgmac100.c             | 10 +++-
 hw/net/igbvf.c                 |  2 +-
 hw/net/rocker/rocker.c         |  2 +-
 hw/pci/msix.c                  |  2 +-
 hw/remote/proxy.c              | 15 +++++-
 hw/riscv/riscv-iommu.c         |  2 +-
 hw/scsi/megasas.c              | 16 ++++--
 hw/sd/cadence_sdhci.c          |  2 +-
 hw/timer/ibex_timer.c          |  2 +-
 hw/timer/sifive_pwm.c          |  2 +-
 hw/usb/hcd-ohci.c              | 11 +++++
 hw/usb/hcd-xhci-pci.c          | 16 ++++--
 hw/vfio/ap.c                   |  2 +-
 hw/vfio/ccw.c                  |  2 +-
 hw/vfio/iommufd.c              |  5 +-
 hw/vfio/pci-quirks.c           |  2 +-
 hw/vfio/pci.c                  |  2 +-
 hw/virtio/vhost-vdpa.c         |  4 +-
 monitor/hmp-cmds.c             |  2 +-
 target/i386/kvm/hyperv-stub.c  |  5 ++
 target/i386/kvm/hyperv.c       |  9 ++++
 target/i386/kvm/kvm.c          | 12 ++---
 54 files changed, 305 insertions(+), 183 deletions(-)

-- 
2.53.0


