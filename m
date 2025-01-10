Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7784FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWAxH-0002Bo-7u; Fri, 10 Jan 2025 04:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tWAwn-0001fa-VH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:58 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tWAwi-0005Nz-G7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 04:04:53 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa+n4oBn2Q9hAA--.60637S3;
 Fri, 10 Jan 2025 17:04:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx7sWk4oBn718cAA--.42742S6;
 Fri, 10 Jan 2025 17:04:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/intc/loongarch_extioi: Use cpu plug notification
Date: Fri, 10 Jan 2025 17:04:36 +0800
Message-Id: <20250110090436.2831690-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250110090436.2831690-1-maobibo@loongson.cn>
References: <20250110090436.2831690-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx7sWk4oBn718cAA--.42742S6
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

Use hotplug_handler_plug() to nofity extioi object when cold-plug
cpu is created, so that extioi can set and configure irq routing
to new cpu.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index df56d75a6e..4006cabdc5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -850,7 +850,8 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     LoongArchCPU *lacpu;
     CPULoongArchState *env;
     CPUState *cpu_state;
-    int cpu, pin, i, start, num;
+    int cpu, i, start, num;
+    Error *local_err = NULL;
 
     /*
      * Extended IRQ model.
@@ -932,16 +933,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
     }
 
-    /*
-     * connect ext irq to the cpu irq
-     * cpu_pin[9:2] <= intc_pin[7:0]
-     */
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpudev = DEVICE(qemu_get_cpu(cpu));
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
-                                  qdev_get_gpio_in(cpudev, pin + 2));
-        }
+        hotplug_handler_plug(HOTPLUG_HANDLER(extioi), cpudev, &local_err);
     }
 
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
-- 
2.39.3


