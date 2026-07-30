Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201DAC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6c-0002xn-GL; Wed, 29 Jul 2026 23:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6Z-0002nV-OW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:43 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6X-0002vt-98
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=IkQugLx6QLVgUoZlVKl4ZiXCLCO5b235a651y44fLYM=; b=uePriEQZLUAPXN6
 HH/VsIUgtnAF0dq9+1uCuAXXyykbtPaCTqNQ5Zl9m3/RU3rV5iTB9A9ml3SCjApva8Mkhylj8SzcP
 ObqrFgd+GxWgBo6x/ad8aKJ1r/VcmqhEOZjNh2jq7ZnUjxnWp1SHPa2TYY7+s/udjdMfGJJIUtvuR
 9Y=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 22/50] helper-to-tcg: Introduce PrepareForTcgPass
Date: Thu, 30 Jul 2026 05:09:56 +0200
Message-ID: <20260730031025.12926-23-anjo@rev.ng>
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

Adds a new pass over the LLVM module which runs post-optimization with
the end-goal of:

  * Culling functions which aren't worth translating;
  * Canonicalizing the IR to something closer to TCG, and;
  * Extracting information which may be useful in the backend pass.

The bulk of IR transformations occur in the canonicalization phase, with
a handful occuring later in the packend. This commits sets up a new LLVM
pass over the IR module and runs it from the pipeline.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.hpp  |  2 ++
 .../include/PrepareForTcgPass.hpp             | 27 +++++++++++++++++++
 subprojects/helper-to-tcg/meson.build         |  1 +
 subprojects/helper-to-tcg/src/Pipeline.cpp    | 24 +++++++++++++++++
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 25 +++++++++++++++++
 5 files changed, 79 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
index ca1cb59835..bfdd3ebe41 100644
--- a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
@@ -23,3 +23,5 @@
 extern llvm::cl::list<std::string> InputFiles;
 // Options for PrepareForOptPass
 extern llvm::cl::opt<bool> TranslateAllHelpers;
+// Options for PrepareForTcgPass
+extern llvm::cl::opt<std::string> TcgGlobalMappingsName;
diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
new file mode 100644
index 0000000000..90bc9402cb
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
@@ -0,0 +1,27 @@
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
+#include <llvm/IR/PassManager.h>
+
+class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
+public:
+    PrepareForTcgPass() {}
+    llvm::PreservedAnalyses run(llvm::Module &M,
+                                llvm::ModuleAnalysisManager &MAM);
+};
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index b3a3de6297..c2926652f3 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -44,6 +44,7 @@ sources = [
     'src/Pipeline.cpp',
     'src/PrepareForOptPass/PrepareForOptPass.cpp',
     'src/PseudoInst.cpp',
+    'src/PrepareForTcgPass/PrepareForTcgPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index 571276de24..6058718a9c 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -18,6 +18,7 @@
 #include "CmdLineOptions.hpp"
 #include "LlvmCompat.hpp"
 #include "PrepareForOptPass.hpp"
+#include "PrepareForTcgPass.hpp"
 
 #if LLVM_VERSION_MAJOR == 15
 #include <llvm/ADT/Triple.h>
@@ -32,6 +33,7 @@
 #include <llvm/IR/LLVMContext.h>
 #include <llvm/IR/Module.h>
 #include <llvm/IR/PassManager.h>
+#include <llvm/IR/Verifier.h>
 #include <llvm/IRReader/IRReader.h>
 #include <llvm/InitializePasses.h>
 #include <llvm/Linker/Linker.h>
@@ -43,6 +45,7 @@
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
 #include <llvm/Target/TargetMachine.h>
+#include <llvm/Transforms/Scalar/DCE.h>
 #include <llvm/Transforms/Scalar/SROA.h>
 
 #define DEBUG_TYPE "pipeline"
@@ -70,6 +73,13 @@ cl::opt<bool> TranslateAllHelpers(
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
@@ -214,5 +224,19 @@ int main(int argc, char **argv) {
     MPM.addPass(
         PB.buildModuleOptimizationPipeline(compat::OptimizationLevel::Oz, {}));
 
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
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
new file mode 100644
index 0000000000..cea6573e41
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -0,0 +1,25 @@
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
+#include "PrepareForTcgPass.hpp"
+
+using namespace llvm;
+
+PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
+{
+    return PreservedAnalyses::none();
+}
-- 
2.52.0


