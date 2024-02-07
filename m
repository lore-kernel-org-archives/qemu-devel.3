Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E86FC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXeL2-0005Ir-Hq; Wed, 07 Feb 2024 04:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXeL0-0005ID-Cd
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXeKy-0005L1-3P
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707298523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WypRlAgwPE3N9xh2eGTPn3GJSH1rDJz3teXxmZ3tmGY=;
 b=hRW3AvgTVUDnDl9mWa0KQi7ZNolc7UVi46ir/XRG+eN79a4Gj2MLZ9++704FocrxGQvzH8
 +4beJuoLTBb+50Ljb1F4c4I7JM7fKoX6FhwSFKLNa4cEsrj2FPop0ixzyF9hAkoKbqcCIU
 JYtPEOaG/9eabFr6AIEcAl6giorol6g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44--mXO3c0rPJiSk7uQImi0qg-1; Wed, 07 Feb 2024 04:35:21 -0500
X-MC-Unique: -mXO3c0rPJiSk7uQImi0qg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b316fcaecso217453f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707298520; x=1707903320;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WypRlAgwPE3N9xh2eGTPn3GJSH1rDJz3teXxmZ3tmGY=;
 b=XKzpgPZjvmwE71tS1JQhlefvstjtTv7sXskFVvnTjenivzkAe7PvuVCLccWDVMtuPf
 924Ih6r3LO8zqqL1CwZB7Mus1zIhbprT/wzaKq9Q+Un956mv3YKeHYFL8nDb4XGvRehR
 rgi5iDeTPpESQVUOzdi4rVokqG8wNCSxyWvtmoeVdCaN3pm4yGMd06MrLnFZ95zS1oML
 qPuhUUciguoVF5veqrgzJ3jz73fFNjCCwizeFykNmjXQLtKcLO9sjGnd00Wxtb1MW6U3
 4kXcOd4B3tuXju1KcoiasYQGIHy2TMrLw25EldiaLohnJYsi5DHq94hqTiSU4rIxRQ/f
 utng==
X-Gm-Message-State: AOJu0Ywvsw9qoRhcTanZBjZvaLpGda2GL/rcpMwkUtkwgT+kcxROPPfP
 mLVVbwQ7M21HGZkrmn8/fpqVNINnlUJBbkVo57ITdyJBQGDvkkfPBwE99zExefprtqxy2pMOsF8
 fJt0UeFNuOoCDkadniTT+jCkwEjeFpk6hTLttqNuHp79WGp9620NW
X-Received: by 2002:adf:ce90:0:b0:33b:44b4:da60 with SMTP id
 r16-20020adfce90000000b0033b44b4da60mr3119945wrn.41.1707298520418; 
 Wed, 07 Feb 2024 01:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHENEqwOHDCrFpk/+pcr2bJjUc+Ld+QNemL+WDMQu6DQeVr2bTZfdNSnGPazpAvbLNWuj/wYA==
X-Received: by 2002:adf:ce90:0:b0:33b:44b4:da60 with SMTP id
 r16-20020adfce90000000b0033b44b4da60mr3119935wrn.41.1707298520041; 
 Wed, 07 Feb 2024 01:35:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNUJjes23Lg6S4jGutjY9+TUFQLUmW1trTWQPGY4rGV1Bk8+Yr6vW+/Q2iNd2CAxc7m44sJrUwE2e/7wbJTmT2UVTd49vtuEpv9j0fLLnWi8vcyeqLT34GXdutCHNBlk0r574c2c7aVyx+dxfR7llj+SVorm/c+SyXn3gishIyO6UgCfdef2pgQMOcFkvGVAJFv48
Received: from ?IPV6:2003:cf:d740:6580:d2a6:bec3:ba10:572d?
 (p200300cfd7406580d2a6bec3ba10572d.dip0.t-ipconnect.de.
 [2003:cf:d740:6580:d2a6:bec3:ba10:572d])
 by smtp.gmail.com with ESMTPSA id
 s27-20020adfa29b000000b0033b3c1200f0sm1053356wra.10.2024.02.07.01.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 01:35:19 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------jLtUpBeu6SwG2C1JJW95Uk0l"
