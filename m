Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED1CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 12:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNs8F-0007Ur-Lj; Fri, 15 May 2026 08:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNs8D-0007UH-Pu
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wNs8C-0001GV-9X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 08:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778849947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1pay4S0OxEwwkS6/BOqhr5FsTQ1kyyjq11BZJ5/0oaE=;
 b=fu1dYcp0ho0sZEDYbt9uXXVGbFwSgo3LWHvb+3W3qO/MczV+aVBtsDuWpYSj8OPfeExlnF
 eqJgYUaM7Uz/4Uent4WCNL2MEM/1XcyB+xDdy3edH5sCCxbUV5WdEfetZYQBnt/pYnNC7K
 5Wgis4ep+me4Vl2KeeG6sHeb7zqwYcM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-8yLJkQnTPZys7qxiePxE6A-1; Fri,
 15 May 2026 08:59:03 -0400
X-MC-Unique: 8yLJkQnTPZys7qxiePxE6A-1
X-Mimecast-MFC-AGG-ID: 8yLJkQnTPZys7qxiePxE6A_1778849943
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A36931800627; Fri, 15 May 2026 12:59:02 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.123])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA57F1800347; Fri, 15 May 2026 12:59:00 +0000 (UTC)
Date: Fri, 15 May 2026 14:58:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH 2/2] block/qcow2: fix hangup in cache_clean_timer
 cancellation
Message-ID: <agcYkmTWud8euTds@redhat.com>
References: <20260424103917.248668-1-den@openvz.org>
 <20260424103917.248668-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424103917.248668-3-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 24.04.2026 um 12:39 hat Denis V. Lunev geschrieben:
> cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
> by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
> to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
> fire-and-forget: it reads w->to_wake and silently returns when it is
> NULL. A sleeper that is between two iterations -- has just released
> s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
> the wake:
> 
>   iothread0 timer coroutine           main thread (qcow2 close)
>   -------------------------           -------------------------
>   while-body (holding s->lock):
>     read interval = 600
>     wait_ns = 600 * NS
>     release s->lock
>                                       take s->lock
>                                       interval = 0
>                                       qemu_co_sleep_wake(w):
>                                         w->to_wake == NULL -> skip
>                                         return
>                                       qemu_co_queue_wait(exit, s->lock):
>                                         release s->lock
>                                         yield
>   qemu_co_sleep_ns_wakeable:
>     aio_timer_init(+600 s)
>     qemu_co_sleep:
>       cas scheduled NULL -> "qsns"
>       w->to_wake = co
>       yield  [sleeps 600 s]
> 
> cache_clean_timer_del_and_wait() is now stuck waiting for
> cache_clean_timer_exit; the timer will not signal it until its
> original 600 s expiry fires. qcow2_close() is on the main thread
> holding BQL, so RCU, VCPUs and every iothread path that needs BQL
> stall behind it.
> 
> qemu_co_sleep_wake() has always been a hint: it has no way to
> rendezvous with a sleeper still arming. Rather than mutate it (which
> would change semantics for every other user -- mirror, stream,
> backup), fix the caller.

Would changing it be a problem for any caller?

I don't see the calls in mirror and stream, but for the backup job it
seems to be two cases: Cancelling the block job and updating the speed.
Cancelling is essentially the exact same case as closing qcow2, so
changing it fixes an unwanted delay. If updating the speed should always
wake up the job is more debatable, but once we've taken the decision
that it should do so, doing that always (even under the race condition)
doesn't seem like a problem either.

I'm asking because the workaround in this patch both makes the qcow2
code more complicated and still doesn't fully solve the problem - you
still get a delay, it's just shortened to what we think is acceptable.
If we fixed the qemu_co_sleep_wake() interface, the wakeup would be
instantaneous and the code in the callers would be simpler. (And I don't
think it would be much worse in the implementation either.)

> Split the sleep in cache_clean_timer() into steps of at most one
> second and move the s->cache_clean_interval check to the top of the
> loop so it is re-evaluated under s->lock between steps. The
> loop/wait structure itself is unchanged. The stop decision is now
> made under the same lock that the teardown caller holds to set
> cache_clean_interval = 0, so it cannot be missed.
> qemu_co_sleep_wake() is still called opportunistically to cut short
> the current step; if it misses, the next 1 s tick catches the change.
> Worst-case cancellation latency is bounded at 1 s, independent of
> cache_clean_interval.
> 
> Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>

Kevin


