Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AC3E7FDE0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn27m-0000Zw-77; Mon, 02 Feb 2026 17:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn27E-0005wV-4m; Mon, 02 Feb 2026 17:09:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn27C-0002l3-Lc; Mon, 02 Feb 2026 17:09:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8447E1852C4;
 Tue, 03 Feb 2026 01:07:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 62E5635B3D7;
 Tue, 03 Feb 2026 01:08:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 23/56] hw/loongarch/virt: Modify the interrupt trigger
 type in fdt table
Date: Tue,  3 Feb 2026 01:07:28 +0300
Message-ID: <20260202220805.945271-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Xianglai Li <lixianglai@loongson.cn>

In the loongarch virt fdt file, the interrupt trigger type directly
uses magic numbers. Now, refer to the definitions in the linux kernel and
use macro definitions.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
(cherry picked from commit 47de28a0b7fb96531271aaeaa3e7f2cad2b91221)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 1f0ba01f71..7333019cf7 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -16,6 +16,11 @@
 #include "system/reset.h"
 #include "target/loongarch/cpu.h"
 
+#define FDT_IRQ_TYPE_EDGE_RISING  1
+#define FDT_IRQ_TYPE_EDGE_FALLING 2
+#define FDT_IRQ_TYPE_LEVEL_HIGH   4
+#define FDT_IRQ_TYPE_LEVEL_LOW    8
+
 static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
@@ -415,7 +420,8 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
     if (chosen) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     }
-    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
+                           FDT_IRQ_TYPE_LEVEL_HIGH);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
@@ -435,7 +441,8 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
                             "loongson,ls7a-rtc");
     qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
     qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
-                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
+                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
+                           FDT_IRQ_TYPE_LEVEL_HIGH);
     qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
                           *pch_pic_phandle);
     g_free(nodename);
-- 
2.47.3


