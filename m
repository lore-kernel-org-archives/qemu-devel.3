Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0179BC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF7I-0001Ni-91; Thu, 07 Mar 2024 09:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF7E-0000x2-NM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:53:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF77-0003XT-38
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:53:00 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8BxHOu41Oll+PMVAA--.44308S3;
 Thu, 07 Mar 2024 22:52:40 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S15; 
 Thu, 07 Mar 2024 22:52:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 13/17] hw/loongarch: fdt adds pch_msi Controller
Date: Thu,  7 Mar 2024 22:52:03 +0800
Message-Id: <20240307145207.247913-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
References: <20240307145207.247913-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S15
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF47Jr1UGFykAFy5AFyfZrc_yoW5ZrWxpF
 ZrAFZxZr4UWa47XFZav342ywsxAr1fu34jqF429ry0kFyDu3srXr48Aa93GryUAw48XFn0
 vFZ5X3srW3ZrGwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
 17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 cHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

fdt adds pch msi controller, we use 'loongson,pch-msi-1.0'.

See:
https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongson-pch-msi.c
https://lore.kernel.org/r/20200528152757.1028711-6-jiaxun.yang@flygoat.com

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-14-gaosong@loongson.cn>
---
 hw/loongarch/virt.c        | 33 ++++++++++++++++++++++++++++++++-
 include/hw/pci-host/ls7a.h |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b7b653fc1..1e767c49f8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -173,6 +173,34 @@ static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
+static void fdt_add_pch_msi_node(LoongArchMachineState *lams,
+                                 uint32_t *eiointc_phandle,
+                                 uint32_t *pch_msi_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
+    hwaddr pch_msi_base = VIRT_PCH_MSI_ADDR_LOW;
+    hwaddr pch_msi_size = VIRT_PCH_MSI_SIZE;
+
+    *pch_msi_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/msi@%" PRIx64, pch_msi_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", *pch_msi_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,pch-msi-1.0");
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg",
+                           0, pch_msi_base,
+                           0, pch_msi_size);
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *eiointc_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,msi-base-vec",
+                          VIRT_PCH_PIC_IRQ_NUM);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,msi-num-vecs",
+                          EXTIOI_IRQS - VIRT_PCH_PIC_IRQ_NUM);
+    g_free(nodename);
+}
+
 static void fdt_add_flash_node(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -594,7 +622,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle;
+    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
 
     /*
      * The connection of interrupts:
@@ -702,6 +730,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
                               qdev_get_gpio_in(extioi, i + start));
     }
 
+    /* Add PCH MSI node */
+    fdt_add_pch_msi_node(lams, &eiointc_phandle, &pch_msi_phandle);
+
     loongarch_devices_init(pch_pic, lams);
 }
 
diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index fe260f0183..cd7c9ec7bc 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -25,6 +25,7 @@
 #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
 #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
 #define VIRT_PCH_REG_SIZE        0x400
+#define VIRT_PCH_MSI_SIZE        0x8
 
 /*
  * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
-- 
2.34.1


