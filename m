Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F494C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nwr-0003J3-8J; Sun, 13 Sep 2026 13:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nUM-00009H-2Z; Sun, 13 Sep 2026 12:55:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nU0-0005Av-LM; Sun, 13 Sep 2026 12:55:33 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 647DB60E85;
 Sun, 13 Sep 2026 16:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034D81F000FF;
 Sun, 13 Sep 2026 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318511;
 bh=t3eABMYx10xOCPmuL2/oN9NpnfYFZjUwGHohBGog74I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eizgEX5g+LzHDzxDI0ZYEurk8CmMC5Xc/oZdKCk8us7oZqvu5Lb1dlqkiIUa9gudg
 em8avjIi6H7cNCemJR19aQoX1WEw4wS/ZDEco9Rp5l26WdJrKJnG4Hi2/W6skdNoLC
 X9P0+Txz5q2OyKMpwNA1Ny0n++z4YVtEfPObKHUjxfNFW8Bmaqfhg8q0i6CquICgt2
 wV/8zQEyx2/fZixGnICgKXeIT2NZ1PcOoU61m+oVx/DEyqSXOqkJPv4wX+eyGTJpQy
 k3HK4Y3pR7EmeJuEMq4xw9qhWNhsoEExDssmTTxZogNzEnsHZH27rkcXyAgYlLb7b1
 6E+D76EJ42y2Q==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Sun, 13 Sep 2026 18:54:54 +0200
Subject: [PATCH 4/4] hw/arm/virt: Add PCIe Endpoint Controller support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pcie-ep-emulation-v1-4-b8e8f74a5842@kernel.org>
References: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
In-Reply-To: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6182; i=mani@kernel.org;
 h=from:subject:message-id; bh=4wOqO45KFOwtM58aoP89+yBny+rNvXOMQO9Jja7LR44=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqptVhKHyh+8Nty6VEkecocuTJaI/LzjuYreeK2
 YuMQxx0vTiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqbVYQAKCRBVnxHm/pHO
 9aclB/sFfVrcq0V4YoyqGcZTA/YSLMaPX+M7FuZLmaZHNls7FA3Iod7qhENeZzqaPWi+Uz8HTsa
 ErgNVquWZoxwMhv67NYq21QPyvbcol+JR9YZ+PxhuD/TcIU460k0y5COCiYsKgGFJtl/G3uCoUV
 7fZIxbqZrmRae/DAMJ+pfPjGo8Dq0QVFQkHD8UymqjYIiKgg4lxwJeT4X8097Z7V/JbyYYV8uh2
 nmRXH87sEfo0XhW38vQHob3mhLeMhjPuySQeqhZ5sgPrGW5n+wx0UOk2LtkshUfTyFmU66kEXil
 tzHpxU38E2E4MF2LJ0rU3kI/oqYhRBL+nQAHW0NbvNt2HHTF
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
Received-SPF: pass client-ip=172.105.4.254; envelope-from=mani@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 13:24:48 -0400
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Wire the pcie-ep-ctrl controller into the ARM virt machine as a dynamic
sysbus device on the platform bus.

  -device pcie-ep-ctrl,target-bus=ID

The platform bus assigns the MMIO windows, so the machine emits the
device tree node (compatible "pci-ep-generic") with the resolved
addresses. The node is also marked dma-coherent. This allows the
Endpoint Controller driver to allocate coherent DMA memory from system
RAM for the Endpoint Function BARs.

Allow the device on the platform bus with
machine_class_allow_dynamic_sysbus_dev(). Also register a no_fdt_node
binding in hw/core/sysbus-fdt.c so the generic platform bus code leaves
the node to the machine.

The target-bus property names the PCIe Root Port the Endpoint Function
is hotplugged onto when the Link comes up.

