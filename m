Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40144C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaPQ-0005Ek-E5; Mon, 09 Jun 2025 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOaPL-0005CW-6k
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOaPH-00075U-3l
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxbKxJwUZoWG4RAQ--.44350S3;
 Mon, 09 Jun 2025 19:11:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxtFwUZoiU0SAQ--.4222S9;
 Mon, 09 Jun 2025 19:11:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 07/10] hw/loongarch: connect pch_msi controller to avec
 controller
Date: Mon,  9 Jun 2025 18:48:30 +0800
Message-Id: <20250609104833.839811-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250609104833.839811-1-gaosong@loongson.cn>
References: <20250609104833.839811-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtFwUZoiU0SAQ--.4222S9
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 718b5b4f92..6b670e7936 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -503,11 +503,19 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
     qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
     d = SYS_BUS_DEVICE(pch_msi);
     sysbus_realize_and_unref(d, &error_fatal);
-    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
-    for (i = 0; i < num; i++) {
-        /* Connect pch_msi irqs to extioi */
-        qdev_connect_gpio_out(DEVICE(d), i,
-                              qdev_get_gpio_in(extioi, i + start));
+    if (virt_is_avecintc_enabled(lvms)) {
+        for (i = 0; i < num; i++) {
+            /* Connect pch_msi irqs to avec */
+            qdev_connect_gpio_out(DEVICE(d), i,
+                                 qdev_get_gpio_in(avec, i + start));
+        }
+    } else {
+        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
+        for (i = 0; i < num; i++) {
+            /* Connect pch_msi irqs to extioi */
+            qdev_connect_gpio_out(DEVICE(d), i,
+                                  qdev_get_gpio_in(extioi, i + start));
+        }
     }
 
     virt_devices_init(pch_pic, lvms);
-- 
2.34.1


