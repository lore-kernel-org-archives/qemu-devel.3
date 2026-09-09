Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A3CC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GDM-0004d9-KI; Wed, 09 Sep 2026 07:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x4GDL-0004cr-PM
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:11:39 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x4GDI-0006mQ-IH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=46OaE9bPFmbl/lBP0KqW9H3ivsTm6IOeNYRzHl0KiL8=; b=uLf1ApsvUC32azy
 8gQUbC3MVHhy/TRnuuEtlNvFUNfS/J40h7XhEj67XkZxpj2ZU8mrNCXLQK0HPKkIbT/qC3w4EDfIz
 jZsKLoyxbtYUHYhekwgQzOoA5Dry+z0+7/DpDq14cjwC1ulCTaJB5qx4+b/Due/UXXlrHgF2coqBf
 xU=;
Date: Wed, 9 Sep 2026 13:09:03 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 20/50] helper-to-tcg: Introduce pseudo instructions
Message-ID: <20260909130903.7cffa06d@spawn>
In-Reply-To: <20260730031025.12926-21-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-21-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:09:54 +0200
Anton Johansson <anjo@rev.ng> wrote:

> "pseudo" instructions makes it easy to add custom instructions to
> LLVM IR in the form of calls to undefined functions.  These will be used
> in future commits to express functionality present in TCG that is missing
> from LLVM IR (certain vector ops.), or to simplify the backend by
> collecting similar instruction mappings into a single opcode
> (idendity mapping).
> 
> Mapping from a call instructions in LLVM IR to an enum representing the
> pseudo instruction is also handled, this avoids string comparisons in
> the backend, and is easy to switch over.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../helper-to-tcg/include/PseudoInst.hpp      |  75 +++++++
>  .../helper-to-tcg/include/PseudoInst.inc      |  78 ++++++++
>  subprojects/helper-to-tcg/meson.build         |   1 +
>  subprojects/helper-to-tcg/src/PseudoInst.cpp  | 183 ++++++++++++++++++
>  4 files changed, 337 insertions(+)
>  create mode 100644 subprojects/helper-to-tcg/include/PseudoInst.hpp
>  create mode 100644 subprojects/helper-to-tcg/include/PseudoInst.inc
>  create mode 100644 subprojects/helper-to-tcg/src/PseudoInst.cpp
> 
> diff --git a/subprojects/helper-to-tcg/include/PseudoInst.hpp b/subprojects/helper-to-tcg/include/PseudoInst.hpp
> new file mode 100644
> index 0000000000..ef0b03cb5b
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/include/PseudoInst.hpp
> @@ -0,0 +1,75 @@
> +//
> +//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +//
> +//  This program is free software; you can redistribute it and/or modify
> +//  it under the terms of the GNU General Public License as published by
> +//  the Free Software Foundation; either version 2 of the License, or
> +//  (at your option) any later version.
> +//
> +//  This program is distributed in the hope that it will be useful,
> +//  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +//  GNU General Public License for more details.
> +//
> +//  You should have received a copy of the GNU General Public License
> +//  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +//
> +
> +#pragma once
> +
> +#include <stdint.h>
> +
> +#include <llvm/ADT/ArrayRef.h>
> +#include <llvm/IR/IRBuilder.h>
> +#include <llvm/IR/Module.h>
> +#include <llvm/IR/Value.h>
> +
> +// Pseudo instructions refers to extra LLVM instructions implemented as
> +// calls to undefined functions.  They are useful for amending LLVM IR to
> +// simplify mapping to TCG in the backend, e.g.
> +//
> +//   %2 = call i32 @IdentityMap.i32.i16(i16 %1)
> +//
> +// is a pseudo opcode used to communicate that %1 and %2 should be mapped
> +// to the same value in TCG.
> +
> +enum PseudoInstArg {
> +    ArgAny,
> +    ArgInt,
> +    ArgVec,
> +    ArgPtr,
> +    ArgLabel,
> +    ArgVoid,
> +};
> +
> +// Define an enum `PseudoInst` consisting of the names of pseudo instructions
> +// defined in "PseudoInst.inc".
> +#define PSEUDO_INST_DEF(name, ret, args) name
> +enum PseudoInst : uint8_t {
> +#include "PseudoInst.inc"
> +};
> +#undef PSEUDO_INST_DEF
> +
> +// Retrieve string representation and argument counts for a given
> +// pseudo instruction.
> +const char *pseudoInstName(PseudoInst Inst);
> +uint8_t pseudoInstArgCount(PseudoInst Inst);
> +llvm::ArrayRef<PseudoInstArg> pseudoInstArgTypes(PseudoInst Inst);
> +
> +// Maps `PseudoInst`, return type, and argument types, to a `FunctionCallee`
> +// that can be called.  Provided argument types are matched against
> +// "PseudoInst.inc" for verification and an assert triggers on failure.
> +llvm::FunctionCallee pseudoInstFunction(llvm::Module &M, PseudoInst Inst,
> +                                        llvm::Type *RetType,
> +                                        llvm::ArrayRef<llvm::Type *> ArgTypes);
> +
> +// Convenience function that gets a pseudo instruction via
> +// `pseudoInstFunction()` and creates a call to it via the provided `IRBuilder`.
> +llvm::CallInst *createPseudoInstCall(llvm::Module &M,
> +                                     llvm::IRBuilder<> &Builder,
> +                                     PseudoInst Inst, llvm::Type *RetType,
> +                                     llvm::ArrayRef<llvm::Value *> Values);

