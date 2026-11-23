Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8D606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVT1s-0004h9-Pi; Mon, 23 Nov 2026 07:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVT1o-0004gX-C8; Mon, 23 Nov 2026 07:20:12 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVT1m-0007lU-05; Mon, 23 Nov 2026 07:20:12 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1475C42E24;
 Mon, 23 Nov 2026 13:20:06 +0100 (CET)
Message-ID: <b9538c3e-6d50-42cb-b2e9-770cdb9768fc@proxmox.com>
Date: Mon, 23 Nov 2026 13:20:04 +0100
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
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20261120163624.GC780462@shajnocz.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795436405157
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

Hi Stefan,

Am 20.11.26 um 5:36 PM schrieb Stefan Hajnoczi:
> On Thu, Nov 19, 2026 at 04:08:08PM +0100, Fiona Ebner wrote:
>> diff --git a/include/qemu/aio.h b/include/qemu/aio.h
>> index e65e90093a..17bc145eb6 100644
>> --- a/include/qemu/aio.h
>> +++ b/include/qemu/aio.h
>> @@ -55,6 +55,12 @@ struct CqeHandler {
>>  
>>      /* This field is filled in before ->cb() is called */
>>      struct io_uring_cqe cqe;
>> +
>> +    /*
>> +     * Whether the in-flight request should count towards IO wait.
>> +     * Set by the fdmon layer; callers must not touch it.
> 
> "callers must not touch it"
> 
> This is a struct field and there are no callers since it's not a
> function. Is the intent that this field is private to the fdmon
> implementation and nothing outside should access this field?

Yes, that is the intent. Should I change it to
"Private to the fdmon layer; must not be touched outside of it."
or do you prefer something else?

>> @@ -422,9 +440,25 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioHandlerList *ready_list,
>>       * 1. If no SQEs were submitted, then -EINTR is returned.
>>       * 2. If SQEs were submitted then the number of SQEs submitted is returned
>>       *    rather than -EINTR.
>> +     *
>> +     * Submit and wait are split into separate calls so we can pass
>> +     * IORING_ENTER_NO_IOWAIT when no request that should count against IO
>> +     * wait is in flight.
>>       */
>>      do {
>> -        ret = io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
>> +        ret = io_uring_submit(&ctx->fdmon_io_uring);
>> +
>> +        if (ret >= 0 && wait_nr > io_uring_cq_ready(&ctx->fdmon_io_uring)) {
>> +            unsigned flags = IORING_ENTER_GETEVENTS;
>> +
>> +            if ((ctx->fdmon_io_uring.features & IORING_FEAT_NO_IOWAIT) &&
>> +                qatomic_read(&ctx->iowait_accounting_reqs) == 0) {
>> +                flags |= IORING_ENTER_NO_IOWAIT;
>> +            }
>> +
>> +            ret = io_uring_enter(ctx->fdmon_io_uring.ring_fd, 0, wait_nr,
>> +                                 flags, NULL);
>> +        }
> 
> Can you use io_uring_set_iowait() instead of splitting
> io_uring_submit_and_wait() so that all liburing APIs automatically
> set/clear the flag when calling io_uring_enter(2)?
> 
> Perhaps that will also reduce the remaining iowait that you observed
> because there are other (indirect) io_uring_enter(2) calls in
> fdmon-io_uring.c aside from.

The io_uring_set_iowait() function is available since liburing 2.10, but
Debian 13, which our management layer is based on, only has liburing
2.9. I tried it with a self-compiled liburing 2.10, to see if the other
callers are the reason for the remaining IO PSI, but it does not seem to
be the case, see below. Should I still go for the approach with
io_uring_set_iowait()?

I added:

io_uring_set_iowait(&ctx->fdmon_io_uring,
                    qatomic_read(&ctx->iowait_accounting_reqs) != 0);
CALL()
io_uring_set_iowait(&ctx->fdmon_io_uring, false);

to the four relevant calls:

1. io_uring_submit() in get_sqe()
2. io_uring_get_events() in process_cq_ring()
3. io_uring_submit() in fdmon_io_uring_gsource_prepare()
   This one I split into a do {} while loop to be able to surround the
   single call.
4. io_uring_submit_and_wait() in fdmon_io_uring_wait()

Also also tried it when only surrounding the io_uring_submit_and_wait()
call.

In the guest I ran

fio --name=make-mirror-work --size=4096k --direct=1 --rw=randwrite \
--bs=4k --ioengine=psync --numjobs=4 --runtime=60 --time_based

and then checked the total of the 'some' metric of the IO PSI after it
finished:

this patch:

total=5472173
total=6375811
total=6361853

set_iowait for submit_and_wait only:

total=6103261
total=6156911
total=6806779

set_iowait for all four calls:

total=7284803
total=6896655
total=6489701

So, at least with this pattern, it's not a huge difference between the
different approaches.

Best Regards,
Fiona


