Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567BDE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 07:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTG24-0005ow-0J; Thu, 02 Jan 2025 02:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tTG21-0005mn-EV
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:13 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tTG1y-0000YY-2V
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 02:54:13 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxfa8WRnZnyS5dAA--.28101S3;
 Thu, 02 Jan 2025 15:53:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8cVRnZn0i8RAA--.16082S3;
 Thu, 02 Jan 2025 15:53:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/intc/loongarch_extioi: Get cpu number from
 possible_cpu_arch_ids
Date: Thu,  2 Jan 2025 15:53:55 +0800
Message-Id: <20250102075357.2541410-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250102075357.2541410-1-maobibo@loongson.cn>
References: <20250102075357.2541410-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8cVRnZn0i8RAA--.16082S3
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

Supported CPU number can be acquired from function
possible_cpu_arch_ids(), cpu-num property is not necessary.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c                | 7 +++++++
 include/hw/intc/loongarch_extioi_common.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 4a1a7c357c..2ce2f83196 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -320,6 +320,9 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *id_list;
     Error *local_err = NULL;
     int i, pin;
 
@@ -347,6 +350,8 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
         s->status |= BIT(EXTIOI_ENABLE);
     }
 
+    id_list = mc->possible_cpu_arch_ids(machine);
+    s->num_cpu = id_list->len;
     s->cpu = g_new0(ExtIOICore, s->num_cpu);
     if (s->cpu == NULL) {
         error_setg(errp, "Memory allocation for ExtIOICore faile");
@@ -357,6 +362,8 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[pin], 1);
         }
+        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
+        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
     }
 }
 
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index f6bc778a85..22d7880977 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -65,6 +65,8 @@ typedef struct ExtIOICore {
     uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
     DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
     qemu_irq parent_irq[LS3A_INTC_IP];
+    uint64_t arch_id;
+    CPUState *cpu;
 } ExtIOICore;
 
 struct LoongArchExtIOICommonState {
-- 
2.39.3


