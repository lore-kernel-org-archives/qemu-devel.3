Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB73D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHz-0001g4-Fj; Wed, 20 Nov 2024 20:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHx-0001fL-Ck
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHu-0004Zk-RR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=AzEcD40MnOYRYmwxWBYqXftTCENUS2p4MXNkow+7IsY=; b=VxT7J7rymkkaSqq
 OBAjPFuLHUihykpcnDSvyDhOwPiP8lboRmcJz+18dZoLQyoQGhUnWRwFU/OuiyX6viSSVP5pM+3h4
 wVUVrfmAhdq1pTtODpq2YFGSJRnFawSVHV4tLAvhi2gEMSeOPvX1YsbesIkE9HZqW/1jB352Ae66r
 CU=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 25/43] helper-to-tcg: PrepareForTcgPass, transform GEPs
Date: Thu, 21 Nov 2024 02:49:29 +0100
Message-ID: <20241121014947.18666-26-anjo@rev.ng>
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

getelementpointer (GEP) instructions in LLVM IR represent general pointer
arithmetic (struct field access, array indexing, ...).  From the
perspective of TCG, three distinct cases are important and are
transformed into pseudo instructions respectively:

  * struct accesses whose offset into the struct map to a TCG global are
    transformed into "call @AccessGlobalValue(offset)";

  * struct accesses whose offset into the struct map to an array of TCG
    globals are transformed into "call @AccessGlobalArray(offset, index)";

  * otherwise converted to general pointer arithmetic in LLVM IR using
    "call @PtrAdd(...)".

These three cases are treated differently in the backend and all other
GEPs are considered an error.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../PrepareForTcgPass/PrepareForTcgPass.cpp   |   4 +
 .../PrepareForTcgPass/TransformGEPs.cpp       | 286 ++++++++++++++++++
 .../passes/PrepareForTcgPass/TransformGEPs.h  |  37 +++
 4 files changed, 328 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 6db1a019ce..6b18734bad 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -47,6 +47,7 @@ sources = [
     'passes/PrepareForOptPass/PrepareForOptPass.cpp',
     'passes/PseudoInst.cpp',
     'passes/PrepareForTcgPass/PrepareForTcgPass.cpp',
+    'passes/PrepareForTcgPass/TransformGEPs.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
index a453aa8558..b1e2932750 100644
--- a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/PrepareForTcgPass.cpp
@@ -17,6 +17,7 @@
 
 #include <CmdLineOptions.h>
 #include <PrepareForTcgPass.h>
+#include "TransformGEPs.h"
 #include <llvm/ADT/SCCIterator.h>
 #include <llvm/IR/Function.h>
 #include <llvm/IR/InstIterator.h>
@@ -120,5 +121,8 @@ PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
         demotePhis(F);
     }
     collectTcgGlobals(M, ResultTcgGlobalMap);
