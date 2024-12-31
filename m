Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857C7E77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilA-0002IK-Ea; Tue, 31 Dec 2024 15:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSil9-0002IB-6y
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:35 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSil6-0000nj-Tm
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:22:34 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so7843553f8f.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676550; x=1736281350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vBQnnJ3ZvLeVBiai1g7qoZaxU2XE25eF9CCanHat+xI=;
 b=qXd5Ijg/bWFJIlRCHpDu5pkn26CmqHKw0Ke0jjcvZg7KDql6/yCUKREmH59MN2iHED
 N7hNTDlo1Ll3pJ5TNZWyLfwJ6BOgeXgXcKRuxoVpbmZtOV9r1EM868lZi1vpeq8fXwUe
 MgiQuJIhz5uDEoahyYwhFvUul857QqcAeHrIoC74H2cXHWgLs5mdEeETN2lLvbzl+6N3
 ilsvo9O4thkzyLfb9lYMGrKimtTZWMTtSr1TgIVLTanEjV30+N5NRrjtHkppAsM0bsFp
 lMBFWlagTD79Hq7pwlWLZMv9YLPDNsznu+zLggFFAhvJx9NvZLA9nUFpCC5rr/vVL0h9
 Ftgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676550; x=1736281350;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBQnnJ3ZvLeVBiai1g7qoZaxU2XE25eF9CCanHat+xI=;
 b=MfXt3hgd6QqoKFIIbtJsgLQac+39DT7qV6ZFIrmCYXHVF5yL8kXAlwk5A8i1N8lTER
 cKz/2JlW3lRKYWIExQun3oOIGih2K801+8FlQYsaQjjuH7tyvUQVAy823jTCT6zYN5OO
 z7fX3dwgYwFr2lwVojLmyFE4CrEZXTN6MHA0VGvk4uI9+sa3aRejauY7kMIu049xRS27
 X8P8VHtn0A/w0Gor8A4gVdn5PGsdVDUhmb+fBJVDLlFqdXKj/fOGRZ6bm1VbWc3oGPsA
 9uzpV3ow0Oy5DIJaCbIwYTx0+fApJt3iaKKul79CeazDph3UzMn7kCxtk1HQFs/lRNrh
 yCqg==
X-Gm-Message-State: AOJu0YxqSRLzBCp6SPa/uXgtVPoX/3bd+mkZvo99SeoDSNs+TPekUN4Y
 9CUfk6iI1ABbARF5SwyO/Af18/jQb8HFngiEq4ZYIAQOtEfovEQuKd7DNsrx/oMrKk0PyzPidtU
 gg3o=
X-Gm-Gg: ASbGncukc2+jgpjP5Q3QyV9dwxO4WepBrIlrpHbSEfPZ0E1GWqUpoStH+58eYWAgg/9
 glduMoGkW0t4cVZeKKv6O7h49wFGCLaSdnO/TG+vIrNZzWZFLO2vbvCtU74KKEa5/cbxO4VNBCo
 okeCwUj9Q1IdfNdrM5pFO0PmvCZtWnpOmMB4G6eDa3mY8syysTRQekspd5yzNJ4O6Fo/GIiimMM
 snKfOLybqTHmvDTUQdWkneH4/BMlbjcfWznXg/VW/PJ5+s3pnqoXc9Mu5rO6wlGger3xS9/4iTC
 TYGP/VDofwjXA8HzjxxlacgCkIfBqII=
X-Google-Smtp-Source: AGHT+IHq0uDifn64QsPDv46yLaUg1J/69WQY3Zij9C84blcmEt0PUsQ95wku4fkeikWXRd+dkc850Q==
X-Received: by 2002:a05:6000:4612:b0:385:df5d:622c with SMTP id
 ffacd0b85a97d-38a221f36e3mr30171245f8f.30.1735676550423; 
 Tue, 31 Dec 2024 12:22:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219578sm402543095e9.20.2024.12.31.12.22.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:22:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/29] Misc HW patches for 2024-12-31
Date: Tue, 31 Dec 2024 21:21:59 +0100
Message-ID: <20241231202228.28819-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The following changes since commit 7c89e226f878539b633dde3fd9c9f061c34094e3:

  Merge tag 'pull-request-2024-12-29' of https://gitlab.com/huth/qemu into staging (2024-12-29 03:25:41 -0500)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20241231

for you to fetch changes up to c6f59e3b68abefc1f6942d4b4e3063d96d903b27:

  hw/display/qxl: Do not use C99 // comments (2024-12-31 21:21:34 +0100)

Ignored checkpatch errors:

 WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
 (I asked Gustavo to fix that in a following patch)

----------------------------------------------------------------
Misc HW patches queue

- Allow more than 4 legacy IRQs on Generic PCI Express Bridge (Alexander)
- Add MMIO-based Inter-VM shared memory device 'ivshmem-flat' (Gustavo)
- Use UHCI register definitions (Guenter)
- Propagate CPU endianness to microblaze_load_kernel (Philippe)
- Mark x86/TriCore devices as little-endian, OpenRISC/SPARC as big (Philippe)
- Don't set callback_opaque NULL in fw_cfg_modify_bytes_read (Shameer)
- Simplify non-KVM checks on AMD IOMMU XTSup feature (Philippe)
- Trivial cleanups on xilinx_ethlite, vmcoreinfo, qxl (Philippe, Hyman)
- Move USB-HCD-XHCI msi/msix properties from NEC to superclass (Phil)
- Redesign of main thread event handling due to macOS Cocoa (Phil)
- Introduce ParavirtualizedGraphics.Framework support 'apple-gfx' (Phil)
- Pad short Ethernet frames on macOS vmnet (William)

----------------------------------------------------------------

Alexander Graf (1):
  hw/pci-host/gpex: Allow more than 4 legacy IRQs

