Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB91E109B469
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Z51-0005Q2-J9; Tue, 31 Mar 2026 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Z50-0005PU-6G
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7Z4y-0005V2-FJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774963463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7MEtMnISvWBLfWW9UDfuN4obvQ4JSRJg0CWibd49zPY=;
 b=CpSfheUgM6wX9ckHNthLiHTGAS2z8ttxUGetd6sAuwQs88if6jZZIF0NMYPhKw1DYfOZAp
 D8sVKQAv1pPyeDNem7EqpAZuiQ+9Pn8gW3+E6ACDDMatMI0jNoubTep3kKQv5GvT6+7+PD
 PJExB237msPyoOzv3AomDaIVM3lJwuA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-NiynDcslPzq8Z6E7R6rbIA-1; Tue,
 31 Mar 2026 09:24:19 -0400
X-MC-Unique: NiynDcslPzq8Z6E7R6rbIA-1
X-Mimecast-MFC-AGG-ID: NiynDcslPzq8Z6E7R6rbIA_1774963458
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C7D81944F05; Tue, 31 Mar 2026 13:24:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1A0719560AB; Tue, 31 Mar 2026 13:24:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C40921E6A28; Tue, 31 Mar 2026 15:24:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "hongmianquan" <hongmianquan@bytedance.com>
Cc: <qemu-devel@nongnu.org>,  <kwolf@redhat.com>,  <armbru@redhat.com>,
 <michael.roth@amd.com>,  <wubo.bob@bytedance.com>
Subject: Re: [PATCH v2] monitor: Fix deadlock in monitor_cleanup
In-Reply-To: <20260327131024.51947-1-hongmianquan@bytedance.com>
 (hongmianquan@bytedance.com's message of "Fri, 27 Mar 2026 21:10:24
 +0800")
References: <20260327131024.51947-1-hongmianquan@bytedance.com>
Date: Tue, 31 Mar 2026 15:24:15 +0200
Message-ID: <875x6ci134.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"hongmianquan" <hongmianquan@bytedance.com> writes:

> During qemu_cleanup, if a non-coroutine QMP command (e.g., query-commands) is concurrently
> received and processed by the mon_iothread, it can lead to a deadlock in monitor_cleanup.
>
> The root cause is a race condition between the main thread's shutdown sequence and the coroutine's dispatching mechanism. When handling a non-coroutine QMP command, qmp_dispatcher_co schedules the actual command execution as a bottom half in iohandler_ctx and then yields. At this suspended point, qmp_dispatcher_co_busy remains true.
> Subsequently, the main thread in monitor_cleanup(), sets qmp_dispatcher_co_shutdown, and calls qmp_dispatcher_co_wake(). Since qmp_dispatcher_co_busy is already true, the aio_co_wake is skipped. The main thread then enters the AIO_WAIT_WHILE_UNLOCKED loop, it executes the scheduled BH (do_qmp_dispatch_bh) via aio_poll(iohandler_ctx, false), which attempts to wake up the coroutine, aio_co_wake schedules a new wake-up BH in iohandler_ctx. The main thread then blocks indefinitely in aio_poll(qemu_aio_context, true), while the coroutine's wake-up BH is starved in iohandler_ctx, qmp_dispatcher_co never reaches termination, resulting in a deadlock.
>
> The execution sequence is illustrated below:
>
>  IO Thread                 Main Thread (qemu_aio_context)        qmp_dispatcher_co (iohandler_ctx)
>     |                                 |                                        |
>     |-- query-commands                |                                        |
>     |-- qmp_dispatcher_co_wake()      |                                        |
>     |    (sets busy = true)           |                                        |
>     |                                 |   <-- Wakes up in iohandler_ctx -->    |
>     |                                 |                                        |-- qmp_dispatch()
>     |                                 |                                        |-- Schedules BH (do_qmp_dispatch_bh)
>     |                                 |                                        |-- qemu_coroutine_yield()
>     |                                 |                                            [State: Suspended, busy=true]
>     |   [ quit triggered ]            |
>     |                                 |-- monitor_cleanup()
>     |                                 |-- qmp_dispatcher_co_shutdown = true
>     |                                 |-- qmp_dispatcher_co_wake()
>     |                                 |    -> Checks busy flag. It's TRUE!
>     |                                 |    -> Skips aio_co_wake().
>     |                                 |
>     |                                 |-- AIO_WAIT_WHILE_UNLOCKED:
>     |                                 |   |-- aio_poll(iohandler_ctx, false)
>     |                                 |   |    -> Executes do_qmp_dispatch_bh
>     |                                 |   |    -> Schedules 'co_schedule_bh' in iohandler_ctx
>     |                                 |   |
>     |                                 |   |-- aio_poll(qemu_aio_context, true)
>     |                                 |   |    -> Blocks indefinitely! (Deadlock)
>     |                                 |
>     |                                 X (Main thread sleeping)                 X (Waiting for next iohandler_ctx poll)
>
> To fix this, we add an explicit aio_wait_kick() in do_qmp_dispatch_bh() to break the main loop out of its blocking poll, allowing it to evaluate the loop condition and poll iohandler_ctx.
>
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> Signed-off-by: wubo.bob <wubo.bob@bytedance.com>

Please line-wrap your paragraphs at 70 columns or so.  The maintainer
accepting the patch may do that for you, to save you a respin.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>