This looks like a class in disguise:

```
class PseudoInst {
public:
  enum Operation {
    // ...
  };

private:
  Operation TheOperation;

public:
  const char *name() const;
  // ...

public:
  FunctionCallee makeFunction(Module &M,
                              Type *RetType,
                              ArrayRef<llvm::Type *> ArgTypes);

  FunctionCallee makeCall(...);

public:
  static PseudoInst fromCall(const llvm::CallInst *Call);
};
```
> +
> +// Reverse mapping of above, takes a call instruction and attempts to map the
> +// callee to a `PseudoInst`.
> +PseudoInst getPseudoInstFromCall(const llvm::CallInst *Call);
> diff --git a/subprojects/helper-to-tcg/include/PseudoInst.inc b/subprojects/helper-to-tcg/include/PseudoInst.inc
> new file mode 100644
> index 0000000000..003d3fb186
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/include/PseudoInst.inc
> @@ -0,0 +1,78 @@
> +PSEUDO_INST_DEF(InvalidPseudoInst,  ArgVoid, PSEUDO_INST_ARGVEC()),
> +// Identity mapping
> +PSEUDO_INST_DEF(IdentityMap,        ArgAny, PSEUDO_INST_ARGVEC(ArgAny)),
> +// Pointer arithmetic
> +PSEUDO_INST_DEF(PtrAdd,             ArgPtr, PSEUDO_INST_ARGVEC(ArgPtr, ArgInt)),
> +// Global accesses
> +PSEUDO_INST_DEF(AccessGlobalArray,  ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt)),
> +PSEUDO_INST_DEF(AccessGlobalValue,  ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt)),
> +// Conditional branch
> +PSEUDO_INST_DEF(Brcond,             ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt, ArgInt, ArgLabel, ArgLabel)),
> +// Conditional move
> +PSEUDO_INST_DEF(Movcond,            ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt, ArgInt, ArgInt)),

Add more documentation.

* AFAIU `Brcond` represents a `icmp + br` in LLVM.
* AFAIU `Movcond` represents `icmp + select` in LLVM.
* `IdentityMap` is not obvious
* `PtrAdd` is not obvious

Same for others, be more verbose about what they represent, why base
LLVM is not able to capture them and what they map to in TCG.
No need to go in depth for all vector operations, but for these docs
would be beneficial.

