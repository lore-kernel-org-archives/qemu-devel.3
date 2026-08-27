Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF33C61DBE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzPED-00025u-B5; Wed, 26 Aug 2026 21:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wzPEB-00025H-8f
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wzPE8-0007pO-5c
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 21:48:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxTtNil49qgIYFAA--.15336S3;
 Thu, 27 Aug 2026 09:48:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCx+c1dl49q1KwTAA--.16714S4;
 Thu, 27 Aug 2026 09:48:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/3] hw/loongarch/virt: Add bootargs and initrd to device-tree
Date: Thu, 27 Aug 2026 09:28:10 +0800
Message-Id: <20260827012811.1008381-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260827012811.1008381-1-gaosong@loongson.cn>
References: <20260827012811.1008381-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c1dl49q1KwTAA--.16714S4
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Add bootarg and initrd information in fdt tree.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260807070029.1171348-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/virt-fdt-build.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 6c06b36fca..c6f5d022c5 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -25,6 +25,7 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
     uint8_t rng_seed[32];
+    int ret;
 
     ms->fdt = create_device_tree(&lvms->fdt_size);
     if (!ms->fdt) {
@@ -39,6 +40,32 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
     qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
     qemu_fdt_add_subnode(ms->fdt, "/chosen");
 
+    if (ms->kernel_cmdline && *ms->kernel_cmdline) {
+        ret = qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs",
+                                      ms->kernel_cmdline);
+        if (ret < 0) {
+            error_report("set /chosen/bootargs failed");
+            exit(1);
+        }
+    }
+
+    if (lvms->bootinfo.initrd_addr) {
+        ret = qemu_fdt_setprop_cell(ms->fdt, "/chosen", "linux,initrd-start",
+                                    lvms->bootinfo.initrd_addr);
+        if (ret < 0) {
+            error_report("set /chosen/linux,initrd-start failed");
+            exit(1);
+        }
+
+        ret = qemu_fdt_setprop_cell(ms->fdt, "/chosen", "linux,initrd-end",
+                                    lvms->bootinfo.initrd_addr +
+                                    lvms->bootinfo.initrd_size);
+        if (ret < 0) {
+            error_report("set /chosen/linux,initrd-end failed");
+            exit(1);
+        }
+    }
+
     /* Pass seed to RNG */
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_seed));
-- 
2.55.0


