Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F1DC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6hF-0003qm-6y; Mon, 28 Sep 2026 04:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xB6h2-0003pz-J7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:26:38 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xB6h0-0000MV-HH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:26:36 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 5F252DFF9;
 Mon, 28 Sep 2026 13:56:28 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH] target/loongarch: delete CSR_OFF_FUNCS
Date: Mon, 28 Sep 2026 16:26:22 +0800
Message-ID: <20260928082622.110889-1-prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now csr helpers are set by SET_CSR_FUNC in trans_privileged.c.inc, so this
macro is unneeded.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 target/loongarch/csr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index d2ac39dee9..e4ad8a4618 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -6,21 +6,20 @@
 #include "cpu.h"
 #include "csr.h"
 
-#define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
-    [LOONGARCH_CSR_##NAME] = {                             \
-        .name   = (stringify(NAME)),                       \
-        .offset = CSR_OFFSET(CSR_##NAME),                  \
-        .flags = FL, .readfn = RD, .writefn = WR           \
+#define CSR_OFF_FLAGS(NAME, FL)                               \
+    [LOONGARCH_CSR_##NAME] = {                                \
+        .name   = (stringify(NAME)),                          \
+        .offset = CSR_OFFSET(CSR_##NAME),                     \
+        .flags = FL, .readfn = NULL, .writefn = NULL          \
     }
 
 #define CSR_OFF_ARRAY(NAME, N)                                \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
         .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
-        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
+        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
     }
 
-#define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
 #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
 
 static CSRInfo csr_info[] = {
-- 
2.55.0


