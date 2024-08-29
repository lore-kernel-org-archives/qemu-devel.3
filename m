Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDE4C83F16
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhqp-0007b9-U8; Thu, 29 Aug 2024 12:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sjhqo-0007aW-EO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sjhql-0005Sk-Pl
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 12:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724948293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AB18IbeTHuMkckQC8w0r36xGGkZnJ2IzRlzWo5wZPww=;
 b=MNgQDW6fZvEVeSlf6ScKN+GAjiYd9vs8sXbVYRwgWvGKMK5ub7aHj107XaOxsTA0KQTkC5
 X+LFgFyQjf6cTxIJKm0nGkhzC5MuLs05fE0HY6PBlGzHxF3ovzhwD3neFwdfOTiXImS9uI
 RHrFLf7pTqXGB8yaNMotJQUO+/3cjSk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-fsm-3j8nNpSou7faArnA-w-1; Thu,
 29 Aug 2024 12:18:09 -0400
X-MC-Unique: fsm-3j8nNpSou7faArnA-w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9639D1955D47; Thu, 29 Aug 2024 16:18:07 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.81])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 358721956056; Thu, 29 Aug 2024 16:18:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org,
 treding@nvidia.com, vbhadram@nvidia.com, jonathanh@nvidia.com,
 mperttunen@nvidia.com, alex.williamson@redhat.com, clg@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH] sysbus-fdt: DT node generation for tegra234-mgbe assigned
 device
Date: Thu, 29 Aug 2024 18:17:58 +0200
Message-ID: <20240829161759.608256-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Implement the code generating the guest device tree node for a tegra234
Multi-Gigabit Ethernet (MGBE) controller assigned device (physical
function).

The tricky part is the reset properties. For the device to be
probed on guest side, mac and pcs resets are requested. As opposed
to the clocks we cannot add a phandle to dummy nodes. We need to
instantiate a reset controller. The most simple solution that I found
is to use the hisilicon system reser controller (hisilicon,hi3660-reset)
which has a link to a syscon provider (means ARCH_HISI,
COMMON_RESET_HI3660,CONFIG_MFD_SYSCON must be set on guest side).

Obviously I tried to use the NVidia bpmp (nvidia,tegra186-bpmp.txt)
but its dependency on a mailbox requesting proper emulation make
things too complicated.

With those generated dt nodes I can run the guest unmodified and the
interface is functional on guest.

Test procedure:
sudo modprobe -v vfio_iommu_type1 allow_unsafe_interrupts=1
sudo modprobe -v vfio-platform
dev=6810000.ethernet
echo vfio-platform | sudo tee -a /sys/bus/platform/devices/$dev/driver_override
echo $dev | sudo tee -a /sys/bus/platform/devices/$dev/driver/unbind
echo $dev | sudo tee -a /sys/bus/platform/drivers_probe
in qemu command line pass: -device vfio-platform,host=6810000.ethernet

Note there is a mismatch between the device being assigned:
/sys/firmware/devicetree/base/bus\@0/ethernet\@6800000/
and
/sys/bus/platform/devices/6810000.ethernet (hyp base) which is used
by the VFIO device. This mismatch is crudely handled in the VFIO code at
the moment. In case you use a more recent BSP, you should remove that.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

The tegra234 mgbe reset module is requested to test. It can be found at:
https://github.com/eauger/linux/tree/tegra234-mgbe-reset-module-rfc
The guest runs unmodified (tested with 6.11.0-rc5)

Note there may be some possibility to assign some kind of virtual
functions since the IP seems virtualization friendly but this needs
to be further discussed and enabled at baremetal level.
---
 hw/core/sysbus-fdt.c | 203 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..f6f0ea02cb 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -259,6 +259,34 @@ static int add_calxeda_midway_xgmac_fdt_node(SysBusDevice *sbdev, void *opaque)
     g_free(nodename);
     return 0;
 }
