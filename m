Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C5D743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHv-0001dz-EL; Wed, 20 Nov 2024 20:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHu-0001dT-Nw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHs-0004Yv-5U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=C3wX1QdcsW7MQWsSRDypo/NZdV81zatwSZ7ea+i2V6E=; b=wVGW+6OM+KJB33R
 Z/AyImJ4n28xyU75TZh5c+d7I3k1U1cJus9nWVQbJnlskEzLxbRnsX35iJoopMCBuvt++8juVvBFM
 XzP86+ze8FC0jU1AAUQ3ER3cedUMp8meVJHj7TjN4ZgQRKUwg4MgbKLl9K1mB7EGqFbMVV8c6hbYM
 hk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 20/43] helper-to-tcg: Introduce pseudo instructions
Date: Thu, 21 Nov 2024 02:49:24 +0100
Message-ID: <20241121014947.18666-21-anjo@rev.ng>
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

"pseudo" instructions makes it easy to add custom instructions to
LLVM IR in the form of calls to undefined functions.  These will be used
in future commits to express functionality present in TCG that is missing
from LLVM IR (certain vector ops.), or to simplify the backend by
collecting similar instruction mappings into a single opcode
(idendity mapping).

Mapping from a call instructions in LLVM IR to an enum representing the
pseudo instruction is also handled, this avoids string comparisons in
the backend, and is easy to switch over.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 subprojects/helper-to-tcg/meson.build         |   1 +
 .../helper-to-tcg/passes/PseudoInst.cpp       | 142 ++++++++++++++++++
 subprojects/helper-to-tcg/passes/PseudoInst.h |  63 ++++++++
 .../helper-to-tcg/passes/PseudoInst.inc       |  76 ++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.cpp
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.h
 create mode 100644 subprojects/helper-to-tcg/passes/PseudoInst.inc

diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
index fd3fd6f0ae..6aba71d5ca 100644
--- a/subprojects/helper-to-tcg/meson.build
+++ b/subprojects/helper-to-tcg/meson.build
@@ -45,6 +45,7 @@ sources = [
     'passes/llvm-compat.cpp',
     'pipeline/Pipeline.cpp',
     'passes/PrepareForOptPass/PrepareForOptPass.cpp',
+    'passes/PseudoInst.cpp',
 ]
 
 clang = bindir / 'clang'
