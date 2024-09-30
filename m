Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CCACEB2CA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOjm-0005Ky-Sv; Mon, 30 Sep 2024 18:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOji-00056g-TV
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOjf-0003P6-RC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d446adf6eso839472666b.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734758; x=1728339558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tv2jZnZjCbdt84MPax+EcsJ9zOY57sXyrwaIyw3HRws=;
 b=tvTwCNsMasqGfGqFhrzQo1XfGN9cUgxadrr7E9/AIM3wqog6fXjWVMEGCi8RuZogDD
 Us8NgG78LWA1+2BAwWUXnsCNX3R3fR5nTuMCgJ5yJgU499CIRKoS27p8lXKxitN2tjpu
 k7Mf3VskVGSGOsiuw/+GldRiws9soujGE2YJPaflTRyvu+MQQQp5gZ0AIWU7UndyFE3L
 ewVXIl771KIv4Bf8SyazXISTPCNj/x6NHxVdDem9P6KDV9v4pkpQtHdV+g50kz4Iw7M5
 ij3wIFi0xh7sq3HTijidMAVCWCZlDw3PT+yoH+6/5f0ur7nvWh4pStwvINVXihqdCyr3
 86hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734758; x=1728339558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tv2jZnZjCbdt84MPax+EcsJ9zOY57sXyrwaIyw3HRws=;
 b=iWJ6Rf85EkfNzuzQB/SqSLew/GoyVn4aXLpQW9DuieEEuleE9L+M0HLA826cDVjsXf
 zx28uddbPrluByBgMXkALwINsG+1RZNDtp0ahq3zIs+mLXxGsLh63xkN67qXIrPXLh6N
 DirE6QuULujr/Z5T+IUmzMuL4dpKaHgiRK0hHezOdEusVyQr18lJ4m0d2+/aSAq7NhC6
 czkRFfPIp/FyBMGURKvOriLRSAv/Gkb4nbN/qp0Y3HG3Csaxq1uEl/X+IfIg4NzQDQLr
 G65w2iNwuo8JsBe4dIoGQw1gASMEsDjwIYpJvjmSoiyVKUKSkLgIPKYHv2Ku7jCyoBXt
 TtYg==
X-Gm-Message-State: AOJu0YziE5mQP/vOegRlPO0YZ2eql2cAQsczzJHF02+IBirXupoeGb+v
 kZXfZnniw5QD3yVVGoqX7pGbDICRbZylnSvhXcG/iEPUzKsITbm0ScdGCXDsnh/7Ga7M7KNViLs
 KTSQ=
X-Google-Smtp-Source: AGHT+IFgptAQHamlNG5ZjPg1lh4Ew1icU7YGlSdzipE6lGBbFDYm+R2avO0pq5boi4/4K9G5+sUfNw==
X-Received: by 2002:a17:906:4788:b0:a86:789f:c756 with SMTP id
 a640c23a62f3a-a93c4aa461cmr1512175266b.53.1727734757719; 
 Mon, 30 Sep 2024 15:19:17 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2947e3esm593668566b.111.2024.09.30.15.19.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:19:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 2/2] hw/core/machine: Extract compat properties to
 machine-compat.c
Date: Tue,  1 Oct 2024 00:19:00 +0200
Message-ID: <20240930221900.59525-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930221900.59525-1-philmd@linaro.org>
References: <20240930221900.59525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Extract machine compat properties to machine-compat.c.
Add the unit to the meson specific_ss[] source set so
we can use target specific (poisoned) definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS              |   1 +
 hw/core/machine-compat.c | 287 +++++++++++++++++++++++++++++++++++++++
 hw/core/machine.c        | 277 -------------------------------------
 hw/core/meson.build      |   3 +
 4 files changed, 291 insertions(+), 277 deletions(-)
 create mode 100644 hw/core/machine-compat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 62f5255f40..b89e2dae9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1886,6 +1886,7 @@ F: hw/core/cpu-common.c
 F: hw/core/cpu-sysemu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
+F: hw/core/machine-compat.c
 F: hw/core/machine-smp.c
 F: hw/core/null-machine.c
 F: hw/core/numa.c
