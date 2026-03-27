Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC310ED65A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64dD-0002XN-K8; Fri, 27 Mar 2026 06:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w64dC-0002XE-8s
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w64dA-0006ap-JO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774608091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7z+bJmCQvMsrSRnPawAuCqNTtylAFIRQidYbzNcsdME=;
 b=GEZfcVnJGBNrOCw+OyJyqDNZv0Iq3BNI9IDPZawJ0YPEr54TKby4cEedUDtFdx+Ev/6nOf
 yd4R1lIbWtvbtHHMFIQN0zpxNcYFsxKcMVY20eYCSVQfFIO7nEEHfNXkKQNq1dW3S4/WhL
 1wLUlXfokhvbhrN7yWQvwALFQulvA7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-i4CobxYSMVy0pS3Py_f34g-1; Fri,
 27 Mar 2026 06:41:27 -0400
X-MC-Unique: i4CobxYSMVy0pS3Py_f34g-1
X-Mimecast-MFC-AGG-ID: i4CobxYSMVy0pS3Py_f34g_1774608086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D94B1956055; Fri, 27 Mar 2026 10:41:26 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.239])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7231C30001A1; Fri, 27 Mar 2026 10:41:24 +0000 (UTC)
Date: Fri, 27 Mar 2026 11:41:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: hongmainquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, armbru@redhat.com,
 wubo.bob@bytedance.com
Subject: Re: [RFC] monitor: Fix deadlock in monitor_cleanup
Message-ID: <acZe0gC1yvagJbP0@redhat.com>
References: <20260323133744.46493-1-hongmianquan@bytedance.com>
 <acWJ1-aAmegtcOCv@redhat.com>
 <ac3b2678-e184-41b1-9fd3-92371e626ef3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac3b2678-e184-41b1-9fd3-92371e626ef3@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 27.03.2026 um 08:56 hat hongmainquan geschrieben:
> 在 2026/3/27 03:32, Kevin Wolf 写道:
> > Am 23.03.2026 um 14:37 hat hongmianquan geschrieben:
> >> During qemu_cleanup, if a non-coroutine QMP command (e.g.,
> >> query-commands) is concurrently received and processed by the
> >> mon_iothread, it can lead to a deadlock in monitor_cleanup.
> >>
> >> The root cause is a race condition between the main thread's shutdown
> >> sequence and the coroutine's dispatching mechanism. When handling a
> >> non-coroutine QMP command, qmp_dispatcher_co schedules the actual
> >> command execution as a bottom half in iohandler_ctx and then yields.
> >> At this suspended point, qmp_dispatcher_co_busy remains true.
> >> Subsequently, the main thread in monitor_cleanup(), sets
> >> qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since
> >> qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped.
> >> The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it
> >> executes the scheduled BH (do_qmp_dispatch_bh) via
> >> aio_poll(iohandler_ctx, false), which attempts to wake up the
> >> coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx.
> >> The main thread then blocks indefinitely in aio_poll(qemu_aio_context,
> >> true), while the coroutine's wake-up BH is starved in iohandler_ctx,
> >> qmp_dispatcher_co never reaches termination, resulting in a deadlock.
> > 
> > If the real problem is that the aio_poll() in the main thread is never
> > woken up, does this fix the problem? (Completely untested, and would
> > need a comment if we commit it.)
> > 
> After our reproduction tests, this change also resolves the issue and 
> proves to be a more appropriate solution.
> Should we proceed with this commit based on our discussion, or do you 
> require further validation?

If it works for you, let's move forward with this. I think we just
should add a comment like "if we're in AIO_WAIT_WHILE_UNLOCKED() in
monitor_cleanup(), make sure that it doesn't wait for an event in the
main context, but iohandler_ctx is polled" in the real commit because
it's not obvious why the aio_wait_kick() is needed here.

> Thanks,
> > diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> > index 9bb1e6a9f4a..0a0e9e07756 100644
> > --- a/qapi/qmp-dispatch.c
> > +++ b/qapi/qmp-dispatch.c
> > @@ -128,6 +128,7 @@ static void do_qmp_dispatch_bh(void *opaque)
> >       data->cmd->fn(data->args, data->ret, data->errp);
> >       monitor_set_cur(qemu_coroutine_self(), NULL);
> >       aio_co_wake(data->co);
> > +    aio_wait_kick();
> >   }

Do you want to send a v2 patch that takes this approach, or would you
prefer if I send it as a proper patch?

Kevin


