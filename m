Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57485C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 23:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9W7m-0002v4-Mu; Wed, 23 Sep 2026 19:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W7k-0002ua-EL; Wed, 23 Sep 2026 19:11:36 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>)
 id 1x9W7i-0003OG-BV; Wed, 23 Sep 2026 19:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=HQD/SjX
 /4hRiaVYhuD9IZAGihcis9WXAUErKANezolCE+XyD/7gRRfssXoMN04esblAR+y8rzYq2L
 NbZenTg/1oETz60I7PqO4PiPFVYYoVvAGqw7b/CmKkaBOdYxmejHPvpr/irvCAxUMH/ZR4
 hdCBEZtnwDqPAfbAzULC+v7klaWEDoOlbeXzuG3cTSVJfF2JS0ipbvMYcgFwne9+tLF0Qi
 uUw5P5icMyT1xnQij7p23p4GFW3Nq2q7rCvtcmqRfVs0y+aUMERtiNqavIcR5NxVv/H2nR
 Rzc7QlhgTy4ZiXAw0ZstzQnd/JWqao28IQsBj6D6LJYw9rLxqcHsp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=g
 XB4wVmKqWDRB795EVdYn7Jxopw8QnMbdaf/FjdgD1w=;
 h=references:in-reply-to:
 subject:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net; b=
 uc9qQ1DexwIYpb6E1+PWhkXe4fAxZ/RnSVLVpuu2g2hthxQcTJal/QSBw7n3WPO2Cv+jS/
 auEwPHfAD7nNLnQ4xmIrtoFnsxgqm/VQTcmIXBXAdrgsP7ReyVy4/T/JoPowW7y36JMgPO
 Dl6GJMsZ1iJJwClAt3qFhCwIs6mU/Lg6TmJn55gjUqdS4/3jSEcGE0df/rrtdQPXj+nDhN
 vMTl+FFCOMWAv7Q4I0o/CVGeFwcWEEX9JVku/uKzSANh23mWWa1svEedc2Gt4iDDDQW3Z2
 BbdbGn13SPQOVX3+byKQ6t4Bee1hGqp79NlyXaGPYrzH7rG2v7g8QAdVUJjFug==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=BjZCGZKS; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=EA9brCaX;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=gXB4wVmK
 qWDRB795EVdYn7Jxopw8QnMbdaf/FjdgD1w=; h=references:in-reply-to:
 subject:to:from:date; d=korins.ky;
 b=BjZCGZKSv5djlNXKPweHW68FS9RzBbq06
 ozAgYzo7lXlXxTBsNkxqJPtTYa1yXtRPSvJT14Qb+/n9+08Ic4z4eUPHPKxL8FTRK1AuOG
 28AQPDOVWI06BanVF0L11qq+M9ZuncCnkxODp0h+f63Fz9bLqstXHlQT0dT8coue56QFWU
 i+M3iJa3hisnAW97b+xUDVc9RSqCgDi5i92nJfFwv8AkRWQsgCBRQHn0q/yXqzCWOGr713
 oropFKGr9ghD+rn1VGp0q89epn2DSvqtmD3xfRX0pkFiDMEpfWxm/edayTL83R9bbguIRh
 d2jhQ3SBg33xr/aNehCsW7i+s+LkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=gXB4wVmKqWDRB795EVdYn7Jxopw8QnMbdaf/FjdgD1w=; h=references:
 in-reply-to:subject:to:from:date; d=korins.ky; b=EA9brCaXQfCoKiing24sS
 AVHTV3dKl4Iv8MbG6ibZ4CnU8j8wIdwYqZXH/3ZyMKmb3fwLqrvJ9vaDJ5c8x4FCA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id e0f84ae5
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 24 Sep 2026 01:11:31 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) id 3698c682;
 Thu, 24 Sep 2026 01:11:29 +0200 (CEST)
Date: Thu, 24 Sep 2026 01:11:29 +0200
Message-ID: <87fqyz5zry.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
In-Reply-To: <20260923002139.9c3d31d4-37-amachhiw@linux.ibm.com>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
 <20260923002139.9c3d31d4-37-amachhiw@linux.ibm.com>
