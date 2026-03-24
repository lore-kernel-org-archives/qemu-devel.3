Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8C9F54AD2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54II-00041t-Gk; Tue, 24 Mar 2026 12:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w54IE-00041I-Uh
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:07:47 -0400
Received: from out-185.mta0.migadu.com ([91.218.175.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1w54ID-0007wx-1N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 12:07:46 -0400
Message-ID: <1aeb1610-fbe6-42f6-ae36-4d512d17ed49@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774368462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+FDRtdWjfZ6ybQ8CFeaIJMk3z8Ddb9wddgYxze1xm4=;
 b=niT17i7Gv9p5BL2HsrXymV6QnP2bDV+i/bgh727AxLf3JeA9J39aS1scw+vPhaplNCih+o
 bIvU84SiDh61EumhD6p4IN3mbNNlJSePNMcEdoxxdbXVYlhL4+ikSkvC6zp9g5tL8/87JO
 Io6GtnFf54kiHoaF2kE088awMDOj4s0=
Date: Wed, 25 Mar 2026 00:07:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] target/arm: Don't skip access flag fault for AccessType_AT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
References: <20260317122517.47627-1-zenghui.yu@linux.dev>
 <CAFEAcA9bGVuWXAPA0=EaAWXhSigm_yf5OYfnYoTjaQ8x1qXKYg@mail.gmail.com>
 <CAFEAcA9sovFYwoF1Jk6sN7Aheh1WXj+imAVhJ7ifpvTu7PHuFg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA9sovFYwoF1Jk6sN7Aheh1WXj+imAVhJ7ifpvTu7PHuFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.185; envelope-from=zenghui.yu@linux.dev;
 helo=out-185.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 3/24/26 9:38 PM, Peter Maydell wrote:
> On Thu, 19 Mar 2026 at 17:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 17 Mar 2026 at 12:25, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> > >
> > > As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():
> > >
> > >   // Check descriptor AF bit
> > >   elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
> > >           (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
> > >            boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
> > >       fault.statuscode = Fault_AccessFlag;
> > >
> > > an access flag fault should be generated for AccessType_AT, if the AF bit
> > > is 0 and !param.ha.
> >
> > Did you find this by code inspection, or because it caused
> > a guest to go wrong?
> >
> > We should probably
> >
> > Cc: qemu-stable@nongnu.org
> >
> > > Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
> > > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > > ---
> > >  target/arm/ptw.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > > index 8b8dc09e72..572048d560 100644
> > > --- a/target/arm/ptw.c
> > > +++ b/target/arm/ptw.c
> > > @@ -2118,6 +2118,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
> > >      descaddr &= ~(hwaddr)(page_size - 1);
> > >      descaddr |= (address & (page_size - 1));
> > >
> > > +    /* Check descriptor AF bit */
> > > +    if (!(descriptor & (1 << 10)) && !param.ha) {
> > > +        fi->type = ARMFault_AccessFlag;
> > > +        goto do_fault;
> > > +    }
> > > +
> > >      /*
> > >       * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
> > >       * and it is IMPLEMENTATION DEFINED whether AF is updated
> > > @@ -2127,15 +2133,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
> > >          /*
> > >           * Access flag.
> > >           * If HA is enabled, prepare to update the descriptor below.
> > > -         * Otherwise, pass the access fault on to software.
> > >           */
> > > -        if (!(descriptor & (1 << 10))) {
> > > -            if (param.ha) {
> > > -                new_descriptor |= 1 << 10; /* AF */
> > > -            } else {
> > > -                fi->type = ARMFault_AccessFlag;
> > > -                goto do_fault;
> > > -            }
> > > +        if (!(descriptor & (1 << 10)) && param.ha) {
> > > +            new_descriptor |= 1 << 10; /* AF */
> > >          }
> >
> > This is definitely correct behaviour for AT insns. The only
> > thing I'm wondering about is what we should do for the
> > ptw->in_debug == true case. Before commit efebeec13d07 we
> > were checking !ptw->in_debug to skip both the testing and
> > the updating of the access flag; now we will skip the update
> > (definitely correct) but will fail debug accesses if the
> > access flag is not set.
> >
> > There's an argument that if you're doing a debugger access
> > it's not very helpful for it to not work just because the OS
> > happens to have cleared the access flag on the page table entry
> > (we also ignore permissions on debug accesses, though there
> > are some code paths where we do enforce permissions, not
> > really intentionally).
> >
> > On the other hand, we don't and I think have never suppressed
> > AccessFlag faults for the get_phys_addr_v6 short-descriptor
> > tables, so honouring them here too is at least consistent.
> 
> Having thought about this a little more, I think we should
> continue to not raise the AccessFlag fault for in_debug = true:
> it is what we've been doing previously for LPAE, at least, and
> it is what intention of the debugger access codepath is.
> 
> Could you do a v2 of this patch that handles in_debug = true, please?

Sure, sent out now. Thanks for your suggestion!

Zenghui

