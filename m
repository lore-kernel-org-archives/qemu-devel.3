Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B760C982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KWu-00023l-OZ; Wed, 23 Sep 2026 06:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KWs-00023U-Vs
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:48:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KWq-0000RF-5q
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790160523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=50zyYwWICmXqtQOKsK87UzDvNjhw1MP7aqsBsNiUgbY=;
 b=ScqomIjd2OsVuXowP0iMk1jeiw5W2n8szdzCUntX6RJNw8EMKqr3Ufqm61apNM5ei5q0Pw
 7xguxfhE3EOXutUsJ2GIJgzxBC0WDhK1L1DocSNTKr7Dl2wA9IYKijBNFBfPRv7NASgYkY
 pzrutv5NvJBh/0ZYOnX9op+dZOoQeQg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-Fenrt2ctPASbkcvwBgQhFg-1; Wed, 23 Sep 2026 06:48:40 -0400
X-MC-Unique: Fenrt2ctPASbkcvwBgQhFg-1
X-Mimecast-MFC-AGG-ID: Fenrt2ctPASbkcvwBgQhFg_1790160519
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4870a0fe60fso548154f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790160519; x=1790765319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=50zyYwWICmXqtQOKsK87UzDvNjhw1MP7aqsBsNiUgbY=;
 b=H+JE3SfoPDpDI4jdkZjObn/oYiZp/sA/BGE96lJuYJwZy3HuYTYnnr32sE+3RWV1q2
 hh4oZXVMRQJQThVkwtt4Iy5elzOVTa7/Dnm2N7ZJmDYpcc2DdIc5afi9FTWhI1FAeWc8
 4u5aNUimrwOdwWmBlN41kx2k//JTY3+q9NWU1hdyHGM2giqFYGD6hd/PZWjOozYkldku
 3ZjiQ08R1gN+wdEEqX2gFydKM8vCrdoXnlW2X4YEbsLitQaKkdM8kSJ4Uihe0yT04bvi
 rFEP0jCpNdbeNboMceaJTkhbhd8OZFKzJPLhmtAidMNst1BQFQx3GlD30dRrMx6q7xlC
 /9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790160519; x=1790765319;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=50zyYwWICmXqtQOKsK87UzDvNjhw1MP7aqsBsNiUgbY=;
 b=lsCh5YDTRl+8POO90w0CGJWPS1oU6tzVaEqDLi3bOOXlc8uVkitUCCBORYwEES3S7q
 fN39ElncFs3vWhNZ8WYjVt4HbvKkIlQw8vJc/9+GXjxPQzWAMExylhKj5NeVEcJ2b51t
 SU1DrtXlN8YVsFu/x2XA8UKvIi2Fo1aYI+GEsacvG32Ndvv8Hw/cYG+UTIdupzAhEhVw
 QNs4B1JEDaNhZPu09AWUKTOXPQSnZkNsKDZQOiraeeKiDSB4ZbTa4cm5+FGeqK6Xwi77
 OgFRnHedQD08QBiMle0XeSuAa1QBTp6BhlmQ77fN4T08lkT2FMRoZqtBsFkECm2PlT9a
 jcKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9ZMQiFS0u5DyKv+o9hjNWgy3QN3eOasJwyCuw1NWdWg/DhKAC4jBBGLrAS/bShmdkespzMnQlE2ay@nongnu.org
X-Gm-Message-State: AFuF++mbQ6rPt4MUpFg8IQWrlprP9siyuR3KKYGQ2LAo91evI4gtESSL
 9JnZeDch7J3vdoZdb0PTHP7yeWLMVaf1SC2If5x0xXhkueXAzusJ0yFHdR0kmx4WfcGJyY8K4d1
 0R+zGaG8GePd6qL9Ydg8zNo0tLL9x+EDvKwnlcAnGt/52yqBHbwh9Pfdr
