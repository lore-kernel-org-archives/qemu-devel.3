Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56FEC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfete-0003oW-Ks; Thu, 29 Feb 2024 06:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfetd-0003nq-AP; Thu, 29 Feb 2024 06:48:17 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfetY-0004Wt-Kx; Thu, 29 Feb 2024 06:48:17 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:6c2d:0:640:316f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5307E6090D;
 Thu, 29 Feb 2024 14:48:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5mYtTY2IZa60-6teqyoXN; Thu, 29 Feb 2024 14:48:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709207286;
 bh=wIbwL2Q1795jWIZb6xwNRZkj1ZQxHDXEaQEybHW6N88=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ahGv5wUcmh3mZWRcWZ2bPFJdFP/e/5tVtbDkeh2j4eKIBat8ZnATFLVaA5VvnOShh
 /i7fxTsjG+Kg9WZE13nEdvEb4jT0fyb5gi0lr405Ua0vn+kZ8AuSjoDopQxpDXjscu
 TLw6VwswRlxT8Qt3gEGep58sp8Jcw0i7s/lf4MuU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b737130a-2a01-4b1c-945a-b0d574345d0e@yandex-team.ru>
Date: Thu, 29 Feb 2024 14:48:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <cf086f76-1f47-4f45-aba5-fc021ad090da@yandex-team.ru>
 <8a84f7f2-6765-49f6-9469-908bcfdc7437@yandex-team.ru>
 <5ded1c2d-5aa8-440a-9f01-a3529e07abf0@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <5ded1c2d-5aa8-440a-9f01-a3529e07abf0@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 29.02.24 13:11, Fiona Ebner wrote:
> Am 28.02.24 um 17:06 schrieb Vladimir Sementsov-Ogievskiy:
>> On 28.02.24 19:00, Vladimir Sementsov-Ogievskiy wrote:
>>> On 16.02.24 13:55, Fiona Ebner wrote:
>>>> Now, the IO test added in patch 4/4 actually contains yet another use
>>>> case, namely doing incremental mirrors to stand-alone qcow2 "diff"
>>>> images, that only contain the delta and can be rebased later. I had to
>>>> adapt the IO test, because its output expected the mirror bitmap to
>>>> still be dirty, but nowadays the mirror is apparently already done
>>>> when the bitmaps are queried. So I thought, I'll just use
>>>> 'write-blocking' mode to avoid any potential timing issues.
>>>>
>>>> But this exposed an issue with the diff image approach. If a write is
>>>> not aligned to the granularity of the mirror target, then rebasing the
>>>> diff image onto a backing image will not yield the desired result,
>>>> because the full cluster is considered to be allocated and will "hide"
>>>> some part of the base/backing image. The failure can be seen by either
>>>> using 'write-blocking' mode in the IO test or setting the (bitmap)
>>>> granularity to 32 KiB rather than the current 64 KiB.
>>>>
>>>> The question is how to deal with these edge cases? Some possibilities
>>>> that would make sense to me:
>>>>
>>>> For 'background' mode:
>>>> * prohibit if target's cluster size is larger than the bitmap
>>>>     granularity
>>>> * document the limitation
>>>>
>>>> For 'write-blocking' mode:
>>>> * disallow in combination with bitmap mode (would not be happy about
>>>>     it, because I'd like to use this without diff images)
>>>
>>> why not just require the same: bitmap granularity must be >= target
>>> granularity
>>>
> 
> For the iotest's use-case, that only works for background mode. I'll
> explain below.
> 
>>>> * for writes that are not aligned to the target's cluster size, read
>>>>     the relevant/missing parts from the source image to be able to write
>>>>     whole target clusters (seems rather complex)
>>>
>>> There is another approach: consider and unaligned part of the request,
>>> fit in one cluster (we can always split any request to "aligned"
>>> middle part, and at most two small "unligned" parts, each fit into one
>>> cluster).
>>>
>>> We have two possibilities:
>>>
>>> 1. the cluster is dirty (marked dirty in the bitmap used by background
>>> process)
>>>
>>> We can simply ignore this part and rely on background process. This
>>> will not affect the convergence of the mirror job.
>>>
> 
> Agreed.
> 
>>> 2. the cluster is clear (i.e. background process, or some previous
>>> write already copied it)
>>>
> 
> The iotest creates a new target image for each incremental sync which
> only records the diff relative to the previous mirror and those diff
> images are later rebased onto each other to get the full picture.
> 
> Thus, it can be that a previous mirror job (not just background process
> or previous write) already copied a cluster, and in particular, copied
> it to a different target!

Aha understand.

For simplicity, let's consider case, when source "cluster size" = "job cluster size" = "bitmap granularity" = "target cluster size".

Which types of clusters we should consider, when we want to handle guest write?

1. Clusters, that should be copied by background process

These are dirty clusters from user-given bitmap, or if we do a full-disk mirror, all clusters, not yet copied by background process.

For such clusters we simply ignore the unaligned write. We can even ignore the aligned write too: less disturbing the guest by delays.

2. Clusters, already copied by background process during this mirror job and not dirtied by guest since this time.

For such clusters we are safe to do unaligned write, as target cluster must be allocated.

3. Clusters, not marked initially by dirty bitmap.

What to do with them? We can't do unaligned write. I see two variants:

- do additional read from source, to fill the whole cluster, which seems a bit too heavy

- just mark the cluster as dirty for background job. So we behave like in "background" mode. But why not? The maximum count of such "hacks" is limited to number of "clear" clusters at start of mirror job, which means that we don't seriously affect the convergence. Mirror is guaranteed to converge anyway. And the whole sense of "write-blocking" mode is to have a guaranteed convergence. What do you think?


----

Of course, we can't distinguish 3 types by on dirty bitmap, so we need the second one. For example "done_bitmap", where we can mark clusters that were successfully copied. That would be a kind of block-status of target image. But using bitmap is a lot better than querying block-status from target.


> 
>>> In this case, we are safe to do unaligned write, as target cluster
>>> must be allocated.
> 
> Because the diff image is new, the target's cluster is not necessarily
> allocated. When using write-blocking and a write of, e.g., 9 bytes to a
> clear source cluster comes in, only those 9 bytes are written to the
> target. Now the target's cluster is allocated but with only those 9
> bytes of data. When rebasing, the previously copied cluster is "masked"
> and when reading the rebased image, we only see the cluster with those 9
> bytes (and IIRC, zeroes for the rest of the cluster rather than the
> previously copied data).
> 
>>>
>>> (for bitmap-mode, I don't consider here clusters that are clear from
>>> the start, which we shouldn't copy in any case)
>>>
> 
> We do need to copy new writes to any cluster, and with a clear cluster
> and write-blocking, the issue can manifest.

OK right, I was misunderstanding bitmap-mode for mirror. Now I understand.

> 
>>
>> Hmm, right, and that's exactly the logic we already have in
>> do_sync_target_write(). So that's enough just to require that
>> bitmap_granularity >= target_granularity
>>
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


