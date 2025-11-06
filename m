Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BD4CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 21:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH7ui-0002Ry-LS; Thu, 06 Nov 2025 16:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH7ug-0002Rq-2n
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 16:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH7uc-00077y-Ii
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 16:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762465976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFqQ3k8ew5sAZC8AgtUBIqhAthez3TA7YBxoFYPmzV8=;
 b=Y4kEnfErdXX/VHerCv8NFoieAaeAxgJrE0UYjZ8E2KS+PaDCop2uuBZAcAdUPVITbw7696
 nGwxVjaEQrs9aNeee25ODOeah8VwwgpZ1UDnZTw2KCA/59KEB94VlBx3v4JCq/h2hcBy1f
 ziSRn0N/bApf/n0LTuAHDoqOAS9M2xw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-WC3Sdux_PxS0mwYsFEMlKw-1; Thu, 06 Nov 2025 16:52:55 -0500
X-MC-Unique: WC3Sdux_PxS0mwYsFEMlKw-1
X-Mimecast-MFC-AGG-ID: WC3Sdux_PxS0mwYsFEMlKw_1762465975
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8805713e84fso3231456d6.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 13:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762465975; x=1763070775; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sFqQ3k8ew5sAZC8AgtUBIqhAthez3TA7YBxoFYPmzV8=;
 b=lXT+ooKq+7i2hlnueLCcMBlMl7oxJ3WqVq7mqsLkzxD3OqvhWBQZ1pQoI81lXndP9S
 PMMicaIpoDNTQIs+RJBmLbDudEvJw8cC73SdhjVtlpT29oNhUWSdaAtvwLg8m+jrEUII
 Omeupy3iHI3juuYM534gq14hKRZWGdVSW+eGjnW5EiycOEguqDK+MRwhybYZ+cn6elOs
 Qwq5PefWjOke85NcIqo3ZssJLPIlJ/WN8Dtq4OeZ/BytIDZLSbUtEgKK1527LohckT0m
 pPRmeh6JgJsLwyLC5fHMUdA4wSEJHqUCvjvKTKiSPYzfIrpiPPQ1Y2Hk7zMjfD1aX033
 TlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762465975; x=1763070775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFqQ3k8ew5sAZC8AgtUBIqhAthez3TA7YBxoFYPmzV8=;
 b=mt+yt3Ep3myvWSkWR52c+vaouwOg9Bi7sKAX6w5fbA5ov8ZYNiPGV7ONc1NjE6479/
 ZEkLvnR8/MZ7UrIyLX+gfhSnWLZpqNGZGY2MfoBx2DLUoN47r8g1xN7Q3ylhccgW3FH5
 6YcA9PW2rkI8kq0/j7oPquIGhQl1d05G+TqH9zLV/9tb7MjneK0NILhdLSal+Q1veEbl
 yzTyyzac+eh1aVXZNvBPeX31r0pd6P5WaqMF4+2upokFSV2JnjZ5gNYBefqYT7ETtlXM
 XXfHouv0uOcTaLu1sUUFwQhpFKQROo+nbS6j44alU0Hof+GrksYCOwZ9VwrXmuztQsgs
 cI+g==
X-Gm-Message-State: AOJu0Yyy+ATofpKELJUVZTP+EvD6qnRiT7RCiM0LzGBOJf6Jnz7X/J3x
 RTsSO7rxuHzvJFlz93LUrZgzdvfKlZ5kmCmtTHJbTYdGvsgmC1TxrqGc2bHwFJcTZd0LFNHdufW
 A/rgOqo5ZwBmMylRocgRDFFi6AJQj9bS1xzJy6udWNPjzk5HggQqEXzqO
X-Gm-Gg: ASbGnct/4iw89pqhLCV/TVd4DT97XDHoyXLsR0oyqwCzy2DL5Xm4Zj6UKo9R/c0saJV
 SrNP3G7a06tPhxyluzmv77D81BXyVByge09JtWUAA/2trNiHEIvxui7Ud9JYQLj2nG57/JzGdKY
 lfgjXEyc/L2jy4pziT8z/xNeIYKwkiGTwXA5OI2x13+Z2Biprvtaq1zLwRjFr/qUk1cGvZhg7NG
 IPp+d0/VOkAt1mlYV5jhUGa/KhbC01MWBT3MHTfRuBtfbJPanlY8ecvfmWRfywgnRzQXjbFPGvP
 9PFVqgVg8nzwUG2XmsOs3iVSPtTBiS+XxYRPLDoUVksOUCdOz66o5UgetQ9UIX3gqzw=