X-Gm-Gg: AYBFou1AwnP0m/0AA2v5zPiDumZroUt8AJN+raZZIISjU1lpybaWoDKAgIlTWD6gw3x
 +YSDXkk0APxrkZJxZk0leJb8W97OBBqOus9o5KBcKgPjruXorq0VHc5AUk4JCDFKxXxrvotRBLf
 h4ZvOvcGCKFsdhFpzc2te5vzkDqxcSWl10ABsJbOCbKf1Bl5/HGVjnQ4Bf5p3TgzdoHhltvaSEW
 Pzx5L23YYugcHod6JnQiGNd0T7pyQaQRclPJUOnm+E8xSaXqIbdxdVx25G9kDyH+G45WHsScGrB
 TrVnTZtIH8o4r3YUVMq1rPYlTr/d/T7+MLtINrBAaEBHZOZa5G6JlNybYWXDKdBFHDjVL+l3+G7
 Xo+adRqxmY+zb80FnM4tUBllk6dR9gsEE6fU3u7AacEJqTUfLurxD1W+Fjusy4Htp5MjoIGK+6V
 u/8BkvURlccF4O/dXu2SJ/zLWsLTsBvQ==
X-Received: by 2002:a05:6000:250c:b0:487:35f:f0f0 with SMTP id
 ffacd0b85a97d-488670891femr4084262f8f.14.1790160518892; 
 Wed, 23 Sep 2026 03:48:38 -0700 (PDT)
X-Received: by 2002:a05:6000:250c:b0:487:35f:f0f0 with SMTP id
 ffacd0b85a97d-488670891femr4084226f8f.14.1790160518461; 
 Wed, 23 Sep 2026 03:48:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c64dsm6190760f8f.21.2026.09.23.03.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 03:48:37 -0700 (PDT)
Message-ID: <6a6a77e9-8acb-4312-aa38-e06f81ac882e@redhat.com>
Date: Wed, 23 Sep 2026 12:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
 <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
 <20260921204126.GC115897@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260921204126.GC115897@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 21.09.26 22:41, Stefan Hajnoczi wrote:
> On Wed, Sep 16, 2026 at 10:04:51AM +0200, Hanna Czenczek wrote:
>> On 03.09.26 16:08, Stefan Hajnoczi wrote:
>>> On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
>>>> Based-on:<20260724152315.234183-1-hreitz@redhat.com>
>>>>             [PATCH 0/6] hw/[block]: Fix missing accounting
>>>>             Fri, 24 Jul 2026 17:23:09 +0200
>>>>
>>>> Hi,
>>>>
>>>> I’m told there are installations where storage is very slow, and some
>>>> would like the VM stack to report this proactively.  To do so, we should
>>>> (via QAPI events) report on extremely slow I/O requests.
>>>>
>>>> We already have the latency histogram, but this is not deemed sufficient
>>>> because it is not proactively reporting and would require repeated
>>>> querying.  Therefore, this series introduces the event still.
>>>>
>>>> Now, from a user's perspective, it would be nice if this event could be
>>>> raised exactly when an I/O request crosses the user-defined threshold,
>>>> but this would require keeping all active requests in a list and
>>>> checking it periodically.  Now, if we used latency cookies for this
>>> Did you consider a per-request timer? The QEMUTimerList active_timers
>>> sorted list does not support efficient insertion, but improving it would
>>> benefit all timer API users.
>> I'm not sure how that would address the problem. Does that not just move the
>> list elsewhere?
>>
>> I.e. it still has the problem that every request needs to be put into a list
>> (starting a timer), and be removed when the request is done, or the timer
>> will fire and the below problems would occur if the request is done but we
>> failed to remove it (either use-after-free; or spurious events plus memory
>> leaks on top of a heap allocation per request).
> I wasn't thinking about the lifecycle here, but about the current
> limitation that users aren't notified until request completion. Requests
> can be stuck for a very long time or forever. Using a timer solves the
> timeliness problem.

I still don’t follow. The lifecycle *is* the problem if the timeliness. 
How to implement repeated querying is not the problem.

FWIW, the series that I had with timely waking did use a timer. But the 
timer is just not the problem.

