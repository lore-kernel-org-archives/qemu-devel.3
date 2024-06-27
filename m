Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D34C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 17:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsjH-0003OD-Ux; Thu, 27 Jun 2024 13:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMsjF-0003Lz-Ri
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMsjA-00039s-SK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 13:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719508567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64uZB/zO7pjgcAyDtcIrLSMXEOiaMktvmXG18MrG3ys=;
 b=I2GkTtvLInXFEF6ervNPtlkPK4Jc6e/DwEbBBpsxMgwFJZNvgS68ALvZhxnYVA6AEOaKpU
 a1iINAaqQUAxH+6yqnSa4Pee13JzVH//CpihfBRD17hO4xG1Xfyd/tvUJNDkEajy0sz1u6
 jr1VFvjN2Kw2v4qqB2A3ehN3iI3uWOw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-6_nZlrx4NIOoOA72MthHYQ-1; Thu, 27 Jun 2024 13:16:03 -0400
X-MC-Unique: 6_nZlrx4NIOoOA72MthHYQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3634a25a7beso4739525f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 10:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719508561; x=1720113361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=64uZB/zO7pjgcAyDtcIrLSMXEOiaMktvmXG18MrG3ys=;
 b=Vs96Wz5Ldhx6/Fr81hGA49luuZ/HG8cApnlSTdOklXUH24P9iV2vI1oMVerIq1iTO0
 8Wi68KlqCzGLCYECyl0muqCOK9HbyCypYXlhGeHF5kcRQg7wTCwY0b0Rxij9bVTNsYzN
 jQZxEHlLpuTjCY+tm8ncYKoKXBkubTrNTjLPMw8s+XKtJXuWJ8PB6yka2NfZtSO8o1Vm
 xn8AsiNpHUy5OSdoft8qz6oCIMK0lReT3ebrnvzj+QlXzzKsKW0g6ry/ymCN9D6gPRXT
 hzAkpYG8jhLtqLnq9v7zrVOx4lw3kOOvx3HGSNKDVkVoF8gFj/m012rZyBV5dkScNQg6
 QHUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMJv1f8pWyH2PS+wSyJgahjNB/WKi/HeitkkEB6naEQIBWsYYLXH5bLg/pLPOhAntrtbFV2z7b6701VJR1tKCCy6SrB5o=
X-Gm-Message-State: AOJu0YzYHvOgiRawK5f0OtXlZA6ppm5jkWP0ZbloBdV3JY9NUuOi1vaD
 d4RI45GkD0OJULte077WhOHFXsV83PsONFWxu/hfgl+dIRNxiVjVi3GVVWXgs2x6RqMV+WDcysm
 6WHcJMdEJMpjqN8ud6F0MV6VWrBiPkZ/AM69S6zg2Y3HiTtbNT5GbVkTKPb5tfAaezOfed7FmW7
 bDw1j+kAegWXRCOSGNvB+iAqF6UUZWK2B6DfK02A==
X-Received: by 2002:a05:6000:144b:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-366f8e7d95dmr9437828f8f.50.1719508561109; 
 Thu, 27 Jun 2024 10:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5/7+zA9E7Yv93W2aG8Ez5ULkcmbIyKBQ8AAcIV4MjVhkSCgj6cAO5zWwFpS//lsCA4Z8/uQQXpYxZK97wQ24=
X-Received: by 2002:a05:6000:144b:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-366f8e7d95dmr9437816f8f.50.1719508560769; Thu, 27 Jun 2024
 10:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <ad0740c5-9bc2-443c-9caa-a243b3a29108@redhat.com>
 <20240627003134.3447175-1-rkir@google.com>
 <CABgObfajkBU9-aGQcDGf6taUGwZOG=O5sewzc1HjCWTb5cVA1A@mail.gmail.com>
 <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
In-Reply-To: <CAOGAQepLGTY-92So1arNZWjg9m+HZ8AjZ28Gsscm2ai5sj1AMQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Jun 2024 19:15:49 +0200
Message-ID: <CABgObfaBjneGy__o_aABdm+60wsg=rxLmgZLthwCoezwnH34ZQ@mail.gmail.com>
Subject: Re: [PATCH v3] timer: Fix a race condition between timer's callback
 and destroying code
To: Roman Kiryanov <rkir@google.com>
Cc: jansene@google.com, jpcottin@google.com, mett@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 27, 2024 at 6:12=E2=80=AFPM Roman Kiryanov <rkir@google.com> wr=
ote:
>
> On Thu, Jun 27, 2024 at 6:27=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On Thu, Jun 27, 2024 at 2:32=E2=80=AFAM Roman Kiryanov <rkir@google.com=
> wrote:
> > > +        if (qatomic_read(&ts->cb_running)) {
> > > +            qemu_event_wait(&timer_list->timers_done_ev);
> > > +        }
> >
> > qemu_event_wait() already has the right atomic magic, and
> > ts->cb_running is both redundant (in general), and I think racy (as
> > implemented in this patch).
>
> I added cb_running to avoid waiting for timers_done_ev if we know our
> cb is done.

Yes, but it's very tricky. Assuming we want to fix it in the timer
core, the QemuEvent should be enough, no need to optimize it. On the
other hand, I'm still worried about deadlocks (more below).

> > But especially, you haven't justified in the commit message _why_ you
> > need this.
>
> I mentioned the problem of cleanup racing with the timer's callback funct=
ion
> in the current shape of QEMU.

Yes, but it was not clear what are the involved threads. It is clear
now that you have a function in a separate thread, creating a timer in
the main QEMU event loop.

> > using
> > aio_bh_schedule_oneshot() or aio_wait_bh_oneshot() to synchronize
> > everything with the AioContext thread seems like a superior solution
> > to me.
>
> Could you please elaborate? The problem we want to solve is this:
>
> void myThreadFunc() {
>     CallbackState callbackState;
>     QEMUTimer timer;
>
>     timer_init(&timer, myClockType, myScale, &myTimerCallbackFunc,
> &callbackState);
>     ...
>     timer_del(&timer);
> }
>
> Currently, myTimerCallbackFunc could fire after myThreadFunc exits
> (if timer_del runs between qemu_mutex_unlock and cb(opaque) in
> timerlist_run_timers) and callbackState gets destroyed.

Ok, got it now. I agree that qemu_event_wait() is safe for you here
because you are in a completely separate thread. But I'm worried that
it causes deadlocks in QEMU where the timer callback and the timer_del
run in the same thread.

I think the easiest options would be:

1) if possible, allocate the timer and the callbackState statically in
the device.

2) use "aio_wait_bh_oneshot(qemu_get_aio_context(), [](void
*opaque){}, NULL);" after timer_del(). You can also put the timer and
the callbackState in a RAII wrapper, so that aio_wait_bh_oneshot() is
executed when the RAII wrapper is destructed

Another thing that you could do is to use a shared_ptr<> for the
timer+callbackState combo, and pass a weak_ptr<> to the timer. Then:

- at the beginning of the timer, you upgrade the weak_ptr with lock()
and if it fails, return

- at the end of myThreadfunc, you destruct the shared_ptr before
deleting the timer.

I'm not sure how you'd pass the weak_ptr/shared_ptr to a callback
(Rust has Weak::into_raw/Weak::from_raw, but I don't know C++ well
enough). That may be overkill.

Paolo