Guenter Roeck (2):
  hw/usb/uhci: checkpatch cleanup
  hw/usb/uhci: Introduce and use register defines

Gustavo Romero (2):
  hw/misc/ivshmem-flat: Add ivshmem-flat device
  hw/misc/ivshmem: Rename ivshmem to ivshmem-pci

Hyman Huang (1):
  hw/display/qxl: Do not use C99 // comments

Phil Dennis-Jordan (8):
  hw/block/virtio-blk: Replaces request free function with g_free
  hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC to superclass
  hw/usb/hcd-xhci: Unimplemented/guest error logging for port MMIO
  ui & main loop: Redesign of system-specific main thread event handling
  hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
    support
  hw/display/apple-gfx: Adds PCI implementation
  hw/display/apple-gfx: Adds configurable mode list
  MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF

Philippe Mathieu-Daudé (13):
  hw/microblaze: Propagate CPU endianness to microblaze_load_kernel()
  hw/i386: Mark devices as little-endian
  hw/tricore: Mark devices as little-endian
  hw/openrisc: Mark devices as big-endian
  hw/sparc: Mark devices as big-endian
  hw/net/xilinx_ethlite: Convert some debug logs to trace events
  hw/net/xilinx_ethlite: Remove unuseful debug logs
  hw/net/xilinx_ethlite: Update QOM style
  hw/net/xilinx_ethlite: Correct maximum RX buffer size
  hw/net/xilinx_ethlite: Rename rxbuf -> port_index
  hw/misc/vmcoreinfo: Declare QOM type using DEFINE_TYPES macro
  hw/misc/vmcoreinfo: Rename opaque pointer as 'opaque'
  hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature

Shameer Kolothum (1):
  fw_cfg: Don't set callback_opaque NULL in fw_cfg_modify_bytes_read()

William Hooper (1):
  net/vmnet: Pad short Ethernet frames

 MAINTAINERS                              |   7 +
 docs/system/device-emulation.rst         |   1 +
 docs/system/devices/ivshmem-flat.rst     |  33 +
 meson.build                              |   4 +
 hw/display/apple-gfx.h                   |  74 ++
 hw/microblaze/boot.h                     |   4 +-
 include/hw/misc/ivshmem-flat.h           |  85 +++
 include/hw/pci-host/gpex.h               |   7 +-
 include/hw/usb/uhci-regs.h               |  11 +
 include/qemu-main.h                      |  14 +-
 hw/arm/sbsa-ref.c                        |   2 +-
 hw/arm/virt.c                            |   2 +-
 hw/block/virtio-blk.c                    |  43 +-
 hw/display/qxl.c                         |   2 +-
 hw/i386/amd_iommu.c                      |  11 +-
 hw/i386/kvm/apic.c                       |   2 +-
 hw/i386/microvm.c                        |   2 +-
 hw/i386/pc.c                             |   4 +-
 hw/i386/vapic.c                          |   2 +-
 hw/i386/xen/xen_apic.c                   |   2 +-
 hw/i386/xen/xen_platform.c               |   2 +-
 hw/loongarch/virt.c                      |  12 +-
 hw/microblaze/boot.c                     |   8 +-
 hw/microblaze/petalogix_ml605_mmu.c      |   2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |   2 +-
 hw/mips/loongson3_virt.c                 |   2 +-
 hw/misc/ivshmem-flat.c                   | 459 ++++++++++++
 hw/misc/{ivshmem.c => ivshmem-pci.c}     |   0
 hw/misc/vmcoreinfo.c                     |  29 +-
 hw/net/xilinx_ethlite.c                  |  78 +-
 hw/nvram/fw_cfg.c                        |   1 -
 hw/openrisc/openrisc_sim.c               |   2 +-
 hw/openrisc/virt.c                       |  14 +-
 hw/pci-host/gpex.c                       |  43 +-
 hw/riscv/virt.c                          |  12 +-
 hw/sparc/sun4m_iommu.c                   |   2 +-
 hw/sparc64/sun4u.c                       |   2 +-
 hw/tricore/tricore_testdevice.c          |   2 +-
 hw/usb/hcd-uhci.c                        | 122 ++--
 hw/usb/hcd-xhci-nec.c                    |   2 -
 hw/usb/hcd-xhci-pci.c                    |   6 +
 hw/usb/hcd-xhci.c                        |  25 +-
 hw/xen/xen-pvh-common.c                  |   2 +-
 hw/xtensa/virt.c                         |   2 +-
 system/main.c                            |  38 +-
 tests/qtest/fuzz/fuzz.c                  |   1 +
 ui/gtk.c                                 |   4 +
 ui/sdl2.c                                |   4 +
 hw/display/Kconfig                       |  13 +
 hw/display/apple-gfx-mmio.m              | 285 ++++++++
 hw/display/apple-gfx-pci.m               | 157 ++++
 hw/display/apple-gfx.m                   | 879 +++++++++++++++++++++++
 hw/display/meson.build                   |   7 +
 hw/display/trace-events                  |  30 +
 hw/misc/Kconfig                          |   5 +
 hw/misc/meson.build                      |   4 +-
 hw/misc/trace-events                     |  16 +
 hw/net/trace-events                      |   4 +
 net/vmnet-common.m                       |  23 +-
 ui/cocoa.m                               |  54 +-
 61 files changed, 2413 insertions(+), 256 deletions(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/display/apple-gfx.h
 create mode 100644 include/hw/misc/ivshmem-flat.h
 create mode 100644 hw/misc/ivshmem-flat.c
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)
 create mode 100644 hw/display/apple-gfx-mmio.m
 create mode 100644 hw/display/apple-gfx-pci.m
 create mode 100644 hw/display/apple-gfx.m

-- 
2.47.1


