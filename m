Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0AEC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pl4-0005Ll-DH; Wed, 16 Sep 2026 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pl1-0005L0-Pl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:33:03 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pkz-0004gZ-Vq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=B2O+rtwjICDTLR2wYYR9i32ep/2Q9o5LpprIVkbnOjU=; b=WO96XuRJvl0MoNI
 Mb2Z82qAlku8Bs5p4aIM7p/jQ1hTke91YtkvS1fsDUD+vU532zWBy6pnULfv0rkgToEEclkJ6EqQ3
 zXdMOSQWeJQcnyGnNPYsKIguVZh63raHnjJv+6P0WhksOIMYEgaaAuFz3HV9Mt2PKtQi+avmaMDyj
 9Y=;
Date: Wed, 16 Sep 2026 15:32:53 +0200
To: Anton Johansson via qemu development <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 24/50] helper-to-tcg: PrepareForTcgPass, demote PHI
 nodes
Message-ID: <20260916153253.7b47094d@spawn>
In-Reply-To: <20260730031025.12926-25-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-25-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:58 +0200
Anton Johansson via qemu development <qemu-devel@nongnu.org> wrote:

> PHI nodes have no clear analogue in TCG, this commits converts them to
> stack accesses using a built-in LLVM transformation.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> index 41f317ed0b..d8530406ad 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> @@ -20,7 +20,10 @@
>  #include <llvm/ADT/SCCIterator.h>
>  #include <llvm/ADT/SmallPtrSet.h>
>  #include <llvm/IR/Function.h>
> +#include <llvm/IR/InstIterator.h>
> +#include <llvm/IR/Instructions.h>
>  #include <llvm/IR/Module.h>
> +#include <llvm/Transforms/Utils/Local.h>
>  
>  using namespace llvm;
>  
> @@ -48,8 +51,28 @@ static void removeFunctionsWithLoops(Module &M, ModuleAnalysisManager &MAM) {
>      }
>  }
>  
> +inline void demotePhis(Function &F) {
> +    if (F.isDeclaration()) {
> +        return;
> +    }
> +
> +    SmallVector<PHINode *, 10> Phis;
> +    for (auto &I : instructions(F)) {
> +        if (auto *Phi = dyn_cast<PHINode>(&I)) {
> +            Phis.push_back(Phi);
> +        }
> +    }
> +
> +    for (auto *Phi : Phis) {
> +        DemotePHIToStack(Phi);
> +    }
> +}
> +
>  PreservedAnalyses PrepareForTcgPass::run(Module &M,
>                                           ModuleAnalysisManager &MAM) {
>      removeFunctionsWithLoops(M, MAM);
> +    for (Function &F : M) {
> +        demotePhis(F);
> +    }
>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

