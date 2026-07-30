Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2883FC54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5v-0001rd-Ut; Wed, 29 Jul 2026 23:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5u-0001px-Ou
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:02 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5s-0002t7-9F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ih5zg/uLk39Z71+sgYtKvzrNyD7K2CngOA6d/ur0vuc=; b=OO2n4nh5zH2UrLM
 DVIwuFs7fwcV3JHzN1ItE7pSxUUhmc4cbZa5SyIGZTolm+4hgVi6zZn8pJqhU4mJ3+wRMdvnOkSqW
 Nh1CiVzEXNjclBXhzeFaizOQrgQCCfrJWd43s322yjtQayRmPO3NcXckOeLMZSRCVTt5QDqrQkDU0
 v4=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 09/50] helper-to-tcg: Introduce custom LLVM pipeline
Date: Thu, 30 Jul 2026 05:09:43 +0200
Message-ID: <20260730031025.12926-10-anjo@rev.ng>
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

Adds a custom pipeline, similar to LLVM opt, with the goal of taking an
input LLVM IR module to an equivalent output .c file implementing
functions in TCG.

Initial LLVM boilerplate is added up until the creation of a
ModulePassManager.  A custom target derived from x64 is added, to ensure
consistent behaviour across different hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.hpp  |  23 +++
 subprojects/helper-to-tcg/meson.build         |   1 +
 subprojects/helper-to-tcg/src/Pipeline.cpp    | 146 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.hpp
 create mode 100644 subprojects/helper-to-tcg/src/Pipeline.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
new file mode 100644
index 0000000000..93706b78c5
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
@@ -0,0 +1,23 @@
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
+#include <llvm/Support/CommandLine.h>
+
+// Options for pipeline
+extern llvm::cl::list<std::string> InputFiles;
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 965014c988..ca46578cb3 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -41,6 +41,7 @@ endif
 
 sources = [
     'src/LlvmCompat.cpp',
+    'src/Pipeline.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
new file mode 100644
index 0000000000..f36f447fd2
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -0,0 +1,146 @@
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
+#include "CmdLineOptions.hpp"
+#include "LlvmCompat.hpp"
+
+#if LLVM_VERSION_MAJOR == 15
+#include <llvm/ADT/Triple.h>
+#else
+#include <llvm/TargetParser/Triple.h>
+#endif
+#include <llvm/Analysis/AliasAnalysis.h>
+#include <llvm/Analysis/CGSCCPassManager.h>
+#include <llvm/Analysis/LoopAnalysisManager.h>
+#include <llvm/Analysis/TargetTransformInfo.h>
+#include <llvm/CodeGen/BasicTTIImpl.h>
+#include <llvm/IR/LLVMContext.h>
+#include <llvm/IR/Module.h>
+#include <llvm/IR/PassManager.h>
+#include <llvm/IRReader/IRReader.h>
+#include <llvm/InitializePasses.h>
+#include <llvm/Linker/Linker.h>
+#include <llvm/PassRegistry.h>
+#include <llvm/Passes/PassBuilder.h>
+#include <llvm/Support/CommandLine.h>
+#include <llvm/Support/InitLLVM.h>
+#include <llvm/Support/SourceMgr.h>
+#include <llvm/Support/TargetSelect.h>
+#include <llvm/Target/TargetMachine.h>
+
+using namespace llvm;
+
+cl::OptionCategory Cat("helper-to-tcg Options");
+
+// Options for pipeline
+cl::opt<std::string> InputFile(cl::Positional, cl::desc("[input LLVM module]"),
+                               cl::cat(Cat));
+
+// Define a TargetTransformInfo (TTI) subclass, this allows for overriding
+// common per-llvm-target information expected by other LLVM passes, such
+// as the width of the largest scalar/vector registers.  Needed for consistent
+// behaviour across different hosts.
+class TcgTTI : public BasicTTIImplBase<TcgTTI> {
+    friend class BasicTTIImplBase<TcgTTI>;
+
+    // We need to provide ST, TLI, getST(), getTLI()
+    const TargetSubtargetInfo *ST;
+    const TargetLoweringBase *TLI;
+
+    const TargetSubtargetInfo *getST() const { return ST; }
+    const TargetLoweringBase *getTLI() const { return TLI; }
+
+  public:
+    // Initialize ST and TLI from the target machine, e.g. if we're
+    // targeting x86 we'll get the Subtarget and TargetLowering to
+    // match that architechture.
+    TcgTTI(TargetMachine *TM, Function const &F)
+        : BasicTTIImplBase(TM, F.getParent()->getDataLayout()),
+          ST(TM->getSubtargetImpl(F)), TLI(ST->getTargetLowering()) {}
+
+    TypeSize getRegisterBitWidth(TargetTransformInfo::RegisterKind K) const {
+        switch (K) {
+        case TargetTransformInfo::RGK_Scalar:
+            // We pretend we always support 64-bit registers
+            return TypeSize::getFixed(64);
+        case TargetTransformInfo::RGK_FixedWidthVector:
+            // We pretend we always support 2048-bit vector registers
+            return TypeSize::getFixed(2048);
+        case TargetTransformInfo::RGK_ScalableVector:
+            return TypeSize::getScalable(0);
+        default:
+            abort();
+        }
+    }
+};
+
+int main(int argc, char **argv) {
+    InitLLVM X(argc, argv);
+    cl::HideUnrelatedOptions(Cat);
+
+    InitializeAllTargets();
+    InitializeAllTargetMCs();
+    PassRegistry &Registry = *PassRegistry::getPassRegistry();
+    initializeCore(Registry);
+    initializeScalarOpts(Registry);
+    initializeVectorization(Registry);
+    initializeAnalysis(Registry);
+    initializeTransformUtils(Registry);
+    initializeInstCombine(Registry);
+    initializeTarget(Registry);
+
+    cl::ParseCommandLineOptions(argc, argv);
+
+    LLVMContext Context;
+
+    SMDiagnostic Err;
+    std::unique_ptr<Module> M = parseIRFile(InputFile, Err, Context);
+
+    // Create a new TargetMachine to represent a TCG target,
+    // we use x86_64 as a base and derive from that using a
+    // TargetTransformInfo to provide allowed scalar and vector
+    // register sizes.
+    Triple ModuleTriple("x86_64-pc-unknown");
+    assert(ModuleTriple.getArch());
+    TargetMachine *TM = compat::getTargetMachine(ModuleTriple);
+
+    PipelineTuningOptions PTO;
+    PassBuilder PB = compat::createPassBuilder(TM, PTO);
+    LoopAnalysisManager LAM;
+    FunctionAnalysisManager FAM;
+    CGSCCAnalysisManager CGAM;
+    ModuleAnalysisManager MAM;
+
+    // Register our TargetIrAnalysis pass using our own TTI
+    FAM.registerPass([&] {
+        return TargetIRAnalysis(
+            [&TM](const Function &F) -> TargetIRAnalysis::Result {
+                return compat::makeTTI<TcgTTI>(TM, F);
+            });
+    });
+
+    // Register other default LLVM Analyses
+    PB.registerFunctionAnalyses(FAM);
+    PB.registerModuleAnalyses(MAM);
+    PB.registerLoopAnalyses(LAM);
+    PB.registerCGSCCAnalyses(CGAM);
+    PB.crossRegisterProxies(LAM, FAM, CGAM, MAM);
+
+    ModulePassManager MPM;
+
+    return 0;
+}
-- 
2.52.0


