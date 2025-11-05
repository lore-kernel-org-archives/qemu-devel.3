Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDC2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGkMK-0000OD-TB; Wed, 05 Nov 2025 15:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGkMH-0000Np-FP
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vGkME-0004A1-G1
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 15:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762375433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqkoa1+83IGMORjRogR6fuomDsZuGRTpVjBYvV0qfYE=;
 b=b7YgYfdnSbZy9MqQiNHuk2RuKLXJ4ZalyG0PokCFmHMJYwTQcmnJlguPg5E0imDZJOC+cP
 CtkwAwE0DNhoVGAq80fPQjIkiVGcxNMxE69X+uwJjL0aJK0Gg/AFP5AeZEuB6DmCebEVT5
 qQJnS6iTi4TZCjVcPGzKOTcGb8xoRFQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-bCvYwayoPLCATTUvG4LF8w-1; Wed, 05 Nov 2025 15:43:47 -0500
X-MC-Unique: bCvYwayoPLCATTUvG4LF8w-1
X-Mimecast-MFC-AGG-ID: bCvYwayoPLCATTUvG4LF8w_1762375427
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8805713e84fso8150106d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762375426; x=1762980226; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqkoa1+83IGMORjRogR6fuomDsZuGRTpVjBYvV0qfYE=;
 b=regozymo5FSupqGOFutd/4ta3727ChLLEp8FdZoZkLXy8o+68qEdORlPb6XOWGvGp2
 5fsAEzZpNY7sI1BEhU1BheRUngNatrm/vE31cplbX6s8niwkaXJLB1yoeE8RyVktj1Vk
 xOiN7vw3sl1REi/S3Atcq/0xm4C2OFHI7EolVguKOkebrtyUueYtKW2otkmpUk8kGsv4
 CbGsfMjSSlx6XZW8a6HJo4DxZ/Nrv25j3vEE507D2PTWuc1o4/xEgkyZ8DZitqiVC2vb
 HpNEF6474ZIEgNoAV1rQz7d8cHrWTNFrs3/75AeeD+0+S8xiQkH92VaLfyZzN/QDeFdO
 AfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762375426; x=1762980226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqkoa1+83IGMORjRogR6fuomDsZuGRTpVjBYvV0qfYE=;
 b=HROsFBrIj25OcMpMUgm3K9XHETT06Bi7/E6gpzxqFhSDd8p9rPfMlN50zT869Hb40j
 ENDtMFR6vf/3JMEnz1OzyTWS0BPOmBgJfqKKpwxm9F3F0T5p2deP3cWpkW0zlF5xnOfa
 eOKRaBXbqN9wpGxEO3fIT0FETqXIkKeLKF+A+a1Bk8AAlA2CDsoaGpYt6Y0hTCNf46/P
 RWTguHZg1VORpD2u2Qcuy479HYM3bCLuzIHURRlG4yOblEyv+SQFNnz4ZWd3KwKb1cwl
 0PzPZTtqWwhlKvdjrvUVfkUIX1GqLGDJPSeKXjsMtDsOk0bIkoOdM9zD2rwhZcYGgszp
 D0gA==
X-Gm-Message-State: AOJu0YzqhfTZbaY0i1AUtQ0O2Er1ZvJPvGt+i+LK1GkTLyadoV42AkGN
 XdoOxi5AM85ENTlA5h+QtKnyOMZdRekf4O8lkSU26qNiE9W1RPckb1pt8NNPgOUEv9xQ3T5maeg
 wyXFutEoSLlmKQdmCEIomgU93f1P+NpqgbY1IEmZ0Qzd2A7ofslhUaR5j
X-Gm-Gg: ASbGncvKcYc9b1AQCsiV2Nsw8lAPhzDWz/ZNkXkyn4ak9S8a27k9fc5JRnhzsIGVP6f
 N28TYNE6sWzXjacUE51sL4Ob0NwwwVKBNEZymYYH3SBre2fa3X6C8o33apSFlesL6W1iN+3oE8c
 eLkbsOjDdfBXIA/Ql9X0PMptJBJP/86zNVmExat1ENKEhe8+DQhutQVk3EzwCCAi0rRKAjRZnLU
 WCsMaT9kblcQJv6SBwknfi4JAAuzJyJaVmVMAVFgSAu9yTihg4JgYBeu7owTikbAQUk7h50x/5C
 fLUlIE/47aykxvLlOxuFuUW5xfjbvNrtkLXa16qHRwMLplCBaj+UIEKtkFhf7/AcDMc=
