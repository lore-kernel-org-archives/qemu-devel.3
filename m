Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F1C5CFD9
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjUH-0002ac-DN; Tue, 11 Aug 2026 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUF-0002a7-Ix
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:35 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1wtjUE-00037F-80
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XfP28X7+bsqlFFPfWemvJMICX3yB6seNPgL9QuKX9ZE=; b=LmxUbJnbtRDPp25
 dOiwHfsbX95Ft8/aBEd0yR5gw6krJoDlI7DIXIOmIMFPJYHspikX2TVZ4BJwZUG5+KrO6dCrrA3Tq
 q2Xyc9QQP4BZueYOsnuMREKHgTB1xuTLIywrLdQvynHXllVFCf1LqEJvBOz3besO7kyI3A/NMJdwI
 Nc=;
Date: Tue, 11 Aug 2026 12:12:31 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 17/50] helper-to-tcg: PrepareForOptPass, fixup inline
 attributes
Message-ID: <20260811121231.05f4caf9@spawn>
In-Reply-To: <20260730031025.12926-18-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-18-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:51 +0200
Anton Johansson <anjo@rev.ng> wrote:

> When producing LLVM IR using clang -O0, a noinline attribute is added.
> Remove this attribute to not inhibit future optimization.  Also try and
> force functions returning struct type to be inlined so they might be
> translated.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../src/PrepareForOptPass/PrepareForOptPass.cpp    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> index 157f8cd05e..a7bee53582 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForOptPass/PrepareForOptPass.cpp
> @@ -32,6 +32,7 @@
>  #include <llvm/IR/Intrinsics.h>
>  #include <llvm/IR/Module.h>
>  #include <llvm/Support/Debug.h>
> +#include <llvm/Transforms/Utils/Local.h>
>  
>  #include <queue>
>  #include <set>
> @@ -293,5 +294,18 @@ PreservedAnalyses PrepareForOptPass::run(Module &M,
>      collectAnnotations(M, ResultAnnotations);
>      cullUnusedFunctions(M, ResultAnnotations);
>      replaceRetaddrWithUndef(M);
> +    // Remove noinline function attributes automatically added by -O0, add
> +    // alwaysinline attribute to functions with a struct return value, these
> +    // can not be translated to TCG currently and we rely on inlining to
> +    // hopefully get rid of them.
> +    for (Function &F : M) {
> +        if (F.hasFnAttribute(Attribute::AttrKind::NoInline)) {
> +            F.removeFnAttr(Attribute::AttrKind::NoInline);
> +        }
> +        if (F.getReturnType()->isStructTy()) {
> +            F.addFnAttr(Attribute::AttrKind::AlwaysInline);
> +        }

I'd add a brief comment about why structs are a problem.

> +    }
> +

Did you consider having dinstinct passes for:

1. demangleFunctionNames
2. collectAnnotations + cullUnusedFunctions
3. replaceRetaddrWithUndef
4. This

>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0
> 

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

