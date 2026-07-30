Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1EEC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6D-0001uY-4d; Wed, 29 Jul 2026 23:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6B-0001u4-P4
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:19 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6A-0002tz-02
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=WxHUNRyY9SjQyZWdhZJJM6dALnjqTd/WEb4Rj+WgVnY=; b=qv6/Z9118cdg3zw
 1qs6OjtD2xZWEuqofdAXSJKawyBYqb4l0JxYkafKDgkJiDfGgSjK85yWKDZVLd7IFed8iCo6kUdU7
 0OmfWQgv/gfvP2LfBXyPtuoKN9oRMy8ls0VpEHn+B0CwPSJOE/zty2hv38CCCShG2Tswm1ciqlzQV
 i4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 12/50] helper-to-tcg: Introduce PrepareForOptPass
Date: Thu, 30 Jul 2026 05:09:46 +0200
Message-ID: <20260730031025.12926-13-anjo@rev.ng>
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

Adds a new LLVM pass that runs early in the pipeline with the goal
of preparing the input module for optimization by doing some early
culling of functions and information gathering.

This commits sets up a new LLVM pass over the IR module and runs it from
the pipeline.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../include/PrepareForOptPass.hpp             | 34 +++++++++++++++++++
 subprojects/helper-to-tcg/meson.build         |  1 +
 subprojects/helper-to-tcg/src/Pipeline.cpp    | 27 +++++++++++++++
 .../PrepareForOptPass/PrepareForOptPass.cpp   | 29 ++++++++++++++++
 4 files changed, 91 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp

diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
new file mode 100644
index 0000000000..2b3694c536
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
@@ -0,0 +1,34 @@
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
index ca46578cb3..4fd0ddb778 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -42,6 +42,7 @@ endif
 sources = [
     'src/LlvmCompat.cpp',
     'src/Pipeline.cpp',
+    'src/PrepareForOptPass/PrepareForOptPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index 4b9523ad6f..59de572bf6 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -17,6 +17,7 @@
 
 #include "CmdLineOptions.hpp"
 #include "LlvmCompat.hpp"
+#include "PrepareForOptPass.hpp"
 
 #if LLVM_VERSION_MAJOR == 15
 #include <llvm/ADT/Triple.h>
@@ -42,6 +43,7 @@
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
 #include <llvm/Target/TargetMachine.h>
+#include <llvm/Transforms/Scalar/SROA.h>
 
 #define DEBUG_TYPE "pipeline"
 
@@ -165,5 +167,30 @@ int main(int argc, char **argv) {
 
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
+#if LLVM_VERSION_MAJOR >= 16
+        FPM.addPass(SROAPass(SROAOptions::ModifyCFG));
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
diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
new file mode 100644
index 0000000000..4a7e82b7bd
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
@@ -0,0 +1,29 @@
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
+#include "PrepareForOptPass.h"
+
+#include <llvm/Support/Debug.h>
+
+#define DEBUG_TYPE "prepare-for-opt"
+
+using namespace llvm;
+
+PreservedAnalyses PrepareForOptPass::run(Module &M,
+                                         ModuleAnalysisManager &MAM) {
+    return PreservedAnalyses::none();
+}
-- 
2.52.0


