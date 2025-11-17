Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F6FCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuON-0006su-Cl; Mon, 17 Nov 2025 03:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vKuOB-0006pX-Oo
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:15:08 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vKuO8-0002J4-4Y
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:15:06 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxidF82RppSFokAA--.13111S3;
 Mon, 17 Nov 2025 16:14:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxaMB62RppsNY1AQ--.61669S2;
 Mon, 17 Nov 2025 16:14:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 1/1] target/loongarch: Fix some exception need't update
 CSR_BADV
Date: Mon, 17 Nov 2025 15:50:42 +0800
Message-Id: <20251117075042.1831667-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxaMB62RppsNY1AQ--.61669S2
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

According to Volume 1 Manual 7.4.8, certain exceptions require setting CSR_BADV,
but the code does not match.this patch correct it. and the exception PIL,PIS,PIF,
PME,PNR, PNX, PPI already update on raise_mmu_exception(),these are need't update.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tcg/tcg_cpu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 9d077c56d9..7f94c183c4 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -109,10 +109,22 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         }
         QEMU_FALLTHROUGH;
     case EXCCODE_PIF:
-    case EXCCODE_ADEF:
         cause = cs->exception_index;
         update_badinstr = 0;
         break;
+    case EXCCODE_ADEF:
+        update_badinstr = 0;
+        QEMU_FALLTHROUGH;
+    case EXCCODE_BCE:
+    case EXCCODE_ADEM:
+        env->CSR_BADV = env->pc;
+        QEMU_FALLTHROUGH;
+    case EXCCODE_PNR:
+    case EXCCODE_PNX:
+    case EXCCODE_PPI:
+    case EXCCODE_PIL:
+    case EXCCODE_PIS:
+    case EXCCODE_PME:
     case EXCCODE_SYS:
     case EXCCODE_BRK:
     case EXCCODE_INE:
@@ -121,16 +133,6 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     case EXCCODE_FPE:
     case EXCCODE_SXD:
     case EXCCODE_ASXD:
-        env->CSR_BADV = env->pc;
-        QEMU_FALLTHROUGH;
-    case EXCCODE_BCE:
-    case EXCCODE_ADEM:
-    case EXCCODE_PIL:
-    case EXCCODE_PIS:
-    case EXCCODE_PME:
-    case EXCCODE_PNR:
-    case EXCCODE_PNX:
-    case EXCCODE_PPI:
         cause = cs->exception_index;
         break;
     default:
-- 
2.51.0


