Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FEFD743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHq-0001az-TB; Wed, 20 Nov 2024 20:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHp-0001aR-NA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:13 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHn-0004XK-1d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NXow3yI/n6VGiB50Xsb9COmLd+0cj1NMmA6+H2pmjgc=; b=WKYcobFPlzejlh4
 I+kietp95+5ETSoDAeKdBuDIiOrQLmbbbGtOZefz0nnYjiVT0mKgpTUSk0NRUAn1jsOqOUlROjM3w
 8eaGIJ7sAPauDE4BakwCTHap6xqSC1aQmcPS8ZSP/dZcZYmesO0tzlI9q1ulUjW60jQHHGKCAOydj
 k0=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 12/43] helper-to-tcg: Introduce custom LLVM pipeline
Date: Thu, 21 Nov 2024 02:49:16 +0100
Message-ID: <20241121014947.18666-13-anjo@rev.ng>
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

Adds a custom pipeline, similar to LLVM opt, with the goal of taking an
input LLVM IR module to an equivalent output .c file implementing
functions in TCG.

Initial LLVM boilerplate is added until the creation of a
ModulePassManager.  A custom target derived from x64 is added, to ensure
consistent behaviour across different hosts.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.h    |  23 +++
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../helper-to-tcg/pipeline/Pipeline.cpp       | 159 ++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/CmdLineOptions.h
 create mode 100644 subprojects/helper-to-tcg/pipeline/Pipeline.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.h b/subprojects/helper-to-tcg/include/CmdLineOptions.h
new file mode 100644
index 0000000000..5774ab07b1
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.h
@@ -0,0 +1,23 @@
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
+#include <llvm/Support/CommandLine.h>
+
+// Options for pipeline
+extern llvm::cl::list<std::string> InputFiles;
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 7bb93ce005..63c6ed17fb 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -41,6 +41,7 @@ if version_major < 10 or version_major > 14
 endif
 
 sources = [
+    'pipeline/Pipeline.cpp',
     'passes/llvm-compat.cpp',
 ]
 
diff --git a/subprojects/helper-to-tcg/pipeline/Pipeline.cpp b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
new file mode 100644
index 0000000000..9c0e777893
--- /dev/null
+++ b/subprojects/helper-to-tcg/pipeline/Pipeline.cpp
@@ -0,0 +1,159 @@
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
+#include <llvm/ADT/Triple.h>
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
+#include "llvm-compat.h"
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
+class TcgTTI : public BasicTTIImplBase<TcgTTI>
+{
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
+          ST(TM->getSubtargetImpl(F)), TLI(ST->getTargetLowering())
+    {
+    }
+
+#if LLVM_VERSION_MAJOR >= 13
+    TypeSize getRegisterBitWidth(TargetTransformInfo::RegisterKind K) const
+    {
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
+#else
+    unsigned getRegisterBitWidth(bool Vector) const
+    {
+        if (Vector) {
+            return 2048;
+        } else {
+            return 64;
+        }
+    }
+#endif
+};
+
+int main(int argc, char **argv)
+{
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
+            [&](const Function &F) { return TcgTTI(TM, F); });
+    });
+    FAM.registerPass([&] { return LoopAnalysis(); });
+    LAM.registerPass([&] { return LoopAccessAnalysis(); });
+    // We need to specifically add the aliasing pipeline for LLVM <= 13
+    FAM.registerPass([&] { return PB.buildDefaultAAPipeline(); });
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
2.45.2


