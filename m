Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE58C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6k-0003gH-Hh; Wed, 29 Jul 2026 23:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6g-0003OF-KA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:52 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6d-0002wV-9b
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=B+tS5VBIr0cK4rOug74NF63kx8YZ4luM84qgVcRBTkM=; b=TzpwxNls2pCws2b
 2EsanPOCvSLc2gJYh6NPZB5vyecCJYgXoR/a1VK4VsTXKDtj9rXUK9q9K10y0u9sP3Vt7i4M0SEvJ
 ux9v9OVIFUmHWXchXF4pna+D1RFz1nVT0N+ST8JsaQu7xqOACSUGIPC5P8hMu8dDAlkJuXpdk9PgQ
 54=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 24/50] helper-to-tcg: PrepareForTcgPass, demote PHI nodes
Date: Thu, 30 Jul 2026 05:09:58 +0200
Message-ID: <20260730031025.12926-25-anjo@rev.ng>
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

PHI nodes have no clear analogue in TCG, this commits converts them to
stack accesses using a built-in LLVM transformation.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
index 41f317ed0b..d8530406ad 100644
--- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -20,7 +20,10 @@
 #include <llvm/ADT/SCCIterator.h>
 #include <llvm/ADT/SmallPtrSet.h>
 #include <llvm/IR/Function.h>
+#include <llvm/IR/InstIterator.h>
+#include <llvm/IR/Instructions.h>
 #include <llvm/IR/Module.h>
+#include <llvm/Transforms/Utils/Local.h>
 
 using namespace llvm;
 
@@ -48,8 +51,28 @@ static void removeFunctionsWithLoops(Module &M, ModuleAnalysisManager &MAM) {
     }
 }
 
+inline void demotePhis(Function &F) {
+    if (F.isDeclaration()) {
+        return;
+    }
+
+    SmallVector<PHINode *, 10> Phis;
+    for (auto &I : instructions(F)) {
+        if (auto *Phi = dyn_cast<PHINode>(&I)) {
+            Phis.push_back(Phi);
+        }
+    }
+
+    for (auto *Phi : Phis) {
+        DemotePHIToStack(Phi);
+    }
+}
+
 PreservedAnalyses PrepareForTcgPass::run(Module &M,
                                          ModuleAnalysisManager &MAM) {
     removeFunctionsWithLoops(M, MAM);
+    for (Function &F : M) {
+        demotePhis(F);
+    }
     return PreservedAnalyses::none();
 }
-- 
2.52.0


