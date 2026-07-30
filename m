Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F03C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6o-0003oI-Sc; Wed, 29 Jul 2026 23:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6i-0003Pl-DQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:52 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6f-0002wj-Af
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Wm8+yoau+DLBWo1+flB1+I3tcw4dSaa40HqLRuhRzfg=; b=CK3PAdywvx1i036
 Ql3i5R5QnbXpn8oKSK+05aGGxUeLsm0v4qKIvjsJ5sgBdR/JgDDZ2oQhbTqF9OpTGvqlSNkB4jBPv
 k47v+2kn9RFUePX8meJKXW9NIm/mMflCHHbRGqLccTttqHmJ/E6WIbSMIkyGeoVAC9G4Hjfw/kmCo
 m4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 25/50] helper-to-tcg: PrepareForTcgPass, map TCG globals
Date: Thu, 30 Jul 2026 05:09:59 +0200
Message-ID: <20260730031025.12926-26-anjo@rev.ng>
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

The input LLVM module may define an array of cpu_mapping structs,
describing the mapping between fields in a specified struct (usually
CPUArchState) and TCG globals.

Create a map between offsets into the specified struct and TCG globals
(name, size, number of elements, stride) by iterating over the global
cpu_mapping array.  The name of this array is configurable via
the --tcg-global-mappings flag.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../include/PrepareForTcgPass.hpp             |  6 +-
 .../helper-to-tcg/include/TcgGlobalMap.hpp    | 40 ++++++++++++
 subprojects/helper-to-tcg/src/Pipeline.cpp    |  9 +--
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 62 +++++++++++++++++++
 4 files changed, 112 insertions(+), 5 deletions(-)
 create mode 100644 subprojects/helper-to-tcg/include/TcgGlobalMap.hpp

diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
index 90bc9402cb..3e0679b46c 100644
--- a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
+++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
@@ -17,11 +17,15 @@
 
 #pragma once
 
+#include "TcgGlobalMap.hpp"
 #include <llvm/IR/PassManager.h>
 
 class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
+    TcgGlobalMap &ResultTcgGlobalMap;
+
 public:
-    PrepareForTcgPass() {}
+    PrepareForTcgPass(TcgGlobalMap &ResultTcgGlobalMap)
+        : ResultTcgGlobalMap(ResultTcgGlobalMap) {}
     llvm::PreservedAnalyses run(llvm::Module &M,
                                 llvm::ModuleAnalysisManager &MAM);
 };
