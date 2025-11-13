Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C03CD8CA4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJalv-00068O-3Q; Thu, 13 Nov 2025 12:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJajU-0003Xn-FG
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJajQ-0008N8-3N
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 12:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763053413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7TcA3OOuaDaI84ymjY4N+SNqWDxXq3tgysqNThEwlzc=;
 b=dYh4A60kFi4d950gUwFy8Q6fNF1N+5f90Zvt/Am2dz24SmgR8ZcyVKuckZNy9soZmzTvVf
 YnEeoAZQ0OJCfcY3LFo5QzuqdO29uwkk3nAEeqnYfl2X4HQ+etwJpMIwmFizUTk4cLB/vL
 yKNXOJzJ9kGxK5kfIYPhxN/K8GwoNU8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-wlz2o9mCPT6dhfRvL9xBUQ-1; Thu, 13 Nov 2025 12:03:30 -0500
X-MC-Unique: wlz2o9mCPT6dhfRvL9xBUQ-1
X-Mimecast-MFC-AGG-ID: wlz2o9mCPT6dhfRvL9xBUQ_1763053410
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b234bae2a7so336494785a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763053410; x=1763658210; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7TcA3OOuaDaI84ymjY4N+SNqWDxXq3tgysqNThEwlzc=;
 b=RGFce5BGEPkV/3ZO6lRteXdJOSqwTuthlm44ghtENDCF0v9CGp3HpKhxbsSSpMUgfg
 EGo6ozH/jEI8quUqkJzId08xaFNftcFyiyBUOSB0e9HMv8YvD1QACECxR5COTwmhAcIa
 gIo8CmN7R50m0CcD+r93aIYtg0pJeBTfOuT+aVmWTmKnWnaxyXwK3B0sISsQMBuvelKD
 KE299icqXcocpJS2SYJuGxDzCEHiskjR3gDEuDpkvGcUKN5+JTGci8kuUTGq+yG74IQ/
 IQpohfyJLkq6AGVdeQpTyhd8VWX5ok943+BBIXZq+bjZfW3B2wHf/5WnuuHE8MbfP3t8
 Zdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763053410; x=1763658210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TcA3OOuaDaI84ymjY4N+SNqWDxXq3tgysqNThEwlzc=;
 b=K3tPXn7sSjLsWUEGw2Dt9sYtnyF2bNFIg96CpFwaxpBAQYjJtRDznoijmjd24xeuN0
 fiRiJX8FHzDR+VvpB0RpUOi/7s+8eqbZkeA4xCGxTCnZyA6+NE+r8C1lPdyHt8qS5LTP
 eqHQaBCYK4ehD5fhQmVJOtNZVoaZd35fmOgZpWWVQmUXLuUNi9hQB/4Uo951spAOYb+w
 WjYuE7j6eNL9PeBolNXIUm/EF06WXQv6HddkUeyFckQzBqas7iluoz7SaeSuU/SpQMB/
 c2NdtyoJkTnBLDEK9YkzmIH4YKopU/QAWrB9vfVVCuHTo25PSXTJU+mTVSj9tOVk3+O7
 BesA==
X-Gm-Message-State: AOJu0Yw7n3UA7QErEugAXySRte4T2wKtFzblqdnTXn12vwIX98brlWPE
 mPSSNeEHU4dZMspWDViKdPy5+TNux295l/0ynCXY2aH4s/3fZ1B5ugGADBVgvaWDC/mKT8I1XdI
 nVs9BU9xbcHv9ZPSWJqRTfpf2Fvh71Vu5qA4xHUrf8w+BbP8kzyu1W7Wc
X-Gm-Gg: ASbGncu5c41RLZtPhjZctB81H699zVbQ+jR0uc31xCckVgIJiWxEm2UIA4u3qtekZAq
 DRZXrA90jso01uON3Kb59H1DRqFhnN8klahnHKmzFTYSJiOcXLYpRScAjQ3352e4xzWHAAxXU+0
 KTqrIdgFXZggaOMEdV2fURSvOEK1yIcbPyxodh1S28KxcFkvFZaOy2xZcjBxggrhLd2tXapQJgL
 wdN7w9UltjPIJVvgXLuafG0ke7FIkBkHJB6LVewhdO76/pn8x5RHNNl54LD/SXPb1YVp9kBTDnV
 TWWlgR8WBgEAHKVieg1yKbHu6lcFR4f2MOPhMuwoRSMZtnffZJsNtxAVgrpm0oJgxf7rX+Xnmg9
 hyA==
