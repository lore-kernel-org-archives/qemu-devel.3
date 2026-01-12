Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26491D2503C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 07:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfC3J-0007sk-6w; Mon, 12 Jan 2026 02:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vfC3F-0007p1-Vo
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:21 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vfC3E-0004qY-13
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 02:09:21 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxCMIdnmRpicYHAA--.12538S3;
 Mon, 12 Jan 2026 15:09:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCx98AdnmRpJKgaAA--.41401S2;
 Mon, 12 Jan 2026 15:09:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 06/10] hw/loongarch/virt: Get irq number from gpex config info
Date: Mon, 12 Jan 2026 15:09:00 +0800
Message-Id: <20260112070904.3230440-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260112070904.3230440-1-maobibo@loongson.cn>
References: <20260112070904.3230440-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx98AdnmRpJKgaAA--.41401S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The base irq number of GPEX PCIE host bridge can comes from gpex::irq.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b00393565f..8a1842c492 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -292,7 +292,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     PCIBus *pci_bus;
     MemoryRegion *ecam_alias, *ecam_reg, *pio_alias, *pio_reg;
     MemoryRegion *mmio_alias, *mmio_reg;
-    int i;
+    int i, irq;
 
     gpex_dev = qdev_new(TYPE_GPEX_HOST);
     d = SYS_BUS_DEVICE(gpex_dev);
@@ -332,9 +332,9 @@ static void virt_devices_init(DeviceState *pch_pic,
                                 pio_alias);
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        sysbus_connect_irq(d, i,
-                           qdev_get_gpio_in(pch_pic, 16 + i));
-        gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
+        irq = lvms->gpex.irq + i - VIRT_GSI_BASE;
+        sysbus_connect_irq(d, i, qdev_get_gpio_in(pch_pic, irq));
+        gpex_set_irq_num(GPEX_HOST(gpex_dev), i, irq);
     }
 
     /*
@@ -343,7 +343,7 @@ static void virt_devices_init(DeviceState *pch_pic,
      */
     for (i = VIRT_UART_COUNT; i-- > 0;) {
         hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
-        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
+        irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
         serial_mm_init(get_system_memory(), base, 0,
                        qdev_get_gpio_in(pch_pic, irq),
                        115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
-- 
2.52.0