X-Received: by 2002:a05:6214:20c4:b0:880:545b:ab72 with SMTP id
 6a1803df08f44-8817674011bmr15494746d6.36.1762465974661; 
 Thu, 06 Nov 2025 13:52:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQqm4NA5lcp1wm3QBHHIiQNGE4ghkxw5zdcFSwzJ3BNRvEzkcEitVHR/d0G8Lr+u2ji1mSbQ==
X-Received: by 2002:a05:6214:20c4:b0:880:545b:ab72 with SMTP id
 6a1803df08f44-8817674011bmr15494526d6.36.1762465974143; 
 Thu, 06 Nov 2025 13:52:54 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-880829c55ddsm26208866d6.37.2025.11.06.13.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 13:52:53 -0800 (PST)
Date: Thu, 6 Nov 2025 16:52:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aQ0Ys09WtlSPoapm@x1.local>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
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

On Thu, Nov 06, 2025 at 10:40:52AM +0900, Akihiko Odaki wrote:
> > > > > +        /*
> > > > > +         * Ensure that the forced variable has not been set after fetching
> > > > > +         * rcu_call_count; otherwise we may get confused by a force quiescent
> > > > > +         * state request for an element later than n.
> > > > > +         */
> > > > > +        while (qatomic_xchg(&forced, false)) {
> > > > > +            sleep = false;
> > > > > +            n = qatomic_read(&rcu_call_count);
> > > > >            }
> > > > 
> > > > This is pretty tricky, and I wonder if it will make the code easier to read
> > > > if we convert the sync_event to be a semaphore instead.  When as a sem, it
> > > > will take account of whatever kick to it, either a call_rcu1() or an
> > > > enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
> > > > worry on an slightly outdated "n" read because the 2nd round of sem_wait()
> > > > will catch that new "n".
> > > > 
> > > > Instead, worst case is rcu thread runs one more round without seeing
> > > > callbacks on the queue.
> > > > 
> > > > I'm not sure if that could help simplying code, maybe also make it less
> > > > error-prone.
> > > 
> > > Semaphore is not applicable here because it will not de-duplicate concurrent
> > > kicks of RCU threads.
> > 
> > Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
> > thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
> > loops some more rounds reading "n", which looks all safe. No?
> 
> It is safe but incurs overheads and confusing. QemuEvent represents the
> boolean semantics better.
> 
> I also have difficulty to understand how converting sync_event to a
> semaphore simplifies the code. Perhaps some (pseudo)code to show how the
> code will look like may be useful.

I prepared a patch on top of your current patchset to show what I meant.  I
also added comments and some test results showing why I think it might be
fine that the sem overhead should be small.

In short, I tested a VM with 8 vCPUs and 4G mem, booting Linux and properly
poweroff, I only saw <1000 rcu_call1 users in total.  That should be the
max-bound of sem overhead on looping in rcu thread.

It's in patch format but still treat it as a comment instead to discuss
with you.  Attaching it is just easier for me.

===8<===
From 71f15ed19050a973088352a8d71b6cc6b7b5f7cf Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 6 Nov 2025 16:03:00 -0500
Subject: [PATCH] rcu: Make sync_event a semaphore

It could simply all reset logic, especially after enforced rcu is
introduced we'll also need a tweak to re-read "n", which can be avoided too
when with a sem.

However, the sem can introduce an overhead in high frequecy rcu frees.
This patch is drafted with the assumption that rcu free is at least very
rare in QEMU, hence it's not a problem.

When I tested with this command:

qemu-system-x86_64 -M q35,kernel-irqchip=split,suppress-vmdesc=on -smp 8 \
  -m 4G -msg timestamp=on -name peter-vm,debug-threads=on -cpu Nehalem \
  -accel kvm -qmp unix:/tmp/peter.sock,server,nowait -nographic \
  -monitor telnet::6666,server,nowait -netdev user,id=net0,hostfwd=tcp::5555-:22
  -device e1000,netdev=net0 -device virtio-balloon $DISK

I booted a pre-installed Linux, login and poweroff, wait until VM
completely shutdowns.  I captured less than 1000 rcu_free1() calls in
summary.  It means for the whole lifetime of such VM the max overhead of
the call_rcu_thread() loop reading rcu_call_count will be 1000 loops.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/rcu.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/util/rcu.c b/util/rcu.c
index 85f9333f5d..dfe031a5c9 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -54,7 +54,7 @@ static int rcu_call_count;
 static QemuMutex rcu_registry_lock;
 
 /* Set when the forced variable is set or rcu_call_count becomes non-zero. */