Message-ID: <5c7c5239-f665-4845-8448-14226e1337cc@redhat.com>
Date: Wed, 7 Feb 2024 10:35:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20240202144755.671354-1-hreitz@redhat.com>
 <20240206165330.GB66397@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240206165330.GB66397@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------jLtUpBeu6SwG2C1JJW95Uk0l
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.02.24 17:53, Stefan Hajnoczi wrote:
> On Fri, Feb 02, 2024 at 03:47:53PM +0100, Hanna Czenczek wrote:
>> Hi,
>>
>> Without the AioContext lock, a BB's context may kind of change at any
>> time (unless it has a root node, and I/O requests are pending).  That
>> also means that its own context (BlockBackend.ctx) and that of its root
>> node can differ sometimes (while the context is being changed).
>>
>> blk_get_aio_context() doesn't know this yet and asserts that both are
>> always equal (if there is a root node).  Because it's no longer true,
>> and because callers don't seem to really care about the root node's
>> context, we can and should remove the assertion and just return the BB's
>> context.
>>
>> Beyond that, the question is whether the callers of
>> blk_get_aio_context() are OK with the context potentially changing
>> concurrently.  Honestly, it isn't entirely clear to me; most look OK,
>> except for the virtio-scsi code, which operates under the general
>> assumption that the BB's context is always equal to that of the
>> virtio-scsi device.  I doubt that this assumption always holds (it is
>> definitely not obvious to me that it would), but then again, this series
>> will not make matters worse in that regard, and that is what counts for
>> me now.
>>
>> One clear point of contention is scsi_device_for_each_req_async(), which
>> is addressed by patch 2.  Right now, it schedules a BH in the BB
>> context, then the BH double-checks whether the context still fits, and
>> if not, re-schedules itself.  Because virtio-scsi's context is fixed,
>> this seems to indicate to me that it wants to be able to deal with a
>> case where BB and virtio-scsi context differ, which seems to break that
>> aforementioned general virtio-scsi assumption.
> I don't agree with the last sentence: virtio-scsi's context isn't fixed.
>
> The AioContext changes when dataplane is started/stopped. virtio-scsi
> switches AioContext between the IOThread's AioContext and the main
> loop's qemu_aio_context.
>
> However, virtio-scsi virtqueue processing only happens in the IOThread's
> AioContext. Maybe this is what you meant when you said the AioContext is
> fixed?

Specifically, I meant VirtIOSCSI.ctx, which is set only once in 
virtio_scsi_dataplane_setup().  That’s at least where the virtqueue 
notifiers are registered, so yes, virtqueue processing should at least 
be fixed to that context.  It seems like it’s always possible some 
things are processed in the main thread (not just setup/teardown, but 
also e.g. TMF_LOGICAL_UNIT_RESET), so to me it seems like virtio-scsi 
kind of runs in two contexts simultaneously. Yes, when virtqueue 
processing is paused, all processing VirtIOSCSI.ctx is stopped, but I 
wouldn’t say it switches contexts there.  It just stops processing some 
requests.

Either way, virtio-scsi request processing doesn’t stop just because a 
scsi-hd device is hot-plugged or -unplugged.  If the BB changes contexts 
in the hot-unplug path (while vq request processing is continuing in the 
I/O thread), its context will differ from that of virtio-scsi.

So should I just replace the “the context is fixed” and say that in this 
specific instance, virtio-scsi vq processing continues in the I/O thread?

> The BH function is aware that the current AioContext might not be the
> same as the AioContext at the time the BH was scheduled. That doesn't
> break assumptions in the code.
>
> (It may be possible to rewrite virtio-blk, virtio-scsi, and core
> VirtIODevice ioeventfd code to use the simpler model where the
> AioContext really is fixed because things have changed significantly
> over the years, but I looked a few weeks ago and it's difficult work.)
>
> I'm just pointing out that I think this description is incomplete. I
> *do* agree with what this patch series is doing :).

Well, this description won’t land in any commit log, so from my side, 
I’m not too worried about its correctness. O:)

Hanna

>> Unfortunately, I definitely have to touch that code, because accepting
>> concurrent changes of AioContexts breaks the double-check (just because
>> the BB has the right context in that place does not mean it stays in
>> that context); instead, we must prevent any concurrent change until the
>> BH is done.  Because changing contexts generally involves a drained
>> section, we can prevent it by keeping the BB in-flight counter elevated.
>>
>> Question is, how to reason for that.  I’d really rather not include the
>> need to follow the BB context in my argument, because I find that part a
>> bit fishy.
>>
>> Luckily, there’s a second, completely different reason for having
>> scsi_device_for_each_req_async() increment the in-flight counter:
>> Specifically, scsi_device_purge_requests() probably wants to await full
>> completion of scsi_device_for_each_req_async(), and we can do that most
>> easily in the very same way by incrementing the in-flight counter.  This
>> way, the blk_drain() in scsi_device_purge_requests() will not only await
>> all (cancelled) I/O requests, but also the non-I/O requests.
>>
>> The fact that this prevents the BB AioContext from changing while the BH
>> is scheduled/running then is just a nice side effect.
>>
>>
>> Hanna Czenczek (2):
>>    block-backend: Allow concurrent context changes
>>    scsi: Await request purging
>>
>>   block/block-backend.c | 22 +++++++++++-----------
>>   hw/scsi/scsi-bus.c    | 30 +++++++++++++++++++++---------
>>   2 files changed, 32 insertions(+), 20 deletions(-)
>>
>> -- 
>> 2.43.0
>>

--------------jLtUpBeu6SwG2C1JJW95Uk0l
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 06.02.24 17:53, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240206165330.GB66397@fedora">
      <pre class="moz-quote-pre" wrap="">On Fri, Feb 02, 2024 at 03:47:53PM +0100, Hanna Czenczek wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi,