diff --git a/hw/core/machine-compat.c b/hw/core/machine-compat.c
new file mode 100644
index 0000000000..6bed588ec1
--- /dev/null
+++ b/hw/core/machine-compat.c
@@ -0,0 +1,287 @@
+/*
+ * QEMU Machine compatibility properties
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-iommu.h"
+
+GlobalProperty hw_compat_9_1[] = {
+};
+const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
+
+GlobalProperty hw_compat_9_0[] = {
+    { "arm-cpu", "backcompat-cntfrq", "true" },
+    { "scsi-hd", "migrate-emulated-scsi-request", "false" },
+    { "scsi-cd", "migrate-emulated-scsi-request", "false" },
+    { "vfio-pci", "skip-vsc-check", "false" },
+    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
+    { "sd-card", "spec_version", "2" },
+};
+const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
+
+GlobalProperty hw_compat_8_2[] = {
+    { "migration", "zero-page-detection", "legacy"},
+    { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
+    { "virtio-gpu-device", "x-scanout-vmstate-version", "1" },
+};
+const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
+
+GlobalProperty hw_compat_8_1[] = {
+    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
+    { "ramfb", "x-migrate", "off" },
+    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
+    { "igb", "x-pcie-flr-init", "off" },
+    { TYPE_VIRTIO_NET, "host_uso", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
+    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
+};
+const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
+
+GlobalProperty hw_compat_8_0[] = {
+    { "migration", "multifd-flush-after-each-section", "on"},
+    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
+};
+const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
+
+GlobalProperty hw_compat_7_2[] = {
+    { "e1000e", "migrate-timadj", "off" },
+    { "virtio-mem", "x-early-migration", "false" },
+    { "migration", "x-preempt-pre-7-2", "true" },
+    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
+};
+const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
+
+GlobalProperty hw_compat_7_1[] = {
+    { "virtio-device", "queue_reset", "false" },
+    { "virtio-rng-pci", "vectors", "0" },
+    { "virtio-rng-pci-transitional", "vectors", "0" },
+    { "virtio-rng-pci-non-transitional", "vectors", "0" },
+};
+const size_t hw_compat_7_1_len = G_N_ELEMENTS(hw_compat_7_1);
+
+GlobalProperty hw_compat_7_0[] = {
+    { "arm-gicv3-common", "force-8-bit-prio", "on" },
+    { "nvme-ns", "eui64-default", "on"},
+};
+const size_t hw_compat_7_0_len = G_N_ELEMENTS(hw_compat_7_0);
+
+GlobalProperty hw_compat_6_2[] = {
+    { "PIIX4_PM", "x-not-migrate-acpi-index", "on"},
+};
+const size_t hw_compat_6_2_len = G_N_ELEMENTS(hw_compat_6_2);
+
+GlobalProperty hw_compat_6_1[] = {
+    { "vhost-user-vsock-device", "seqpacket", "off" },
+    { "nvme-ns", "shared", "off" },
+};
+const size_t hw_compat_6_1_len = G_N_ELEMENTS(hw_compat_6_1);
+
+GlobalProperty hw_compat_6_0[] = {
+    { "gpex-pcihost", "allow-unmapped-accesses", "false" },
+    { "i8042", "extended-state", "false"},
+    { "nvme-ns", "eui64-default", "off"},
+    { "e1000", "init-vet", "off" },
+    { "e1000e", "init-vet", "off" },
+    { "vhost-vsock-device", "seqpacket", "off" },
+};
+const size_t hw_compat_6_0_len = G_N_ELEMENTS(hw_compat_6_0);
+
+GlobalProperty hw_compat_5_2[] = {
+    { "ICH9-LPC", "smm-compat", "on"},
+    { "PIIX4_PM", "smm-compat", "on"},
+    { "virtio-blk-device", "report-discard-granularity", "off" },
+    { "virtio-net-pci-base", "vectors", "3"},
+    { "nvme", "msix-exclusive-bar", "on"},
+};
+const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
+
+GlobalProperty hw_compat_5_1[] = {
+    { "vhost-scsi", "num_queues", "1"},
+    { "vhost-user-blk", "num-queues", "1"},
+    { "vhost-user-scsi", "num_queues", "1"},
+    { "virtio-blk-device", "num-queues", "1"},
+    { "virtio-scsi-device", "num_queues", "1"},
+    { "nvme", "use-intel-id", "on"},
+    { "pvpanic", "events", "1"}, /* PVPANIC_PANICKED */
+    { "pl011", "migrate-clk", "off" },
+    { "virtio-pci", "x-ats-page-aligned", "off"},
+};
+const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
+
+GlobalProperty hw_compat_5_0[] = {
+    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
+    { "virtio-balloon-device", "page-poison", "false" },
+    { "vmport", "x-read-set-eax", "off" },
+    { "vmport", "x-signal-unsupported-cmd", "off" },
+    { "vmport", "x-report-vmx-type", "off" },
+    { "vmport", "x-cmds-v2", "off" },
+    { "virtio-device", "x-disable-legacy-check", "true" },
+};
+const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
+
+GlobalProperty hw_compat_4_2[] = {
+    { "virtio-blk-device", "queue-size", "128"},
+    { "virtio-scsi-device", "virtqueue_size", "128"},
+    { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
+    { "virtio-blk-device", "seg-max-adjust", "off"},
+    { "virtio-scsi-device", "seg_max_adjust", "off"},
+    { "vhost-blk-device", "seg_max_adjust", "off"},
+    { "usb-host", "suppress-remote-wake", "off" },
+    { "usb-redir", "suppress-remote-wake", "off" },
+    { "qxl", "revision", "4" },
+    { "qxl-vga", "revision", "4" },
+    { "fw_cfg", "acpi-mr-restore", "false" },
+    { "virtio-device", "use-disabled-flag", "false" },
+};
+const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
+
+GlobalProperty hw_compat_4_1[] = {
+    { "virtio-pci", "x-pcie-flr-init", "off" },
+};
+const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
+
+GlobalProperty hw_compat_4_0[] = {
+    { "VGA",            "edid", "false" },
+    { "secondary-vga",  "edid", "false" },
+    { "bochs-display",  "edid", "false" },
+    { "virtio-vga",     "edid", "false" },
+    { "virtio-gpu-device", "edid", "false" },
+    { "virtio-device", "use-started", "false" },
+    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
+    { "pl031", "migrate-tick-offset", "false" },
+};
+const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
+
+GlobalProperty hw_compat_3_1[] = {
+    { "pcie-root-port", "x-speed", "2_5" },
+    { "pcie-root-port", "x-width", "1" },
+    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
+    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
+    { "tpm-crb", "ppi", "false" },
+    { "tpm-tis", "ppi", "false" },
+    { "usb-kbd", "serial", "42" },
+    { "usb-mouse", "serial", "42" },
+    { "usb-tablet", "serial", "42" },
+    { "virtio-blk-device", "discard", "false" },
+    { "virtio-blk-device", "write-zeroes", "false" },
+    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
+    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
+};
+const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
+
+GlobalProperty hw_compat_3_0[] = {};
+const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
+
+GlobalProperty hw_compat_2_12[] = {
+    { "hda-audio", "use-timer", "false" },
+    { "cirrus-vga", "global-vmstate", "true" },
+    { "VGA", "global-vmstate", "true" },
+    { "vmware-svga", "global-vmstate", "true" },
+    { "qxl-vga", "global-vmstate", "true" },
+};
+const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
+
+GlobalProperty hw_compat_2_11[] = {
+    { "hpet", "hpet-offset-saved", "false" },
+    { "virtio-blk-pci", "vectors", "2" },
+    { "vhost-user-blk-pci", "vectors", "2" },
+    { "e1000", "migrate_tso_props", "off" },
+};
+const size_t hw_compat_2_11_len = G_N_ELEMENTS(hw_compat_2_11);
+
+GlobalProperty hw_compat_2_10[] = {
+    { "virtio-mouse-device", "wheel-axis", "false" },
+    { "virtio-tablet-device", "wheel-axis", "false" },
+};
+const size_t hw_compat_2_10_len = G_N_ELEMENTS(hw_compat_2_10);
+
+GlobalProperty hw_compat_2_9[] = {
+    { "pci-bridge", "shpc", "off" },
+    { "intel-iommu", "pt", "off" },
+    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
+    { "pcie-root-port", "x-migrate-msix", "false" },
+};
+const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
+
+GlobalProperty hw_compat_2_8[] = {
+    { "fw_cfg_mem", "x-file-slots", "0x10" },
+    { "fw_cfg_io", "x-file-slots", "0x10" },
+    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
+    { "pci-bridge", "shpc", "on" },
+    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
+    { "virtio-pci", "x-pcie-deverr-init", "off" },
+    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
+    { "virtio-pci", "x-pcie-pm-init", "off" },
+    { "cirrus-vga", "vgamem_mb", "8" },
+    { "isa-cirrus-vga", "vgamem_mb", "8" },
+};
+const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
+
+GlobalProperty hw_compat_2_7[] = {
+    { "virtio-pci", "page-per-vq", "on" },
+    { "virtio-serial-device", "emergency-write", "off" },
+    { "ioapic", "version", "0x11" },
+    { "intel-iommu", "x-buggy-eim", "true" },
+    { "virtio-pci", "x-ignore-backend-features", "on" },
+};
+const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
+
+GlobalProperty hw_compat_2_6[] = {
+    { "virtio-mmio", "format_transport_address", "off" },
+    /* Optional because not all virtio-pci devices support legacy mode */
+    { "virtio-pci", "disable-modern", "on",  .optional = true },
+    { "virtio-pci", "disable-legacy", "off", .optional = true },
+};
+const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
+
+GlobalProperty hw_compat_2_5[] = {
+    { "isa-fdc", "fallback", "144" },
+    { "pvscsi", "x-old-pci-configuration", "on" },
+    { "pvscsi", "x-disable-pcie", "on" },
+    { "vmxnet3", "x-old-msi-offsets", "on" },
+    { "vmxnet3", "x-disable-pcie", "on" },
+};
+const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
+
+GlobalProperty hw_compat_2_4[] = {
+    { "e1000", "extra_mac_registers", "off" },
+    { "virtio-pci", "x-disable-pcie", "on" },
+    { "virtio-pci", "migrate-extra", "off" },
+    { "fw_cfg_mem", "dma_enabled", "off" },
+    { "fw_cfg_io", "dma_enabled", "off" }
+};
+const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
+
+GlobalProperty hw_compat_2_3[] = {
+    { "virtio-blk-pci", "any_layout", "off" },
+    { "virtio-balloon-pci", "any_layout", "off" },
+    { "virtio-serial-pci", "any_layout", "off" },
+    { "virtio-9p-pci", "any_layout", "off" },
+    { "virtio-rng-pci", "any_layout", "off" },
+    { TYPE_PCI_DEVICE, "x-pcie-lnksta-dllla", "off" },
+    { "migration", "send-configuration", "off" },
+    { "migration", "send-section-footer", "off" },
+    { "migration", "store-global-state", "off" },
+};
+const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
+
+GlobalProperty hw_compat_2_2[] = {};
+const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
+
+GlobalProperty hw_compat_2_1[] = {
+    { "intel-hda", "old_msi_addr", "on" },
+    { "VGA", "qemu-extended-regs", "off" },
+    { "secondary-vga", "qemu-extended-regs", "off" },
+    { "virtio-scsi-pci", "any_layout", "off" },
+    { "usb-mouse", "usb_version", "1" },
+    { "usb-kbd", "usb_version", "1" },
+    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
+};
+const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 94d3b11a53..31463cc8ec 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,289 +27,12 @@
 #include "sysemu/runstate.h"
 #include "sysemu/xen.h"
 #include "sysemu/qtest.h"
-#include "hw/pci/pci_bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/virtio/virtio-pci.h"
-#include "hw/virtio/virtio-net.h"
-#include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_9_1[] = {};
-const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
-
-GlobalProperty hw_compat_9_0[] = {
-    {"arm-cpu", "backcompat-cntfrq", "true" },
-    { "scsi-hd", "migrate-emulated-scsi-request", "false" },
-    { "scsi-cd", "migrate-emulated-scsi-request", "false" },
-    {"vfio-pci", "skip-vsc-check", "false" },
-    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
-    {"sd-card", "spec_version", "2" },
-};
-const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
-
-GlobalProperty hw_compat_8_2[] = {
-    { "migration", "zero-page-detection", "legacy"},
-    { TYPE_VIRTIO_IOMMU_PCI, "granule", "4k" },
-    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
-    { "virtio-gpu-device", "x-scanout-vmstate-version", "1" },
-};
-const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
-
-GlobalProperty hw_compat_8_1[] = {
-    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
-    { "ramfb", "x-migrate", "off" },
-    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
-    { "igb", "x-pcie-flr-init", "off" },
-    { TYPE_VIRTIO_NET, "host_uso", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso4", "off"},
-    { TYPE_VIRTIO_NET, "guest_uso6", "off"},
-};
-const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
-
-GlobalProperty hw_compat_8_0[] = {
-    { "migration", "multifd-flush-after-each-section", "on"},
-    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
-};
-const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
-
-GlobalProperty hw_compat_7_2[] = {
-    { "e1000e", "migrate-timadj", "off" },
-    { "virtio-mem", "x-early-migration", "false" },
-    { "migration", "x-preempt-pre-7-2", "true" },
-    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
-};
-const size_t hw_compat_7_2_len = G_N_ELEMENTS(hw_compat_7_2);
-
-GlobalProperty hw_compat_7_1[] = {
-    { "virtio-device", "queue_reset", "false" },
-    { "virtio-rng-pci", "vectors", "0" },
-    { "virtio-rng-pci-transitional", "vectors", "0" },
-    { "virtio-rng-pci-non-transitional", "vectors", "0" },
-};
-const size_t hw_compat_7_1_len = G_N_ELEMENTS(hw_compat_7_1);
-
-GlobalProperty hw_compat_7_0[] = {
-    { "arm-gicv3-common", "force-8-bit-prio", "on" },
-    { "nvme-ns", "eui64-default", "on"},
-};
-const size_t hw_compat_7_0_len = G_N_ELEMENTS(hw_compat_7_0);
-
-GlobalProperty hw_compat_6_2[] = {
-    { "PIIX4_PM", "x-not-migrate-acpi-index", "on"},
-};
-const size_t hw_compat_6_2_len = G_N_ELEMENTS(hw_compat_6_2);
-
-GlobalProperty hw_compat_6_1[] = {
-    { "vhost-user-vsock-device", "seqpacket", "off" },
-    { "nvme-ns", "shared", "off" },
-};
-const size_t hw_compat_6_1_len = G_N_ELEMENTS(hw_compat_6_1);
-
-GlobalProperty hw_compat_6_0[] = {
-    { "gpex-pcihost", "allow-unmapped-accesses", "false" },
-    { "i8042", "extended-state", "false"},
-    { "nvme-ns", "eui64-default", "off"},
-    { "e1000", "init-vet", "off" },
-    { "e1000e", "init-vet", "off" },
-    { "vhost-vsock-device", "seqpacket", "off" },
-};
-const size_t hw_compat_6_0_len = G_N_ELEMENTS(hw_compat_6_0);
-
-GlobalProperty hw_compat_5_2[] = {
-    { "ICH9-LPC", "smm-compat", "on"},
-    { "PIIX4_PM", "smm-compat", "on"},
-    { "virtio-blk-device", "report-discard-granularity", "off" },
-    { "virtio-net-pci-base", "vectors", "3"},
-    { "nvme", "msix-exclusive-bar", "on"},
-};
-const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
-
-GlobalProperty hw_compat_5_1[] = {
-    { "vhost-scsi", "num_queues", "1"},
-    { "vhost-user-blk", "num-queues", "1"},
-    { "vhost-user-scsi", "num_queues", "1"},
-    { "virtio-blk-device", "num-queues", "1"},
-    { "virtio-scsi-device", "num_queues", "1"},
-    { "nvme", "use-intel-id", "on"},
-    { "pvpanic", "events", "1"}, /* PVPANIC_PANICKED */
-    { "pl011", "migrate-clk", "off" },
-    { "virtio-pci", "x-ats-page-aligned", "off"},
-};
-const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
-
-GlobalProperty hw_compat_5_0[] = {
-    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
-    { "virtio-balloon-device", "page-poison", "false" },
-    { "vmport", "x-read-set-eax", "off" },
-    { "vmport", "x-signal-unsupported-cmd", "off" },
-    { "vmport", "x-report-vmx-type", "off" },
-    { "vmport", "x-cmds-v2", "off" },
-    { "virtio-device", "x-disable-legacy-check", "true" },
-};
-const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
-
-GlobalProperty hw_compat_4_2[] = {
-    { "virtio-blk-device", "queue-size", "128"},
-    { "virtio-scsi-device", "virtqueue_size", "128"},
-    { "virtio-blk-device", "x-enable-wce-if-config-wce", "off" },
-    { "virtio-blk-device", "seg-max-adjust", "off"},
-    { "virtio-scsi-device", "seg_max_adjust", "off"},
-    { "vhost-blk-device", "seg_max_adjust", "off"},
-    { "usb-host", "suppress-remote-wake", "off" },
-    { "usb-redir", "suppress-remote-wake", "off" },
-    { "qxl", "revision", "4" },
-    { "qxl-vga", "revision", "4" },
-    { "fw_cfg", "acpi-mr-restore", "false" },
-    { "virtio-device", "use-disabled-flag", "false" },
-};
-const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
-
-GlobalProperty hw_compat_4_1[] = {
-    { "virtio-pci", "x-pcie-flr-init", "off" },
-};
-const size_t hw_compat_4_1_len = G_N_ELEMENTS(hw_compat_4_1);
-
-GlobalProperty hw_compat_4_0[] = {
-    { "VGA",            "edid", "false" },
-    { "secondary-vga",  "edid", "false" },
-    { "bochs-display",  "edid", "false" },
-    { "virtio-vga",     "edid", "false" },
-    { "virtio-gpu-device", "edid", "false" },
-    { "virtio-device", "use-started", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "true" },
-    { "pl031", "migrate-tick-offset", "false" },
-};
-const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
-
-GlobalProperty hw_compat_3_1[] = {
-    { "pcie-root-port", "x-speed", "2_5" },
-    { "pcie-root-port", "x-width", "1" },
-    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
-    { "tpm-crb", "ppi", "false" },
-    { "tpm-tis", "ppi", "false" },
-    { "usb-kbd", "serial", "42" },
-    { "usb-mouse", "serial", "42" },
-    { "usb-tablet", "serial", "42" },
-    { "virtio-blk-device", "discard", "false" },
-    { "virtio-blk-device", "write-zeroes", "false" },
-    { "virtio-balloon-device", "qemu-4-0-config-size", "false" },
-    { "pcie-root-port-base", "disable-acs", "true" }, /* Added in 4.1 */
-};
-const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
-
-GlobalProperty hw_compat_3_0[] = {};
-const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
-
-GlobalProperty hw_compat_2_12[] = {
-    { "hda-audio", "use-timer", "false" },
-    { "cirrus-vga", "global-vmstate", "true" },
-    { "VGA", "global-vmstate", "true" },
-    { "vmware-svga", "global-vmstate", "true" },
-    { "qxl-vga", "global-vmstate", "true" },
-};
-const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
-
-GlobalProperty hw_compat_2_11[] = {
-    { "hpet", "hpet-offset-saved", "false" },
-    { "virtio-blk-pci", "vectors", "2" },
-    { "vhost-user-blk-pci", "vectors", "2" },
-    { "e1000", "migrate_tso_props", "off" },
-};
-const size_t hw_compat_2_11_len = G_N_ELEMENTS(hw_compat_2_11);
-
-GlobalProperty hw_compat_2_10[] = {
-    { "virtio-mouse-device", "wheel-axis", "false" },
-    { "virtio-tablet-device", "wheel-axis", "false" },
-};
-const size_t hw_compat_2_10_len = G_N_ELEMENTS(hw_compat_2_10);
-
-GlobalProperty hw_compat_2_9[] = {
-    { "pci-bridge", "shpc", "off" },
-    { "intel-iommu", "pt", "off" },
-    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
-    { "pcie-root-port", "x-migrate-msix", "false" },
-};
-const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
-
-GlobalProperty hw_compat_2_8[] = {
-    { "fw_cfg_mem", "x-file-slots", "0x10" },
-    { "fw_cfg_io", "x-file-slots", "0x10" },
-    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
-    { "pci-bridge", "shpc", "on" },
-    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
-    { "virtio-pci", "x-pcie-deverr-init", "off" },
-    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
-    { "virtio-pci", "x-pcie-pm-init", "off" },
-    { "cirrus-vga", "vgamem_mb", "8" },
-    { "isa-cirrus-vga", "vgamem_mb", "8" },
-};
-const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
-
-GlobalProperty hw_compat_2_7[] = {
-    { "virtio-pci", "page-per-vq", "on" },
-    { "virtio-serial-device", "emergency-write", "off" },
-    { "ioapic", "version", "0x11" },
-    { "intel-iommu", "x-buggy-eim", "true" },
-    { "virtio-pci", "x-ignore-backend-features", "on" },
-};
-const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
-
-GlobalProperty hw_compat_2_6[] = {
-    { "virtio-mmio", "format_transport_address", "off" },
-    /* Optional because not all virtio-pci devices support legacy mode */
-    { "virtio-pci", "disable-modern", "on",  .optional = true },
-    { "virtio-pci", "disable-legacy", "off", .optional = true },
-};
-const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
-
-GlobalProperty hw_compat_2_5[] = {
-    { "isa-fdc", "fallback", "144" },
-    { "pvscsi", "x-old-pci-configuration", "on" },
-    { "pvscsi", "x-disable-pcie", "on" },
-    { "vmxnet3", "x-old-msi-offsets", "on" },
-    { "vmxnet3", "x-disable-pcie", "on" },
-};
-const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
-
-GlobalProperty hw_compat_2_4[] = {
-    { "e1000", "extra_mac_registers", "off" },
-    { "virtio-pci", "x-disable-pcie", "on" },
-    { "virtio-pci", "migrate-extra", "off" },
-    { "fw_cfg_mem", "dma_enabled", "off" },
-    { "fw_cfg_io", "dma_enabled", "off" }
-};
-const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
-
-GlobalProperty hw_compat_2_3[] = {
-    { "virtio-blk-pci", "any_layout", "off" },
-    { "virtio-balloon-pci", "any_layout", "off" },
-    { "virtio-serial-pci", "any_layout", "off" },
-    { "virtio-9p-pci", "any_layout", "off" },
-    { "virtio-rng-pci", "any_layout", "off" },
-    { TYPE_PCI_DEVICE, "x-pcie-lnksta-dllla", "off" },
-    { "migration", "send-configuration", "off" },
-    { "migration", "send-section-footer", "off" },
-    { "migration", "store-global-state", "off" },
-};
-const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
-
-GlobalProperty hw_compat_2_2[] = {};
-const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
-
-GlobalProperty hw_compat_2_1[] = {
-    { "intel-hda", "old_msi_addr", "on" },
-    { "VGA", "qemu-extended-regs", "off" },
-    { "secondary-vga", "qemu-extended-regs", "off" },
-    { "virtio-scsi-pci", "any_layout", "off" },
-    { "usb-mouse", "usb_version", "1" },
-    { "usb-kbd", "usb_version", "1" },
-    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
-};
-const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
diff --git a/hw/core/meson.build b/hw/core/meson.build
index a3d9bab9f4..1087f4bfad 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -45,3 +45,6 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
+specific_ss.add(files(
+  'machine-compat.c',
+))
-- 
2.45.2


