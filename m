Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D170C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kdf-0006ga-Qe; Wed, 16 Sep 2026 04:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6kdd-0006gA-4T
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6kdY-00078S-Ip
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789545898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdmFFEY2zOwBL8usehWliXvF2bQAT/RD7GM44xBiHJA=;
 b=ZG5neGlCM74683jL2VkjNkM5frytrLKcHWxS9U+jAyqewh7DdPOIRmRaoGudMWIO69XLJr
 PMKNrov33HAfSw3FJlI0JZlXp6Mw0gpZ+Z5MfwehsSIpO9E3Cf4PITc5OIwJi26GL3QzBn
 sMukEHZtaLi0ev+5fl4SIuyNy3jZpYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-aYg4K0KDOQyv2WvfxmidXA-1; Wed, 16 Sep 2026 04:04:55 -0400
X-MC-Unique: aYg4K0KDOQyv2WvfxmidXA-1
X-Mimecast-MFC-AGG-ID: aYg4K0KDOQyv2WvfxmidXA_1789545894
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e6683d48fso46275235e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789545894; x=1790150694; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vdmFFEY2zOwBL8usehWliXvF2bQAT/RD7GM44xBiHJA=;
 b=nGeFtLBOph19RXEqllIijgyc7/qI2cktmuLaiWPVrCqtz971X6SdCOZPrZQ/uk51ux
 ZlaOQLdzCUt4T+mpXqYqsZivwFg+yS6bSsPev5brQRMMFy6JOGHw9u3M2lquFlQQtmiZ
 wj8mGJP4ieHxMdgs9YThpCwopUBT5fL+6fCvgygUtQb8zKAXBQH0+rLhDJg3CMr1Be2p
 65SmwOOnmX+NvnNNLp2wbpoh2LdC7IU7qJD5d9Xp1sdPRIIiWzAFkCKmvrfex3deehfC
 O9HPgZF7UiFdxM3wO8A68lVoaRTStQdjqdDcIYfJboym5VIApZz49GuNvicqhcMQ4RZm
 68NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789545894; x=1790150694;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vdmFFEY2zOwBL8usehWliXvF2bQAT/RD7GM44xBiHJA=;
 b=Ay4Nor4W51WU1URRq4Q2M3b18Hp1VUBB02xjlGSURSLr/6E2LRoMT7Dls2F06vPmTB
 GFi7GkMovq5TUlko5R/3KhKFgSjtSJy+q2QmxfvbZM8mFgkraGdqGlthSVqWOjt103yr
 /c5NNCcQMFtojaMGpQIVtOePMoDd33zEIFSwq6FZtrSXLZh14IawCoyU0bnL+VttIa0V
 k9Uw1ae/8g22rUhs6fPD/Ysigy3Xyxc7gSFsBFKNBgfTe8h/joEtqCAm97S8AUQZJMNH
 Y5aoN9OSX+Poln51aX9M2JA477K/QQauUE+Cakd0OQrGZysiuDVhz6UVzU0sFjESc8zG
 f3HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBziRrzs8MjkHMBmDShaDCbDk807YBI/ZhvjZN2tqgqXfqrN9mJeDf0OKL/Nhw+mV5ypspDt/3k+uWh+@nongnu.org
X-Gm-Message-State: AFuF++mekZ3lQcoV1sH9leUQK7TMAvKpIvApSj/VgzB5qhPvTUf/owGL
 gfuDx9SULaqQqrDr0MP0nXkmN8ynejtTHXpiihq4RGrM+U2nUnYXLdsUz/xmaJPJ51uLCyFsTvx
 Byx5wznNTyABUFc9tMsCUyIUpaR4Hb1qZ2JvVgZEGmoEBXLhWHkz2KEWg
