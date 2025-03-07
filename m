Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B29C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqV49-0007Du-91; Fri, 07 Mar 2025 05:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV42-0007DT-U7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:36:23 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV40-0004gV-Vn
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:36:22 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dc299dee9so1546036276.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741343779; x=1741948579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kLmPuTPkxAyKDm7E12J+r9WbRuBKoTnv4o0hMexvlcw=;
 b=CeQ41XAZD6BVM4Nq40aA5PQuUatBRAd0jnh1FLDMdnYE0y7MWReuZgy1toX90ZnDas
 MtnimoGukAA3XcvAGPAo7a/lsAtdb+nONJqn49nwlr3Wq7axC3lv311mJVoKFK5irOB3
 iE47qg2gnelphK6sVqgp+DEuSB7Ch8oB6safP3v56bnQykZi8VNSDOxI7DUUiQy3CJ8M
 MORnnu6NV4doQtxNVyYlBKzS3QmXTVPGoGx0DgEg95djpc5nSU+bbgTL2YViaLTELnhc
 INtBxe0yFfDLIlaf62+tPVV3mKKhU3gyLaGGd/4GGWbmIz7yPoYkm+nSULcCutcJ01li
 6AGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741343779; x=1741948579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLmPuTPkxAyKDm7E12J+r9WbRuBKoTnv4o0hMexvlcw=;
 b=OvzXc5LgknEkWVpUsBs6RoIv6N9AMxV8b/1SX2x2LeecTIY+lATZCycME9Eqmr+yXA
 IW87LMqDyXQdQO6vEb63tdLSo06xiGPLQOp3alFZX9F6HaagyxuORVOfS98vl8DPeEs7
 /0GrTMOLJ6qzaql+eaOymYvsqzQg19b34ETB8Twqs+WiBxdnLm7rlyz0akux6I94P8GU
 IRimS02mx/Mpu8eGVgjZdfLLKoWPdfQkPu8QKct0WuR1yOhDkopiYRkg6qa+zo4dxwuX
 Au2NDAgdWvWljQN36s0+6HDFq0KoG/6HuaZ90TXj2t6Zs38PYMHDlMOSXWLR1QcVLlAR
 9ygw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWosrvEBiR5GtJOBzpY/zrMy82NvynTmw5qbRwBBSQOI0TjxLZ45LH3aKMC6Md9E9IX25cU5zioPhms@nongnu.org
X-Gm-Message-State: AOJu0YwFK+IIGwrkp+ntB9o1lU4HQrnpjU5dTCcu5/IaYzMouHyPFFPw
 maTkaGXzNlZHW/M/SstFQL1iE8q2dDtmokqQ8l416pS8eRDq+msRA6rnd6k1gfD1hbDNrqa6JYz
 IdoRchDIy6r8qd+Ao8uguTPF54yaFjyi6laXxfw==
X-Gm-Gg: ASbGncvnNE2z/BFOqBh2moTelgtmK9CJiV7qOJydiAnMEskcqmnt1HJ2JmEv60FdZSj
 Kpx0oYqVPyGM4FjQ7eMr8YMt0aJ4V2ontRR1g/3f7ciEiG8UtUl4LFxN8MRUEqiYWnolbIMfho7
 HSeA1ahAWIxCmEZ88u5KMk1yGt56k=
X-Google-Smtp-Source: AGHT+IEILKnMGvhXjFsl3Bp43vgXKpMYnA4edCIZqUOoUUYmzaBni70MZckDojlxOOtk2kUuSJmV+1FDTYAxhd5rSJ0=
X-Received: by 2002:a05:6902:33c3:b0:e60:97b9:5a96 with SMTP id
 3f1490d57ef6-e635c100616mr3061783276.1.1741343779628; Fri, 07 Mar 2025
 02:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20250210135804.3526943-1-peter.maydell@linaro.org>
 <CAFEAcA-SbHjBu8xo8Uy11n2N22LtUejARHC7w8ucu24kg15Xog@mail.gmail.com>
