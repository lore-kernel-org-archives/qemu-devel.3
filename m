Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45D3C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjUG-0002aI-9p; Tue, 11 Aug 2026 06:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUE-0002ZR-74
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:34 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUC-00036q-EH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=4s+4l+94+KVZetizq2kRH22BMtI8TNfo82B5LgZFpDA=; b=p5V0a9ogumlFQQi
 MAA3MFx+1NmAitsDIFY4fRBptE6bwG3NvfnOUHsDNVsYIwo7kj8W/xW/kw5lxwIWr1suapXy8M19z
 4szmVk+rhvTZhLAXPJziWITj5PlmnmBkGDUIg8Oq+U97gbTUvpkRWGOtC2Rnc6xEDoTIKsTyQ8zI5
 g4=;
Date: Tue, 11 Aug 2026 12:12:36 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 16/50] helper-to-tcg: PrepareForOptPass, undef
 llvm.returnaddress
Message-ID: <20260811121236.7af5b27d@spawn>
In-Reply-To: <20260730031025.12926-17-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-17-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:50 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Convert llvm.returnaddress arguments to cpu_[ld|st]*() to undef, causing
> the LLVM optmizer to discard the intrinsics.  Needed as
> llvm.returnadress is not representable in TCG, and usually results from
> usage of GETPC() in helper functions.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../PrepareForOptPass/PrepareForOptPass.cpp   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> index df6d9eeec8..157f8cd05e 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> @@ -29,6 +29,7 @@
>  #include <llvm/IR/Function.h>
>  #include <llvm/IR/Instruction.h>
>  #include <llvm/IR/Instructions.h>
> +#include <llvm/IR/Intrinsics.h>
>  #include <llvm/IR/Module.h>
>  #include <llvm/Support/Debug.h>
>  
> @@ -241,10 +242,56 @@ static void cullUnusedFunctions(Module &M, AnnotationMapTy &Annotations) {
>      }
>  }
>  
> +struct RetAddrReplaceInfo {
> +    User *Parent;
> +    unsigned OpIndex;
> +    Type *Ty;
> +};
> +
> +static void replaceRetaddrWithUndef(Module &M) {
> +    // Replace uses of llvm.returnaddress arguments to cpu_ld* w. undef,
> +    // and let optimizations remove it.  Needed as llvm.returnaddress is
> +    // not reprensentable in TCG.

I'd add a brief comment about what's the use in helpers of
`llvm.returnaddress`, possibly with a reference to the part of code
emitting it.

This way, if someone changes things around that part of the code will
(hopefully) `git grep` this.

> +    SmallVector<RetAddrReplaceInfo, 24> UsesToReplace;
> +    Function *Retaddr = compat::Intrinsic::getOrInsertDeclaration(
> +        &M, Intrinsic::returnaddress, {});
> +    // Loop over all calls to llvm.returnaddress
> +    for (auto *CallUser : Retaddr->users()) {
> +        auto *Call = dyn_cast<CallInst>(CallUser);
> +        if (!Call) {
> +            continue;
> +        }
> +        for (auto *PtrToIntUser : Call->users()) {
> +            auto *Cast = dyn_cast<PtrToIntInst>(PtrToIntUser);
> +            if (!Cast) {
> +                continue;
> +            }
> +            for (Use &U : Cast->uses()) {
> +                auto *Call = dyn_cast<CallInst>(U.getUser());
> +                Function *F = Call->getCalledFunction();
> +                if (compat::isFunctionQemuLoadStore(F->getName())) {
> +                    UsesToReplace.push_back({
> +                        .Parent = U.getUser(),
> +                        .OpIndex = U.getOperandNo(),
> +                        .Ty = U->getType(),
> +                    });
> +                }
> +            }
> +        }
> +    }
> +
> +    // Defer replacement to not invalidate iterators
> +    for (RetAddrReplaceInfo &RI : UsesToReplace) {
> +        auto *Undef = UndefValue::get(RI.Ty);
> +        RI.Parent->setOperand(RI.OpIndex, Undef);
> +    }
> +}
> +
>  PreservedAnalyses PrepareForOptPass::run(Module &M,
>                                           ModuleAnalysisManager &MAM) {
>      demangleFunctionNames(M);
>      collectAnnotations(M, ResultAnnotations);
>      cullUnusedFunctions(M, ResultAnnotations);
> +    replaceRetaddrWithUndef(M);
>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

