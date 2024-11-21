Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01C9D743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHt-0001cf-4W; Wed, 20 Nov 2024 20:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHr-0001b0-2o
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:15 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHo-0004Xd-Um
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lmWGLOze3SuRS/fAHZcf3ZMhqPnKfajIC31FbL7DQy4=; b=NtKZojsW4OM2ES9
 t+zx3ibbMJSZEnIAu6650ysyhwmS0QWy0JKdaK4i2rn3DNUvG5ocwzMFlMkJMyaVtcuGu0MmDJA9l
 VItuhIQ5DVPVNXjcsYjW7kSQuLTXnEzHm7rkWzQTi7u2FXbWfHQoTVEgl+JmVvEDuY6ZILsSuv/+Q
 3s=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 15/43] helper-to-tcg: PrepareForOptPass, map annotations
Date: Thu, 21 Nov 2024 02:49:19 +0100
Message-ID: <20241121014947.18666-16-anjo@rev.ng>
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

In the LLVM IR module function annotations are stored in one big global
array of strings.  Traverse this array and parse the data into a format
more useful for future passes.  A map between Functions * and a list of
annotations is exposed.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../include/FunctionAnnotation.h              | 54 ++++++++++++
 .../helper-to-tcg/include/PrepareForOptPass.h |  7 +-
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 87 +++++++++++++++++++
 .../helper-to-tcg/pipeline/Pipeline.cpp       |  3 +-
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.h

diff --git a/subprojects/helper-to-tcg/include/FunctionAnnotation.h b/subprojects/helper-to-tcg/include/FunctionAnnotation.h
new file mode 100644
index 0000000000..b562f7c892
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/FunctionAnnotation.h
@@ -0,0 +1,54 @@
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
+#pragma once
+
+#include <llvm/ADT/DenseMap.h>
+#include <llvm/ADT/SmallVector.h>
+#include <stdint.h>
+
+namespace llvm
+{
+class Function;
+}
+
+// Different kind of function annotations which control the behaviour
+// of helper-to-tcg.
+enum class AnnotationKind : uint8_t {
+    // Function should be translated
+    HelperToTcg,
+    // Declares a list of arguments as immediates
+    Immediate,
+    // Declares a list of arguments as vectors, represented by offsets into
+    // the CPU state
+    PtrToOffset,
+};
+
+// Annotation data which may be attached to a function
+struct Annotation {
+    // Indices of function arguments the annotation applies to, only
+    // used for AnnotationKind::[Immediate|PtrToOffset].
+    llvm::SmallVector<uint8_t, 4> ArgIndices;
+    AnnotationKind Kind;
+};
+
+// Map from Function * to a list of struct Annotation.  std::map is used here
+// which allocates for each mapped pair due to the value being large
+// (at least 48*3 bits).  If ArgIndices were to be stored out-of-band this could
+// be reduced, and DenseMap would be more appropriate.
+using AnnotationVectorTy = llvm::SmallVector<Annotation, 3>;
+using AnnotationMapTy = llvm::DenseMap<llvm::Function *, AnnotationVectorTy>;
diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.h b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
index d74618613f..5f9c059b97 100644
--- a/subprojects/helper-to-tcg/include/PrepareForOptPass.h
+++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
@@ -17,6 +17,7 @@
 
 #pragma once
 
+#include "FunctionAnnotation.h"
 #include <llvm/IR/PassManager.h>
 
 //
@@ -27,8 +28,12 @@
 //
 
 class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
+    AnnotationMapTy &ResultAnnotations;
 public:
-    PrepareForOptPass() {}
+    PrepareForOptPass(AnnotationMapTy &ResultAnnotations)
+        : ResultAnnotations(ResultAnnotations)
+    {
+    }
     llvm::PreservedAnalyses run(llvm::Module &M,
                                 llvm::ModuleAnalysisManager &MAM);
 };
diff --git a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
index 0a018494fe..9f1d4df102 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
@@ -16,10 +16,97 @@
 //
 
 #include <PrepareForOptPass.h>
+#include <Error.h>
+
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Instruction.h>
+#include <llvm/IR/Module.h>
 
 using namespace llvm;
 
+static Expected<Annotation> parseAnnotationStr(StringRef Str,
+                                               uint32_t num_function_args)
+{
+    Annotation Ann;
+
+    Str = Str.trim();
+
+    if (Str.consume_front("helper-to-tcg")) {
+        Ann.Kind = AnnotationKind::HelperToTcg;
+        // Early return, no additional info to parse from annotation string
+        return Ann;
+    } else if (Str.consume_front("immediate")) {
+        Ann.Kind = AnnotationKind::Immediate;
+    } else if (Str.consume_front("ptr-to-offset")) {
+        Ann.Kind = AnnotationKind::PtrToOffset;
+    } else {
+        return mkError("Unknown annotation");
+    }
+
+    // Parse comma separated list of argument indices
+
+    if (!Str.consume_front(":")) {
+        return mkError("Expected \":\"");
+    }
+
+    Str = Str.ltrim(' ');
+    do {
+        Str = Str.ltrim(' ');
+        uint32_t i = 0;
+        Str.consumeInteger(10, i);
+        if (i >= num_function_args) {
+            return mkError("Annotation has out of bounds argument index");
+        }
+        Ann.ArgIndices.push_back(i);
+    } while (Str.consume_front(","));
+
+    return Ann;
+}
+
+static void collectAnnotations(Module &M, AnnotationMapTy &ResultAnnotations)
+{
+    // cast over dyn_cast is being used here to
+    // assert that the structure of
+    //
+    //     llvm.global.annotation
+    //
+    // is what we expect.
+
+    GlobalVariable *GA = M.getGlobalVariable("llvm.global.annotations");
+    if (!GA) {
+        return;
+    }
+
+    // Get the metadata which is stored in the first op
+    auto *CA = cast<ConstantArray>(GA->getOperand(0));
+    // Loop over metadata
+    for (Value *CAOp : CA->operands()) {
+        auto *Struct = cast<ConstantStruct>(CAOp);
+        assert(Struct->getNumOperands() >= 2);
+        Constant *UseOfF = Struct->getOperand(0);
+        if (isa<UndefValue>(UseOfF)) {
+            continue;
+        }
+        auto *F = cast<Function>(UseOfF->getOperand(0));
+        auto *AnnVar =
+            cast<GlobalVariable>(Struct->getOperand(1)->getOperand(0));
+        auto *AnnData = cast<ConstantDataArray>(AnnVar->getOperand(0));
+
+        StringRef AnnStr = AnnData->getAsString();
+        AnnStr = AnnStr.substr(0, AnnStr.size() - 1);
+        Expected<Annotation> Ann = parseAnnotationStr(AnnStr, F->arg_size());
+        if (!Ann) {
+            dbgs() << "Failed to parse annotation: \"" << Ann.takeError()
+                   << "\" for function " << F->getName() << "\n";
+            continue;
+        }
+        ResultAnnotations[F].push_back(*Ann);
+    }
+}
+
 PreservedAnalyses PrepareForOptPass::run(Module &M, ModuleAnalysisManager &MAM)
 {
+    collectAnnotations(M, ResultAnnotations);
     return PreservedAnalyses::none();
 }
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index fad335f4a9..3b9493bc73 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -174,7 +174,8 @@ int main(int argc, char **argv)
         MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
     }
 
-    MPM.addPass(PrepareForOptPass());
+    AnnotationMapTy Annotations;
+    MPM.addPass(PrepareForOptPass(Annotations));
 
     {
         FunctionPassManager FPM;
-- 
2.45.2


