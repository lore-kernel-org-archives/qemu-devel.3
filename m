Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B66D743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHq-0001aa-4C; Wed, 20 Nov 2024 20:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHo-0001Zq-Nk
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:12 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHm-0004XD-FS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Hg/o1H2sN/+u03XPSgfnuR4t0tZbOD4bmwcvMFlXc2g=; b=O2pEpEP7TloW/Vc
 KHuOaMbiBsqhllQhBjX3xe1E8KRu9ZxDWvsLNsEz1lDtwkOriuE18s6Gp/tQXTz93nI576OcsA/5E
 yAaD8nVHBGwq+Q6FYNYFBF/2EHEboTBfPLLNpMrqWytrbXnwqSMYFrbS+Glt4eXVVVAGU9eI2aqgx
 og=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 11/43] helper-to-tcg: Introduce llvm-compat
Date: Thu, 21 Nov 2024 02:49:15 +0100
Message-ID: <20241121014947.18666-12-anjo@rev.ng>
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

Adds a translation unit with the sole purpose of handling inter-LLVM
code changes.  Instead of littering the code with #ifdefs, most of them
will be limited to llvm-compat.[cpp|h] and a saner compat::*() function
is exposed in its place.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../helper-to-tcg/passes/llvm-compat.cpp      | 162 ++++++++++++++++++
 .../helper-to-tcg/passes/llvm-compat.h        | 143 ++++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/llvm-compat.h

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index af593ccdfe..7bb93ce005 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -41,6 +41,7 @@ if version_major < 10 or version_major > 14
 endif
 
 sources = [
+    'passes/llvm-compat.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/llvm-compat.cpp b/subprojects/helper-to-tcg/passes/llvm-compat.cpp
new file mode 100644
index 0000000000..c5d9d28078
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/llvm-compat.cpp
@@ -0,0 +1,162 @@
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
+#include "llvm-compat.h"
+
+#if LLVM_VERSION_MAJOR > 10
+#include <llvm/CodeGen/CommandFlags.h>
+#else
+#include <llvm/CodeGen/CommandFlags.inc>
+#endif
+
+#include <string>
+
+// Static variables required by LLVM
+//
+// Defining RegisterCodeGenFlags with static duration registers extra
+// codegen commandline flags for specifying the target arch.
+#if LLVM_VERSION_MAJOR > 10
+static llvm::codegen::RegisterCodeGenFlags CGF;
+#endif
+static llvm::ExitOnError ExitOnErr;
+
+namespace compat
+{
+
+using namespace llvm;
+
+#if LLVM_VERSION_MAJOR > 10
+llvm::TargetMachine *getTargetMachine(llvm::Triple &TheTriple)
+{
+    const TargetOptions Options{};
+    std::string Error;
+    const Target *TheTarget = llvm::TargetRegistry::lookupTarget(
+        llvm::codegen::getMArch(), TheTriple, Error);
+    // Some modules don't specify a triple, and this is okay.
+    if (!TheTarget) {
+        return nullptr;
+    }
+
+    return TheTarget->createTargetMachine(
+        TheTriple.getTriple(), llvm::codegen::getCPUStr(),
+        llvm::codegen::getFeaturesStr(), Options,
+        llvm::codegen::getExplicitRelocModel(),
+        llvm::codegen::getExplicitCodeModel(), llvm::CodeGenOpt::Aggressive);
+}
+#else
+llvm::TargetMachine *getTargetMachine(llvm::Triple &TheTriple)
+{
+    const TargetOptions Options{};
+    std::string Error;
+    const Target *TheTarget =
+        llvm::TargetRegistry::lookupTarget(MArch, TheTriple, Error);
+    // Some modules don't specify a triple, and this is okay.
+    if (!TheTarget) {
+        return nullptr;
+    }
+
+    return TheTarget->createTargetMachine(
+        TheTriple.getTriple(), getCPUStr(), getFeaturesStr(), Options,
+        getRelocModel(), getCodeModel(), llvm::CodeGenOpt::Aggressive);
+}
+#endif
+
+//
+// LLVM 11 and below does not define the UnifyFunctionExitNodes pass
+// for the new pass manager.  Copy over the definition from LLVM and use it
+// for 11 and below.
+//
+#if LLVM_VERSION_MAJOR <= 11
+static bool unifyReturnBlocks(Function &F)
+{
+    std::vector<BasicBlock *> ReturningBlocks;
+
+    for (BasicBlock &I : F)
+        if (isa<ReturnInst>(I.getTerminator()))
+            ReturningBlocks.push_back(&I);
+
+    if (ReturningBlocks.size() <= 1)
+        return false;
+
+    // Insert a new basic block into the function, add PHI nodes (if the
+    // function returns values), and convert all of the return instructions into
+    // unconditional branches.
+    BasicBlock *NewRetBlock =
+        BasicBlock::Create(F.getContext(), "UnifiedReturnBlock", &F);
+
+    PHINode *PN = nullptr;
+    if (F.getReturnType()->isVoidTy()) {
+        ReturnInst::Create(F.getContext(), nullptr, NewRetBlock);
+    } else {
+        // If the function doesn't return void... add a PHI node to the block...
+        PN = PHINode::Create(F.getReturnType(), ReturningBlocks.size(),
+                             "UnifiedRetVal");
+        NewRetBlock->getInstList().push_back(PN);
+        ReturnInst::Create(F.getContext(), PN, NewRetBlock);
+    }
+
+    // Loop over all of the blocks, replacing the return instruction with an
+    // unconditional branch.
+    for (BasicBlock *BB : ReturningBlocks) {
+        // Add an incoming element to the PHI node for every return instruction
+        // that is merging into this new block...
+        if (PN)
+            PN->addIncoming(BB->getTerminator()->getOperand(0), BB);
+
+        BB->getInstList().pop_back(); // Remove the return insn
+        BranchInst::Create(NewRetBlock, BB);
+    }
+
+    return true;
+}
+
+static bool unifyUnreachableBlocks(Function &F)
+{
+    std::vector<BasicBlock *> UnreachableBlocks;
+
+    for (BasicBlock &I : F)
+        if (isa<UnreachableInst>(I.getTerminator()))
+            UnreachableBlocks.push_back(&I);
+
+    if (UnreachableBlocks.size() <= 1)
+        return false;
+
+    BasicBlock *UnreachableBlock =
+        BasicBlock::Create(F.getContext(), "UnifiedUnreachableBlock", &F);
+    new UnreachableInst(F.getContext(), UnreachableBlock);
+
+    for (BasicBlock *BB : UnreachableBlocks) {
+        BB->getInstList().pop_back(); // Remove the unreachable inst.
+        BranchInst::Create(UnreachableBlock, BB);
+    }
+
+    return true;
+}
+
+llvm::PreservedAnalyses
+UnifyFunctionExitNodesPass::run(llvm::Function &F,
+                                llvm::FunctionAnalysisManager &AM)
+{
+    bool Changed = false;
+    Changed |= unifyUnreachableBlocks(F);
+    Changed |= unifyReturnBlocks(F);
+    return Changed ? PreservedAnalyses() : llvm::PreservedAnalyses::all();
+}
+
+#endif
+
+} // namespace compat
diff --git a/subprojects/helper-to-tcg/passes/llvm-compat.h b/subprojects/helper-to-tcg/passes/llvm-compat.h
new file mode 100644
index 0000000000..e983ad660e
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/llvm-compat.h
@@ -0,0 +1,143 @@
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
+//
+// The purpose of this file is to both collect and hide most api-specific
+// changes of LLVM [10,14]. Hopefully making it easier to keep track of the
+// changes necessary to support our targeted versions.
+//
+// Note some #ifdefs still remain throughout the codebase for larger codeblocks
+// that are specific enough such that pulling them here would be more cumbersome
+// than it's worth.
+//
+
+#include <llvm/IR/Module.h>
+#include <llvm/IR/PassManager.h>
+
+#if LLVM_VERSION_MAJOR > 11
+#include <llvm/Transforms/Utils/UnifyFunctionExitNodes.h>
+#endif
+
+#if LLVM_VERSION_MAJOR >= 14
+#include <llvm/MC/TargetRegistry.h>
+#else
+#include <llvm/Support/TargetRegistry.h>
+#endif
+
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/PatternMatch.h>
+#include <llvm/Passes/OptimizationLevel.h>
+#include <llvm/Passes/PassBuilder.h>
+#include <llvm/Support/FileSystem.h>
+
+#include <stdint.h>
+
+namespace compat
+{
+
+#if LLVM_VERSION_MAJOR == 14 || LLVM_VERSION_MAJOR == 13
+constexpr auto OpenFlags = llvm::sys::fs::OF_TextWithCRLF;
+#else
+constexpr auto OpenFlags = llvm::sys::fs::OF_Text;
+#endif
+
+#if LLVM_VERSION_MAJOR == 14
+using OptimizationLevel = llvm::OptimizationLevel;
+#else
+using OptimizationLevel = llvm::PassBuilder::OptimizationLevel;
+#endif
+
+#if LLVM_VERSION_MAJOR > 11
+constexpr auto LTOPhase = llvm::ThinOrFullLTOPhase::None;
+#else
+constexpr auto LTOPhase = llvm::PassBuilder::ThinLTOPhase::None;
+#endif
+
+inline llvm::PassBuilder createPassBuilder(llvm::TargetMachine *TM,
+                                           llvm::PipelineTuningOptions &PTO)
+{
+#if LLVM_VERSION_MAJOR == 14 || LLVM_VERSION_MAJOR == 13
+    return llvm::PassBuilder(TM, PTO, llvm::None);
+#elif LLVM_VERSION_MAJOR == 12
+    return llvm::PassBuilder(TM, nullptr, PTO);
+#else
+    return llvm::PassBuilder(TM, PTO);
+#endif
+}
+
+// Wrapper to convert Function- to Module analysis manager
+template <typename T>
+inline const typename T::Result *
+getModuleAnalysisManagerProxyResult(llvm::FunctionAnalysisManager &FAM,
+                                    llvm::Function &F)
+{
+#if LLVM_VERSION_MAJOR > 10
+    auto &MAMProxy = FAM.getResult<llvm::ModuleAnalysisManagerFunctionProxy>(F);
+    return MAMProxy.getCachedResult<T>(*F.getParent());
+#else
+    auto &MAMProxy =
+        FAM.getResult<llvm::ModuleAnalysisManagerFunctionProxy>(F).getManager();
+    return MAMProxy.getCachedResult<T>(*F.getParent());
+#endif
+}
+
+llvm::TargetMachine *getTargetMachine(llvm::Triple &TheTriple);
+
+//
+// LLVM 11 and below does not define the UnifyFunctionExitNodes pass
+// for the new pass manager.  Copy over the definition and use it for
+// 11 and below.
+//
+#if LLVM_VERSION_MAJOR > 11
+using llvm::UnifyFunctionExitNodesPass;
+#else
+class UnifyFunctionExitNodesPass
+    : public llvm::PassInfoMixin<UnifyFunctionExitNodesPass>
+{
+  public:
+    llvm::PreservedAnalyses run(llvm::Function &F,
+                                llvm::FunctionAnalysisManager &AM);
+};
+#endif
+
+inline uint32_t getVectorElementCount(llvm::VectorType *VecTy)
+{
+    auto ElementCount = VecTy->getElementCount();
+#if LLVM_VERSION_MAJOR > 11
+    return ElementCount.getFixedValue();
+#else
+    return ElementCount.Min;
+#endif
+}
+
+//
+// PatternMatch
+//
+
+#if LLVM_VERSION_MAJOR > 10
+#define compat_m_InsertElt llvm::PatternMatch::m_InsertElt
+#define compat_m_Shuffle llvm::PatternMatch::m_Shuffle
+#define compat_m_ZeroMask llvm::PatternMatch::m_ZeroMask
+#else
+#define compat_m_InsertElt llvm::PatternMatch::m_InsertElement
+#define compat_m_Shuffle llvm::PatternMatch::m_ShuffleVector
+#define compat_m_ZeroMask llvm::PatternMatch::m_Zero
+#endif
+
+} // namespace compat
-- 
2.45.2


