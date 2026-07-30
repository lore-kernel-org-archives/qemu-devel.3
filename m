Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4E2C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH76-0004Qv-4t; Wed, 29 Jul 2026 23:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH72-0004FW-FA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:12 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6s-0002xl-4s
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ykgq7m2MwXWBOItfqUBXCnnSV1ZKB1COoa7NuA2wPyE=; b=Nd3NokSIDLPYJ/o
 YwR4bJWTmEfyHuH33xqrIIUNvn78iSD9IwywvNx7l67Hzb3gaDZfTaXjCRt6RSbLz6srD/kPvxByO
 XCq4wDDY70ru/lodstpWFYbU8VUhYV2+wtQB88ZPYPpX5bxndkHAqgACzborFo6AdgVJS7wylpo/R
 +s=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 30/50] helper-to-tcg: Introduce TcgGenPass
Date: Thu, 30 Jul 2026 05:10:04 +0200
Message-ID: <20260730031025.12926-31-anjo@rev.ng>
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

Adds a final backend pass over the LLVM module, taking
previously optimized and canonicalized LLVM IR and for
each function:

  1. Maps arguments, and propagates constant expressions;
  2. Allocates TCG values to non-constants;
  3. Emits the final TCG.

Points above will be implemented in following commits, this commits adds
boilerplate and some scaffolding for translating and emitting code.

TODO: This commit could do with some more splitting, TcgEmit.hpp and
ValueMapping.hpp and the functions therein are referenced but not added
in this commit, they come later.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../helper-to-tcg/include/CmdLineOptions.hpp  |  16 +
 .../helper-to-tcg/include/TcgGenPass.hpp      |  63 +++
 subprojects/helper-to-tcg/meson.build         |   1 +
 subprojects/helper-to-tcg/src/Pipeline.cpp    |  97 ++++-
 .../src/TcgGenPass/TcgGenPass.cpp             | 385 ++++++++++++++++++
 5 files changed, 561 insertions(+), 1 deletion(-)
 create mode 100644 subprojects/helper-to-tcg/include/TcgGenPass.hpp
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/TcgGenPass.cpp

diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
index 3a827f8ab7..1a4c0dd732 100644
--- a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
+++ b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
@@ -28,3 +28,19 @@ extern llvm::cl::opt<std::string> TcgGlobalMappingsName;
 extern llvm::cl::opt<std::string> UserPCRelBranchFunc;
 extern llvm::cl::opt<std::string> UserPCRelBranchFallthroughFunc;
 extern llvm::cl::opt<std::string> UserPCRelBranchConditionalFunc;
