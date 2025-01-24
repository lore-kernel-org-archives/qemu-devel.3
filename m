Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C26C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 07:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbDgG-0005vs-CB; Fri, 24 Jan 2025 02:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tbDgC-0005tx-DG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tbDg8-00083k-J4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 02:00:35 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxC+KIOpNnIShoAA--.6701S3;
 Fri, 24 Jan 2025 15:00:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eGOpNnM2ksAA--.32130S3;
 Fri, 24 Jan 2025 15:00:23 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 1/7] target/loongarch: Add dynamic function access with CSR
 register
Date: Fri, 24 Jan 2025 15:00:15 +0800
Message-Id: <20250124070021.800907-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250124070021.800907-1-maobibo@loongson.cn>
References: <20250124070021.800907-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eGOpNnM2ksAA--.32130S3
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

With CSR register, dynamic function access is used for CSR register
access in TCG mode, so that csr info can be used by other modules.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc     | 37 +++++++++++++++++--
 target/loongarch/tcg/tcg_loongarch.h          | 12 ++++++
 target/loongarch/tcg/translate.c              |  5 +++
 3 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 target/loongarch/tcg/tcg_loongarch.h

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 30f9b83fb2..96958bd6c1 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -76,7 +76,7 @@ enum {
 #define CSR_OFF(NAME) \
     CSR_OFF_FLAGS(NAME, 0)
 
-static const CSRInfo csr_info[] = {
+static CSRInfo csr_info[] = {
     CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
     CSR_OFF(PRMD),
     CSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
@@ -160,9 +160,9 @@ static bool check_plv(DisasContext *ctx)
     return false;
 }
 
-static const CSRInfo *get_csr(unsigned csr_num)
+static CSRInfo *get_csr(unsigned csr_num)
 {
-    const CSRInfo *csr;
+    CSRInfo *csr;
 
     if (csr_num >= ARRAY_SIZE(csr_info)) {
         return NULL;
@@ -174,6 +174,37 @@ static const CSRInfo *get_csr(unsigned csr_num)
     return csr;
 }
 
+static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
+                               GenCSRWrite writefn)
+{
+    CSRInfo *csr;
+
+    csr = get_csr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->readfn = readfn;
+    csr->writefn = writefn;
+    return true;
+}
+
+#define SET_CSR_FUNC(NAME, read, write)                 \
+        set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
+
+void loongarch_csr_translate_init(void)
+{
+    SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
+    SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
+    SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
+    SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr_pwcl);
+    SET_CSR_FUNC(CPUID, gen_helper_csrrd_cpuid, NULL);
+    SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
+    SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
+    SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
+}
+#undef SET_CSR_FUNC
+
 static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
 {
     if ((csr->flags & CSRFL_READONLY) && write) {
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
new file mode 100644
index 0000000000..da2539e995
--- /dev/null
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch TCG interface
+ *
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+#ifndef TARGET_LOONGARCH_TCG_LOONGARCH_H
+#define TARGET_LOONGARCH_TCG_LOONGARCH_H
+
+void loongarch_csr_translate_init(void);
+
+#endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 68be999410..3480f54c71 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -16,6 +16,7 @@
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 #include "fpu/softfloat.h"
+#include "tcg_loongarch.h"
 #include "translate.h"
 #include "internals.h"
 #include "vec.h"
@@ -358,4 +359,8 @@ void loongarch_translate_init(void)
                     offsetof(CPULoongArchState, lladdr), "lladdr");
     cpu_llval = tcg_global_mem_new(tcg_env,
                     offsetof(CPULoongArchState, llval), "llval");
+
+#ifndef CONFIG_USER_ONLY
+    loongarch_csr_translate_init();
+#endif
 }
-- 
2.43.5


