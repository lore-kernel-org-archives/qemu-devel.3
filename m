Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0407DC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7f-0005FR-Dv; Wed, 29 Jul 2026 23:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7R-0004kD-Go
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7P-00032p-7B
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Zv7NYeayKikcDdOY1xslOcV3UWVEL8WWqscoRbqh03E=; b=VL3XO2k8WZr7Bwl
 3Ik2y+Kn5RLXh+I1BjN+Gjc9eZKE3fRTD1SWGLeJ2bpRXWIClPNDDDn9tPUDklhXhVXejjnNA+J8k
 rbsjefw8NXQotKU8tYImepWKdITD6RhD+RUvaq8zKvOHWLZC9DO/ad9CvIuhy2Jvd6vx0BLZf9Ydw
 fk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 47/50] target/hexagon: Use helper-to-tcg helper calls
Date: Thu, 30 Jul 2026 05:10:21 +0200
Message-ID: <20260730031025.12926-48-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replaces the default "helper-gen.h" header with those provided by
helper-to-tcg.  `gen_helper_*()` definitions are generated for all
helpers in the input module, regardless of whether they successfully
translated or not.  The generated `gen_helper_*()` calls into either
`emit_*()` or `tcg_gen_callN` depending on whether translation of that
helper was successful or not.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/genptr.c    | 4 ++++
 target/hexagon/helper.h    | 8 ++++++++
 target/hexagon/translate.c | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 5acf237bf0..d99580e815 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -20,7 +20,11 @@
 #include "internal.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#if defined(TARGET_HELPER_TO_TCG)
+#include "helper-to-tcg-emitted.h"
+#else
 #include "exec/helper-gen.h"
+#endif
 #include "insn.h"
 #include "opcodes.h"
 #include "sys_macros.h"
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 74d5b7ffe8..1796ef7144 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -133,3 +133,11 @@ DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
 DEF_HELPER_1(pending_interrupt, void, env)
 #endif
+
+/*
+ * Include generated helper-to-tcg support helpers, but not during IR
+ * generation since they won't have been emitted at that point.
+ */
+#if defined(TARGET_HELPER_TO_TCG) && !defined(HELPER_TO_TCG_IR_GEN)
+# include "helper-to-tcg-support-helpers.h"
+#endif
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 870475010b..ab6e100a38 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -20,7 +20,15 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+/*
+ * Include generated gen_helper_*() definitions if using helper-to-tcg, but
+ * only when not generating input IR since the header won't exist at that point.
+ */
+#if defined(TARGET_HELPER_TO_TCG) && !defined(HELPER_TO_TCG_IR_GEN)
+#include "helper-to-tcg-emitted.h"
+#else
 #include "exec/helper-gen.h"
+#endif
 #include "exec/helper-proto.h"
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ldst.h"
-- 
2.52.0


