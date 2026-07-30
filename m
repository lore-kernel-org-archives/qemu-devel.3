Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB4AC54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7a-0004zP-Qz; Wed, 29 Jul 2026 23:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH76-0004Sr-DQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:18 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH72-0002zK-W1
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=bLMxEDtYtHEQEK6wR7TDb5jQ5+u/BTLS7BKnJclrKiw=; b=XvKmkQwS5YWCu3v
 OsNFjGfbltcq1N+S8SpStFyVUiRg4+txiPz5LfTgvmVqw8FJImVEzEMgHyTqR2VEtI+022f8FKq/Q
 DR6ViXNAxVAS9lOwE4Uj3iS7MygyKX1LIIkvweq01N35ytl9EN2v8pKylZxXGpfUUiNO7Gkn81uCe
 Pc=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 35/50] helper-to-tcg: TcgGenPass,
 propagate constant expresssions
Date: Thu, 30 Jul 2026 05:10:09 +0200
Message-ID: <20260730031025.12926-36-anjo@rev.ng>
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

In a forward pass over the instructions, fold and propagate constant
expressions to `TcgV`s with a string representing the expression.

This needs to be performed before register allocation where `TcgV`
registers are assigned to `Value`s to get the best register reuse.
Register allocation is also performed in a backwards pass over the
instructions, so these two passes cannot be nicely combined.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../src/TcgGenPass/MapConstantExpressions.cpp | 328 ++++++++++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/src/TcgGenPass/MapConstantExpressions.cpp

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index 22190025d0..046cdb916b 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -52,6 +52,7 @@ sources = [
     'src/TcgGenPass/LinearizeBlocks.cpp',
     'src/TcgGenPass/TcgEmit.cpp',
     'src/TcgGenPass/MapArguments.cpp',
+    'src/TcgGenPass/MapConstantExpressions.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/src/TcgGenPass/MapConstantExpressions.cpp b/subprojects/helper-to-tcg/src/TcgGenPass/MapConstantExpressions.cpp
new file mode 100644
index 0000000000..0d0810ebc8
--- /dev/null
+++ b/subprojects/helper-to-tcg/src/TcgGenPass/MapConstantExpressions.cpp
@@ -0,0 +1,328 @@
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
+#include "ValueMapping.hpp"
+
+#include "DebugInfo.hpp"
+#include "Error.hpp"
+#include "PseudoInst.hpp"
+#include "TcgEmit.hpp"
+#include "TcgGlobalMap.hpp"
+#include "TcgType.hpp"
+
+#include <llvm/IR/BasicBlock.h>
+#include <llvm/IR/Constants.h>
+#include <llvm/IR/DerivedTypes.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Instructions.h>
+#include <llvm/IR/Module.h>
+
+using namespace llvm;
+
+//
+// Functions for mapping an LLVM Value to a TcgV
+//
+
+// Provides a C string representation of a ConstantInt
+static std::string constantIntToStr(const ConstantInt *C) {
+    SmallString<20> ResultStr;
+    auto *Int = cast<ConstantInt>(C);
+    const APInt Value = Int->getUniqueInteger();
+    const unsigned BitWidth = Int->getBitWidth();
+    if (BitWidth == 1) {
+        // Emit as bool
+        return (Value.getBoolValue()) ? "true" : "false";
+    } else if (BitWidth == 64 and !Int->isNegative() and Int->uge(0xefff)) {
+        // Emit hex-formatted integer as 64-bit constants often occur in vector
+        // expressions, and are way easier to read.
+        Value.toString(ResultStr, 16, false, true);
+        return Twine(ResultStr).str();
+    } else {
+        // Emit as signed integer
+        const char *SuffixStr = "";
+        if (Value.ugt(UINT32_MAX) or C->getBitWidth() == 64) {
+            SuffixStr = Int->isNegative() ? "ll" : "ull";
+        }
+        bool IsMax =
+            (Int->isNegative()) ? Value.isMaxSignedValue() : Value.isMaxValue();
+        bool IsMin = Int->isNegative() and Value.isMinSignedValue();
+        unsigned Bitwidth = Value.getBitWidth();
+        if (IsMax) {
+            return Twine("INT").concat(Twine(Bitwidth)).concat("_MAX").str();
+        } else if (IsMin) {
+            return Twine("INT").concat(Twine(Bitwidth)).concat("_MIN").str();
+        } else {
+            Value.toString(ResultStr, 10, Value.isNegative(), true);
+            return Twine(ResultStr).concat(SuffixStr).str();
+        }
+    }
+}
+
+static Expected<TcgV> mapIntegerConstant(TempAllocationData &TAD,
+                                         const ConstantInt *V) {
+    auto Size = ValueSize::fromLlvmType(cast<IntegerType>(V->getType()));
+    if (!Size) {
+        return Size.takeError();
+    }
+    auto Tcg = TcgV::makeTemp(*Size, IrImmediate);
+    Tcg.Name = constantIntToStr(V);
+    return TAD.map(V, Tcg);
+}
+
+static Expected<TcgV> mapVectorConstant(TempAllocationData &TAD,
+                                        const AnnotationMapTy &Annotations,
+                                        const DebugInfoMapTy &DebugInfo,
+                                        const Value *V, VectorType *VecTy) {
+    auto *Const = dyn_cast<Constant>(V);
+    if (!Const) {
+        return mkError("Non-constant vector");
+    }
+
+    auto Size = VectorSize::fromLlvmType(VecTy);
+    if (!Size) {
+        return Size.takeError();
+    }
+    auto Tcg = TcgV::makeVector(*Size);
+
+    // At this point, splatted vectors should have been converted to calls to
+    // @VecSplat, to more closely match TCG and benefit from future variable
+    // assignments.
+    assert(!Const->getSplatValue());
+
+    std::string ExprStr;
+    raw_string_ostream Expr(ExprStr);
+
+    // Map constant elements of vector where elements differ
+    //   <32 x i32> <i32 1, i32 2, ..., i32 16>
+
+    Expr << "{";
+    for (unsigned I = 0; I < Size->ElementCount; ++I) {
+        ConstantInt *C = cast<ConstantInt>(Const->getAggregateElement(I));
+        Expr << constantIntToStr(C);
+        if (I < Size->ElementCount - 1) {
+            Expr << ", ";
+        }
+    }
+    Expr << "}";
+    Tcg.Name = ExprStr;
+    Tcg.ConstantExpression = true;
+
+    return TAD.map(V, Tcg);
+}
+
+// Given a LLVM value, assigns a TcgV by type (integer, pointer, vector).  If
+// the given value has already been mapped to a TcgV, return it.
+static Expected<TcgV> mapConstant(TempAllocationData &TAD,
+                                  const AnnotationMapTy &AnnotationMap,
+                                  const DebugInfoMapTy &DebugInfo,
+                                  const Value *V) {
+    // Return previously mapped value
+    auto It = TAD.Map.find(V);
+    if (It != TAD.Map.end()) {
+        return It->second;
+    }
+
+    Type *Ty = V->getType();
+    if (auto *ConstInt = dyn_cast<ConstantInt>(V)) {
+        return mapIntegerConstant(TAD, ConstInt);
+    } else if (isa<VectorType>(Ty)) {
+        return mapVectorConstant(TAD, AnnotationMap, DebugInfo, V,
+                                 cast<VectorType>(Ty));
+    }
+
+    return mkError("Unable to map value ", V);
+}
+
+Error propagateConstantExpressions(CEmitter &C, const Function &F,
+                                   const LinearBlocks &Blocks,
+                                   const AnnotationMapTy &AnnotationMap,
+                                   const DebugInfoMapTy &DebugInfo,
+                                   const TcgGlobalMap &TcgGlobals,
+                                   TempAllocationData &TAD) {
+    SmallVector<Value *, 16> Worklist;
+    for (BasicBlock *BB : Blocks) {
+        for (Instruction &I : *BB) {
+            // Skip all instructions for which all operands have not been
+            // mapped, at this point we're only mapping constant expressions, so
+            // this is equivalent to all operands being constant expressions.
+            bool SkipInstruction = false;
+            SmallVector<TcgV, 4> Ops;
+            for (Value *V : getOperands(&I)) {
+                // Try and map `V` as a constant, or return previously mapped
+                // value. At this point any previously mapped value must be an
+                // argument to the function.
+                Expected<TcgV> T =
+                    mapConstant(TAD, AnnotationMap, DebugInfo, V);
+                if (!T or T->Kind == IrValue or T->Kind == IrPtr) {
+                    // Do break out here, we still need to map all operands,
+                    // consider
+                    //
+                    //   call @func(i32 %nonconst, i32 0).
+                    SkipInstruction = true;
+                    continue;
+                }
+                Ops.push_back(*T);
+            }
+            if (SkipInstruction) {
+                continue;
+            }
+
+            switch (I.getOpcode()) {
+            case Instruction::SExt:
+            case Instruction::ZExt: {
+                auto *IntTy = dyn_cast<IntegerType>(I.getType());
+                if (!IntTy) {
+                    continue;
+                }
+                auto Size = ValueSize::fromLlvmType(IntTy);
+                if (!Size) {
+                    return Size.takeError();
+                }
+                bool Signed = (I.getOpcode() == Instruction::SExt);
+                TAD.Map[&I] = C.extend(Signed, Ops[0], *Size);
+            } break;
+            case Instruction::Trunc: {
+                auto Trunc = cast<TruncInst>(&I);
+                if (!Trunc->getDestTy()->isIntegerTy()) {
+                    continue;
+                }
+                TAD.Map[&I] = Ops[0];
+            } break;
+            case Instruction::Add:
+            case Instruction::And:
+            case Instruction::AShr:
+            case Instruction::LShr:
+            case Instruction::Mul:
+            case Instruction::UDiv:
+            case Instruction::SDiv:
+            case Instruction::Or:
+            case Instruction::Shl:
+            case Instruction::Sub:
+            case Instruction::Xor: {
+                auto Bin = cast<BinaryOperator>(&I);
+                if (!isa<IntegerType>(Bin->getType())) {
+                    continue;
+                }
+                assert(Ops[0].Kind == Ops[1].Kind);
+                TAD.Map[&I] = C.binop(Bin->getOpcode(), Ops[0], Ops[1]);
+            } break;
+            case Instruction::ICmp: {
+                auto *ICmp = cast<ICmpInst>(&I);
+                assert(Ops[0].Kind == Ops[1].Kind);
+                TAD.Map[&I] = C.compare(ICmp->getPredicate(), Ops[0], Ops[1]);
+            } break;
+            case Instruction::Call: {
+                auto *Call = cast<CallInst>(&I);
+
+                // Rule out calls which are marked as returning integer
+                // immediates first, then handle specific pseudo instructions.
+
+                Type *RetTy = Call->getType();
+
+                if (auto IntTy = dyn_cast<IntegerType>(RetTy)) {
+                    auto It = AnnotationMap.find(Call->getCalledFunction());
+                    if (It != AnnotationMap.end() and
+                        It->second.isSet(
+                            FunctionAnnotation::ReturnsImmediate)) {
+                        auto Size = ValueSize::fromLlvmType(IntTy);
+                        if (!Size) {
+                            return Size.takeError();
+                        }
+                        auto Tcg = TcgV::makeTemp(*Size, IrImmediate);
+                        Tcg.Name = getDebugVarName(DebugInfo, Call);
+                        Tcg.Kind = IrImmediate;
+                        TAD.Map[Call] = Tcg;
+                        continue;
+                    }
+                }
+
+                switch (getPseudoInstFromCall(Call)) {
+                case IdentityMap: {
+                    TcgV Tcg;
+                    if (auto *IntTy = dyn_cast<IntegerType>(RetTy)) {
+                        auto Size = ValueSize::fromLlvmType(IntTy);
+                        if (!Size) {
+                            return Size.takeError();
+                        }
+                        Tcg = TcgV::makeTemp(*Size, IrValue);
+                    } else if (auto *VecTy = dyn_cast<VectorType>(RetTy)) {
+                        auto Size = VectorSize::fromLlvmType(VecTy);
+                        if (!Size) {
+                            return Size.takeError();
+                        }
+                        Tcg = TcgV::makeVector(*Size);
+                    } else {
+                        abort();
+                    }
+                    Tcg.ConstantExpression = true;
+                    Tcg.Name = Ops[0].Name;
+                    TAD.Map[&I] = Tcg;
+                } break;
+                case PtrAdd: {
+                    TAD.Map[&I] = C.ptrAdd(Ops[0], Ops[1]);
+                } break;
+                case Movcond: {
+                    auto LlvmPred = static_cast<ICmpInst::Predicate>(
+                        cast<ConstantInt>(Call->getOperand(0))->getZExtValue());
+                    const TcgV Cond = C.compare(LlvmPred, Ops[1], Ops[2]);
+                    TAD.Map[&I] = C.ternary(Cond, Ops[3], Ops[4]);
+                } break;
+                case AccessGlobalArray: {
+                    const uint64_t TypeIndex =
+                        cast<ConstantInt>(Call->getArgOperand(0))
+                            ->getZExtValue();
+                    const uint64_t Offset =
+                        cast<ConstantInt>(Call->getArgOperand(1))
+                            ->getZExtValue();
+                    assert(TypeIndex < TcgGlobals.size());
+                    auto It = TcgGlobals[TypeIndex].find(Offset);
+                    assert(It != TcgGlobals[TypeIndex].end());
+                    const TcgGlobal Global = It->second;
+                    if (Ops[2].Kind != IrImmediate) {
+                        return mkError(
+                            "Global array access with non-immediate index");
+                    }
+                    auto Code = Global.Code.str() + "[" + getName(Ops[2]) + "]";
+                    TAD.Map[&I] = TcgV::makeConstantExpression(
+                        Code, *ValueSize::fromBitWidth(Global.Size), IrValue);
+                } break;
+                case AccessGlobalValue: {
+                    const uint64_t TypeIndex =
+                        cast<ConstantInt>(Call->getArgOperand(0))
+                            ->getZExtValue();
+                    const uint64_t Offset =
+                        cast<ConstantInt>(Call->getArgOperand(1))
+                            ->getZExtValue();
+                    assert(TypeIndex < TcgGlobals.size());
+                    auto It = TcgGlobals[TypeIndex].find(Offset);
+                    assert(It != TcgGlobals[TypeIndex].end());
+                    const TcgGlobal Global = It->second;
+                    TAD.Map[&I] = TcgV::makeConstantExpression(
+                        Global.Code.str(),
+                        *ValueSize::fromBitWidth(Global.Size), IrValue);
+                } break;
+                default:
+                    continue;
+                }
+            } break;
+            default:
+                continue;
+            }
+        }
+    }
+    return Error::success();
+}
-- 
2.52.0


