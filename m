Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7949E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vskHH-0000Nx-Sv; Wed, 18 Feb 2026 11:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vskH8-0000I6-5b
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:19:42 -0500
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vskH5-0005YZ-IQ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:19:41 -0500
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8cb3a8494c5so487798385a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771431567; x=1772036367;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qY1e9tdVMtgaq/2zP7f9Q8Qnw5Q3quaqtHRpNjjYfvo=;
 b=BtZtWoTJiVBtjvLMbOqkGJqqn7sfeMOn8632Yxcaw8dRW0SaxC2pH5/tV1hBH6jl/7
 u3tXn3wE7RrcNjAkLAyXNvqr+BF1XgoOP0cBhS+zqc8CbzNhoIpkdqGuMamyr9kR+wA4
 HlJF5hA62heSobGBOIN2NnhFv9H8fi6AMWx0Xu5GioozO5nvKvyL1W5DZVDLLdicIufM
 coN6kituS84w6ITVPljwuA+hoGjNgkaWrS2qc2u90JfTjo4/8XHCVR8u2v/lYU7cIFZm
 ARYFarGxz4ru2uByzRF57YPKxNlqh3joIjdgvpjQDj7KWYIRcQMjAk+37IJ9k39PhqvL
 eP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771431567; x=1772036367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qY1e9tdVMtgaq/2zP7f9Q8Qnw5Q3quaqtHRpNjjYfvo=;
 b=lEWvT58jOz1VCOeu22911aAOy2k2YwsFEV48d59ZJ3IovyEuuAAKklvWrmU1fR7Yby
 T2N8mSP//M88I4J7ECUoHAnaDZ97kr+P9LD6nBUku6POuJh+0B0LqZdfcpROLxnMrTYy
 hdTNbiMtXLCaSeI/UcwXhV/mhh2qZCavAXlZ7rUQNm2MBxsFYx6uzNwSAagAcQ2CHkj3
 hfKkRWUaqqfkg361Eby0iSjVGhkk90hcfbvgshthLlJl3tHP4ZUozmxQNcKutx+1+plb
 D/pMUxrbil9M/PqLFWn9gxjXkQRhM6LrZj1PNjXhtIFs85k0lxawXO/s8Ounu5jDa/0O
 5bpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmNgKDhS4r9Ja7vIhpxM04VFZXvLCzuh4L4uu9YXMumsx/A14hlfZMVduDdoWRzm0wUonC40F2eQIo@nongnu.org
X-Gm-Message-State: AOJu0Yw42t+23J/c/pUedEU6w3TrY8uHqkpqW8OkEXaGcA0pC77UZlmp
 x+gcmp2sabj/B+wFDinjH3VpzPZUcggzQqh5NFOMDaJFDZlwsbS9efF/wuhM7RfOVz8=
X-Gm-Gg: AZuq6aKRIKg8TEaeGzuzzu2hH5EzNOBgJkEEJe/bSRPZJaUSnyP69/ZzxFkCO0t+uEo
 jDzhirbbmZDwNnYEorztXywnhf3JB/MpQLcb79leVCi7VThwnSlAmrXARVj0nj2AKmxtjKJZld0
 +1N0VY38rhRtMplvekM9fKTnl9c4OHy2+HaZL/hR+MzVNPoxapN6P2XLmp3w2YgLrksOEudmvNb
 CSiuk+Cu1LMf229kII51cIrTF6HiGG00ZXrBZ+F23Dy1wo/L7I2wXmq2g6lNvqDE7KlLAnvnCq3
 mONy7SyHycYeNOI/sJQzDNWdwozSwBF235Fq7754QJyLPyR/3TE8PDy8H2YUht4jWLiEfHpNfAh
 C7nDAnzRTyCJHVsRHgTzpXS4bJfXODjFSLf77VTEF0YriGrRgblvJrtv7vKKcpIsPkpVWk1dUSW
 1P2a468yzaNH/lkkUXKvNnkiZyrzP2MdclvUoYItCiFdRzJgk=
