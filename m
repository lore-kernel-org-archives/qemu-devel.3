Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854C3D1AD2F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 08:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ziT-00056X-81; Wed, 16 Oct 2024 04:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t0ziQ-000555-43
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:49:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t0ziO-0006Pb-66
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 04:49:09 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxNOkBfg9nKdUfAA--.45935S3;
 Wed, 16 Oct 2024 16:49:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx_9X4fQ9n6ncsAA--.29226S4;
 Wed, 16 Oct 2024 16:49:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/5] hw/loongarch/virt: Add FDT table support with acpi ged pm
 register
Date: Wed, 16 Oct 2024 16:31:00 +0800
Message-Id: <20241016083103.2541727-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241016083103.2541727-1-gaosong@loongson.cn>
References: <20241016083103.2541727-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx_9X4fQ9n6ncsAA--.29226S4
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

From: Bibo Mao <maobibo@loongson.cn>

ACPI ged is used for power management on LoongArch virt platform, in
general it is parsed from acpi table. However if system boot directly from
elf kernel, no UEFI bios is provided and acpi table cannot be used also.

Here acpi ged pm register is exposed with FDT table, it is compatbile
with syscon method in FDT table, only that acpi ged pm register is accessed
with 8-bit mode, rather with 32-bit mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240918014206.2165821-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ddd886f69b..9a635d1d3d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -280,6 +280,44 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
     g_free(nodename);
 }
 
+static void fdt_add_ged_reset(LoongArchVirtMachineState *lvms)
+{
+    char *name;
+    uint32_t ged_handle;
+    MachineState *ms = MACHINE(lvms);
+    hwaddr base = VIRT_GED_REG_ADDR;
+    hwaddr size = ACPI_GED_REG_COUNT;
+
+    ged_handle = qemu_fdt_alloc_phandle(ms->fdt);
+    name = g_strdup_printf("/ged@%" PRIx64, base);
+    qemu_fdt_add_subnode(ms->fdt, name);
+    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
+    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0, base, 0x0, size);
+    /* 8 bit registers */
+    qemu_fdt_setprop_cell(ms->fdt, name, "reg-shift", 0);
+    qemu_fdt_setprop_cell(ms->fdt, name, "reg-io-width", 1);
+    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", ged_handle);
+    ged_handle = qemu_fdt_get_phandle(ms->fdt, name);
+    g_free(name);
+
+    name = g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(ms->fdt, name);
+    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", ged_handle);
+    qemu_fdt_setprop_cell(ms->fdt, name, "offset", ACPI_GED_REG_RESET);
+    qemu_fdt_setprop_cell(ms->fdt, name, "value", ACPI_GED_RESET_VALUE);
+    g_free(name);
+
+    name = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(ms->fdt, name);
+    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", ged_handle);
+    qemu_fdt_setprop_cell(ms->fdt, name, "offset", ACPI_GED_REG_SLEEP_CTL);
+    qemu_fdt_setprop_cell(ms->fdt, name, "value", ACPI_GED_SLP_EN |
+                          (ACPI_GED_SLP_TYP_S5 << ACPI_GED_SLP_TYP_POS));
+    g_free(name);
+}
+
 static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
                               uint32_t *pch_pic_phandle, hwaddr base,
                               int irq, bool chosen)
@@ -737,6 +775,7 @@ static void virt_devices_init(DeviceState *pch_pic,
                          qdev_get_gpio_in(pch_pic,
                          VIRT_RTC_IRQ - VIRT_GSI_BASE));
     fdt_add_rtc_node(lvms, pch_pic_phandle);
+    fdt_add_ged_reset(lvms);
 
     /* acpi ged */
     lvms->acpi_ged = create_acpi_ged(pch_pic, lvms);
-- 
2.34.1


