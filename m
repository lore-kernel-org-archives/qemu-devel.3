Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875D6C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVUQ-0007yX-G0; Wed, 22 Jan 2025 02:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taVUJ-0007u5-C3
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taVUF-0002bf-Qe
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:49:23 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxC+L8opBnLxxnAA--.4797S3;
 Wed, 22 Jan 2025 15:49:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxYMb5opBneEIqAA--.26608S8;
 Wed, 22 Jan 2025 15:49:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] target/loongarch: Set unused flag with CSR registers
Date: Wed, 22 Jan 2025 15:49:12 +0800
Message-Id: <20250122074913.534050-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250122074913.534050-1-maobibo@loongson.cn>
References: <20250122074913.534050-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMb5opBneEIqAA--.26608S8
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

On LA464, some CSR registers are not used such as CSR_SAVE8 -
CSR_SAVE15, also CSR registers relative with MCE is not used now.

Flag CSRFL_UNUSED is added for these registers, so that it will
not dumped. In order to keep compatiblity, these CSR registers are
not removed since it is used in vmstate already.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 30 +++++++++++++++++++++++++++++-
 target/loongarch/csr.c | 13 +++++++++++++
 target/loongarch/csr.h |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index d611a60470..a744010332 100644
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
@@ -375,6 +375,33 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_DA_IDX;
 }
 
+static void loongarch_la464_init_csr(Object *obj)
+{
+#ifndef CONFIG_USER_ONLY
+    static bool initialized;
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    CPULoongArchState *env = &cpu->env;
+    int i, num;
+
+    if (!initialized) {
+        initialized = true;
+        num = FIELD_EX64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
+        for (i = num; i < 16; i++) {
+            set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
+        }
+        set_csr_flag(LOONGARCH_CSR_IMPCTL1, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_IMPCTL2, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRCTL, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRINFO1, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRINFO2, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRENTRY, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRERA, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_MERRSAVE, CSRFL_UNUSED);
+        set_csr_flag(LOONGARCH_CSR_CTAG, CSRFL_UNUSED);
+    }
+#endif
+}
+
 static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -470,6 +497,7 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
+    loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
 
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 62c1815bfb..87bd24e8cd 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -112,3 +112,16 @@ CSRInfo *get_csr(unsigned int csr_num)
 
     return csr;
 }
+
+bool set_csr_flag(unsigned int csr_num, int flag)
+{
+    CSRInfo *csr;
+
+    csr = get_csr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->flags |= flag;
+    return true;
+}
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index caad832545..deb1aacc33 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -13,6 +13,7 @@ enum {
     CSRFL_READONLY = (1 << 0),
     CSRFL_EXITTB   = (1 << 1),
     CSRFL_IO       = (1 << 2),
+    CSRFL_UNUSED   = (1 << 3),
 };
 
 typedef struct {
@@ -23,4 +24,5 @@ typedef struct {
 } CSRInfo;
 
 CSRInfo *get_csr(unsigned int csr_num);
+bool set_csr_flag(unsigned int csr_num, int flag);
 #endif /* TARGET_LOONGARCH_CSR_H */
-- 
2.39.3


