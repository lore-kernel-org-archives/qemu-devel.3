Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B4C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5v-0001qx-3L; Wed, 29 Jul 2026 23:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5t-0001n4-8H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5q-0002sX-Sr
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=a1qsAGaR4LgJCtj8xxxYgcUmd5Ee5pQgbWSEUkovCOw=; b=VpMiZYIdCe4EFW5
 DCugNvwK01PdWBzw8Kqb0YDsNUo8BlQ9769ikHtMzQYgqmcleG9YOlxE+fOKIIjhUYNhQvmQ7ExVp
 VGMCBDDUwWZhlp3Td+6sKweqi7FbyKJkLT1koPrQ0z8a893+7gItlJc1S5Gp177hHPsqZYUzyWpXF
 HA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 08/50] helper-to-tcg: Handle LLVM version compatibility
Date: Thu, 30 Jul 2026 05:09:42 +0200
Message-ID: <20260730031025.12926-9-anjo@rev.ng>
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

Adds a translation unit with the sole purpose of handling inter-LLVM
code changes.  Instead of littering the code with #ifdefs, most of them
will be limited to LlvmCompat.[cpp|hpp] and a saner compat::*() function
is exposed in its place.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/LlvmCompat.hpp      | 124 ++++++++++++++++++
 subprojects/helper-to-tcg/meson.build         |   1 +
 subprojects/helper-to-tcg/src/LlvmCompat.cpp  |  89 +++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/include/LlvmCompat.hpp
 create mode 100644 subprojects/helper-to-tcg/src/LlvmCompat.cpp

