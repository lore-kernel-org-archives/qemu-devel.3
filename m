Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8045C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 03:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmP8o-00014R-5f; Sun, 23 Feb 2025 22:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmP8c-00011s-Bw
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:28:10 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmP8Z-0004Vg-D7
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 22:28:09 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvOI+57tnLl2AAA--.24741S3;
 Mon, 24 Feb 2025 11:27:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_MQ857tnVqMlAA--.6451S4;
 Mon, 24 Feb 2025 11:27:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	lixianglai <lixianglai@loongson.cn>
Subject: [PATCH v2 2/8] target/loongarch: Mov kvm specified vcpu property to
 kvm directory
Date: Mon, 24 Feb 2025 11:27:50 +0800
Message-Id: <20250224032756.809994-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250224032756.809994-1-maobibo@loongson.cn>
References: <20250224032756.809994-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MQ857tnVqMlAA--.6451S4
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

LBT and PMU feature is supported only in kvm mode, move property
about these two features to function kvm_loongarch_cpu_post_init().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c     | 40 ++------------------------------------
 target/loongarch/kvm/kvm.c | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 40f753167f..e1ff346bce 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -712,34 +712,12 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
 }
 
-static bool loongarch_get_lbt(Object *obj, Error **errp)
-{
-    return LOONGARCH_CPU(obj)->lbt != ON_OFF_AUTO_OFF;
-}
-
-static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-
-    cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
-}
-
-static bool loongarch_get_pmu(Object *obj, Error **errp)
-{
-    return LOONGARCH_CPU(obj)->pmu != ON_OFF_AUTO_OFF;
-}
-
-static void loongarch_set_pmu(Object *obj, bool value, Error **errp)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-
-    cpu->pmu = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
-}
-
 void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
+    cpu->lbt = ON_OFF_AUTO_OFF;
+    cpu->pmu = ON_OFF_AUTO_OFF;
     cpu->lsx = ON_OFF_AUTO_AUTO;
     cpu->lasx = ON_OFF_AUTO_AUTO;
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
@@ -748,21 +726,7 @@ void loongarch_cpu_post_init(Object *obj)
                              loongarch_set_lasx);
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
     if (kvm_enabled()) {
-        cpu->lbt = ON_OFF_AUTO_AUTO;
-        object_property_add_bool(obj, "lbt", loongarch_get_lbt,
-                                 loongarch_set_lbt);
-        object_property_set_description(obj, "lbt",
-                                   "Set off to disable Binary Tranlation.");
-
-        cpu->pmu = ON_OFF_AUTO_AUTO;
-        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
-                                 loongarch_set_pmu);
-        object_property_set_description(obj, "pmu",
-                                   "Set off to performance monitor unit.");
         kvm_loongarch_cpu_post_init(cpu);
-    } else {
-        cpu->lbt = ON_OFF_AUTO_OFF;
-        cpu->pmu = ON_OFF_AUTO_OFF;
     }
 }
 
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 516aba180f..cf15d58adf 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1009,8 +1009,43 @@ int kvm_arch_init_vcpu(CPUState *cs)
     return ret;
 }
 
+static bool loongarch_get_lbt(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lbt != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
+static bool loongarch_get_pmu(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->pmu != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_pmu(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->pmu = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
+    cpu->lbt = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(OBJECT(cpu), "lbt", loongarch_get_lbt,
+                             loongarch_set_lbt);
+    object_property_set_description(OBJECT(cpu), "lbt",
+                                   "Set off to disable Binary Tranlation.");
+
+    cpu->pmu = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(OBJECT(cpu), "pmu", loongarch_get_pmu,
+                             loongarch_set_pmu);
+    object_property_set_description(OBJECT(cpu), "pmu",
+                               "Set off to disable performance monitor unit.");
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
-- 
2.39.3