+// Options for TcgEmit
+extern llvm::cl::opt<std::string> MmuIndexFunction;
+extern llvm::cl::opt<std::string> TempVectorBlock;
+extern llvm::cl::opt<uint32_t> MaxVectorInstructions;
+extern llvm::cl::opt<uint32_t> MaxVectorTempBytes;
+// Options for MapTemporaries
+extern llvm::cl::opt<uint32_t> GuestPtrSize;
+// Options for TcgGenPass
+extern llvm::cl::opt<std::string> OutputSourceFile;
+extern llvm::cl::opt<std::string> OutputHeaderFile;
+extern llvm::cl::opt<std::string> OutputEnabledFile;
+extern llvm::cl::opt<bool> ErrorOnTranslationFailure;
+extern llvm::cl::opt<bool> StaticOutput;
+extern llvm::cl::opt<bool> AllowDeclCall;
+extern llvm::cl::opt<bool> ForwardContext;
+extern llvm::cl::opt<bool> EmitVectorPreamble;
diff --git a/subprojects/helper-to-tcg/include/TcgGenPass.hpp b/subprojects/helper-to-tcg/include/TcgGenPass.hpp
new file mode 100644
index 0000000000..8318b2c7cd
--- /dev/null
+++ b/subprojects/helper-to-tcg/include/TcgGenPass.hpp
@@ -0,0 +1,63 @@
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
+#include "DebugInfo.hpp"
+#include "FunctionAnnotation.hpp"
+#include "TcgGlobalMap.hpp"
+#include "VectorLayout.hpp"
+
+#include <llvm/IR/PassManager.h>
+
+//
+// TcgGenPass
+//
+// Backend pass responsible for emitting the final TCG code.
+//
+// This pass is further diveded into smaller passes that map arguments,
+// propagate constants, allocate registers, and emit finally TCG.
+//
+// Note, the incoming IR is broken and linearized to an array of basic blocks,
+// which acts to simplify the various backend passes.
+//
+
+class TcgGenPass : public llvm::PassInfoMixin<TcgGenPass> {
+    llvm::raw_ostream &OutSource;
+    llvm::raw_ostream &OutHeader;
+    llvm::raw_ostream &OutHelpers;
+    llvm::raw_ostream &OutEnabled;
+    llvm::StringRef HeaderPath;
+    const AnnotationMapTy &Annotations;
+    const DebugInfoMapTy &DebugInfo;
+    const TcgGlobalMap &TcgGlobals;
+    const VectorLayout &VL;
+
+  public:
+    TcgGenPass(llvm::raw_ostream &OutSource, llvm::raw_ostream &OutHeader,
+               llvm::raw_ostream &OutHelpers, llvm::raw_ostream &OutEnabled,
+               llvm::StringRef HeaderPath, const AnnotationMapTy &Annotations,
+               const DebugInfoMapTy &DebugInfo, const TcgGlobalMap &TcgGlobals,
+               const VectorLayout &VL)
+        : OutSource(OutSource), OutHeader(OutHeader), OutHelpers(OutHelpers),
+          OutEnabled(OutEnabled), HeaderPath(HeaderPath),
+          Annotations(Annotations), DebugInfo(DebugInfo),
+          TcgGlobals(TcgGlobals), VL(VL) {}
+
+    llvm::PreservedAnalyses run(llvm::Module &M,
+                                llvm::ModuleAnalysisManager &MAM);
+};
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index c88c759ba6..880561416a 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -48,6 +48,7 @@ sources = [
     'src/PrepareForTcgPass/TransformGEPs.cpp',
     'src/PrepareForTcgPass/CanonicalizeIR.cpp',
     'src/PrepareForTcgPass/IdentityMap.cpp',
+    'src/TcgGenPass/TcgGenPass.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index 9b45664bdc..6555762b9d 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -19,6 +19,7 @@
 #include "LlvmCompat.hpp"
 #include "PrepareForOptPass.hpp"
 #include "PrepareForTcgPass.hpp"
+#include "TcgGenPass.hpp"
 #include "VectorLayout.hpp"
 
 #if LLVM_VERSION_MAJOR == 15
@@ -46,6 +47,7 @@
 #include <llvm/Support/MathExtras.h>
 #include <llvm/Support/SourceMgr.h>
 #include <llvm/Support/TargetSelect.h>
+#include <llvm/Support/ToolOutputFile.h>
 #include <llvm/Target/TargetMachine.h>
 #include <llvm/Transforms/Scalar/DCE.h>
 #include <llvm/Transforms/Scalar/SROA.h>
@@ -105,7 +107,7 @@ cl::opt<std::string> UserPCRelBranchFallthroughFunc(
              " from inside a conditional block, but that condition isn't taken."
              " and we instead need to fallthrough to the next instruction."),
     cl::init(""), cl::cat(Cat));
- 
+
 static llvm::cl::opt<bool> VecForceBigEndian(
     "vec-force-big-endian",
     cl::desc("Force emission of vector operations as if on a big-endian host."),
@@ -127,6 +129,76 @@ static llvm::cl::opt<LanePreference> VecLane0(
                          "Vector lane 0 is in the most-significant bytes")),
     cl::init(LeastSignificant), cl::cat(Cat));
 
