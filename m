Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA8C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9z8-0001UI-07; Fri, 11 Jul 2025 05:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ua9xb-0000BI-Rg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:22:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ua9xR-0003rV-2M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:22:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxQK3E13BorR8nAQ--.51S3;
 Fri, 11 Jul 2025 17:22:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOS813Bo5owSAA--.39837S11;
 Fri, 11 Jul 2025 17:22:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v5 09/11] target/loongarch: CPU enable msg interrupts.
Date: Fri, 11 Jul 2025 16:59:13 +0800
Message-Id: <20250711085915.3042395-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250711085915.3042395-1-gaosong@loongson.cn>
References: <20250711085915.3042395-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOS813Bo5owSAA--.39837S11
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

when loongarch cpu set irq is INT_AVEC, we need set CSR_ESTAT.MSGINT bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h |  6 ++++--
 target/loongarch/cpu.c     | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 4792677086..6ec13d13d1 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -34,11 +34,13 @@ FIELD(CSR_MISC, ALCL, 12, 4)
 FIELD(CSR_MISC, DWPL, 16, 3)
 
 #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
-FIELD(CSR_ECFG, LIE, 0, 13)
+FIELD(CSR_ECFG, LIE, 0, 15)        /*bit 15 is msg interrupt enabled */
+FIELD(CSR_ECFG, MSGINT, 14, 1)
 FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
-FIELD(CSR_ESTAT, IS, 0, 13)
+FIELD(CSR_ESTAT, IS, 0, 15)        /*bit 15 is msg interrupt enabled */
+FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c054..9e21ed1d07 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -130,7 +130,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
+        /* do INTC_AVEC irqs */
+        if (irq == INT_AVEC) {
+            irq = find_first_bit(env->CSR_MSGIS, 256);
+            if (irq < 256) {
+                env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
+            }
+        } else {
+            env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
+        }
         if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         } else {
-- 
2.34.1


