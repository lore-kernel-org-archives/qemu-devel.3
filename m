Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73400C71157
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 03:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5Yc-00076i-UT; Wed, 18 Jun 2025 23:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5Yb-00076Y-LX
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YZ-0006CZ-Pc
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxbKzufVNozo4ZAQ--.58680S3;
 Thu, 19 Jun 2025 11:03:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S10;
 Thu, 19 Jun 2025 11:03:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 8/9] target/loongarch: CSR_ESTAT enable msg interrupts.
Date: Thu, 19 Jun 2025 10:39:43 +0800
Message-Id: <20250619023944.1278716-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S10
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

when loongarch cpu set irq is INT_AVEC, we need set CSR_ESTAT.MSGINT bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h | 1 +
 target/loongarch/cpu.c     | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..83f6cb081a 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -39,6 +39,7 @@ FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
 FIELD(CSR_ESTAT, IS, 0, 13)
+FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index bde9f917fc..28b23743f9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -127,6 +127,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
+    /* do INTC_AVEC irqs */
+    if (irq == INT_AVEC) {
+        for (int i = 256; i >= 0; i--) {
+            if (test_bit(i, &(env->CSR_MSGIS[i / 64]))) {
+                env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
+            }
+        }
+    }
+
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-- 
2.34.1


