Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142B4D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHs-0001cX-Tw; Wed, 20 Nov 2024 20:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHr-0001b4-8i
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:15 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHp-0004Xj-Ie
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OIlScO3BuH63uZxdmqbUwS+sjbYNsWyshmkeVqgGtWQ=; b=mrO8wMR8oaQDdcZ
 JelEhQefGPshBw7N41+t9ly5Fx6J1+DhujzxT0HxjnTXZoVDY/DOO8wZK3lle/79GWxu43zp0qmFA
 1y/hKzVMBJ/GmKZ78F4PWjgQUBsCQtTBKcCbPCZOL6IO6NaIg6F0K+GdZrUZ5UISl2tMeIuU6L458
 xc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 16/43] helper-to-tcg: PrepareForOptPass,
 Cull unused functions
Date: Thu, 21 Nov 2024 02:49:20 +0100
Message-ID: <20241121014947.18666-17-anjo@rev.ng>
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

Make an early pass over all functions in the input module and filter out
functions with:
  1. Invalid return type;
  2. No helper-to-tcg annotation.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/PrepareForOptPass.h |  7 +-
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 93 +++++++++++++++++++
 .../helper-to-tcg/pipeline/Pipeline.cpp       |  7 +-
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.h b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
index 5f9c059b97..8615625f09 100644
--- a/subprojects/helper-to-tcg/include/PrepareForOptPass.h
+++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
@@ -29,9 +29,12 @@
 
 class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
     AnnotationMapTy &ResultAnnotations;
+    bool TranslateAllHelpers;
 public:
-    PrepareForOptPass(AnnotationMapTy &ResultAnnotations)
-        : ResultAnnotations(ResultAnnotations)
+    PrepareForOptPass(AnnotationMapTy &ResultAnnotations,
+                      bool TranslateAllHelpers)
+        : ResultAnnotations(ResultAnnotations),
+          TranslateAllHelpers(TranslateAllHelpers)
     {
     }
     llvm::PreservedAnalyses run(llvm::Module &M,
diff --git a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
index 9f1d4df102..22509008c8 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
@@ -17,12 +17,17 @@
 
 #include <PrepareForOptPass.h>
 #include <Error.h>
+#include <FunctionAnnotation.h>
 
 #include <llvm/IR/Constants.h>
 #include <llvm/IR/Function.h>
 #include <llvm/IR/Instruction.h>
+#include <llvm/IR/Instructions.h>
 #include <llvm/IR/Module.h>
 
+#include <queue>
+#include <set>
+
 using namespace llvm;
 
 static Expected<Annotation> parseAnnotationStr(StringRef Str,
@@ -105,8 +110,96 @@ static void collectAnnotations(Module &M, AnnotationMapTy &ResultAnnotations)
     }
 }
 
+inline bool hasValidReturnTy(const Module &M, const Function *F)
+{
+    Type *RetTy = F->getReturnType();
+    return RetTy == Type::getVoidTy(F->getContext()) ||
+           RetTy == Type::getInt8Ty(M.getContext()) ||
+           RetTy == Type::getInt16Ty(M.getContext()) ||
+           RetTy == Type::getInt32Ty(M.getContext()) ||
+           RetTy == Type::getInt64Ty(M.getContext());
+}
+
+// Functions that should be removed:
+//   - No helper-to-tcg annotation (if TranslateAllHelpers == false);
+//   - Invalid (non-integer/void) return type
+static bool shouldRemoveFunction(const Module &M, const Function &F,
+                                 const AnnotationMapTy &AnnotationMap,
+                                 bool TranslateAllHelpers)
+{
+    if (F.isDeclaration()) {
+        return false;
+    }
+
+    if (!hasValidReturnTy(M, &F)) {
+        return true;
+    }
+
+    auto hasCorrectAnnotation = [](const Annotation &Ann) {
+        return Ann.Kind == AnnotationKind::HelperToTcg;
+    };
+
+    std::queue<const Function *> Worklist;
+    std::set<const Function *> Visited;
+    Worklist.push(&F);
+    while (!Worklist.empty()) {
+        const Function *F = Worklist.front();
+        Worklist.pop();
+        if (F->isDeclaration() or Visited.find(F) != Visited.end()) {
+            continue;
+        }
+        Visited.insert(F);
+
+        // Check for llvm-to-tcg annotation
+        if (TranslateAllHelpers and F->getName().startswith("helper_")) {
+            return false;
+        } else {
+            auto It = AnnotationMap.find(F);
+            if (It != AnnotationMap.end()) {
+                const auto &AnnotationVec = It->second;
+                auto Res = find_if(AnnotationVec, hasCorrectAnnotation);
+                if (Res != AnnotationVec.end()) {
+                    return false;
+                }
+            }
+        }
+
+        // Push functions that call F to the worklist, this way we retain
+        // functions that are being called by functions with the llvm-to-tcg
+        // annotation.
+        for (const User *U : F->users()) {
+            auto Call = dyn_cast<CallInst>(U);
+            if (!Call) {
+                continue;
+            }
+            const Function *ParentF = Call->getParent()->getParent();
+            Worklist.push(ParentF);
+        }
+    }
+
+    return true;
+}
+
+static void cullUnusedFunctions(Module &M, AnnotationMapTy &Annotations,
+                                bool TranslateAllHelpers)
+{
+    SmallVector<Function *, 16> FunctionsToRemove;
+    for (auto &F : M) {
+        if (shouldRemoveFunction(M, F, Annotations, TranslateAllHelpers)) {
+            FunctionsToRemove.push_back(&F);
+        }
+    }
+
+    for (Function *F : FunctionsToRemove) {
+        Annotations.erase(F);
+        F->setComdat(nullptr);
+        F->deleteBody();
+    }
+}
+
 PreservedAnalyses PrepareForOptPass::run(Module &M, ModuleAnalysisManager &MAM)
 {
     collectAnnotations(M, ResultAnnotations);
+    cullUnusedFunctions(M, ResultAnnotations, TranslateAllHelpers);
     return PreservedAnalyses::none();
 }
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index 3b9493bc73..dde3641ab3 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -47,6 +47,11 @@ cl::OptionCategory Cat("helper-to-tcg Options");
 cl::opt<std::string> InputFile(cl::Positional, cl::desc("[input LLVM module]"),
                                cl::cat(Cat));
 
+// Options for PrepareForOptPass
+cl::opt<bool> TranslateAllHelpers(
+    "translate-all-helpers", cl::init(false),
+    cl::desc("Translate all functions starting with helper_*"), cl::cat(Cat));
+
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
 // as the width of the largest scalar/vector registers.  Needed for consistent
@@ -175,7 +180,7 @@ int main(int argc, char **argv)
     }
 
     AnnotationMapTy Annotations;
-    MPM.addPass(PrepareForOptPass(Annotations));
+    MPM.addPass(PrepareForOptPass(Annotations, TranslateAllHelpers));
 
     {
         FunctionPassManager FPM;
-- 
2.45.2


