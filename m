Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B10CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQFD-0003XU-W0; Tue, 02 Dec 2025 08:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQQFB-0003TP-D4
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQQF8-0002jr-Tm
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764681393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mEZYo8n3dT7CNPLww9AvfM+n2T0kO2ySVeXEea+fxg=;
 b=aXBt4vPMGIiuflG13Lhc/NzluHOuNlXE5FZQGdttiHMGO+mBHLhfIlUGt7sADfgtnfOYUc
 RgsRblqfJYfvV/0X1I4laf1Bl269mBKJdnZ6S6mA/gn+9YbRZdZCln73Emc92f/ByqzcQ1
 6orOP7K7bhCcN9IgTuTNeZB4VAnsxUU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-20eqBAzjOhKzKklvVYQAeQ-1; Tue,
 02 Dec 2025 08:16:30 -0500
X-MC-Unique: 20eqBAzjOhKzKklvVYQAeQ-1
X-Mimecast-MFC-AGG-ID: 20eqBAzjOhKzKklvVYQAeQ_1764681389
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B47DA1956052; Tue,  2 Dec 2025 13:16:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.249])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8136E1955F24; Tue,  2 Dec 2025 13:16:25 +0000 (UTC)
Date: Tue, 2 Dec 2025 14:16:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: luzhipeng <luzhipeng@cestc.cn>
Cc: qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH resend] block: add single-check guard in
 throttle_group_restart_queue to address race with schedule_next_request
Message-ID: <aS7mpt3GHFkNfWZT@redhat.com>
References: <20251117011045.1232-1-luzhipeng@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117011045.1232-1-luzhipeng@cestc.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 17.11.2025 um 02:10 hat luzhipeng geschrieben:
> A race condition exists between throttle_group_restart_queue() and
> schedule_next_request(): when multiple ThrottleGroupMembers in the same
> throttle group are assigned to different IOThreads, concurrent execution
> can cause schedule_next_request() to re-arm a throttle timer while
> throttle_group_restart_queue() is being called (e.g., from a timer
> callback or external restart). This violates the assumption that no
> timer is pending upon entry to throttle_group_restart_queue(), triggering
> an assertion failure and causing QEMU to abort.
> 
> This patch replaces the assert with a single early-return check:
> if the timer for the given direction is already pending, the function
> returns immediately. This prevents duplicate coroutine scheduling and
> avoids crashes under race conditions, without altering the core
> (non-thread-safe) throttle group logic.
> 
> For details, see: https://gitlab.com/qemu-project/qemu/-/issues/3194
> 
> Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
> ---
>  block/throttle-groups.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 66fdce9a90..9dcc6b4923 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -430,15 +430,14 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
>                                          ThrottleDirection direction)
>  {
>      Coroutine *co;
> +    if (timer_pending(tgm->throttle_timers.timers[direction])) {
> +        return;
> +    }
>      RestartData *rd = g_new0(RestartData, 1);
>  
>      rd->tgm = tgm;
>      rd->direction = direction;
>  
> -    /* This function is called when a timer is fired or when
> -     * throttle_group_restart_tgm() is called. Either way, there can
> -     * be no timer pending on this tgm at this point */
> -    assert(!timer_pending(tgm->throttle_timers.timers[direction]));
>  
>      qatomic_inc(&tgm->restart_pending);

I'm not really familiar with the finer details of this throttling code,
but this doesn't look like a proper fix for a race to me. If it was
possible for a timer to be scheduled between the caller and here, then
it can certainly also be scheduled between your new check and whatever
relies on the condition after it.

If I understand the commit message of 25b8e4db7f3 correctly, the idea is
that you never have a timer pending that wouldn't actually restart a
request. If the timer is rescheduled from a different thread right after
this check, we'll already resume all of the requests now and the timer
will still be pending without actually having any work to do.

So it looks to me like we'll need some extended locking (tg->lock is
already held by callers of throttle_group_schedule_timer(), but only for
a short duration in throttle_group_restart_queue_entry() instead of
during the whole process), or just give up on the invariant, but then we
don't have to return early either.

Berto, any thoughts?

Kevin


