Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B70EE74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXRx-0003OL-Ly; Tue, 03 Dec 2024 13:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXRg-0003NX-IF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:16:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIXRd-0002FX-K7
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:16:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lZroXs/IlA7QtJZm4uvlFl6f41lEKEK5zgsqrtD/E4k=; b=S5mV9OGH6UABO42
 xMcCqGrAbaC5MheMrarPc9xH+KDw/YT2SUVMPQ7BCa87BFexqko+zU0BcTJEDM0/Vpyby6lnzJ8z1
 D79fkNpJtSp0Zq2zVvxAovvIYE4xiJHwYyeUSd+g0l9Lo4Vy9JVX9VQmNcs+hAqLGDy6rOoGkLCqk
 Xo=;
Date: Tue, 3 Dec 2024 19:19:19 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 04/43] tcg: Add gvec functions for creating
 consant vectors
Message-ID: <vmaedyamz4zas5elmgn4sg4n3wrgofganonh2drsiube52awdx@76pvdn6onmkt>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-5-anjo@rev.ng>
 <a1e76d49-e307-4718-987a-839e0cbe074c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1e76d49-e307-4718-987a-839e0cbe074c@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/11/24, Richard Henderson wrote:
> On 11/20/24 19:49, Anton Johansson wrote:
> > This commit adds a gvec function for copying data from constant array
> > given in C to a gvec intptr_t.  For each element, a host store of
> > each constant is performed, this is not ideal and will inflate TBs for
> > large vectors.
> > 
> > Moreover, data will be copied during each run of the generated code
> > impacting performance.  A more suitable solution might store constant
> > vectors separately, this can be handled either on the QEMU or
> > helper-to-tcg side.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> 
> This is invalid because generic code does not know how to index elements
> within the target vector, which this is doing with its per-element copy.

Hmm I should take a look at tcg_gen_gvec_dup_imm() again, isn't it doing
basically the same thing?

> The code in target/arch/ knows the element ordering (though I suspect you
> have not taught llvm), and could arrange for the data to be put in the
> correct byte order, which could then be copied into place using plain host
> vector operations.  I won't attempt to riff on what such an interface would
> look like exactly, but I imagine that something sensible could be
> constructed with only a little effort.

I might have misunderstood how gvec works, I thought all elements would
be in host order, and so copying from a host C array would be fine?

//Anton

