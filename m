Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E410C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAge-00028X-Ad; Thu, 06 Jun 2024 06:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFAgd-00028A-K1
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sFAga-00050W-Sb
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717670976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CMws9XKKNqLHNAZjVr6cRVE4P3G9ltVNEHGDPxoP3g8=;
 b=Vn/UfnMErG6lWaDgk8lSiGUOyycH3/F9QtLBoY8P2qhiIKDYZ+0511vbvDMFc6pZsYFHTn
 fPKVvdqKiFJGXveWb00YJaHJETgt6Iiqr7tXxv+Jb+LFPO+fh47Nr+auwnJAMDtbITBtPA
 JqwbKXkogZWHWLAYMOQ+vdqtzG6nHRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-4AvQoy8VMzGc7_gmBNiX9w-1; Thu, 06 Jun 2024 06:48:13 -0400
X-MC-Unique: 4AvQoy8VMzGc7_gmBNiX9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 417BE85A588;
 Thu,  6 Jun 2024 10:48:13 +0000 (UTC)
Received: from virt-mtsnow-02.lab.eng.rdu2.redhat.com
 (virt-mtsnow-02.lab.eng.rdu2.redhat.com [10.8.1.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E32652166B00;
 Thu,  6 Jun 2024 10:48:12 +0000 (UTC)
From: Zhenyu Zhang <zhenyzha@redhat.com>
To: qemu-arm@nongnu.org
Cc: zhenyzha@redhat.com, qemu-devel@nongnu.org, gshan@redhat.com,
 eauger@redhat.com, sebott@redhat.com, peter.maydell@linaro.org,
 cohuck@redhat.com, ddutile@redhat.com, shahuang@redhat.com
Subject: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux guest on
 host with Fujitsu CPUs
Date: Thu,  6 Jun 2024 06:47:45 -0400
Message-ID: <20240606104745.291330-1-zhenyzha@redhat.com>
MIME-Version: 1.0\nContent-Type: text/plain;
 charset=UTF-8\nContent-Transfer-Encoding: 8bit
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, BOGUS_MIME_VERSION=3.496,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Multiple warning messages and corresponding backtraces are observed when Linux
guest is booted on the host with Fujitsu CPUs. One of them is shown as below.

[    0.032443] ------------[ cut here ]------------
[    0.032446] uart-pl011 9000000.pl011: ARCH_DMA_MINALIGN smaller than CTR_EL0.CWG (128 < 256)
[    0.032454] WARNING: CPU: 0 PID: 1 at arch/arm64/mm/dma-mapping.c:54 arch_setup_dma_ops+0xbc/0xcc
[    0.032470] Modules linked in:
[    0.032475] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0-452.el9.aarch64 #1
[    0.032481] Hardware name: linux,dummy-virt (DT)
[    0.032484] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.032490] pc : arch_setup_dma_ops+0xbc/0xcc
[    0.032496] lr : arch_setup_dma_ops+0xbc/0xcc
[    0.032501] sp : ffff80008003b860
[    0.032503] x29: ffff80008003b860 x28: 0000000000000000 x27: ffffaae4b949049c
[    0.032510] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    0.032517] x23: 0000000000000100 x22: 0000000000000000 x21: 0000000000000000
[    0.032523] x20: 0000000100000000 x19: ffff2f06c02ea400 x18: ffffffffffffffff
[    0.032529] x17: 00000000208a5f76 x16: 000000006589dbcb x15: ffffaae4ba071c89
[    0.032535] x14: 0000000000000000 x13: ffffaae4ba071c84 x12: 455f525443206e61
[    0.032541] x11: 68742072656c6c61 x10: 0000000000000029 x9 : ffffaae4b7d21da4
[    0.032547] x8 : 0000000000000029 x7 : 4c414e494d5f414d x6 : 0000000000000029
[    0.032553] x5 : 000000000000000f x4 : ffffaae4b9617a00 x3 : 0000000000000001
[    0.032558] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2f06c029be40
[    0.032564] Call trace:
[    0.032566]  arch_setup_dma_ops+0xbc/0xcc
[    0.032572]  of_dma_configure_id+0x138/0x300
[    0.032591]  amba_dma_configure+0x34/0xc0
[    0.032600]  really_probe+0x78/0x3dc
[    0.032614]  __driver_probe_device+0x108/0x160
[    0.032619]  driver_probe_device+0x44/0x114
[    0.032624]  __device_attach_driver+0xb8/0x14c
[    0.032629]  bus_for_each_drv+0x88/0xe4
[    0.032634]  __device_attach+0xb0/0x1e0
[    0.032638]  device_initial_probe+0x18/0x20
[    0.032643]  bus_probe_device+0xa8/0xb0
[    0.032648]  device_add+0x4b4/0x6c0
[    0.032652]  amba_device_try_add.part.0+0x48/0x360
[    0.032657]  amba_device_add+0x104/0x144
[    0.032662]  of_amba_device_create.isra.0+0x100/0x1c4
[    0.032666]  of_platform_bus_create+0x294/0x35c
[    0.032669]  of_platform_populate+0x5c/0x150
[    0.032672]  of_platform_default_populate_init+0xd0/0xec
[    0.032697]  do_one_initcall+0x4c/0x2e0
[    0.032701]  do_initcalls+0x100/0x13c
[    0.032707]  kernel_init_freeable+0x1c8/0x21c
[    0.032712]  kernel_init+0x28/0x140
[    0.032731]  ret_from_fork+0x10/0x20
[    0.032735] ---[ end trace 0000000000000000 ]---