X-Gm-Gg: AYBFou3WLT4OU7PaASD+Pja8X6E/Ut05ex1D67mZAfr7AYF7LCgJK2J55GebAcCnfnt
 vfpfUMxaZV7V/3ZmX8CizrZdt46ogfU041Nm+QJXNmmjl9wVLMl4OmGahOlibT1Ls0x6ML+JBJU
 fB0nz6nsonsNkSTW7Omtn228Zj6AHYU60ns69H8hh+VzUq/xK8mqzCT/ebcLFeo0FF4Q8Q8iT+z
 lMF5u/5o5vjhNuXftl/re5fJ/yXmENCRjj3TMVUeSXTP/06OwvAdVlweq60+D5V3AmWoc2f2NFj
 +QNSevphm6qwKy1k1vEDZTdI7U+hSfxj1tPeWXKPzQYCw6G8yh5S/hoAgFKCsHcNUpk3Rd0Ea7s
 hrjfmT/wJJJD9gCvMBj0l4hHkLm6d9h1tRLoW/HC/Wu98W2hTYtXOwyW25iNy5Sr5MQCYvIZcLp
 MdK5yD5eqK+xuC2ZLQsPffh223uZw=
X-Received: by 2002:a05:600c:8b78:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49ebb4297c4mr16150415e9.24.1789545893802; 
 Wed, 16 Sep 2026 01:04:53 -0700 (PDT)
X-Received: by 2002:a05:600c:8b78:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49ebb4297c4mr16149895e9.24.1789545893374; 
 Wed, 16 Sep 2026 01:04:53 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83add1casm58541095e9.3.2026.09.16.01.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:04:52 -0700 (PDT)
Message-ID: <8592119d-665d-482e-9502-8f4a1a69c10d@redhat.com>
Date: Wed, 16 Sep 2026 10:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH 0/9] block: BLOCK_IO_DELAY event
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260903140815.GC825275@fedora>
Content-Language: en-US
In-Reply-To: <20260903140815.GC825275@fedora>
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

On 03.09.26 16:08, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2026 at 03:51:56PM +0200, Hanna Czenczek wrote:
>> Based-on:<20260724152315.234183-1-hreitz@redhat.com>
>>            [PATCH 0/6] hw/[block]: Fix missing accounting
>>            Fri, 24 Jul 2026 17:23:09 +0200
>>
>> Hi,
>>
>> I’m told there are installations where storage is very slow, and some
>> would like the VM stack to report this proactively.  To do so, we should
>> (via QAPI events) report on extremely slow I/O requests.
>>
>> We already have the latency histogram, but this is not deemed sufficient
>> because it is not proactively reporting and would require repeated
>> querying.  Therefore, this series introduces the event still.
>>
>> Now, from a user's perspective, it would be nice if this event could be
>> raised exactly when an I/O request crosses the user-defined threshold,
>> but this would require keeping all active requests in a list and
>> checking it periodically.  Now, if we used latency cookies for this
> Did you consider a per-request timer? The QEMUTimerList active_timers
> sorted list does not support efficient insertion, but improving it would
> benefit all timer API users.

I'm not sure how that would address the problem. Does that not just move 
the list elsewhere?

I.e. it still has the problem that every request needs to be put into a 
list (starting a timer), and be removed when the request is done, or the 
timer will fire and the below problems would occur if the request is 
done but we failed to remove it (either use-after-free; or spurious 
events plus memory leaks on top of a heap allocation per request).

>> (which makes sense), then that would require that every cookie set up is
>> also finalized when the request is done, because if we don't, results
>> could well be catastrophic:
>> - Either we use cookies as-is, which are often allocated on the stack or
>>    in some other structure managed by the device; then this would result
>>    in use-after-free,
>> - Or we allocate something specifically for this checking, so lingering
>>    requests would at most create spurious latency events and memory
>>    leaks, but this would require an additional heap allocation per
>>    request that we would probably want to avoid.
>>
>> So ideally we could use latency cookies and could statically verify that
>> they are always finalized when the request is done, but doing this in C
>> may well be impossible.
> I think you are saying that the cookie API is unsafe because cookie
> lifetime is not bounded by the request lifetime?

Yes, because it is not statically proven to be so.

> Maybe the block_acct_*() API can be integrated into the actual request
> so there is no way to leak the cookie. In other words, directly
> associate requests with a BlockAcctStats and stop requiring the user to
> manually manage a separate BlockAcctCookie.

I don't follow what you mean concretely. If you are suggesting a list of 
requests in BlockAcctStats, then that is exactly what I had.