> +// Vector creation ops
> +PSEUDO_INST_DEF(VecSplat,           ArgVec, PSEUDO_INST_ARGVEC(ArgInt)),
> +PSEUDO_INST_DEF(VecConstant,        ArgVec, PSEUDO_INST_ARGVEC(ArgVec)),
> +// Vector unary ops
> +PSEUDO_INST_DEF(VecNot,             ArgVec, PSEUDO_INST_ARGVEC(ArgVec)),
> +// Vector scalar binary ops
> +PSEUDO_INST_DEF(VecAddScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecSubScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecMulScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecXorScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecOrScalar,        ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecAndScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecShlScalar,       ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecLShrScalar,      ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecAShrScalar,      ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgInt)),
> +// Vector unary ops that stores to pointer
> +PSEUDO_INST_DEF(VecNotStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
> +// Vector binary ops that stores to pointer
> +PSEUDO_INST_DEF(VecAddStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecSubStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecMulStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecXorStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecOrStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecAndStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecShlStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecLShrStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecAShrStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecAddScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecSubScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecMulScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecXorScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecOrScalarStore,   ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecAndScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecShlScalarStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecLShrScalarStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +PSEUDO_INST_DEF(VecAShrScalarStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgInt)),
> +// Host memory operations
> +//                                                      vaddr,  value   sign    size    endian
> +PSEUDO_INST_DEF(GuestLoad,  ArgInt,  PSEUDO_INST_ARGVEC(ArgInt,         ArgInt, ArgInt, ArgInt)),
> +PSEUDO_INST_DEF(GuestStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgInt,         ArgInt, ArgInt)),
> +// ...
> +PSEUDO_INST_DEF(VecTruncStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecZExtStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecSExtStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecSignedSatAddStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecSignedSatSubStore, ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecSelectStore,       ArgVoid, PSEUDO_INST_ARGVEC(ArgInt, ArgPtr, ArgVec, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecFunnelShrStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecAbsStore,          ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecSignedMaxStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecUnsignedMaxStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecSignedMinStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecUnsignedMinStore,  ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecCtlzStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecCttzStore,         ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecCtpopStore,        ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec)),
> +PSEUDO_INST_DEF(VecWideCondBitsel,    ArgVec, PSEUDO_INST_ARGVEC(ArgVec, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecWideCondBitselStore,    ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgVec, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecCompare,           ArgVec, PSEUDO_INST_ARGVEC(ArgInt, ArgVec, ArgVec)),
> +PSEUDO_INST_DEF(VecSelect,            ArgVec, PSEUDO_INST_ARGVEC(ArgInt, ArgVec, ArgVec)),
> +

These would also benefit from more docs:

> +PSEUDO_INST_DEF(SignExtract,          ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt)),
> +PSEUDO_INST_DEF(Extract,              ArgInt, PSEUDO_INST_ARGVEC(ArgInt, ArgInt, ArgInt)),
> +
> +PSEUDO_INST_DEF(Exception,            ArgVoid, PSEUDO_INST_ARGVEC(ArgPtr, ArgInt)),
> +PSEUDO_INST_DEF(GetPC,                ArgInt,  PSEUDO_INST_ARGVEC()),
> diff --git a/subprojects/helper-to-tcg/meson.build b/subprojects/helper-to-tcg/meson.build
> index 4fd0ddb778..b3a3de6297 100644
> --- a/subprojects/helper-to-tcg/meson.build
> +++ b/subprojects/helper-to-tcg/meson.build
> @@ -43,6 +43,7 @@ sources = [
>      'src/LlvmCompat.cpp',
>      'src/Pipeline.cpp',
>      'src/PrepareForOptPass/PrepareForOptPass.cpp',
> +    'src/PseudoInst.cpp',
>  ]
>  
>  clang = bindir / 'clang'
> diff --git a/subprojects/helper-to-tcg/src/PseudoInst.cpp b/subprojects/helper-to-tcg/src/PseudoInst.cpp
> new file mode 100644
> index 0000000000..91e0f25e3d
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/src/PseudoInst.cpp
> @@ -0,0 +1,183 @@
> +//
> +//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +//
> +//  This program is free software; you can redistribute it and/or modify
> +//  it under the terms of the GNU General Public License as published by
> +//  the Free Software Foundation; either version 2 of the License, or
> +//  (at your option) any later version.
> +//
> +//  This program is distributed in the hope that it will be useful,
> +//  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +//  GNU General Public License for more details.
> +//
> +//  You should have received a copy of the GNU General Public License
> +//  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +//
> +
> +#include "PseudoInst.hpp"
> +#include "LlvmCompat.hpp"
> +
> +#include <llvm/ADT/DenseMap.h>
> +#include <llvm/ADT/Twine.h>
> +#include <llvm/IR/Function.h>
> +#include <llvm/IR/Instructions.h>
> +#include <llvm/Support/Casting.h>
> +
> +using namespace llvm;
> +
> +// Define an array `PseudoInstName[]`, indexed by `PseudoInst` and mapping
> +// to a string representation of the enum.
> +#define PSEUDO_INST_DEF(name, ret, args) #name
> +static const char *PseudoInstName[] = {
> +#include "PseudoInst.inc"
> +};
> +#undef PSEUDO_INST_DEF
> +
> +// Define an array `PseudoInstArgTypes[]` indexed by `PseudoInst` and
> +// mapping to an array of `PseudoInstArg` representing allowed argument types.
> +#define PSEUDO_INST_ARGVEC(...) {__VA_ARGS__}
> +
> +#define PSEUDO_INST_DEF(name, ret, args) args
> +static const SmallVector<PseudoInstArg, 6> PseudoInstArgTypes[] = {
> +#include "PseudoInst.inc"
> +};
> +#undef PSEUDO_INST_DEF
> +#undef PSEUDO_INST_ARGVEC
> +
> +// In order to map from a `Function *` to a `PseudoInst`, we keep a map
> +// of all functions created, this simplifies mapping of callees to
> +// a `PseudoInst` that can be switched over.
> +static DenseMap<Function *, PseudoInst> MapFuncToInst;