X-Received: by 2002:a05:620a:28d0:b0:8c8:82a1:11bf with SMTP id
 af79cd13be357-8cb7402bc96mr260637685a.2.1771431566466; 
 Wed, 18 Feb 2026 08:19:26 -0800 (PST)
Received: from [172.19.0.48] ([99.196.128.5]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0db51fsm1836723885a.14.2026.02.18.08.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 08:19:25 -0800 (PST)
Message-ID: <d729df1d-ba33-4cab-88c9-ba980cdaa37d@kernel.dk>
Date: Wed, 18 Feb 2026 09:19:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
To: Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, fam@euphon.net
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk> <aY9Lj1BTVRCFyfic@redhat.com>
 <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
 <20260218161127.GC587447@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260218161127.GC587447@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=axboe@kernel.dk; helo=mail-qk1-x734.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/18/26 9:11 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 18, 2026 at 10:57:02AM +0100, Fiona Ebner wrote:
>> Am 13.02.26 um 5:05 PM schrieb Kevin Wolf:
>>> Am 13.02.2026 um 15:26 hat Jens Axboe geschrieben:
>>>> When a vCPU thread handles MMIO (holding BQL), aio_co_enter() runs the
>>>> block I/O coroutine inline on the vCPU thread because
>>>> qemu_get_current_aio_context() returns the main AioContext when BQL is
>>>> held. The coroutine calls luring_co_submit() which queues an SQE via
>>>> fdmon_io_uring_add_sqe(), but the actual io_uring_submit() only happens
>>>> in gsource_prepare() on the main loop thread.
>>>
>>> Ouch! Yes, looks like we completely missed I/O submitted in vCPU threads
>>> in the recent changes (or I guess worker threads in theory, but I don't
>>> think there any that actually make use of aio_add_sqe()).
>>>
>>>> Since the coroutine ran inline (not via aio_co_schedule()), no BH is
>>>> scheduled and aio_notify() is never called. The main loop remains asleep
>>>> in ppoll() with up to a 499ms timeout, leaving the SQE unsubmitted until
>>>> the next timer fires.
>>>>
>>>> Fix this by calling aio_notify() after queuing the SQE. This wakes the
>>>> main loop via the eventfd so it can run gsource_prepare() and submit the
>>>> pending SQE promptly.
>>>>
>>>> This is a generic fix that benefits all devices using aio=io_uring.
>>>> Without it, AHCI/SATA devices see MUCH worse I/O latency since they use
>>>> MMIO (not ioeventfd like virtio) and have no other mechanism to wake the
>>>> main loop after queuing block I/O.
>>>>
>>>> This is usually a bit hard to detect, as it also relies on the ppoll
>>>> loop not waking up for other activity, and micro benchmarks tend not to
>>>> see it because they don't have any real processing time. With a
>>>> synthetic test case that has a few usleep() to simulate processing of
>>>> read data, it's very noticeable. The below example reads 128MB with
>>>> O_DIRECT in 128KB chunks in batches of 16, and has a 1ms delay before
>>>> each batch submit, and a 1ms delay after processing each completion.
>>>> Running it on /dev/sda yields:
>>>>
>>>> time sudo ./iotest /dev/sda
>>>>
>>>> ________________________________________________________
>>>> Executed in   25.76 secs      fish           external
>>>>    usr time    6.19 millis  783.00 micros    5.41 millis
>>>>    sys time   12.43 millis  642.00 micros   11.79 millis
>>>>
>>>> while on a virtio-blk or NVMe device we get:
>>>>
>>>> time sudo ./iotest /dev/vdb
>>>>
>>>> ________________________________________________________
>>>> Executed in    1.25 secs      fish           external
>>>>    usr time    1.40 millis    0.30 millis    1.10 millis
>>>>    sys time   17.61 millis    1.43 millis   16.18 millis
>>>>
>>>> time sudo ./iotest /dev/nvme0n1
>>>>
>>>> ________________________________________________________
>>>> Executed in    1.26 secs      fish           external
>>>>    usr time    6.11 millis    0.52 millis    5.59 millis
>>>>    sys time   13.94 millis    1.50 millis   12.43 millis
>>>>
>>>> where the latter are consistent. If we run the same test but keep the
>>>> socket for the ssh connection active by having activity there, then
>>>> the sda test looks as follows:
>>>>
>>>> time sudo ./iotest /dev/sda
>>>>
>>>> ________________________________________________________
>>>> Executed in    1.23 secs      fish           external
>>>>    usr time    2.70 millis   39.00 micros    2.66 millis
>>>>    sys time    4.97 millis  977.00 micros    3.99 millis
>>>>
>>>> as now the ppoll loop is woken all the time anyway.
>>>>
>>>> After this fix, on an idle system:
>>>>
>>>> time sudo ./iotest /dev/sda
>>>>
>>>> ________________________________________________________
>>>> Executed in    1.30 secs      fish           external
>>>>    usr time    2.14 millis    0.14 millis    2.00 millis
>>>>    sys time   16.93 millis    1.16 millis   15.76 millis
>>>>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>>  util/fdmon-io_uring.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
>>>> index d0b56127c670..96392876b490 100644
>>>> --- a/util/fdmon-io_uring.c
>>>> +++ b/util/fdmon-io_uring.c
>>>> @@ -181,6 +181,14 @@ static void fdmon_io_uring_add_sqe(AioContext *ctx,
>>>>  
>>>>      trace_fdmon_io_uring_add_sqe(ctx, opaque, sqe->opcode, sqe->fd, sqe->off,
>>>>                                   cqe_handler);
>>>> +
>>>> +    /*
>>>> +     * Wake the main loop if it is sleeping in ppoll().  When a vCPU thread
>>>> +     * runs a coroutine inline (holding BQL), it queues SQEs here but the
>>>> +     * actual io_uring_submit() only happens in gsource_prepare().  Without
>>>> +     * this notify, ppoll() can sleep up to 499ms before submitting.
>>>> +     */
>>>> +    aio_notify(ctx);
>>>>  }
>>>
>>> Makes sense to me.
>>>
>>> At first I wondered if we should use defer_call() for the aio_notify()
>>> to batch the submission, but of course holding the BQL will already take
>>> care of that. And in iothreads where there is no BQL, the aio_notify()
>>> shouldn't make a difference anyway because we're already in the right
>>> thread.
>>>
>>> I suppose the other variation could be have another io_uring_enter()
>>> call here (but then probably really through defer_call()) to avoid
>>> waiting for another CPU to submit the request in its main loop. But I
>>> don't really have an intuition if that would make things better or worse
>>> in the common case.
>>>
>>> Fiona, does this fix your case, too?
>>
>> Yes, it does fix my issue [0] and the second patch gives another small
>> improvement :)
>>
>> Would it be slightly cleaner to have aio_add_sqe() call aio_notify()
>> itself? Since aio-posix.c calls downwards into fdmon-io_uring.c, it
>> would feel nicer to me to not have fdmon-io_uring.c call "back up". I
>> guess it also depends on whether we expect another future fdmon
>> implementation with .add_sqe() to also benefit from it.
> 
> Calling aio_notify() from aio-posix.c:aio_add_sqe() sounds better to me
> because fdmon-io_uring.c has to be careful about calling aio_*() APIs to
> avoid loops.

Would anyone care to make that edit? I'm on a plane and gone for a bit,
so won't get back to this for the next week. But I would love to see a
fix go in, as this issue has been plaguing me with test timeouts for
quite a while on the CI front. And seems like I'm not alone, if the
patches fix Fiona's issues as well.

-- 
Jens Axboe

