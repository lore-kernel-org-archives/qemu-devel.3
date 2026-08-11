Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35B9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjUD-0002ZL-1n; Tue, 11 Aug 2026 06:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUC-0002Yy-74
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:32 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUA-00036S-BP
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Ja3uHjZVX+zsefq2xJ/flJScz6sOFpzHem2eGtNMesk=; b=GV6H5vpo6E13FEb
 g6hb5PhDGrLwzpvTm1bekCAgDfUOKIzsR5O9AjsV0m+dgTGJXdhzVWA/XSOZoetUFXiwMIwA5McIP
 YZeLwUOj6qu3DmM5F/UxAQh1GJpuvLcQ8r0thlVa0dBwSFCeQeA7QabtcaCbZQNRVXrdvSa+gdt75
 yM=;
Date: Tue, 11 Aug 2026 12:13:09 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 15/50] helper-to-tcg: PrepareForOptPass, cull unused
 functions
Message-ID: <20260811121309.3b9f0ed7@spawn>
In-Reply-To: <20260730031025.12926-16-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-16-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:49 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Make an early pass over all functions in the input module and filter out
> functions with:
> 
>   1. Invalid return type, or;
>   2. No helper-to-tcg annotation and not called by a function with such
>      a annotation.
> 
> A commandline option is also added to force translation of all functions
> starting with "helper_".
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../helper-to-tcg/include/CmdLineOptions.hpp  |  2 +
>  .../include/PrepareForOptPass.hpp             |  7 +-
>  subprojects/helper-to-tcg/src/Pipeline.cpp    |  5 ++
>  .../PrepareForOptPass/PrepareForOptPass.cpp   | 86 +++++++++++++++++++
>  4 files changed, 96 insertions(+), 4 deletions(-)
> 
> diff --git a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> index 93706b78c5..ca1cb59835 100644
> --- a/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> +++ b/subprojects/helper-to-tcg/include/CmdLineOptions.hpp
> @@ -21,3 +21,5 @@
>  
>  // Options for pipeline
>  extern llvm::cl::list<std::string> InputFiles;
> +// Options for PrepareForOptPass
> +extern llvm::cl::opt<bool> TranslateAllHelpers;
> diff --git a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> index e007243578..08ca9a43bb 100644
> --- a/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> +++ b/subprojects/helper-to-tcg/include/PrepareForOptPass.hpp
> @@ -29,11 +29,10 @@
>  
>  class PrepareForOptPass : public llvm::PassInfoMixin<PrepareForOptPass> {
>      AnnotationMapTy &ResultAnnotations;
> -public:
> +
> +  public:
>      PrepareForOptPass(AnnotationMapTy &ResultAnnotations)
> -        : ResultAnnotations(ResultAnnotations)
> -    {
> -    }
> +        : ResultAnnotations(ResultAnnotations) {}
>      llvm::PreservedAnalyses run(llvm::Module &M,
>                                  llvm::ModuleAnalysisManager &MAM);
>  };
> diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
> index 051611b0f3..89637eaec6 100644
> --- a/subprojects/helper-to-tcg/src/Pipeline.cpp
> +++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
> @@ -65,6 +65,11 @@ static cl::opt<std::string>
>                cl::init(""), cl::cat(Cat));
>  #endif
>  
> +// Options for PrepareForOptPass
> +cl::opt<bool> TranslateAllHelpers(
> +    "translate-all-helpers", cl::init(false),
> +    cl::desc("Translate all functions starting with helper_*"), cl::cat(Cat));
> +
>  // Define a TargetTransformInfo (TTI) subclass, this allows for overriding
>  // common per-llvm-target information expected by other LLVM passes, such
>  // as the width of the largest scalar/vector registers.  Needed for consistent
> diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> index 1228ac952f..df6d9eeec8 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> @@ -16,17 +16,25 @@
>  //
>  
>  #include "PrepareForOptPass.hpp"
> +#include "CmdLineOptions.hpp"
>  #include "Error.hpp"
> +#include "FunctionAnnotation.hpp"
> +#include "LlvmCompat.hpp"
>  
> +#include <llvm/ADT/SmallPtrSet.h>
>  #include <llvm/ADT/StringRef.h>
>  #include <llvm/ADT/StringSet.h>
>  #include <llvm/Demangle/Demangle.h>
>  #include <llvm/IR/Constants.h>
>  #include <llvm/IR/Function.h>
>  #include <llvm/IR/Instruction.h>
> +#include <llvm/IR/Instructions.h>
>  #include <llvm/IR/Module.h>
>  #include <llvm/Support/Debug.h>
>  
> +#include <queue>
> +#include <set>
> +
>  #define DEBUG_TYPE "prepare-for-opt"
>  
>  using namespace llvm;
> @@ -156,9 +164,87 @@ static void collectAnnotations(Module &M, AnnotationMapTy &ResultAnnotations) {
>      });
>  }
>  
> +inline bool hasValidReturnTy(const Module &M, const Function *F) {
> +    Type *RetTy = F->getReturnType();
> +    return RetTy->isStructTy() || RetTy == Type::getVoidTy(F->getContext()) ||
> +           RetTy == Type::getInt8Ty(M.getContext()) ||
> +           RetTy == Type::getInt16Ty(M.getContext()) ||
> +           RetTy == Type::getInt32Ty(M.getContext()) ||
> +           RetTy == Type::getInt64Ty(M.getContext());
> +}
> +
> +// Functions that should be removed:
> +//   - No helper-to-tcg annotation (if TranslateAllHelpers == false);
> +//   - Invalid (non-integer/void) return type
> +static bool shouldRemoveFunction(const Module &M, const Function &F,
> +                                 const AnnotationMapTy &AnnotationMap) {
> +    if (F.isDeclaration()) {
> +        return false;
> +    }
> +
> +    if (!hasValidReturnTy(M, &F)) {

I'd do this check after the others and write something to `llvm::errs()`.
If a helper has been explicitly marked as to be translated, but it's
unsuitable, we need to notify the user.

> +        return true;
> +    }
> +
> +    std::queue<const Function *> Worklist;
> +    std::set<const Function *> Visited;
> +    Worklist.push(&F);
> +    while (!Worklist.empty()) {
> +        const Function *F = Worklist.front();
> +        Worklist.pop();
> +        if (F->isDeclaration() or Visited.find(F) != Visited.end()) {
> +            continue;
> +        }
> +        Visited.insert(F);
> +
> +        if (TranslateAllHelpers and
> +            compat::isFunctionQemuHelper(F->getName())) {
> +            // If --translate-all-helpers is provided and `F` starts with
> +            // "helper_*", then don't skip it.
> +            return false;
> +        } else if (auto It = AnnotationMap.find(F); It != AnnotationMap.end()) {
> +            // Otherwise check "helper-to-tcg" annotation.
> +            const Annotations &Ann = It->second;
> +            if (Ann.isSet(FunctionAnnotation::HelperToTcg)) {
> +                return false;
> +            }
> +        }
> +
> +        // Push functions that call `F` to the worklist, this way we retain
> +        // functions that are being called by functions with the "helper-to-tcg"
> +        // annotation.
> +        for (const User *U : F->users()) {
> +            auto Call = dyn_cast<CallInst>(U);

Use `CallBase` so you also catch `InvokeInst`.

> +            if (!Call) {
> +                continue;
> +            }
> +            const Function *ParentF = Call->getParent()->getParent();
> +            Worklist.push(ParentF);
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void cullUnusedFunctions(Module &M, AnnotationMapTy &Annotations) {

I'd call it `purgeUnusedFunctions`, but this is fine as well.

> +    SmallPtrSet<Function *, 16> FunctionsToRemove;
> +    for (auto &F : M) {
> +        if (shouldRemoveFunction(M, F, Annotations)) {
> +            FunctionsToRemove.insert(&F);
> +        }
> +    }

This is not super efficient, for every function you walk the call graph.

I'd walk the list of functions and mark those we need to keep due to
name/annotation.
Then I'd walk the CallGraph (check out CallGraph.h) starting from them
(and stopping if you get to a function you already visited.

It'd also be nice to fail in case we have indirect calls, at some point.

> +
> +    for (Function *F : FunctionsToRemove) {
> +        Annotations.erase(F);
> +        F->setComdat(nullptr);
> +        F->deleteBody();
> +    }
> +}
> +
>  PreservedAnalyses PrepareForOptPass::run(Module &M,
>                                           ModuleAnalysisManager &MAM) {
>      demangleFunctionNames(M);
>      collectAnnotations(M, ResultAnnotations);
> +    cullUnusedFunctions(M, ResultAnnotations);
>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

