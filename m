Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB04FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9vq-0003TN-EU; Thu, 07 Mar 2024 04:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ri9vm-0003Sb-RY; Thu, 07 Mar 2024 04:20:50 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ri9vW-0004qA-Rm; Thu, 07 Mar 2024 04:20:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5a2f:0:640:431a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 0ACD660EB5;
 Thu,  7 Mar 2024 12:20:28 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:28] (unknown
 [2a02:6b8:b081:7204::1:28])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PKd6f80IgiE0-hhqzITfS; Thu, 07 Mar 2024 12:20:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709803227;
 bh=oRFKZvL9NvEoceBMsNHh9HoFd0dGOZzXl0p7E8uc12c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=PGNmXCbu3tLNFKFMmo2xDqjjZZWGjNXuKuZn9qQNs6BrzzOHHOQrI3fH+HqhdGMBT
 NmOBsbAoC2vuGtYlHfl027Ypmc5zLKKfYIQtV3yXol7uAz3SL0R+q/oFA/hmT82syd
 sFXvyVZ57RCV39Ow2ySyMFsW0i3zlraoIkqkTvOw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b91dba34-7969-4d51-ba40-96a91038cc54@yandex-team.ru>
Date: Thu, 7 Mar 2024 12:20:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] mirror: implement incremental and bitmap modes
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
References: <20240216105513.309901-1-f.ebner@proxmox.com>
 <cf086f76-1f47-4f45-aba5-fc021ad090da@yandex-team.ru>
 <8a84f7f2-6765-49f6-9469-908bcfdc7437@yandex-team.ru>
 <5ded1c2d-5aa8-440a-9f01-a3529e07abf0@proxmox.com>
 <b737130a-2a01-4b1c-945a-b0d574345d0e@yandex-team.ru>
 <0a3b3d62-5374-4219-a5fa-f087f93d85d8@proxmox.com>
 <7b21c91b-5d33-4d84-aa61-cd69bbb78ccd@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7b21c91b-5d33-4d84-aa61-cd69bbb78ccd@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06.03.24 16:44, Fiona Ebner wrote:
> Am 29.02.24 um 13:47 schrieb Fiona Ebner:
>> Am 29.02.24 um 12:48 schrieb Vladimir Sementsov-Ogievskiy:
>>> On 29.02.24 13:11, Fiona Ebner wrote:
>>>>
>>>> The iotest creates a new target image for each incremental sync which
>>>> only records the diff relative to the previous mirror and those diff
>>>> images are later rebased onto each other to get the full picture.
>>>>
>>>> Thus, it can be that a previous mirror job (not just background process
>>>> or previous write) already copied a cluster, and in particular, copied
>>>> it to a different target!
>>>
>>> Aha understand.
>>>
>>> For simplicity, let's consider case, when source "cluster size" = "job
>>> cluster size" = "bitmap granularity" = "target cluster size".
>>>
>>> Which types of clusters we should consider, when we want to handle guest
>>> write?
>>>
>>> 1. Clusters, that should be copied by background process
>>>
>>> These are dirty clusters from user-given bitmap, or if we do a full-disk
>>> mirror, all clusters, not yet copied by background process.
>>>
>>> For such clusters we simply ignore the unaligned write. We can even
>>> ignore the aligned write too: less disturbing the guest by delays.
>>>
>>
>> Since do_sync_target_write() currently doesn't ignore aligned writes, I
>> wouldn't change it. Of course they can count towards the "done_bitmap"
>> you propose below.
>>
>>> 2. Clusters, already copied by background process during this mirror job
>>> and not dirtied by guest since this time.
>>>
>>> For such clusters we are safe to do unaligned write, as target cluster
>>> must be allocated.
>>>
>>
>> Right.
>>
>>> 3. Clusters, not marked initially by dirty bitmap.
>>>
>>> What to do with them? We can't do unaligned write. I see two variants:
>>>
>>> - do additional read from source, to fill the whole cluster, which seems
>>> a bit too heavy
>>>
>>
>> Yes, I'd rather only do that as a last resort.
>>
>>> - just mark the cluster as dirty for background job. So we behave like
>>> in "background" mode. But why not? The maximum count of such "hacks" is
>>> limited to number of "clear" clusters at start of mirror job, which
>>> means that we don't seriously affect the convergence. Mirror is
>>> guaranteed to converge anyway. And the whole sense of "write-blocking"
>>> mode is to have a guaranteed convergence. What do you think?
>>>
>>
>> It could lead to a lot of flips between job->actively_synced == true and
>> == false. AFAIU, currently, we only switch back from true to false when
>> an error happens. While I don't see a concrete issue with it, at least
>> it might be unexpected to users, so it better be documented.
>>
>> I'll try going with this approach, thanks!
>>
> 
> These flips are actually a problem. When using live-migration with disk
> mirroring, it's good that an actively synced image stays actively
> synced. Otherwise, migration could finish at an inconvenient time and
> try to inactivate the block device while mirror still got something to
> do which would lead to an assertion failure [0].

Hmm right. So, when mirror is actively-synced, we have to read the whole cluster from source to make an aligned write on target.

> 
> The IO test added by this series is what uses the possibility to sync to
> "diff images" which contain only the delta. In production, we are only
> syncing to a previously mirrored target image. Non-aligned writes are
> not an issue later like with a diff image. (Even if the initial
> mirroring happened via ZFS replication outside of QEMU).
> 
> So copy-mode=write-blocking would work fine for our use case, but if I
> go with the "mark clusters for unaligned writes dirty"-approach, it
> would not work fine anymore.
> 
> Should I rather just document the limitation for the combination "target
> is a diff image" and copy-mode=write-blocking?

Of course, simply documenting the limitation is better than implementing a new feature, if you don't need the feature for production)

> 
> I'd still add the check for the granularity and target cluster size.

Check is good too.

> While also only needed for diff images, it would allow using background
> mode safely for those.
> 
> Best Regards,
> Fiona
> 
> [0]:
> https://lore.kernel.org/qemu-devel/1db7f571-cb7f-c293-04cc-cd856e060c3f@proxmox.com/
> 

-- 
Best regards,
Vladimir


