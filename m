Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB70D743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHr-0001bA-CK; Wed, 20 Nov 2024 20:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHq-0001aq-El
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:14 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHo-0004XZ-D4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=79pr1drhMqVTakNZzCI6+VG2OY2chgT2RrjIC+e91vQ=; b=gvB4mbFQ9zlG5lO
 u1L/TOkOFKnZcHgVDSsTzZ7wwzSy3rpDes9tkzZz8t0WGAXx7GSwWyS3cCaWNUFo1YnSBC/dLSNUR
 oeNIDO4ubvM7KYes46csSSvCJzGBDK1oNSTBl4T3pPGH+OugC3pm7wIIaKtx62pwGk8IJW3ucrFXR
 xA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 14/43] helper-to-tcg: Introduce PrepareForOptPass
Date: Thu, 21 Nov 2024 02:49:18 +0100
Message-ID: <20241121014947.18666-15-anjo@rev.ng>
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

Adds a new LLVM pass that runs early in the pipeline with the goal
of preparing the input module for optimization by doing some early
culling of functions and information gathering.

This commits sets up a new LLVM pass over the IR module and runs it from
the pipeline.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.h    |  2 ++
 .../helper-to-tcg/include/PrepareForOptPass.h | 34 +++++++++++++++++++
 subprojects/helper-to-tcg/meson.build         |  2 ++
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 25 ++++++++++++++
 .../helper-to-tcg/pipeline/Pipeline.cpp       | 27 +++++++++++++++
 5 files changed, 90 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.h
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.h b/subprojects/helper-to-tcg/include/CmdLineOptions.h
index 5774ab07b1..ed60c45f9a 100644
--- a/subprojects/helper-to-tcg/include/CmdLineOptions.h
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.h
@@ -21,3 +21,5 @@
 
 // Options for pipeline
 extern llvm::cl::list<std::string> InputFiles;
+// Options for PrepareForOptPass
+extern llvm::cl::opt<bool> TranslateAllHelpers;
diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.h b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
new file mode 100644
index 0000000000..d74618613f
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.h
@@ -0,0 +1,34 @@
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
+//
+// PrepareForOptPass
+//
+// Pass that performs either early information collection or basic culling of
+// the input module. simplify the module, or to allow for further optimization.
+//
+
+class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
+public:
+    PrepareForOptPass() {}
+    llvm::PreservedAnalyses run(llvm::Module &M,
+                                llvm::ModuleAnalysisManager &MAM);
+};
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 63c6ed17fb..fd3fd6f0ae 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -43,6 +43,8 @@ endif
 sources = [
     'pipeline/Pipeline.cpp',
     'passes/llvm-compat.cpp',
+    'pipeline/Pipeline.cpp',
+    'passes/PrepareForOptPass/PrepareForOptPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
new file mode 100644
index 0000000000..0a018494fe
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForOptPass/PrepareForOptPass.cpp
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
+#include <PrepareForOptPass.h>
+
+using namespace llvm;
+
+PreservedAnalyses PrepareForOptPass::run(Module &M, ModuleAnalysisManager &MAM)
+{
+    return PreservedAnalyses::none();
+}
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
index 9c0e777893..fad335f4a9 100644
--- a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -34,7 +34,9 @@
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
 #include <llvm/Target/TargetMachine.h>
+#include <llvm/Transforms/Scalar/SROA.h>
 
+#include <PrepareForOptPass.h>
 #include "llvm-compat.h"
 
 using namespace llvm;
@@ -155,5 +157,30 @@ int main(int argc, char **argv)
 
     ModulePassManager MPM;
 
+    //
+    // Start by Filtering out functions we don't want to translate,
+    // following by a pass that removes `noinline`s that are inserted
+    // by clang on -O0. We finally run a UnifyExitNodesPass to make sure
+    // the helpers we parse only has a single exit.
+    //
+
+    {
+        FunctionPassManager FPM;
+#if LLVM_VERSION_MAJOR < 14
+        FPM.addPass(SROA());
+#else
+        FPM.addPass(SROAPass());
+#endif
+        MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
+    }
+
+    MPM.addPass(PrepareForOptPass());
+
+    {
+        FunctionPassManager FPM;
+        FPM.addPass(compat::UnifyFunctionExitNodesPass());
+        MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
+    }
+
     return 0;
 }
-- 
2.45.2


