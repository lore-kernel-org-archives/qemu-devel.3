Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FEBCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTsV-0004Lt-AT; Mon, 24 Nov 2025 05:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsI-0004FH-Np
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:32:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsF-0003bi-JB
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:32:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so23752815e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763980366; x=1764585166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ttZG+bplNscAnJZ3Wsi/sT9i5HqaUO76m59My6lktYk=;
 b=I7L0LqFt3ahMP7x20z2h6wkMADD3uD3+XfLgMNpqlCYGbrQ4NwWQOD2Xc7o8KSaKvI
 ukH+J2JFuFNM5MIX+0bQQgFYycpe9o/dQjEJYbJnt5SYsYw2gRa6iHGHp41sBai/AOXk
 3h+62FICkLkLlcwLJRv2xtHRKupH2mtJqp6sjmW4uRRNM1q55lLn8Bi693jeq2Jnr2pv
 3nzV1zOoOL1qr4Oa5OjBsuiNUNmyRiML5oTwA6Wc7q12Do8pG15RL9UvZyNKZ72VCGJX
 9B9vTeMd7772yErpw/FfPIJ/vDGYlpeUN4scG1J+Nt8KxsiQtBCSMajGTzx2J2cu7nhf
 LKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763980366; x=1764585166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttZG+bplNscAnJZ3Wsi/sT9i5HqaUO76m59My6lktYk=;
 b=iCZDq2yq2AkQXVLixeer+MEXJo2GyrqvLMsgVlWdl8NkyH/ai0tUSUaYrQ+1/+JJXP
 lGmxcia9NQWGv2QqlwJj9FdYd0R+5ZERy66oRtLR2xuP8jNz7JnuU+DdY8VrdBXKa80T
 usZTYdagM1A5s+w2/edaz8vXSxwhX4ejZ4jxKUB7ZJgLt2o1VECBvgGCn5FbZ9mPe9MF
 osLKumki3LCpTTngW27/IyidXE+YE/kxWurPM4N4Kx/tS7D3W2bxRNO+5k8hbar5DPDT
 JqC1JAR8wEAlYs3m3fZlkgng+/9PPTh9On7VViqYZM9JnpIRd1uKriNqfBOEL0/GlPty
 77NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVVCintw3Y9pYzriFylnbRqM1iaSpkDjRQGCk5xHsqTxfXAu4II28iPq5pSX0yYf82khs4+YPmx7j7@nongnu.org
X-Gm-Message-State: AOJu0YwKuVSMrySm7VUJcUh8jJl86PD9k0E2AcfPcLEQbJK5/6HkamXO
 AMY0TuJRpM7t3FI4gW2M4njxG2/LB40Ys26mco319b5sMwYeML1CG9MfScxCNstEy4Q=
X-Gm-Gg: ASbGncsNVWw8ps0eyl2VqHb2/b8EPL/hRVTxyeX4RKzhAjGYDyBBis/+1e3GKOH2Cdq
 Mc571kHLPxvpZ+ZHAI21DULT3EiGWRgPoelbuzeeWlRMB2BB2d1B2KHdCGp+8UisApOsoeHDtXo
 Ra9pvkuvgAEK5C/KQrgZst96/KAFOf00/LLuwnwFztgh9g44XeNyOnx1FVS3Ve5Bo0snu43Dz9I
 hiw4kgYoGWsZrgW4/ZLNWNaKuT1V6xGO97EwBrf9VsS5AUu7DXUXcWQnJuX3ulCH4NiSW84lD59
 KO3r63RpHM1YRX34uuku0TILX4SZjJgci/IC4A0BD46kQwtzECgfq14wnfxi3IcsngcGI0R2Rfh
 wMtxlXlBjlNrgGwAHWV356DSg0tAZk6VcqIENOIXZ3F+zsGyX0MJWQgMXnnbTGBKyvrIoo26elw
 qd2MNDJHa9LLhG//bNQLWjm9olM5/PBeLkF6cVl7cffo2x9zk+8JEwvvWdoYnlvqXakhES8Q8=
X-Google-Smtp-Source: AGHT+IEdqXdr4uNivV+2DGOmylD3Ak7CbhywtnSbDfluQzZK9IRpB+mNywSrdaSVzC4HdE1r0XsG1w==
X-Received: by 2002:a05:600c:3589:b0:477:97c7:9be7 with SMTP id
 5b1f17b1804b1-477c110262fmr112976355e9.1.1763980365732; 
 Mon, 24 Nov 2025 02:32:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm182882805e9.15.2025.11.24.02.32.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 02:32:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-11.0 0/2] hw/pci: Rename PCIDeviceClass::exit() ->
 PCIDeviceClass::unrealize()
Date: Mon, 24 Nov 2025 11:32:42 +0100
Message-ID: <20251124103244.78932-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Complete PCIDeviceClass::realize() conversion started 10 years ago :)

