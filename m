Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC609C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTvV-0001PA-Ll; Mon, 10 Feb 2025 08:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtz-0000EF-P5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtt-0006Ek-Fn
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:41 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4393f6a2c1bso6927215e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194355; x=1739799155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnfQKZYiHpuXw2v8R5navif8iFQQJRpzK/6sx5v+sIs=;
 b=OLpl0pSXJGe+iEA7SmsJ9Us4xXEUSOzGKj8z3/u85bsGyJf0/0sQQmDDuiyZ/REhlZ
 C8vrkcdfqfQhbL+1nwPJz0dvKYg/Xn8sOaW84yNBkO8IW/lk+KRd7qmM83x1V3eOJ3c1
 mOlEbUbN6RPmRr48051/hkbZJzLJHrMUeJD73dqGEPs9OBo/raEh3y/AOu65Cc3kAj1Y
 EyiE8apRundIpyfVYlMRDaj3sGuA/et9XD1rk0RI3Rbme8suLuMI+OQ035TFTj+J1Dzh
 EIwq9HRGEDUoY3c6AIUnoZkij0XyyQzZB7lmK/3/aSSmYcQrYOgCL+uTh6JDyGmRlzu8
 uATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194355; x=1739799155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnfQKZYiHpuXw2v8R5navif8iFQQJRpzK/6sx5v+sIs=;
 b=BXMlFM85DI1PLu1mTFN+6XZW2KVP9xYx4bo0yWlzxD8tlfhsngPtk95mv9XyDX42Ib
 s5bcQNyNlVWrMuyvUdijhijAcpLmlgyOwOmaakXM9YJ6qlmpPvXt32I3qpwO1sPkVtGh
 U2w6Ut6L1SU1uiDPcyR0OaT2R+FQxbNpQrnPgahKn3RkQxSpcFFGgeUKrbwhsKhFnMSX
 b/STcDPdY1d845b7+mp9sLqlEFHiKN7/k8FTq6SPRfn1qXEA91DffOeW/Iahl48B8pIR
 rdQYTYZkXfCmAkX32nrbPq05NE8FwULUdGSCEvYzVC2YcAQ/FjRFWn6VRbsozrah/yKa
 F4Qw==
X-Gm-Message-State: AOJu0YxESpSdp8w+MtaFYETc3dUWud+gEHDXI0L7WKgINIwuQqe08TXQ
 uU1Cn2a6zvp6vGy4zM8E5/7GxkZ+TD2k/NuHJ+UqX9njhMQolK78+tM9iik93TG6b90ZqPucIjs
 lhFc=
X-Gm-Gg: ASbGncv4XQEzrjX3/KzuO+bw+uf4uHQogscKpkmf84E+vfQkH5VFXqeiFY84r/RzCML
 VsA5HRq6Sq/WNUQcJY2tvxt6wSBf94eDl+KfAE8npEtqCBoEt9jJwyS6fPb0KWz+ig9bLJkODBN
 VsSBfFWJhIWVAjJKrDyftbthLyqafqjXFpfet0FBDi6ahY56VbHD8Dzo6M/YgZLoev//LohphUn
 PCeauSLz72I0a9heoiKjQ5YrawjIEWawoP8ofQ7ZSiwiwSrSwrjQxtK3uvVZWEgGn/JZnmHcu8S
 rkLT583zWLMWy+pJFkV/OEOtq5wvP2n0X60H3Dow0GFIKCoQVpqISiayjb5LQIwDBHhkLkQ=
X-Google-Smtp-Source: AGHT+IGKqdYXm06JDM3iekBtRxGZmBJHBBtrbcNixQyd59rwzu5VY+XZq1jLO+jE+EXVk5w/xGM7Xw==
X-Received: by 2002:a05:6000:1a88:b0:38d:c911:c639 with SMTP id
 ffacd0b85a97d-38dc99a0a39mr9858649f8f.23.1739194353720; 
 Mon, 10 Feb 2025 05:32:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcde66729sm8771288f8f.81.2025.02.10.05.32.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/11] qom: Constify InterfaceInfo[] interfaces
