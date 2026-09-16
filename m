Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B922C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pg7-0001ll-Lh; Wed, 16 Sep 2026 09:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pfx-0001kW-0Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:49 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pfu-0003sV-IJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=15tu9Igm3t/Cu5fVDuOxFO/Z0eZPJsUUwGHTpW66s+Y=; b=U/Bl0EHToUw4yA2
 e8/XfafRB1br2nTuncavnyRm8u//EcJqRIlLQ40fWevmx+N49lewDqwPDR6KzdzQ0lYaSSv/YgDHC
 gmzoJ8Wabdz8p71+G+ZQ5wmt0OLmsgh7zZdaS4Nupua+mSKfk7iQ3npHYuQLiMstFAGzE1y7bj8Le
 6E=;
Date: Wed, 16 Sep 2026 15:16:26 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 23/50] helper-to-tcg: PrepareForTcgPass, remove
 functions with cycles
Message-ID: <20260916151626.03678639@spawn>
In-Reply-To: <20260730031025.12926-24-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-24-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:57 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Functions with cycles are removed for two primary reasons:
> 
>   * As a simplifying assumption for register allocation which occurs down
>     the line, and;
> 
>   * If a function contains cycles post-optimization neither unrolling or
>     loop vectorization were deemed beneficial, and the function _might_ be
>     better suited as a helper anyway.
> 
> Cycles are detected by iterating over Strongly Connected Components
> (SCCs) which imply the existence of cycles if a SCC contains more than one
> node, or it has a self-edge.

I'd move most of the commit message to the documentation of the
function.

> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../PrepareForTcgPass/PrepareForTcgPass.cpp   | 34 +++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> index cea6573e41..41f317ed0b 100644
> --- a/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> +++ b/subprojects/helper-to-tcg/src/PrepareForTcgPass/PrepareForTcgPass.cpp
> @@ -17,9 +17,39 @@
>  
>  #include "PrepareForTcgPass.hpp"
>  
> +#include <llvm/ADT/SCCIterator.h>
> +#include <llvm/ADT/SmallPtrSet.h>
> +#include <llvm/IR/Function.h>
> +#include <llvm/IR/Module.h>
> +
>  using namespace llvm;
>  
> -PreservedAnalyses PrepareForTcgPass::run(Module &M, ModuleAnalysisManager &MAM)
> -{
> +static void removeFunctionsWithLoops(Module &M, ModuleAnalysisManager &MAM) {
> +    // Iterate over all Strongly Connected Components (SCCs), a SCC implies
> +    // the existence of loops if:
> +    //   - it has more than one node, or;
> +    //   - it has a self-edge.
> +    SmallPtrSet<Function *, 16> FunctionsToRemove;
> +    for (Function &F : M) {
> +        if (F.isDeclaration()) {
> +            continue;
> +        }
> +        for (auto It = scc_begin(&F); !It.isAtEnd(); ++It) {
> +            if (It.hasCycle()) {
> +                FunctionsToRemove.insert(&F);
> +                break;
> +            }
> +        }
> +    }
> +
> +    for (Function *F : FunctionsToRemove) {
> +        F->setComdat(nullptr);
> +        F->deleteBody();
> +    }
> +}
> +
> +PreservedAnalyses PrepareForTcgPass::run(Module &M,
> +                                         ModuleAnalysisManager &MAM) {
> +    removeFunctionsWithLoops(M, MAM);
>      return PreservedAnalyses::none();
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