Having a `llvm::Function` reference in a global variable is not nice.
All of this should be part of a class associated to a specific module.

> +
> +// Converts llvm `Type`s to a string representation
> +// that can be embedded in function names for basic overloading.
> +//
> +// Ex.
> +//
> +//      [8 x i8] -> "a8xi8"
> +//      <128 x i8> -> "v128xi8"
> +//
> +// LLVM has an implementation of a similar function used by intrinsics,
> +// called `getMangledTypeStr`, but it's not exposed.

Is this function for debugging purposes?
Please clearly identify functions that are not critical (i.e., they are
for debugging purposes).

> +inline std::string getMangledTypeStr(Type *Ty) {

Use `static` instead of `inline` in `.cpp` files.

> +    std::string TypeStr = "";
> +    llvm::raw_string_ostream TypeStream(TypeStr);
> +    switch (Ty->getTypeID()) {
> +    case Type::ArrayTyID: {
> +        auto *ArrayTy = cast<ArrayType>(Ty);
> +        std::string ElementStr = getMangledTypeStr(ArrayTy->getElementType());
> +        TypeStream << "a" << ArrayTy->getNumElements() << "x" << ElementStr;
> +    } break;
> +    case Type::FixedVectorTyID: {
> +        auto *VecTy = cast<VectorType>(Ty);
> +        uint32_t ElementCount = compat::getVectorElementCount(VecTy);
> +        std::string ElementStr = getMangledTypeStr(VecTy->getElementType());
> +        TypeStream << "v" << ElementCount << "x" << ElementStr;
> +    } break;
> +    case Type::StructTyID: {
> +        auto *StructTy = cast<StructType>(Ty);
> +        TypeStream << StructTy->getName();
> +    } break;
> +    case Type::IntegerTyID: {
> +        auto *IntTy = cast<IntegerType>(Ty);
> +        TypeStream << "i" << IntTy->getBitWidth();
> +    } break;
> +    case Type::PointerTyID: {
> +        TypeStream << "p";
> +    } break;
> +    default:
> +        abort();
> +    }
> +    return TypeStream.str();
> +}
> +
> +// Access functions into the static defined above.
> +
> +const char *pseudoInstName(PseudoInst Inst) { return PseudoInstName[Inst]; }
> +
> +uint8_t pseudoInstArgCount(PseudoInst Inst) {
> +    return PseudoInstArgTypes[Inst].size();
> +}
> +
> +llvm::ArrayRef<PseudoInstArg> pseudoInstArgTypes(PseudoInst Inst) {
> +    return PseudoInstArgTypes[Inst];
> +}
> +
> +// Match LLVM type against `PseudoIntsArg`.
> +static void assertMatchingType(PseudoInstArg Expected, Type *Ty) {
> +    const Type::TypeID Id = Ty->getTypeID();
> +    switch (Expected) {
> +    case ArgAny:
> +        return;
> +    case ArgInt:
> +        assert(Id == Type::IntegerTyID);
> +        return;
> +    case ArgVec:
> +        assert(Id == Type::FixedVectorTyID);
> +        return;
> +    case ArgPtr:
> +        assert(Id == Type::PointerTyID);
> +        return;
> +    case ArgLabel:
> +        assert(Id == Type::LabelTyID);
> +        return;
> +    case ArgVoid:
> +        assert(Id == Type::VoidTyID);
> +        return;
> +    default:
> +        abort();
> +    };
> +}
> +
> +llvm::FunctionCallee pseudoInstFunction(llvm::Module &M, PseudoInst Inst,
> +                                        llvm::Type *RetType,
> +                                        llvm::ArrayRef<llvm::Type *> ArgTypes) {
> +    ArrayRef<PseudoInstArg> PArgTypes = pseudoInstArgTypes(Inst);
> +    assert(PArgTypes.size() == ArgTypes.size());
> +    for (size_t I = 0; I < ArgTypes.size(); ++I) {
> +        assertMatchingType(PArgTypes[I], ArgTypes[I]);
> +    }
> +
> +    auto *FT = llvm::FunctionType::get(RetType, ArgTypes, false);
> +
> +    std::string FnName{PseudoInstName[Inst]};
> +    if (!RetType->isVoidTy()) {
> +        FnName += ".";
> +        FnName += getMangledTypeStr(RetType);
> +    }
> +    for (llvm::Type *Ty : ArgTypes) {
> +        if (Ty->isLabelTy()) {
> +            continue;
> +        }
> +        FnName += ".";
> +        FnName += getMangledTypeStr(Ty);
> +    }
> +
> +    llvm::FunctionCallee Fn = M.getOrInsertFunction(FnName, FT);
> +    auto *F = cast<Function>(Fn.getCallee());
> +    MapFuncToInst.insert({F, Inst});
> +
> +    return Fn;
> +}
> +
> +llvm::CallInst *createPseudoInstCall(llvm::Module &M, IRBuilder<> &Builder,

You could get `M` from `Builder.GetInsertPoint`.

> +                                     PseudoInst Inst, llvm::Type *RetType,
> +                                     llvm::ArrayRef<llvm::Value *> Values) {
> +    SmallVector<Type *, 8> ArgTypes;
> +    for (Value *V : Values) {
> +        ArgTypes.push_back(V->getType());
> +    }
> +
> +    FunctionCallee Fn = pseudoInstFunction(M, Inst, RetType, ArgTypes);
> +    return Builder.CreateCall(Fn, Values);
> +}
> +
> +PseudoInst getPseudoInstFromCall(const CallInst *Call) {
> +    Function *F = Call->getCalledFunction();
> +    auto It = MapFuncToInst.find(F);
> +    if (It == MapFuncToInst.end()) {
> +        return InvalidPseudoInst;
> +    }
> +    return It->second;
> +}
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