Date: Mon, 10 Feb 2025 14:31:34 +0100
Message-ID: <20250210133134.90879-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Mechanical change using gsed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h                      |  2 +-
 include/qom/object.h                                |  4 ++--
 authz/list.c                                        |  2 +-
 authz/listfile.c                                    |  2 +-
 authz/pamacct.c                                     |  2 +-
 authz/simple.c                                      |  2 +-
 backends/cryptodev.c                                |  2 +-
 backends/dbus-vmstate.c                             |  2 +-
 backends/hostmem.c                                  |  2 +-
 backends/iommufd.c                                  |  2 +-
 backends/rng.c                                      |  2 +-
 block/throttle-groups.c                             |  2 +-
 crypto/secret_common.c                              |  2 +-
 crypto/tls-cipher-suites.c                          |  2 +-
 crypto/tlscredsanon.c                               |  2 +-
 crypto/tlscredspsk.c                                |  2 +-
 crypto/tlscredsx509.c                               |  2 +-
 event-loop-base.c                                   |  2 +-
 hw/acpi/erst.c                                      |  2 +-
 hw/acpi/generic_event_device.c                      |  2 +-
 hw/acpi/piix4.c                                     |  2 +-
 hw/arm/armsse.c                                     |  2 +-
 hw/arm/mps2-tz.c                                    |  2 +-
 hw/arm/virt.c                                       |  2 +-
 hw/audio/ac97.c                                     |  2 +-
 hw/audio/es1370.c                                   |  2 +-
 hw/audio/intel-hda.c                                |  2 +-
 hw/audio/via-ac97.c                                 |  4 ++--
 hw/block/fdc-isa.c                                  |  2 +-
 hw/char/diva-gsp.c                                  |  4 ++--
 hw/char/parallel.c                                  |  2 +-
 hw/char/serial-isa.c                                |  2 +-
 hw/char/serial-pci-multi.c                          |  4 ++--
 hw/char/serial-pci.c                                |  2 +-
 hw/char/virtio-serial-bus.c                         |  2 +-
 hw/core/bus.c                                       |  2 +-
 hw/core/qdev.c                                      |  2 +-
 hw/cxl/switch-mailbox-cci.c                         |  2 +-
 hw/display/ati.c                                    |  2 +-
 hw/display/bochs-display.c                          |  2 +-
 hw/display/cirrus_vga.c                             |  2 +-
 hw/display/qxl.c                                    |  2 +-
 hw/display/sm501.c                                  |  2 +-
 hw/display/vga-pci.c                                |  2 +-
 hw/display/virtio-gpu-pci-rutabaga.c                |  2 +-
 hw/display/vmware_vga.c                             |  2 +-
 hw/dma/i8257.c                                      |  2 +-
 hw/dma/xilinx_axidma.c                              |  4 ++--
 hw/dma/xlnx_csu_dma.c                               |  2 +-
 hw/hppa/machine.c                                   |  4 ++--
 hw/i2c/smbus_ich9.c                                 |  2 +-
 hw/i386/amd_iommu.c                                 |  2 +-
 hw/i386/microvm.c                                   |  2 +-
 hw/i386/pc.c                                        |  2 +-
 hw/i386/sgx-epc.c                                   |  2 +-
 hw/i386/x86.c                                       |  2 +-
 hw/i386/xen/xen_platform.c                          |  2 +-
 hw/i386/xen/xen_pvdevice.c                          |  2 +-
 hw/ide/ich.c                                        |  2 +-
 hw/ide/pci.c                                        |  2 +-
 hw/input/pckbd.c                                    |  2 +-
 hw/intc/arm_gic_common.c                            |  2 +-
 hw/intc/arm_gicv3_common.c                          |  2 +-
 hw/intc/goldfish_pic.c                              |  2 +-
 hw/intc/i8259_common.c                              |  2 +-
 hw/intc/ioapic_common.c                             |  2 +-
 hw/intc/m68k_irqc.c                                 |  2 +-
 hw/intc/pnv_xive.c                                  |  2 +-
 hw/intc/pnv_xive2.c                                 |  2 +-
 hw/intc/slavio_intctl.c                             |  2 +-
 hw/intc/spapr_xive.c                                |  2 +-
 hw/intc/xics_spapr.c                                |  2 +-
 hw/intc/xive.c                                      |  2 +-
 hw/intc/xive2.c                                     |  2 +-
 hw/ipack/tpci200.c                                  |  2 +-
 hw/ipmi/isa_ipmi_bt.c                               |  2 +-
 hw/ipmi/isa_ipmi_kcs.c                              |  2 +-
 hw/ipmi/pci_ipmi_bt.c                               |  2 +-
 hw/ipmi/pci_ipmi_kcs.c                              |  2 +-
 hw/ipmi/smbus_ipmi.c                                |  2 +-
 hw/isa/i82378.c                                     |  2 +-
 hw/isa/lpc_ich9.c                                   |  2 +-
 hw/isa/piix.c                                       |  2 +-
 hw/isa/vt82c686.c                                   |  4 ++--
 hw/loongarch/virt.c                                 |  2 +-
 hw/m68k/q800-glue.c                                 |  2 +-
 hw/mem/cxl_type3.c                                  |  2 +-
 hw/mem/pc-dimm.c                                    |  2 +-
 hw/misc/applesmc.c                                  |  2 +-
 hw/misc/edu.c                                       |  2 +-
 hw/misc/ivshmem-pci.c                               |  2 +-
 hw/misc/macio/gpio.c                                |  2 +-
 hw/misc/macio/macio.c                               |  2 +-
 hw/misc/pci-testdev.c                               |  2 +-
 hw/misc/pvpanic-isa.c                               |  2 +-
 hw/misc/pvpanic-pci.c                               |  2 +-
 hw/misc/xlnx-versal-cframe-reg.c                    |  2 +-
 hw/misc/xlnx-versal-cfu.c                           |  4 ++--
 hw/net/can/can_kvaser_pci.c                         |  2 +-
 hw/net/can/can_mioe3680_pci.c                       |  2 +-
 hw/net/can/can_pcm3680_pci.c                        |  2 +-
 hw/net/can/ctucan_pci.c                             |  2 +-
 hw/net/e1000.c                                      |  2 +-
 hw/net/e1000e.c                                     |  2 +-
 hw/net/eepro100.c                                   |  2 +-
 hw/net/igb.c                                        |  2 +-
 hw/net/igbvf.c                                      |  2 +-
 hw/net/ne2000-pci.c                                 |  2 +-
 hw/net/pcnet-pci.c                                  |  2 +-
 hw/net/rocker/rocker.c                              |  2 +-
 hw/net/rtl8139.c                                    |  2 +-
 hw/net/sungem.c                                     |  2 +-
 hw/net/sunhme.c                                     |  2 +-
 hw/net/tulip.c                                      |  2 +-
 hw/net/vmxnet3.c                                    |  2 +-
 hw/net/xilinx_axienet.c                             |  4 ++--
 hw/nvme/ctrl.c                                      |  2 +-
 hw/pci-bridge/cxl_downstream.c                      |  2 +-
 hw/pci-bridge/cxl_root_port.c                       |  2 +-
 hw/pci-bridge/cxl_upstream.c                        |  2 +-
 hw/pci-bridge/i82801b11.c                           |  2 +-
 hw/pci-bridge/pci_bridge_dev.c                      |  2 +-
 hw/pci-bridge/pci_expander_bridge.c                 |  6 +++---
 hw/pci-bridge/pcie_pci_bridge.c                     |  2 +-
 hw/pci-bridge/pcie_root_port.c                      |  2 +-
 hw/pci-bridge/simba.c                               |  2 +-
 hw/pci-bridge/xio3130_downstream.c                  |  2 +-
 hw/pci-bridge/xio3130_upstream.c                    |  2 +-
 hw/pci-host/articia.c                               |  4 ++--
 hw/pci-host/bonito.c                                |  2 +-
 hw/pci-host/designware.c                            |  2 +-
 hw/pci-host/gpex.c                                  |  2 +-
 hw/pci-host/grackle.c                               |  2 +-
 hw/pci-host/gt64120.c                               |  2 +-
 hw/pci-host/i440fx.c                                |  2 +-
 hw/pci-host/mv64361.c                               |  2 +-
 hw/pci-host/pnv_phb3_pbcq.c                         |  2 +-
 hw/pci-host/pnv_phb4.c                              |  2 +-
 hw/pci-host/pnv_phb4_pec.c                          |  4 ++--
 hw/pci-host/ppc4xx_pci.c                            |  2 +-
 hw/pci-host/ppce500.c                               |  2 +-
 hw/pci-host/q35.c                                   |  2 +-
 hw/pci-host/raven.c                                 |  2 +-
 hw/pci-host/sabre.c                                 |  2 +-
 hw/pci-host/sh_pci.c                                |  2 +-
 hw/pci-host/uninorth.c                              |  8 ++++----
 hw/pci-host/versatile.c                             |  2 +-
 hw/pci-host/xilinx-pcie.c                           |  2 +-
 hw/pci/pci.c                                        |  2 +-
 hw/pci/pci_bridge.c                                 |  2 +-
 hw/pci/pcie_port.c                                  |  2 +-
 hw/ppc/e500plat.c                                   |  2 +-
 hw/ppc/mac_newworld.c                               |  2 +-
 hw/ppc/mac_oldworld.c                               |  2 +-
 hw/ppc/pegasos2.c                                   |  2 +-
 hw/ppc/pnv.c                                        |  8 ++++----
 hw/ppc/pnv_adu.c                                    |  2 +-
 hw/ppc/pnv_chiptod.c                                |  4 ++--
 hw/ppc/pnv_i2c.c                                    |  2 +-
 hw/ppc/pnv_lpc.c                                    |  2 +-
 hw/ppc/pnv_n1_chiplet.c                             |  2 +-
 hw/ppc/pnv_nest_pervasive.c                         |  2 +-
 hw/ppc/pnv_psi.c                                    |  4 ++--
 hw/ppc/spapr.c                                      |  2 +-
 hw/ppc/spapr_pci.c                                  |  2 +-
 hw/remote/machine.c                                 |  2 +-
 hw/remote/proxy.c                                   |  2 +-
 hw/remote/remote-obj.c                              |  2 +-
 hw/remote/vfio-user-obj.c                           |  2 +-
 hw/riscv/riscv-iommu-pci.c                          |  2 +-
 hw/riscv/virt.c                                     |  2 +-
 hw/rtc/m48t59-isa.c                                 |  2 +-
 hw/rtc/m48t59.c                                     |  2 +-
 hw/rtc/mc146818rtc.c                                |  2 +-
 hw/s390x/ap-bridge.c                                |  2 +-
 hw/s390x/css-bridge.c                               |  2 +-
 hw/s390x/s390-pci-bus.c                             |  2 +-
 hw/s390x/s390-virtio-ccw.c                          |  2 +-
 hw/s390x/virtio-ccw-md.c                            |  2 +-
 hw/scsi/esp-pci.c                                   |  2 +-
 hw/scsi/lsi53c895a.c                                |  2 +-
 hw/scsi/megasas.c                                   |  6 +++---
 hw/scsi/mptsas.c                                    |  2 +-
 hw/scsi/scsi-bus.c                                  |  2 +-
 hw/scsi/vhost-scsi.c                                |  2 +-
 hw/scsi/vhost-user-scsi.c                           |  2 +-
 hw/scsi/virtio-scsi.c                               |  2 +-
 hw/scsi/vmw_pvscsi.c                                |  2 +-
 hw/sd/sdhci-pci.c                                   |  2 +-
 hw/sparc64/sun4u.c                                  |  4 ++--
 hw/ssi/pnv_spi.c                                    |  2 +-
 hw/tpm/tpm_crb.c                                    |  2 +-
 hw/tpm/tpm_spapr.c                                  |  2 +-
 hw/tpm/tpm_tis_i2c.c                                |  2 +-
 hw/tpm/tpm_tis_isa.c                                |  2 +-
 hw/tpm/tpm_tis_sysbus.c                             |  2 +-
 hw/ufs/ufs.c                                        |  2 +-
 hw/usb/bus.c                                        |  2 +-
 hw/usb/dev-smartcard-reader.c                       |  2 +-
 hw/usb/hcd-ehci-pci.c                               |  2 +-
 hw/usb/hcd-ohci-pci.c                               |  2 +-
 hw/usb/hcd-uhci.c                                   |  2 +-
 hw/usb/hcd-xhci-pci.c                               |  2 +-
 hw/vfio/igd.c                                       |  2 +-
 hw/vfio/pci.c                                       |  2 +-
 hw/virtio/virtio-md-pci.c                           |  2 +-
 hw/virtio/virtio-mem.c                              |  2 +-
 hw/virtio/virtio-pci.c                              |  6 +++---
 hw/watchdog/wdt_i6300esb.c                          |  2 +-
 hw/xen/xen-bus.c                                    |  2 +-
 hw/xen/xen-legacy-backend.c                         |  2 +-
 hw/xen/xen_pt.c                                     |  2 +-
 hw/xen/xen_pt_graphics.c                            |  2 +-
 net/can/can_core.c                                  |  2 +-
 net/can/can_host.c                                  |  2 +-
 net/colo-compare.c                                  |  2 +-
 net/filter.c                                        |  2 +-
 scsi/pr-manager.c                                   |  2 +-
 system/qtest.c                                      |  2 +-
 target/i386/sev.c                                   |  2 +-
 target/ppc/cpu_init.c                               |  2 +-
 tests/unit/check-qom-interface.c                    |  2 +-
 tests/unit/check-qom-proplist.c                     |  2 +-
 ui/dbus.c                                           |  2 +-
 ui/input-barrier.c                                  |  2 +-
 ui/input-linux.c                                    |  2 +-
 util/thread-context.c                               |  2 +-
 hw/display/apple-gfx-pci.m                          |  2 +-
 rust/qemu-api/src/qom.rs                            |  2 +-
 scripts/codeconverter/codeconverter/test_regexps.py | 10 +++++-----
 230 files changed, 260 insertions(+), 260 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 567a9b0a9da..31ec144509f 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -256,7 +256,7 @@ typedef struct VirtioPCIDeviceTypeInfo {
     void (*instance_init)(Object *obj);
     void (*instance_finalize)(Object *obj);
     void (*class_init)(ObjectClass *klass, const void *data);
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } VirtioPCIDeviceTypeInfo;
 
 /* Register virtio-pci type(s).  @t must be static. */
diff --git a/include/qom/object.h b/include/qom/object.h
index 42b75d10a43..1d5b0337242 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -294,7 +294,7 @@ struct Object
         .class_size = CLASS_SIZE, \
         .class_init = module_obj_name##_class_init, \
         .abstract = ABSTRACT, \
-        .interfaces = (InterfaceInfo[]) { __VA_ARGS__ } , \
+        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
     }; \
     \
     static void \
