Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F07C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi0A-0000oQ-Fj; Wed, 05 Mar 2025 01:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi06-0000mw-VZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi02-0004Fv-9O
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:02 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx63Fn68dnxd+KAA--.40613S3;
 Wed, 05 Mar 2025 14:12:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S9;
 Wed, 05 Mar 2025 14:12:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 07/15] hw/intc/loongarch_extioi: Use cpu plug notification
Date: Wed,  5 Mar 2025 14:12:42 +0800
Message-Id: <20250305061250.1908444-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250305061250.1908444-1-maobibo@loongson.cn>
References: <20250305061250.1908444-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S9
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
 hw/loongarch/virt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 0629347da1..907f965c54 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -312,7 +312,7 @@ static void virt_devices_init(DeviceState *pch_pic,
 
 static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
 {
-    int num, pin;
+    int num;
     MachineState *ms = MACHINE(lvms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus;
@@ -328,15 +328,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
         }
 
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs), &err);
-
-        /*
-         * connect ext irq to the cpu irq
-         * cpu_pin[9:2] <= intc_pin[7:0]
-         */
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_connect_gpio_out(lvms->extioi, (num * LS3A_INTC_IP + pin),
-                                  qdev_get_gpio_in(DEVICE(cs), pin + 2));
-        }
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs), &err);
     }
 }
 
-- 
2.43.5