In-Reply-To: <CAFEAcA-SbHjBu8xo8Uy11n2N22LtUejARHC7w8ucu24kg15Xog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 10:36:08 +0000
X-Gm-Features: AQ5f1JoDA8Lw4OZdJgZwY9LksjpWrxU_IS5SPdObcl1E2VzQed9-Gjfno-pr_-A
Message-ID: <CAFEAcA_bL-OR=RNvnWokjoz05AAM1d-eCjG_YtE=_s-LdcHMZw@mail.gmail.com>
Subject: Re: [PATCH] util/qemu-timer.c: Don't warp timer from timerlist_rearm()
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In the absence of any objections, I'm putting this into
target-arm.next.

thanks
-- PMM

On Mon, 24 Feb 2025 at 14:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This has been reviewed, but nobody's picked it up. Paolo,
> MAINTAINERS says qemu-timer.c is part of your "Main loop"
> responsibilities. Did you want to pick it up? Or I could
> throw it in to target-arm.next if you prefer.
>
> thanks
> -- PMM
>
> On Mon, 10 Feb 2025 at 13:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Currently we call icount_start_warp_timer() from timerlist_rearm().
> > This produces incorrect behaviour, because timerlist_rearm() is
> > called, for instance, when a timer callback modifies its timer.  We
> > cannot decide here to warp the timer forwards to the next timer
> > deadline merely because all_cpu_threads_idle() is true, because the
> > timer callback we were called from (or some other callback later in
> > the list of callbacks being invoked) may be about to raise a CPU
> > interrupt and move a CPU from idle to ready.5A
> >
> > The only valid place to choose to warp the timer forward is from the
> > main loop, when we know we have no outstanding IO or timer callbacks
> > that might be about to wake up a CPU.
> >
> > For Arm guests, this bug was mostly latent until the refactoring
> > commit f6fc36deef6abc ("target/arm/helper: Implement
> > CNTHCTL_EL2.CNT[VP]MASK"), which exposed it because it refactored a
> > timer callback so that it happened to call timer_mod() first and
> > raise the interrupt second, when it had previously raised the
> > interrupt first and called timer_mod() afterwards.
> >
> > This call seems to have originally derived from the
> > pre-record-and-replay icount code, which (as of e.g.  commit
> > db1a49726c3c in 2010) in this location did a call to
> > qemu_notify_event(), necessary to get the icount code in the vCPU
> > round-robin thread to stop and recalculate the icount deadline when a
> > timer was reprogrammed from the IO thread.  In current QEMU,
> > everything is done on the vCPU thread when we are in icount mode, so
> > there's no need to try to notify another thread here.
> >
> > I suspect that the other reason why this call was doing icount timer
> > warping is that it pre-dates commit efab87cf79077a from 2015, which
> > added a call to icount_start_warp_timer() to main_loop_wait().  Once
> > the call in timerlist_rearm() has been removed, if the timer
> > callbacks don't cause any CPU to be woken up then we will end up
> > calling icount_start_warp_timer() from main_loop_wait() when the rr
> > main loop code calls rr_wait_io_event().
> >
> > Remove the incorrect call from timerlist_rearm().
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > As far as I can tell, this is the right thing, and it fixes the
> > "icount warps the timer when it should not" bug I'm trying to
> > address, but I'm not super familiar with the icount subsystem or its
> > evolution, so it's possible I've accidentally broken some other setup
> > here.  This does pass the tcg, functional and avocado tests,
> > including the record-and-replay ones.  I've cc'd it to stable as a
> > bugfix, but it definitely merits careful review first.
> > ---
> >  util/qemu-timer.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> > index 0e8a453eaa1..af6e1787e57 100644
> > --- a/util/qemu-timer.c
> > +++ b/util/qemu-timer.c
> > @@ -409,10 +409,6 @@ static bool timer_mod_ns_locked(QEMUTimerList *timer_list,
> >
> >  static void timerlist_rearm(QEMUTimerList *timer_list)
> >  {
> > -    /* Interrupt execution to force deadline recalculation.  */
> > -    if (icount_enabled() && timer_list->clock->type == QEMU_CLOCK_VIRTUAL) {
> > -        icount_start_warp_timer();
> > -    }
> >      timerlist_notify(timer_list);
> >  }
> >
> > --
> > 2.34.1