-static QemuEvent sync_event;
+static QemuSemaphore sync_event;
 
 /*
  * Check whether a quiescent state was crossed between the beginning of
@@ -80,7 +80,7 @@ static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
 void force_rcu(void)
 {
     qatomic_set(&forced, true);
-    qemu_event_set(&sync_event);
+    qemu_sem_post(&sync_event);
 }
 
 /* Wait for previous parity/grace period to be empty of readers.  */
@@ -148,7 +148,7 @@ static void wait_for_readers(bool sleep)
              */
             qemu_event_reset(&rcu_gp_event);
         } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
-                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
+                   !sleeps || qemu_sem_timedwait(&sync_event, 10)) {
             /*
              * Now one of the following heuristical conditions is satisfied:
              * - A decent number of callbacks piled up.
@@ -286,7 +286,6 @@ static void *call_rcu_thread(void *opaque)
     rcu_register_thread();
 
     for (;;) {
-        bool sleep = true;
         int n;
 
         /*
@@ -294,7 +293,6 @@ static void *call_rcu_thread(void *opaque)
          * added before enter_qs() starts.
          */
         for (;;) {
-            qemu_event_reset(&sync_event);
             n = qatomic_read(&rcu_call_count);
             if (n) {
                 break;
@@ -303,36 +301,19 @@ static void *call_rcu_thread(void *opaque)
 #if defined(CONFIG_MALLOC_TRIM)
             malloc_trim(4 * 1024 * 1024);
 #endif
-            qemu_event_wait(&sync_event);
+            qemu_sem_wait(&sync_event);
         }
 
-        /*
-         * Ensure that an event for a rcu_call_count change will not interrupt
-         * wait_for_readers().
-         */
-        qemu_event_reset(&sync_event);
-
-        /*
-         * Ensure that the forced variable has not been set after fetching
-         * rcu_call_count; otherwise we may get confused by a force quiescent
-         * state request for an element later than n.
-         */
-        while (qatomic_xchg(&forced, false)) {
-            sleep = false;
-            n = qatomic_read(&rcu_call_count);
-        }
-
-        enter_qs(sleep);
+        enter_qs(!qatomic_xchg(&forced, false));
         qatomic_sub(&rcu_call_count, n);
         bql_lock();
         while (n > 0) {
             node = try_dequeue();
             while (!node) {
                 bql_unlock();
-                qemu_event_reset(&sync_event);
                 node = try_dequeue();
                 if (!node) {
-                    qemu_event_wait(&sync_event);
+                    qemu_sem_wait(&sync_event);
                     node = try_dequeue();
                 }
                 bql_lock();
@@ -352,7 +333,7 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
     enqueue(node);
 
     if (!qatomic_fetch_inc(&rcu_call_count)) {
-        qemu_event_set(&sync_event);
+        qemu_sem_post(&sync_event);
     }
 }
 
@@ -456,8 +437,7 @@ static void rcu_init_complete(void)
 
     qemu_mutex_init(&rcu_registry_lock);
     qemu_event_init(&rcu_gp_event, true);
-
-    qemu_event_init(&sync_event, false);
+    qemu_sem_init(&sync_event, 0);
 
     /* The caller is assumed to have BQL, so the call_rcu thread
      * must have been quiescent even after forking, just recreate it.
-- 
2.50.1
===8<===

When I was having a closer look, I found some other issues, I'll list it
all here.

1. I found that rcu_gp_event was initialized as "true".  I'm not sure
   whether it should be false.  This has nothing to do with your series as
   well, only some observation of mine.
   
    qemu_event_init(&rcu_gp_event, true);

2. It looks to me your patch here checked the wrong retval of
   qemu_event_timedwait()..

        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   should it be "!qemu_event_timedwait(&sync_event, 10)"?  Side note: maybe
   we should cleanup all _timedwait() for QEMU's eventfd, sem, cond,
   ... because they don't return the same retval.. but if you think sem is
   good, then we don't need eventfd's timedwait() in this series (your
   initial two patches).

3. I doubt if malloc_trim() feature is broken with your current patchset,
   because now the loop looks like:

        for (;;) {
            qemu_event_reset(&sync_event);
            n = qatomic_read(&rcu_call_count);
            if (n) {
                break;
            }
#if defined(CONFIG_MALLOC_TRIM)
            malloc_trim(4 * 1024 * 1024);
#endif
            qemu_event_wait(&sync_event);
        }

  I don't know if n can be zero here at all.. if you use the sem change
  this might trigger but it's not designed for it.  When using sem we may
  want to periodically trim.  But I'd like to know how you think in general
  on the sem idea first (e.g. do we need to be prepared for high freq rcu
  frees).

Thanks,

-- 
Peter Xu


