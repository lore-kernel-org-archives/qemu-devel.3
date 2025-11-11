Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C01CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 07:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIiy4-0007yC-Va; Tue, 11 Nov 2025 02:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1vIiy1-0007wi-Jj
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:39:05 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1vIixy-0005Ix-DO
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 02:39:05 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx6tEH6BJpLN0hAA--.8316S3;
 Tue, 11 Nov 2025 15:38:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxH8IG6BJpRSovAQ--.16851S2;
 Tue, 11 Nov 2025 15:38:47 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: lixianglai@loongson.cn,
	qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH] fix pci device can't alloc irq from fdt
Date: Tue, 11 Nov 2025 15:14:36 +0800
Message-Id: <20251111071436.1555402-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8IG6BJpRSovAQ--.16851S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When we use the -kernel parameter to start an elf format kernel relying on
fdt, we get the following error:

pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.0: enabling device (0000 -> 0003)
pcieport 0000:00:01.0: PME: Signaling with IRQ 19
pcieport 0000:00:01.0: AER: enabled with IRQ 19
pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.1: enabling device (0000 -> 0003)
pcieport 0000:00:01.1: PME: Signaling with IRQ 20
pcieport 0000:00:01.1: AER: enabled with IRQ 20
pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.2: enabling device (0000 -> 0003)
pcieport 0000:00:01.2: PME: Signaling with IRQ 21
pcieport 0000:00:01.2: AER: enabled with IRQ 21
pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
pcieport 0000:00:01.3: enabling device (0000 -> 0003)
pcieport 0000:00:01.3: PME: Signaling with IRQ 22
pcieport 0000:00:01.3: AER: enabled with IRQ 22
pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22

This is because the description of interrupt-cell size in the interrupt
controller pch_pic in our fdt is incorrect, and the description of
interrupt-cell is missing in the pcie irq map. Now it is corrected and
the correct interrupt-cell is added in th pcie irq map.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>

 hw/loongarch/virt-fdt-build.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 1f0ba01f71..f1f70ed3c3 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -272,7 +272,7 @@ static void fdt_add_pch_pic_node(LoongArchVirtMachineState *lvms,
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0,
                            pch_pic_base, 0, pch_pic_size);
     qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *eiointc_phandle);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,pic-base-vec", 0);
@@ -395,6 +395,8 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
                                  2, base_mmio, 2, size_mmio);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
                            0, *pch_msi_phandle, 0, 0x10000);
+
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
     fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
     g_free(nodename);
 }
-- 
2.39.1


