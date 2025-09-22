Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72478CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0b43-0005wH-Jf; Mon, 22 Sep 2025 03:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v0b42-0005w3-Nu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v0b3w-0007Ng-BO
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:34:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjr_v+9BoERwNAA--.26633S3;
 Mon, 22 Sep 2025 15:34:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocLo+9Bo5wulAA--.64540S5;
 Mon, 22 Sep 2025 15:34:06 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/loongarch: Set file tcg_cpu.c separate from cpu.c
Date: Mon, 22 Sep 2025 15:33:58 +0800
Message-Id: <20250922073400.1308169-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250922073400.1308169-1-maobibo@loongson.cn>
References: <20250922073400.1308169-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocLo+9Bo5wulAA--.64540S5
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

Remove inline included with file tcg_cpu.c, and set it separate
with file target/loongarch/cpu.c

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c               |  9 ---------
 target/loongarch/tcg/meson.build     |  1 +
 target/loongarch/tcg/tcg_cpu.c       | 13 ++++++++++++-
 target/loongarch/tcg/tcg_loongarch.h |  1 +
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 6eb8c3214a..b449ede56d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -28,11 +28,6 @@
 #ifdef CONFIG_KVM
 #include <linux/kvm.h>
 #endif
-#ifdef CONFIG_TCG
-#include "accel/tcg/cpu-ldst.h"
-#include "accel/tcg/cpu-ops.h"
-#include "tcg/tcg.h"
-#endif
 #include "tcg/tcg_loongarch.h"
 
 const char * const regnames[32] = {
@@ -653,10 +648,6 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 }
 
-#ifdef CONFIG_TCG
-#include "tcg/tcg_cpu.c"
-#endif /* CONFIG_TCG */
-
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
diff --git a/target/loongarch/tcg/meson.build b/target/loongarch/tcg/meson.build
index bdf34f9673..b7adfe46f1 100644
--- a/target/loongarch/tcg/meson.build
+++ b/target/loongarch/tcg/meson.build
@@ -7,6 +7,7 @@ loongarch_ss.add([zlib, gen])
 loongarch_ss.add(files(
   'fpu_helper.c',
   'op_helper.c',
+  'tcg_cpu.c',
   'translate.c',
   'vec_helper.c',
 ))
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index f09a695968..c7f49838e3 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -4,6 +4,17 @@
  *
  * Copyright (c) 2025 Loongson Technology Corporation Limited
  */
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ops.h"
+#include "exec/translation-block.h"
+#include "exec/target_page.h"
+#include "tcg_loongarch.h"
+#include "internals.h"
 
 #ifndef CONFIG_USER_ONLY
 static void loongarch_cpu_do_interrupt(CPUState *cs)
@@ -232,7 +243,7 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_DA_IDX;
 }
 
-static const TCGCPUOps loongarch_tcg_ops = {
+const TCGCPUOps loongarch_tcg_ops = {
     .guest_default_memory_order = 0,
     .mttcg_supported = true,
 
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 47702893e3..7fb627f2d6 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -9,6 +9,7 @@
 #include "cpu.h"
 #include "cpu-mmu.h"
 
+extern const TCGCPUOps loongarch_tcg_ops;
 void loongarch_csr_translate_init(void);
 
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.39.3