Philippe Mathieu-Daudé (2):
  hw/pci: Rename pci_bridge_exitfn() -> pci_bridge_unrealize()
  hw/pci: Rename PCIDeviceClass::exit() -> PCIDeviceClass::unrealize()

 include/hw/pci/pci.h                |  1 -
 include/hw/pci/pci_bridge.h         |  2 +-
 include/hw/pci/pci_device.h         |  3 ++-
 hw/audio/ac97.c                     |  8 ++++----
 hw/audio/es1370.c                   |  8 ++++----
 hw/audio/intel-hda.c                |  8 ++++----
 hw/audio/via-ac97.c                 |  4 ++--
 hw/char/diva-gsp.c                  |  6 +++---
 hw/char/serial-pci-multi.c          |  8 ++++----
 hw/char/serial-pci.c                |  4 ++--
 hw/cxl/switch-mailbox-cci.c         |  4 ++--
 hw/display/ati.c                    |  8 ++++----
 hw/display/bochs-display.c          |  4 ++--
 hw/display/vga-pci.c                |  4 ++--
 hw/ide/cmd646.c                     |  4 ++--
 hw/ide/ich.c                        |  4 ++--
 hw/ide/piix.c                       |  6 +++---
 hw/ide/via.c                        |  4 ++--
 hw/mem/cxl_type3.c                  |  4 ++--
 hw/misc/edu.c                       |  4 ++--
 hw/misc/ivshmem-pci.c               |  4 ++--
 hw/misc/pci-testdev.c               |  5 ++---
 hw/net/can/can_kvaser_pci.c         |  4 ++--
 hw/net/can/can_mioe3680_pci.c       |  4 ++--
 hw/net/can/can_pcm3680_pci.c        |  4 ++--
 hw/net/can/ctucan_pci.c             |  4 ++--
 hw/net/e1000.c                      |  5 ++---
 hw/net/e1000e.c                     |  4 ++--
 hw/net/eepro100.c                   |  8 ++++----
 hw/net/igb.c                        |  4 ++--
 hw/net/igbvf.c                      |  4 ++--
 hw/net/ne2000-pci.c                 |  4 ++--
 hw/net/pcnet-pci.c                  |  4 ++--
 hw/net/rocker/rocker.c              |  4 ++--
 hw/net/rtl8139.c                    |  4 ++--
 hw/net/sungem.c                     |  4 ++--
 hw/net/tulip.c                      |  4 ++--
 hw/net/vmxnet3.c                    |  4 ++--
 hw/nvme/ctrl.c                      |  4 ++--
 hw/pci-bridge/cxl_downstream.c      |  8 ++++----
 hw/pci-bridge/cxl_root_port.c       |  2 +-
 hw/pci-bridge/cxl_upstream.c        |  8 ++++----
 hw/pci-bridge/gen_pcie_root_port.c  |  2 +-
 hw/pci-bridge/i82801b11.c           |  2 +-
 hw/pci-bridge/pci_bridge_dev.c      |  8 ++++----
 hw/pci-bridge/pci_expander_bridge.c |  8 ++++----
 hw/pci-bridge/pcie_pci_bridge.c     |  8 ++++----
 hw/pci-bridge/pcie_root_port.c      |  8 ++++----
 hw/pci-bridge/simba.c               |  2 +-
 hw/pci-bridge/xio3130_downstream.c  |  8 ++++----
 hw/pci-bridge/xio3130_upstream.c    |  8 ++++----
 hw/pci-host/designware.c            |  2 +-
 hw/pci-host/xilinx-pcie.c           |  2 +-
 hw/pci/pci.c                        |  4 ++--
 hw/pci/pci_bridge.c                 |  2 +-
 hw/remote/proxy.c                   |  4 ++--
 hw/riscv/riscv-iommu-pci.c          |  4 ++--
 hw/scsi/esp-pci.c                   |  4 ++--
 hw/scsi/lsi53c895a.c                |  4 ++--
 hw/scsi/megasas.c                   |  4 ++--
 hw/scsi/mptsas.c                    |  4 ++--
 hw/scsi/vmw_pvscsi.c                | 10 ++++------
 hw/sd/sdhci-pci.c                   |  4 ++--
 hw/ufs/ufs.c                        |  4 ++--
 hw/usb/hcd-ehci-pci.c               |  4 ++--
 hw/usb/hcd-ohci-pci.c               |  8 ++++----
 hw/usb/hcd-uhci.c                   |  4 ++--
 hw/usb/hcd-xhci-pci.c               |  4 ++--
 hw/vfio/pci.c                       |  4 ++--
 hw/virtio/virtio-pci.c              |  4 ++--
 hw/watchdog/wdt_i6300esb.c          |  4 ++--
 hw/xen/xen_pt.c                     |  4 ++--
 72 files changed, 168 insertions(+), 172 deletions(-)

-- 
2.51.0


