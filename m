Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075CEC88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nwl-0003Ip-Fd; Sun, 13 Sep 2026 13:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nUH-0008WL-69; Sun, 13 Sep 2026 12:55:29 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nTy-0004uM-4B; Sun, 13 Sep 2026 12:55:28 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73941601DB;
 Sun, 13 Sep 2026 16:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1332D1F000FF;
 Sun, 13 Sep 2026 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318500;
 bh=w7Z8m29xdoy30Hmw0TjiMrRadXixjoZlsPBHoFg6zNM=;
 h=From:Subject:Date:To:Cc;
 b=S6AOdxtGir73t7zs1uYADzaxgJDShv6qUEz+xTXamudBAuWL/k5Fn9QbUbek2OT35
 0yb6NKecywjvxKmMvejjD/8uXYIkKOsLvBp+16kMg6bbmEJCOXOB8g306mA1vP8YkI
 nRyJIvXAgg00NEdo2WLA+tZppKDpmvGpsClNLHTXUFRnGe47m6bZjCKhzIHq4tvf8K
 Zh01WR58Rlp3BSoCCsBENQgUmCZaITHstQKshFO36LU3YIE9nL9bEAJwzFzE9uKnZp
 5hOboIIpapXar14IrYSCca6iTdLIUMwAvUT/YZlIP/OMtPEXgMhHHKg7ZZHKU4hjId
 l/mowNs1I2NEQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 0/4] Add PCIe Endpoint emulation for the Linux PCI Endpoint
 framework
Date: Sun, 13 Sep 2026 18:54:50 +0200
Message-Id: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFrVpmoC/yXMUQqDMBCE4avIPnchRjDYq0gfNBnrllZDYkQQ7
 260jx/M/DtFBEGkZ7FTwCpR5imjfBRkx256g8Vlk1a6Vk1ZsbcChmf80rdb8pqdccpoXRuDnvL
 PBwyy3c329XdM/Qd2uUJ0HCc9SNxudQAAAA==
X-Change-ID: 20260913-pcie-ep-emulation-d7d0722677eb
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5420; i=mani@kernel.org;
 h=from:subject:message-id; bh=LSukRMTP2e8jdjYHuWL0CHWAoSi9zH6eM2BeFDsiszA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqptVfPHPcLCh4D8jNKPhYT8Z8HBvCzQPbxX0yv
 hYdmonboEyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqbVXwAKCRBVnxHm/pHO
 9ckBCACV0C+KweteyQDzGkfRfBPL2wtGE2Nc+x27PWhs3fBCxvj0TFrweCWZ02mdYNa7elgvTkq
 k11jVwarOC1VZ7CmzlpBofVMyUAp4RcdoXLj671gmkXNSrcQC8E39kcxQqiLxzl7oKBiL1d7Pu4
 WO+1EZE3wsoTzAsktjGR7v1/7N5D/V+DT9rw1zc1JhdLLjQivMqzWQEXrNLyG7Mrl3hJvPi+XEC
 ZBfLVznVkRZLU/Zwx0sz5HnOr1iMWLu50nx8S9fQ9zExpt2IYMl5pEB0qBnLExSURxHdBc/sf/T
 q9ttMqMyWseZiWOwfpzk0K6wroeDlX7oBRYPPrnWscuCxUSK
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mani@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 13:24:47 -0400
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

The Linux PCI Endpoint framework lets a Linux system act as the
peripheral side of a PCI link instead of the host. It runs on SoCs whose
PCIe controller supports Endpoint mode, with Linux running on the
Endpoint device itself. The kernel there uses the framework to set up the
PCI config space (vendor and device IDs, class), expose BARs backed by
local memory, negotiate MSI and MSI-X, map host memory, and raise
interrupts to the host. The personality the Endpoint presents is provided
by an Endpoint Function driver, for example pci-epf-test or pci-epf-nvme,
bound to an Endpoint Controller (EPC) driver through configfs. This is how
a Linux SoC can be turned into a device such as an NVMe drive or a test
function that a separate host enumerates as an ordinary PCI device.

Working on this code today requires real Endpoint-capable hardware and a
second host machine connected over a physical PCIe link. Such setups are
not widely available and are impractical for continuous integration, so
the framework, EPC drivers, and Endpoint Function drivers cannot be
exercised in a plain QEMU or CI environment.

This series closes that gap by emulating a PCIe Endpoint Controller and a
PCIe Endpoint Function in QEMU. It lets developers run the Linux Endpoint
stack, both EPC drivers and Endpoint Function drivers such as
pci-epf-test, entirely inside QEMU without real Endpoint hardware.

