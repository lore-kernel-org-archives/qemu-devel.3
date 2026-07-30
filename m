Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06675C55160
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH6r-0003xB-83; Wed, 29 Jul 2026 23:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6n-0003ow-Pw
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:58 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH6i-0002wv-N9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=KEcf/6fUzAX7NA/vh4m4OtuUSMiXhSnGfIf10mAjLT4=; b=qaDsGmiWzf73uLh
 v6WHX3jbp7t6ez1TAW1XLUZgPsrqR60BV3EM+azj29SCqf95hOBx491dD3azUx6xZq+crCJfwKBzW
 ejvo/whh0u/jpQxSPRZlVqESZHWaC08FNSYfdqRerOw649zR54PxLpIONr5fPjkjFlEjMuZHOfq8c
 LI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 26/50] helper-to-tcg: PrepareForTcgPass, transform GEPs
Date: Thu, 30 Jul 2026 05:10:00 +0200
Message-ID: <20260730031025.12926-27-anjo@rev.ng>
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

getelementpointer (GEP) instructions in LLVM IR represent general pointer
arithmetic (struct field access, array indexing, ...).  From the
perspective of TCG, three distinct cases are important and are
transformed into pseudo instructions respectively:

  * Struct accesses whose offset into the struct map to a TCG global are
    transformed into `call @AccessGlobalValue(structindex, offset)`;

  * Struct accesses whose offset into the struct map to an array of TCG
    globals are transformed into `call @AccessGlobalArray(structindex, offset, index)`;

  * Otherwise, access is converted to general pointer arithmetic in LLVM IR using
    `call @PtrAdd(...)`.

These three cases are treated differently in the backend and all other
GEPs are considered erroneous.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 .../include/PrepareForTcgPass.hpp             |   7 +-
 subprojects/helper-to-tcg/meson.build         |   1 +
 subprojects/helper-to-tcg/src/Pipeline.cpp    |   2 +-
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |   4 +
 .../src/PrepareForTcgPass/TransformGEPs.cpp   | 355 ++++++++++++++++++
 .../src/PrepareForTcgPass/TransformGEPs.hpp   |  45 +++
 6 files changed, 411 insertions(+), 3 deletions(-)
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.cpp
 create mode 100644 subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.hpp

diff --git a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
index 3e0679b46c..d0cd6e3cbd 100644
--- a/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
+++ b/subprojects/helper-to-tcg/include/PrepareForTcgPass.hpp
@@ -17,15 +17,18 @@
 
 #pragma once
 
+#include "DebugInfo.hpp"
 #include "TcgGlobalMap.hpp"
 #include <llvm/IR/PassManager.h>
 
 class PrepareForTcgPass : public llvm::PassInfoMixin<PrepareForTcgPass> {
     TcgGlobalMap &ResultTcgGlobalMap;
+    const DebugInfoMapTy &DebugInfo;
 
 public:
-    PrepareForTcgPass(TcgGlobalMap &ResultTcgGlobalMap)
-        : ResultTcgGlobalMap(ResultTcgGlobalMap) {}
+    PrepareForTcgPass(TcgGlobalMap &ResultTcgGlobalMap,
+                      const DebugInfoMapTy &DebugInfo)
+        : ResultTcgGlobalMap(ResultTcgGlobalMap), DebugInfo(DebugInfo) {}
     llvm::PreservedAnalyses run(llvm::Module &M,
                                 llvm::ModuleAnalysisManager &MAM);
 };
diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index c2926652f3..564191d328 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -45,6 +45,7 @@ sources = [
     'src/PrepareForOptPass/PrepareForOptPass.cpp',
     'src/PseudoInst.cpp',
     'src/PrepareForTcgPass/PrepareForTcgPass.cpp',
+    'src/PrepareForTcgPass/TransformGEPs.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
index f24bb67f0c..9212bba29f 100644
--- a/subprojects/helper-to-tcg/src/Pipeline.cpp
+++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
@@ -231,7 +231,7 @@ int main(int argc, char **argv) {
     //
 
     TcgGlobalMap TcgGlobals;
-    MPM.addPass(PrepareForTcgPass(TcgGlobals));
+    MPM.addPass(PrepareForTcgPass(TcgGlobals, DebugInfo));
     MPM.addPass(VerifierPass());
     {
         FunctionPassManager FPM;
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
index 69add43529..10129fa245 100644
--- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -17,6 +17,7 @@
 
 #include "PrepareForTcgPass.hpp"
 #include "CmdLineOptions.hpp"
+#include "TransformGEPs.hpp"
 
 #include <llvm/ADT/SCCIterator.h>
 #include <llvm/ADT/SmallPtrSet.h>
@@ -136,5 +137,8 @@ PreservedAnalyses PrepareForTcgPass::run(Module &M,
         demotePhis(F);
     }
     const StringMap<size_t> TypeIndexMap = collectTcgGlobals(M, ResultTcgGlobalMap);
+    for (Function &F : M) {
+        transformGEPs(M, F, ResultTcgGlobalMap, TypeIndexMap, DebugInfo);
+    }
     return PreservedAnalyses::none();
 }
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.cpp
new file mode 100644
index 0000000000..f4c4a5b22d
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.cpp
@@ -0,0 +1,355 @@
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
+#include "TransformGEPs.hpp"
+#include "DebugInfo.hpp"
+#include "LlvmCompat.hpp"
+#include "Error.hpp"
+#include "PseudoInst.hpp"
+
+#include <llvm/ADT/SmallSet.h>
+#include <llvm/ADT/SmallVector.h>
+#include <llvm/ADT/iterator_range.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/IRBuilder.h>
+#include <llvm/IR/InstIterator.h>
+#include <llvm/IR/Module.h>
+#include <llvm/IR/Operator.h>
+#include <llvm/IR/Value.h>
+#include <llvm/Support/Debug.h>
+
+#define DEBUG_TYPE "transform-geps"
+
+using namespace llvm;
+
+// collectIndices will, given a getelementptr (GEP) instruction, construct an
+// array of GepIndex structs keeping track of the total offset into the struct
+// along with some access information.  For instance,
+//
+//   struct SubS {
+//      uint8_t a;
+//      uint8_t b;
+//      uint8_t c;
+//   };
+//
+//   struct S {
+//      uint64_t i;
+//      struct SubS sub[3];
+//   };
+//
+//   void f(struct S *s, int idx) {
+//      S->sub[idx].a = ...
+//      S->sub[idx].b = ...
+//      S->sub[idx].c = ...
+//   }
+//
+// would correspond to the following GEPs
+//
+//   getelementptr %struct.S, %struct.S* %s, i64 0, i32 1, %idx, i32 0
+//   getelementptr %struct.S, %struct.S* %s, i64 0, i32 1, %idx, i32 1
+//   getelementptr %struct.S, %struct.S* %s, i64 0, i32 1, %idx, i32 2
+//
+// or the following GepIndex's
+//
+//   GepIndex{Size=0,false}, GepIndex{Size=8,false}, GepIndex{Size=4,true},
+//   GepIndex{Size=0,false} GepIndex{Size=0,false}, GepIndex{Size=8,false},
+//   GepIndex{Size=4,true}, GepIndex{Size=1,false} GepIndex{Size=0,false},
+//   GepIndex{Size=8,false}, GepIndex{Size=4,true}, GepIndex{Size=2,false}
+//
+
+struct GepIndex {
+    Value *V;
+    uint64_t Size;
+    bool IsArrayAccess = false;
+};
+
+using GepIndices = SmallVector<GepIndex, 2>;
+
+struct GlobalAccessInfo {
+    uint64_t Offset;
+    StringRef BaseTypeName;
+    Value *LastArrayIndex;
+};
+
+using GlobalAccessMap = DenseMap<Value *, GlobalAccessInfo>;
+
+static Expected<GepIndices> collectIndices(const DataLayout &DL,
+                                           GEPOperator *Gep) {
+    Type *PtrOpTy = Gep->getPointerOperandType();
+    if (!PtrOpTy->isPointerTy()) {
+        return mkError("GEPs on vectors are not handled!");
+    }
+    Type *InternalTy = Type::getIntNTy(Gep->getContext(), 64);
+    auto *One = ConstantInt::get(InternalTy, 1u);
+
+    GepIndices Result;
+    Type *CurrentTy = PtrOpTy;
+
+    // Handle initial pointer dereference
+    auto Begin = Gep->idx_begin();
+    {
+        CurrentTy = Gep->getSourceElementType();
+        const size_t FixedSize = compat::getTypeAllocSize(DL, CurrentTy);
+        Result.push_back(GepIndex{*Begin, FixedSize});
+        ++Begin;
+    }
+
+    for (auto &Arg : make_range(Begin, Gep->idx_end())) {
+        switch (CurrentTy->getTypeID()) {
+        case Type::ArrayTyID: {
+            CurrentTy = cast<ArrayType>(CurrentTy)->getElementType();
+            const size_t FixedSize = compat::getTypeAllocSize(DL, CurrentTy);
+            Result.push_back(
+                GepIndex{Arg.get(), FixedSize, /* IsArrayAccess= */ true});
+        } break;
+        case Type::StructTyID: {
+            auto *StructTy = cast<StructType>(CurrentTy);
+            auto *Constant = dyn_cast<ConstantInt>(Arg.get());
+            if (Constant->getBitWidth() > DL.getPointerSizeInBits()) {
+                return mkError(
+                    "GEP to struct with unsupported index bit width!");
+            }
+            uint64_t ConstantValue = Constant->getZExtValue();
+            uint64_t ElementOffset =
+                DL.getStructLayout(StructTy)->getElementOffset(ConstantValue);
+            CurrentTy = StructTy->getTypeAtIndex(ConstantValue);
+            Result.push_back(GepIndex{One, ElementOffset});
+        } break;
+        default:
+            return mkError("GEP unsupported index type: ");
+        }
+    }
+
+    return Result;
+}
+
+// Takes indices associated with a getelementpointer instruction and expands
+// it into pointer math.
+static void replaceGEPWithPointerMath(Module &M, Instruction *ParentInst,
+                                      GEPOperator *Gep,
+                                      const GepIndices &Indices) {
+    assert(Indices.size() > 0);
+    IRBuilder<> Builder(ParentInst);
+    Value *PtrOp = Gep->getPointerOperand();
+
+    // Sum indices to get the total offset from the base pointer
+    Value *PrevV = nullptr;
+    for (auto &Index : Indices) {
+        Value *Mul = Builder.CreateMul(
+            Index.V, ConstantInt::get(Index.V->getType(), Index.Size));
+        if (PrevV) {
+            uint32_t BitWidthLeft =
+                cast<IntegerType>(PrevV->getType())->getIntegerBitWidth();
+            uint32_t BitWidthRight =
+                cast<IntegerType>(Mul->getType())->getIntegerBitWidth();
+            if (BitWidthLeft < BitWidthRight) {
+                PrevV = Builder.CreateZExt(PrevV, Mul->getType());
+            } else if (BitWidthLeft > BitWidthRight) {
+                Mul = Builder.CreateZExt(Mul, PrevV->getType());
+            }
+            PrevV = Builder.CreateAdd(PrevV, Mul);
+        } else {
+            PrevV = Mul;
+        }
+    }
+
+    Gep->replaceAllUsesWith(createPseudoInstCall(
+        M, Builder, PtrAdd, Gep->getType(), {PtrOp, PrevV}));
+}
+
+// Takes indices associated with a getelementpointer instruction and expands
+// it into pointer math.
+static Value *replaceGEPWithGlobalAccess(Module &M, Instruction *ParentInst,
+                                         GEPOperator *Gep, size_t TypeIndex,
+                                         uint64_t BaseOffset,
+                                         Value *ArrayIndex) {
+    CallInst *Call;
+    IRBuilder<> Builder(ParentInst);
+    Type *IndexTy = Type::getIntNTy(M.getContext(), 64);
+    auto *ConstBaseOffset = ConstantInt::get(IndexTy, BaseOffset);
+    auto *ConstTypeIndex = ConstantInt::get(IndexTy, TypeIndex);
+    if (ArrayIndex) {
+        Call =
+            createPseudoInstCall(M, Builder, AccessGlobalArray, Gep->getType(),
+                                 {ConstTypeIndex, ConstBaseOffset, ArrayIndex});
+    } else {
+        Call =
+            createPseudoInstCall(M, Builder, AccessGlobalValue, Gep->getType(),
+                                 {ConstTypeIndex, ConstBaseOffset});
+    }
+    Gep->replaceAllUsesWith(Call);
+    return cast<Value>(Call);
+}
+
+static bool transformGEP(Module &M, const TcgGlobalMap &TcgGlobals,
+                         GlobalAccessMap &GAMap,
+                         const StringMap<size_t> &TypeIndexMap,
+                         const DebugInfoMapTy &DebugInfo,
+                         const GepIndices &Indices, Instruction *ParentInst,
+                         GEPOperator *Gep) {
+    GlobalAccessInfo Info{};
+    uint32_t NumArrayAccesses = 0;
+    for (const GepIndex &Index : Indices) {
+        if (Index.IsArrayAccess) {
+            Info.LastArrayIndex = Index.V;
+            ++NumArrayAccesses;
+        } else if (auto *Const = dyn_cast<ConstantInt>(Index.V)) {
+            Info.Offset += Const->getZExtValue() * Index.Size;
+        }
+    }
+
+    Value *PtrOp = Gep->getPointerOperand();
+    bool IsGlobalAccess = isa<Argument>(PtrOp);
+    if (auto It = GAMap.find(PtrOp); It != GAMap.end()) {
+        Info.Offset += It->second.Offset;
+        Info.BaseTypeName = It->second.BaseTypeName;
+        assert(!Info.LastArrayIndex or !It->second.LastArrayIndex);
+        if (It->second.LastArrayIndex) {
+            Info.LastArrayIndex = It->second.LastArrayIndex;
+        }
+        IsGlobalAccess = true;
+    } else if (auto It = DebugInfo.find(PtrOp); It != DebugInfo.end()) {
+        Info.BaseTypeName = It->second.BaseTypeName;
+    }
+
+    bool PtrHasMapping =
+        !Info.BaseTypeName.empty() and TypeIndexMap.count(Info.BaseTypeName);
+
+    LLVM_DEBUG({
+        dbgs() << "For " << *Gep << "\n";
+        dbgs() << "  has mapping: " << PtrHasMapping << "\n";
+        dbgs() << "  is global access: " << IsGlobalAccess << "\n";
+    });
+
+    if (IsGlobalAccess and PtrHasMapping and NumArrayAccesses <= 1) {
+
+        if (!isa<ConstantExpr>(Gep)) {
+            bool HasOnlyGEPUsers = true;
+            for (auto *U : cast<Instruction>(Gep)->users()) {
+                if (!isa<GEPOperator>(U)) {
+                    HasOnlyGEPUsers = false;
+                    break;
+                }
+            }
+            if (HasOnlyGEPUsers) {
+                GAMap[cast<Value>(Gep)] = Info;
+                return true;
+            }
+        }
+
+        const size_t Index = TypeIndexMap.lookup(Info.BaseTypeName);
+
+        // Array accesses, particularly those to an array at the beginning of a
+        // mapped structs, e.g. `uint32_t v = env->gpr[40]`, might appear either
+        // as
+        //
+        //   getelementptr struct.CPUArchState, ptr %0, i64 0, i64 40,
+        //
+        // or
+        //
+        //   getelementptr i8, ptr %0, i64 160.
+        //
+        // The former and simpler one being more common in older LLVM versions.
+        // For the latter we need to manually compute the array index.
+        for (auto &P : TcgGlobals[Index]) {
+            const TcgGlobal Global = P.second;
+            if ((Global.NumElements == 1 and Info.Offset == P.first) or
+                (Info.Offset >= P.first and
+                 Info.Offset < P.first + Global.NumElements * Global.Stride)) {
+                Value *ArrayIndexV = Info.LastArrayIndex;
+                if (Global.NumElements > 1 and !Info.LastArrayIndex) {
+                    assert(Global.Stride > 0);
+                    uint64_t ArrayIndex =
+                        (Info.Offset - P.first) / Global.Stride;
+                    Info.Offset = P.first;
+                    ArrayIndexV = ConstantInt::get(
+                        Type::getInt64Ty(M.getContext()), ArrayIndex);
+                }
+
+                LLVM_DEBUG(dbgs() << "  replacing with global access\n");
+                Value *Access = replaceGEPWithGlobalAccess(
+                    M, ParentInst, Gep, Index, Info.Offset, ArrayIndexV);
+                GAMap[Access] = Info;
+                return !isa<ConstantExpr>(Gep);
+            }
+        }
+    }
+
+    LLVM_DEBUG(dbgs() << "  replacing with pointer math\n");
+    replaceGEPWithPointerMath(M, ParentInst, Gep, Indices);
+    return !isa<ConstantExpr>(Gep);
+}
+
+static GEPOperator *getGEPOperator(Instruction *I) {
+    // If the instructions is directly a GEP, simply return it.
+    auto *GEP = dyn_cast<GEPOperator>(I);
+    if (GEP) {
+        return GEP;
+    }
+
+    // Hard-code handling of GEPs that appear as an inline operand to loads
+    // and stores.
+    if (isa<LoadInst>(I)) {
+        auto *Load = cast<LoadInst>(I);
+        auto *ConstExpr = dyn_cast<ConstantExpr>(Load->getPointerOperand());
+        if (ConstExpr) {
+            return dyn_cast<GEPOperator>(ConstExpr);
+        }
+    } else if (isa<StoreInst>(I)) {
+        auto *Store = dyn_cast<StoreInst>(I);
+        auto *ConstExpr = dyn_cast<ConstantExpr>(Store->getPointerOperand());
+        if (ConstExpr) {
+            return dyn_cast<GEPOperator>(ConstExpr);
+        }
+    }
+
+    return nullptr;
+}
+
+void transformGEPs(Module &M, Function &F, const TcgGlobalMap &TcgGlobals,
+                   const StringMap<size_t> &TypeIndexMap,
+                   const DebugInfoMapTy &DebugInfo) {
+    SmallSet<Instruction *, 8> InstToErase;
+    GlobalAccessMap GAMap;
+
+    LLVM_DEBUG(dbgs() << "Transforming GEPs for:" << F.getName() << "\n");
+
+    for (auto &I : instructions(F)) {
+        GEPOperator *GEP = getGEPOperator(&I);
+        if (!GEP) {
+            continue;
+        }
+
+        Expected<GepIndices> Indices = collectIndices(M.getDataLayout(), GEP);
+        if (!Indices) {
+            dbgs() << "Failed collecting GEP indices for:\n\t" << I << "\n";
+            dbgs() << "Reason: " << Indices.takeError();
+            abort();
+        }
+
+        bool ShouldErase = transformGEP(M, TcgGlobals, GAMap, TypeIndexMap,
+                                        DebugInfo, Indices.get(), &I, GEP);
+        if (ShouldErase) {
+            InstToErase.insert(&I);
+        }
+    }
+
+    for (auto *I : InstToErase) {
+        I->eraseFromParent();
+    }
+}
diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.hpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.hpp
new file mode 100644
index 0000000000..8430a65fa0
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/TransformGEPs.hpp
@@ -0,0 +1,45 @@
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
+#include "TcgGlobalMap.hpp"
+#include <llvm/ADT/StringMap.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
+
+//
+// Transform of module that converts `getelementptr` (GEP) operators to
+// pseudo instructions, either:
+//
+//   1. `call @AccessGlobalArray(StructIndex, Offset, Index)`
+//      if `Offset` is mapped to a global TCG array;
+//
+//   2. `call @AccessGlobalValue(StructIndex, Offset)`
+//      if `Offset` is mapped to a global TCG value;
+//
+//   3. Pointer math, if above fails.
+//
+// `StructIndex` is a an increasing integer assigned to each mapped struct type,
+// usually only `CPUArchState` is mapped, so `StructIndex` would be 0.
+//
+
+void transformGEPs(llvm::Module &M, llvm::Function &F,
+                   const TcgGlobalMap &TcgGlobals,
+                   const llvm::StringMap<size_t> &TypeIndexMap,
+                   const DebugInfoMapTy &DebugInfo);
-- 
2.52.0


