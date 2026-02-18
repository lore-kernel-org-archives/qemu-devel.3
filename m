Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8FEE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vskG0-0008Q7-QE; Wed, 18 Feb 2026 11:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vskFx-0008Pa-OZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:18:29 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <axboe@kernel.dk>) id 1vskFm-0004ul-NQ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 11:18:23 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-89549b2f538so5012876d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 08:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771431492; x=1772036292;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xp7vQ0DUAAfOK5KgbDsk0O302+yuwl4xwmTcIOq8d0Y=;
 b=CHwvm4eS6SAHwjWv7n/1tNJnaGcTJc4YIM44kGDY3oGLiTqNkRqggd/4560rsLemXi
 tFSRKAe10KMzikerh0gvCnDSmQyvV3vYTfq18g5+n3o9eMHU9AIFvBmbjamIFtYpqLLg
 gArRlCQ+OfFWJ/bOmFDv3urwNvXsgZviPbjwqiN1SQlIqgot0Aa9fcrlSUwljHywFqJm
 yXKddqApXHPPK2yTDAU7lV2fWz9qKOEoswYDOgJgjSAawLf4F7ohvsyF1qOb6skpRse0
 NMh3U8I7GBycnC2573uu6n9frUS353+CwcqnP+Odd8WiEzKus6GpVYuyhFm6so7PQooy
 un8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771431492; x=1772036292;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xp7vQ0DUAAfOK5KgbDsk0O302+yuwl4xwmTcIOq8d0Y=;
 b=mVHm7xz1B7cegLSspH1kMDX77PmOnGjRQTbBHSZ/1xAI1WibTHpDrCW4HQXguQcwl9
 YR6GZxm2Ftx5ehHtlvaDLZPYv6oWWQk0RmBPuvNwUxa8/sSlg4lf4Y6yikFEW5Vgwipl
 N8Fd6R24NP1jz3Ro+g5jeXwmGwkdWK6j6/BCQ2fP+DMaY8VubmBu84GlUBZgOWSUyIiX
 O62bPF4QqFjPJyDce/k2JUNtBL1p3iOmY/+Hj1f77a7HwJAJt/9jbePrvEW4Tqzz8KCP
 oqoWa9Jtby3tRMmAvZjndVRX/rO1nU0JJayaBOe8srmsw77DYqmr5rByf5jQCwMzwUir
 ReFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhoVUm35QfN488I4cz7gT9qrDsdk1WcAMMWlryCF3Lfl87zjlcxgPuwE5MvjE/aIo7WvuUFwN2WWrf@nongnu.org
X-Gm-Message-State: AOJu0YzIAxZJevHoQjrR+ztwUE9G6sduGhYXNraFL0Q6IqhWw26kQNnt
 6pY22txkvNN5tZVZ1n+bzgNdU7zxxYcnybfN64+f25QosADSkJJmABa/I1uwCQA4iZI=
X-Gm-Gg: AZuq6aJqzG9tpcCKNlx9hXUF9ZTqf4Df8af/eMZY9TeL6953yiEWs8MN4Yc/N/s/49k
 2e4vNYmVJjOGBMc9CT971ZOJVxQTxnLYZ202hsCTvj6m9vv+/UkjneZBjmlrZW+t5yddx6XtYw+
 KcBvvo+5fSw2gcgi3V0ZLeYUX3AJB9Ow1ORHig9NCPi9dBpLxNHmgZbJxbPGxyUHYR61w2TXZAe
 90ISCRWpeYuEeyzwuye5wSV6AMX1iywLfiD6/Wg5mZWCcTOOpolc05KMVD+PrXQOKK+YgdtjS5Y
 gx5YDPDqJMaGX23aFbUSLRx3WCY/jaVOEzHluFHhAydQIx/sAQk4ZMnBAX9BFypyNPnqK1SWcDZ
 mMqZKoJofd5HGr1/5xNYSf6KJJr1dDE0LMSt4j/XKF/4EnqZQGRKeJGzZIe4RbusULQSUUZmgh6
 MEnmnNte1fB2czXV8fO6V51VSed+st9InPMrf1Cp7KebfRr1s=
X-Received: by 2002:ac8:7c4a:0:b0:503:42a4:96fb with SMTP id
 d75a77b69052e-506b402067dmr192170731cf.65.1771431491766; 
 Wed, 18 Feb 2026 08:18:11 -0800 (PST)
Received: from [172.19.0.48] ([99.196.128.5]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847d78e1sm213902221cf.4.2026.02.18.08.18.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 08:18:10 -0800 (PST)
Message-ID: <7811fc80-b2a1-4857-95f5-4bf01c806d07@kernel.dk>
Date: Wed, 18 Feb 2026 09:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fdmon-io_uring: notify main loop when SQEs are queued
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, fam@euphon.net, Fiona Ebner <f.ebner@proxmox.com>
References: <20260213143225.161043-1-axboe@kernel.dk>
 <20260213143225.161043-2-axboe@kernel.dk> <aY9Lj1BTVRCFyfic@redhat.com>
 <c32915a9-33a2-47c5-a91b-27f01147918f@proxmox.com>
 <20260218160621.GB587447@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260218160621.GB587447@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=axboe@kernel.dk; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/18/26 9:06 AM, Stefan Hajnoczi wrote:
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
> 
> It's possible to call io_uring_enter(). QEMU currently doesn't use
> IORING_SETUP_SINGLE_ISSUER, so it's okay for multiple threads to call
> io_uring_enter() on the same io_uring fd.

I would not recommend that, see below.

> I experimented with IORING_SETUP_SINGLE_ISSUER (as well as
> IORING_SETUP_COOP_TASKRUN and IORING_SETUP_TASKRUN_FLAG) in the past and
> didn't measure a performance improvement:
> https://lore.kernel.org/qemu-devel/20250724204702.576637-1-stefanha@redhat.com/
> 
> Jens, any advice regarding these flags?

None other than "yes you should use them" - it's an expanding area of
"let's make that faster", so if you tested something older, then that
may be why as we didn't have a lot earlier. We're toying with getting
rid of the uring_lock for SINGLE_ISSUER, for example.

Hence I think having multiple threads do enter is a design mistake, and
one that might snowball down the line and make it harder to step back
and make SINGLE_ISSUER work for you. Certain features also end up being
gated behing DEFER_TASKRUN, which requires SINGLE_ISSUER as well.

tldr - don't have multiple threads do enter on the same ring, ever, if
it can be avoided. It's a design mistake.

-- 
Jens Axboe

