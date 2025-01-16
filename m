Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52558C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO5b-0007g9-3U; Thu, 16 Jan 2025 06:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYO5E-0007dc-Ak
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYO59-0005ML-Qc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:44 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuHa7Yhn0GBkAA--.5574S3;
 Thu, 16 Jan 2025 19:30:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxfcXZ7YhneOQkAA--.11212S6;
 Thu, 16 Jan 2025 19:30:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] target/loongarch: Add common source file for CSR
 register
Date: Thu, 16 Jan 2025 19:30:30 +0800
Message-Id: <20250116113032.599899-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116113032.599899-1-maobibo@loongson.cn>
References: <20250116113032.599899-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcXZ7YhneOQkAA--.11212S6
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Common source file csr.c is added here, it can be used by both
TCG mode and kvm mode. The common code is removed from file
tcg/insn_trans/trans_privileged.c.inc to csrc.c

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.c                        | 114 ++++++++++++++++++
 target/loongarch/csr.h                        |   1 +
 target/loongarch/meson.build                  |   1 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 107 ----------------
 4 files changed, 116 insertions(+), 107 deletions(-)
 create mode 100644 target/loongarch/csr.c

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
new file mode 100644
index 0000000000..62c1815bfb
--- /dev/null
+++ b/target/loongarch/csr.c
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+#include <stddef.h>
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "csr.h"
+
+#define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
+    [LOONGARCH_CSR_##NAME] = {                             \
+        .offset = offsetof(CPULoongArchState, CSR_##NAME), \
+        .flags = FL, .readfn = RD, .writefn = WR           \
+    }
+
+#define CSR_OFF_ARRAY(NAME, N)                                \
+    [LOONGARCH_CSR_##NAME(N)] = {                             \
+        .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
+        .flags = 0, .readfn = NULL, .writefn = NULL           \
+    }
+
+#define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
+#define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, 0)
+
+static CSRInfo csr_info[] = {
+    CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
+    CSR_OFF(PRMD),
+    CSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
+    CSR_OFF_FLAGS(MISC, CSRFL_READONLY),
+    CSR_OFF(ECFG),
+    CSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
+    CSR_OFF(ERA),
+    CSR_OFF(BADV),
+    CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
+    CSR_OFF(EENTRY),
+    CSR_OFF(TLBIDX),
+    CSR_OFF(TLBEHI),
+    CSR_OFF(TLBELO0),
+    CSR_OFF(TLBELO1),
+    CSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
+    CSR_OFF(PGDL),
+    CSR_OFF(PGDH),
+    CSR_OFF_FLAGS(PGD, CSRFL_READONLY),
+    CSR_OFF(PWCL),
+    CSR_OFF(PWCH),
+    CSR_OFF(STLBPS),
+    CSR_OFF(RVACFG),
+    CSR_OFF_FLAGS(CPUID, CSRFL_READONLY),
+    CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
+    CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
+    CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
+    CSR_OFF_ARRAY(SAVE, 0),
+    CSR_OFF_ARRAY(SAVE, 1),
+    CSR_OFF_ARRAY(SAVE, 2),
+    CSR_OFF_ARRAY(SAVE, 3),
+    CSR_OFF_ARRAY(SAVE, 4),
+    CSR_OFF_ARRAY(SAVE, 5),
+    CSR_OFF_ARRAY(SAVE, 6),
+    CSR_OFF_ARRAY(SAVE, 7),
+    CSR_OFF_ARRAY(SAVE, 8),
+    CSR_OFF_ARRAY(SAVE, 9),
+    CSR_OFF_ARRAY(SAVE, 10),
+    CSR_OFF_ARRAY(SAVE, 11),
+    CSR_OFF_ARRAY(SAVE, 12),
+    CSR_OFF_ARRAY(SAVE, 13),
+    CSR_OFF_ARRAY(SAVE, 14),
+    CSR_OFF_ARRAY(SAVE, 15),
+    CSR_OFF(TID),
+    CSR_OFF_FLAGS(TCFG, CSRFL_IO),
+    CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
+    CSR_OFF(CNTC),
+    CSR_OFF_FLAGS(TICLR, CSRFL_IO),
+    CSR_OFF(LLBCTL),
+    CSR_OFF(IMPCTL1),
+    CSR_OFF(IMPCTL2),
+    CSR_OFF(TLBRENTRY),
+    CSR_OFF(TLBRBADV),
+    CSR_OFF(TLBRERA),
+    CSR_OFF(TLBRSAVE),
+    CSR_OFF(TLBRELO0),
+    CSR_OFF(TLBRELO1),
+    CSR_OFF(TLBREHI),
+    CSR_OFF(TLBRPRMD),
+    CSR_OFF(MERRCTL),
+    CSR_OFF(MERRINFO1),
+    CSR_OFF(MERRINFO2),
+    CSR_OFF(MERRENTRY),
+    CSR_OFF(MERRERA),
+    CSR_OFF(MERRSAVE),
+    CSR_OFF(CTAG),
+    CSR_OFF_ARRAY(DMW, 0),
+    CSR_OFF_ARRAY(DMW, 1),
+    CSR_OFF_ARRAY(DMW, 2),
+    CSR_OFF_ARRAY(DMW, 3),
+    CSR_OFF(DBG),
+    CSR_OFF(DERA),
+    CSR_OFF(DSAVE),
+};
+
+CSRInfo *get_csr(unsigned int csr_num)
+{
+    CSRInfo *csr;
+
+    if (csr_num >= ARRAY_SIZE(csr_info)) {
+        return NULL;
+    }
+
+    csr = &csr_info[csr_num];
+    if (csr->offset == 0) {
+        return NULL;
+    }
+
+    return csr;
+}
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 20d4bf5dc7..caad832545 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -22,4 +22,5 @@ typedef struct {
     GenCSRFunc writefn;
 } CSRInfo;
 
+CSRInfo *get_csr(unsigned int csr_num);
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index 7817318287..20bd3e2f0a 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -10,6 +10,7 @@ loongarch_system_ss = ss.source_set()
 loongarch_system_ss.add(files(
   'arch_dump.c',
   'cpu_helper.c',
+  'csr.c',
   'loongarch-qmp-cmds.c',
   'machine.c',
 ))
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 87506ec0dc..3afa23af79 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -45,99 +45,6 @@ GEN_FALSE_TRANS(idle)
 typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
 typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
 
-#define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
-    [LOONGARCH_CSR_##NAME] = {                             \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME), \
-        .flags = FL, .readfn = RD, .writefn = WR           \
-    }
-
-#define CSR_OFF_ARRAY(NAME, N)                                \
-    [LOONGARCH_CSR_##NAME(N)] = {                             \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
-        .flags = 0, .readfn = NULL, .writefn = NULL           \
-    }
-
-#define CSR_OFF_FLAGS(NAME, FL) \
-    CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
-
-#define CSR_OFF(NAME) \
-    CSR_OFF_FLAGS(NAME, 0)
-
-static CSRInfo csr_info[] = {
-    CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
-    CSR_OFF(PRMD),
-    CSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
-    CSR_OFF_FLAGS(MISC, CSRFL_READONLY),
-    CSR_OFF(ECFG),
-    CSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
-    CSR_OFF(ERA),
-    CSR_OFF(BADV),
-    CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
-    CSR_OFF(EENTRY),
-    CSR_OFF(TLBIDX),
-    CSR_OFF(TLBEHI),
-    CSR_OFF(TLBELO0),
-    CSR_OFF(TLBELO1),
-    CSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
-    CSR_OFF(PGDL),
-    CSR_OFF(PGDH),
-    CSR_OFF_FLAGS(PGD, CSRFL_READONLY),
-    CSR_OFF(PWCL),
-    CSR_OFF(PWCH),
-    CSR_OFF(STLBPS),
-    CSR_OFF(RVACFG),
-    CSR_OFF_FLAGS(CPUID, CSRFL_READONLY),
-    CSR_OFF_FLAGS(PRCFG1, CSRFL_READONLY),
-    CSR_OFF_FLAGS(PRCFG2, CSRFL_READONLY),
-    CSR_OFF_FLAGS(PRCFG3, CSRFL_READONLY),
-    CSR_OFF_ARRAY(SAVE, 0),
-    CSR_OFF_ARRAY(SAVE, 1),
-    CSR_OFF_ARRAY(SAVE, 2),
-    CSR_OFF_ARRAY(SAVE, 3),
-    CSR_OFF_ARRAY(SAVE, 4),
-    CSR_OFF_ARRAY(SAVE, 5),
-    CSR_OFF_ARRAY(SAVE, 6),
-    CSR_OFF_ARRAY(SAVE, 7),
-    CSR_OFF_ARRAY(SAVE, 8),
-    CSR_OFF_ARRAY(SAVE, 9),
-    CSR_OFF_ARRAY(SAVE, 10),
-    CSR_OFF_ARRAY(SAVE, 11),
-    CSR_OFF_ARRAY(SAVE, 12),
-    CSR_OFF_ARRAY(SAVE, 13),
-    CSR_OFF_ARRAY(SAVE, 14),
-    CSR_OFF_ARRAY(SAVE, 15),
-    CSR_OFF(TID),
-    CSR_OFF_FLAGS(TCFG, CSRFL_IO),
-    CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
-    CSR_OFF(CNTC),
-    CSR_OFF_FLAGS(TICLR, CSRFL_IO),
-    CSR_OFF(LLBCTL),
-    CSR_OFF(IMPCTL1),
-    CSR_OFF(IMPCTL2),
-    CSR_OFF(TLBRENTRY),
-    CSR_OFF(TLBRBADV),
-    CSR_OFF(TLBRERA),
-    CSR_OFF(TLBRSAVE),
-    CSR_OFF(TLBRELO0),
-    CSR_OFF(TLBRELO1),
-    CSR_OFF(TLBREHI),
-    CSR_OFF(TLBRPRMD),
-    CSR_OFF(MERRCTL),
-    CSR_OFF(MERRINFO1),
-    CSR_OFF(MERRINFO2),
-    CSR_OFF(MERRENTRY),
-    CSR_OFF(MERRERA),
-    CSR_OFF(MERRSAVE),
-    CSR_OFF(CTAG),
-    CSR_OFF_ARRAY(DMW, 0),
-    CSR_OFF_ARRAY(DMW, 1),
-    CSR_OFF_ARRAY(DMW, 2),
-    CSR_OFF_ARRAY(DMW, 3),
-    CSR_OFF(DBG),
-    CSR_OFF(DERA),
-    CSR_OFF(DSAVE),
-};
-
 static bool check_plv(DisasContext *ctx)
 {
     if (ctx->plv == MMU_PLV_USER) {
@@ -147,20 +54,6 @@ static bool check_plv(DisasContext *ctx)
     return false;
 }
 
-static CSRInfo *get_csr(unsigned csr_num)
-{
-    CSRInfo *csr;
-
-    if (csr_num >= ARRAY_SIZE(csr_info)) {
-        return NULL;
-    }
-    csr = &csr_info[csr_num];
-    if (csr->offset == 0) {
-        return NULL;
-    }
-    return csr;
-}
-
 static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
                                GenCSRWrite writefn)
 {
-- 
2.39.3


