Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7316BCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6sXC-00081l-Bz; Thu, 09 Oct 2025 11:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6sWx-0007vX-Tn
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6sWp-0002bN-Qs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760023558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CB4PuUbH0eXCKY/NZYPj1ZikRRce9S2C+/c0qS163A=;
 b=fBHqIWYmLCyM4YrLX/wn2LTJ7IxbdHJUgMned+qGbS1+Z9k9ZKbZcrnLkVVp+mAgEd2ErC
 bo/1Zhjqe4ONzRd3oozaYezqZbXPTeeED3gJpItm0G1197IJsQSW7a/d8kNdSb7gmzpvOU
 p4KMsVZbNfq80J3FizrhoGi9CbjDJ7I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-nnLjgM_7PsicbA3H1b_HhQ-1; Thu,
 09 Oct 2025 11:25:55 -0400
X-MC-Unique: nnLjgM_7PsicbA3H1b_HhQ-1
X-Mimecast-MFC-AGG-ID: nnLjgM_7PsicbA3H1b_HhQ_1760023554
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEFD419560B0; Thu,  9 Oct 2025 15:25:53 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45B081955F6A; Thu,  9 Oct 2025 15:25:49 +0000 (UTC)
Date: Thu, 9 Oct 2025 17:25:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 04/12] aio-posix: integrate fdmon into glib event loop
Message-ID: <aOfT-zK_3XXM_9_8@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> AioContext's glib integration only supports ppoll(2) file descriptor
> monitoring. epoll(7) and io_uring(7) disable themselves and switch back
> to ppoll(2) when the glib event loop is used. The main loop thread
> cannot use epoll(7) or io_uring(7) because it always uses the glib event
> loop.
> 
> Future QEMU features may require io_uring(7). One example is uring_cmd
> support in FUSE exports. Each feature could create its own io_uring(7)
> context and integrate it into the event loop, but this is inefficient
> due to extra syscalls. It would be more efficient to reuse the
> AioContext's existing fdmon-io_uring.c io_uring(7) context because
> fdmon-io_uring.c will already be active on systems where Linux io_uring
> is available.
> 
> In order to keep fdmon-io_uring.c's AioContext operational even when the
> glib event loop is used, extend FDMonOps with an API similar to
> GSourceFuncs so that file descriptor monitoring can integrate into the
> glib event loop.
> 
> A quick summary of the GSourceFuncs API:
> - prepare() is called each event loop iteration before waiting for file
>   descriptors and timers.
> - check() is called to determine whether events are ready to be
>   dispatched after waiting.
> - dispatch() is called to process events.
> 
> More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html
> 
> Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
> also implement epoll(7)- and io_uring(7)-specific file descriptor
> monitoring code for glib event loops.
> 
> Note that it's still faster to use aio_poll() rather than the glib event
> loop since glib waits for file descriptor activity with ppoll(2) and
> does not support adaptive polling. But at least epoll(7) and io_uring(7)
> now work in glib event loops.
> 
> Splitting this into multiple commits without temporarily breaking
> AioContext proved difficult so this commit makes all the changes. The
> next commit will remove the aio_context_use_g_source() API because it is
> no longer needed.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

It looks to me like we get a lot of duplication between implementations
of .wait and the new .gsource_* callbacks. We can probably clean this up
later. In the meantime, we need to make sure that the implementations
don't diverge.

>  include/block/aio.h   | 36 ++++++++++++++++++
>  util/aio-posix.h      |  5 +++
>  tests/unit/test-aio.c |  7 +++-
>  util/aio-posix.c      | 69 ++++++++-------------------------
>  util/fdmon-epoll.c    | 52 ++++++++++++++++++++++---
>  util/fdmon-io_uring.c | 44 +++++++++++++++++++++-
>  util/fdmon-poll.c     | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  7 files changed, 239 insertions(+), 62 deletions(-)

