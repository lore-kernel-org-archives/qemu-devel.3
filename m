Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C9BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjUJ-0002bE-7b; Tue, 11 Aug 2026 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUH-0002aw-R0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:37 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUE-00037B-4k
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=zf+LimCXbtF3MvM1nTVenogjeT1AOdG+zSJM6x5show=; b=cw07AZEydDZVZ35
 knAwMcXZ4c0Gil6u8Zkaf/6L+8IaDYPqh083caXCjJyOkcIw2NrByiXEGoM1BJRYyzJVhpc5R4syA
 WCxkeWMyZwIiPTvoprdsAbSIuZ4ABFDfp5yYOHhm6BrSO+xaY08fOokZWmYWARGvm8aopYdOu/LE1
 64=;
Date: Tue, 11 Aug 2026 12:12:25 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 14/50] helper-to-tcg: PrepareForOptPass, map annotations
Message-ID: <20260811121225.669078f7@spawn>
In-Reply-To: <20260730031025.12926-15-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-15-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:48 +0200
Anton Johansson <anjo@rev.ng> wrote:

> In the LLVM IR module, function annotations are stored in one big global
> array of strings.  Traverse this array and parse the data into a format
> more useful for future passes.  A map between Functions * and an
> `Annotations` structure is exposed.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../include/FunctionAnnotation.hpp            | 104 ++++++++++++++++++
>  .../include/PrepareForOptPass.hpp             |   7 +-
>  subprojects/helper-to-tcg/src/Pipeline.cpp    |   6 +-
>  .../PrepareForOptPass/PrepareForOptPass.cpp   |  94 ++++++++++++++++
>  4 files changed, 209 insertions(+), 2 deletions(-)
>  create mode 100644 subprojects/helper-to-tcg/include/FunctionAnnotation.hpp
> 
> diff --git a/subprojects/helper-to-tcg/include/FunctionAnnotation.hpp b/subprojects/helper-to-tcg/include/FunctionAnnotation.hpp
> new file mode 100644
> index 0000000000..398dd53ef5
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/include/FunctionAnnotation.hpp
> @@ -0,0 +1,104 @@
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
> +#include <llvm/ADT/DenseMap.h>
> +#include <llvm/ADT/SmallVector.h>
> +#include <llvm/Support/Format.h>
> +#include <llvm/Support/raw_ostream.h>
> +#include <stdint.h>
> +
> +namespace llvm {
> +class Function;
> +}
> +
> +// Different kind of function annotations which control the behaviour
> +// of helper-to-tcg.
> +enum class ArgumentAnnotation : uint8_t {
> +    // Declares a list of arguments as immediates
> +    Immediate = 1,
> +    // Declares a list of arguments as vectors, represented by offsets into
> +    // the CPU state
> +    PtrToOffset = 2,
> +};
> +
> +// Different kind of function annotations which control the behaviour
> +// of helper-to-tcg.
> +enum class FunctionAnnotation : uint8_t {
> +    // Function should be translated
> +    HelperToTcg = 1,
> +    // Return value of function is an immediate
> +    ReturnsImmediate = 2,

I prefer 1 << 1 instead of `2` to better convey this is a bit mask and
avoid future copy-paste errors.

> +};
> +
> +// Annotation data which may be attached to a function
> +class Annotations {
> +    // 8-bit flag for each argument in a function, fields defined by
> +    // `ArgumentAnnotions`.
> +    llvm::SmallVector<uint8_t, 4> ArgumentAnnotations;
> +    // Flag of function annotations, fields defined by `FunctionsAnnotations`.
> +    uint8_t FunctionAnnotations = 0;
> +
> +  public:
> +    inline uint8_t getArgFlag(size_t Index) const {

Methods defined inline are implicitly inline. `inline` is redundant.

> +        if (Index >= ArgumentAnnotations.size()) {
> +            return 0;
> +        }
> +        return ArgumentAnnotations[Index];
> +    }
> +
> +    // Getters and setters for annotations flags.
> +
> +    inline void set(FunctionAnnotation FA) {
> +        FunctionAnnotations |= (uint8_t)FA;
> +    }
> +
> +    inline void set(size_t Index, ArgumentAnnotation AA) {
> +        if (Index >= ArgumentAnnotations.size()) {
> +            // Resizing will default initialize any new elements.
> +            ArgumentAnnotations.resize(Index + 1);
> +        }
> +        ArgumentAnnotations[Index] |= (uint8_t)AA;
> +    }
> +
> +    inline bool isSet(FunctionAnnotation FA) const {
> +        return (FunctionAnnotations & (uint8_t)FA) != 0;
> +    }
> +
> +    inline bool isSet(size_t Index, ArgumentAnnotation AA) const {
> +        uint8_t Flag = getArgFlag(Index);
> +        return (Flag & (uint8_t)AA) != 0;
> +    }
> +
> +    // Pretty printing debug information
> +    inline void dump(llvm::raw_ostream &Out) const {
> +        Out << "Annotations:\n";
> +        Out << "  Function: " << llvm::format_hex(FunctionAnnotations, 4)
> +            << "\n";
> +        for (size_t I = 0; I < ArgumentAnnotations.size(); ++I) {
> +            const uint8_t Flag = ArgumentAnnotations[I];
> +            Out << "  Argument[" << I << "]: " << llvm::format_hex(Flag, 4)
> +                << "\n";
> +        }
> +    }
> +};
> +
> +// Mapping from functions to annotations, this is the main structure to be used
> +// by other parts of the codebase when referencing annotations, filled out by
> +// `PrepareForOptPass`.
> +using AnnotationMapTy = llvm::DenseMap<llvm::Function *, Annotations>;

