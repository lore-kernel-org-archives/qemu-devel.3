Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF5606A68B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnNX-0005rq-K8; Tue, 24 Nov 2026 05:03:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVnNU-0005pS-AS; Tue, 24 Nov 2026 05:03:56 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVnNS-0005Mg-8z; Tue, 24 Nov 2026 05:03:56 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 433E342297;
 Tue, 24 Nov 2026 11:03:43 +0100 (CET)
Message-ID: <1988f5a1-49ec-4d70-90d1-df78da629d15@proxmox.com>
Date: Tue, 24 Nov 2026 11:03:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdmon-io_uring: avoid idle event loop being accounted as
 IO wait
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 jmaguire2013@gmail.com, axboe@kernel.dk, kwolf@redhat.com,
 hreitz@redhat.com, t.lamprecht@proxmox.com, qemu-stable@nongnu.org,
 casasfernando@outlook.com, ncopa@alpinelinux.org
References: <20261119150839.439544-1-f.ebner@proxmox.com>
 <20261120163624.GC780462@shajnocz.csb>
 <b9538c3e-6d50-42cb-b2e9-770cdb9768fc@proxmox.com>
 <20261123145626.GA1551726@shajnocz.csb>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20261123145626.GA1551726@shajnocz.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795514622238
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 23.11.26 um 3:56 PM schrieb Stefan Hajnoczi:
> On Mon, Nov 23, 2026 at 01:20:04PM +0100, Fiona Ebner wrote:
>>>> @@ -422,9 +440,25 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
>>>>       * 1. If no SQEs were submitted, then -EINTR is returned.
>>>>       * 2. If SQEs were submitted then the number of SQEs submitted is returned
>>>>       *    rather than -EINTR.
>>>> +     *
>>>> +     * Submit and wait are split into separate calls so we can pass
>>>> +     * IORING_ENTER_NO_IOWAIT when no request that should count against IO
>>>> +     * wait is in flight.
>>>>       */
>>>>      do {
>>>> -        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
>>>> +        ret = io_uring_submit(&ctx->fdmon_io_uring);
>>>> +
>>>> +        if (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)) {
>>>> +            unsigned flags = IORING_ENTER_GETEVENTS;
>>>> +
>>>> +            if ((ctx->fdmon_io_uring.features & IORING_FEAT_NO_IOWAIT) &&
>>>> +                qatomic_read(&ctx->iowait_accounting_reqs) == 0) {
>>>> +                flags |= IORING_ENTER_NO_IOWAIT;
>>>> +            }
>>>> +
>>>> +            ret = io_uring_enter(ctx->fdmon_io_uring.ring_fd, 0, wait_nr,
>>>> +                                 flags, NULL);
>>>> +        }
>>>
>>> Can you use io_uring_set_iowait() instead of splitting
>>> io_uring_submit_and_wait() so that all liburing APIs automatically
>>> set/clear the flag when calling io_uring_enter(2)?
>>>
>>> Perhaps that will also reduce the remaining iowait that you observed
>>> because there are other (indirect) io_uring_enter(2) calls in
>>> fdmon-io_uring.c aside from.
>>
>> The io_uring_set_iowait() function is available since liburing 2.10, but
>> Debian 13, which our management layer is based on, only has liburing
>> 2.9. I tried it with a self-compiled liburing 2.10, to see if the other
>> callers are the reason for the remaining IO PSI, but it does not seem to
>> be the case, see below. Should I still go for the approach with
>> io_uring_set_iowait()?
> 
> Yes, I think it would be best to go via liburing APIs instead of
> io_uring_submit() + io_uring_enter(2):
> - We could get the flags wrong since we build them from scratch without
>   knowledge of liburing's flags.
> - Other liburing APIs that call io_uring_enter(2) internally will not be
>   aware of our IOWAIT flag value.
> - Performance could be worse when io_uring_submit() + io_uring_enter(2)
>   is called instead of doing it in a single io_uring_submit_and_wait()
>   call.
> 
> For upstream QEMU the io_uring_set_iowait() call could be compiled out
> when liburing <2.10. There is no need to fix IOWAIT for older liburing
> versions and maybe those hosts won't have a new enough kernel anyway. In
> other words, something like:
> 
> #ifndef HAVE_IO_URING_SET_IOWAIT
> static inline int io_uring_set_iowait(struct io_uring *ring, bool enable_iowait)
> {
>     /*
>      * Stub out this liburing 2.10 API on older hosts and accept that
>      * IOWAIT accounting includes POLL_ADD and TIMEOUT ops. Build
>      * against a newer liburing and a newer Linux kernel if you want to
>      * fix IOWAIT accounting.
>      */
>     return 0;
> }
> #endif

Ack, will do that.

>>
>> I added:
>>
>> io_uring_set_iowait(&ctx->fdmon_io_uring,
>>                     qatomic_read(&ctx->iowait_accounting_reqs) != 0);
>> CALL()
>> io_uring_set_iowait(&ctx->fdmon_io_uring, false);
> 
> Is there a reason to clear the flag afterwards? It's cheap to do, so
> it's not a big deal, but I was curious if you thought of a case where
> this is necessary for correctness.
No, if we cover all entry points for io_uring_enter(), it should not be
necessary. If we miss one, we should fix that anyways, so I'll just
leave it out.

Best Regards,
Fiona


