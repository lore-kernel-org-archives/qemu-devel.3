Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E78BD743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHv-0001e4-MG; Wed, 20 Nov 2024 20:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHu-0001dC-Gu
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHs-0004Z9-Gg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=3xa4cSQWq1UFcy/VC4ccaIM0E/2QjTKLoAtI/4PVoBM=; b=M35JFciezjmnJAh
 Wji961ULdWWiTcGHd+BVNZ1XDhAoov5IUfXyk0Gnimg4vZ4+zIztxFXs97WkpOI3dt8E+QvWvLHj5
 +vSlMxvNCGOD6IxvmnEzeayDvSm7YKXf8Qf5ibwJjr1K3892vLzmetG9vHA4DSxViVXC43Vra4eus
 9A=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 21/43] helper-to-tcg: Introduce PrepareForTcgPass
Date: Thu, 21 Nov 2024 02:49:25 +0100
Message-ID: <20241121014947.18666-22-anjo@rev.ng>
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

Adds a new pass over the LLVM module which runs post-optimization with
the end-goal of:
  * culling functions which aren't worth translating;
  * canonicalizing the IR to something closer to TCG, and;
  * extracting information which may be useful in the backend pass.

This commits sets up a new LLVM pass over the IR module and runs it from
the pipeline.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.h    |  2 ++
 .../helper-to-tcg/include/PrepareForTcgPass.h | 27 +++++++++++++++++++
 subprojects/helper-to-tcg/meson.build         |  1 +
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 25 +++++++++++++++++
 .../helper-to-tcg/pipeline/Pipeline.cpp       | 26 +++++++++++++++++-
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.h
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.h b/subprojects/helper-to-tcg/include/CmdLineOptions.h
index ed60c45f9a..9553e26407 100644
--- a/subprojects/helper-to-tcg/include/CmdLineOptions.h
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.h
@@ -23,3 +23,5 @@
 extern llvm::cl::list<std::string> InputFiles;
 // Options for PrepareForOptPass
 extern llvm::cl::opt<bool> TranslateAllHelpers;
+// Options for PrepareForTcgPass
+extern llvm::cl::opt<std::string> TcgGlobalMappingsName;
diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.h b/subprojects/helper-to-tcg/include/PrepareForTcgPass.h
new file mode 100644
index 0000000000..a41edb4c2e
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.h
@@ -0,0 +1,27 @@
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
+#include <llvm/IR/PassManager.h>
+
+class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
+public:
+    PrepareForTcgPass() {}
+    llvm::PreservedAnalyses run(llvm::Module &M,
+                                llvm::ModuleAnalysisManager &MAM);
+};
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 6aba71d5ca..6db1a019ce 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -46,6 +46,7 @@ sources = [
     'pipeline/Pipeline.cpp',
     'passes/PrepareForOptPass/PrepareForOptPass.cpp',
     'passes/PseudoInst.cpp',
+    'passes/PrepareForTcgPass/PrepareForTcgPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
new file mode 100644
index 0000000000..f0ef1abd17
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -0,0 +1,25 @@
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
+#include <PrepareForTcgPass.h>
+
+using namespace llvm;
+
+PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
+{
+    return PreservedAnalyses::none();
+}
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index a26b7a7350..7d03389439 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -24,6 +24,7 @@
 #include <llvm/IR/LLVMContext.h>
 #include <llvm/IR/Module.h>
 #include <llvm/IR/PassManager.h>
+#include <llvm/IR/Verifier.h>
 #include <llvm/IRReader/IRReader.h>
 #include <llvm/InitializePasses.h>
 #include <llvm/Linker/Linker.h>
@@ -34,10 +35,12 @@
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
 #include <llvm/Target/TargetMachine.h>
+#include <llvm/Transforms/Scalar/DCE.h>
 #include <llvm/Transforms/Scalar/SROA.h>
 
 #include <PrepareForOptPass.h>
-#include "llvm-compat.h"
+#include <PrepareForTcgPass.h>
+#include <llvm-compat.h>
 
 using namespace llvm;
 
@@ -52,6 +55,13 @@ cl::opt<bool> TranslateAllHelpers(
     "translate-all-helpers", cl::init(false),
     cl::desc("Translate all functions starting with helper_*"), cl::cat(Cat));
 
+// Options for PrepareForTcgPass
+cl::opt<std::string> TcgGlobalMappingsName(
+    "tcg-global-mappings",
+    cl::desc("<Name of global cpu_mappings[] used for mapping accesses"
+             "into a struct to TCG globals>"),
+    cl::Required, cl::cat(Cat));
+
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
 // as the width of the largest scalar/vector registers.  Needed for consistent
@@ -200,5 +210,19 @@ int main(int argc, char **argv)
     MPM.addPass(
         PB.buildModuleOptimizationPipeline(compat::OptimizationLevel::Os));
 
+    //
+    // Next, we run our final transformations, including removing phis and our
+    // own instruction combining that prioritizes instructions that map more
+    // easily to TCG.
+    //
+
+    MPM.addPass(PrepareForTcgPass());
+    MPM.addPass(VerifierPass());
+    {
+        FunctionPassManager FPM;
+        FPM.addPass(DCEPass());
+        MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
+    }
+
     return 0;
 }
-- 
2.45.2