@@ -490,7 +490,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 };
 
 /**
diff --git a/authz/list.c b/authz/list.c
index bbd99f2b7fc..17aa0efd80e 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -253,7 +253,7 @@ static const TypeInfo qauthz_list_info = {
     .instance_size = sizeof(QAuthZList),
     .instance_finalize = qauthz_list_finalize,
     .class_init = qauthz_list_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/authz/listfile.c b/authz/listfile.c
index 39a0746fa09..4a0b70c9bc3 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -272,7 +272,7 @@ static const TypeInfo qauthz_list_file_info = {
     .instance_size = sizeof(QAuthZListFile),
     .instance_finalize = qauthz_list_file_finalize,
     .class_init = qauthz_list_file_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/authz/pamacct.c b/authz/pamacct.c
index 07b8aad4972..c0ad67479a7 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -136,7 +136,7 @@ static const TypeInfo qauthz_pam_info = {
     .instance_size = sizeof(QAuthZPAM),
     .instance_finalize = qauthz_pam_finalize,
     .class_init = qauthz_pam_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/authz/simple.c b/authz/simple.c
index f6985b840ea..f8f2b98518a 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -111,7 +111,7 @@ static const TypeInfo qauthz_simple_info = {
     .instance_size = sizeof(QAuthZSimple),
     .instance_finalize = qauthz_simple_finalize,
     .class_init = qauthz_simple_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 51bbe5ce40f..79f8882d3be 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -641,7 +641,7 @@ static const TypeInfo cryptodev_backend_info = {
     .instance_finalize = cryptodev_backend_finalize,
     .class_size = sizeof(CryptoDevBackendClass),
     .class_init = cryptodev_backend_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index 8c2deef43d4..7d5b58b4c90 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -505,7 +505,7 @@ static const TypeInfo dbus_vmstate_info = {
     .instance_size = sizeof(DBusVMState),
     .instance_finalize = dbus_vmstate_finalize,
     .class_init = dbus_vmstate_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { TYPE_VMSTATE_IF },
         { }
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 195f37fa443..35734d6f4d1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -586,7 +586,7 @@ static const TypeInfo host_memory_backend_info = {
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
     .instance_post_init = host_memory_backend_post_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 53566beb8a5..cbe34994884 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -345,7 +345,7 @@ static const TypeInfo types[] = {
         .instance_finalize = iommufd_backend_finalize,
         .class_size = sizeof(IOMMUFDBackendClass),
         .class_init = iommufd_backend_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_USER_CREATABLE },
             { }
         }
diff --git a/backends/rng.c b/backends/rng.c
index b3480d27a12..ab94dfea850 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -119,7 +119,7 @@ static const TypeInfo rng_backend_info = {
     .class_size = sizeof(RngBackendClass),
     .class_init = rng_backend_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index a72765e847e..24851972e84 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -968,7 +968,7 @@ static const TypeInfo throttle_group_info = {
     .instance_size = sizeof(ThrottleGroup),
     .instance_init = throttle_group_obj_init,
     .instance_finalize = throttle_group_obj_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     },
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index 2399ce412be..a5ecb876aeb 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -375,7 +375,7 @@ static const TypeInfo qcrypto_secret_info = {
     .class_size = sizeof(QCryptoSecretCommonClass),
     .class_init = qcrypto_secret_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
index e546cc7c0e6..d9b61d0c08a 100644
--- a/crypto/tls-cipher-suites.c
+++ b/crypto/tls-cipher-suites.c
@@ -118,7 +118,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
     .instance_size = sizeof(QCryptoTLSCipherSuites),
     .class_size = sizeof(QCryptoTLSCredsClass),
     .class_init = qcrypto_tls_cipher_suites_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 0e2d133821f..44af9e6c9af 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -152,7 +152,7 @@ static const TypeInfo qcrypto_tls_creds_anon_info = {
     .instance_finalize = qcrypto_tls_creds_anon_finalize,
     .class_size = sizeof(QCryptoTLSCredsAnonClass),
     .class_init = qcrypto_tls_creds_anon_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 287c2a3c96c..5b68a6b7ba2 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -255,7 +255,7 @@ static const TypeInfo qcrypto_tls_creds_psk_info = {
     .instance_finalize = qcrypto_tls_creds_psk_finalize,
     .class_size = sizeof(QCryptoTLSCredsPSKClass),
     .class_init = qcrypto_tls_creds_psk_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 143993f5393..63a72fe47c8 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -828,7 +828,7 @@ static const TypeInfo qcrypto_tls_creds_x509_info = {
     .instance_finalize = qcrypto_tls_creds_x509_finalize,
     .class_size = sizeof(QCryptoTLSCredsX509Class),
     .class_init = qcrypto_tls_creds_x509_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/event-loop-base.c b/event-loop-base.c
index 10b669ffc73..b3e2978450d 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -128,7 +128,7 @@ static const TypeInfo event_loop_base_info = {
     .class_size = sizeof(EventLoopBaseClass),
     .class_init = event_loop_base_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 621c82f019f..6c653a92cd4 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1044,7 +1044,7 @@ static const TypeInfo erst_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .class_init    = erst_class_init,
     .instance_size = sizeof(ERSTDeviceState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index f589e79a2bb..d8adfea6480 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -494,7 +494,7 @@ static const TypeInfo acpi_ged_info = {
     .instance_size = sizeof(AcpiGedState),
     .instance_init  = acpi_ged_initfn,
     .class_init    = acpi_ged_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
         { }
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 5860e8408bd..b16d45f03e1 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -657,7 +657,7 @@ static const TypeInfo piix4_pm_info = {
     .instance_init  = piix4_pm_init,
     .instance_size = sizeof(PIIX4PMState),
     .class_init    = piix4_pm_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 9403b65ddb5..50ab7f48105 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1713,7 +1713,7 @@ static const TypeInfo armsse_info = {
     .class_size = sizeof(ARMSSEClass),
     .instance_init = armsse_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IDAU_INTERFACE },
         { }
     }
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 7de19e60b7b..8287a748fab 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1453,7 +1453,7 @@ static const TypeInfo mps2tz_info = {
     .instance_size = sizeof(MPS2TZMachineState),
     .class_size = sizeof(MPS2TZMachineClass),
     .class_init = mps2tz_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IDAU_INTERFACE },
         { }
     },
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e35a988acb9..1bcb7da8ae8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3342,7 +3342,7 @@ static const TypeInfo virt_machine_info = {
     .class_size    = sizeof(VirtMachineClass),
     .class_init    = virt_machine_class_init,
     .instance_init = virt_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 7454cc60deb..669a0463cc1 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1351,7 +1351,7 @@ static const TypeInfo ac97_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(AC97LinkState),
     .class_init    = ac97_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 322b7798149..8efb9692128 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -896,7 +896,7 @@ static const TypeInfo es1370_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof (ES1370State),
     .class_init    = es1370_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 2f1b08e9c1c..b256c8ccea1 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1262,7 +1262,7 @@ static const TypeInfo intel_hda_info = {
     .instance_size = sizeof(IntelHDAState),
     .class_init    = intel_hda_class_init,
     .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/audio/via-ac97.c b/hw/audio/via-ac97.c
index 5feef663d8c..1e0a5c7398b 100644
--- a/hw/audio/via-ac97.c
+++ b/hw/audio/via-ac97.c
@@ -487,7 +487,7 @@ static const TypeInfo via_ac97_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(ViaAC97State),
     .class_init    = via_ac97_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -522,7 +522,7 @@ static const TypeInfo via_mc97_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = via_mc97_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index 1d32a66d3b7..6a6fca43748 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -331,7 +331,7 @@ static const TypeInfo isa_fdc_info = {
     .instance_size = sizeof(FDCtrlISABus),
     .class_init    = isabus_fdc_class_init,
     .instance_init = isabus_fdc_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 9a623d680b3..60f933191d2 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -268,7 +268,7 @@ static const TypeInfo diva_aux_info = {
     .instance_size = sizeof(DivaAuxState),
     .instance_init = diva_aux_init,
     .class_init    = diva_aux_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -282,7 +282,7 @@ static const TypeInfo diva_serial_pci_info = {
     .instance_size = sizeof(PCIDivaSerialState),
     .instance_init = diva_serial_init,
     .class_init    = diva_serial_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 217ddaf2e3e..8732e4e9f96 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -627,7 +627,7 @@ static const TypeInfo parallel_isa_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(ISAParallelState),
     .class_init    = parallel_isa_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index fe7fb1625b5..0ea59a3d5c2 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -146,7 +146,7 @@ static const TypeInfo serial_isa_info = {
     .instance_size = sizeof(ISASerialState),
     .instance_init = serial_isa_initfn,
     .class_init    = serial_isa_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index ee1c0f7dc4f..fb184c2e6dc 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -194,7 +194,7 @@ static const TypeInfo multi_2x_serial_pci_info = {
     .instance_size = sizeof(PCIMultiSerialState),
     .instance_init = multi_serial_init,
     .class_init    = multi_2x_serial_pci_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -206,7 +206,7 @@ static const TypeInfo multi_4x_serial_pci_info = {
     .instance_size = sizeof(PCIMultiSerialState),
     .instance_init = multi_serial_init,
     .class_init    = multi_4x_serial_pci_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index bd38c7428c6..8707e819144 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -115,7 +115,7 @@ static const TypeInfo serial_pci_info = {
     .instance_size = sizeof(PCISerialState),
     .instance_init = serial_pci_init,
     .class_init    = serial_pci_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 00572873d28..eb79f5258b6 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1188,7 +1188,7 @@ static const TypeInfo virtio_device_info = {
     .parent = TYPE_VIRTIO_DEVICE,
     .instance_size = sizeof(VirtIOSerial),
     .class_init = virtio_serial_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/core/bus.c b/hw/core/bus.c
index c3b431a014b..bddfc22d388 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -260,7 +260,7 @@ static const TypeInfo bus_info = {
     .instance_init = qbus_initfn,
     .instance_finalize = qbus_finalize,
     .class_init = bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_RESETTABLE_INTERFACE },
         { }
     },
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 14706565b78..3b0f011a482 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -870,7 +870,7 @@ static const TypeInfo device_type_info = {
     .class_init = device_class_init,
     .abstract = true,
     .class_size = sizeof(DeviceClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_VMSTATE_IF },
         { TYPE_RESETTABLE_INTERFACE },
         { }
diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
index c57bf555f97..5455b4f6219 100644
--- a/hw/cxl/switch-mailbox-cci.c
+++ b/hw/cxl/switch-mailbox-cci.c
@@ -97,7 +97,7 @@ static const TypeInfo cswmbcci_info = {
     .parent = TYPE_PCI_DEVICE,
     .class_init = cswmbcci_class_init,
     .instance_size = sizeof(CSWMBCCIDev),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 4e88d099431..7de27732cdc 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1079,7 +1079,7 @@ static const TypeInfo ati_vga_info = {
     .instance_size = sizeof(ATIVGAState),
     .class_init = ati_vga_class_init,
     .instance_init = ati_vga_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
           { },
     },
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 1d329fc9cce..ad2821c9745 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -374,7 +374,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_size  = sizeof(BochsDisplayState),
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
-    .interfaces     = (InterfaceInfo[]) {
+    .interfaces     = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 4e5ae04af0f..ef08694626d 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3013,7 +3013,7 @@ static const TypeInfo cirrus_vga_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCICirrusVGAState),
     .class_init    = cirrus_vga_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0e4612d55aa..a8cd0209a3c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2496,7 +2496,7 @@ static const TypeInfo qxl_pci_type_info = {
     .instance_size = sizeof(PCIQXLDevice),
     .abstract = true,
     .class_init = qxl_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index dcff1e978ed..6d2f18684c3 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2196,7 +2196,7 @@ static const TypeInfo sm501_pci_info = {
     .instance_size = sizeof(SM501PCIState),
     .class_init    = sm501_pci_class_init,
     .instance_init = sm501_pci_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index a8601972740..b81f7fd2d0f 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -369,7 +369,7 @@ static const TypeInfo vga_pci_type_info = {
     .instance_size = sizeof(PCIVGAState),
     .abstract = true,
     .class_init = vga_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index abbb898c65d..5fdff37f2c1 100644
--- a/hw/display/virtio-gpu-pci-rutabaga.c
+++ b/hw/display/virtio-gpu-pci-rutabaga.c
@@ -34,7 +34,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
         .parent = TYPE_VIRTIO_GPU_PCI_BASE,
         .instance_size = sizeof(VirtIOGPURutabagaPCI),
         .instance_init = virtio_gpu_rutabaga_initfn,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         }
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 7777deb17d0..544bb65320b 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1363,7 +1363,7 @@ static const TypeInfo vmsvga_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(struct pci_vmsvga_state_s),
     .class_init    = vmsvga_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 1d67e505364..2463952ada2 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -618,7 +618,7 @@ static const TypeInfo i8257_info = {
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8257State),
     .class_init = i8257_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ISADMA },
         { }
     }
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index bf1b523ac88..2020399fd59 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -662,7 +662,7 @@ static const TypeInfo xilinx_axidma_data_stream_info = {
     .instance_size = sizeof(XilinxAXIDMAStreamSink),
     .class_init    = xilinx_axidma_stream_class_init,
     .class_data    = &xilinx_axidma_data_stream_class,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_STREAM_SINK },
         { }
     }
@@ -674,7 +674,7 @@ static const TypeInfo xilinx_axidma_control_stream_info = {
     .instance_size = sizeof(XilinxAXIDMAStreamSink),
     .class_init    = xilinx_axidma_stream_class_init,
     .class_data    = &xilinx_axidma_control_stream_class,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_STREAM_SINK },
         { }
     }
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 6943c927d07..3db3904d835 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -744,7 +744,7 @@ static const TypeInfo xlnx_csu_dma_info = {
     .class_init    = xlnx_csu_dma_class_init,
     .class_size    = sizeof(XlnxCSUDMAClass),
     .instance_init = xlnx_csu_dma_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_STREAM_SINK },
         { }
     }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 37f6cb6346b..6e04c0d13d5 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -712,7 +712,7 @@ static const TypeInfo HP_B160L_machine_init_typeinfo = {
     .name = MACHINE_TYPE_NAME("B160L"),
     .parent = TYPE_MACHINE,
     .class_init = HP_B160L_machine_init_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NMI },
         { }
     },
@@ -748,7 +748,7 @@ static const TypeInfo HP_C3700_machine_init_typeinfo = {
     .name = MACHINE_TYPE_NAME("C3700"),
     .parent = TYPE_MACHINE,
     .class_init = HP_C3700_machine_init_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NMI },
         { }
     },
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index f1fca30fea5..956c9b59bbc 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -145,7 +145,7 @@ static const TypeInfo ich9_smb_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(ICH9SMBState),
     .class_init = ich9_smb_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a6654cfa8af..08c18174c2e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1720,7 +1720,7 @@ static const TypeInfo amdvi_pci = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(AMDVIPCIState),
     .class_init = amdvi_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a0e39673c9e..ef7401dc162 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -726,7 +726,7 @@ static const TypeInfo microvm_machine_info = {
     .instance_init = microvm_machine_initfn,
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 62ac43e5a88..65e54ee4310 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1862,7 +1862,7 @@ static const TypeInfo pc_machine_info = {
     .instance_init = pc_machine_initfn,
     .class_size = sizeof(PCMachineClass),
     .class_init = pc_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d5590cd0b53..e3defb774f6 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -173,7 +173,7 @@ static const TypeInfo sgx_epc_info = {
     .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
     },
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c8e2551b2b4..e2d04092992 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -450,7 +450,7 @@ static const TypeInfo x86_machine_info = {
     .instance_init = x86_machine_initfn,
     .class_size = sizeof(X86MachineClass),
     .class_init = x86_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_NMI },
          { }
     },
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 7c0d345f964..c8b852be0cc 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -604,7 +604,7 @@ static const TypeInfo xen_platform_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIXenPlatformState),
     .class_init    = xen_platform_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 65868bd5e59..87a974ae5a0 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -139,7 +139,7 @@ static const TypeInfo xen_pv_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XenPVDevice),
     .class_init    = xen_pv_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index f2773ab4621..4cade0d1219 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -197,7 +197,7 @@ static const TypeInfo ich_ahci_info = {
     .instance_size = sizeof(AHCIPCIState),
     .instance_init = pci_ich9_ahci_init,
     .class_init    = ich_ahci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 0ed72e42233..1e50bb9e483 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -625,7 +625,7 @@ static const TypeInfo pci_ide_type_info = {
     .instance_size = sizeof(PCIIDEState),
     .instance_init = pci_ide_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 83930dd50c0..71f5f976e9c 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -958,7 +958,7 @@ static const TypeInfo i8042_info = {
     .instance_size = sizeof(ISAKBDState),
     .instance_init = i8042_initfn,
     .class_init    = i8042_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index f61d1c1fe60..0f0c48d89ab 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -382,7 +382,7 @@ static const TypeInfo arm_gic_common_type = {
     .class_size = sizeof(ARMGICCommonClass),
     .class_init = arm_gic_common_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo []) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
         { },
     },
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index dd86a50300a..1cee68193ca 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -644,7 +644,7 @@ static const TypeInfo arm_gicv3_common_type = {
     .class_init = arm_gicv3_common_class_init,
     .instance_finalize = arm_gicv3_finalize,
     .abstract = true,
-    .interfaces = (InterfaceInfo []) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
         { },
     },
diff --git a/hw/intc/goldfish_pic.c b/hw/intc/goldfish_pic.c
index b80538cdeba..2359861785d 100644
--- a/hw/intc/goldfish_pic.c
+++ b/hw/intc/goldfish_pic.c
@@ -204,7 +204,7 @@ static const TypeInfo goldfish_pic_info = {
     .class_init = goldfish_pic_class_init,
     .instance_init = goldfish_pic_instance_init,
     .instance_size = sizeof(GoldfishPICState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_INTERRUPT_STATS_PROVIDER },
          { }
     },
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 4a92e0da908..602e44c8eaf 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -226,7 +226,7 @@ static const TypeInfo pic_common_type = {
     .class_size = sizeof(PICCommonClass),
     .class_init = pic_common_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
         { }
     },
diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index b0381c7990d..fce3486e519 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -215,7 +215,7 @@ static const TypeInfo ioapic_common_type = {
     .class_size = sizeof(IOAPICCommonClass),
     .class_init = ioapic_common_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
         { }
     },
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 215e1a6ed5b..2532322618a 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -110,7 +110,7 @@ static const TypeInfo m68k_irqc_type_info = {
     .instance_size = sizeof(M68KIRQCState),
     .instance_init = m68k_irqc_instance_init,
     .class_init = m68k_irqc_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_NMI },
          { TYPE_INTERRUPT_STATS_PROVIDER },
          { }
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index b67c2ed6c7e..155c46b6404 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -2106,7 +2106,7 @@ static const TypeInfo pnv_xive_info = {
     .instance_size = sizeof(PnvXive),
     .class_init    = pnv_xive_class_init,
     .class_size    = sizeof(PnvXiveClass),
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 8c9bcd40b92..fd9ecd2a898 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2441,7 +2441,7 @@ static const TypeInfo pnv_xive2_info = {
     .instance_size = sizeof(PnvXive2),
     .class_init    = pnv_xive2_class_init,
     .class_size    = sizeof(PnvXive2Class),
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index 5776055a8b4..00b80bb177c 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -460,7 +460,7 @@ static const TypeInfo slavio_intctl_info = {
     .instance_size = sizeof(SLAVIO_INTCTLState),
     .instance_init = slavio_intctl_init,
     .class_init    = slavio_intctl_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
         { }
     },
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index fad03dbfbe8..9f00d717c98 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -856,7 +856,7 @@ static const TypeInfo spapr_xive_info = {
     .instance_size = sizeof(SpaprXive),
     .class_init = spapr_xive_class_init,
     .class_size = sizeof(SpaprXiveClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_SPAPR_INTC },
         { }
     },
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 9e465fb8f3b..7663596a4a4 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -461,7 +461,7 @@ static const TypeInfo ics_spapr_info = {
     .name = TYPE_ICS_SPAPR,
     .parent = TYPE_ICS,
     .class_init = ics_spapr_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_SPAPR_INTC },
         { }
     },
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a91d71d108e..43c1bf5296c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -2028,7 +2028,7 @@ static const TypeInfo xive_router_info = {
     .instance_size = sizeof(XiveRouter),
     .class_size    = sizeof(XiveRouterClass),
     .class_init    = xive_router_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_XIVE_NOTIFIER },
         { TYPE_XIVE_PRESENTER },
         { }
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index cf37aa2e4a7..88eef9a1d14 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1052,7 +1052,7 @@ static const TypeInfo xive2_router_info = {
     .instance_size = sizeof(Xive2Router),
     .class_size    = sizeof(Xive2RouterClass),
     .class_init    = xive2_router_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_XIVE_NOTIFIER },
         { TYPE_XIVE_PRESENTER },
         { }
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index f6993330d23..40b30517c75 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -650,7 +650,7 @@ static const TypeInfo tpci200_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(TPCI200State),
     .class_init    = tpci200_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index f7f7abcca89..fa8b3ac1066 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -161,7 +161,7 @@ static const TypeInfo isa_ipmi_bt_info = {
     .instance_size = sizeof(ISAIPMIBTDevice),
     .instance_init = isa_ipmi_bt_init,
     .class_init    = isa_ipmi_bt_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IPMI_INTERFACE },
         { TYPE_ACPI_DEV_AML_IF },
         { }
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index 67969ca0636..0bd5554f78f 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -168,7 +168,7 @@ static const TypeInfo isa_ipmi_kcs_info = {
     .instance_size = sizeof(ISAIPMIKCSDevice),
     .instance_init = isa_ipmi_kcs_init,
     .class_init    = isa_ipmi_kcs_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IPMI_INTERFACE },
         { TYPE_ACPI_DEV_AML_IF },
         { }
diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
index 78d81420089..5709a1efe89 100644
--- a/hw/ipmi/pci_ipmi_bt.c
+++ b/hw/ipmi/pci_ipmi_bt.c
@@ -133,7 +133,7 @@ static const TypeInfo pci_ipmi_bt_info = {
     .instance_size = sizeof(PCIIPMIBTDevice),
     .instance_init = pci_ipmi_bt_instance_init,
     .class_init    = pci_ipmi_bt_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IPMI_INTERFACE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
index 40127de393e..64d70506779 100644
--- a/hw/ipmi/pci_ipmi_kcs.c
+++ b/hw/ipmi/pci_ipmi_kcs.c
@@ -133,7 +133,7 @@ static const TypeInfo pci_ipmi_kcs_info = {
     .instance_size = sizeof(PCIIPMIKCSDevice),
     .instance_init = pci_ipmi_kcs_instance_init,
     .class_init    = pci_ipmi_kcs_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IPMI_INTERFACE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index 7345844a3a9..78c332de54d 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -376,7 +376,7 @@ static const TypeInfo smbus_ipmi_info = {
     .instance_size = sizeof(SMBusIPMIDevice),
     .instance_init = smbus_ipmi_init,
     .class_init    = smbus_ipmi_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_IPMI_INTERFACE },
         { TYPE_ACPI_DEV_AML_IF },
         { }
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 26c8ec4f77a..06e8f0ce3e0 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -142,7 +142,7 @@ static const TypeInfo i82378_type_info = {
     .instance_size = sizeof(I82378State),
     .instance_init = i82378_init,
     .class_init = i82378_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index d3e623b1e88..71afb45b631 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -915,7 +915,7 @@ static const TypeInfo ich9_lpc_info = {
     .instance_size = sizeof(ICH9LPCState),
     .instance_init = ich9_lpc_initfn,
     .class_init  = ich9_lpc_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2c6e76f97cc..52c14d3cd5b 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -445,7 +445,7 @@ static const TypeInfo piix_pci_type_info = {
     .instance_init = pci_piix_init,
     .abstract = true,
     .class_init = pci_piix_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { TYPE_ACPI_DEV_AML_IF },
         { },
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index c62afc907b2..337958617a4 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -243,7 +243,7 @@ static const TypeInfo via_pm_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(ViaPMState),
     .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -634,7 +634,7 @@ static const TypeInfo via_isa_info = {
     .instance_size = sizeof(ViaISAState),
     .instance_init = via_isa_init,
     .abstract      = true,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c3ede6e74c..422259c3a81 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1507,7 +1507,7 @@ static const TypeInfo virt_machine_types[] = {
         .instance_size  = sizeof(LoongArchVirtMachineState),
         .class_init     = virt_class_init,
         .instance_init  = virt_initfn,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
         },
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index b428e7c833e..36de67c328e 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -248,7 +248,7 @@ static const TypeInfo glue_info_types[] = {
         .instance_init = glue_init,
         .instance_finalize = glue_finalize,
         .class_init = glue_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
              { TYPE_NMI },
              { }
         },
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b98c068476d..4ae2985891d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2161,7 +2161,7 @@ static const TypeInfo ct3d_info = {
     .class_size = sizeof(struct CXLType3Class),
     .class_init = ct3_class_init,
     .instance_size = sizeof(CXLType3Dev),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CXL_DEVICE },
         { INTERFACE_PCIE_DEVICE },
         {}
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6f68171442f..f701d5b5f9b 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -301,7 +301,7 @@ static const TypeInfo pc_dimm_info = {
     .instance_init = pc_dimm_init,
     .class_init    = pc_dimm_class_init,
     .class_size    = sizeof(PCDIMMDeviceClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
     },
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index d83a81b60d3..a015d4a9b8c 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -393,7 +393,7 @@ static const TypeInfo applesmc_isa_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(AppleSMCState),
     .class_init    = qdev_applesmc_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index a6e0786b6f1..b92c7e06bef 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -431,7 +431,7 @@ static void edu_class_init(ObjectClass *class, const void *data)
 
 static void pci_edu_register_types(void)
 {
-    static InterfaceInfo interfaces[] = {
+    static const InterfaceInfo interfaces[] = {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     };
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 2844b6f9099..5a10bca633d 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -1002,7 +1002,7 @@ static const TypeInfo ivshmem_common_info = {
     .instance_size = sizeof(IVShmemState),
     .abstract      = true,
     .class_init    = ivshmem_common_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1b4e386b0d8..f03cf7e06fc 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -205,7 +205,7 @@ static const TypeInfo macio_gpio_init_info = {
     .instance_size = sizeof(MacIOGPIOState),
     .instance_init = macio_gpio_init,
     .class_init    = macio_gpio_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NMI },
         { }
     },
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index b0418db49ea..6710485d728 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -465,7 +465,7 @@ static const TypeInfo macio_type_info = {
     .instance_init = macio_instance_init,
     .abstract      = true,
     .class_init    = macio_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 0ea26451f1f..3f6a8bba84f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -345,7 +345,7 @@ static const TypeInfo pci_testdev_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCITestDevState),
     .class_init    = pci_testdev_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/misc/pvpanic-isa.c b/hw/misc/pvpanic-isa.c
index 55522ee56cb..f7b421c713b 100644
--- a/hw/misc/pvpanic-isa.c
+++ b/hw/misc/pvpanic-isa.c
@@ -121,7 +121,7 @@ static const TypeInfo pvpanic_isa_info = {
     .instance_size = sizeof(PVPanicISAState),
     .instance_init = pvpanic_isa_initfn,
     .class_init    = pvpanic_isa_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index 51ebf661076..2869b6a7ff8 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -80,7 +80,7 @@ static const TypeInfo pvpanic_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PVPanicPCIState),
     .class_init    = pvpanic_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index e28d569ebef..1ce083e2409 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -833,7 +833,7 @@ static const TypeInfo cframe_reg_info = {
     .instance_size = sizeof(XlnxVersalCFrameReg),
     .class_init    = cframe_reg_class_init,
     .instance_init = cframe_reg_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
     }
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 02e4fed05b9..b920fc77c3f 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -532,7 +532,7 @@ static const TypeInfo cfu_apb_info = {
     .instance_size = sizeof(XlnxVersalCFUAPB),
     .class_init    = cfu_apb_class_init,
     .instance_init = cfu_apb_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
     }
@@ -545,7 +545,7 @@ static const TypeInfo cfu_fdro_info = {
     .class_init    = cfu_fdro_class_init,
     .instance_init = cfu_fdro_init,
     .instance_finalize = cfu_fdro_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
     }
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index c0bb598baef..be16769de29 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -305,7 +305,7 @@ static const TypeInfo kvaser_pci_info = {
     .instance_size = sizeof(KvaserPCIState),
     .class_init    = kvaser_pci_class_init,
     .instance_init = kvaser_pci_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 9aac70dccd3..44f3ba370dc 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -248,7 +248,7 @@ static const TypeInfo mioe3680_pci_info = {
     .instance_size = sizeof(Mioe3680PCIState),
     .class_init    = mioe3680_pci_class_init,
     .instance_init = mioe3680_pci_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index b305f7e9b7d..7296d63be79 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -249,7 +249,7 @@ static const TypeInfo pcm3680i_pci_info = {
     .instance_size = sizeof(Pcm3680iPCIState),
     .class_init    = pcm3680i_pci_class_init,
     .instance_init = pcm3680i_pci_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index 0dee9b59d10..bed6785433e 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -262,7 +262,7 @@ static const TypeInfo ctucan_pci_info = {
     .instance_size = sizeof(CtuCanPCIState),
     .class_init    = ctucan_pci_class_init,
     .instance_init = ctucan_pci_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 13814e84d18..cba4999e6d0 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1732,7 +1732,7 @@ static const TypeInfo e1000_base_info = {
     .instance_init = e1000_instance_init,
     .class_size    = sizeof(E1000BaseClass),
     .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 5e58f39235e..ae4fcdc544d 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -722,7 +722,7 @@ static const TypeInfo e1000e_info = {
     .instance_size = sizeof(E1000EState),
     .class_init = e1000e_class_init,
     .instance_init = e1000e_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 02a4e787f67..10d4a00ec99 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2096,7 +2096,7 @@ static void eepro100_register_types(void)
         type_info.class_init = eepro100_class_init;
         type_info.instance_size = sizeof(EEPRO100State);
         type_info.instance_init = eepro100_instance_init;
-        type_info.interfaces = (InterfaceInfo[]) {
+        type_info.interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         };
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 61e7ea7896b..62c5869f51d 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -632,7 +632,7 @@ static const TypeInfo igb_info = {
     .instance_size = sizeof(IGBState),
     .class_init = igb_class_init,
     .instance_init = igb_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 91e7ccf931b..31d72c4977d 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -325,7 +325,7 @@ static const TypeInfo igbvf_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(IgbVfState),
     .class_init = igbvf_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 2153973af43..ce937e1b618 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -122,7 +122,7 @@ static const TypeInfo ne2000_info = {
     .instance_size = sizeof(PCINE2000State),
     .class_init    = ne2000_class_init,
     .instance_init = ne2000_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 429c2171803..0ca5bc21938 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -280,7 +280,7 @@ static const TypeInfo pcnet_info = {
     .instance_size = sizeof(PCIPCNetState),
     .class_init    = pcnet_class_init,
     .instance_init = pcnet_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 3d307f4ab15..cc49701dd3c 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1498,7 +1498,7 @@ static const TypeInfo rocker_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Rocker),
     .class_init    = rocker_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index ad812954cf8..15b8f7501ae 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3438,7 +3438,7 @@ static const TypeInfo rtl8139_info = {
     .instance_size = sizeof(RTL8139State),
     .class_init    = rtl8139_class_init,
     .instance_init = rtl8139_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 123d08ee8e3..b405eb89fa5 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1477,7 +1477,7 @@ static const TypeInfo sungem_info = {
     .instance_size = sizeof(SunGEMState),
     .class_init    = sungem_class_init,
     .instance_init = sungem_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 46c9f5020b1..c2f7a8483da 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -958,7 +958,7 @@ static const TypeInfo sunhme_info = {
     .class_init    = sunhme_class_init,
     .instance_size = sizeof(SunHMEState),
     .instance_init = sunhme_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index fb3366d8ee3..63fe5134586 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1035,7 +1035,7 @@ static const TypeInfo tulip_info = {
     .instance_size = sizeof(TULIPState),
     .class_init    = tulip_class_init,
     .instance_init = tulip_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 702a0ac78dc..85c230e3e93 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2523,7 +2523,7 @@ static const TypeInfo vmxnet3_info = {
     .instance_size = sizeof(VMXNET3State),
     .class_init    = vmxnet3_class_init,
     .instance_init = vmxnet3_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index e45bc048e05..1f5c7480476 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -1045,7 +1045,7 @@ static const TypeInfo xilinx_enet_data_stream_info = {
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(XilinxAXIEnetStreamSink),
     .class_init    = xilinx_enet_data_stream_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
             { TYPE_STREAM_SINK },
             { }
     }
@@ -1056,7 +1056,7 @@ static const TypeInfo xilinx_enet_control_stream_info = {
     .parent        = TYPE_OBJECT,
     .instance_size = sizeof(XilinxAXIEnetStreamSink),
     .class_init    = xilinx_enet_control_stream_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
             { TYPE_STREAM_SINK },
             { }
     }
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a49f1ea9cfe..5c378034ee1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9097,7 +9097,7 @@ static const TypeInfo nvme_info = {
     .instance_size = sizeof(NvmeCtrl),
     .instance_init = nvme_instance_init,
     .class_init    = nvme_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index ab3b550a889..1065245a8b8 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -241,7 +241,7 @@ static const TypeInfo cxl_dsp_info = {
     .instance_size = sizeof(CXLDownstreamPort),
     .parent = TYPE_PCIE_SLOT,
     .class_init = cxl_dsp_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
         { }
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 8b1e149e9ba..e6a4035d26c 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -294,7 +294,7 @@ static const TypeInfo cxl_root_port_info = {
     .parent = TYPE_PCIE_ROOT_PORT,
     .instance_size = sizeof(CXLRootPort),
     .class_init = cxl_root_port_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CXL_DEVICE },
         { }
     },
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 822a8285554..208e0c6172e 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -394,7 +394,7 @@ static const TypeInfo cxl_usp_info = {
     .parent = TYPE_PCIE_PORT,
     .instance_size = sizeof(CXLUpstreamPort),
     .class_init = cxl_upstream_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CXL_DEVICE },
         { }
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index f2b294aee27..1d73c14c1f8 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -107,7 +107,7 @@ static const TypeInfo i82801b11_bridge_info = {
     .parent        = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(I82801b11Bridge),
     .class_init    = i82801b11_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index 4ac07e82567..3df2517dbc9 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -268,7 +268,7 @@ static const TypeInfo pci_bridge_dev_info = {
     .instance_size     = sizeof(PCIBridgeDev),
     .class_init        = pci_bridge_dev_class_init,
     .instance_finalize = pci_bridge_dev_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1e2e394ee8a..3a29dfefc2c 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -449,7 +449,7 @@ static const TypeInfo pxb_dev_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PXBDev),
     .class_init    = pxb_dev_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -486,7 +486,7 @@ static const TypeInfo pxb_pcie_dev_info = {
     .parent        = TYPE_PXB_DEV,
     .instance_size = sizeof(PXBPCIEDev),
     .class_init    = pxb_pcie_dev_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -537,7 +537,7 @@ static const TypeInfo pxb_cxl_dev_info = {
     .instance_size = sizeof(PXBCXLDev),
     .class_init    = pxb_cxl_dev_class_init,
     .interfaces =
-        (InterfaceInfo[]){
+        (const InterfaceInfo[]){
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             {},
         },
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index bb81bccb185..4f3cfb11ceb 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -163,7 +163,7 @@ static const TypeInfo pcie_pci_bridge_info = {
         .parent = TYPE_PCI_BRIDGE,
         .instance_size = sizeof(PCIEPCIBridge),
         .class_init = pcie_pci_bridge_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
             { INTERFACE_PCIE_DEVICE },
             { },
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 512c2ab305c..22c2fdb71e7 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -188,7 +188,7 @@ static const TypeInfo rp_info = {
     .class_init    = rp_class_init,
     .abstract      = true,
     .class_size = sizeof(PCIERootPortClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index c7565d9e946..bbae594e119 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -87,7 +87,7 @@ static const TypeInfo simba_pci_bridge_info = {
     .parent        = TYPE_PCI_BRIDGE,
     .class_init    = simba_pci_bridge_class_init,
     .instance_size = sizeof(SimbaPCIBridge),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index d85c23fe4a8..dc7d1aa7d77 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -175,7 +175,7 @@ static const TypeInfo xio3130_downstream_info = {
     .name          = TYPE_XIO3130_DOWNSTREAM,
     .parent        = TYPE_PCIE_SLOT,
     .class_init    = xio3130_downstream_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index d7a27158124..40057b749bf 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -144,7 +144,7 @@ static const TypeInfo xio3130_upstream_info = {
     .name          = "x3130-upstream",
     .parent        = TYPE_PCIE_PORT,
     .class_init    = xio3130_upstream_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 043fb85e840..cc65aac2a87 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -273,7 +273,7 @@ static const TypeInfo articia_types[] = {
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(ArticiaHostState),
         .class_init    = articia_pci_host_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
               { INTERFACE_CONVENTIONAL_PCI_DEVICE },
               { },
         },
@@ -283,7 +283,7 @@ static const TypeInfo articia_types[] = {
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(PCIDevice),
         .class_init    = articia_pci_bridge_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
               { INTERFACE_CONVENTIONAL_PCI_DEVICE },
               { },
         },
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 4508cdd21ae..7d6251a78d7 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -783,7 +783,7 @@ static const TypeInfo bonito_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIBonitoState),
     .class_init    = bonito_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 70759cab149..4a2cf11bac1 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -766,7 +766,7 @@ static const TypeInfo designware_pcie_types[] = {
         .parent         = TYPE_PCI_BRIDGE,
         .instance_size  = sizeof(DesignwarePCIERoot),
         .class_init     = designware_pcie_root_class_init,
-        .interfaces     = (InterfaceInfo[]) {
+        .interfaces     = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
         },
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 7dcac4ee3c4..b806a2286f7 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -261,7 +261,7 @@ static const TypeInfo gpex_root_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(GPEXRootState),
     .class_init = gpex_root_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index b48d44623dd..f9da5a908c1 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -116,7 +116,7 @@ static const TypeInfo grackle_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = grackle_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index bd74b6e8714..56a6ef93b7a 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1268,7 +1268,7 @@ static const TypeInfo gt64120_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = gt64120_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index fcc9f3818a4..e13bb1b53e4 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -341,7 +341,7 @@ static const TypeInfo i440fx_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCII440FXState),
     .class_init    = i440fx_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index 591186f41ff..41a68959831 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -46,7 +46,7 @@ static const TypeInfo mv64361_pcibridge_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = mv64361_pcibridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 4e24b1449d0..1f7a149580d 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -354,7 +354,7 @@ static const TypeInfo pnv_pbcq_type_info = {
     .instance_size = sizeof(PnvPBCQState),
     .instance_init = phb3_pbcq_instance_init,
     .class_init    = pnv_pbcq_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index feb812dc1a9..77ea35299d3 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1714,7 +1714,7 @@ static const TypeInfo pnv_phb4_type_info = {
     .instance_init = pnv_phb4_instance_init,
     .instance_size = sizeof(PnvPHB4),
     .class_init    = pnv_phb4_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_NOTIFIER },
             { },
     }
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index a4e5e8c226c..645c745dd45 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -340,7 +340,7 @@ static const TypeInfo pnv_pec_type_info = {
     .instance_size = sizeof(PnvPhb4PecState),
     .class_init    = pnv_pec_class_init,
     .class_size    = sizeof(PnvPhb4PecClass),
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
@@ -392,7 +392,7 @@ static const TypeInfo pnv_phb5_pec_type_info = {
     .instance_size = sizeof(PnvPhb4PecState),
     .class_init    = pnv_phb5_pec_class_init,
     .class_size    = sizeof(PnvPhb4PecClass),
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/pci-host/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
index dcc4b78660c..25478176881 100644
--- a/hw/pci-host/ppc4xx_pci.c
+++ b/hw/pci-host/ppc4xx_pci.c
@@ -370,7 +370,7 @@ static const TypeInfo ppc4xx_host_bridge_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = ppc4xx_host_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 2f6354c931e..e97a515d5fe 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -528,7 +528,7 @@ static const TypeInfo e500_pci_types[] = {
         .parent        = TYPE_PCI_DEVICE,
         .instance_size = sizeof(PPCE500PCIBridgeState),
         .class_init    = e500_host_bridge_class_init,
-        .interfaces    = (InterfaceInfo[]) {
+        .interfaces    = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         },
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index c2a71108f2e..1951ae440cc 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -703,7 +703,7 @@ static const TypeInfo mch_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MCHPCIState),
     .class_init = mch_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 3f158838a0a..21f7ca65e06 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -416,7 +416,7 @@ static const TypeInfo raven_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(RavenPCIState),
     .class_init = raven_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index f7086086f9a..538624c5079 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -477,7 +477,7 @@ static const TypeInfo sabre_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(SabrePCIState),
     .class_init    = sabre_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 52bff66d6a1..de8f6a84aab 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -186,7 +186,7 @@ static const TypeInfo sh_pcic_types[] = {
         .parent         = TYPE_PCI_DEVICE,
         .instance_size  = sizeof(PCIDevice),
         .class_init     = sh_pcic_pci_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         },
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 7cb37e01d8f..194037d6e75 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -333,7 +333,7 @@ static const TypeInfo unin_main_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = unin_main_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -361,7 +361,7 @@ static const TypeInfo u3_agp_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = u3_agp_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -389,7 +389,7 @@ static const TypeInfo unin_agp_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = unin_agp_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -418,7 +418,7 @@ static const TypeInfo unin_internal_pci_host_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = unin_internal_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 10bb89f528f..24458b676e9 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -492,7 +492,7 @@ static const TypeInfo versatile_pci_host_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init    = versatile_pci_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 70e9b2b9810..c71492de9e7 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -314,7 +314,7 @@ static const TypeInfo xilinx_pcie_root_info = {
     .parent = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(XilinxPCIERoot),
     .class_init = xilinx_pcie_root_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { }
     },
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e9e0524f5c3..4529241ee8f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -288,7 +288,7 @@ static const TypeInfo pci_bus_info = {
     .instance_size = sizeof(PCIBus),
     .class_size = sizeof(PCIBusClass),
     .class_init = pci_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
         { }
     }
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 0fe66e8b12d..76255c4cd89 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -497,7 +497,7 @@ static const TypeInfo pci_bridge_type_info = {
     .instance_size = sizeof(PCIBridge),
     .class_init = pci_bridge_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index 8629b3aafd6..54f639e3d4f 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -230,7 +230,7 @@ static const TypeInfo pcie_slot_type_info = {
     .instance_size = sizeof(PCIESlot),
     .abstract = true,
     .class_init = pcie_slot_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index cd594eeb3ed..775b9d8da00 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -107,7 +107,7 @@ static const TypeInfo e500plat_info = {
     .name          = TYPE_E500PLAT_MACHINE,
     .parent        = TYPE_PPCE500_MACHINE,
     .class_init    = e500plat_machine_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
     }
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index dc4bd85544a..bc74808a785 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -645,7 +645,7 @@ static const TypeInfo core99_machine_info = {
     .class_init    = core99_machine_class_init,
     .instance_init = core99_instance_init,
     .instance_size = sizeof(Core99MachineState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
     },
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 3906fb724e6..614929b463e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -434,7 +434,7 @@ static const TypeInfo ppc_heathrow_machine_info = {
     .name          = MACHINE_TYPE_NAME("g3beige"),
     .parent        = TYPE_MACHINE,
     .class_init    = heathrow_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
     },
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index ebc4379764e..20d4b6b238b 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -620,7 +620,7 @@ static const TypeInfo pegasos2_machine_info = {
     .parent        = TYPE_MACHINE,
     .class_init    = pegasos2_machine_class_init,
     .instance_size = sizeof(Pegasos2MachineState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_VOF_MACHINE_IF },
         { }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6d95e24dd2b..8bf8c1149d0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2926,7 +2926,7 @@ static const TypeInfo types[] = {
         .name          = MACHINE_TYPE_NAME("powernv10"),
         .parent        = TYPE_PNV_MACHINE,
         .class_init    = pnv_machine_power10_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_FABRIC },
             { },
         },
@@ -2935,7 +2935,7 @@ static const TypeInfo types[] = {
         .name          = MACHINE_TYPE_NAME("powernv9"),
         .parent        = TYPE_PNV_MACHINE,
         .class_init    = pnv_machine_power9_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_FABRIC },
             { },
         },
@@ -2944,7 +2944,7 @@ static const TypeInfo types[] = {
         .name          = MACHINE_TYPE_NAME("powernv8"),
         .parent        = TYPE_PNV_MACHINE,
         .class_init    = pnv_machine_power8_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_XICS_FABRIC },
             { },
         },
@@ -2956,7 +2956,7 @@ static const TypeInfo types[] = {
         .instance_size = sizeof(PnvMachineState),
         .class_init    = pnv_machine_class_init,
         .class_size    = sizeof(PnvMachineClass),
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_INTERRUPT_STATS_PROVIDER },
             { TYPE_NMI },
             { },
diff --git a/hw/ppc/pnv_adu.c b/hw/ppc/pnv_adu.c
index f9620806ec7..005fbda4750 100644
--- a/hw/ppc/pnv_adu.c
+++ b/hw/ppc/pnv_adu.c
@@ -204,7 +204,7 @@ static const TypeInfo pnv_adu_type_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(PnvADU),
     .class_init    = pnv_adu_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { } },
 };
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index 4ca511a4dee..b9e9c7ba3db 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -478,7 +478,7 @@ static const TypeInfo pnv_chiptod_power9_type_info = {
     .parent        = TYPE_PNV_CHIPTOD,
     .instance_size = sizeof(PnvChipTOD),
     .class_init    = pnv_chiptod_power9_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
@@ -514,7 +514,7 @@ static const TypeInfo pnv_chiptod_power10_type_info = {
     .parent        = TYPE_PNV_CHIPTOD,
     .instance_size = sizeof(PnvChipTOD),
     .class_init    = pnv_chiptod_power10_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
index b2f372c8743..60de4794917 100644
--- a/hw/ppc/pnv_i2c.c
+++ b/hw/ppc/pnv_i2c.c
@@ -569,7 +569,7 @@ static const TypeInfo pnv_i2c_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(PnvI2C),
     .class_init    = pnv_i2c_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 84079443738..ae309a130aa 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -721,7 +721,7 @@ static const TypeInfo pnv_lpc_power8_info = {
     .name          = TYPE_PNV8_LPC,
     .parent        = TYPE_PNV_LPC,
     .class_init    = pnv_lpc_power8_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/pnv_n1_chiplet.c b/hw/ppc/pnv_n1_chiplet.c
index 05e3fd6f731..053f6473f22 100644
--- a/hw/ppc/pnv_n1_chiplet.c
+++ b/hw/ppc/pnv_n1_chiplet.c
@@ -159,7 +159,7 @@ static const TypeInfo pnv_n1_chiplet_info = {
     .instance_init = pnv_n1_chiplet_instance_init,
     .instance_size = sizeof(PnvN1Chiplet),
     .class_init    = pnv_n1_chiplet_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
index b5182d54fa1..1b1b14fed95 100644
--- a/hw/ppc/pnv_nest_pervasive.c
+++ b/hw/ppc/pnv_nest_pervasive.c
@@ -194,7 +194,7 @@ static const TypeInfo pnv_nest_pervasive_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(PnvNestChipletPervasive),
     .class_init    = pnv_nest_pervasive_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5eed22252df..1e84ab97aeb 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -913,7 +913,7 @@ static const TypeInfo pnv_psi_power9_info = {
     .instance_size = sizeof(Pnv9Psi),
     .instance_init = pnv_psi_power9_instance_init,
     .class_init    = pnv_psi_power9_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_NOTIFIER },
             { },
     },
@@ -959,7 +959,7 @@ static const TypeInfo pnv_psi_info = {
     .class_init    = pnv_psi_class_init,
     .class_size    = sizeof(PnvPsiClass),
     .abstract      = true,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bb31dc96a80..6bb226c726f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4683,7 +4683,7 @@ static const TypeInfo spapr_machine_info = {
     .instance_finalize = spapr_machine_finalizefn,
     .class_size    = sizeof(SpaprMachineClass),
     .class_init    = spapr_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER },
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a2f7e731623..ce10818f42f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2186,7 +2186,7 @@ static const TypeInfo spapr_phb_info = {
     .instance_size = sizeof(SpaprPhbState),
     .instance_finalize = spapr_phb_finalizefn,
     .class_init    = spapr_phb_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index dadc5ce3307..0cc3c3ad770 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -146,7 +146,7 @@ static const TypeInfo remote_machine = {
     .instance_size = sizeof(RemoteMachineState),
     .instance_init = remote_machine_instance_init,
     .class_init = remote_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
index d2de48c9e37..b0165aa2a1d 100644
--- a/hw/remote/proxy.c
+++ b/hw/remote/proxy.c
@@ -215,7 +215,7 @@ static const TypeInfo pci_proxy_dev_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIProxyDev),
     .class_init    = pci_proxy_dev_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 75f8d6df8a1..85882902d7f 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -188,7 +188,7 @@ static const TypeInfo remote_object_info = {
     .instance_finalize = remote_object_finalize,
     .class_size = sizeof(RemoteObjectClass),
     .class_init = remote_object_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 23f339936a2..803ca656a29 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -944,7 +944,7 @@ static const TypeInfo vfu_object_info = {
     .instance_finalize = vfu_object_finalize,
     .class_size = sizeof(VfuObjectClass),
     .class_init = vfu_object_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/hw/riscv/riscv-iommu-pci.c b/hw/riscv/riscv-iommu-pci.c
index 4e0e3cc5be5..106410b7ca4 100644
--- a/hw/riscv/riscv-iommu-pci.c
+++ b/hw/riscv/riscv-iommu-pci.c
@@ -208,7 +208,7 @@ static const TypeInfo riscv_iommu_pci = {
     .class_init = riscv_iommu_pci_class_init,
     .instance_init = riscv_iommu_pci_init,
     .instance_size = sizeof(RISCVIOMMUStatePci),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { },
     },
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1744ed8c73c..eb1878b8b20 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1980,7 +1980,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .class_init = virt_machine_class_init,
     .instance_init = virt_machine_instance_init,
     .instance_size = sizeof(RISCVVirtState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
     },
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 4a7c0af9f04..9e2f6563a0a 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -140,7 +140,7 @@ static const TypeInfo m48txx_isa_type_info = {
     .instance_size = sizeof(M48txxISAState),
     .abstract = true,
     .class_init = m48txx_isa_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NVRAM },
         { }
     }
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 821472a680e..68be2dad6f3 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -658,7 +658,7 @@ static const TypeInfo m48txx_sysbus_type_info = {
     .instance_init = m48t59_init1,
     .abstract = true,
     .class_init = m48txx_sysbus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NVRAM },
         { }
     }
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 93b632bdf4a..6f787be7af8 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -1038,7 +1038,7 @@ static const TypeInfo mc146818rtc_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(MC146818RtcState),
     .class_init    = rtc_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_ACPI_DEV_AML_IF },
         { },
     },
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 4aa7d5a90db..edeb3dbef34 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -75,7 +75,7 @@ static const TypeInfo ap_bridge_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = 0,
     .class_init    = ap_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 9d91e5a5fec..0f87b8c5c44 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -136,7 +136,7 @@ static const TypeInfo virtual_css_bridge_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(VirtualCssBridge),
     .class_init    = virtual_css_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3edc3493a46..cc777470bc1 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1338,7 +1338,7 @@ static const TypeInfo s390_pcihost_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(S390pciState),
     .class_init    = s390_pcihost_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 74848d34710..e95f885bce6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -873,7 +873,7 @@ static const TypeInfo ccw_machine_info = {
     .instance_init = s390_machine_initfn,
     .class_size = sizeof(S390CcwMachineClass),
     .class_init    = ccw_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_NMI },
         { TYPE_HOTPLUG_HANDLER},
         { }
diff --git a/hw/s390x/virtio-ccw-md.c b/hw/s390x/virtio-ccw-md.c
index de333282df4..0370f584505 100644
--- a/hw/s390x/virtio-ccw-md.c
+++ b/hw/s390x/virtio-ccw-md.c
@@ -140,7 +140,7 @@ static const TypeInfo virtio_ccw_md_info = {
     .instance_size = sizeof(VirtIOMDCcw),
     .class_size = sizeof(VirtIOMDCcwClass),
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
     },
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 74e9af0b5d8..12c86eb7aaa 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -450,7 +450,7 @@ static const TypeInfo esp_pci_info = {
     .instance_init = esp_pci_init,
     .instance_size = sizeof(PCIESPState),
     .class_init = esp_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 81da262289c..4f01ab2ce08 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2396,7 +2396,7 @@ static const TypeInfo lsi_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(LSIState),
     .class_init    = lsi_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 6104d4202aa..03cd837b44f 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2487,7 +2487,7 @@ typedef struct MegasasInfo {
     const VMStateDescription *vmsd;
     const Property *props;
     size_t props_count;
-    InterfaceInfo *interfaces;
+    const InterfaceInfo *interfaces;
 } MegasasInfo;
 
 static struct MegasasInfo megasas_devices[] = {
@@ -2504,7 +2504,7 @@ static struct MegasasInfo megasas_devices[] = {
         .vmsd = &vmstate_megasas_gen1,
         .props = megasas_properties_gen1,
         .props_count = ARRAY_SIZE(megasas_properties_gen1),
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         },
@@ -2521,7 +2521,7 @@ static struct MegasasInfo megasas_devices[] = {
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
         .props_count = ARRAY_SIZE(megasas_properties_gen2),
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
         },
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 17f73ce3816..1ebe0b82a79 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1441,7 +1441,7 @@ static const TypeInfo mptsas_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(MPTSASState),
     .class_init = mptsas1068_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index d7d0ef8f21f..7212e8a84bd 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1995,7 +1995,7 @@ static const TypeInfo scsi_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(SCSIBus),
     .class_init = scsi_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 6a7bb5949ad..3e5ae2e3379 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -398,7 +398,7 @@ static const TypeInfo vhost_scsi_info = {
     .instance_size = sizeof(VHostSCSI),
     .class_init = vhost_scsi_class_init,
     .instance_init = vhost_scsi_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
     },
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 807a58ecf4c..8298e8cc6d8 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -422,7 +422,7 @@ static const TypeInfo vhost_user_scsi_info = {
     .instance_size = sizeof(VHostUserSCSI),
     .class_init = vhost_user_scsi_class_init,
     .instance_init = vhost_user_scsi_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
     },
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 0d75f2d87a0..a813737d50a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1357,7 +1357,7 @@ static const TypeInfo virtio_scsi_info = {
     .parent = TYPE_VIRTIO_SCSI_COMMON,
     .instance_size = sizeof(VirtIOSCSI),
     .class_init = virtio_scsi_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a8ea57ffad3..d5825b67868 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1346,7 +1346,7 @@ static const TypeInfo pvscsi_info = {
     .class_size    = sizeof(PVSCSIClass),
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 4c2944df01c..e957dea4827 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -73,7 +73,7 @@ static const TypeInfo sdhci_pci_types[] = {
         .parent         = TYPE_PCI_DEVICE,
         .instance_size  = sizeof(SDHCIState),
         .class_init     = sdhci_pci_class_init,
-        .interfaces     = (InterfaceInfo[]) {
+        .interfaces     = (const InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
         },
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 0794c1fbff0..f92cb599881 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -397,7 +397,7 @@ static const TypeInfo ebus_info = {
     .parent        = TYPE_PCI_DEVICE,
     .class_init    = ebus_class_init,
     .instance_size = sizeof(EbusState),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
@@ -817,7 +817,7 @@ static const TypeInfo sun4u_type = {
     .name = MACHINE_TYPE_NAME("sun4u"),
     .parent = TYPE_MACHINE,
     .class_init = sun4u_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
         { }
     },
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 9575cb88fd5..a43878528e0 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1255,7 +1255,7 @@ static const TypeInfo pnv_spi_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PnvSpi),
     .class_init    = pnv_spi_class_init,
-    .interfaces    = (InterfaceInfo[]) {
+    .interfaces    = (const InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
     }
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8a3dd32fbeb..47c3e36282a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -337,7 +337,7 @@ static const TypeInfo tpm_crb_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CRBState),
     .class_init  = tpm_crb_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 1cad9a88ead..ea608ba4c80 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -414,7 +414,7 @@ static const TypeInfo tpm_spapr_info = {
     .parent        = TYPE_VIO_SPAPR_DEVICE,
     .instance_size = sizeof(SpaprTpmState),
     .class_init    = tpm_spapr_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 2c28028b54f..c23deaf7d96 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -556,7 +556,7 @@ static const TypeInfo tpm_tis_i2c_info = {
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(TPMStateI2C),
     .class_init    = tpm_tis_i2c_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index c0098a26e80..dce83057a94 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -189,7 +189,7 @@ static const TypeInfo tpm_tis_isa_info = {
     .instance_size = sizeof(TPMStateISA),
     .instance_init = tpm_tis_isa_initfn,
     .class_init  = tpm_tis_isa_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { TYPE_ACPI_DEV_AML_IF },
         { }
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 862556c3a64..969917c4c08 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -146,7 +146,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
     .instance_size = sizeof(TPMStateSysBus),
     .instance_init = tpm_tis_sysbus_initfn,
     .class_init  = tpm_tis_sysbus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_TPM_IF },
         { }
     }
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 24dcdc7ee36..54acdc56068 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1813,7 +1813,7 @@ static const TypeInfo ufs_info = {
     .parent = TYPE_PCI_DEVICE,
     .class_init = ufs_class_init,
     .instance_size = sizeof(UfsHc),
-    .interfaces = (InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
+    .interfaces = (const InterfaceInfo[]){ { INTERFACE_PCIE_DEVICE }, {} },
 };
 
 static const TypeInfo ufs_bus_info = {
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index d8446cf50e6..8dd2ce415eb 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -42,7 +42,7 @@ static const TypeInfo usb_bus_info = {
     .parent = TYPE_BUS,
     .instance_size = sizeof(USBBus),
     .class_init = usb_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 1bb4332238f..73a624aec69 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1459,7 +1459,7 @@ static const TypeInfo ccid_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBCCIDState),
     .class_init    = ccid_class_initfn,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 73122aa7971..38ad3406b32 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -172,7 +172,7 @@ static const TypeInfo ehci_pci_type_info = {
     .instance_finalize = usb_ehci_pci_finalize,
     .abstract = true,
     .class_init = ehci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 3c82525a1e4..94d1077eb9e 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -149,7 +149,7 @@ static const TypeInfo ohci_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(OHCIPCIState),
     .class_init    = ohci_pci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 2b1aee1f21f..4822c704f69 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1278,7 +1278,7 @@ static const TypeInfo uhci_pci_type_info = {
     .class_size    = sizeof(UHCIPCIDeviceClass),
     .abstract = true,
     .class_init = uhci_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index cc5c4e600e0..9128cbf16c9 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -224,7 +224,7 @@ static const TypeInfo xhci_pci_info = {
     .class_init    = xhci_class_init,
     .instance_init = xhci_instance_init,
     .abstract      = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index ebeceaadcd9..e92678fcc07 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -265,7 +265,7 @@ static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
     .name = "vfio-pci-igd-lpc-bridge",
     .parent = TYPE_PCI_DEVICE,
     .class_init = vfio_pci_igd_lpc_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 45b5560fb59..d6d5a81d1b2 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3442,7 +3442,7 @@ static const TypeInfo vfio_pci_dev_info = {
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
index 9ec50676626..9278b32cf84 100644
--- a/hw/virtio/virtio-md-pci.c
+++ b/hw/virtio/virtio-md-pci.c
@@ -138,7 +138,7 @@ static const TypeInfo virtio_md_pci_info = {
     .instance_size = sizeof(VirtIOMDPCI),
     .class_size = sizeof(VirtIOMDPCIClass),
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_MEMORY_DEVICE },
         { }
     },
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 9fc05a11da0..f8e8d52d992 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1909,7 +1909,7 @@ static const TypeInfo virtio_mem_info = {
     .instance_finalize = virtio_mem_instance_finalize,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_RAM_DISCARD_MANAGER },
         { }
     },
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 48082445bc6..a72f878e949 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2484,7 +2484,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         .name = t->generic_name,
         .parent = base_type_info.name,
         .class_init = virtio_pci_generic_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { }
@@ -2519,7 +2519,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->non_transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_non_transitional_instance_init,
-            .interfaces = (InterfaceInfo[]) {
+            .interfaces = (const InterfaceInfo[]) {
                 { INTERFACE_PCIE_DEVICE },
                 { INTERFACE_CONVENTIONAL_PCI_DEVICE },
                 { }
@@ -2533,7 +2533,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
             .name          = t->transitional_name,
             .parent        = base_type_info.name,
             .instance_init = virtio_pci_transitional_instance_init,
-            .interfaces = (InterfaceInfo[]) {
+            .interfaces = (const InterfaceInfo[]) {
                 /*
                  * Transitional virtio devices work only as Conventional PCI
                  * devices because they require PIO ports.
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 1536e1fe032..bb8a2766b69 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -480,7 +480,7 @@ static const TypeInfo i6300esb_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(I6300State),
     .class_init    = i6300esb_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index a1a53b2e85e..08342a37078 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -399,7 +399,7 @@ static const TypeInfo xen_bus_type_info = {
     .instance_size = sizeof(XenBus),
     .class_size = sizeof(XenBusClass),
     .class_init = xen_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     },
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 938dd8fb28f..eb1cb590b53 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -663,7 +663,7 @@ static const TypeInfo xensysbus_info = {
     .name       = TYPE_XENSYSBUS,
     .parent     = TYPE_BUS,
     .class_init = xen_sysbus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
     }
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index d9f1ddd25c6..6ab06d8ff6c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -1019,7 +1019,7 @@ static const TypeInfo xen_pci_passthrough_info = {
     .class_init = xen_pci_passthrough_class_init,
     .class_size = sizeof(XenPTDeviceClass),
     .instance_init = xen_pci_passthrough_instance_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { INTERFACE_PCIE_DEVICE },
         { },
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 264851ece36..2c0cec97234 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -363,7 +363,7 @@ static const TypeInfo isa_bridge_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIDevice),
     .class_init = isa_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
     },
diff --git a/net/can/can_core.c b/net/can/can_core.c
index e16e15c036e..77fe2b8ba48 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -162,7 +162,7 @@ static const TypeInfo can_bus_info = {
     .instance_size = sizeof(CanBusState),
     .instance_init = can_bus_instance_init,
     .class_init = can_bus_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/net/can/can_host.c b/net/can/can_host.c
index ca5fcf1ea12..3f9bb33e474 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -92,7 +92,7 @@ static const TypeInfo can_host_info = {
     .class_size = sizeof(CanHostClass),
     .abstract = true,
     .class_init = can_host_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7e5f6e09dba..fe39038d00e 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1478,7 +1478,7 @@ static const TypeInfo colo_compare_info = {
     .instance_finalize = colo_compare_finalize,
     .class_size = sizeof(CompareClass),
     .class_init = colo_compare_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/net/filter.c b/net/filter.c
index 03b3c793f76..c7cc6615dc9 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -363,7 +363,7 @@ static const TypeInfo netfilter_info = {
     .instance_size = sizeof(NetFilterState),
     .instance_init = netfilter_init,
     .instance_finalize = netfilter_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 1977d99ce0d..40e1210eb21 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -77,7 +77,7 @@ static const TypeInfo pr_manager_info = {
     .name = TYPE_PR_MANAGER,
     .class_size = sizeof(PRManagerClass),
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/system/qtest.c b/system/qtest.c
index 6827521e9ca..f66a517d839 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -1027,7 +1027,7 @@ static const TypeInfo qtest_info = {
     .parent = TYPE_OBJECT,
     .class_init = qtest_class_init,
     .instance_size = sizeof(QTest),
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f44cc1d2153..6e34f934df5 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2088,7 +2088,7 @@ static const TypeInfo sev_common_info = {
     .class_size = sizeof(SevCommonStateClass),
     .class_init = sev_common_class_init,
     .abstract = true,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 570b03d7bc9..97b0a56f814 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7519,7 +7519,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .class_size = sizeof(PowerPCCPUClass),
     .class_init = ppc_cpu_class_init,
 #ifndef CONFIG_USER_ONLY
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
           { TYPE_INTERRUPT_STATS_PROVIDER },
           { }
     },
diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index 4e1c4d67297..86ae5f6c3b1 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -52,7 +52,7 @@ static const TypeInfo direct_impl_info = {
     .name = TYPE_DIRECT_IMPL,
     .parent = TYPE_OBJECT,
     .class_init = test_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_TEST_IF },
         { }
     }
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 04ea5ba7115..f608bf99378 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -164,7 +164,7 @@ static const TypeInfo dummy_info = {
     .instance_finalize = dummy_finalize,
     .class_size = sizeof(DummyObjectClass),
     .class_init = dummy_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/ui/dbus.c b/ui/dbus.c
index 0c0f86eaa6f..dd0336702de 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -514,7 +514,7 @@ static const TypeInfo dbus_display_info = {
     .instance_init = dbus_display_init,
     .instance_finalize = dbus_display_finalize,
     .class_init = dbus_display_class_init,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 9dce31ea9a7..9793258aac1 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -732,7 +732,7 @@ static const TypeInfo input_barrier_info = {
     .instance_size = sizeof(InputBarrier),
     .instance_init = input_barrier_instance_init,
     .instance_finalize = input_barrier_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/ui/input-linux.c b/ui/input-linux.c
index b940198bfe2..147f0052c89 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -523,7 +523,7 @@ static const TypeInfo input_linux_info = {
     .instance_size = sizeof(InputLinux),
     .instance_init = input_linux_instance_init,
     .instance_finalize = input_linux_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/util/thread-context.c b/util/thread-context.c
index 95228a3d4f6..0146154fa56 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -319,7 +319,7 @@ static const TypeInfo thread_context_info = {
     .instance_size = sizeof(ThreadContext),
     .instance_init = thread_context_instance_init,
     .instance_finalize = thread_context_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
+    .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
         { }
     }
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index 2f0d24f7fee..b0694f4cb85 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -147,7 +147,7 @@ static void apple_gfx_pci_class_init(ObjectClass *klass, const void *data)
         .instance_size = sizeof(AppleGFXPCIState),
         .class_init    = apple_gfx_pci_class_init,
         .instance_init = apple_gfx_pci_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { },
         },
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index b007f089153..0faca41affe 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -497,7 +497,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
-        interfaces: core::ptr::null_mut(),
+        interfaces: core::ptr::null(),
     };
 
     // methods on ObjectClass
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 08857c5008d..4526268ae80 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -77,8 +77,8 @@ def fullmatch(regexp, s):
     assert fullmatch(RE_ARRAY_ITEM, '{ TYPE_HOTPLUG_HANDLER },')
     assert fullmatch(RE_ARRAY_ITEM, '{ TYPE_ACPI_DEVICE_IF },')
     assert fullmatch(RE_ARRAY_ITEM, '{ }')
-    assert fullmatch(RE_ARRAY_CAST, '(InterfaceInfo[])')
-    assert fullmatch(RE_ARRAY, '''(InterfaceInfo[]) {
+    assert fullmatch(RE_ARRAY_CAST, '(const InterfaceInfo[])')
+    assert fullmatch(RE_ARRAY, '''(const InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
             { TYPE_ACPI_DEVICE_IF },
             { }
@@ -98,7 +98,7 @@ def fullmatch(regexp, s):
         .parent = TYPE_DEVICE,
         .instance_size = sizeof(CRBState),
         .class_init  = tpm_crb_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_TPM_IF },
             { }
         }
@@ -134,7 +134,7 @@ def fullmatch(regexp, s):
         .instance_size = sizeof(AcpiGedState),
         .instance_init  = acpi_ged_initfn,
         .class_init    = acpi_ged_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
             { TYPE_ACPI_DEVICE_IF },
             { }
@@ -164,7 +164,7 @@ def fullmatch(regexp, s):
         .parent = TYPE_DEVICE,
         .instance_size = sizeof(CRBState),
         .class_init  = tpm_crb_class_init,
-        .interfaces = (InterfaceInfo[]) {
+        .interfaces = (const InterfaceInfo[]) {
             { TYPE_TPM_IF },
             { }
         }
-- 
2.47.1


