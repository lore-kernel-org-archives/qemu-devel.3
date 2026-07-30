Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E415C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6N-00029Z-VP; Wed, 29 Jul 2026 23:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6M-00027f-Ms
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:30 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6K-0002um-Ic
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=eWZchuVqzSjR2V6QniOrNG+R+2Zn07uA9lVeEhjH+3o=; b=VDf4TL+DQY2z+n+
 A9rj1NanJFEupDQUDidbO6b9jNNql6dfGX8gigqLCIynKnFDIRlO/LH5AFQLiFmqa4lE2jmofGp/m
 geLeGiiSZtlT/Jfb5IiKdujybOur3rwezDxbe9XwvSzckE8Qm5KCWzFxRD7cu1iFwiKqPT5GE2zjF
 pM=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 18/50] helper-to-tcg: PrepareForOptPass, collect debuginfo
Date: Thu, 30 Jul 2026 05:09:52 +0200
Message-ID: <20260730031025.12926-19-anjo@rev.ng>
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

Debug information is collected before any non-preserving optimization
pass is ran.  Currently, only variable definitions are parsed, mapping a
Value * to a name and typename.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/DebugInfo.hpp       | 46 ++++++++++++++++
 .../include/PrepareForOptPass.hpp             | 10 ++--
 subprojects/helper-to-tcg/src/Pipeline.cpp    |  3 +-
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 52 +++++++++++++++++++
 4 files changed, 107 insertions(+), 4 deletions(-)
 create mode 100644 subprojects/helper-to-tcg/include/DebugInfo.hpp

diff --git a/subprojects/helper-to-tcg/include/DebugInfo.hpp b/subprojects/helper-to-tcg/include/DebugInfo.hpp
new file mode 100644
index 0000000000..27e545c6b7
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/DebugInfo.hpp
@@ -0,0 +1,46 @@
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
+#pragma once
+
+#include <llvm/ADT/StringRef.h>
+#include <llvm/IR/ValueMap.h>
+
+namespace llvm {
+class Value;
+}
+
+// StringRefs will refer do debug metadata fields which have the same
+// lifetime as the LLVMContext and survive accross optimizations and
+// possible deletions of functions/variables.
+struct DebugInfo {
+    llvm::StringRef VarName;
+    llvm::StringRef BaseTypeName;
+};
+
+using DebugInfoMapTy = llvm::ValueMap<const llvm::Value *, DebugInfo>;
+
+// Helper to get the variable name from debug info associated with a particular
+// value, or default construct an empty name.
+inline llvm::StringRef getDebugVarName(const DebugInfoMapTy &DM,
+                                       const llvm::Value *V) {
+    auto It = DM.find(V);
+    if (It != DM.end()) {
+        return It->second.VarName;
+    }
+    return {};
+}
diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
index 08ca9a43bb..43cf77190a 100644
--- a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
+++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
@@ -17,6 +17,7 @@
 
 #pragma once
 
+#include "DebugInfo.hpp"
 #include "FunctionAnnotation.hpp"
 #include <llvm/IR/PassManager.h>
 
@@ -29,10 +30,13 @@
 
 class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
     AnnotationMapTy &ResultAnnotations;
+    DebugInfoMapTy &ResultDebugInfo;
 
-  public:
-    PrepareForOptPass(AnnotationMapTy &ResultAnnotations)
-        : ResultAnnotations(ResultAnnotations) {}
+public:
+    PrepareForOptPass(AnnotationMapTy &ResultAnnotations,
+                      DebugInfoMapTy &ResultDebugInfo)
+        : ResultAnnotations(ResultAnnotations),
+          ResultDebugInfo(ResultDebugInfo) {}
     llvm::PreservedAnalyses run(llvm::Module &M,
                                 llvm::ModuleAnalysisManager &MAM);
 };
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index 89637eaec6..a11c5fd353 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -193,7 +193,8 @@ int main(int argc, char **argv) {
     // but is correlct in LLVM-terms.
 
     AnnotationMapTy Annotations;
-    MPM.addPass(PrepareForOptPass(Annotations));
+    DebugInfoMapTy DebugInfo;
+    MPM.addPass(PrepareForOptPass(Annotations, DebugInfo));
 
     {
         FunctionPassManager FPM;
diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
index a7bee53582..7a9b954d7c 100644
--- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
@@ -26,6 +26,9 @@
 #include <llvm/ADT/StringSet.h>
 #include <llvm/Demangle/Demangle.h>
 #include <llvm/IR/Constants.h>
+#if LLVM_VERSION_MAJOR >= 19
+#include <llvm/IR/DebugProgramInstruction.h>
+#endif
 #include <llvm/IR/Function.h>
 #include <llvm/IR/Instruction.h>
 #include <llvm/IR/Instructions.h>
@@ -288,6 +291,53 @@ static void replaceRetaddrWithUndef(Module &M) {
     }
 }
 
+static void collectDebugInfo(Function &F, DebugInfoMapTy &ResultDebugInfo) {
+    StringSet EncounteredNames;
+    for (auto &BB : F) {
+        for (Instruction &I : BB) {
+#if LLVM_VERSION_MAJOR >= 19
+            for (DbgVariableRecord &DVR :
+                 filterDbgVars(I.getDbgRecordRange())) {
+                if (!DVR.isDbgValue()) {
+                    continue;
+                }
+                StringRef BaseType{};
+                StringRef VarName{};
+                if (auto *Derived =
+                        dyn_cast<DIDerivedType>(DVR.getVariable()->getType())) {
+                    BaseType = Derived->getBaseType()->getName();
+                }
+                VarName = DVR.getVariable()->getName();
+                if (ResultDebugInfo.find(DVR.getValue(0)) ==
+                        ResultDebugInfo.end() and
+                    !EncounteredNames.contains(VarName.data())) {
+                    ResultDebugInfo[DVR.getValue(0)] = {VarName, BaseType};
+                    EncounteredNames.insert(VarName.data());
+                }
+            }
+#else
+            if (I.isDebugOrPseudoInst()) {
+                if (const auto *Dbg = dyn_cast<DbgValueInst>(&I)) {
+                    StringRef BaseType{};
+                    StringRef VarName{};
+                    if (auto *Derived = dyn_cast<DIDerivedType>(
+                            Dbg->getVariable()->getType())) {
+                        BaseType = Derived->getBaseType()->getName();
+                    }
+                    VarName = Dbg->getVariable()->getName();
+                    if (ResultDebugInfo.find(Dbg->getValue(0)) ==
+                            ResultDebugInfo.end() and
+                        !EncounteredNames.contains(VarName.data())) {
+                        ResultDebugInfo[Dbg->getValue(0)] = {VarName, BaseType};
+                        EncounteredNames.insert(VarName.data());
+                    }
+                }
+            }
+#endif
+        }
+    }
+}
+
 PreservedAnalyses PrepareForOptPass::run(Module &M,
                                          ModuleAnalysisManager &MAM) {
     demangleFunctionNames(M);
@@ -305,6 +355,8 @@ PreservedAnalyses PrepareForOptPass::run(Module &M,
         if (F.getReturnType()->isStructTy()) {
             F.addFnAttr(Attribute::AttrKind::AlwaysInline);
         }
+        // Populate variable and type names for `Value`s from debug info.
+        collectDebugInfo(F, ResultDebugInfo);
     }
 
     return PreservedAnalyses::none();
-- 
2.52.0


