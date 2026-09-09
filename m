Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED01CC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GDM-0004d0-CF; Wed, 09 Sep 2026 07:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x4GDK-0004cS-A0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:11:38 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x4GDI-0006mU-IH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=OMjZDX6rKwzBgAXL6s7+DESo+/QiwsVkvLwytKyvofU=; b=i3N8hbUwjiKNwhv
 YUz4VqCCKh0XenUoT+T2aTVBGj4dfrTLnNSHtKJIlrX+xEXXglMzayUJ07xBIsbX+gZQiOkVSEJOA
 xPd8L9mHWkrS8zPoeEtKAMpEXM7RrFMG+7OTTy4NTEnF1ux0cHJg7P1vx1CdkAGU1aIL3OVnGiN12
 io=;
Date: Wed, 9 Sep 2026 13:09:07 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 19/50] helper-to-tcg: Pipeline, run optimization pass
Message-ID: <20260909130907.4955f7bb@spawn>
In-Reply-To: <20260730031025.12926-20-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-20-anjo@rev.ng>
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

On Thu, 30 Jul 2026 05:09:53 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Run a standard LLVM -Oz optimization pass, which makes up the bulk of
> optimizations in helper-to-tcg.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  subprojects/helper-to-tcg/src/Pipeline.cpp | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
> index a11c5fd353..571276de24 100644
> --- a/subprojects/helper-to-tcg/src/Pipeline.cpp
> +++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
> @@ -202,5 +202,17 @@ int main(int argc, char **argv) {
>          MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
>      }
>  
> +    //
> +    // Run a -Oz optimization pass.  In general -Oz will prefer loop
> +    // vectorization over unrolling, as compared to -O3.  In TCG, this
> +    // translates to more utilization of gvec and possibly smaller TBs.
> +    //
> +
> +    // Optimization passes
> +    MPM.addPass(PB.buildModuleSimplificationPipeline(
> +        compat::OptimizationLevel::Oz, compat::LTOPhase));
> +    MPM.addPass(
> +        PB.buildModuleOptimizationPipeline(compat::OptimizationLevel::Oz, {}));
> +
>      return 0;
>  }
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

