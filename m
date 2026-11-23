Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ns9ieU6V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVTV-0007NQ-RJ; Mon, 23 Nov 2026 09:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVVTM-0007Le-B9
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:56:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xVVTI-0006xp-2p
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 09:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795445803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sb1LcfLQAIg1YmxXI+7Oe3nrNWXnU+Fz8Ms7Q8HprxQ=;
 b=Ns9ieU6Vx+MAs/HfeWcRXZloBnxYUGnbiF2c+P1ULjISm+ntQt/zWMKFaBs47ll7MnBlF6
 Dn01X0zgOAdE0nup1kYUYQuQ+XivHlCcUw2YTnUFPmXOl86G7evGCAQWlo/Xv5FLzwbUdr
 ToJh7M07Xsnbl3fqnQzHqMT7JZq9GOk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-yzK756S3P0OyOaw_gNcyzA-1; Mon,
 23 Nov 2026 14:56:36 +0000
X-MC-Unique: yzK756S3P0OyOaw_gNcyzA-1
X-Mimecast-MFC-AGG-ID: yzK756S3P0OyOaw_gNcyzA_1795445792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E97F1954124; Mon, 23 Nov 2026 14:56:29 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B3CF030000E3; Mon, 23 Nov 2026 14:56:27 +0000 (UTC)
Date: Mon, 23 Nov 2026 09:56:26 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org
Subject: Re: [PATCH] fdmon-io_uring: avoid idle event loop being accounted as
 IO wait
Message-ID: <20261123145626.GA1551726@shajnocz.csb>
References: <20261119150839.439544-1-f.ebner@proxmox.com>
 <20261120163624.GC780462@shajnocz.csb>
 <b9538c3e-6d50-42cb-b2e9-770cdb9768fc@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9538c3e-6d50-42cb-b2e9-770cdb9768fc@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 01:20:04PM +0100, Fiona Ebner wrote:
> Hi Stefan,
> 
> Am 20.11.26 um 5:36 PM schrieb Stefan Hajnoczi:
> > On Thu, Nov 19, 2026 at 04:08:08PM +0100, Fiona Ebner wrote:
> >> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
> >> index e65e90093a..17bc145eb6 100644
> >> --- a/include/qemu/aio.h
> >> +++ b/include/qemu/aio.h
> >> @@ -55,6 +55,12 @@ struct CqeHandler {
> >>  
> >>      /* This field is filled in before ->cb() is called */
> >>      struct io_uring_cqe cqe;
> >> +
> >> +    /*
> >> +     * Whether the in-flight request should count towards IO wait.
> >> +     * Set by the fdmon layer; callers must not touch it.
> > 
> > "callers must not touch it"
> > 
> > This is a struct field and there are no callers since it's not a
> > function. Is the intent that this field is private to the fdmon
> > implementation and nothing outside should access this field?
> 
> Yes, that is the intent. Should I change it to
> "Private to the fdmon layer; must not be touched outside of it."
> or do you prefer something else?

Yes, please. That is clearer.

> 
> >> @@ -422,9 +440,25 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
> >>       * 1. If no SQEs were submitted, then -EINTR is returned.
> >>       * 2. If SQEs were submitted then the number of SQEs submitted is returned
> >>       *    rather than -EINTR.
> >> +     *
> >> +     * Submit and wait are split into separate calls so we can pass
> >> +     * IORING_ENTER_NO_IOWAIT when no request that should count against IO
> >> +     * wait is in flight.
> >>       */
> >>      do {
> >> -        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> >> +        ret = io_uring_submit(&ctx->fdmon_io_uring);
> >> +
> >> +        if (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)) {
> >> +            unsigned flags = IORING_ENTER_GETEVENTS;
> >> +
> >> +            if ((ctx->fdmon_io_uring.features & IORING_FEAT_NO_IOWAIT) &&
> >> +                qatomic_read(&ctx->iowait_accounting_reqs) == 0) {
> >> +                flags |= IORING_ENTER_NO_IOWAIT;
> >> +            }
> >> +
> >> +            ret = io_uring_enter(ctx->fdmon_io_uring.ring_fd, 0, wait_nr,
> >> +                                 flags, NULL);
> >> +        }
> > 
> > Can you use io_uring_set_iowait() instead of splitting
> > io_uring_submit_and_wait() so that all liburing APIs automatically
> > set/clear the flag when calling io_uring_enter(2)?
> > 
> > Perhaps that will also reduce the remaining iowait that you observed
> > because there are other (indirect) io_uring_enter(2) calls in
> > fdmon-io_uring.c aside from.
> 
> The io_uring_set_iowait() function is available since liburing 2.10, but
> Debian 13, which our management layer is based on, only has liburing
> 2.9. I tried it with a self-compiled liburing 2.10, to see if the other
> callers are the reason for the remaining IO PSI, but it does not seem to
> be the case, see below. Should I still go for the approach with
> io_uring_set_iowait()?

Yes, I think it would be best to go via liburing APIs instead of
io_uring_submit() + io_uring_enter(2):
- We could get the flags wrong since we build them from scratch without
  knowledge of liburing's flags.
- Other liburing APIs that call io_uring_enter(2) internally will not be
  aware of our IOWAIT flag value.
- Performance could be worse when io_uring_submit() + io_uring_enter(2)
  is called instead of doing it in a single io_uring_submit_and_wait()
  call.

For upstream QEMU the io_uring_set_iowait() call could be compiled out
when liburing <2.10. There is no need to fix IOWAIT for older liburing
versions and maybe those hosts won't have a new enough kernel anyway. In
other words, something like:

#ifndef HAVE_IO_URING_SET_IOWAIT
static inline int io_uring_set_iowait(struct io_uring *ring, bool enable_iowait)
{
    /*
     * Stub out this liburing 2.10 API on older hosts and accept that
     * IOWAIT accounting includes POLL_ADD and TIMEOUT ops. Build
     * against a newer liburing and a newer Linux kernel if you want to
     * fix IOWAIT accounting.
     */
    return 0;
}
#endif

> 
> I added:
> 
> io_uring_set_iowait(&ctx->fdmon_io_uring,
>                     qatomic_read(&ctx->iowait_accounting_reqs) != 0);
> CALL()
> io_uring_set_iowait(&ctx->fdmon_io_uring, false);

Is there a reason to clear the flag afterwards? It's cheap to do, so
it's not a big deal, but I was curious if you thought of a case where
this is necessary for correctness.

Thanks,
Stefan