Without the AioContext lock, a BB's context may kind of change at any
time (unless it has a root node, and I/O requests are pending).  That
also means that its own context (BlockBackend.ctx) and that of its root
node can differ sometimes (while the context is being changed).

blk_get_aio_context() doesn't know this yet and asserts that both are
always equal (if there is a root node).  Because it's no longer true,
and because callers don't seem to really care about the root node's
context, we can and should remove the assertion and just return the BB's
context.

Beyond that, the question is whether the callers of
blk_get_aio_context() are OK with the context potentially changing
concurrently.  Honestly, it isn't entirely clear to me; most look OK,
except for the virtio-scsi code, which operates under the general
assumption that the BB's context is always equal to that of the
virtio-scsi device.  I doubt that this assumption always holds (it is
definitely not obvious to me that it would), but then again, this series
will not make matters worse in that regard, and that is what counts for
me now.

One clear point of contention is scsi_device_for_each_req_async(), which
is addressed by patch 2.  Right now, it schedules a BH in the BB
context, then the BH double-checks whether the context still fits, and
if not, re-schedules itself.  Because virtio-scsi's context is fixed,
this seems to indicate to me that it wants to be able to deal with a
case where BB and virtio-scsi context differ, which seems to break that
aforementioned general virtio-scsi assumption.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't agree with the last sentence: virtio-scsi's context isn't fixed.

The AioContext changes when dataplane is started/stopped. virtio-scsi
switches AioContext between the IOThread's AioContext and the main
loop's qemu_aio_context.

However, virtio-scsi virtqueue processing only happens in the IOThread's
AioContext. Maybe this is what you meant when you said the AioContext is
fixed?</pre>
    </blockquote>
    <br>
    Specifically, I meant VirtIOSCSI.ctx, which is set only once in
    virtio_scsi_dataplane_setup().  That’s at least where the virtqueue
    notifiers are registered, so yes, virtqueue processing should at
    least be fixed to that context.  It seems like it’s always possible
    some things are processed in the main thread (not just
    setup/teardown, but also e.g. TMF_LOGICAL_UNIT_RESET), so to me it
    seems like virtio-scsi kind of runs in two contexts simultaneously. 
    Yes, when virtqueue processing is paused, all processing
    VirtIOSCSI.ctx is stopped, but I wouldn’t say it switches contexts
    there.  It just stops processing some requests.<br>
    <br>
    Either way, virtio-scsi request processing doesn’t stop just because
    a scsi-hd device is hot-plugged or -unplugged.  If the BB changes
    contexts in the hot-unplug path (while vq request processing is
    continuing in the I/O thread), its context will differ from that of
    virtio-scsi.<br>
    <br>
    So should I just replace the “the context is fixed” and say that in
    this specific instance, virtio-scsi vq processing continues in the
    I/O thread?<br>
    <br>
    <blockquote type="cite" cite="mid:20240206165330.GB66397@fedora">
      <pre class="moz-quote-pre" wrap="">The BH function is aware that the current AioContext might not be the
same as the AioContext at the time the BH was scheduled. That doesn't
break assumptions in the code.

(It may be possible to rewrite virtio-blk, virtio-scsi, and core
VirtIODevice ioeventfd code to use the simpler model where the
AioContext really is fixed because things have changed significantly
over the years, but I looked a few weeks ago and it's difficult work.)

I'm just pointing out that I think this description is incomplete. I
*do* agree with what this patch series is doing :).</pre>
    </blockquote>
    <br>
    Well, this description won’t land in any commit log, so from my
    side, I’m not too worried about its correctness. O:)<br>
    <br>
    Hanna<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:20240206165330.GB66397@fedora">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Unfortunately, I definitely have to touch that code, because accepting
concurrent changes of AioContexts breaks the double-check (just because
the BB has the right context in that place does not mean it stays in
that context); instead, we must prevent any concurrent change until the
BH is done.  Because changing contexts generally involves a drained
section, we can prevent it by keeping the BB in-flight counter elevated.

Question is, how to reason for that.  I’d really rather not include the
need to follow the BB context in my argument, because I find that part a
bit fishy.

Luckily, there’s a second, completely different reason for having
scsi_device_for_each_req_async() increment the in-flight counter:
Specifically, scsi_device_purge_requests() probably wants to await full
completion of scsi_device_for_each_req_async(), and we can do that most
easily in the very same way by incrementing the in-flight counter.  This
way, the blk_drain() in scsi_device_purge_requests() will not only await
all (cancelled) I/O requests, but also the non-I/O requests.

The fact that this prevents the BB AioContext from changing while the BH
is scheduled/running then is just a nice side effect.


Hanna Czenczek (2):
  block-backend: Allow concurrent context changes
  scsi: Await request purging

 block/block-backend.c | 22 +++++++++++-----------
 hw/scsi/scsi-bus.c    | 30 +++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.43.0

</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------jLtUpBeu6SwG2C1JJW95Uk0l--