The problem is that if the destructor has to be called explicitly, we 
may forget to do so; and accounting is done on the device emulation 
level, so there is no central place where the pairing of constructor and 
destructor would be obvious and trivial to verify.

I.e. it’s not like our functions current look like

````
run_co_ide_request() {
     start_cookie();
     run_co_request();
     finalize_cookie();
}
```

Where the pairing of start and finalize are obvious; instead, start and 
stop are in very different parts of the code, in all device emulation code.

> The API is already weird because devices use:
>
>    block_acct_failed(blk_get_stats(s->blk), &req->acct);
>
> i.e. why does the device have to reach into s->blk to access the stats?
> If the stats belong to s->blk, then s->blk should do the accounting
> during the request lifetime.
>
> This would require a redesign of not just the cookie API, but also the
> error policy API. There is also a wrinkle in that virtio-blk merges I/O
> requests and accounts the merges.
>
>> So, because it is basically impossible (or at least it would be very
>> hard, and presumably require a large refactoring) to guarantee, without
>> additional heap allocations, that a list of active requests won’t run
>> into catastrophic use-after-frees, this series does the much simpler
>> version first, which is to just raise an event when a request *finishes*
>> and took more than a user-defined latency threshold.
> Does this achieve the goal of warning when requests exceed a threshold?

According to 
https://redhat.atlassian.net/browse/RHEL-141617?focusedCommentId=18127333 
(and the following two comments), yes.

> When an I/O request hangs for a long time, the management tool will be
> unable to detect that the threshold has been exceeded in a timely
> manner.

Yes. But why would that be a real problem?

Given the request so far is only to notify users of their storage block 
showing problematic latencies at all, there is no need to provide the 
alerts in actual real time.

Hanna

>> (PS: The nice thing about throwing an alert while the request is still
>> going on would be that it could allow us to also stop the VM in case of
>> excessive latency, before the request completes, so the guest would be
>> shielded from such excessive latency.  This might be useful for Windows
>> guests that just have a maximum request lantency before throwing a
>> BSOD.)
>>
>>
>> Hanna Czenczek (9):
>>    block/accounting: Add offset to BlockAcctCookie
>>    qapi/block: Add IoAccountingOperation enum
>>    qapi/block: Add BLOCK_IO_DELAY event
>>    block-backend: Public blk_get_attached_dev_path()
>>    block/accounting: Add BB field to latency checker
>>    block/accounting: Emit BLOCK_IO_DELAY event
>>    block: Add delay-alert-ms property
>>    block/accounting: Move latency_ns override down
>>    iotests: Add delay-alert test
>>
>>   qapi/block.json                          |  52 +++++++++
>>   include/block/accounting.h               |  20 +++-
>>   include/hw/block/block.h                 |   5 +-
>>   include/system/block-backend-io.h        |   9 ++
>>   include/system/dma.h                     |   2 +-
>>   block/accounting.c                       |  60 ++++++++--
>>   block/block-backend.c                    |   8 +-
>>   blockdev.c                               |  16 ++-
>>   hw/block/block.c                         |   4 +-
>>   hw/block/dataplane/xen-block.c           |   4 +-
>>   hw/block/virtio-blk.c                    |  15 +--
>>   hw/ide/ahci.c                            |   6 +-
>>   hw/ide/atapi.c                           |   9 +-
>>   hw/ide/core.c                            |   9 +-
>>   hw/ide/macio.c                           |  15 ++-
>>   hw/nvme/ctrl.c                           |  43 ++++---
>>   hw/nvme/dif.c                            |   8 +-
>>   hw/scsi/scsi-disk.c                      |  28 +++--
>>   qemu-io-cmds.c                           |  14 +--
>>   system/dma-helpers.c                     |   4 +-
>>   tests/unit/test-block-accounting.c       |   2 +-
>>   tests/qemu-iotests/172.out               |  38 +++++++
>>   tests/qemu-iotests/tests/delay-alert     | 136 +++++++++++++++++++++++
>>   tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
>>   24 files changed, 472 insertions(+), 81 deletions(-)
>>   create mode 100755 tests/qemu-iotests/tests/delay-alert
>>   create mode 100644 tests/qemu-iotests/tests/delay-alert.out
>>
>> -- 
>> 2.55.0
>>