According to the LLVM developer's manual

> DenseMap is a simple linearly probed hash table. It excels at
> supporting small keys and values
> - https://llvm.org/docs/ProgrammersManual.html

I wouldn't use it for values bigger than 128 bits.
Not too bad as of now, but if we end up adding fields to `Annotations`,
this might silently stop be the right tool.

> diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> index 2b3694c536..e007243578 100644
> --- a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> +++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> @@ -17,6 +17,7 @@
>  
>  #pragma once
>  
> +#include "FunctionAnnotation.hpp"
>  #include <llvm/IR/PassManager.h>
>  
>  //
> @@ -27,8 +28,12 @@
>  //
>  
>  class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
> +    AnnotationMapTy &ResultAnnotations;

Passes should not hold module-specific data.
The assumption is that they are instantiated once and run multiple
times on different modules.
You should also assume they might run in parallel, even if this doesn't
happen in practice.

In short: do not store any state in the pass, if not some `const`
configuration.

Given you also have a couple of static functions sharing the same
arguments, I suggest to push all this state in a `PrepareForOpt` class
holding the relevant state and having the `static` functions as methods.

>  public:
> -    PrepareForOptPass() {}
> +    PrepareForOptPass(AnnotationMapTy &ResultAnnotations)
> +        : ResultAnnotations(ResultAnnotations)
> +    {
> +    }
>      llvm::PreservedAnalyses run(llvm::Module &M,
>                                  llvm::ModuleAnalysisManager &MAM);
>  };
> diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
> index 59de572bf6..051611b0f3 100644
> --- a/subprojects/helper-to-tcg/src/Pipeline.cpp
> +++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
> @@ -184,7 +184,11 @@ int main(int argc, char **argv) {
>          MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
>      }
>  
> -    MPM.addPass(PrepareForOptPass());
> +    // TODO: Get pass results via dependencies instead? Adds more boiler-plate
> +    // but is correlct in LLVM-terms.
> +
> +    AnnotationMapTy Annotations;
> +    MPM.addPass(PrepareForOptPass(Annotations));
>  
>      {
>          FunctionPassManager FPM;
> diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> index c15c0af6ea..1228ac952f 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> @@ -16,10 +16,15 @@
>  //
>  
>  #include "PrepareForOptPass.hpp"
> +#include "Error.hpp"
>  
>  #include <llvm/ADT/StringRef.h>
>  #include <llvm/ADT/StringSet.h>
>  #include <llvm/Demangle/Demangle.h>
> +#include <llvm/IR/Constants.h>
> +#include <llvm/IR/Function.h>
> +#include <llvm/IR/Instruction.h>
> +#include <llvm/IR/Module.h>
>  #include <llvm/Support/Debug.h>
>  
>  #define DEBUG_TYPE "prepare-for-opt"
> @@ -63,8 +68,97 @@ static void demangleFunctionNames(Module &M) {
>      }
>  }
>  
> +static Error parseAnnotationStr(Annotations &Ann, StringRef Str,
> +                                size_t NumArgs) {
> +    Str = Str.trim();
> +
> +    // Function annotations
> +    if (Str.consume_front("helper-to-tcg")) {

Why .consume_front?
Is there some suffix we are happy to ignore?
If yes, add a comment.
If not, let's have an equality test.

> +        Ann.set(FunctionAnnotation::HelperToTcg);
> +        return Error::success();
> +    } else if (Str.consume_front("returns-immediate")) {
> +        Ann.set(FunctionAnnotation::ReturnsImmediate);
> +        return Error::success();
> +    }
> +
> +    // Argument annotations
> +    ArgumentAnnotation AA;
> +    if (Str.consume_front("immediate")) {
> +        AA = ArgumentAnnotation::Immediate;
> +    } else if (Str.consume_front("ptr-to-offset")) {
> +        AA = ArgumentAnnotation::PtrToOffset;
> +    } else {
> +        return mkError("Unknown annotation");
> +    }
> +
> +    // An argument annotation looks like
> +    //
> +    //  "immediate: 0, 1, 2",
> +    //
> +    // parse the comma separated list of argument indices.
> +    if (!Str.consume_front(":")) {
> +        return mkError("Expected \":\"");
> +    }
> +    Str = Str.ltrim(' ');
> +    do {
> +        Str = Str.ltrim(' ');
> +        size_t I = 0;
> +        Str.consumeInteger(10, I);

Do not ignore the return value.

> +        if (I >= NumArgs) {
> +            return mkError("Annotation has out of bounds argument index");
> +        }
> +        Ann.set(I, AA);
> +    } while (Str.consume_front(","));

I'd check the string is now empty and fail otherwise.
Let's try to be strict.

> +
> +    return Error::success();
> +}
> +
> +static void collectAnnotations(Module &M, AnnotationMapTy &ResultAnnotations) {

I'd make `collectAnnotations` return `ResultAnnotations`.

> +    // cast over dyn_cast is being used here to
> +    // assert that the structure of

Please review the comment wrapping of the patchset. Sometimes they
split in multiple lines in unexpected ways.

> +    //
> +    //     llvm.global.annotation
> +    //
> +    // is what we expect.
> +
> +    GlobalVariable *GA = M.getGlobalVariable("llvm.global.annotations");
> +    if (!GA) {
> +        return;
> +    }
> +
> +    // Get the metadata which is stored in the first op
> +    auto *CA = cast<ConstantArray>(GA->getOperand(0));
> +    // Loop over metadata
> +    for (Value *CAOp : CA->operands()) {
> +        auto *Struct = cast<ConstantStruct>(CAOp);
> +        assert(Struct->getNumOperands() >= 2);

Are we asserting an expectation specific to helper-to-tcg or a more
generic one about the layout of llvm.global.annotations?

In the former case, maybe I'd avoid asserting and I'd just report some
message on `llvm::errs()`.

> +
> +        Function *F = cast<Function>(Struct->getOperand(0));
> +        ConstantDataArray *AnnData =
> +            cast<ConstantDataArray>(Struct->getOperand(1)->getOperand(0));
> +
> +        StringRef AnnStr = AnnData->getAsString();
> +        AnnStr = AnnStr.substr(0, AnnStr.size() - 1);
> +        Annotations Ann = ResultAnnotations[F];
> +        if (auto Err = parseAnnotationStr(Ann, AnnStr, F->arg_size()); Err) {
> +            errs() << "Failed to parse annotation: \"" << Err
> +                   << "\" for function " << F->getName() << "\n";
> +            continue;
> +        }
> +        ResultAnnotations[F] = Ann;
> +    }
> +
> +    LLVM_DEBUG({
> +        for (auto &P : ResultAnnotations) {
> +            dbgs() << "Annotations for " << P.first->getName() << "\n";
> +            P.second.dump(dbgs());
> +        }
> +    });
> +}
> +
>  PreservedAnalyses PrepareForOptPass::run(Module &M,
>                                           ModuleAnalysisManager &MAM) {
>      demangleFunctionNames(M);
> +    collectAnnotations(M, ResultAnnotations);
>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