+// Options for TcgEmit
+cl::opt<std::string> MmuIndexFunction(
+    "mmu-index-function",
+    cl::desc("Name of a (uint32_t tb_flag) -> int function returning the "
+             "mmu index from the tb_flags of the current translation block"),
+    cl::init("get_tb_mmu_index"), cl::cat(Cat));
+
+cl::opt<std::string>
+    TempVectorBlock("temp-vector-block",
+                    cl::desc("Name of uint8_t[...] field in CPUArchState used "
+                             "for allocating temporary gvec variables"),
+                    cl::init("tmp_vmem"), cl::cat(Cat));
+
+cl::opt<uint32_t> MaxVectorTempBytes(
+    "max-vector-temp-bytes",
+    cl::desc("Maximum bytes to be allocated for vector temporaries"),
+    cl::init(0), cl::cat(Cat));
+
+cl::opt<uint32_t> MaxVectorInstructions(
+    "max-vector-instructions",
+    cl::desc(
+        "Maximum number of vector instructions an emitted function may have"),
+    cl::init(0), cl::cat(Cat));
+
+// Options for MapTemporaries
+cl::opt<uint32_t>
+    GuestPtrSize("guest-ptr-size",
+                 cl::desc("Pointer size of the guest architecture"),
+                 cl::init(32), cl::cat(Cat));
+
+// Options for TcgGenPass
+cl::opt<std::string> OutputSourceFile("output-source",
+                                      cl::desc("output .c file"),
+                                      cl::init("helper-to-tcg-emitted.c"),
+                                      cl::cat(Cat));
+
+cl::opt<std::string> OutputHeaderFile("output-header",
+                                      cl::desc("output .h file"),
+                                      cl::init("helper-to-tcg-emitted.h"),
+                                      cl::cat(Cat));
+
+cl::opt<std::string> OutputHelpersFile(
+    "output-helpers", cl::desc("output support helper.h file"),
+    cl::init("helper-to-tcg-support-helpers.h"), cl::cat(Cat));
+
+cl::opt<std::string>
+    OutputEnabledFile("output-enabled",
+                      cl::desc("output list of tranlated functions"),
+                      cl::init("helper-to-tcg-enabled"), cl::cat(Cat));
+
+cl::opt<bool>
+    ErrorOnTranslationFailure("error-on-translation-failure",
+                              cl::desc("Abort translation on first failure"),
+                              cl::init(false), cl::cat(Cat));
+
+cl::opt<bool> StaticOutput("static-output",
+                           cl::desc("Statically define output functions"),
+                           cl::init(false), cl::cat(Cat));
+
+cl::opt<bool>
+    AllowDeclCall("allow-decl-call",
+                  cl::desc("Forward calls to declared functions to output"),
+                  cl::init(false), cl::cat(Cat));
+
+cl::opt<bool> ForwardContext(
+    "forward-context",
+    cl::desc(
+        "Pass a DisasContext struct to all translated functions and calls"),
+    cl::init(false), cl::cat(Cat));
+
 // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
 // common per-llvm-target information expected by other LLVM passes, such
 // as the width of the largest scalar/vector registers.  Needed for consistent
@@ -300,5 +372,28 @@ int main(int argc, char **argv) {
         MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
     }
 
