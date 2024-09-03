Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1095FCD37AA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 19:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slYq9-0004Qo-BJ; Tue, 03 Sep 2024 15:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1slYpy-0004Oq-On
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:05:13 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1slYpw-0006kZ-2y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 15:05:09 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5e174925b7bso1186706eaf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725390306; x=1725995106; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rW/PLP82ejUxwwp2CtMSKKKyTQs0NkVVFEXjtEsYFrk=;
 b=CdDKzMPi6nUsrhs+zYWLz4qBgWIQFAIGxptfce90X+V7wPEQDOvM1f6t47ChsTa04f
 NDAJuEyqeYoAA4TBeolC5O5mUhVpEuw4rAsfv+xddNSdlgu8X27OS+sX1vWWHnLycQyu
 ey+lrNBYh1v/9CzIeGLLUux4tIryTDNYJaD6nCstFxNsFCLX6OSBXyqhvhOCfALnwNMD
 5k/fu4/4Y/nizQ5Dg7XmMdMzpgvjAl6QLc4TN4+dOR61e3ECsexnIUUkc7eXZyqNbI/C
 0JpCkwF1ni9vPJlhdQRH9pdhoJTOr5ZSEUV70HM/GLTLVgP1QaBPDCwBtws+TLfbK4t+
 sIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725390306; x=1725995106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW/PLP82ejUxwwp2CtMSKKKyTQs0NkVVFEXjtEsYFrk=;
 b=B8yOJG5RY4B+LfeuTnmDN6DGsFuGgxqGssIYKNBDxN1Kizx+9uIodEpP2QTf1azjhj
 H4TDCsloe9iPNnb9EOAFgmaadCQcs11Cy0UkgxpGfw8/QR/fRXDKE1mg2YbpCZPrMJgG
 i7XtWjBUOxo5QrLuE91qPzjE/MCMO5b9WFkgnO2sKjLGUObGrM32dwwq7UXHkP9oSr67
 ScAt1ypLMBrzEYrS7nChVQ5m73Dc+Fd80VhaeOxiiirMZ1wGep1uwmtx3K7B7tmEkgZ7
 3kPdK3uKYMmAQYWQYYu1WPRJ5sVok/Uj094DFL4WiiNEVViozEDDyPOOaTMWXYC0G6zh
 asQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCjyQl4qJyczAZfDxk43rVOZ6cZDsNR7IpjqeXLl0AL9iE+vMTGHA/G9LyG3W9N+NvLTcbOT2/nB9g@nongnu.org
X-Gm-Message-State: AOJu0Yy38m+8cQOzQONVtof66kZLsrxu7TKUKyf/bBHeA8laF4peVSBh
 zVaVQMbBe872XOqSmMxVcC4qtNpwvnvBTBp7mOpuVJmMf7ugbfLVnu6o0azSimnDxjJaQsVNm1t
 n+uvd0R9cqTGJ1URItjzdnd8F7ec=
X-Google-Smtp-Source: AGHT+IHgHkHViCzk+T+PZGF8nEtWGX4WpdQiT4/YO+qciBls0M1imx3o/QALU5jOUUwXhxwN8yeSk/2qIs870tW3X3Q=
X-Received: by 2002:a05:6871:23c3:b0:277:e1e8:a085 with SMTP id
 586e51a60fabf-277e1e8d7a2mr6483322fac.23.1725390306336; Tue, 03 Sep 2024
 12:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <CAJSP0QU+dhh_e2LJRoGCxtCEh6C2-GBoZoFZL2W-SMSQPzUtYg@mail.gmail.com>
 <d6e7dbd4-634f-4f62-8516-7bbf404b7adf@maciej.szmigiero.name>
