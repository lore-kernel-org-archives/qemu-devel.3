Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B464FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1H3u-0007Wb-7H; Sun, 28 Apr 2024 22:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1H3e-0006iM-2D
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:47:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1H3c-00067R-2Z
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 22:47:57 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx3+tPCi9mJ8UEAA--.16750S3;
 Mon, 29 Apr 2024 10:47:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxkFVECi9mp6QJAA--.7424S18; 
 Mon, 29 Apr 2024 10:47:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 16/17] hw/loongarch: Add cells missing from uart node
Date: Mon, 29 Apr 2024 10:30:42 +0800
Message-Id: <20240429023043.2607982-17-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240429023043.2607982-1-gaosong@loongson.cn>
References: <20240429023043.2607982-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxkFVECi9mp6QJAA--.7424S18
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

uart node need interrupts and interrupt-parent cells.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20240426091551.2397867-17-gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 48f73edd8e..dbd7928759 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -245,7 +245,8 @@ static void fdt_add_rtc_node(LoongArchMachineState *lams)
     g_free(nodename);
 }
 
-static void fdt_add_uart_node(LoongArchMachineState *lams)
+static void fdt_add_uart_node(LoongArchMachineState *lams,
+                              uint32_t *pch_pic_phandle)
 {
     char *nodename;
     hwaddr base = VIRT_UART_BASE;
@@ -258,6 +259,10 @@ static void fdt_add_uart_node(LoongArchMachineState *lams)
     qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
     qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
+                           VIRT_UART_IRQ - VIRT_GSI_BASE, 0x4);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *pch_pic_phandle);
     g_free(nodename);
 }
 
@@ -630,7 +635,7 @@ static void loongarch_devices_init(DeviceState *pch_pic,
                    qdev_get_gpio_in(pch_pic,
                                     VIRT_UART_IRQ - VIRT_GSI_BASE),
                    115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-    fdt_add_uart_node(lams);
+    fdt_add_uart_node(lams, pch_pic_phandle);
 
     /* Network init */
     pci_init_nic_devices(pci_bus, mc->default_nic);
-- 
2.25.1


