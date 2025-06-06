Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E60C5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQbr-000786-Bw; Fri, 06 Jun 2025 02:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uNQbf-00072S-84
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:31:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uNQbc-0007Rm-Hu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:31:10 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bxlmkqi0JoPr8NAQ--.38702S3;
 Fri, 06 Jun 2025 14:31:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxu8QNi0JoJcYMAQ--.37752S12;
 Fri, 06 Jun 2025 14:31:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v3 10/13] hw/loongarch/virt: Add reset support for kernel
 irqchip
Date: Fri,  6 Jun 2025 14:30:30 +0800
Message-Id: <20250606063033.2557365-11-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250606063033.2557365-1-maobibo@loongson.cn>
References: <20250606063033.2557365-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8QNi0JoJcYMAQ--.37752S12
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

When system reboot, interrupt controller is restored to initial
state. However if interrupt controller extioi/ipi/pch_pic is
emulated in kernel, it should notify kvm to do so. Here suspend
and restore API is used for reset, set initial state in qemu user
space and restore API is used to notify kvm to reload register
state.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c     | 4 ++++
 hw/intc/loongarch_extioi_kvm.c | 4 ++++
 hw/intc/loongarch_ipi.c        | 4 ++++
 hw/intc/loongarch_ipi_kvm.c    | 4 ++++
 hw/intc/loongarch_pch_pic.c    | 4 ++++
 hw/intc/loongarch_pic_kvm.c    | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 7be0685f36..8b8ac6b187 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -391,6 +391,10 @@ static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
     if (lec->parent_phases.hold) {
         lec->parent_phases.hold(obj, type);
     }
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_extioi_put(obj, 0);
+    }
 }
 
 static int vmstate_extioi_pre_save(void *opaque)
diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index f4c618ca4c..0133540c45 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -94,6 +94,10 @@ int kvm_extioi_put(void *opaque, int version_id)
     LoongArchExtIOIState *les = LOONGARCH_EXTIOI(opaque);
     int fd = les->dev_fd;
 
+    if (fd == 0) {
+        return 0;
+    }
+
     kvm_extioi_access_regs(opaque, true);
     kvm_extioi_access_sw_status(opaque, true);
     kvm_device_access(fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 0ea91ea054..fc8005c944 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -122,6 +122,10 @@ static void loongarch_ipi_reset_hold(Object *obj, ResetType type)
         core->clear = 0;
         memset(core->buf, 0, sizeof(core->buf));
     }
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_ipi_put(obj, 0);
+    }
 }
 
 static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
index b615060d83..4cb3acc921 100644
--- a/hw/intc/loongarch_ipi_kvm.c
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -25,6 +25,10 @@ static void kvm_ipi_access_regs(void *opaque, bool write)
     uint64_t attr;
     int cpu, fd = lis->dev_fd;
 
+    if (fd == 0) {
+        return;
+    }
+
     for (cpu = 0; cpu < ipi->num_cpu; cpu++) {
         core = &ipi->cpu[cpu];
         attr = (cpu << 16) | CORE_STATUS_OFF;
diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 75448ffa6b..4f6a22b3be 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -264,6 +264,10 @@ static void loongarch_pic_reset_hold(Object *obj, ResetType type)
     if (lpc->parent_phases.hold) {
         lpc->parent_phases.hold(obj, type);
     }
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_pic_put(obj, 0);
+    }
 }
 
 static void loongarch_pic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
index 3eef81a9bb..dd504ec6a6 100644
--- a/hw/intc/loongarch_pic_kvm.c
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -26,6 +26,10 @@ static void kvm_pch_pic_access(void *opaque, bool write)
     int fd = lps->dev_fd;
     int addr, offset;
 
+    if (fd == 0) {
+        return;
+    }
+
     kvm_pch_pic_access_reg(fd, PCH_PIC_INT_MASK, &s->int_mask, write);
     kvm_pch_pic_access_reg(fd, PCH_PIC_HTMSI_EN, &s->htmsi_en, write);
     kvm_pch_pic_access_reg(fd, PCH_PIC_INT_EDGE, &s->intedge, write);
-- 
2.39.3