In Linux, a check is applied to every device which is exposed through device-tree
node. The warning message is raised when the device isn't DMA coherent and the
cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The cache line is
sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the guest CPUs. 
The DMA coherent capability is claimed through 'dma-coherent' in their
device-tree nodes.

I don't see those devices need to be DMA incoherent necessarily and those devices
will do DMA operations in practice. So lets add 'dma-coherent' property to their
device-tree nodes to avoid the unexpected warnings in the Linux guest.

Signed-off-by: Zhenyu Zhang <zhenyzha@redhat.com>
---
 hw/arm/boot.c        | 1 +
 hw/arm/virt.c        | 4 ++++
 hw/core/sysbus-fdt.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d480a7da02..cdf99966e6 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -509,6 +509,7 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
     qemu_fdt_setprop_cell(fdt, "/psci", "cpu_on", cpu_on_fn);
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
+    qemu_fdt_setprop(fdt, "/psci", "dma-coherent", NULL, 0);
 }
 
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..d3e5f512e2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -652,6 +652,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
         qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI,
                                INTID_TO_PPI(VIRTUAL_PMU_IRQ), irqflags);
+        qemu_fdt_setprop(ms->fdt, "/pmu", "dma-coherent", NULL, 0);
     }
 }
 
@@ -936,6 +937,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
                                vms->clock_phandle, vms->clock_phandle);
     qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
@@ -972,6 +974,7 @@ static void create_rtc(const VirtMachineState *vms)
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     g_free(nodename);
 }
 
@@ -1077,6 +1080,7 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
     qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
     qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 
     if (gpio != VIRT_GPIO) {
         /* Mark as not usable by the normal world */
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index eebcd28f9a..da47071a95 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -554,6 +554,7 @@ void platform_bus_add_all_fdt_nodes(void *fdt, const char *intc, hwaddr addr,
     qemu_fdt_setprop_cells(fdt, node, "ranges", 0, addr >> 32, addr, bus_size);
 
     qemu_fdt_setprop_phandle(fdt, node, "interrupt-parent", intc);
+    qemu_fdt_setprop(fdt, node, "dma-coherent", NULL, 0);
 
     dev = qdev_find_recursive(sysbus_get_default(), TYPE_PLATFORM_BUS_DEVICE);
     pbus = PLATFORM_BUS_DEVICE(dev);
-- 
2.43.0


