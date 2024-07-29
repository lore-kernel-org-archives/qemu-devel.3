Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C3C49EA1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 01:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYFdg-0004ze-46; Sun, 28 Jul 2024 21:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sYFdX-0004qt-BG
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:57:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sYFdS-0002Tw-7g
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 21:57:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxSurx9qZmfVQDAA--.11834S3;
 Mon, 29 Jul 2024 09:57:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBx4MXu9qZm1AIEAA--.19410S3;
 Mon, 29 Jul 2024 09:57:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn,
	philmd@linaro.org
Subject: [PATCH 1/5] target/loongarch: Add a new cpu_type la664
Date: Mon, 29 Jul 2024 09:39:35 +0800
Message-Id: <20240729013939.1807982-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240729013939.1807982-1-gaosong@loongson.cn>
References: <20240729013939.1807982-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx4MXu9qZm1AIEAA--.19410S3
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

Add a new LoongArch cpu type la664. The la664 has many new features,
such as new atomic instructions, hardware page table walk, etc.
We will implement them later.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 48 +++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5e85b9dbef..1b975f1de8 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -374,20 +374,11 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_DA_IDX;
 }
 
-static void loongarch_la464_initfn(Object *obj)
+static void loongarch_common_initfn(CPULoongArchState *env, Object *obj)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    CPULoongArchState *env = &cpu->env;
-    int i;
-
-    for (i = 0; i < 21; i++) {
-        env->cpucfg[i] = 0x0;
-    }
-
-    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
-    env->cpucfg[0] = 0x14c010;  /* PRID */
+    uint32_t data;
 
-    uint32_t data = 0;
+    data = 0;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
@@ -472,6 +463,38 @@ static void loongarch_la464_initfn(Object *obj)
     loongarch_cpu_post_init(obj);
 }
 
+static void loongarch_la664_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,Loongson-3A6000";
+    env->cpucfg[0] = 0x14d000; /* PRID */
+
+    loongarch_common_initfn(env, obj);
+}
+
+static void loongarch_la464_initfn(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+    int i;
+
+    for (i = 0; i < 21; i++) {
+        env->cpucfg[i] = 0x0;
+    }
+
+    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
+    env->cpucfg[0] = 0x14c010;  /* PRID */
+
+    loongarch_common_initfn(env, obj);
+}
+
 static void loongarch_la132_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -857,6 +880,7 @@ static const TypeInfo loongarch_cpu_type_infos[] = {
         .abstract = true,
         .class_init = loongarch64_cpu_class_init,
     },
+    DEFINE_LOONGARCH_CPU_TYPE(64, "la664", loongarch_la664_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
     DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
-- 
2.33.0