User-Agent: Wanderlust
Mail-Followup-To: kirill@korins.ky, mark.cave-ayland@ilande.co.uk,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 22 Sep 2026 21:42:27 +0200,
Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
> 
> On 2026/09/03 01:50 PM, Kirill A. Korinsky wrote:
> > OpenBSD writes zero to an edge triggered decrementer, then enters idle
> > expecting its interrupt. QEMU defers the already due edge to a timer at
> > the current virtual time, leaving the guest stalled.
> > 
> > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > ---
> >  hw/ppc/ppc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index b123b4cc1c..d99e47d532 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
> >       * an edge interrupt, so raise it here too.
> >       */
> >      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> > +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
> 
> The fix is correct for mac99/G3/G4, but the guard flag is too broad and
> introduces a regression on PPE42.
> 
> Commit 17dd1354c1d1 ("target/ppc: Decrementer fix BookE semantics") explicitly
> removed the immediate raise on value==0 with the rationale: "BookE says a
> decrementer interrupt should not be raised on a store of 0, only of a decrement
> from 1."
> 
> The new clause:
> 
>     ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0)
> 
> also fires for PPE42, which goes through ppc_booke_timers_init() with
> PPC_TIMER_PPE and gets PPC_DECR_UNDERFLOW_TRIGGERED set - introduced by commit
> 7197f6f7baf2 ("hw/ppc: Support for an IBM PPE42 CPU decrementer").  That commit
> explicitly documents that PPE42 raises an interrupt when DEC[0] transitions from
> 0 to -1 (non-negative to negative) — not on a store of zero.  The new clause
> contradicts this.
> 
> Note that __cpu_ppc_store_decr() is reached by BookE machines too — both on
> direct guest writes to SPR_DECR and via the auto-reload path in booke_decr_cb()
> (which calls cpu_ppc_store_decr(env, DECAR) when TCR_ARE is set; the existing
> DECAR != 0 guard there already prevents a zero value from arriving via that
> route).  So the safety of normal BookE targets (e500, sam460ex, bamboo, virtex)
> is flag-based: they have PPC_DECR_ZERO_TRIGGERED set but not
> PPC_DECR_UNDERFLOW_TRIGGERED, so neither the old clause nor the new one fires
> for a guest write of zero.  That is the correct BookE behaviour per the
> architecture.
> 
> PPC_DECR_ZERO_TRIGGERED already exists in ppc.h (defined as "Decr interrupt
> triggered when the decrementer reaches zero") but is never checked in
> __cpu_ppc_store_decr().  I think the minimal fix is to set it in
> cpu_ppc_tb_init() for the non-64-bit path and guard the new clause on it:
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index b123b4cc1cce..6f99b61a2876 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
>       * an edge interrupt, so raise it here too.
>       */
>      if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
> +        ((flags & PPC_DECR_ZERO_TRIGGERED) && value == 0) ||
>          ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>            && signed_decr >= 0)) {
>          (*raise_excp)(cpu);
> @@ -1104,6 +1105,12 @@ void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
>      if (is_book3s_arch2x(env)) {
>          /* All Book3S 64bit CPUs implement level based DEC logic */
>          tb_env->flags |= PPC_DECR_UNDERFLOW_LEVEL;
> +    } else {
> +        /*
> +         * Classic 32-bit edge-triggered decrementer: zero write fires
> +         * immediately
> +         */
> +        tb_env->flags |= PPC_DECR_ZERO_TRIGGERED;
>      }
>      /* Create new timer */
>      tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> 
> 
> All callers of cpu_ppc_tb_init() that use a 32-bit classic CPU (mac99 with 7400,
> mac_oldworld/750, prep/604, pegasos/7457, amigaone/7457) take the else branch
> and get PPC_DECR_ZERO_TRIGGERED.  64-bit Book3S machines (spapr, pnv, mac99 with
> 970fx) take the if branch and are unchanged.  PPE42 goes through
> ppc_booke_timers_init() and never gets PPC_DECR_ZERO_TRIGGERED, so the new
> clause does not fire for it.
> 
> This scopes the fix to the classic 32-bit edge-triggered path (mac99, pegasos,
> prep, mac_oldworld, amigaone) and leaves PPE42 behaviour unchanged.  What do you
> think?
> 

It is sane and I had included your suggested way into v2 of the series.

Thanks!

-- 
wbr, Kirill

