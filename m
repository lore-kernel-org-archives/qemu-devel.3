Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE05E77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 03:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUzxJ-00058h-9G; Mon, 06 Jan 2025 22:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tUzxH-00057e-N8
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tUzxF-0004cl-F2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 22:08:31 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxCeGlmnxnU_heAA--.55603S3;
 Tue, 07 Jan 2025 11:08:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxfcejmnxnn2gXAA--.35275S4;
 Tue, 07 Jan 2025 11:08:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] hw/intc/loongson_ipi: Remove num_cpu from
 loongson_ipi_common
Date: Tue,  7 Jan 2025 11:08:14 +0800
Message-Id: <20250107030819.90442-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250107030819.90442-1-maobibo@loongson.cn>
References: <20250107030819.90442-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxfcejmnxnn2gXAA--.35275S4
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

With mips64 loongson ipi, num_cpu property is used, with loongarch
ipi, num_cpu can be acquired from possible_cpu_arch_ids.

Here remove num_cpu setting from loongson_ipi_common, and this piece
of code is put into loongson ipi and loongarch ipi.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c       | 13 +++++++++++++
 hw/intc/loongson_ipi.c        | 14 +++++++++++++-
 hw/intc/loongson_ipi_common.c | 14 --------------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 4e2f9acddf..e6126e4fbc 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -52,14 +52,27 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
 
 static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
+    LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(dev);
     LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
     Error *local_err = NULL;
+    int i;
 
     lic->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
+
+    if (lics->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    lics->cpu = g_new0(IPICore, lics->num_cpu);
+    for (i = 0; i < lics->num_cpu; i++) {
+        lics->cpu[i].ipi = lics;
+        qdev_init_gpio_out(dev, &lics->cpu[i].irq, 1);
+    }
 }
 
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 4e08f03510..1ed39b90ea 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -36,6 +36,7 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
     LoongsonIPIClass *lic = LOONGSON_IPI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
+    int i;
 
     lic->parent_realize(dev, &local_err);
     if (local_err) {
@@ -43,8 +44,19 @@ static void loongson_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (sc->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    sc->cpu = g_new0(IPICore, sc->num_cpu);
+    for (i = 0; i < sc->num_cpu; i++) {
+        sc->cpu[i].ipi = sc;
+        qdev_init_gpio_out(dev, &sc->cpu[i].irq, 1);
+    }
+
     s->ipi_mmio_mem = g_new0(MemoryRegion, sc->num_cpu);
-    for (unsigned i = 0; i < sc->num_cpu; i++) {
+    for (i = 0; i < sc->num_cpu; i++) {
         g_autofree char *name = g_strdup_printf("loongson_ipi_cpu%d_mmio", i);
 
         memory_region_init_io(&s->ipi_mmio_mem[i], OBJECT(dev),
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index 9a081565f5..5d46679ea1 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -10,7 +10,6 @@
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "qapi/error.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -253,12 +252,6 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
 
     memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
                           &loongson_ipi_iocsr_ops,
@@ -273,13 +266,6 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
                           &loongson_ipi64_ops,
                           s, "loongson_ipi64_iocsr", 0x118);
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    for (i = 0; i < s->num_cpu; i++) {
-        s->cpu[i].ipi = s;
-
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
-    }
 }
 
 static void loongson_ipi_common_unrealize(DeviceState *dev)
-- 
2.39.3