A single guest kernel then drives the controller through the
pci-ep-generic EPC driver. In the same kernel, it enumerates the
resulting Function as a PCI host. This allows running Linux EPF drivers
such as pci-epf-test against the matching host driver without a second
QEMU instance.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 hw/arm/Kconfig       |  1 +
 hw/arm/virt.c        | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus-fdt.c |  3 +++
 3 files changed, 61 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fb798ccbee..0c8266d403 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -36,6 +36,7 @@ config ARM_VIRT
     select VIRTIO_MEM_SUPPORTED
     select ACPI_CXL
     select ACPI_HMAT
+    select PCIE_EP_CTRL
 
 config CUBIEBOARD
     bool
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893..25091d2639 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,6 +94,7 @@
 #include "hw/core/cpu.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
+#include "hw/misc/pcie-ep-ctrl.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
@@ -1569,6 +1570,57 @@ static void create_rtc(const VirtMachineState *vms)
     g_free(nodename);
 }
 
+/*
+ * Emit the device tree node for a pcie-ep-ctrl instantiated on the platform
+ * bus and hand the device the absolute addresses the bus assigned to its
+ * regions. Called from the plug handler once platform_bus_link_device() has
+ * placed the MMIO regions, mirroring how the SMMUv3 device builds its own
+ * node in create_smmuv3_dev_dtb().
+ */
+static void create_pcie_ep_ctrl_dtb(VirtMachineState *vms, DeviceState *dev)
+{
+    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
+    PCIeEPCtrlState *ec = PCIE_EP_CTRL(dev);
+    MachineState *ms = MACHINE(vms);
+    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
+    hwaddr ctrl_base, ob_base;
+    hwaddr ctrl_size, ob_size;
+    char *nodename;
+    static const char compat[] = "pci-ep-generic";
+    static const char reg_names[] = "ctrl\0outbound";
+
+    /* Absolute base of each region as the platform bus mapped it. */
+    ctrl_base = pbus_base + platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    ob_base = pbus_base + platform_bus_get_mmio_addr(pbus, sbdev, 1);
+
+    ctrl_size = memory_region_size(sysbus_mmio_get_region(sbdev, 0));
+    ob_size = memory_region_size(sysbus_mmio_get_region(sbdev, 1));
+
+    /*
+     * The EP guest programs outbound window addresses using these absolute CPU
+     * addresses, so the device must know where the platform bus placed the
+     * region to translate them back into window offsets.
+     */
+    ec->ob_base = ob_base;
+
+    nodename = g_strdup_printf("/pcie-ep@%" PRIx64, ctrl_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible",
+                     compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
+                                 2, ctrl_base, 2, ctrl_size,
+                                 2, ob_base, 2, ob_size);
+    qemu_fdt_setprop(ms->fdt, nodename, "reg-names",
+                     reg_names, sizeof(reg_names));
+    /*
+     * Mark the controller DMA-coherent so the EPC driver's dma_alloc_coherent
+     * returns cacheable coherent RAM for the Endpoint BAR backing buffers.
+     */
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
+    g_free(nodename);
+}
+
 static DeviceState *gpio_key_dev;
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
@@ -3843,6 +3895,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         if (device_is_dynamic_sysbus(mc, dev)) {
             platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
                                      SYS_BUS_DEVICE(dev));
+
+            if (object_dynamic_cast(OBJECT(dev), TYPE_PCIE_EP_CTRL)) {
+                create_pcie_ep_ctrl_dtb(vms, dev);
+            }
         }
     }
 
@@ -4091,6 +4147,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PCIE_EP_CTRL);
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 89d0c46445..60586cc9b2 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -36,6 +36,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
+#include "hw/misc/pcie-ep-ctrl.h"
 
 /*
  * internal struct that contains the information to create dynamic
@@ -140,6 +141,8 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
+    /* Node emitted by the arm virt machine (create_pcie_ep_ctrl_dtb) */
+    TYPE_BINDING(TYPE_PCIE_EP_CTRL, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
 

-- 
2.43.0


