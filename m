Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0574AE74AC8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIY1H-0003k3-Hd; Tue, 03 Dec 2024 13:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY1B-0003eF-Ro
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:53:06 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tIY18-0000lx-Ep
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=v3PoHTf/4Z/AjnlRHwTw6gE8NWBMPO5n5omaGD5JVgg=; b=dIvi6D+FooXwj9i
 sU5s1OzbeBcI8TVYw4CTsyflAQZlS/y76wTdNGsGv+M5VFwDVms4wZJvsRNmPNY9GSikoX6zweN0w
 zrnSb1qyS1c1zh7rYouFtC1Z0jZBYudnB5NuaC+lA+NgTtqEv5Pp6soetHPZ7mMyowmTvrQGOKFFl
 8o=;
Date: Tue, 3 Dec 2024 19:56:03 +0100
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, ltaylorsimpson@gmail.com, 
 bcain@quicinc.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [RFC PATCH v1 36/43] target/hexagon: Add temporary vector storage
Message-ID: <gcp5xcypulziy2ixslvsiekwidedztxydvypyc6faz2ssbzx2i@ibcmjqjzgxwp>
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-37-anjo@rev.ng>
 <eaf906e2-3973-466b-8a2e-f7749e844968@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaf906e2-3973-466b-8a2e-f7749e844968@linaro.org>
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
> > Temporary vectors in helper-to-tcg generated code are allocated from an
> > array of bytes in CPUArchState, specified with --temp-vector-block.
> > 
> > This commits adds such a block of memory to CPUArchState, if
> > CONFIG_HELPER_TO_TCG is set.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/hexagon/cpu.h | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> > index 7be4b5769e..fa6ac83e01 100644
> > --- a/target/hexagon/cpu.h
> > +++ b/target/hexagon/cpu.h
> > @@ -97,6 +97,10 @@ typedef struct CPUArchState {
> >       MMVector future_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
> >       MMVector tmp_VRegs[VECTOR_TEMPS_MAX] QEMU_ALIGNED(16);
> > +#ifdef CONFIG_HELPER_TO_TCG
> > +    uint8_t tmp_vmem[4096] QEMU_ALIGNED(16);
> > +#endif
> > +
> >       MMQReg QRegs[NUM_QREGS] QEMU_ALIGNED(16);
> >       MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
> 
> Wow.  Do you really require 4k in temp storage?

No, 4k is overkill used during testing.  But consider that Hexagon uses
128- and 256-byte vectors in some cases so if the emitted code uses say
5 temporaries in its computation we end up at 1280 bytes as an upper
bound.

Two ideas here, we can:

  1. Allow users to specify an upper bound on vector memory, and abort
     translation of helpers that surpass this, and;

  2. Emit maximum number of bytes used for vector temporaries to a
     macro.

//Anton

