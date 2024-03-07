Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43043C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 14:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riF7C-0000r0-Ms; Thu, 07 Mar 2024 09:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riF7A-0000l5-On
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riF72-0003UT-W3
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:52:50 -0500
Received: from loongson.cn (unknown [43.156.43.207])
 by gateway (Coremail) with SMTP id _____8Axz+u01Oll8_MVAA--.54428S3;
 Thu, 07 Mar 2024 22:52:36 +0800 (CST)
Received: from VM-4-14-ubuntu.. (unknown [43.156.43.207])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTs2Y1OllbElQAA--.15045S13; 
 Thu, 07 Mar 2024 22:52:36 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 11/17] hw/loongarch: fdt adds Extend I/O Interrupt Controller
Date: Thu,  7 Mar 2024 22:52:01 +0800
Message-Id: <20240307145207.247913-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
References: <20240307145207.247913-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTs2Y1OllbElQAA--.15045S13
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWUuryfAr43WFyUXrWkGrX_yoW5ZF4kpF
 W7CF9xur4UJF1xWrsa9345AwnxArs3ury2qw129rZ2ka4DX34xXw48A397JF18Cw18Xa4q
 vFZYq34UW3ZFqwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcHUqUUUUU
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

fdt adds Extend I/O Interrupt Controller,
we use 'loongson,ls2k2000-eiointc'.

See:
https://github.com/torvalds/linux/blob/v6.7/drivers/irqchip/irq-loongson-eiointc.c
https://lore.kernel.org/r/764e02d924094580ac0f1d15535f4b98308705c6.1683279769.git.zhoubinbin@loongson.cn

Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240301093839.663947-12-gaosong@loongson.cn>
---
 hw/loongarch/virt.c                | 30 +++++++++++++++++++++++++++++-
 include/hw/intc/loongarch_extioi.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index d260f933a5..822f070c45 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -123,6 +123,31 @@ static void fdt_add_cpuic_node(LoongArchMachineState *lams,
     g_free(nodename);
 }
 
+static void fdt_add_eiointc_node(LoongArchMachineState *lams,
+                                  uint32_t *cpuintc_phandle,
+                                  uint32_t *eiointc_phandle)
+{
+    MachineState *ms = MACHINE(lams);
+    char *nodename;
+    hwaddr extioi_base = APIC_BASE;
+    hwaddr extioi_size = EXTIOI_SIZE;
+
+    *eiointc_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename = g_strdup_printf("/eiointc@%" PRIx64, extioi_base);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", *eiointc_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
+                            "loongson,ls2k2000-eiointc");
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
+                          *cpuintc_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupts", 3);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0,
+                           extioi_base, 0x0, extioi_size);
+    g_free(nodename);
+}
+
 static void fdt_add_flash_node(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
@@ -544,7 +569,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPULoongArchState *env;
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
-    uint32_t cpuintc_phandle;
+    uint32_t cpuintc_phandle, eiointc_phandle;
 
     /*
      * The connection of interrupts:
@@ -613,6 +638,9 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
         }
     }
 
+    /* Add Extend I/O Interrupt Controller node */
+    fdt_add_eiointc_node(lams, &cpuintc_phandle, &eiointc_phandle);
+
     pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index a0a46b888c..410c6e1121 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -39,6 +39,7 @@
 #define EXTIOI_COREISR_END           (0xB20 - APIC_OFFSET)
 #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
+#define EXTIOI_SIZE                  0x800
 
 typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
-- 
2.34.1