X-Received: by 2002:a05:620a:17a2:b0:863:42ea:d69d with SMTP id
 af79cd13be357-8b29b96e7a2mr1038917585a.63.1763053409881; 
 Thu, 13 Nov 2025 09:03:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7s1ye/kY+eDzwR6yCnocIEJYD44d1t5rwyKWJauMD15wJZTw0eH7atD38Avla7gQokz+70Q==
X-Received: by 2002:a05:620a:17a2:b0:863:42ea:d69d with SMTP id
 af79cd13be357-8b29b96e7a2mr1038910085a.63.1763053409116; 
 Thu, 13 Nov 2025 09:03:29 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aef2f936sm164739385a.29.2025.11.13.09.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 09:03:28 -0800 (PST)
Date: Thu, 13 Nov 2025 12:03:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aRYPXh_9m5ZvTi2w@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 08, 2025 at 10:47:16AM +0900, Akihiko Odaki wrote:
> On 2025/11/07 23:00, Peter Xu wrote:
> > On Fri, Nov 07, 2025 at 10:47:35AM +0900, Akihiko Odaki wrote:
> > > On 2025/11/07 6:52, Peter Xu wrote:
> > > > On Thu, Nov 06, 2025 at 10:40:52AM +0900, Akihiko Odaki wrote:
> > > > > > > > > +        /*
> > > > > > > > > +         * Ensure that the forced variable has not been set after fetching
> > > > > > > > > +         * rcu_call_count; otherwise we may get confused by a force quiescent
> > > > > > > > > +         * state request for an element later than n.
> > > > > > > > > +         */
> > > > > > > > > +        while (qatomic_xchg(&forced, false)) {
> > > > > > > > > +            sleep = false;
> > > > > > > > > +            n = qatomic_read(&rcu_call_count);
> > > > > > > > >              }
> > > > > > > > 
> > > > > > > > This is pretty tricky, and I wonder if it will make the code easier to read
> > > > > > > > if we convert the sync_event to be a semaphore instead.  When as a sem, it
> > > > > > > > will take account of whatever kick to it, either a call_rcu1() or an
> > > > > > > > enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
> > > > > > > > worry on an slightly outdated "n" read because the 2nd round of sem_wait()
> > > > > > > > will catch that new "n".
> > > > > > > > 
> > > > > > > > Instead, worst case is rcu thread runs one more round without seeing
> > > > > > > > callbacks on the queue.
> > > > > > > > 
> > > > > > > > I'm not sure if that could help simplying code, maybe also make it less
> > > > > > > > error-prone.
> > > > > > > 
> > > > > > > Semaphore is not applicable here because it will not de-duplicate concurrent
> > > > > > > kicks of RCU threads.
> > > > > > 
> > > > > > Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
> > > > > > thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
> > > > > > loops some more rounds reading "n", which looks all safe. No?
> > > > > 
> > > > > It is safe but incurs overheads and confusing. QemuEvent represents the
> > > > > boolean semantics better.
> > > > > 
> > > > > I also have difficulty to understand how converting sync_event to a
> > > > > semaphore simplifies the code. Perhaps some (pseudo)code to show how the
> > > > > code will look like may be useful.
> > > > 
> > > > I prepared a patch on top of your current patchset to show what I meant.  I
> > > > also added comments and some test results showing why I think it might be
> > > > fine that the sem overhead should be small.
> > > > 
> > > > In short, I tested a VM with 8 vCPUs and 4G mem, booting Linux and properly
> > > > poweroff, I only saw <1000 rcu_call1 users in total.  That should be the
> > > > max-bound of sem overhead on looping in rcu thread.
> > > > 
> > > > It's in patch format but still treat it as a comment instead to discuss
> > > > with you.  Attaching it is just easier for me.
> > > > 
> > > > ===8<===
> > > >   From 71f15ed19050a973088352a8d71b6cc6b7b5f7cf Mon Sep 17 00:00:00 2001
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Date: Thu, 6 Nov 2025 16:03:00 -0500
> > > > Subject: [PATCH] rcu: Make sync_event a semaphore
> > > > 
> > > > It could simply all reset logic, especially after enforced rcu is
> > > > introduced we'll also need a tweak to re-read "n", which can be avoided too
> > > > when with a sem.
> > > > 
> > > > However, the sem can introduce an overhead in high frequecy rcu frees.
> > > > This patch is drafted with the assumption that rcu free is at least very
> > > > rare in QEMU, hence it's not a problem.
> > > > 
> > > > When I tested with this command:
> > > > 
> > > > qemu-system-x86_64 -M q35,kernel-irqchip=split,suppress-vmdesc=on -smp 8 \
> > > >     -m 4G -msg timestamp=on -name peter-vm,debug-threads=on -cpu Nehalem \
> > > >     -accel kvm -qmp unix:/tmp/peter.sock,server,nowait -nographic \
> > > >     -monitor telnet::6666,server,nowait -netdev user,id=net0,hostfwd=tcp::5555-:22
> > > >     -device e1000,netdev=net0 -device virtio-balloon $DISK
> > > > 
> > > > I booted a pre-installed Linux, login and poweroff, wait until VM
> > > > completely shutdowns.  I captured less than 1000 rcu_free1() calls in
> > > > summary.  It means for the whole lifetime of such VM the max overhead of
> > > > the call_rcu_thread() loop reading rcu_call_count will be 1000 loops.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >    util/rcu.c | 36 ++++++++----------------------------
> > > >    1 file changed, 8 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/util/rcu.c b/util/rcu.c
> > > > index 85f9333f5d..dfe031a5c9 100644
> > > > --- a/util/rcu.c
> > > > +++ b/util/rcu.c
> > > > @@ -54,7 +54,7 @@ static int rcu_call_count;
> > > >    static QemuMutex rcu_registry_lock;
> > > >    /* Set when the forced variable is set or rcu_call_count becomes non-zero. */
> > > > -static QemuEvent sync_event;
> > > > +static QemuSemaphore sync_event;
> > > >    /*
> > > >     * Check whether a quiescent state was crossed between the beginning of
> > > > @@ -80,7 +80,7 @@ static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
> > > >    void force_rcu(void)
> > > >    {
> > > >        qatomic_set(&forced, true);
> > > > -    qemu_event_set(&sync_event);
> > > > +    qemu_sem_post(&sync_event);
> > > >    }
> > > >    /* Wait for previous parity/grace period to be empty of readers.  */
> > > > @@ -148,7 +148,7 @@ static void wait_for_readers(bool sleep)
> > > >                 */
> > > >                qemu_event_reset(&rcu_gp_event);
> > > >            } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> > > > -                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
> > > > +                   !sleeps || qemu_sem_timedwait(&sync_event, 10)) {
> > > >                /*
> > > >                 * Now one of the following heuristical conditions is satisfied:
> > > >                 * - A decent number of callbacks piled up.
> > > > @@ -286,7 +286,6 @@ static void *call_rcu_thread(void *opaque)
> > > >        rcu_register_thread();
> > > >        for (;;) {
> > > > -        bool sleep = true;
> > > >            int n;
> > > >            /*
> > > > @@ -294,7 +293,6 @@ static void *call_rcu_thread(void *opaque)
> > > >             * added before enter_qs() starts.
> > > >             */
> > > >            for (;;) {
> > > > -            qemu_event_reset(&sync_event);
> > > >                n = qatomic_read(&rcu_call_count);
> > > >                if (n) {
> > > >                    break;
> > > > @@ -303,36 +301,19 @@ static void *call_rcu_thread(void *opaque)
> > > >    #if defined(CONFIG_MALLOC_TRIM)
> > > >                malloc_trim(4 * 1024 * 1024);
> > > >    #endif
> > > > -            qemu_event_wait(&sync_event);
> > > > +            qemu_sem_wait(&sync_event);
> > > >            }
> > > > -        /*
> > > > -         * Ensure that an event for a rcu_call_count change will not interrupt
> > > > -         * wait_for_readers().
> > > > -         */
> > > > -        qemu_event_reset(&sync_event);
> > > > -
> > > > -        /*
> > > > -         * Ensure that the forced variable has not been set after fetching
> > > > -         * rcu_call_count; otherwise we may get confused by a force quiescent
> > > > -         * state request for an element later than n.
> > > > -         */
> > > > -        while (qatomic_xchg(&forced, false)) {
> > > > -            sleep = false;
> > > > -            n = qatomic_read(&rcu_call_count);
> > > > -        }
> > > > -
> > > > -        enter_qs(sleep);
> > > > +        enter_qs(!qatomic_xchg(&forced, false));
> > > 
> > > This is not OK; the forced variable may be set after rcu_call_count is
> > > fetched. In that case, we should avoid unsetting the force quiescent state
> > > request for the elements later than "n" or refetch "n".
> > 
> > Indeed I missed that part, but it should be trivial to fix, on top of my
> > previous patch:
> > 
> > ===8<===
> > diff --git a/util/rcu.c b/util/rcu.c
> > index dfe031a5c9..aff98d9ee2 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -286,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
> >       rcu_register_thread();
> >       for (;;) {
> > +        bool sleep;
> >           int n;
> >           /*
> > @@ -293,6 +294,7 @@ static void *call_rcu_thread(void *opaque)
> >            * added before enter_qs() starts.
> >            */
> >           for (;;) {
> > +            sleep = !qatomic_xchg(&forced, false);
> 
> This doesn't work either; the following sequence may happen (assume forced
> is false at beginning):
> 
> qatomic_xchg(&forced, false)  |
>                               | call_rcu1()
>                               |     qatomic_fetch_inc(&rcu_call_count)
>                               | force_rcu()
>                               |     qatomic_set(&forced, true)   <---------- [1]
> qatomic_read(&rcu_call_count)
> 
> We need to enter the force quiescent state for the node added with the
> call_rcu1() call in this sequence, but this code doesn't.

We don't necessarily need to identify "this sequence" or "next sequence",
but what we want to make sure when forced rcu triggered, rcu thread doesn't
sleep until flushing the callback injected right before force_rcu(), right?

IOW, at [1] above after setting forced, we still will post to sem, so IIUC
what will happen is both the normal call_rcu1() and force_rcu() will start
to post to the sem, hence the value of sem can be 2.  If I add the whole
process into above picture, there must be a pre-existing call_rcu1() that
kicks the rcu thread first at [0] otherwise rcu thread should be asleep,
then with the help of the 2nd post at [2] it should guarantee the rcu
callback of force_rcu() be finally invoked without sleep:

   rcu thread                               other thread
   ----------                               ------------

  call_rcu1()                   |
      qemu_sem_post(&sync_event)|                                  <---------- [0]
                                |

                     ... rcu thread waked up ...

                                |
  qatomic_xchg(&forced, false)  |
                                | call_rcu1()                      <---------- [a]
                                |     qatomic_fetch_inc(&rcu_call_count)
                                |     ... assume count>0 already, no post ...
                                | force_rcu()
                                |     qatomic_set(&forced, true)   <---------- [1]
                                |     ... force_rcu() always post ...
                                |     qemu_sem_post(&sync_event)   <---------- [2]
  qatomic_read(&rcu_call_count) |
  enter_qs()                    |
      wait_for_readers(sleep=N) |

    ... finish without explicit sleep in wait_for_readers(), due to [2] above...
        (even if sleep=N)

    ... invoked the rcu callback injected at [a] ...

    ... the next sequence of rcu will see force=true, but it's fine to see
        force=true (false positive in this case when [a] callback is
        already flushed) ...

IOW, IIUC there're two things needed to make sure the rcu thread finish
asap, one is the set of force=true, the other is the event_set(sync_event).

IMHO it's the same here when using sem, just that sem can remember more
than 1 count so it'll be able to identify concurrent call_rcu1() and
force_rcu().

Thanks,

> 
> >               n = qatomic_read(&rcu_call_count);
> >               if (n) {
> >                   break;
> > @@ -304,7 +306,7 @@ static void *call_rcu_thread(void *opaque)
> >               qemu_sem_wait(&sync_event);
> >           }
> > -        enter_qs(!qatomic_xchg(&forced, false));
> > +        enter_qs(sleep);
> >           qatomic_sub(&rcu_call_count, n);
> >           bql_lock();
> >           while (n > 0) {
> > ===8<===
> > 
> > The idea is still the same, using semaphore can avoid explicit resets and a
> > lot of other ordering constraints like reading call_count, etc.
> > 
> > E.g. even before this series, we still need to properly reset at explicit
> > time to make sure we can capture a set() correct.  When with sem, all these
> > issues are gone simply because we won't miss post() when it's a counter not
> > boolean.
> > 
> > Also, would you please also have a look at other comments I left in the
> > same email (after the patch I attached)?
> > 
> > https://lore.kernel.org/qemu-devel/aQ0Ys09WtlSPoapm@x1.local/
> > 
> > Can search "When I was having a closer look, I found some other issues".
> 
> I have just replied to the email. My mailer ignored the part after "--".
> 
> Regards,
> Akihiko Odaki
> 

-- 
Peter Xu