X-Received: by 2002:a05:6214:d63:b0:87d:e32:81c4 with SMTP id
 6a1803df08f44-88071192603mr57165896d6.48.1762375425769; 
 Wed, 05 Nov 2025 12:43:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4oNNBH6Tylsqnyp0pymk90gHie0K5X6NM2CzB4hDFKltvznXjP7z6uJjul5JdlScdgYkOzg==
X-Received: by 2002:a05:6214:d63:b0:87d:e32:81c4 with SMTP id
 6a1803df08f44-88071192603mr57165496d6.48.1762375425083; 
 Wed, 05 Nov 2025 12:43:45 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88082a3165asm4014626d6.50.2025.11.05.12.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 12:43:44 -0800 (PST)
Date: Wed, 5 Nov 2025 15:43:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aQu2_izqViAbJ3A9@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

On Mon, Nov 03, 2025 at 06:45:30PM +0900, Akihiko Odaki wrote:
> On 2025/10/30 3:22, Peter Xu wrote:
> > On Wed, Oct 29, 2025 at 03:12:48PM +0900, Akihiko Odaki wrote:
> > > drain_call_rcu() triggers the force quiescent state, but it can be
> > > delayed if the RCU thread is sleeping. Ensure the force quiescent state
> > > is immediately triggered by waking the RCU thread up.
> > > 
> > > The logic to trigger the force quiescent state is decoupled as
> > > force_rcu() so that it can be used independently.
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > >   include/qemu/rcu.h |   1 +
> > >   util/rcu.c         | 106 ++++++++++++++++++++++++++++++++---------------------
> > >   2 files changed, 65 insertions(+), 42 deletions(-)
> > > 
> > > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > > index 020dbe4d8b77..d6aa4e5854d3 100644
> > > --- a/include/qemu/rcu.h
> > > +++ b/include/qemu/rcu.h
> > > @@ -118,6 +118,7 @@ static inline void rcu_read_unlock(void)
> > >       }
> > >   }
> > > +void force_rcu(void);
> > >   void synchronize_rcu(void);
> > >   /*
> > > diff --git a/util/rcu.c b/util/rcu.c
> > > index 3c4af9d213c8..85f9333f5dff 100644
> > > --- a/util/rcu.c
> > > +++ b/util/rcu.c
> > > @@ -49,10 +49,13 @@
> > >   unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
> > >   QemuEvent rcu_gp_event;
> > > -static int in_drain_call_rcu;
> > > +static bool forced;
> > >   static int rcu_call_count;
> > >   static QemuMutex rcu_registry_lock;
> > > +/* Set when the forced variable is set or rcu_call_count becomes non-zero. */
> > > +static QemuEvent sync_event;
> > > +
> > >   /*
> > >    * Check whether a quiescent state was crossed between the beginning of
> > >    * update_counter_and_wait and now.
> > > @@ -74,36 +77,21 @@ QEMU_DEFINE_CO_TLS(struct rcu_reader_data, rcu_reader)
> > >   typedef QLIST_HEAD(, rcu_reader_data) ThreadList;
> > >   static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
> > > +void force_rcu(void)
> > > +{
> > > +    qatomic_set(&forced, true);
> > > +    qemu_event_set(&sync_event);
> > > +}
> > > +
> > >   /* Wait for previous parity/grace period to be empty of readers.  */
> > > -static void wait_for_readers(void)
> > > +static void wait_for_readers(bool sleep)
> > >   {
> > >       ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
> > >       struct rcu_reader_data *index, *tmp;
> > > -    int sleeps = 0;
> > > -    bool forced = false;
> > > +    int sleeps = sleep ? 5 : 0;
> > > +    bool waiting = false;
> > >       for (;;) {
> > > -        /*
> > > -         * Force the grace period to end and wait for it if any of the
> > > -         * following heuristical conditions are satisfied:
> > > -         * - A decent number of callbacks piled up.
> > > -         * - It timed out.
> > > -         * - It is in a drain_call_rcu() call.
> > > -         *
> > > -         * Otherwise, periodically poll the grace period, hoping it ends
> > > -         * promptly.
> > > -         */
> > > -        if (!forced &&
> > > -            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> > > -             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
> > > -            forced = true;
> > > -
> > > -            QLIST_FOREACH(index, &registry, node) {
> > > -                notifier_list_notify(&index->force_rcu, NULL);
> > > -                qatomic_set(&index->waiting, true);
> > > -            }
> > > -        }
> > 
> > IIUC this is the part to set index->waiting first whenever necessary, then
> > that'll guarantee the wait(rcu_gp_event) will be notified in rcu unlock.
> > 
> > Now we removed this chunk, then could it happen if waiting=true and the
> > wait(rcu_gp_event) may wait for more than it should (as nobody will wake it
> > up if all threads have waiting=false)?
> 
> It is not removed, but it is moved along with the assignment of the waiting
> variable. So index->waiting is still set whenever the waiting variable is
> set and no hang up will happen.

Ah, I noticed the "waiting" is actually the global variable and I think
when I read it last time I somehow misread it with "sleep" (which was
passed down from the caller).

        if (waiting) {  <--------------------
            qemu_event_wait(&rcu_gp_event);
            qemu_event_reset(&rcu_gp_event);
        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||

Yeah, I think it's non-issue.  Please ignore my question.

> 
> > 
> > The other thing is, right below here there's the code and comment:
> > 
> >          /* Here, order the stores to index->waiting before the loads of
> >           * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
> >           * ensuring that the loads of index->ctr are sequentially consistent.
> >           *
> >           * If this is the last iteration, this barrier also prevents
> >           * frees from seeping upwards, and orders the two wait phases
> >           * on architectures with 32-bit longs; see enter_qs().
> >           */
> >          smp_mb_global();
> > 
> > IIUC it explains the mb_global() to order the updates of waiting and the
> > reads of index->ctr.  It doesn't look like applicable anymore.  Said that,
> > I think we should indeed still need some barrier to make sure we read
> > index->ctr at least to be after we update global gp_ctr (done before
> > calling wait_for_readers()).  I'm not sure if it means the mb is needed,
> > however maybe at least the comment is outdated if so.
> 
> It is still applicable. The stores to index->waiting is still present and
> needs to be ordered before the loads of index->ctr.
> 
> > 
> > > -
> > >           /* Here, order the stores to index->waiting before the loads of
> > >            * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
> > >            * ensuring that the loads of index->ctr are sequentially consistent.
> > > @@ -150,7 +138,8 @@ static void wait_for_readers(void)
> > >            */
> > >           qemu_mutex_unlock(&rcu_registry_lock);
> > > -        if (forced) {
> > > +        if (waiting) {
> > > +            /* Wait for the forced quiescent state. */
> > >               qemu_event_wait(&rcu_gp_event);
> > >               /*
> > > @@ -158,9 +147,25 @@ static void wait_for_readers(void)
> > >                * while we walk the list.
> > >                */
> > >               qemu_event_reset(&rcu_gp_event);
> > > +        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> > > +                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
> > > +            /*
> > > +             * Now one of the following heuristical conditions is satisfied:
> > > +             * - A decent number of callbacks piled up.
> > > +             * - It timed out.
> > > +             * - force_rcu() was called.
> > > +             *
> > > +             * Force a quiescent state.
> > > +             */
> > > +            waiting = true;
> > > +
> > > +            QLIST_FOREACH(index, &registry, node) {
> > > +                notifier_list_notify(&index->force_rcu, NULL);
> > > +                qatomic_set(&index->waiting, true);
> > > +            }
> > >           } else {
> > > -            g_usleep(10000);
> > > -            sleeps++;
> > > +            /* Try again. */
> > > +            sleeps--;
> > >           }
> > >           qemu_mutex_lock(&rcu_registry_lock);
> > > @@ -170,7 +175,7 @@ static void wait_for_readers(void)
> > >       QLIST_SWAP(&registry, &qsreaders, node);
> > >   }
> > > -static void enter_qs(void)
> > > +static void enter_qs(bool sleep)
> > >   {
> > >       /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
> > >        * Pairs with smp_mb_placeholder() in rcu_read_lock().
> > > @@ -189,14 +194,14 @@ static void enter_qs(void)
> > >                * Switch parity: 0 -> 1, 1 -> 0.
> > >                */
> > >               qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
> > > -            wait_for_readers();
> > > +            wait_for_readers(sleep);
> > >               qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
> > >           } else {
> > >               /* Increment current grace period.  */
> > >               qatomic_set(&rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
> > >           }
> > > -        wait_for_readers();
> > > +        wait_for_readers(sleep);
> > >       }
> > >   }
> > > @@ -205,7 +210,6 @@ static void enter_qs(void)
> > >    */
> > >   static struct rcu_head dummy;
> > >   static struct rcu_head *head = &dummy, **tail = &dummy.next;
> > > -static QemuEvent rcu_call_ready_event;
> > >   static void enqueue(struct rcu_head *node)
> > >   {
> > > @@ -282,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
> > >       rcu_register_thread();
> > >       for (;;) {
> > > +        bool sleep = true;
> > >           int n;
> > >           /*
> > > @@ -289,7 +294,7 @@ static void *call_rcu_thread(void *opaque)
> > >            * added before enter_qs() starts.
> > >            */
> > >           for (;;) {
> > > -            qemu_event_reset(&rcu_call_ready_event);
> > > +            qemu_event_reset(&sync_event);
> > >               n = qatomic_read(&rcu_call_count);
> > >               if (n) {
> > >                   break;
> > > @@ -298,20 +303,36 @@ static void *call_rcu_thread(void *opaque)
> > >   #if defined(CONFIG_MALLOC_TRIM)
> > >               malloc_trim(4 * 1024 * 1024);
> > >   #endif
> > > -            qemu_event_wait(&rcu_call_ready_event);
> > > +            qemu_event_wait(&sync_event);
> > > +        }
> > > +
> > > +        /*
> > > +         * Ensure that an event for a rcu_call_count change will not interrupt
> > > +         * wait_for_readers().
> > > +         */
> > > +        qemu_event_reset(&sync_event);
> > > +
> > > +        /*
> > > +         * Ensure that the forced variable has not been set after fetching
> > > +         * rcu_call_count; otherwise we may get confused by a force quiescent
> > > +         * state request for an element later than n.
> > > +         */
> > > +        while (qatomic_xchg(&forced, false)) {
> > > +            sleep = false;
> > > +            n = qatomic_read(&rcu_call_count);
> > >           }
> > 
> > This is pretty tricky, and I wonder if it will make the code easier to read
> > if we convert the sync_event to be a semaphore instead.  When as a sem, it
> > will take account of whatever kick to it, either a call_rcu1() or an
> > enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
> > worry on an slightly outdated "n" read because the 2nd round of sem_wait()
> > will catch that new "n".
> > 
> > Instead, worst case is rcu thread runs one more round without seeing
> > callbacks on the queue.
> > 
> > I'm not sure if that could help simplying code, maybe also make it less
> > error-prone.
> 
> Semaphore is not applicable here because it will not de-duplicate concurrent
> kicks of RCU threads.

Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
loops some more rounds reading "n", which looks all safe. No?

> 
> > 
> > > -        enter_qs();
> > > +        enter_qs(sleep);
> > >           qatomic_sub(&rcu_call_count, n);
> > >           bql_lock();
> > >           while (n > 0) {
> > >               node = try_dequeue();
> > >               while (!node) {
> > 
> > I have a pure question here not relevant to your changes.. do you know when
> > this "if" will trigger?  It seems to me the enqueue() should always happen
> > before the increment of rcu_call_count:
> > 
> > void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
> > {
> >      node->func = func;
> >      enqueue(node);
> > 
> >      if (!qatomic_fetch_inc(&rcu_call_count)) {
> >          qemu_event_set(&sync_event);
> >      }
> > }>
> > I believe qatomic_fetch_inc() is RMW so it's strong mb and order
> > guaranteed.  Then here why the node can be null even if we're sure >=n have
> > been enqueued?
> 
> Indeed, enqueue() always happens before the increment of rcu_call_count
> performed by the same thread.
> 
> The node can still be NULL when there are two concurrent call_rcu1()
> executions. In the following example, rcu_call_count will be greater than
> the number of visible nodes after (A) and before (B):
> 
> Thread T                 Thread U
> call_rcu1(O)
>  enqueue(O)
>   Load N from tail
>   tail = O->next
>                          call_rcu1(P)
>                           enqueue(P)
>                            Load O->next from tail
>                            tail = P
>                            O->next = P
>                           rcu_call_count++ (A)
>   N->next = O (B)
>   rcu_call_count++

Thanks, yeah it makes sense.  If you think worthwhile, maybe we could add a
comment after the first try_dequeue().

-- 
Peter Xu


