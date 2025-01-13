Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E52E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFmK-0002ae-8S; Mon, 13 Jan 2025 03:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tXFly-0002OP-Fg
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:12 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tXFlu-0002Ss-Ei
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:26:10 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_64XzoRnZGtiAA--.22870S3;
 Mon, 13 Jan 2025 16:25:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx78cVzoRngBAgAA--.63355S5;
 Mon, 13 Jan 2025 16:25:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/5] target/loongarch: Add common header file for CSR register
Date: Mon, 13 Jan 2025 16:25:55 +0800
Message-Id: <20250113082557.2926009-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250113082557.2926009-1-maobibo@loongson.cn>
References: <20250113082557.2926009-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx78cVzoRngBAgAA--.63355S5
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

Common header file csr.h is added here, it can be used by both
TCG mode and kvm mode.

Macro CONFIG_TCG is used for TCG specific CSR function because
of  function parameter such as TCGv and TCGv_ptr.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/csr.h                        | 35 +++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc     | 18 +---------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 target/loongarch/csr.h

diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
new file mode 100644
index 0000000000..b0e51d51cd
--- /dev/null
+++ b/target/loongarch/csr.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef TARGET_LOONGARCH_CSR_H
+#define TARGET_LOONGARCH_CSR_H
+
+#include "cpu-csr.h"
+#ifdef CONFIG_TCG
+#include "tcg/tcg-op.h"
+#endif
+
+#ifdef CONFIG_TCG
+typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
+typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
+#else
+typedef void (*GenCSRRead)(void);
+typedef void (*GenCSRWrite)(void);
+#endif
+
+enum {
+    CSRFL_READONLY = (1 << 0),
+    CSRFL_EXITTB   = (1 << 1),
+    CSRFL_IO       = (1 << 2),
+};
+
+typedef struct {
+    int offset;
+    int flags;
+    GenCSRRead readfn;
+    GenCSRWrite writefn;
+} CSRInfo;
+
+#endif /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 2dfba3af76..34a7ca39fd 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -5,7 +5,7 @@
  * LoongArch translation routines for the privileged instructions.
  */
 
-#include "cpu-csr.h"
+#include "csr.h"
 
 #ifdef CONFIG_USER_ONLY
 
@@ -42,22 +42,6 @@ GEN_FALSE_TRANS(idle)
 
 #else
 
-typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
-typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
-
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
-- 
2.39.3


