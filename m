Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E154DC48295
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDj-0006uv-BS; Thu, 01 Feb 2024 11:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaB8-0002yb-KF
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:42 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAv-0002Un-Kg
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=mAI+pje2IHyDnEouIzhJkV5N4vbFYGUKvrHpNRj8FXs=; b=ACY4qryZhdhbHuCgN8/n7fxAWV
 g0QsS9zRc3wLPr0VPfoAOD/D+HIW/kVFo9fYURufojC0SpFdroAtedsZd2T5kmFUa1X+ylgU1l0Ob
 XqUc1aPynHJL7xsodGvJvjdGcLgFbm7+B45BaPk7XwZgszwqib9QBGz7BK7HnW/65IUmAfSUTpZGm
 7pKA0pr1H5e74ynHkD9dhOrVz4OHtyIoMUO2FB70jXEfv5YjlhHEW/+ut+o/1Rb8w2X/dAv5wBEMu
 I2YAAF6EvdkmbtJRK1WuOKsaIfW17Ax9EjqzvYjSFC+3VM6srFi/+Ynitt0bnI+qc/MyH+bvAsadQ
 JCJRXLeQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAh-00000009cMO-1xPm for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IOk-3MmN for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/47] hw/sparc/sun4m: use qemu_find_nic_info()
Date: Thu,  1 Feb 2024 16:44:07 +0000
Message-ID: <20240201164412.785520-43-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Obtain the MAC address from the NIC configuration if there is one, or
generate one explicitly so that it can be placed in the PROM.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/sparc/sun4m.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550af01690..e782c8ec7a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -299,13 +299,15 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
 
 static void *sparc32_dma_init(hwaddr dma_base,
                               hwaddr esp_base, qemu_irq espdma_irq,
-                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
+                              hwaddr le_base, qemu_irq ledma_irq,
+                              MACAddr *mac)
 {
     DeviceState *dma;
     ESPDMADeviceState *espdma;
     LEDMADeviceState *ledma;
     SysBusESPState *esp;
     SysBusPCNetState *lance;
+    NICInfo *nd = qemu_find_nic_info("lance", true, NULL);
 
     dma = qdev_new(TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
@@ -320,7 +322,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
-    qdev_set_nic_properties(DEVICE(lance), nd);
+
+    if (nd) {
+        qdev_set_nic_properties(DEVICE(lance), nd);
+        memcpy(mac->a, nd->macaddr.a, sizeof(mac->a));
+    } else {
+        qemu_macaddr_default_if_unset(mac);
+        qdev_prop_set_macaddr(DEVICE(lance), "mac", mac->a);
+    }
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
@@ -823,7 +832,7 @@ static void sun4m_hw_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
     HostMemoryBackend *ram_memdev = machine->memdev;
-    NICInfo *nd = &nd_table[0];
+    MACAddr hostid;
 
     if (machine->ram_size > hwdef->max_mem) {
         error_report("Too much memory for this machine: %" PRId64 ","
@@ -884,10 +893,9 @@ static void sun4m_hw_init(MachineState *machine)
                         hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
-    qemu_check_nic_model(nd, TYPE_LANCE);
     sparc32_dma_init(hwdef->dma_base,
                      hwdef->esp_base, slavio_irq[18],
-                     hwdef->le_base, slavio_irq[16], nd);
+                     hwdef->le_base, slavio_irq[16], &hostid);
 
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
@@ -1039,7 +1047,7 @@ static void sun4m_hw_init(MachineState *machine)
                                     machine->initrd_filename,
                                     machine->ram_size, &initrd_size);
 
-    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
+    nvram_init(nvram, hostid.a, machine->kernel_cmdline,
                machine->boot_config.order, machine->ram_size, kernel_size,
                graphic_width, graphic_height, graphic_depth,
                hwdef->nvram_machine_id, "Sun4m");
-- 
2.43.0