+/* Tegra234 MGBE properties whose values are copied/pasted from host */
+static HostProperty nvidia_tegra234_mgbe_copied_properties[] = {
+    {"compatible", false},
+    {"dma-coherent", true},
+    {"interrupt-names", true},
+    {"clock-names", false},
+    {"reg-names", false},
+    {"nvidia,rx_frames", true},
+    {"nvidia,max-platform-mtu", true},
+    {"nvidia,nvidia,slot_intvl_vals", true},
+    {"nvidia,tx_frames", true},
+    {"nvidia,rx_riwt", true},
+    {"nvidia,num-dma-chans", true},
+    {"nvidia,promisc_mode", true},
+    {"nvidia,mtl-queues", true},
+    {"nvidia,dcs-enable", true},
+    {"nvidia,dma_tx_ring_sz", true},
+    {"nvidia,num-mtl-queues", true},
+    {"nvidia,tx-queue-prio", true},
+    {"nvidia,dma-chans", true},
+    {"nvidia,rx-queue-prio", true},
+    {"mac-address", true},
+    {"nvidia,ptp_ref_clock_speed", true},
+    {"nvidia,ptp-rx-queue", true},
+    {"nvidia,tc-mapping", true},
+    {"phy-mode", false},
+    {"reset-names", false},
+};
 
 /* AMD xgbe properties whose values are copied/pasted from host */
 static HostProperty amd_xgbe_copied_properties[] = {
@@ -415,6 +443,180 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+static int add_nvidia_tegra234_mgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data = opaque;
+    PlatformBusDevice *pbus = data->pbus;
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    VFIOINTp *intp;
+    const char *parent_node = data->pbus_node_name;
+    char **node_path;
+    char *dt_name;
+    char *nodename;
+    void *host_fdt;
+    void *guest_fdt = data->fdt;
+    int i;
+    uint32_t *irq_attr, *reg_attr;
+    uint64_t mmio_base, irq_number;
+    uint32_t guest_clock_phandles[13];
+    uint32_t syscon_phandle, rst_phandle;
+    const char *clock_name[13] = {
+        "/rx-input-m", "/rx-pcs-m", "/rx-pcs-input",
+         "/rx-pcs", "/tx", "/tx-pcs",
+         "/mac-divider", "/mac", "/eee-pcs", "/mgbe",
+         "/ptp-ref", "/mgbe_macsec", "/rx-input"};
+    char *c, *fixed_name;
+
+    host_fdt = load_device_tree_from_sysfs();
+
+/*
+ * Temporary hack since we assign the mac (host=6810000.ethernet)
+ * while the host dt node is named 680000.ethernet (hypervisor).
+ * so if we use sysfs_to_dt_name(vbasedev->name), the node is not
+ * found! This may have been fixed already by Thierry though.
+ */
+    fixed_name = g_strdup(vbasedev->name);
+    c = strrchr(fixed_name, '1');
+    if (c) {
+        *c = '0';
+    }
+    dt_name = sysfs_to_dt_name(fixed_name);
+    if (!dt_name) {
+        error_report("%s incorrect sysfs device name %s",
+                     __func__, vbasedev->name);
+        exit(1);
+    }
+    node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
+                                   &error_fatal);
+    if (!node_path || !node_path[0]) {
+        error_report("%s unable to retrieve node path for %s/%s",
+                     __func__, dt_name, vdev->compat);
+        exit(1);
+    }
+
+    if (node_path[1]) {
+        error_report("%s more than one node matching %s/%s!",
+                     __func__, dt_name, vdev->compat);
+        exit(1);
+    }
+
+    g_free(dt_name);
+    g_free(fixed_name);
+
+/*
+ * Note on my host 4 regions are present including undocumented
+ * macsec-base: mac\0xpcs\0macsec-base\0hypervisor
+ */
+    if (vbasedev->num_regions != 4) {
+        error_report("%s unexpected number of regions?", __func__);
+        exit(1);
+    }
+
+    /* generate dummy nodes for reset (hisilicon rst and syscon) */
+
+    rst_phandle = qemu_fdt_alloc_phandle(guest_fdt);
+    syscon_phandle = qemu_fdt_alloc_phandle(guest_fdt);
+
+    qemu_fdt_add_subnode(guest_fdt, "/hisi-rst-syscon");
+    qemu_fdt_setprop_cell(guest_fdt, "/hisi-rst-syscon",
+                          "phandle", syscon_phandle);
+    qemu_fdt_setprop_string(guest_fdt, "/hisi-rst-syscon",
+                          "compatible", "syscon");
+
+    qemu_fdt_setprop_sized_cells(guest_fdt, "/hisi-rst-syscon", "reg",
+                                 2, 0x0, 2, 0x1000);
+
+    qemu_fdt_add_subnode(guest_fdt, "/hisi-rst");
+    qemu_fdt_setprop_cell(guest_fdt, "/hisi-rst",
+                          "phandle", rst_phandle);
+    qemu_fdt_setprop_cell(guest_fdt, "/hisi-rst",
+                          "hisilicon,rst-syscon", syscon_phandle);
+    qemu_fdt_setprop_string(guest_fdt, "/hisi-rst",
+                          "compatible", "hisilicon,hi3660-reset");
+    qemu_fdt_setprop_cell(guest_fdt, "/hisi-rst", "#reset-cells", 2);
+
+    /*
+     * generate nodes for 13 clocks. The standard clock node generation code
+     * cannot be used here since host uses single node that provides all the
+     * clocks and we don't want that node on guest? Anyway those clocks are
+     * not fixed. Some of those clocks may not be needed though.
+     */
+    for (int j = 0 ; j < 13; j++) {
+        guest_clock_phandles[j] = qemu_fdt_alloc_phandle(guest_fdt);
+        qemu_fdt_add_subnode(guest_fdt, clock_name[j]);
+        qemu_fdt_setprop_cell(guest_fdt, clock_name[j],
+                              "phandle", guest_clock_phandles[j]);
+        qemu_fdt_setprop_string(guest_fdt, clock_name[j],
+                                "compatible", "fixed-clock");
+        qemu_fdt_setprop_cell(guest_fdt, clock_name[j], "clock-frequency", 120);
+        qemu_fdt_setprop_cell(guest_fdt, clock_name[j], "#clock-cells", 0x0);
+    }
+
+    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    nodename = g_strdup_printf("%s/%s@%" PRIx64, parent_node,
+                               vbasedev->name, mmio_base);
+    qemu_fdt_add_subnode(guest_fdt, nodename);
+
+    copy_properties_from_host(nvidia_tegra234_mgbe_copied_properties,
+                       ARRAY_SIZE(nvidia_tegra234_mgbe_copied_properties),
+                       host_fdt, guest_fdt,
+                       node_path[0], nodename);
+
+    /* regs */
+    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
+        reg_attr[2 * i] = cpu_to_be32(mmio_base);
+        reg_attr[2 * i + 1] = cpu_to_be32(
+                                memory_region_size(vdev->regions[i]->mem));
+    }
+    qemu_fdt_setprop(guest_fdt, nodename, "reg", reg_attr,
+                     vbasedev->num_regions * 2 * sizeof(uint32_t));
+
+    /* interrupts */
+    irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
+    for (i = 0; i < vbasedev->num_irqs; i++) {
+        irq_number = platform_bus_get_irqn(pbus, sbdev , i)
+                         + data->irq_start;
+        irq_attr[3 * i] = cpu_to_be32(GIC_FDT_IRQ_TYPE_SPI);
+        irq_attr[3 * i + 1] = cpu_to_be32(irq_number);
+        /*
+         * General device interrupt and PCS auto-negotiation interrupts are
+         * level-sensitive while the 4 per-channel interrupts are edge
+         * sensitive
+         */
+        QLIST_FOREACH(intp, &vdev->intp_list, next) {
+            if (intp->pin == i) {
+                break;
+            }
+        }
+        if (intp->flags & VFIO_IRQ_INFO_AUTOMASKED) {
+            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        } else {
+            irq_attr[3 * i + 2] = cpu_to_be32(GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
+        }
+    }
+    qemu_fdt_setprop(guest_fdt, nodename, "interrupts",
+                     irq_attr, vbasedev->num_irqs * 3 * sizeof(uint32_t));
+
+    /* clocks */
+    qemu_fdt_setprop_cells(guest_fdt, nodename, "clocks",
+                           guest_clock_phandles[0], guest_clock_phandles[1],
+                           guest_clock_phandles[2], guest_clock_phandles[3],
+                           guest_clock_phandles[4], guest_clock_phandles[5],
+                           guest_clock_phandles[6], guest_clock_phandles[7],
+                           guest_clock_phandles[8], guest_clock_phandles[9],
+                           guest_clock_phandles[10], guest_clock_phandles[11],
+                           guest_clock_phandles[12]);
+
+    /* resets */
+    qemu_fdt_setprop_cells(guest_fdt, nodename, "resets",
+                           rst_phandle, 0, 0, rst_phandle, 8, 0);
+
+    return 0;
+}
+
 /* DT compatible matching */
 static bool vfio_platform_match(SysBusDevice *sbdev,
                                 const BindingEntry *entry)
@@ -490,6 +692,7 @@ static const BindingEntry bindings[] = {
     TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
     TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
+    VFIO_PLATFORM_BINDING("nvidia,tegra234-mgbe", add_nvidia_tegra234_mgbe_fdt_node),
 #endif
 #ifdef CONFIG_TPM
     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
-- 
2.41.0


