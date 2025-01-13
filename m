Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6928E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFmW-0002ng-09; Mon, 13 Jan 2025 03:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tXFly-0002OI-AH
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tXFlu-0002TI-FQ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:09 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxG+IZzoRnZ2tiAA--.61516S3;
 Mon, 13 Jan 2025 16:26:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx78cVzoRngBAgAA--.63355S7;
 Mon, 13 Jan 2025 16:26:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/loongarch: Dump all generic CSR registers
Date: Mon, 13 Jan 2025 16:25:57 +0800
Message-Id: <20250113082557.2926009-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250113082557.2926009-1-maobibo@loongson.cn>
References: <20250113082557.2926009-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx78cVzoRngBAgAA--.63355S7
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

CSR registers is import system control registers, it had better
dump all CSR registers when VM is running in system mode.

Here is dump output example of CSR registers:
 CSR000: CRMD b4 PRMD 4 EUEN 0 MISC 0
 CSR004: ECFG 71c3d ESTAT 0 ERA 9000000002e214c0 BADV 7ffff361401c
 CSR008: BADI 2b0000
 CSR012: EENTRY 9000000005680000
 CSR016: TLBIDX e0003c2 TLBEHI 7ffff3610000 TLBELO0 0 TLBELO1 40000001111d801f
 CSR024: ASID a00ce PGDL 9000000105f1c000 PGDH 9000000005650000 PGD 0
 CSR028: PWCL 5e56e PWCH 2e4 STLBPS e RVACFG 0
 CSR032: CPUID 0 PRCFG1 72f8 PRCFG2 3ffff000 PRCFG3 8073f2
 CSR048: SAVE0 0 SAVE1 1b504 SAVE2 7ffff34487a8 SAVE3 5e24000
 CSR052: SAVE4 0 SAVE5 0 SAVE6 0 SAVE7 0
 CSR056: SAVE8 0 SAVE9 0 SAVE10 0 SAVE11 0
 CSR060: SAVE12 0 SAVE13 0 SAVE14 0 SAVE15 0
 CSR064: TID 0 TCFG 50b06f5 TVAL 20ab7cf CNTC ffffffffce390f8f
 CSR068: TICLR 0
 CSR096: LLBCTL 1
 CSR128: IMPCTL1 0 IMPCTL2 0
 CSR136: TLBRENTRY 568a000 TLBRBADV ffff8000021143f8 TLBRERA 9000000003999930 TLBRSAVE 9000000101684a00
 CSR140: TLBRELO0 40 TLBRELO1 10942c053 TLBREHI ffff80000211400e TLBRPRMD 4
 CSR144: MERRCTL 0 MERRINFO1 0 MERRINFO2 0 MERRENTRY 0
 CSR148: MERRERA 0 MERRSAVE 0
 CSR152: CTAG 0
 CSR384: DMW0 8000000000000001 DMW1 9000000000000011 DMW2 a000000000000021 DMW3 0

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 58 +++++++++++++++++++++++++++++-------------
 target/loongarch/csr.c |  2 ++
 target/loongarch/csr.h |  1 +
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a60470..31ef82cfe8 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -19,7 +19,7 @@
 #include "cpu.h"
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
-#include "cpu-csr.h"
+#include "csr.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/reset.h"
 #endif
@@ -765,6 +765,44 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
+{
+#ifndef CONFIG_USER_ONLY
+    int i;
+    CSRInfo *csr_info;
+    CPULoongArchState *env = cpu_env(cs);
+    unsigned long *addr;
+    int col = 0;
+
+    qemu_fprintf(f, "\n");
+
+    /* Dump all generic CSR register */
+    for (i = 0; i < LOONGARCH_CSR_DBG; i++) {
+        csr_info = get_csr(i);
+        if (!csr_info) {
+            if (i == (col + 3)) {
+                qemu_fprintf(f, "\n");
+            }
+
+            continue;
+        }
+
+        if ((i >  (col + 3)) || (i == col)) {
+            col = i & ~3;
+            qemu_fprintf(f, " CSR%03d:", col);
+        }
+
+        addr = (void *)env + csr_info->offset;
+        qemu_fprintf(f, " %s %" PRIx64, csr_info->name, *addr);
+
+        if (i == (col + 3)) {
+            qemu_fprintf(f, "\n");
+        }
+    }
+    qemu_fprintf(f, "\n");
+#endif
+}
+
 static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -784,22 +822,8 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
     }
 
-    qemu_fprintf(f, "CRMD=%016" PRIx64 "\n", env->CSR_CRMD);
-    qemu_fprintf(f, "PRMD=%016" PRIx64 "\n", env->CSR_PRMD);
-    qemu_fprintf(f, "EUEN=%016" PRIx64 "\n", env->CSR_EUEN);
-    qemu_fprintf(f, "ESTAT=%016" PRIx64 "\n", env->CSR_ESTAT);
-    qemu_fprintf(f, "ERA=%016" PRIx64 "\n", env->CSR_ERA);
-    qemu_fprintf(f, "BADV=%016" PRIx64 "\n", env->CSR_BADV);
-    qemu_fprintf(f, "BADI=%016" PRIx64 "\n", env->CSR_BADI);
-    qemu_fprintf(f, "EENTRY=%016" PRIx64 "\n", env->CSR_EENTRY);
-    qemu_fprintf(f, "PRCFG1=%016" PRIx64 ", PRCFG2=%016" PRIx64 ","
-                 " PRCFG3=%016" PRIx64 "\n",
-                 env->CSR_PRCFG1, env->CSR_PRCFG2, env->CSR_PRCFG3);
-    qemu_fprintf(f, "TLBRENTRY=%016" PRIx64 "\n", env->CSR_TLBRENTRY);
-    qemu_fprintf(f, "TLBRBADV=%016" PRIx64 "\n", env->CSR_TLBRBADV);
-    qemu_fprintf(f, "TLBRERA=%016" PRIx64 "\n", env->CSR_TLBRERA);
-    qemu_fprintf(f, "TCFG=%016" PRIx64 "\n", env->CSR_TCFG);
-    qemu_fprintf(f, "TVAL=%016" PRIx64 "\n", env->CSR_TVAL);
+    /* csr */
+    loongarch_cpu_dump_csr(cs, f);
 
     /* fpr */
     if (flags & CPU_DUMP_FPU) {
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 62c1815bfb..8ad6448c69 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -9,12 +9,14 @@
 
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
+        .name   = (stringify(NAME)),                       \
         .offset = offsetof(CPULoongArchState, CSR_##NAME), \
         .flags = FL, .readfn = RD, .writefn = WR           \
     }
 
 #define CSR_OFF_ARRAY(NAME, N)                                \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
+        .name   = (stringify(NAME##N)),                       \
         .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
         .flags = 0, .readfn = NULL, .writefn = NULL           \
     }
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index d32a607975..fba48258c8 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -26,6 +26,7 @@ enum {
 };
 
 typedef struct {
+    const char *name;
     int offset;
     int flags;
     GenCSRRead readfn;
-- 
2.39.3