+    //
+    // Finally we run a backend pass that converts from LLVM IR to TCG,
+    // and emits the final code.
+    //
+
+    std::error_code EC;
+    ToolOutputFile OutSource(OutputSourceFile, EC, compat::OpenFlags);
+    ToolOutputFile OutHeader(OutputHeaderFile, EC, compat::OpenFlags);
+    ToolOutputFile OutHelpers(OutputHelpersFile, EC, compat::OpenFlags);
+    ToolOutputFile OutEnabled(OutputEnabledFile, EC, compat::OpenFlags);
+    assert(!EC);
+
+    MPM.addPass(TcgGenPass(OutSource.os(), OutHeader.os(), OutHelpers.os(),
+                           OutEnabled.os(), OutputHeaderFile, Annotations,
+                           DebugInfo, TcgGlobals, VL));
+
+    MPM.run(*M.get(), MAM);
+
+    OutSource.keep();
+    OutHeader.keep();
+    OutHelpers.keep();
+    OutEnabled.keep();
+
     return 0;
 }
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/TcgGenPass.cpp b/subprojects/helper-to-tcg/src/TcgGenPass/TcgGenPass.cpp
new file mode 100644
index 0000000000..a831a75204
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/TcgGenPass.cpp
@@ -0,0 +1,385 @@
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
+#include "TcgGenPass.hpp"
+#include "CmdLineOptions.hpp"
+#include "DebugInfo.hpp"
+#include "Error.hpp"
+#include "LinearizeBlocks.hpp"
+#include "TcgEmit.hpp"
+#include "TcgType.hpp"
+#include "ValueMapping.hpp"
+
+#include <llvm/ADT/PostOrderIterator.h>
+#include <llvm/ADT/SmallBitVector.h>
+#include <llvm/ADT/StringRef.h>
+#include <llvm/ADT/StringSet.h>
+#include <llvm/Analysis/CallGraph.h>
+#include <llvm/IR/BasicBlock.h>
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
+#include <llvm/Support/Debug.h>
+#include <llvm/Support/FormatVariadic.h>
+#include <llvm/Support/raw_ostream.h>
+
+#define DEBUG_TYPE "tcg-gen-pass"
+
+using namespace llvm;
+
+struct TranslatedFunction {
+    StringRef Name;
+    std::string Decl;
+    std::string Code;
+    std::string DispatchCode;
+    bool IsHelper;
+    bool HasVectorTemporaries;
+    bool NeedVectorSizeChangeOps;
+};
+
+static Expected<TranslatedFunction>
+translateFunction(Module &M, FunctionAnalysisManager &FAM, Function *F,
+                  const TcgGlobalMap &TcgGlobals,
+                  const AnnotationMapTy &Annotations,
+                  const DebugInfoMapTy &DebugInfo,
+                  const SmallPtrSet<Function *, 16> HasTranslatedFunction) {
+    assert(!F->isDeclaration());
+
+    TranslatedFunction TF = {
+        .Name = F->getName(),
+    };
+
+    {
+        // Remove prefix for helper functions to get cleaner emitted names
+        TF.IsHelper = TF.Name.consume_front("helper_");
+    }
+
+    std::string Body;
+    raw_string_ostream Out(Body);
+    CEmitter CE;
+    TcgEmitter TE(Out, CE);
+    TempAllocationData TAD;
+
+    // Following block of function calls make up the majority of the backend,
+    // the rest is mostly string emission.
+    {
+        // Linearize blocks, putting into a vector and breaking the LLVM IR by
+        // some replacing branches with pseudo instructions.
+        const LinearBlocks Blocks = linearizeBlocks(M, FAM, *F);
+        LLVM_DEBUG({
+            dbgs() << "Translating " << F->getName() << "\n";
+            for (auto &BB : Blocks) {
+                dbgs() << *BB << "\n";
+            }
+        });
+
+        // Map arguments to `TcgV`, store results in `TempAllocationData`.
+        if (auto Err = mapArguments(*F, Annotations, DebugInfo, TAD); Err) {
+            return Err;
+        }
+
+        // Make a forward pass over the IR, and propagate constant expressions
+        // forward, assigning them to values in `TempAllocationData`.
+        if (auto Err = propagateConstantExpressions(CE, *F, Blocks, Annotations,
+                                                    DebugInfo, TcgGlobals, TAD);
+            Err) {
+            return Err;
+        }
+
+        // Make a backward pass over the IR and assign temporary `TcgV`s to
+        // non-constant expressions, attempt to reuse created temporaries.
+        // Mapped temporaries are stored in `TempAllocationData`.
+        if (auto Err = allocateTemporaries(*F, Blocks, Annotations, DebugInfo,
+                                           CE, TcgGlobals, TAD);
+            Err) {
+            return Err;
+        }
+
+        // At this point all `Value`s in the function have been mapped to either
+        // a temporary or a constant expression, with the exception of labels.
+        // Make a forward pass over the IR and emit the final TCG operations.
+        if (auto Err = mapTcgOperations(Blocks, TcgGlobals, Annotations,
+                                        HasTranslatedFunction, TAD, TE, CE);
+            Err) {
+            return Err;
+        }
+    }
+
+    Out.flush();
+
+    raw_string_ostream OutFunc(TF.Code);
+    raw_string_ostream HeaderWriter(TF.Decl);
+    raw_string_ostream DispatchWriter(TF.DispatchCode);
+    std::string DispatchCall;
+    raw_string_ostream DispatchCallWriter(DispatchCall);
+    bool IsVectorInst = false;
+
+    if (StaticOutput) {
+        HeaderWriter << "static ";
+    }
+    HeaderWriter << "void " << "emit_" << TF.Name << '(';
+    SmallVector<TcgV, 4> CArgs;
+
+    if (!F->getReturnType()->isVoidTy()) {
+        assert(TAD.hasReturnValue());
+        IsVectorInst = (TAD.ReturnValue.Kind == IrPtrToOffset);
+        CArgs.push_back(TAD.ReturnValue);
+    }
+
+    for (const Argument &Arg : F->args()) {
+        TcgV T = TAD.Map[&Arg];
+        IsVectorInst |= (T.Kind == IrPtrToOffset);
+        CArgs.push_back(T);
+    }
+
+    if (ForwardContext) {
+        HeaderWriter << "DisasContext *ctx";
+        if (!CArgs.empty()) {
+            HeaderWriter << ", ";
+        }
+    }
+
+    auto CArgIt = CArgs.begin();
+    if (CArgIt != CArgs.end()) {
+        HeaderWriter << TE.getType(*CArgIt) << ' ' << getName(*CArgIt);
+        ++CArgIt;
+    }
+    while (CArgIt != CArgs.end()) {
+        HeaderWriter << ", " << TE.getType(*CArgIt) << ' ' << getName(*CArgIt);
+        ++CArgIt;
+    }
+
+    if (!IsVectorInst) {
+        DispatchCallWriter << "emit_" << TF.Name << "(";
+        auto CArgIt = CArgs.begin();
+        if (CArgIt != CArgs.end()) {
+            DispatchWriter << "static inline void gen_helper_" << TF.Name
+                           << "(";
+            for (int i = 0; i < CArgs.size(); ++i) {
+                if (i > 0) {
+                    DispatchWriter << ", ";
+                }
+                DispatchWriter << TE.getType(TE.materialize(CArgs[i])) << " "
+                               << getName(CArgs[i]);
+            }
+            DispatchWriter << ")\n{\n";
+
+            DispatchWriter << "emit_" << TF.Name << "(";
+            for (int i = 0; i < CArgs.size(); ++i) {
+                if (i > 0) {
+                    DispatchWriter << ", ";
+                }
+                if (CArgs[i].Kind == IrImmediate) {
+                    DispatchWriter << "tcgv_i" << CArgs[i].tcgBitWidth()
+                                   << "_temp(" << getName(CArgs[i]) << ")->val";
+                } else {
+                    DispatchWriter << getName(CArgs[i]);
+                }
+            }
+            DispatchWriter << ");\n}\n";
+        }
+    }
+
+    // Copy over function declaration from header to source file
+    HeaderWriter << ')';
+
+    OutFunc << "// " << *F->getReturnType() << ' ' << F->getName() << '\n';
+    OutFunc << HeaderWriter.str();
+    OutFunc << " {\n";
+    OutFunc << Body;
+    OutFunc << "}\n";
+
+    HeaderWriter << ';';
+
+    if (MaxVectorTempBytes > 0 and
+        TE.allocatedVectorMemory() > MaxVectorTempBytes) {
+        return mkError(formatv("Uses too much vector memory: {0} > {1}",
+                               TE.allocatedVectorMemory(), MaxVectorTempBytes)
+                           .str());
+    }
+
+    if (MaxVectorInstructions > 0 and
+        TE.numVectorInstructions() > MaxVectorInstructions) {
+        return mkError(formatv("Uses too many vector instructions: {0} > {1}",
+                               TE.numVectorInstructions(),
+                               MaxVectorInstructions)
+                           .str());
+    }
+
+    TF.HasVectorTemporaries = (TE.allocatedVectorMemory() > 0);
+    TF.NeedVectorSizeChangeOps = TE.NeedVectorSizeChangeOps;
+
+    HeaderWriter.flush();
+    DispatchWriter.flush();
+    DispatchCallWriter.flush();
+
+    return TF;
+}
+
+PreservedAnalyses TcgGenPass::run(Module &M, ModuleAnalysisManager &MAM) {
+    auto &CG = MAM.getResult<CallGraphAnalysis>(M);
+    auto &FAM =
+        MAM.getResult<FunctionAnalysisManagerModuleProxy>(M).getManager();
+
+    // Vector of translation results, order matters, lower indices are emitted
+    // higher up in the output file, and may be used by the higher indices.
+    SmallVector<TranslatedFunction, 16> TranslatedFunctions;
+    // Two sets used for quickly looking up whether or not a function has
+    // already been translated, or the translation failed.
+    SmallPtrSet<Function *, 16> FailedToTranslateFunction;
+    SmallPtrSet<Function *, 16> HasTranslatedFunction;
+    bool NeedVectorMem = false;
+    bool NeedVectorSizeChangeOps = false;
+    for (Function &F : M) {
+        if (F.isDeclaration()) {
+            continue;
+        }
+
+        // Depth first traversal of call graph.  Needed to ensure called
+        // functions are translated before the current function.
+        CallGraphNode *Node = CG[&F];
+        for (auto *N : make_range(po_begin(Node), po_end(Node))) {
+            Function *F = N->getFunction();
+
+            // If F in the call graph has already been translated and failed,
+            // abort translation of the current function.
+            if (FailedToTranslateFunction.contains(F)) {
+                break;
+            }
+
+            // Skip translation of invalid functions or functions that have
+            // already been translated.
+            if (!F or F->isDeclaration() or HasTranslatedFunction.contains(F)) {
+                continue;
+            }
+
+            // Reset variable IDs for the current function, since al TcgVs are
+            // function-local.
+            TcgV::resetId();
+
+            auto Translated =
+                translateFunction(M, FAM, F, TcgGlobals, Annotations, DebugInfo,
+                                  HasTranslatedFunction);
+            if (!Translated) {
+                FailedToTranslateFunction.insert(F);
+                LLVM_DEBUG({
+                    dbgs() << F->getName() << ": " << Translated.takeError()
+                           << "\n";
+                });
+                if (ErrorOnTranslationFailure) {
+                    return PreservedAnalyses::all();
+                }
+            } else {
+                TranslatedFunctions.push_back(*Translated);
+                HasTranslatedFunction.insert(F);
+                NeedVectorMem |= Translated->HasVectorTemporaries;
+                NeedVectorSizeChangeOps |= Translated->NeedVectorSizeChangeOps;
+            }
+        }
+    }
+
+    // Preamble
+    OutSource << "#include \"qemu/osdep.h\"\n";
+    OutSource << "#include \"qemu/log.h\"\n";
+    OutSource << "#include \"cpu.h\"\n";
+    OutSource << "#include \"translate.h\"\n";
+    OutSource << "#include \"tcg/tcg-op.h\"\n";
+    OutSource << "#include \"tcg/tcg-op-gvec.h\"\n";
+    OutSource << "#include \"tcg/tcg.h\"\n";
+    // OutSource << "#include \"exec/helper-gen.h\"\n";
+    if (ForwardContext) {
+        OutSource << "#include \"translate.h\"\n";
+    }
+    if (!StaticOutput) {
+        OutSource << "#include \"tcg/tcg-global-mappings.h\"\n";
+    }
+    if (MmuIndexFunction.size() > 0) {
+        OutSource << "#include \"exec/translation-block.h\"";
+    }
+    OutSource << '\n';
+
+    if (!StaticOutput) {
+        OutSource << "#include \""
+                  << HeaderPath.substr(HeaderPath.find_last_of('/') + 1)
+                  << "\"\n";
+        OutSource << '\n';
+
+        // Emit extern definitions for all global TCGv_* that are mapped
+        // to the CPUState.
+        for (size_t TypeIndex = 0; TypeIndex < TcgGlobals.size(); ++TypeIndex) {
+            for (auto &P : TcgGlobals[TypeIndex]) {
+                const TcgGlobal &Global = P.second;
+                auto Size = ValueSize::fromBitWidth(Global.Size);
+                assert(Size);
+                OutSource << "extern " << "TCGv_i" << (int)Size->TcgBitWidth
+                          << " " << Global.Code;
+                if (Global.NumElements > 1) {
+                    OutSource << "[" << Global.NumElements << "]";
+                }
+                OutSource << ";\n";
+            }
+        }
+    }
+
+    if (NeedVectorSizeChangeOps) {
+        emitVectorSizeChangeOps(OutSource, OutHelpers, VL);
+    }
+
+    if (NeedVectorMem) {
+        emitVectorMem(OutSource);
+    }
+
+    if (ForwardContext) {
+        OutHeader << "struct DisasContext;\n";
+        OutHeader << "typedef struct DisasContext DisasContext;\n";
+        OutSource << "#include \"translate.h\"\n";
+    }
+
+    // Emit translated functions
+    for (auto &TF : TranslatedFunctions) {
+        OutSource << TF.Code << '\n';
+        OutHeader << TF.Decl << '\n';
+        OutEnabled << TF.Name << '\n';
+    }
+
+    // Emit a dispatched to go from helper function address to our
+    // emitted code, if we succeeded.
+    OutHeader << "bool helper_to_tcg_dispatcher(void *func, TCGTemp *ret_temp, "
+                 "int nargs, TCGTemp **args);\n";
+
+    OutHeader << "#include \"tcg/helper-info.h\"\n";
+    OutHeader << "#include \"exec/helper-head.h.inc\"\n";
+    for (Function &F : M) {
+        StringRef Name = F.getName();
+        if (!Name.consume_front("helper_")) {
+            continue;
+        }
+        if (!HasTranslatedFunction.contains(&F)) {
+            SmallVector<Type *> ArgTys;
+            for (auto &A : F.args()) {
+                ArgTys.push_back(A.getType());
+            }
+            emitHelperGen(OutHeader, Name, F.getReturnType(), ArgTys);
+        }
+    }
+    for (TranslatedFunction &TF : TranslatedFunctions) {
+        OutHeader << TF.DispatchCode;
+    }
+
+    return PreservedAnalyses::all();
+}
-- 
2.52.0


