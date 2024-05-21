Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C733CC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KVb-000196-VM; Tue, 21 May 2024 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s9KVZ-000180-UZ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s9KVW-0001hG-Kl
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxeeriVUxm7jECAA--.1765S3;
 Tue, 21 May 2024 16:05:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxRcXdVUxm6O8DAA--.1310S4; 
 Tue, 21 May 2024 16:05:53 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/loongarch: Add loongson binary translation feature
Date: Tue, 21 May 2024 16:05:49 +0800
Message-Id: <20240521080549.434197-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240521080549.434197-1-maobibo@loongson.cn>
References: <20240521080549.434197-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxRcXdVUxm6O8DAA--.1310S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

Loongson Binary Translation (LBT) is used to accelerate binary
translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
eflags (eflags) and x87 fpu stack pointer (ftop).

Now LBT feature is added in kvm mode, not supported in TCG mode since
it is not emulated. And only LBT feature is added here, LBT register
saving and restoring is not supported since it depeeds on LBT feautre
implemented in KVM kernel.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                | 32 +++++++++++++++++++++++++++
 target/loongarch/cpu.h                |  1 +
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b5c1ec94af..84254c0f42 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -412,6 +412,9 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
     data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
     data = FIELD_DP32(data, CPUCFG2, LAM, 1);
+    if (kvm_enabled()) {
+        data = FIELD_DP32(data, CPUCFG2, LBT_ALL, 7);
+    }
     env->cpucfg[2] = data;
 
     env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
@@ -643,12 +646,41 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_lbt(Object *obj, Error **errp)
+ {
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    bool ret;
+
+    ret = false;
+    /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (kvm_enabled() &&
+        (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LBT_ALL) == 7)) {
+        ret = true;
+     }
+    return ret;
+}
+
+static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    int lbt;
+
+    lbt = 0;
+    if (kvm_enabled() && value) {
+        /* Enable binary translation for all architectures */
+        lbt = 7;
+    }
+    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LBT_ALL, lbt);
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
+    object_property_add_bool(obj, "lbt", loongarch_get_lbt,
+                             loongarch_set_lbt);
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 41b8e6d96d..2021e85303 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -152,6 +152,7 @@ FIELD(CPUCFG2, LLFTP_VER, 15, 3)
 FIELD(CPUCFG2, LBT_X86, 18, 1)
 FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
+FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..c6f6e1ef85 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", NULL
+    "lsx", "lasx", "lbt", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.39.3