In-Reply-To: <d6e7dbd4-634f-4f62-8516-7bbf404b7adf@maciej.szmigiero.name>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Sep 2024 15:04:54 -0400
Message-ID: <CAJSP0QXURSS4cHj0i6xy27HMbtF2D4ckL4fwDk5rHA3vFFtHUg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 3 Sept 2024 at 12:54, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 3.09.2024 15:55, Stefan Hajnoczi wrote:
> > On Tue, 27 Aug 2024 at 13:58, Maciej S. Szmigiero
> > <mail@maciej.szmigiero.name> wrote:
> >>
> >> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> >>
> >> Migration code wants to manage device data sending threads in one place.
> >>
> >> QEMU has an existing thread pool implementation, however it was limited
> >> to queuing AIO operations only and essentially had a 1:1 mapping between
> >> the current AioContext and the ThreadPool in use.
> >>
> >> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
> >> too.
> >>
> >> This brings a few new operations on a pool:
> >> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
> >> thread count in the pool.
> >>
> >> * thread_pool_join() operation waits until all the submitted work requests
> >> have finished.
> >>
> >> * thread_pool_poll() lets the new thread and / or thread completion bottom
> >> halves run (if they are indeed scheduled to be run).
> >> It is useful for thread pool users that need to launch or terminate new
> >> threads without returning to the QEMU main loop.
> >
> > Did you consider glib's GThreadPool?
> > https://docs.gtk.org/glib/struct.ThreadPool.html
> >
> > QEMU's thread pool is integrated into the QEMU event loop. If your
> > goal is to bypass the QEMU event loop, then you may as well use the
> > glib API instead.
> >
> > thread_pool_join() and thread_pool_poll() will lead to code that
> > blocks the event loop. QEMU's aio_poll() and nested event loops in
> > general are a source of hangs and re-entrancy bugs. I would prefer not
> > introducing these issues in the QEMU ThreadPool API.
> >
>
> Unfortunately, the problem with the migration code is that it is
> synchronous - it does not return to the main event loop until the
> migration is done.
>
> So the only way to handle things that need working event loop is to
> pump it manually from inside the migration code.
>
> The reason why I used the QEMU thread pool in the first place in this
> patch set version is because Peter asked me to do so during the review
> of its previous iteration [1].
>
> Peter also asked me previously to move to QEMU synchronization
> primitives from using the Glib ones in the early version of this
> patch set [2].
>
> I personally would rather use something common to many applications,
> well tested and with more pairs of eyes looking at it rather to
> re-invent things in QEMU.
>
> Looking at GThreadPool it seems that it lacks ability to wait until
> all queued work have finished, so this would need to be open-coded
> in the migration code.
>
> @Peter, what's your opinion on using Glib's thread pool instead of
> QEMU's one, considering the above things?

I'll add a bit more about my thinking:

Using QEMU's event-driven model is usually preferred because it makes
integrating with the rest of QEMU easy and avoids having lots of
single-purpose threads that are hard to observe/manage (e.g. through
the QMP monitor).

When there is a genuine need to spawn a thread and write synchronous
code (e.g. a blocking ioctl(2) call or something CPU-intensive), then
it's okay to do that. Use QEMUBH, EventNotifier, or other QEMU APIs to
synchronize between event loop threads and special-purpose synchronous
threads.

I haven't looked at the patch series enough to have an opinion about
whether this use case needs a special-purpose thread or not. I am
assuming it really needs to be a special-purpose thread. Peter and you
could discuss that further if you want.

I agree with Peter's request to use QEMU's synchronization primitives.
They do not depend on the event loop so they can be used outside the
event loop.

The issue I'm raising with this patch is that adding new join()/poll()
APIs that shouldn't be called from the event loop is bug-prone. It
will make the QEMU ThreadPool code harder to understand and maintain
because now there are two different contexts where different subsets
of this API can be used and mixing them leads to problems. To me the
non-event loop case is beyond the scope of QEMU's ThreadPool. I have
CCed Paolo, who wrote the thread pool in its current form in case he
wants to participate in the discussion.

Using glib's ThreadPool solves the issue while still reusing an
existing thread pool implementation. Waiting for all work to complete
can be done using QemuSemaphore.

Thanks,
Stefan

> Thanks,
> Maciej
>
> [1]: https://lore.kernel.org/qemu-devel/ZniFH14DT6ycjbrL@x1n/ point 5: "Worker thread model"
> [2]: https://lore.kernel.org/qemu-devel/Zi_9SyJy__8wJTou@x1n/
>