diff --git a/subprojects/helper-to-tcg/include/TcgGlobalMap.hpp b/subprojects/helper-to-tcg/include/TcgGlobalMap.hpp
new file mode 100644
index 0000000000..ad7ac54608
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/TcgGlobalMap.hpp
@@ -0,0 +1,40 @@
+#pragma once
+
+//
+//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
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
+#include <llvm/ADT/DenseMap.h>
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/ADT/StringRef.h>
+#include <stdint.h>
+
+// `TcgGlobal` describes a field in a struct which has a mapping to a TCG
+// global.  `Size`, `NumElements`, and `Stride` describe the mapped type, all
+// types are assumed to be integer or arrays of integers.  `Code` is the
+// expression to be emitted when accessing the mapped global, usually the
+// variable name.
+struct TcgGlobal {
+    llvm::StringRef Code;
+    uint64_t Size;
+    uint64_t NumElements;
+    uint64_t Stride;
+};
+
+// Array of maps between offsets into a mapped struct to the resulting global
+// type, outer array is indexed by the base struct type to handle multiple
+// struct-to-global mappings.
+using TcgGlobalMap = llvm::SmallVector<llvm::DenseMap<uint32_t, TcgGlobal>, 1>;
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index 6058718a9c..f24bb67f0c 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -76,9 +76,9 @@ cl::opt<bool> TranslateAllHelpers(
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
@@ -230,7 +230,8 @@ int main(int argc, char **argv) {
     // easily to TCG.
     //
 
-    MPM.addPass(PrepareForTcgPass());
+    TcgGlobalMap TcgGlobals;
+    MPM.addPass(PrepareForTcgPass(TcgGlobals));
     MPM.addPass(VerifierPass());
     {
         FunctionPassManager FPM;
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
index d8530406ad..69add43529 100644
--- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -16,9 +16,12 @@
 //
 
 #include "PrepareForTcgPass.hpp"
+#include "CmdLineOptions.hpp"
 
 #include <llvm/ADT/SCCIterator.h>
 #include <llvm/ADT/SmallPtrSet.h>
+#include <llvm/ADT/StringMap.h>
+#include <llvm/IR/Constants.h>
 #include <llvm/IR/Function.h>
 #include <llvm/IR/InstIterator.h>
 #include <llvm/IR/Instructions.h>
@@ -68,11 +71,70 @@ inline void demotePhis(Function &F) {
     }
 }
 
+static StringMap<size_t> collectTcgGlobals(Module &M, TcgGlobalMap &ResultTcgGlobalMap) {
+    auto *Map = M.getGlobalVariable(TcgGlobalMappingsName);
+    if (!Map) {
+        return {};
+    }
+
+    // In case the `tcg_global_mappings` array is empty,
+    // casting to `ConstantArray` will fail, even though it's a
+    // `[0 x %struct.cpu_tcg_mapping]`.
+    auto *MapElems = dyn_cast<ConstantArray>(Map->getOperand(0));
+    if (!MapElems) {
+        return {};
+    }
+
+    StringMap<size_t> TypeIndexMap;
+
+    for (auto Row : MapElems->operand_values()) {
+        auto *ConstRow = cast<ConstantStruct>(Row);
+
+        // Get code string
+        auto *CodePtr = ConstRow->getOperand(0);
+        StringRef CodeStr =
+            cast<ConstantDataArray>(CodePtr->getOperand(0))->getAsString();
+        CodeStr = CodeStr.rtrim('\0');
+
+        // Get base type name
+        auto *TypeNamePtr = ConstRow->getOperand(2);
+        StringRef TypeNameStr =
+            cast<ConstantDataArray>(TypeNamePtr->getOperand(0))->getAsString();
+        TypeNameStr = TypeNameStr.rtrim('\0');
+
+        // Get offset in cpu env
+        auto *Offset = cast<ConstantInt>(ConstRow->getOperand(4));
+        // Get size of variable in cpu env
+        auto *SizeInBytes = cast<ConstantInt>(ConstRow->getOperand(5));
+        unsigned SizeInBits = 8 * SizeInBytes->getLimitedValue();
+
+        auto *Stride = cast<ConstantInt>(ConstRow->getOperand(6));
+        auto *NumElements = cast<ConstantInt>(ConstRow->getOperand(7));
+
+        if (auto It = TypeIndexMap.find(TypeNameStr);
+            It == TypeIndexMap.end()) {
+            TypeIndexMap[TypeNameStr] = ResultTcgGlobalMap.size();
+            ResultTcgGlobalMap.emplace_back();
+        }
+
+        const size_t Index = TypeIndexMap[TypeNameStr];
+        ResultTcgGlobalMap[Index][Offset->getLimitedValue()] = {
+            CodeStr,
+            SizeInBits,
+            NumElements->getLimitedValue(),
+            Stride->getLimitedValue(),
+        };
+    }
+
+    return TypeIndexMap;
+}
+
 PreservedAnalyses PrepareForTcgPass::run(Module &M,
                                          ModuleAnalysisManager &MAM) {
     removeFunctionsWithLoops(M, MAM);
     for (Function &F : M) {
         demotePhis(F);
     }
+    const StringMap<size_t> TypeIndexMap = collectTcgGlobals(M, ResultTcgGlobalMap);
     return PreservedAnalyses::none();
 }
-- 
2.52.0