diff --git a/subprojects/helper-to-tcg/passes/PseudoInst.cpp b/subprojects/helper-to-tcg/passes/PseudoInst.cpp
new file mode 100644
index 0000000000..d7efa11499
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PseudoInst.cpp
@@ -0,0 +1,142 @@
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
+#include "PseudoInst.h"
+#include "llvm-compat.h"
+
+#include <llvm/ADT/DenseMap.h>
+#include <llvm/ADT/Twine.h>
+#include <llvm/IR/Function.h>
+#include <llvm/IR/Instructions.h>
+#include <llvm/Support/Casting.h>
+
+using namespace llvm;
+
+#define PSEUDO_INST_DEF(name, ret, args) #name
+static const char *PseudoInstName[] = {
+#include "PseudoInst.inc"
+};
+#undef PSEUDO_INST_DEF
+
+#define PSEUDO_INST_ARGVEC(...)                                                \
+    (sizeof((PseudoInstArg[]){__VA_ARGS__}) / sizeof(PseudoInstArg))
+
+#define PSEUDO_INST_DEF(name, ret, args) args
+static uint8_t PseudoInstArgCount[] = {
+#include "PseudoInst.inc"
+};
+#undef PSEUDO_INST_DEF
+
+// In order to map from a Function * to a PseudoInst, we keep a map
+// of all Functions created, this simplifies mapping of callee's to
+// a PseudoInst that can be switched over.
+static DenseMap<Function *, PseudoInst> MapFuncToInst;
+
+// Converts llvm `Type`s to a string representation
+// that can be embedded in function names for basic overloading.
+//
+// Ex.
+//
+//      *i32 -> "pi32"
+//      [8 x i8] -> "a8xi8"
+//      <128 x i8> -> "v128xi8"
+//
+// LLVM has an implementation of a similar function used by intrinsics,
+// called getMangledTypeStr, but it's not exposed.
+inline std::string getMangledTypeStr(Type *Ty)
+{
+    std::string TypeStr = "";
+    llvm::raw_string_ostream TypeStream(TypeStr);
+    switch (Ty->getTypeID()) {
+    case Type::ArrayTyID: {
+        auto *ArrayTy = cast<ArrayType>(Ty);
+        std::string ElementStr = getMangledTypeStr(ArrayTy->getElementType());
+        TypeStream << "a" << ArrayTy->getNumElements() << "x" << ElementStr;
+    } break;
+#if LLVM_VERSION_MAJOR >= 11
+    case Type::FixedVectorTyID: {
+#else
+    case Type::VectorTyID: {
+#endif
+        auto *VecTy = cast<VectorType>(Ty);
+        uint32_t ElementCount = compat::getVectorElementCount(VecTy);
+        std::string ElementStr = getMangledTypeStr(VecTy->getElementType());
+        TypeStream << "v" << ElementCount << "x" << ElementStr;
+    } break;
+    case Type::StructTyID: {
+        auto *StructTy = cast<StructType>(Ty);
+        TypeStream << StructTy->getName();
+    } break;
+    case Type::IntegerTyID: {
+        auto *IntTy = cast<IntegerType>(Ty);
+        TypeStream << "i" << IntTy->getBitWidth();
+    } break;
+    case Type::PointerTyID: {
+        auto *PtrTy = cast<PointerType>(Ty);
+        std::string ElementStr =
+            getMangledTypeStr(PtrTy->getPointerElementType());
+        TypeStream << "p" << ElementStr;
+    } break;
+    default:
+        abort();
+    }
+
+    return TypeStream.str();
+}
+
+const char *pseudoInstName(PseudoInst Inst) { return PseudoInstName[Inst]; }
+
+uint8_t pseudoInstArgCount(PseudoInst Inst) { return PseudoInstArgCount[Inst]; }
+
+llvm::FunctionCallee pseudoInstFunction(llvm::Module &M, PseudoInst Inst,
+                                        llvm::Type *RetType,
+                                        llvm::ArrayRef<llvm::Type *> ArgTypes)
+{
+    auto *FT = llvm::FunctionType::get(RetType, ArgTypes, false);
+
+    std::string FnName{PseudoInstName[Inst]};
+    if (!RetType->isVoidTy()) {
+        FnName += ".";
+        FnName += getMangledTypeStr(RetType);
+    }
+    for (llvm::Type *Ty : ArgTypes) {
+        if (Ty->isLabelTy()) {
+            continue;
+        }
+        FnName += ".";
+        FnName += getMangledTypeStr(Ty);
+    }
+
+    llvm::FunctionCallee Fn = M.getOrInsertFunction(FnName, FT);
+    auto *F = cast<Function>(Fn.getCallee());
+    MapFuncToInst.insert({F, Inst});
+
+    return Fn;
+}
+
+// Takes value as convenience
+PseudoInst getPseudoInstFromCall(const CallInst *Call)
+{
+    Function *F = Call->getCalledFunction();
+
+    auto It = MapFuncToInst.find(F);
+    if (It == MapFuncToInst.end()) {
+        return InvalidPseudoInst;
+    }
+
+    return It->second;
+}
diff --git a/subprojects/helper-to-tcg/passes/PseudoInst.h b/subprojects/helper-to-tcg/passes/PseudoInst.h
new file mode 100644
index 0000000000..6bf841d85c
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PseudoInst.h
@@ -0,0 +1,63 @@
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
+#include <stdint.h>
+
+#include "llvm/ADT/ArrayRef.h"
+#include "llvm/ADT/Optional.h"
+#include "llvm/IR/Module.h"
+#include "llvm/IR/Value.h"
+
+// Pseudo instructions refers to extra LLVM instructions implemented as
+// calls to undefined functions.  They are useful for amending LLVM IR to
+// simplify mapping to TCG in the backend, e.g.
+//
+//   %2 = call i32 @IdentityMap.i32.i16(i16 %1)
+//
+// is a pseudo opcode used to communicate that %1 and %2 should be mapped
+// to the same value in TCG.
+
+enum PseudoInstArg {
+    ArgInt,
+    ArgVec,
+    ArgPtr,
+    ArgLabel,
+    ArgVoid,
+};
+
+#define PSEUDO_INST_DEF(name, ret, args) name
+enum PseudoInst : uint8_t {
+#include "PseudoInst.inc"
+};
+#undef PSEUDO_INST_DEF
+
+// Retrieve string representation and argument counts for a given
+// pseudo instruction.
+const char *pseudoInstName(PseudoInst Inst);
+uint8_t pseudoInstArgCount(PseudoInst Inst);
+
+// Maps PseudoInst + return/argument types to a FunctionCallee that can be
+// called.
+llvm::FunctionCallee pseudoInstFunction(llvm::Module &M, PseudoInst Inst,
+                                        llvm::Type *RetType,
+                                        llvm::ArrayRef<llvm::Type *> ArgTypes);
+
+// Reverse mapping of above, takes a call instruction and attempts to map the
+// callee to a PseudoInst.
+PseudoInst getPseudoInstFromCall(const llvm::CallInst *Call);
diff --git a/subprojects/helper-to-tcg/passes/PseudoInst.inc b/subprojects/helper-to-tcg/passes/PseudoInst.inc
new file mode 100644
index 0000000000..9856afbe74
--- /dev/null
+++ b/subprojects/helper-to-tcg/passes/PseudoInst.inc
@@ -0,0 +1,76 @@
+PSEUDO_INST_DEF(InvalidPseudoInst,  ArgVoid, PSEUDO_INST_ARGVEC(ArgVoid)),
+// Identity mapping
+PSEUDO_INST_DEF(IdentityMap,        ArgInt, PSEUDO_INST_ARGVEC(ArgInt)),
+// Pointer arithmetic
+PSEUDO_INST_DEF(PtrAdd,             ArgPtr, PSEUDO_INST_ARGVEC(ArgPtr, ArgInt)),
+// Global accesses
+PSEUDO_INST_DEF(AccessGlobalArray,  ArgInt, PSEUDO_INST_ARGVEC(ArgInt)),
+PSEUDO_INST_DEF(AccessGlobalValue,  ArgInt, PSEUDO_INST_ARGVEC(ArgInt)),
+// Conditional branch
+PSEUDO_INST_DEF(Brcond,             ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt, ArgLabel, ArgLabel)),
+// Conditional move
+PSEUDO_INST_DEF(Movcond,            ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt, ArgInt, ArgInt)),
+// Vector creation ops
+PSEUDO_INST_DEF(VecSplat,           ArgVec, PSEUDO_INST_ARGVEC(ArgInt)),
+// Vector unary ops
+PSEUDO_INST_DEF(VecNot,             ArgVec, PSEUDO_INST_ARGVEC(ArgVec)),
+// Vector scalar binary ops
+PSEUDO_INST_DEF(VecAddScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecSubScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecMulScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecXorScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecOrScalar,        ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecAndScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecShlScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecLShrScalar,      ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecAShrScalar,      ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
+// Vector unary ops that stores to pointer
+PSEUDO_INST_DEF(VecNotStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+// Vector binary ops that stores to pointer
+PSEUDO_INST_DEF(VecAddStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecSubStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecMulStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecXorStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecOrStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecAndStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecShlStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecLShrStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecAShrStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecAddScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecSubScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecMulScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecXorScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecOrScalarStore,   ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecAndScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecShlScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecLShrScalarStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+PSEUDO_INST_DEF(VecAShrScalarStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
+// Host memory operations
+//                                                      vaddr,  value   sign    size    endian
+PSEUDO_INST_DEF(GuestLoad,  ArgInt,  PSEUDO_INST_ARGVEC(ArgInt,         ArgInt, ArgInt, ArgInt)),
+PSEUDO_INST_DEF(GuestStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgInt,         ArgInt, ArgInt)),
+// ...
+PSEUDO_INST_DEF(VecTruncStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecZExtStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecSExtStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecSignedSatAddStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecSignedSatSubStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecSelectStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecFunnelShrStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecAbsStore,          ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecSignedMaxStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecUnsignedMaxStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecSignedMinStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecUnsignedMinStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecCtlzStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecCttzStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecCtpopStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
+PSEUDO_INST_DEF(VecWideCondBitsel,    ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecWideCondBitselStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecCompare,           ArgVec, PSEUDO_INST_ARGVEC(ArgInt, ArgVec, ArgVec)),
+PSEUDO_INST_DEF(VecSelect,            ArgVec, PSEUDO_INST_ARGVEC(ArgInt, ArgVec, ArgVec)),
+
+PSEUDO_INST_DEF(SignExtract,          ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt)),
+PSEUDO_INST_DEF(Extract,              ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt)),
+
+PSEUDO_INST_DEF(Exception,            ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgInt)),
-- 
2.45.2


