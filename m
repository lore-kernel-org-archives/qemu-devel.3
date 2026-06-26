Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7929BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdFkL-0006qq-2K; Fri, 26 Jun 2026 19:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oupton@kernel.org>)
 id 1wdFkJ-0006qJ-1Y; Fri, 26 Jun 2026 19:14:03 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oupton@kernel.org>)
 id 1wdFkH-0005ny-IC; Fri, 26 Jun 2026 19:14:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F7F140B21;
 Fri, 26 Jun 2026 23:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780FD1F000E9;
 Fri, 26 Jun 2026 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782515638;
 bh=yl8+LuCMuLG3/XVsdQ4YgbB0rlUGhos48P/KRlhVows=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KHIuhYavF7K/ba06HdItjpkUppQrQvf6CUM4RK5q3jEU/ZSTJTNDkN5r27WT983oA
 oyd9H/z/ZBIk60+QVencNRfTLv7R4CS8mMxa//OZC8MvBUgYEbmha05Ej2j/wkvZ4H
 j5VhOq/8evPA8sMwKz7nPQgQetMFbfn24qYeh5xN9uR5lEri/eY+lrCswCI7qiEzn7
 EEYoRVhJbskxL2ubbvIkkteTmd3pVchEK1H1Ar18MDZebqWhsT0/p7w9tarqSuKu/9
 nKbEgHyWexwMiZ7edwuWb3Kx1XvNGjr+mtQSwiDshV0zoudDLQtyGkECFdIP/oZhFg
 cgZNAEOxnf9Pg==
Date: Fri, 26 Jun 2026 16:13:57 -0700
From: Oliver Upton <oupton@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Only evaluate SCR_EL3.PIEN if
 ARM_FEATURE_EL3 is present
Message-ID: <aj8HtXA7G_EFSrsL@kernel.org>
References: <20260626203639.431191-1-oupton@kernel.org>
 <854ffb2f-a363-4c69-9a51-95151dfff517@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <854ffb2f-a363-4c69-9a51-95151dfff517@linaro.org>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=oupton@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 26, 2026 at 03:55:22PM -0700, Richard Henderson wrote:
> On 6/26/26 13:36, Oliver Upton wrote:
> > Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
> > on -cpu max gets stuck in an infinite loop of stage-2 permission faults
> > due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.
> > 
> > Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
> > value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.
> > 
> > Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
> > Signed-off-by: Oliver Upton <oupton@kernel.org>
> > ---
> >   target/arm/ptw.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 1470de3010..4a7aeb140c 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -1414,9 +1414,13 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
> >                     PAGE_READ | PAGE_WRITE },
> >       };
> > -    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
> > -    int s2pi = extract64(pir, pi_index * 4, 4);
> > +    uint64_t pir = env->cp15.s2pir_el2;
> > +    int s2pi;
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN))
> > +	pir = 0;
> > +
> > +    s2pi = extract64(pir, pi_index * 4, 4);
> >       result->f.prot = perm_table[s2pi][2];
> >       return perm_table[s2pi][s1_is_el0];
> >   }
> > 
> > base-commit: 8f1d3b586f1265023f75ea9c227c35d463321aef
> 
> Braces required for the IF.  Otherwise,

Kernel style, my bad.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks!

-- 
Best,
Oliver

