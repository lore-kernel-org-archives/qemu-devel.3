Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394CDC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 09:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzMN-0003L1-Fs; Fri, 01 Mar 2024 04:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rfzMC-0003I7-IB
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:39:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rfzM5-0006Oc-Kd
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:39:07 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxWPAoouFlXz0TAA--.48678S3;
 Fri, 01 Mar 2024 17:38:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDBMfouFlyZxLAA--.4871S14; 
 Fri, 01 Mar 2024 17:38:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org,
 maobibo@loongson.cn, zhaotianrui@loongson.cn, lixianglai@loongson.cn,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com
Subject: [PATCH v5 12/17] hw/loongarch: fdt adds pch_pic Controller
Date: Fri,  1 Mar 2024 17:38:33 +0800
Message-Id: <20240301093839.663947-13-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240301093839.663947-1-gaosong@loongson.cn>
References: <20240301093839.663947-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDBMfouFlyZxLAA--.4871S14
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

fdt adds pch pic controller, we use 'loongson,pch-pic-1.0'

See:
https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongson-pch-pic.c
https://lore.kernel.org/r/20200528152757.1028711-4-jiaxun.yang@flygoat.com

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/pci-host/ls7a.h |  1 +
 hw/loongarch/virt.c        | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
index e753449593..fe260f0183 100644
--- a/include/hw/pci-host/ls7a.h
+++ b/include/hw/pci-host/ls7a.h
@@ -24,6 +24,7 @@
 #define VIRT_PCH_REG_BASE        0x10000000UL
 #define VIRT_IOAPIC_REG_BASE     (VIRT_PCH_REG_BASE)
 #define VIRT_PCH_MSI_ADDR_LOW    0x2FF00000UL
+#define VIRT_PCH_REG_SIZE        0x400
 
 /*
  * GSI_BASE is hard-coded with 64 in linux kernel, else kernel fails to boot
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4091a14080..87908d1f79 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -125,6 +125,31 @@ static void fdt_add_eiointc_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
+static void fdt_add_pch_pic_node(LoongArchMachineState *lams,
+                                 uint32_t *eiointc_phandle,
+                                 uint32_t *pch_pic_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
+    hwaddr pch_pic_base = VIRT_PCH_REG_BASE;
+    hwaddr pch_pic_size = VIRT_PCH_REG_SIZE;
+
+    *pch_pic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/platic@%" PRIx64, pch_pic_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt,  nodename, "phandle", *pch_pic_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,pch-pic-1.0");
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0,
+                           pch_pic_base, 0, pch_pic_size);
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *eiointc_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "loongson,pic-base-vec", 0);
+    g_free(nodename);
+}
+
 static void fdt_add_flash_node(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -533,7 +558,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle, eiointc_phandle;
+    uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle;
 
     /*
      * The connection of interrupts:
@@ -624,6 +649,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
         qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
     }
 
+    /* Add PCH PIC node */
+    fdt_add_pch_pic_node(lams, &eiointc_phandle, &pch_pic_phandle);
+
     pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
     num = EXTIOI_IRQS - start;
-- 
2.25.1


