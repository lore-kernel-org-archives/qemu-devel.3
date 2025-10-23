Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF40CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlMc-0007jt-Ph; Wed, 22 Oct 2025 22:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBlMX-0007j9-Rn
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBlMU-0006XX-Sa
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxP_A_l_loTZcZAA--.55004S3;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxmcA+l_lo4ysCAQ--.19467S4;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/loongarch: Add PMU register dump support in KVM
 mode
Date: Thu, 23 Oct 2025 10:47:25 +0800
Message-Id: <20251023024726.2995960-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251023024726.2995960-1-maobibo@loongson.cn>
References: <20251023024726.2995960-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxmcA+l_lo4ysCAQ--.19467S4
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

PMU is supported in KVM mode. With info registers command, PMU CSR
registers should be dumped also. And it is not necessary in TCG mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 14 +++++++++++++-
 target/loongarch/csr.c |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 86490e0f72..deb7b0bcb9 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -129,6 +129,17 @@ static void loongarch_la464_init_csr(Object *obj)
         set_csr_flag(LOONGARCH_CSR_MERRERA, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_MERRSAVE, CSRFL_UNUSED);
         set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
+
+        if (cpu->pmu != ON_OFF_AUTO_ON) {
+            set_csr_flag(LOONGARCH_CSR_PERFCTRL0, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCNTR0, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCTRL1, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCNTR1, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCTRL2, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCNTR2, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCTRL3, CSRFL_UNUSED);
+            set_csr_flag(LOONGARCH_CSR_PERFCNTR3, CSRFL_UNUSED);
+        }
     }
 #endif
 }
@@ -346,8 +357,9 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
     cpu->msgint = ON_OFF_AUTO_OFF;
-    loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
+    /* Some features with OnOffAuto type is detected after cpu_post_init */
+    loongarch_la464_init_csr(obj);
 }
 
 static void loongarch_la132_initfn(Object *obj)
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index f973780bba..8574e5bc0a 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -94,6 +94,14 @@ static CSRInfo csr_info[] = {
     CSR_OFF_ARRAY(DMW, 1),
     CSR_OFF_ARRAY(DMW, 2),
     CSR_OFF_ARRAY(DMW, 3),
+    CSR_OFF(PERFCTRL0),
+    CSR_OFF(PERFCNTR0),
+    CSR_OFF(PERFCTRL1),
+    CSR_OFF(PERFCNTR1),
+    CSR_OFF(PERFCTRL2),
+    CSR_OFF(PERFCNTR2),
+    CSR_OFF(PERFCTRL3),
+    CSR_OFF(PERFCNTR3),
     CSR_OFF(DBG),
     CSR_OFF(DERA),
     CSR_OFF(DSAVE),
-- 
2.39.3


