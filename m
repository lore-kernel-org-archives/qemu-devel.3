Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B34DCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 14:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHN1e-000857-G8; Fri, 07 Nov 2025 09:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vHN1S-0007mS-MD
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vHN1O-00088I-Eo
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 09:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762524053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WgOgm6H/IUC4CGoa+U6ecogJSGJuuImmKR2/ZpJRXIY=;
 b=Ka1YLFP1JbM8p/c5pLMv3+7q8FIOk2C0MP/HP0/JCo/EVHrpxubP4+cZwPnl+1CqDgJQV1
 auvrcq6ENlXNpZ7Oa1zOHPb/zEOqDTBUWwGG/rXM+ZCAh9RbHTAu+V7nG5KI5h71WtoXb3
 Tjqi0BHcidOYR8Tetbn0FYFVjVEsbgQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-lDZZxQe4OqOFXDFuGxf68Q-1; Fri, 07 Nov 2025 09:00:51 -0500
X-MC-Unique: lDZZxQe4OqOFXDFuGxf68Q-1
X-Mimecast-MFC-AGG-ID: lDZZxQe4OqOFXDFuGxf68Q_1762524051
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8801c2b9ea7so22406026d6.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 06:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762524051; x=1763128851; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WgOgm6H/IUC4CGoa+U6ecogJSGJuuImmKR2/ZpJRXIY=;
 b=BZcNNAUq/iFx6bl0xVWefyveqy4XCSXahmuGsMjWsjqB0pjtbMK/C5DJoYo6TL3M/I
 9NSlnAtJnn+rNvR9bE/3c8DJdKKbjl0AiaeuB0E/C3m6bWojTUgdFn8D73l1A+QaDoBo
 Ak/eYGz8DJqQBTDaHrrRQs9I/EUDnbf2gtiXBlbyjjmWowu40W+c3gLzrhM5yNSF+DcK
 SHUqnq2KumbyWUA+jH7XwZXdm0aqncUKPxsqJ8w4w/OgbUwPcN09bK5S1qBRzM+/vW6C
 +HlFrcoeOPoDW6LwpN90OYe76D5PDyamTdhKHehTUTU1vYD7W9j8vGwiqln90uWwo2UZ
 QVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762524051; x=1763128851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgOgm6H/IUC4CGoa+U6ecogJSGJuuImmKR2/ZpJRXIY=;
 b=tIvt8em9E/DBdnECGxS0O96e9BZlu7A+/kHdzNJe6d1yOHo3OC0w1alZSLKZh5BGjy
 pFS1R37ybuVeETBHn43cjl1NnJsZYhm2o//OU6QgvuC0LDud10sgbeT65ceDMpbbS71b
 Ow+fkdCZ3cR8Ri1ubOvD6j69ZOkXhHnHvVV8+ZH1C+4YZpZnyS5erkPaYUzue1oAXRlu
 2SfKXDkE9zQEt92N8yK0E4b/p/dIS0o5Wa0Ttpgy8m2PCA1ajolI1eyQprgUb/ungZ3z
 jZGxTd0Lw4ni84FNvGucFUnHseUTv0QtGgIC/ChgG+KkUI7WCcgPUEwb8H/XdTMuRKIa
 IvTw==
X-Gm-Message-State: AOJu0Yy6sBMX1FgbtriNSwZYG33OhnqBlHFAhqqtWEOxl8cI63GJ5f+y
 bnYixZTiHLXpJlHysFAJDLL4NM2qQ4DMBLXUiQnZ35kGnmxqNQqZrnOERpKotVcAiDJdnu7WnK9
 M7J+cqhJYRKGcv8tJqHlRoYQXmq2bsEGdriZitzoIYsJKukComHLZcpoC
X-Gm-Gg: ASbGncs6TaLgjrFhfgsJeJYfr7j2jkPM6apzB2fI4TmHQ+xitp4L8eN3o7LSne8BMGy
 IYcymk9efFsJQxoXZ4jnQHa7DDQepgXsLRWcTblXS2ZsO1FF3BbkeyKhEry6wnbApOPbTLcJI2a
 gITh0bfXmRer3b39yiaG/LQpoQsmT8uDYAA4gtZHwNtnhLewKPOmFodofPrzibrYCT+9dgPRpxW
 xEUxM/ToarP8JrPfhEqxzZEipcWHr53YKpYjvTglGPltgGEvv/Aqp1lKVYcRMyRN0YK3/M5MAXZ
 ikPakwb5xCuk4oBh6egubrSEu3+iFhowo+oSycga9MaCWqH0OKnAZQTK+SOo4+c1rD0=