> +static void fdmon_epoll_gsource_dispatch(AioContext *ctx,
> +                                         AioHandlerList *ready_list)
> +{
> +    AioHandler *node;
> +    int ret;
> +    struct epoll_event events[128];
> +
> +    /* Collect events and process them */
> +    ret = epoll_wait(ctx->epollfd, events, ARRAY_SIZE(events), 0);
> +    if (ret <= 0) {
> +        return;
> +    }
> +    for (int i = 0; i < ret; i++) {
> +        int ev = events[i].events;
> +        int revents = (ev & EPOLLIN ? G_IO_IN : 0) |
> +                      (ev & EPOLLOUT ? G_IO_OUT : 0) |
> +                      (ev & EPOLLHUP ? G_IO_HUP : 0) |
> +                      (ev & EPOLLERR ? G_IO_ERR : 0);
> +
> +        node = events[i].data.ptr;
> +        aio_add_ready_handler(ready_list, node, revents);
> +    }
> +}

Isn't this just fdmon_epoll_wait(ctx, ready_list, 0)?

> @@ -97,11 +102,92 @@ static void fdmon_poll_update(AioContext *ctx,
>                                AioHandler *old_node,
>                                AioHandler *new_node)
>  {
> -    /* Do nothing, AioHandler already contains the state we'll need */
> +    if (old_node && !new_node) {
> +        /*
> +         * If the GSource is in the process of being destroyed then
> +         * g_source_remove_poll() causes an assertion failure.  Skip removal in
> +         * that case, because glib cleans up its state during destruction
> +         * anyway.
> +         */
> +        if (!g_source_is_destroyed(&ctx->source)) {
> +            g_source_remove_poll(&ctx->source, &old_node->pfd);
> +        }
> +    }
> +
> +    if (!old_node && new_node) {
> +        g_source_add_poll(&ctx->source, &new_node->pfd);
> +    }
> +}

I think this changes the behaviour for the case where we update a node,
i.e. old_node and new_node are both non-NULL. Previously we added the
new node and removed the old one, now you're skipping this.

Both are referring to the same file descriptor, but we're not passing
an integer here but a pointer to a heap-allocated GPollFD (which is
contined in the AioHandler). The next thing that happens in the caller
is that we free old_node.

Doesn't this cause use after free?

> +static void fdmon_poll_gsource_prepare(AioContext *ctx)
> +{
> +    /* Do nothing */
> +}
> +
> +static bool fdmon_poll_gsource_check(AioContext *ctx)
> +{
> +    AioHandler *node;
> +    bool result = false;
> +
> +    /*
> +     * We have to walk very carefully in case aio_set_fd_handler is
> +     * called while we're walking.
> +     */
> +    qemu_lockcnt_inc(&ctx->list_lock);
> +
> +    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> +        int revents = node->pfd.revents & node->pfd.events;
> +
> +        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read) {
> +            result = true;
> +            break;
> +        }
> +        if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
> +            result = true;
> +            break;
> +        }
> +    }
> +
> +    qemu_lockcnt_dec(&ctx->list_lock);
> +
> +    return result;
> +}
> +
> +static void fdmon_poll_gsource_dispatch(AioContext *ctx,
> +                                        AioHandlerList *ready_list)
> +{
> +    AioHandler *node;
> +
> +    QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
> +        int revents;
> +
> +        revents = node->pfd.revents & node->pfd.events;
> +        if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR) && node->io_read) {
> +            aio_add_ready_handler(ready_list, node, revents);
> +        } else if (revents & (G_IO_OUT | G_IO_ERR) && node->io_write) {
> +            aio_add_ready_handler(ready_list, node, revents);
> +        }

Why do we need these checks? Don't we already know that if an event is
in node->pfd.events, there is a matching io_read/io_write callback, too?
This is how aio_set_fd_handler() decides which events to monitor.

If we do need them, why doesn't fdmon_poll_wait()?

> +    }
>  }
>  
>  const FDMonOps fdmon_poll_ops = {
>      .update = fdmon_poll_update,
>      .wait = fdmon_poll_wait,
>      .need_wait = aio_poll_disabled,
> +    .gsource_prepare = fdmon_poll_gsource_prepare,
> +    .gsource_check = fdmon_poll_gsource_check,
> +    .gsource_dispatch = fdmon_poll_gsource_dispatch,
>  };

Kevin


