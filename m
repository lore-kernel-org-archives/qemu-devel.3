Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7083DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIw6f-0004rz-At; Tue, 11 Nov 2025 16:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw6W-0004g0-KA
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:40:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw6T-0003Bb-JE
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762897240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FpJVK0UMWK1IVwMwlZwjtYT4XHhRC6C7igQENJxQmXE=;
 b=D1YIYej573HEEiSa87NkdhuShBdqqfuI1aNVUL+893Yqq85S2OJrfMLniQE8NwKGxZk0bS
 nu8+LwY9mheF/uEF3tYl6hhT3truVApKWb1A7uGeI8kAqv+9CJzb8BBzedc0yEgJWbZOgU
 oJ/GKTHlcrS6ls0ut3kRtDb/r4PXNSU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-aPhtfXGCPeiDJHanzChiOw-1; Tue,
 11 Nov 2025 16:40:37 -0500
X-MC-Unique: aPhtfXGCPeiDJHanzChiOw-1
X-Mimecast-MFC-AGG-ID: aPhtfXGCPeiDJHanzChiOw_1762897236
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DF8D1956096; Tue, 11 Nov 2025 21:40:36 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.214])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D39C180049F; Tue, 11 Nov 2025 21:40:35 +0000 (UTC)
Date: Tue, 11 Nov 2025 22:40:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 06/27] aio-posix: integrate fdmon into glib event loop
Message-ID: <aROtUHtR5jE4LV-H@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
 <20251104175415.525388-7-kwolf@redhat.com>
 <4dd86e70-fd42-4a70-9f0f-3944e04bc972@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd86e70-fd42-4a70-9f0f-3944e04bc972@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 05.11.2025 um 16:06 hat Richard Henderson geschrieben:
> On 11/4/25 18:53, Kevin Wolf wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > AioContext's glib integration only supports ppoll(2) file descriptor
> > monitoring. epoll(7) and io_uring(7) disable themselves and switch back
> > to ppoll(2) when the glib event loop is used. The main loop thread
> > cannot use epoll(7) or io_uring(7) because it always uses the glib event
> > loop.
> > 
> > Future QEMU features may require io_uring(7). One example is uring_cmd
> > support in FUSE exports. Each feature could create its own io_uring(7)
> > context and integrate it into the event loop, but this is inefficient
> > due to extra syscalls. It would be more efficient to reuse the
> > AioContext's existing fdmon-io_uring.c io_uring(7) context because
> > fdmon-io_uring.c will already be active on systems where Linux io_uring
> > is available.
> > 
> > In order to keep fdmon-io_uring.c's AioContext operational even when the
> > glib event loop is used, extend FDMonOps with an API similar to
> > GSourceFuncs so that file descriptor monitoring can integrate into the
> > glib event loop.
> > 
> > A quick summary of the GSourceFuncs API:
> > - prepare() is called each event loop iteration before waiting for file
> >    descriptors and timers.
> > - check() is called to determine whether events are ready to be
> >    dispatched after waiting.
> > - dispatch() is called to process events.
> > 
> > More details here: https://docs.gtk.org/glib/struct.SourceFuncs.html
> > 
> > Move the ppoll(2)-specific code from aio-posix.c into fdmon-poll.c and
> > also implement epoll(7)- and io_uring(7)-specific file descriptor
> > monitoring code for glib event loops.
> > 
> > Note that it's still faster to use aio_poll() rather than the glib event
> > loop since glib waits for file descriptor activity with ppoll(2) and
> > does not support adaptive polling. But at least epoll(7) and io_uring(7)
> > now work in glib event loops.
> > 
> > Splitting this into multiple commits without temporarily breaking
> > AioContext proved difficult so this commit makes all the changes. The
> > next commit will remove the aio_context_use_g_source() API because it is
> > no longer needed.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Message-ID: <20251104022933.618123-7-stefanha@redhat.com>
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>

> > diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> > index 3d8638b0e5..0a5ec5ead6 100644
> > --- a/util/fdmon-io_uring.c
> > +++ b/util/fdmon-io_uring.c
> > @@ -262,6 +262,11 @@ static int process_cq_ring(AioContext *ctx, AioHandlerList *ready_list)
> >       unsigned num_ready = 0;
> >       unsigned head;
> > +    /* If the CQ overflowed then fetch CQEs with a syscall */
> > +    if (io_uring_cq_has_overflow(ring)) {
> > +        io_uring_get_events(ring);
> > +    }
> 
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/11984045425#L2379
> 
> 
> ../util/fdmon-io_uring.c: In function 'process_cq_ring':
> ../util/fdmon-io_uring.c:315:9: error: implicit declaration of function
> 'io_uring_cq_has_overflow' [-Werror=implicit-function-declaration]
>   315 |     if (io_uring_cq_has_overflow(ring)) {
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ../util/fdmon-io_uring.c:315:9: error: nested extern declaration of
> 'io_uring_cq_has_overflow' [-Werror=nested-externs]
> ../util/fdmon-io_uring.c:316:9: error: implicit declaration of function
> 'io_uring_get_events'; did you mean 'io_uring_get_sqe'?
> [-Werror=implicit-function-declaration]
>   316 |         io_uring_get_events(ring);
>       |         ^~~~~~~~~~~~~~~~~~~
>       |         io_uring_get_sqe
> ../util/fdmon-io_uring.c:316:9: error: nested extern declaration of
> 'io_uring_get_events' [-Werror=nested-externs]

Thanks, I sent a v2 pull request.

Please reply to all in the future instead of only to qemu-devel. I
missed this reply until today, which due to the hard freeze meant a
somewhat longer working day for me than I had hoped for.

Kevin


