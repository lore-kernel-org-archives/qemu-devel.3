Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3850BD743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHy-0001fi-8T; Wed, 20 Nov 2024 20:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHw-0001ew-EE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:20 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHu-0004Zh-Hk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=hmTEpHQ0w/eNIbQgvG5tMvX+8YZQnrFZvWmxaOfG/ek=; b=ecK28upZ/txRPoV
 +Ga3BDq7rsdIKfNmW/G3+py6rd1LS0HY6gIjPwCUyqbjjFU0hksgoEATQ7EXCO70oXjeXP6DcOLzi
 sfb24opEcntdzF3nvgLO0oBks3r5lrE23XmbE1X3tnTD13xa9JJEnQ2ID9U/uaVDLerRwT5fYHGJn
 gs=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 24/43] helper-to-tcg: PrepareForTcgPass, map TCG globals
Date: Thu, 21 Nov 2024 02:49:28 +0100
Message-ID: <20241121014947.18666-25-anjo@rev.ng>
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

The input LLVM module may define an array of cpu_mapping structs,
describing the mapping between fields in a specified struct (usually
CPUArchState) and TCG globals.

Create a map between offsets into the specified struct and TCG globals
(name, size, number of elements, stride) by iterating over the global
cpu_mapping array.  The name of this array is configurable via
the --tcg-global-mappings flag.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/PrepareForTcgPass.h |  7 ++-
 .../helper-to-tcg/include/TcgGlobalMap.h      | 31 +++++++++++++
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 43 +++++++++++++++++++
 .../helper-to-tcg/pipeline/Pipeline.cpp       |  9 ++--
 4 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.h

diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.h b/subprojects/helper-to-tcg/include/PrepareForTcgPass.h
index a41edb4c2e..a731c70b4b 100644
--- a/subprojects/helper-to-tcg/include/PrepareForTcgPass.h
+++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.h
@@ -17,11 +17,16 @@
 
 #pragma once
 
+#include "TcgGlobalMap.h"
 #include <llvm/IR/PassManager.h>
 
 class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
+    TcgGlobalMap &ResultTcgGlobalMap;
 public:
-    PrepareForTcgPass() {}
+    PrepareForTcgPass(TcgGlobalMap &ResultTcgGlobalMap)
+        : ResultTcgGlobalMap(ResultTcgGlobalMap)
+    {
+    }
     llvm::PreservedAnalyses run(llvm::Module &M,
                                 llvm::ModuleAnalysisManager &MAM);
 };
diff --git a/subprojects/helper-to-tcg/include/TcgGlobalMap.h b/subprojects/helper-to-tcg/include/TcgGlobalMap.h
new file mode 100644
index 0000000000..7186d805ba
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/TcgGlobalMap.h
@@ -0,0 +1,31 @@
+#pragma once
+
+//
+//  Copyright(c) 2024 rev.ng Labs Srl. All Rights Reserved.
+//
+//  This program is free software; you can redistribute it and/or modify
+//  it under the terms of the GNU General Public License as published by
+//  the Free Software Foundation; either version 2 of the License, or
+//  (at your option) any later version.
+//
+//  This program is distributed in the hope that it will be useful,
+//  but WITHOUT ANY WARRANTY; without even the implied warranty of
+//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+//  GNU General Public License for more details.
+//
+//  You should have received a copy of the GNU General Public License
+//  along with this program; if not, see <http://www.gnu.org/licenses/>.
+//
+
+#include <llvm/ADT/StringRef.h>
+#include <llvm/ADT/DenseMap.h>
+#include <stdint.h>
+
+struct TcgGlobal {
+  llvm::StringRef Code;
+  uint64_t Size;
+  uint64_t NumElements;
+  uint64_t Stride;
+};
+
+using TcgGlobalMap = llvm::DenseMap<uint32_t, TcgGlobal>;
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
index a2808eafed..a453aa8558 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -15,6 +15,7 @@
 //  along with this program; if not, see <http://www.gnu.org/licenses/>.
 //
 
+#include <CmdLineOptions.h>
 #include <PrepareForTcgPass.h>
 #include <llvm/ADT/SCCIterator.h>
 #include <llvm/IR/Function.h>
@@ -71,11 +72,53 @@ inline void demotePhis(Function &F)
     }
 }
 
+static void collectTcgGlobals(Module &M, TcgGlobalMap &ResultTcgGlobalMap)
+{
+    auto *Map = M.getGlobalVariable(TcgGlobalMappingsName);
+    if (!Map) {
+        return;
+    }
+
+    // In case the `tcg_global_mappings` array is empty,
+    // casting to `ConstantArray` will fail, even though it's a
+    // `[0 x %struct.cpu_tcg_mapping]`.
+    auto *MapElems = dyn_cast<ConstantArray>(Map->getOperand(0));
+    if (!MapElems) {
+        return;
+    }
+
+    for (auto Row : MapElems->operand_values()) {
+        auto *ConstRow = cast<ConstantStruct>(Row);
+
+        // Get code string
+        auto *CodePtr = ConstRow->getOperand(0);
+        auto CodeStr =
+            cast<ConstantDataArray>(
+                cast<Constant>(CodePtr->getOperand(0))->getOperand(0))
+                ->getAsString();
+        CodeStr = CodeStr.rtrim('\0');
+
+        // Get offset in cpu env
+        auto *Offset = cast<ConstantInt>(ConstRow->getOperand(3));
+        // Get size of variable in cpu env
+        auto *SizeInBytes = cast<ConstantInt>(ConstRow->getOperand(4));
+        unsigned SizeInBits = 8 * SizeInBytes->getLimitedValue();
+
+        auto *Stride = cast<ConstantInt>(ConstRow->getOperand(5));
+        auto *NumElements = cast<ConstantInt>(ConstRow->getOperand(6));
+
+        ResultTcgGlobalMap[Offset->getLimitedValue()] = {
+            CodeStr, SizeInBits, NumElements->getLimitedValue(),
+            Stride->getLimitedValue()};
+    }
+}
+
 PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
 {
     removeFunctionsWithLoops(M, MAM);
     for (Function &F : M) {
         demotePhis(F);
     }
+    collectTcgGlobals(M, ResultTcgGlobalMap);
     return PreservedAnalyses::none();
 }
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index 7d03389439..a8df592af3 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -58,9 +58,9 @@ cl::opt<bool> TranslateAllHelpers(
 // Options for PrepareForTcgPass
 cl::opt<std::string> TcgGlobalMappingsName(
     "tcg-global-mappings",
-    cl::desc("<Name of global cpu_mappings[] used for mapping accesses"
-             "into a struct to TCG globals>"),
-    cl::Required, cl::cat(Cat));
+    cl::desc("Name of global cpu_mappings[] used for mapping accesses"
+             "into a struct to TCG globals"),
+    cl::init("mappings"), cl::cat(Cat));
 
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
@@ -216,7 +216,8 @@ int main(int argc, char **argv)
     // easily to TCG.
     //
 
-    MPM.addPass(PrepareForTcgPass());
+    TcgGlobalMap TcgGlobals;
+    MPM.addPass(PrepareForTcgPass(TcgGlobals));
     MPM.addPass(VerifierPass());
     {
         FunctionPassManager FPM;
-- 
2.45.2