diff --git a/subprojects/helper-to-tcg/include/LlvmCompat.hpp b/subprojects/helper-to-tcg/include/LlvmCompat.hpp
new file mode 100644
index 0000000000..78822ca87b
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/LlvmCompat.hpp
@@ -0,0 +1,124 @@
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
+#include <llvm/Analysis/TargetTransformInfo.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Intrinsics.h>
+#include <llvm/IR/Module.h>
+#include <llvm/IR/PassManager.h>
+#include <llvm/IR/PatternMatch.h>
+#include <llvm/MC/TargetRegistry.h>
+#include <llvm/Passes/OptimizationLevel.h>
+#include <llvm/Passes/PassBuilder.h>
+#include <llvm/Support/FileSystem.h>
+#include <llvm/Transforms/Utils/UnifyFunctionExitNodes.h>
+
+#include <stdint.h>
+
+namespace compat {
+
+constexpr auto OpenFlags = llvm::sys::fs::OF_TextWithCRLF;
+
+using OptimizationLevel = llvm::OptimizationLevel;
+
+constexpr auto LTOPhase = llvm::ThinOrFullLTOPhase::None;
+
+inline llvm::PassBuilder createPassBuilder(llvm::TargetMachine *TM,
+                                           llvm::PipelineTuningOptions &PTO) {
+#if LLVM_VERSION_MAJOR >= 16
+    return llvm::PassBuilder(TM, PTO, std::nullopt);
+#else
+    return llvm::PassBuilder(TM, PTO, llvm::None);
+#endif
+}
+
+// LLVM 16 changes the getFixedSize() -> getFixedValue()
+size_t getTypeAllocSize(const llvm::DataLayout &DL, llvm::Type *Ty);
+
+// These rely on string comparison with QEMU names using StringRef::startswith,
+// which changed to StringRef::starts_with in LLVM 18.
+bool isFunctionQemuHelper(llvm::StringRef Name);
+bool isFunctionQemuLoadStore(llvm::StringRef Name);
+
+// LLVM 21 moved to initializing a TargetTransformInfo via unique_ptr,
+// instead of by value.
+template <typename T>
+auto makeTTI(llvm::TargetMachine *TM, const llvm::Function &F) {
+    // Use explicit TargetTransformInfo() contructor
+#if LLVM_VERSION_MAJOR >= 21
+    return llvm::TargetTransformInfo(std::make_unique<T>(TM, F));
+#else
+    return llvm::TargetTransformInfo(T(TM, F));
+#endif
+}
+
+// Note, since constexpr auto is used to alias a function, default
+// arguments won't work.
+//
+// LLVM 20 deprecated getDeclaration() in favour of getOrInsertDeclaration()
+namespace Intrinsic {
+#if LLVM_VERSION_MAJOR >= 20
+constexpr auto getOrInsertDeclaration = llvm::Intrinsic::getOrInsertDeclaration;
+#else
+constexpr auto getOrInsertDeclaration = llvm::Intrinsic::getDeclaration;
+#endif
+} // namespace Intrinsic
+
+// Wrapper to convert Function- to Module analysis manager
+template <typename T>
+inline const typename T::Result *
+getModuleAnalysisManagerProxyResult(llvm::FunctionAnalysisManager &FAM,
+                                    llvm::Function &F) {
+    auto &MAMProxy = FAM.getResult<llvm::ModuleAnalysisManagerFunctionProxy>(F);
+    return MAMProxy.getCachedResult<T>(*F.getParent());
+}
+
+llvm::TargetMachine *getTargetMachine(llvm::Triple &TheTriple);
+
+//
+// LLVM 11 and below does not define the UnifyFunctionExitNodes pass
+// for the new pass manager.  Copy over the definition and use it for
+// 11 and below.
+//
+using llvm::UnifyFunctionExitNodesPass;
+
+inline uint32_t getVectorElementCount(const llvm::VectorType *VecTy) {
+    auto ElementCount = VecTy->getElementCount();
+    return ElementCount.getFixedValue();
+}
+
+//
+// PatternMatch
+//
+
+#define compat_m_InsertElt llvm::PatternMatch::m_InsertElt
+#define compat_m_Shuffle llvm::PatternMatch::m_Shuffle
+#define compat_m_ZeroMask llvm::PatternMatch::m_ZeroMask
+
+} // namespace compat
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 97bce186fe..965014c988 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -40,6 +40,7 @@ if version_major < 10 or version_major > 21
 endif
 
 sources = [
+    'src/LlvmCompat.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/LlvmCompat.cpp b/subprojects/helper-to-tcg/src/LlvmCompat.cpp
new file mode 100644
index 0000000000..3a1995391c
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/LlvmCompat.cpp
@@ -0,0 +1,89 @@
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
+#include "LlvmCompat.hpp"
+
+#include <llvm/CodeGen/CommandFlags.h>
+#include <llvm/Support/CodeGen.h>
+
+#include <string>
+
+// Static variables required by LLVM
+//
+// Defining RegisterCodeGenFlags with static duration registers extra
+// codegen commandline flags for specifying the target arch.
+static llvm::codegen::RegisterCodeGenFlags CGF;
+static llvm::ExitOnError ExitOnErr;
+
+namespace compat {
+
+using namespace llvm;
+
+size_t getTypeAllocSize(const llvm::DataLayout &DL, llvm::Type *Ty) {
+#if LLVM_VERSION_MAJOR >= 16
+    return DL.getTypeAllocSize(Ty).getFixedValue();
+#else
+    return DL.getTypeAllocSize(Ty).getFixedSize();
+#endif
+}
+
+bool isFunctionQemuHelper(StringRef Name) {
+#if LLVM_VERSION_MAJOR >= 18
+    return Name.starts_with("helper_");
+#else
+    return Name.startswith("helper_");
+#endif
+}
+
+bool isFunctionQemuLoadStore(StringRef Name) {
+#if LLVM_VERSION_MAJOR >= 18
+    return Name.starts_with("cpu_ld") or Name.starts_with("cpu_st");
+#else
+    return Name.startswith("cpu_ld") or Name.startswith("cpu_st");
+#endif
+}
+
+llvm::TargetMachine *getTargetMachine(llvm::Triple &TheTriple) {
+    const TargetOptions Options{};
+    std::string Error;
+    const Target *TheTarget = llvm::TargetRegistry::lookupTarget(
+        llvm::codegen::getMArch(), TheTriple, Error);
+    // Some modules don't specify a triple, and this is okay.
+    if (!TheTarget) {
+        return nullptr;
+    }
+
+#if LLVM_VERSION_MAJOR >= 18
+    auto Level = llvm::CodeGenOptLevel::Aggressive;
+#else
+    auto Level = llvm::CodeGenOpt::Aggressive;
+#endif
+
+#if LLVM_VERSION_MAJOR >= 21
+    return TheTarget->createTargetMachine(
+        llvm::Triple(TheTriple.getTriple()), llvm::codegen::getCPUStr(),
+        llvm::codegen::getFeaturesStr(), Options,
+        llvm::codegen::getExplicitRelocModel(),
+        llvm::codegen::getExplicitCodeModel(), Level);
+#else
+    return TheTarget->createTargetMachine(
+        TheTriple.getTriple(), llvm::codegen::getCPUStr(),
+        llvm::codegen::getFeaturesStr(), Options, {}, {}, Level);
+#endif
+}
+
+} // namespace compat
-- 
2.52.0


