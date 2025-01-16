Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69ABC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO5U-0007dv-Li; Thu, 16 Jan 2025 06:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYO5D-0007d2-Nm
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:43 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYO59-0005MI-QT
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:30:42 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_67a7YhnzmBkAA--.26610S3;
 Thu, 16 Jan 2025 19:30:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxfcXZ7YhneOQkAA--.11212S5;
 Thu, 16 Jan 2025 19:30:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] target/loongarch: Add common header file for CSR
 register
Date: Thu, 16 Jan 2025 19:30:29 +0800
Message-Id: <20250116113032.599899-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116113032.599899-1-maobibo@loongson.cn>
References: <20250116113032.599899-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxfcXZ7YhneOQkAA--.11212S5
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

Common header file csr.h is added here, it can be used by both
TCG mode and kvm mode.

Macro CONFIG_TCG is used for TCG specific CSR function because
of  function parameter such as TCGv and TCGv_ptr.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.h                        | 25 +++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     | 37 ++++++++-----------
 2 files changed, 40 insertions(+), 22 deletions(-)
 create mode 100644 target/loongarch/csr.h

diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
new file mode 100644
index 0000000000..20d4bf5dc7
--- /dev/null
+++ b/target/loongarch/csr.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef TARGET_LOONGARCH_CSR_H
+#define TARGET_LOONGARCH_CSR_H
+
+#include "cpu-csr.h"
+
+typedef void (*GenCSRFunc)(void);
+enum {
+    CSRFL_READONLY = (1 << 0),
+    CSRFL_EXITTB   = (1 << 1),
+    CSRFL_IO       = (1 << 2),
+};
+
+typedef struct {
+    int offset;
+    int flags;
+    GenCSRFunc readfn;
+    GenCSRFunc writefn;
+} CSRInfo;
+
+#endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index b90e14cd2a..87506ec0dc 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -5,7 +5,7 @@
  * LoongArch translation routines for the privileged instructions.
  */
 
-#include "cpu-csr.h"
+#include "csr.h"
 
 #ifdef CONFIG_USER_ONLY
 
@@ -45,19 +45,6 @@ GEN_FALSE_TRANS(idle)
 typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
 typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
 
-typedef struct {
-    int offset;
-    int flags;
-    GenCSRRead readfn;
-    GenCSRWrite writefn;
-} CSRInfo;
-
-enum {
-    CSRFL_READONLY = (1 << 0),
-    CSRFL_EXITTB   = (1 << 1),
-    CSRFL_IO       = (1 << 2),
-};
-
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
         .offset = offsetof(CPULoongArchState, CSR_##NAME), \
@@ -184,8 +171,8 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
         return false;
     }
 
-    csr->readfn = readfn;
-    csr->writefn = writefn;
+    csr->readfn = (GenCSRFunc)readfn;
+    csr->writefn = (GenCSRFunc)writefn;
     return true;
 }
 
@@ -222,6 +209,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
 {
     TCGv dest;
     const CSRInfo *csr;
+    GenCSRRead readfn;
 
     if (check_plv(ctx)) {
         return false;
@@ -233,8 +221,9 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
     } else {
         check_csr_flags(ctx, csr, false);
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        if (csr->readfn) {
-            csr->readfn(dest, tcg_env);
+        readfn = (GenCSRRead)csr->readfn;
+        if (readfn) {
+            readfn(dest, tcg_env);
         } else {
             tcg_gen_ld_tl(dest, tcg_env, csr->offset);
         }
@@ -247,6 +236,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
 {
     TCGv dest, src1;
     const CSRInfo *csr;
+    GenCSRWrite writefn;
 
     if (check_plv(ctx)) {
         return false;
@@ -262,9 +252,10 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
         return false;
     }
     src1 = gpr_src(ctx, a->rd, EXT_NONE);
-    if (csr->writefn) {
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
         dest = gpr_dst(ctx, a->rd, EXT_NONE);
-        csr->writefn(dest, tcg_env, src1);
+        writefn(dest, tcg_env, src1);
     } else {
         dest = tcg_temp_new();
         tcg_gen_ld_tl(dest, tcg_env, csr->offset);
@@ -278,6 +269,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
 {
     TCGv src1, mask, oldv, newv, temp;
     const CSRInfo *csr;
+    GenCSRWrite writefn;
 
     if (check_plv(ctx)) {
         return false;
@@ -308,8 +300,9 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     tcg_gen_andc_tl(temp, oldv, mask);
     tcg_gen_or_tl(newv, newv, temp);
 
-    if (csr->writefn) {
-        csr->writefn(oldv, tcg_env, newv);
+    writefn = (GenCSRWrite)csr->writefn;
+    if (writefn) {
+        writefn(oldv, tcg_env, newv);
     } else {
         tcg_gen_st_tl(newv, tcg_env, csr->offset);
     }
-- 
2.39.3