Two devices are added:

  - pcie-ep-ctrl (hw/misc): a SysBus platform device that emulates the
    Endpoint Controller. It exposes an MMIO register interface
    compatible with the pci-ep-generic Linux EPC driver and orchestrates
    the Endpoint Function.

  - pcie-ep-generic (hw/pci): the PCIe Endpoint Function. The controller
    builds it from the staged registers and hotplugs it onto a Root Port
    when the Endpoint driver starts the link.

Everything runs in a single QEMU instance. One guest kernel acts as both
the Endpoint Controller and the PCI host that enumerates the resulting
Function, sharing one guest address space. Outbound maps are memory
region aliases onto guest RAM and interrupts are raised directly on the
Function, so no second QEMU instance or inter-process protocol is
needed.

The controller is wired into the ARM virt machine, which emits the
device tree node the pci-ep-generic EPC driver binds to.

Testing
-------

The pci-ep-generic EPC driver that binds to this controller is not
upstream yet. The kernel used for testing includes this out-of-tree
commit:

  https://github.com/Mani-Sadhasivam/linux/commit/d23bc106b79579ddb979be6b141e71712a70acfa

Built for aarch64 and run under TCG on the virt machine with a single
guest kernel that provides both Endpoint and host support
(CONFIG_PCI_EP_GENERIC, CONFIG_PCI_EPF_TEST, CONFIG_PCI_ENDPOINT_TEST):

  qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 1G \
    -kernel Image -initrd rootfs.cpio.gz -display none -no-reboot \
    -device pcie-root-port,id=rp0,bus=pcie.0,chassis=1,slot=1,hotplug=on \
    -device pcie-ep-ctrl,target-bus=rp0 \
    -append "console=ttyAMA0"

Bring up the Function through configfs, binding pci_epf_test to the
controller, then start the link:

  cd /sys/kernel/config/pci_ep
  CTRL=$(ls controllers/ | head -n 1)
  mkdir functions/pci_epf_test/ep0
  echo 0x104c > functions/pci_epf_test/ep0/vendorid
  echo 0xb00d > functions/pci_epf_test/ep0/deviceid
  echo 1 > functions/pci_epf_test/ep0/msi_interrupts
  echo 1 > functions/pci_epf_test/ep0/msix_interrupts
  ln -s functions/pci_epf_test/ep0 controllers/$CTRL/
  echo 1 > controllers/$CTRL/start

Once /dev/pci-endpoint-test.0 appears, run the kernel selftest at
tools/testing/selftests/pci_endpoint/pci_endpoint_test. Result on this
setup:

  Totals: pass:10 fail:10 skip:3

The passing cases include all six BAR tests and the memcpy READ, WRITE
and COPY transfers, which exercise the memory-aliasing data path. The
failures are environmental: the DMA subtests need a DMA engine that TCG
does not emulate, INTx is not routed on the virt machine, and the
doorbell test is not implemented.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (4):
      docs/system/devices: Add PCIe Endpoint emulation documentation
      hw/pci: Add PCIe Endpoint Function device (pcie-ep-generic)
      hw/misc: Add PCIe Endpoint Controller emulation (pcie-ep-ctrl)
      hw/arm/virt: Add PCIe Endpoint Controller support

 MAINTAINERS                      |   9 +
 docs/system/device-emulation.rst |   1 +
 docs/system/devices/pcie-ep.rst  | 140 +++++++++
 hw/arm/Kconfig                   |   1 +
 hw/arm/virt.c                    |  57 ++++
 hw/core/sysbus-fdt.c             |   3 +
 hw/misc/Kconfig                  |   4 +
 hw/misc/meson.build              |   1 +
 hw/misc/pcie-ep-ctrl.c           | 662 +++++++++++++++++++++++++++++++++++++++
 hw/pci/Kconfig                   |   4 +
 hw/pci/meson.build               |   1 +
 hw/pci/pcie-ep-generic.c         | 255 +++++++++++++++
 include/hw/misc/pcie-ep-ctrl.h   |  68 ++++
 include/hw/pci/pcie-ep-generic.h |  71 +++++
 14 files changed, 1277 insertions(+)
---
base-commit: 193963218accbcf65f28ab1efa773ac6d1cc634c
change-id: 20260913-pcie-ep-emulation-d7d0722677eb

Best regards,
--  
மணிவண்ணன் சதாசிவம்