>>>> (which makes sense), then that would require that every cookie set up is
>>>> also finalized when the request is done, because if we don't, results
>>>> could well be catastrophic:
>>>> - Either we use cookies as-is, which are often allocated on the stack or
>>>>     in some other structure managed by the device; then this would result
>>>>     in use-after-free,
>>>> - Or we allocate something specifically for this checking, so lingering
>>>>     requests would at most create spurious latency events and memory
>>>>     leaks, but this would require an additional heap allocation per
>>>>     request that we would probably want to avoid.
>>>>
>>>> So ideally we could use latency cookies and could statically verify that
>>>> they are always finalized when the request is done, but doing this in C
>>>> may well be impossible.
>>> I think you are saying that the cookie API is unsafe because cookie
>>> lifetime is not bounded by the request lifetime?
>> Yes, because it is not statically proven to be so.
>>
>>> Maybe the block_acct_*() API can be integrated into the actual request
>>> so there is no way to leak the cookie. In other words, directly
>>> associate requests with a BlockAcctStats and stop requiring the user to
>>> manually manage a separate BlockAcctCookie.
>> I don't follow what you mean concretely. If you are suggesting a list of
>> requests in BlockAcctStats, then that is exactly what I had.
> I meant that each I/O request should contain its own cookie and there is
> never a need to create a cookie separately from the request. That way
> the lifetime issue is solved.

Okay, I understood with your other email, because to me, “I/O request” 
sounded like some kind of object and I couldn’t think of any. My mind 
did not jump to the fact that you meant the actual execution thread of 
the request, i.e. code, not structure.

> This would require API changes because device emulation code currently
> has some of the logic for cookies. Devices would no longer call
> block_acct_done() once they have called blk_aio_pwritev(), for
> example. I haven't looked in detail and am not sure if it's feasible.

As said in the other email, doing this would most likely change behavior 
because we can’t or don’t want to reproduce all currently existing 
quirks. Which may be good or bad. Bad for me in any case because it 
would be more work, but, well…

>> The problem is that if the destructor has to be called explicitly, we may
>> forget to do so; and accounting is done on the device emulation level, so
>> there is no central place where the pairing of constructor and destructor
>> would be obvious and trivial to verify.
> This is the part I'm asking about: can accounting be done by the block
> layer? There might be cases that are purely handled in device emulation
> code without a call into the block layer. In that case the accounting
> still needs to be done in device emulation code. But when device
> emulation calls blk_aio_*(), it should not do accounting itself.
>
>> I.e. it’s not like our functions current look like
>>
>> ````
>> run_co_ide_request() {
>>      start_cookie();
>>      run_co_request();
>>      finalize_cookie();
>> }
>> ```
>>
>> Where the pairing of start and finalize are obvious; instead, start and stop
>> are in very different parts of the code, in all device emulation code.
>>
>>> The API is already weird because devices use:
>>>
>>>     block_acct_failed(blk_get_stats(s->blk), &req->acct);
>>>
>>> i.e. why does the device have to reach into s->blk to access the stats?
>>> If the stats belong to s->blk, then s->blk should do the accounting
>>> during the request lifetime.
>>>
>>> This would require a redesign of not just the cookie API, but also the
>>> error policy API. There is also a wrinkle in that virtio-blk merges I/O
>>> requests and accounts the merges.
>>>
>>>> So, because it is basically impossible (or at least it would be very
>>>> hard, and presumably require a large refactoring) to guarantee, without
>>>> additional heap allocations, that a list of active requests won’t run
>>>> into catastrophic use-after-frees, this series does the much simpler
>>>> version first, which is to just raise an event when a request *finishes*
>>>> and took more than a user-defined latency threshold.
>>> Does this achieve the goal of warning when requests exceed a threshold?
>> According to
>> https://redhat.atlassian.net/browse/RHEL-141617?focusedCommentId=18127333
>> (and the following two comments), yes.
> The issue says one purpose of this feature is to pause the guest to
> avoid BSODs. This won't work if the request has to finish first, because
> the BSOD occurs sometime after the treshold is reached but before QEMU
> or any other component can react to the QMP event.

I know. I linked to a specific comment chain that says it is enough for now.

Whether the pausing is something anyone actually would ever want is a 
completely different story, honestly. It is an idea I had for the 
original design, but nothing that has actually ever been requested.

>>> When an I/O request hangs for a long time, the management tool will be
>>> unable to detect that the threshold has been exceeded in a timely
>>> manner.
>> Yes. But why would that be a real problem?
>>
>> Given the request so far is only to notify users of their storage block
>> showing problematic latencies at all, there is no need to provide the alerts
>> in actual real time.
> What does the current approach solve that is not already possible with
> the block latency histogram?

See what I linked above. Apparently having to repeatedly query the 
histogram repeatedly is not deemed nice enough.

Hanna

> Libvirt could add an API to notify when a particular threshold is
> reached without any QEMU changes.
>
> Stefan