+    for (Function &F : M) {
+        transformGEPs(M, F, ResultTcgGlobalMap);
+    }
     return PreservedAnalyses::none();
 }
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
new file mode 100644
index 0000000000..db395533d1
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.cpp
@@ -0,0 +1,286 @@
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
+#include "TransformGEPs.h"
+#include <Error.h>
+#include <PseudoInst.h>
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
+static Expected<GepIndices> collectIndices(const DataLayout &DL,
+                                           GEPOperator *Gep)
+{
+    Type *PtrOpTy = Gep->getPointerOperandType();
+    if (!PtrOpTy->isPointerTy()) {
+        return mkError("GEPs on vectors are not handled!");
+    }
+    Type *InternalTy = Type::getIntNTy(Gep->getContext(), 64);
+    auto *One = ConstantInt::get(InternalTy, 1u);
+
+    GepIndices Result;
+
+    // NOTE: LLVM <= 11 doesn't have Gep->indices()
+    Type *CurrentTy = PtrOpTy;
+    for (auto &Arg : make_range(Gep->idx_begin(), Gep->idx_end())) {
+        switch (CurrentTy->getTypeID()) {
+        case Type::PointerTyID: {
+            CurrentTy = cast<PointerType>(CurrentTy)->getPointerElementType();
+            uint64_t FixedSize = DL.getTypeAllocSize(CurrentTy).getFixedSize();
+            Result.push_back(GepIndex{Arg.get(), FixedSize});
+        } break;
+        case Type::ArrayTyID: {
+            CurrentTy = cast<ArrayType>(CurrentTy)->getElementType();
+            uint64_t FixedSize = DL.getTypeAllocSize(CurrentTy).getFixedSize();
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
+                                      const GepIndices &Indices)
+{
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
+    FunctionCallee Fn = pseudoInstFunction(
+        M, PtrAdd, Gep->getType(), {PtrOp->getType(), PrevV->getType()});
+    CallInst *Call = Builder.CreateCall(Fn, {PtrOp, PrevV});
+    Gep->replaceAllUsesWith(Call);
+}
+
+// Takes indices associated with a getelementpointer instruction and expands
+// it into pointer math.
+static void replaceGEPWithGlobalAccess(Module &M, Instruction *ParentInst,
+                                       GEPOperator *Gep, uint64_t BaseOffset,
+                                       Value *ArrayIndex)
+{
+    IRBuilder<> Builder(ParentInst);
+    Type *IndexTy = Type::getIntNTy(M.getContext(), 64);
+    auto *ConstBaseOffset = ConstantInt::get(IndexTy, BaseOffset);
+    if (ArrayIndex) {
+        Type *ArrayAccessTy = ArrayIndex->getType();
+        FunctionCallee Fn = pseudoInstFunction(
+            M, AccessGlobalArray, Gep->getType(), {IndexTy, ArrayAccessTy});
+        CallInst *Call = Builder.CreateCall(Fn, {ConstBaseOffset, ArrayIndex});
+        Gep->replaceAllUsesWith(Call);
+    } else {
+        FunctionCallee Fn =
+            pseudoInstFunction(M, AccessGlobalValue, Gep->getType(), {IndexTy});
+        CallInst *Call = Builder.CreateCall(Fn, {ConstBaseOffset});
+        Gep->replaceAllUsesWith(Call);
+    }
+}
+
+static bool transformGEP(Module &M, const TcgGlobalMap &TcgGlobals,
+                         const GepIndices &Indices, Instruction *ParentInst,
+                         GEPOperator *Gep)
+{
+    Value *PtrOp = Gep->getPointerOperand();
+
+    bool PtrOpIsEnv = false;
+    {
+        auto *PtrTy = cast<PointerType>(PtrOp->getType());
+        auto *StructTy = dyn_cast<StructType>(PtrTy->getPointerElementType());
+        // NOTE: We are identifying the CPU state via matching the typename to
+        // CPUArchState. This is fragile to QEMU name changes, and does not
+        // play nicely with non-env structs.
+        PtrOpIsEnv = StructTy and StructTy->getName() == "struct.CPUArchState";
+    }
+
+    uint64_t BaseOffset = 0;
+    uint32_t NumArrayAccesses = 0;
+    Value *LastArrayAccess = nullptr;
+    for (const GepIndex &Index : Indices) {
+        if (Index.IsArrayAccess) {
+            LastArrayAccess = Index.V;
+            ++NumArrayAccesses;
+        } else {
+            auto *Const = dyn_cast<ConstantInt>(Index.V);
+            if (Const) {
+                BaseOffset += Const->getZExtValue() * Index.Size;
+            }
+        }
+    }
+
+    if (PtrOpIsEnv) {
+        auto It = TcgGlobals.find(BaseOffset);
+        if (It != TcgGlobals.end()) {
+            if (LastArrayAccess && NumArrayAccesses > 1) {
+                return false;
+            }
+            replaceGEPWithGlobalAccess(M, ParentInst, Gep, BaseOffset,
+                                       LastArrayAccess);
+            return !isa<ConstantExpr>(Gep);
+        }
+    }
+
+    replaceGEPWithPointerMath(M, ParentInst, Gep, Indices);
+    return !isa<ConstantExpr>(Gep);
+}
+
+static GEPOperator *getGEPOperator(Instruction *I)
+{
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
+void transformGEPs(Module &M, Function &F, const TcgGlobalMap &TcgGlobals)
+{
+    SmallSet<Instruction *, 8> InstToErase;
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
+        bool ShouldErase = transformGEP(M, TcgGlobals, Indices.get(), &I, GEP);
+        if (ShouldErase) {
+            InstToErase.insert(&I);
+        }
+    }
+
+    for (auto *I : InstToErase) {
+        I->eraseFromParent();
+    }
+}
diff --git a/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h
new file mode 100644
index 0000000000..11ac9c7e9b
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PrepareForTcgPass/TransformGEPs.h
@@ -0,0 +1,37 @@
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
+#include "TcgGlobalMap.h"
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Module.h>
+
+//
+// Transform of module that converts getelementptr (GEP) operators to
+// pseudo instructions:
+//   - call @AccessGlobalArray(OffsetInEnv, Index)
+//     if OffsetInEnv is mapped to a global TCGv array.
+//
+//   - call @AccessGlobalValue(OffsetInEnv)
+//     if OffsetInEnv is mapped to a global TCGv value.
+//
+//   - pointer math, if above fails.
+//
+
+void transformGEPs(llvm::Module &M, llvm::Function &F,
+                   const TcgGlobalMap &TcgGlobals);
-- 
2.45.2


