Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFC7C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVUK-0007vP-Nx; Wed, 22 Jan 2025 02:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taVUI-0007sU-3d
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taVUF-0002br-O8
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:21 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxquD9opBnMRxnAA--.5422S3;
 Wed, 22 Jan 2025 15:49:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxYMb5opBneEIqAA--.26608S9;
 Wed, 22 Jan 2025 15:49:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] target/loongarch: Dump all generic CSR registers
Date: Wed, 22 Jan 2025 15:49:13 +0800
Message-Id: <20250122074913.534050-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250122074913.534050-1-maobibo@loongson.cn>
References: <20250122074913.534050-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMb5opBneEIqAA--.26608S9
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

CSR registers is import system control registers, it had better
dump all CSR registers when VM is running in system mode.

Here is dump output example of CSR registers:
 CSR000: CRMD   b4               PRMD   4                EUEN   0                MISC   0
 CSR004: ECFG   71c1c            ESTAT  0                ERA    9000000002c31300 BADV   12022c0e0
 CSR008: BADI   2b0000
 CSR012: EENTRY 90000000046b0000
 CSR016: TLBIDX ffffffff8e000228 TLBEHI 120228000        TLBELO0 400000016f19001f TLBELO1 400000016f1a401f
 CSR024: ASID   a0004            PGDL   90000001016f0000 PGDH   9000000004680000 PGD    0
 CSR028: PWCL   5e56e            PWCH   2e4              STLBPS e                RVACFG 0
 CSR032: CPUID  0                PRCFG1 72f8             PRCFG2 3ffff000         PRCFG3 8073f2
 CSR048: SAVE0  0                SAVE1  af9c             SAVE2  12010d6a8        SAVE3  8300000
 CSR052: SAVE4  0                SAVE5  0                SAVE6  0                SAVE7  0
 CSR064: TID    0                TCFG   8f0ca15          TVAL   4cefd8b          CNTC   fffffffffe688aaa
 CSR068: TICLR  0
 CSR096: LLBCTL 1
 CSR136: TLBRENTRY 46ba000       TLBRBADV ffff8000130d81e2 TLBRERA 9000000003585cb8 TLBRSAVE ffff8000130d81e0
 CSR140: TLBRELO0 1fe00043       TLBRELO1 40             TLBREHI ffff8000130d800e TLBRPRMD 0
 CSR384: DMW0   8000000000000001 DMW1   9000000000000011 DMW2   0                DMW3   0

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 65 +++++++++++++++++++++++++++++++-----------
 target/loongarch/csr.c |  2 ++
 target/loongarch/csr.h |  1 +
 3 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a744010332..bf498ae691 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -793,6 +793,53 @@ static ObjectClass *loongarch_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
+{
+#ifndef CONFIG_USER_ONLY
+    CPULoongArchState *env = cpu_env(cs);
+    CSRInfo *csr_info;
+    int64_t *addr;
+    int i, j, len, col = 0;
+
+    qemu_fprintf(f, "\n");
+
+    /* Dump all generic CSR register */
+    for (i = 0; i < LOONGARCH_CSR_DBG; i++) {
+        csr_info = get_csr(i);
+        if (!csr_info || (csr_info->flags & CSRFL_UNUSED)) {
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
+        len = strlen(csr_info->name);
+        for (len < 6; len++) {
+            qemu_fprintf(f, " ");
+        }
+
+        j = find_last_bit((void *)addr, BITS_PER_LONG) & (BITS_PER_LONG - 1);
+        len +=  j / 4 + 1;
+        for (len < 22; len++) {
+                qemu_fprintf(f, " ");
+        }
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
@@ -812,22 +859,8 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
index 87bd24e8cd..7ea0a30450 100644
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
index deb1aacc33..81a656baae 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -17,6 +17,7 @@ enum {
 };
 
 typedef struct {
+    const char *name;
     int offset;
     int flags;
     GenCSRFunc readfn;
-- 
2.39.3