X-Received: by 2002:a05:6214:1303:b0:880:52d3:9c03 with SMTP id
 6a1803df08f44-88176754590mr44998196d6.33.1762524050749; 
 Fri, 07 Nov 2025 06:00:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp45xCUks8hieNDVBlhDnqdJ0xqgEV32Wj4qnp6xtTrdxK9KlZjSoyIpa+RW+461pyrBztIg==
X-Received: by 2002:a05:6214:1303:b0:880:52d3:9c03 with SMTP id
 6a1803df08f44-88176754590mr44986966d6.33.1762524041388; 
 Fri, 07 Nov 2025 06:00:41 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88082a0839dsm39861766d6.46.2025.11.07.06.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:00:40 -0800 (PST)
Date: Fri, 7 Nov 2025 09:00:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aQ37hd0fVJltYtt-@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 07, 2025 at 10:47:35AM +0900, Akihiko Odaki wrote:
> On 2025/11/07 6:52, Peter Xu wrote:
> > On Thu, Nov 06, 2025 at 10:40:52AM +0900, Akihiko Odaki wrote:
> > > > > > > +        /*
> > > > > > > +         * Ensure that the forced variable has not been set after fetching
> > > > > > > +         * rcu_call_count; otherwise we may get confused by a force quiescent
> > > > > > > +         * state request for an element later than n.
> > > > > > > +         */
> > > > > > > +        while (qatomic_xchg(&forced, false)) {
> > > > > > > +            sleep = false;
> > > > > > > +            n = qatomic_read(&rcu_call_count);
> > > > > > >             }
> > > > > > 
> > > > > > This is pretty tricky, and I wonder if it will make the code easier to read
> > > > > > if we convert the sync_event to be a semaphore instead.  When as a sem, it
> > > > > > will take account of whatever kick to it, either a call_rcu1() or an
> > > > > > enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
> > > > > > worry on an slightly outdated "n" read because the 2nd round of sem_wait()
> > > > > > will catch that new "n".
> > > > > > 
> > > > > > Instead, worst case is rcu thread runs one more round without seeing
> > > > > > callbacks on the queue.
> > > > > > 
> > > > > > I'm not sure if that could help simplying code, maybe also make it less
> > > > > > error-prone.
> > > > > 
> > > > > Semaphore is not applicable here because it will not de-duplicate concurrent
> > > > > kicks of RCU threads.
> > > > 
> > > > Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
> > > > thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
> > > > loops some more rounds reading "n", which looks all safe. No?
> > > 
> > > It is safe but incurs overheads and confusing. QemuEvent represents the
> > > boolean semantics better.
> > > 
> > > I also have difficulty to understand how converting sync_event to a
> > > semaphore simplifies the code. Perhaps some (pseudo)code to show how the
> > > code will look like may be useful.
> > 
> > I prepared a patch on top of your current patchset to show what I meant.  I
> > also added comments and some test results showing why I think it might be
> > fine that the sem overhead should be small.
> > 
> > In short, I tested a VM with 8 vCPUs and 4G mem, booting Linux and properly
> > poweroff, I only saw <1000 rcu_call1 users in total.  That should be the
> > max-bound of sem overhead on looping in rcu thread.
> > 
> > It's in patch format but still treat it as a comment instead to discuss
> > with you.  Attaching it is just easier for me.
> > 
> > ===8<===
> >  From 71f15ed19050a973088352a8d71b6cc6b7b5f7cf Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 6 Nov 2025 16:03:00 -0500
> > Subject: [PATCH] rcu: Make sync_event a semaphore
> > 
> > It could simply all reset logic, especially after enforced rcu is
> > introduced we'll also need a tweak to re-read "n", which can be avoided too
> > when with a sem.
> > 
> > However, the sem can introduce an overhead in high frequecy rcu frees.
> > This patch is drafted with the assumption that rcu free is at least very
> > rare in QEMU, hence it's not a problem.
> > 
> > When I tested with this command:
> > 
> > qemu-system-x86_64 -M q35,kernel-irqchip=split,suppress-vmdesc=on -smp 8 \
> >    -m 4G -msg timestamp=on -name peter-vm,debug-threads=on -cpu Nehalem \
> >    -accel kvm -qmp unix:/tmp/peter.sock,server,nowait -nographic \
> >    -monitor telnet::6666,server,nowait -netdev user,id=net0,hostfwd=tcp::5555-:22
> >    -device e1000,netdev=net0 -device virtio-balloon $DISK
> > 
> > I booted a pre-installed Linux, login and poweroff, wait until VM
> > completely shutdowns.  I captured less than 1000 rcu_free1() calls in
> > summary.  It means for the whole lifetime of such VM the max overhead of
> > the call_rcu_thread() loop reading rcu_call_count will be 1000 loops.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   util/rcu.c | 36 ++++++++----------------------------
> >   1 file changed, 8 insertions(+), 28 deletions(-)
> > 
> > diff --git a/util/rcu.c b/util/rcu.c
> > index 85f9333f5d..dfe031a5c9 100644
> > --- a/util/rcu.c
> > +++ b/util/rcu.c
> > @@ -54,7 +54,7 @@ static int rcu_call_count;
> >   static QemuMutex rcu_registry_lock;
> >   /* Set when the forced variable is set or rcu_call_count becomes non-zero. */
> > -static QemuEvent sync_event;
> > +static QemuSemaphore sync_event;
> >   /*
> >    * Check whether a quiescent state was crossed between the beginning of
> > @@ -80,7 +80,7 @@ static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
> >   void force_rcu(void)
> >   {
> >       qatomic_set(&forced, true);
> > -    qemu_event_set(&sync_event);
> > +    qemu_sem_post(&sync_event);
> >   }
> >   /* Wait for previous parity/grace period to be empty of readers.  */
> > @@ -148,7 +148,7 @@ static void wait_for_readers(bool sleep)
> >                */
> >               qemu_event_reset(&rcu_gp_event);
> >           } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> > -                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
> > +                   !sleeps || qemu_sem_timedwait(&sync_event, 10)) {
> >               /*
> >                * Now one of the following heuristical conditions is satisfied:
> >                * - A decent number of callbacks piled up.
> > @@ -286,7 +286,6 @@ static void *call_rcu_thread(void *opaque)
> >       rcu_register_thread();
> >       for (;;) {
> > -        bool sleep = true;
> >           int n;
> >           /*
> > @@ -294,7 +293,6 @@ static void *call_rcu_thread(void *opaque)
> >            * added before enter_qs() starts.
> >            */
> >           for (;;) {
> > -            qemu_event_reset(&sync_event);
> >               n = qatomic_read(&rcu_call_count);
> >               if (n) {
> >                   break;
> > @@ -303,36 +301,19 @@ static void *call_rcu_thread(void *opaque)
> >   #if defined(CONFIG_MALLOC_TRIM)
> >               malloc_trim(4 * 1024 * 1024);
> >   #endif
> > -            qemu_event_wait(&sync_event);
> > +            qemu_sem_wait(&sync_event);
> >           }
> > -        /*
> > -         * Ensure that an event for a rcu_call_count change will not interrupt
> > -         * wait_for_readers().
> > -         */
> > -        qemu_event_reset(&sync_event);
> > -
> > -        /*
> > -         * Ensure that the forced variable has not been set after fetching
> > -         * rcu_call_count; otherwise we may get confused by a force quiescent
> > -         * state request for an element later than n.
> > -         */
> > -        while (qatomic_xchg(&forced, false)) {
> > -            sleep = false;
> > -            n = qatomic_read(&rcu_call_count);
> > -        }
> > -
> > -        enter_qs(sleep);
> > +        enter_qs(!qatomic_xchg(&forced, false));
> 
> This is not OK; the forced variable may be set after rcu_call_count is
> fetched. In that case, we should avoid unsetting the force quiescent state
> request for the elements later than "n" or refetch "n".

Indeed I missed that part, but it should be trivial to fix, on top of my
previous patch:

===8<===
diff --git a/util/rcu.c b/util/rcu.c
index dfe031a5c9..aff98d9ee2 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -286,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
+        bool sleep;
         int n;
 
         /*
@@ -293,6 +294,7 @@ static void *call_rcu_thread(void *opaque)
          * added before enter_qs() starts.
          */
         for (;;) {
+            sleep = !qatomic_xchg(&forced, false);
             n = qatomic_read(&rcu_call_count);
             if (n) {
                 break;
@@ -304,7 +306,7 @@ static void *call_rcu_thread(void *opaque)
             qemu_sem_wait(&sync_event);
         }
 
-        enter_qs(!qatomic_xchg(&forced, false));
+        enter_qs(sleep);
         qatomic_sub(&rcu_call_count, n);
         bql_lock();
         while (n > 0) {
===8<===

The idea is still the same, using semaphore can avoid explicit resets and a
lot of other ordering constraints like reading call_count, etc.

E.g. even before this series, we still need to properly reset at explicit
time to make sure we can capture a set() correct.  When with sem, all these
issues are gone simply because we won't miss post() when it's a counter not
boolean.

Also, would you please also have a look at other comments I left in the
same email (after the patch I attached)?

https://lore.kernel.org/qemu-devel/aQ0Ys09WtlSPoapm@x1.local/

Can search "When I was having a closer look, I found some other issues".

Thanks,

-- 
Peter Xu


