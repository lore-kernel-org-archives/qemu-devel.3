Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFDDFD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 20:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvhYV-0002ja-2d; Thu, 26 Feb 2026 15:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvhYU-0002jJ-7W
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:01:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vvhYS-0006xD-AW
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772136106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GqGeDPK19Bl7WK0Aa/ONCOGV6E1iCeYdEmosArI5WD0=;
 b=CQTj6/CqtxqxjmgSCmOs+zLlJoFBshch7Gf7P+ZRJ1NnCQBEC9ngS8xMCxGWz6JthA8CfA
 HEtnfKq06iJWyYZa/yJUJifvxszic0Pmj7A27avGFyAvZ35bMp1W3obOM4pzOG6d6dDmzD
 5ok8+HEZxRTR9+cOk1rjcEvfGKlxXyI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-iK9w63ndNV68CztqsuLsVQ-1; Thu,
 26 Feb 2026 15:01:43 -0500
X-MC-Unique: iK9w63ndNV68CztqsuLsVQ-1
X-Mimecast-MFC-AGG-ID: iK9w63ndNV68CztqsuLsVQ_1772136102
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68DDD1955F28; Thu, 26 Feb 2026 20:01:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.49])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24ED430001BF; Thu, 26 Feb 2026 20:01:32 +0000 (UTC)
Date: Thu, 26 Feb 2026 21:01:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Dmitry Guryanov <dmitry.guryanov@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>
Subject: Re: [PATCH resend] block/throttle-groups: fix deadlock with iolimits
 and muliple iothreads
Message-ID: <aaCmmgtIlDQMaj8V@redhat.com>
References: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
 <5011ccf5-7af5-4f88-8261-35514c72bc84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5011ccf5-7af5-4f88-8261-35514c72bc84@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 26.02.2026 um 15:37 hat Hanna Czenczek geschrieben:
> On 08.12.25 09:55, Dmitry Guryanov wrote:
> > Details: https://gitlab.com/qemu-project/qemu/-/issues/3144
> > 
> > The function schedule_next_request is called with tg->lock held and
> > it may call throttle_group_co_restart_queue, which takes
> > tgm->throttled_reqs_lock, qemu_co_mutex_lock may leave current
> > coroutine if other iothread has taken the lock. If the next
> > coroutine will call throttle_group_co_io_limits_intercept - it
> > will try to take the mutex tg->lock which will never be released.
> > 
> > Here is the backtrace of the iothread:
> > Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) "IO iothread2"):
> >   #0  futex_wait (futex_word=0x5611adb7d828, expected=2, private=0) at ../sysdeps/nptl/futex-internal.h:146
> >   #1  __GI___lll_lock_wait (futex=futex@entry=0x5611adb7d828, private=0) at lowlevellock.c:49
> >   #2  0x00007f8ab5a97501 in lll_mutex_lock_optimized (mutex=0x5611adb7d828) at pthread_mutex_lock.c:48
> >   #3  ___pthread_mutex_lock (mutex=0x5611adb7d828) at pthread_mutex_lock.c:93
> >   #4  0x00005611823f5482 in qemu_mutex_lock_impl (mutex=0x5611adb7d828, file=0x56118289daca "../block/throttle-groups.c", line=372) at ../util/qemu-thread-posix.c:94
> >   #5  0x00005611822b0b39 in throttle_group_co_io_limits_intercept (tgm=0x5611af1bb4d8, bytes=4096, direction=THROTTLE_READ) at ../block/throttle-groups.c:372
> >   #6  0x00005611822473b1 in blk_co_do_preadv_part (blk=0x5611af1bb490, offset=15972311040, bytes=4096, qiov=0x7f8aa4000f98, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354
> >   #7  0x0000561182247fa0 in blk_aio_read_entry (opaque=0x7f8aa4005910) at ../block/block-backend.c:1619
> >   #8  0x000056118241952e in coroutine_trampoline (i0=-1543497424, i1=32650) at ../util/coroutine-ucontext.c:175
> >   #9  0x00007f8ab5a56f70 in ?? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from target:/lib64/libc.so.6
> >   #10 0x00007f8aad1ef190 in ?? ()
> >   #11 0x0000000000000000 in ?? ()
> > 
> > The lock is taken in line 386:
> > (gdb) p tg.lock
> > $1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 24240, __nusers = 1, __kind = 0, __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
> >      __size = "\002\000\000\000\000\000\000\000\260^\000\000\001", '\000' <repeats 26 times>, __align = 2}, file = 0x56118289daca "../block/throttle-groups.c",
> >    line = 386, initialized = true}
> > 
> > The solution is to use tg->lock to protect both ThreadGroup fields and
> > ThrottleGroupMember.throttled_reqs. It doesn't seem to be possible
> > to use separate locks because we need to first manipulate ThrottleGroup
> > fields, then schedule next coroutine using throttled_reqs and after than
> > update token field from ThrottleGroup depending on the throttled_reqs
> > state.
> > 
> > Signed-off-by: Dmitry Guryanov <dmitry.guryanov@gmail.com>
> > ---
> >   block/throttle-groups.c         | 21 ++++++---------------
> >   include/block/throttle-groups.h |  1 -
> >   2 files changed, 6 insertions(+), 16 deletions(-)
> > 
> > diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> > index 66fdce9a90..bb01e52516 100644
> > --- a/block/throttle-groups.c
> > +++ b/block/throttle-groups.c
> > @@ -295,19 +295,15 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
> >   /* Start the next pending I/O request for a ThrottleGroupMember. Return whether
> >    * any request was actually pending.
> >    *
> > + * This assumes that tg->lock is held.
> > + *
> >    * @tgm:       the current ThrottleGroupMember
> >    * @direction: the ThrottleDirection
> >    */
> >   static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
> >                                                            ThrottleDirection direction)
> >   {
> > -    bool ret;
> > -
> > -    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
> > -    ret = qemu_co_queue_next(&tgm->throttled_reqs[direction]);
> > -    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
> > -
> > -    return ret;
> > +    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);;
> 
> Double semicolon here, should just be one.
> 
> >   }
> >   /* Look for the next pending I/O request and schedule it.
> 
> [...]
> 
> > diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> > index 2355e8d9de..374c7c0215 100644
> > --- a/include/block/throttle-groups.h
> > +++ b/include/block/throttle-groups.h
> > @@ -36,7 +36,6 @@
> >   typedef struct ThrottleGroupMember {
> >       AioContext   *aio_context;
> >       /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
> 
> This comment should be updated to something like "Protected by
> ThrottleGroup.lock".
> 
> With both of these fixed:
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

Thanks, I applied the series based on your review and made the changes
you suggested.

Kevin


