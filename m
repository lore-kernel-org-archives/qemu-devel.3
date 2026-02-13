Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A387EDF17C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvex-0000n3-3V; Fri, 13 Feb 2026 11:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqveu-0000m4-AP
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vqves-0003yT-NC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770998681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0F5O5OwCVjT3jCHBwLprBwZ/F0o/ChVCcim7L8oUkcs=;
 b=AMMsw6/9UeOplp1Pog6RzwlyNh0rIlMHkAk0CxBZJIFb2lilxxl+aPSQEoeAp/qKzYbzbK
 s7+tzsOozgkMCzn4zSWanwDYssJuHVphhNIe1rh9U12gdq28HensgcXlcXlsKCqJjJ8+Us
 DYjWnVlDra3MRkRDyEgDIn5CiZjQvbw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-LE-EWCOuMsCjZyQuUtXG1w-1; Fri,
 13 Feb 2026 11:04:38 -0500
X-MC-Unique: LE-EWCOuMsCjZyQuUtXG1w-1
X-Mimecast-MFC-AGG-ID: LE-EWCOuMsCjZyQuUtXG1w_1770998677
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A8911800366; Fri, 13 Feb 2026 16:04:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.253])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E48E319560B9; Fri, 13 Feb 2026 16:04:33 +0000 (UTC)
Date: Fri, 13 Feb 2026 17:04:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, fam@euphon.net,
 stefanha@redhat.com, f.ebner@proxmox.com
Subject: Re: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
Message-ID: <aY9Lj1BTVRCFyfic@redhat.com>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213143225.161043-2-axboe@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
> When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
> block I/O coroutine inline on the vCPU thread because
> qemu_get_current_aio_context() returns the main AioContext when BQL is
> held. The coroutine calls luring_co_submit() which queues an SQE via
> fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
> in gsource_prepare() on the main loop thread.

Ouch! Yes, looks like we completely missed I/O submitted in vCPU threads
in the recent changes (or I guess worker threads in theory, but I don't
think there any that actually make use of aio_add_sqe()).

> Since the coroutine ran inline (not via aio_co_schedule()), no BH is
> scheduled and aio_notify() is never called. The main loop remains asleep
> in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted until
> the next timer fires.
> 
> Fix this by calling aio_notify() after queuing the SQE. This wakes the
> main loop via the eventfd so it can run gsource_prepare() and submit the
> pending SQE promptly.
> 
> This is a generic fix that benefits all devices using aio=io_uring.
> Without it, AHCI/SATA devices see MUCH worse I/O latency since they use
> MMIO (not ioeventfd like virtio) and have no other mechanism to wake the
> main loop after queuing block I/O.
> 
> This is usually a bit hard to detect, as it also relies on the ppoll
> loop not waking up for other activity, and micro benchmarks tend not to
> see it because they don't have any real processing time. With a
> synthetic test case that has a few usleep() to simulate processing of
> read data, it's very noticeable. The below example reads 128MB with
> O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay before
> each batch submit, and a 1ms delay after processing each completion.
> Running it on /dev/sda yields:
> 
> time sudo ./iotest /dev/sda
> 
> ________________________________________________________
> Executed in   25.76 secs      fish           external
>    usr time    6.19 millis  783.00 micros    5.41 millis
>    sys time   12.43 millis  642.00 micros   11.79 millis
> 
> while on a virtio-blk or NVMe device we get:
> 
> time sudo ./iotest /dev/vdb
> 
> ________________________________________________________
> Executed in    1.25 secs      fish           external
>    usr time    1.40 millis    0.30 millis    1.10 millis
>    sys time   17.61 millis    1.43 millis   16.18 millis
> 
> time sudo ./iotest /dev/nvme0n1
> 
> ________________________________________________________
> Executed in    1.26 secs      fish           external
>    usr time    6.11 millis    0.52 millis    5.59 millis
>    sys time   13.94 millis    1.50 millis   12.43 millis
> 
> where the latter are consistent. If we run the same test but keep the
> socket for the ssh connection active by having activity there, then
> the sda test looks as follows:
> 
> time sudo ./iotest /dev/sda
> 
> ________________________________________________________
> Executed in    1.23 secs      fish           external
>    usr time    2.70 millis   39.00 micros    2.66 millis
>    sys time    4.97 millis  977.00 micros    3.99 millis
> 
> as now the ppoll loop is woken all the time anyway.
> 
> After this fix, on an idle system:
> 
> time sudo ./iotest /dev/sda
> 
> ________________________________________________________
> Executed in    1.30 secs      fish           external
>    usr time    2.14 millis    0.14 millis    2.00 millis
>    sys time   16.93 millis    1.16 millis   15.76 millis
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  util/fdmon-io_uring.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index d0b56127c670..96392876b490 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -181,6 +181,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
>  
>      trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
>                                   cqe_handler);
> +
> +    /*
> +     * Wake the main loop if it is sleeping in ppoll().  When a vCPU thread
> +     * runs a coroutine inline (holding BQL), it queues SQEs here but the
> +     * actual io_uring_submit() only happens in gsource_prepare().  Without
> +     * this notify, ppoll() can sleep up to 499ms before submitting.
> +     */
> +    aio_notify(ctx);
>  }

Makes sense to me.

At first I wondered if we should use defer_call() for the aio_notify()
to batch the submission, but of course holding the BQL will already take
care of that. And in iothreads where there is no BQL, the aio_notify()
shouldn't make a difference anyway because we're already in the right
thread.

I suppose the other variation could be have another io_uring_enter()
call here (but then probably really through defer_call()) to avoid
waiting for another CPU to submit the request in its main loop. But I
don't really have an intuition if that would make things better or worse
in the common case.

Fiona, does this fix your case, too?

Kevin


