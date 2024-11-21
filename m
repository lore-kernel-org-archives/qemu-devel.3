Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54CBD743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHx-0001fT-P9; Wed, 20 Nov 2024 20:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHu-0001dO-MO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHt-0004ZP-7S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=gOqbb409IemoDA9cXRKMqCB6ZUSy0Qk58RmK/jyokAM=; b=LQ28/UUF0fF3/ns
 UMioWfeToFvaoy2MSNVq5FSH6NXASrhNUrNy3f2kiAOfLXOB6pTSB0kroWBFiG9knggN1/iuBQwQ2
 S2EGXvo+uYlj6Rac5jrZj9VWFRavn1To83P/d9SFeBmLmeQsZsDwhRL87lWnVDifCI1ygWJ7oXeWj
 dI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 22/43] helper-to-tcg: PrepareForTcgPass,
 remove functions w. cycles
Date: Thu, 21 Nov 2024 02:49:26 +0100
Message-ID: <20241121014947.18666-23-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Functions with cycles are removed for two primary reasons:

  * as a simplifying assumption for register allocation which occurs down
    the line, and;

  * if a function contains cycles post-optimization neither unrolling or
    loop vectorization were beneficial, and the function _might_ be
    better suited as a helper anyway.

Cycles are detected by iterating over Strongly Connected Components
(SCCs) which imply the existence of cycles if:
  - a SCC contains more than one node, or;
  - it has a self-edge.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
index f0ef1abd17..ccbe3820a0 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -16,10 +16,42 @@
 //
 
 #include <PrepareForTcgPass.h>
+#include <llvm/ADT/SCCIterator.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
 
 using namespace llvm;
 
+static void removeFunctionsWithLoops(Module &M, ModuleAnalysisManager &MAM)
+{
+    // Iterate over all Strongly Connected Components (SCCs), a SCC implies
+    // the existence of loops if:
+    //   - it has more than one node, or;
+    //   - it has a self-edge.
+    SmallVector<Function *, 16> FunctionsToRemove;
+    for (Function &F : M) {
+        if (F.isDeclaration()) {
+            continue;
+        }
+        for (auto It = scc_begin(&F); !It.isAtEnd(); ++It) {
+#if LLVM_VERSION_MAJOR > 10
+            if (It.hasCycle()) {
+#else
+            if (It.hasLoop()) {
+#endif
+                FunctionsToRemove.push_back(&F);
+                break;
+            }
+        }
+    }
+
+    for (auto *F : FunctionsToRemove) {
+        F->deleteBody();
+    }
+}
+
 PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
 {
+    removeFunctionsWithLoops(M, MAM);
     return PreservedAnalyses::none();
 }
-- 
2.45.2


