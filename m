Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8F7C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaPN-0005CV-Do; Mon, 09 Jun 2025 07:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOaPJ-0005C6-RN
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOaPH-00075e-49
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:13 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxCeFJwUZoYW4RAQ--.3066S3;
 Mon, 09 Jun 2025 19:11:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxtFwUZoiU0SAQ--.4222S12;
 Mon, 09 Jun 2025 19:11:05 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 10/10] target/loongarch: cpu do interrupt support msg
 interrupt.
Date: Mon,  9 Jun 2025 18:48:33 +0800
Message-Id: <20250609104833.839811-11-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250609104833.839811-1-gaosong@loongson.cn>
References: <20250609104833.839811-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtFwUZoiU0SAQ--.4222S12
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

we use CSR_ESTAT and CSR_ECFG bit 15 for msg interrupt.
and loongarch_cpu_do_interrupt support msg interrupts.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h |  3 ++-
 target/loongarch/cpu.c     | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 83f6cb081a..5a00cf3366 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -35,11 +35,12 @@ FIELD(CSR_MISC, DWPL, 16, 3)
 
 #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
 FIELD(CSR_ECFG, LIE, 0, 13)
+FIELD(CSR_ECFG, MSGINT, 14, 1)      /* used for msg */
 FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
 FIELD(CSR_ESTAT, IS, 0, 13)
-FIELD(CSR_ESTAT, MSGINT, 14, 1)
+FIELD(CSR_ESTAT, MSGINT, 14, 1)    /* used for msg */
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 207d11266f..b92463101e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -117,6 +117,13 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
 #include "hw/loongarch/virt.h"
 
+static uint32_t loongarch_cpu_has_interrupt(CPULoongArchState *env)
+{
+    uint32_t ret = 0;
+    ret = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
+    ret |= FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, MSGINT);
+    return ret;
+}
 void loongarch_cpu_set_irq(void *opaque, int irq, int level)
 {
     LoongArchCPU *cpu = opaque;
@@ -134,21 +141,20 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
                 env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, i);
                 env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 0);
                 env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
-                cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+                env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 1);
                 clear_bit(i, &(env->CSR_MSGIS[i / 64]));
             }
         }
     } else {
        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
-       env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 1);
-       return;
+       env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
     }
 
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
         env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+        if (loongarch_cpu_has_interrupt(env)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         } else {
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -166,12 +172,24 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
     return ret;
 }
 
+static inline bool cpu_loongarch_hw_interrupt_msg_pending(CPULoongArchState *env)
+{
+    bool pending_msg = 0;
+    bool status_msg = 0;
+
+    pending_msg = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, MSGINT);
+    status_msg = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, MSGINT);
+
+    return (pending_msg & status_msg) != 0;
+}
 /* Check if there is pending and not masked out interrupt */
 static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
-
+    if (cpu_loongarch_hw_interrupt_msg_pending(env)) {
+        return true;
+    }
     pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
     status  = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
 
@@ -285,6 +303,13 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         uint32_t vector = 0;
         uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
         pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+        if (cpu_loongarch_hw_interrupt_msg_pending(env)) {
+            env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 0);
+            env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 0);
+            set_pc(env, env->CSR_EENTRY + \
+                   (EXCCODE_EXTERNAL_INT + INT_AVEC) * vec_size);
+            return;
+        }
 
         /* Find the highest-priority interrupt. */
         vector = 31 - clz32(pending);
-- 
2.34.1


