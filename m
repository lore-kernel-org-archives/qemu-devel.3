Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15360C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtj4e-000770-FV; Tue, 11 Aug 2026 05:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtj4b-00076G-H3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:47:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wtj4P-0007kn-Gt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=bBH4j/sblPPJh9POV8uYhwTU4Jp//RVbLaaK8r1PzXA=; b=Wq6dZpvkw9IPaml
 5HeRJAS2n2/6mCGPG5PqMmy5PLqhjdXcSpcFfBtfu4nQKBKRymL25v6APcdJ6Teb+IhTmjkcC2XKC
 CYcy/hsmFoo8xmVLXf0BK/Up1XSnNRtxLR6lU7uFHDAdd9AUJLe/VIxwNZj2+BHIWGGja3qDL2J6P
 so=;
Date: Tue, 11 Aug 2026 11:52:09 +0200
To: Alessandro Di Federico <ale@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 14/50] helper-to-tcg: PrepareForOptPass, map annotations
Message-ID: <anrsNBMCjpC5g7yS@hive.localdomain>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-15-anjo@rev.ng>
 <20260807122651.692d3cec@spawn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807122651.692d3cec@spawn>
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

On 07/08/26, Alessandro Di Federico via qemu development wrote:
> On Thu, 30 Jul 2026 05:09:48 +0200
> Anton Johansson <anjo@rev.ng> wrote:
> 
> > diff --git a/subprojects/helper-to-tcg/src/Pipeline.cpp b/subprojects/helper-to-tcg/src/Pipeline.cpp
> > index 59de572bf6..051611b0f3 100644
> > --- a/subprojects/helper-to-tcg/src/Pipeline.cpp
> > +++ b/subprojects/helper-to-tcg/src/Pipeline.cpp
> > @@ -184,7 +184,11 @@ int main(int argc, char **argv) {
> >          MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
> >      }
> >  
> > -    MPM.addPass(PrepareForOptPass());
> >
> > +    // TODO: Get pass results via dependencies instead? Adds more boiler-plate
> > +    // but is correlct in LLVM-terms.
> 
> The more appropriate way to do this is to have an *analysis* holding the
> data you want to share among your custom passes (AFAIU Annotations,
> DebugInfo, TcgGlobals, VL). An analysis, unlike a pass (i.e., a transformation)
> cannot modify the IR but it can expose (non-const) data to passes.
> For instance the `DominatorTreeAnalysis` exposes a dominator tree that
> can be updated.
> Another good example of this is the whole LLVM backend which holds the
> machine IR in an analysis and the backend passes modify it.
> 
> Then, in your transformation passes you can depend on the analysis and
> update its content.
> 
> It's always tempting to create local variables in the function creating
> the pass manager and passing references to custom passes in the
> constructor, but this makes the passes unusable from `opt`, which is
> important for unit testing.

I understand the difference between analysis and transformation passes.
Previously we had one analysis pass per piece of information we
gathered, e.g. one analysis pass for gathering annotations, one for
mapping globals, and so on.  Transformation passes would then depend on
these, which is the __correct__ way to structure this in LLVM terms.

In the end we had a bunch of very small analyses and much more boiler
plate for passes that make little sense to run independently in `opt`
anyway.  All small analyses/transformations were merged to `PrepareForOpt`
and friends, which IMO is simpler and easier to follow at the cost of
passing result in this ugly way.

Maybe grouping data gathering to a few analyses makes sense as a
compromise? In total we would have 1-2 extra passes simply to get rid of
the ugly result passing.

-- 
Anton Johansson
rev.ng Labs Srl.

