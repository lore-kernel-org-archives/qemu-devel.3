Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C83C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk7p8-00061n-0K; Wed, 15 Jul 2026 18:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk7p2-00061X-Ae
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:11:20 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk7ov-0000Hv-Lh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:11:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id D968B80F94;
 Thu, 16 Jul 2026 01:11:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 6BZP7m0avKo0-gtwIdNNm; Thu, 16 Jul 2026 01:11:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784153467;
 bh=iculN3Gz99KM+7Q3JAvCA050/w2iC716QPbyVqyYNho=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VYvs9TCMjl+SzM1W0Nv29Z6Iw3hMftd1fm1HNCY+nKtvR04XctPW/faNBimrljFZr
 OWRG8i8TkDSwCoYFOBsnVrB2BO9Xe7yxBuzkD+EO5nCSuRggRgVtxIQ7G8tir8UAeg
 sxLoYpYS8frUdCH3JpfV+T8G/8zlWExVmUk7MOTA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d62fa0f5-4339-49e1-aeef-85196561a94e@yandex-team.ru>
Date: Thu, 16 Jul 2026 01:11:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 jasowang@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, yc-core@yandex-team.ru, mark.caveayland@nutanix.com
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org> <ales0BaHaS0ZgA2d@redhat.com>
 <aleut_YyeS_YeYus@x1.local>
 <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
 <20260715163116-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260715163116-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 15.07.26 23:32, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2026 at 11:21:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.07.26 19:00, Peter Xu wrote:
>>> On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
>>>> On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
>>>>> On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
>>>>>> On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Hi all!
>>>>>>>
>>>>>>> Here is a migration for TAP net backend, including its properties and
>>>>>>> open fds.
>>>>>>>
>>>>>>> With this new feature, management software doesn't need to initialize
>>>>>>> new TAP and do a switch to it. Nothing should be done around
>>>>>>> virtio-net in local migration: it just migrates and continues to use
>>>>>>> same TAP device. So we avoid extra logic in management software, extra
>>>>>>> allocations in kernel (for new TAP), and corresponding extra delay in
>>>>>>> migration downtime.
>>>>>>
>>>>>> This is quite a big patch set, - is this really worth the effort to do
>>>>>> all this just for *local* migration?  What's the possible use case for
>>>>>> this in real, - am I right this is just about upgrading the host qemu?
>>>>>> And with that in mind, isn't it sufficient to use what we already have
>>>>>> (namely, create new tap, start new qemu instance, and migrate the usual
>>>>>> way), and tolerate some very minor downtime while the networking code
>>>>>> learns the new network topology (isn't it happening almost instantly
>>>>>> anyway, and if not, the management can help by sending gratitious ARP)?
>>>>>>
>>>>>> I wonder what's the use for this at yandex?
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> /mjt
>>>>>
>>>>> Well just theoretically, imagine a big VM, reserving twice the amount
>>>>> of memory just to migrate is not nice at all.
>>>>
>>>> Don't we already have the ability to skip memory transfer by setting
>>>> the "x-ignore-shared" capability, assuming the VM RAM has a shared
>>>> memory backing.
>>>
>>> Right, IIUC all similar single-host migrations like this series or CPR (or
>>> anything else...) should always need to enable x-ignore-shared in the first
>>> place.  That's almost always the starting point of optimizing local
>>> migrations.. no matter how the memory will be shared (by the same pool of
>>> page cache, or persisted over kexec, etc.).
>>>
>>
>> Yes, sharing RAM between source and target + enabling x-ignore-shared is a first thing to do.
>>
>> This series optimizes TAP recreating. Not only skip recreating but also allow to
>> exclude cloud-networking component form live-update entirely, making the process
>> simpler (less components involved), and as I already said, reducing corresponding
>> downtime.
>>
>> -- 
>> Best regards,
>> Vladimir
> 
> So can you explain, how is this better than
> 1. a persistent tap

You mean open same tap device both on source and target?

This will require some additional steps anyway, to avoid packet loss,
like keeping queues disabled on target until post_load.

Another thing is MAX_TAP_QUEUES=256 in kernel: this is a problem, if you have more
than 128 queues already opened on source. Seems cleaner just pass already opened
queues to the target.

And finally, on hosts with many CPUs, TAP queue allocate noticeable amount
of RAM, so having x2 queues during migration would be an overhead.

> 2. a non persistent tap that some server gets a hold of

You mean, just pass FDs externally, instead of using QEMUs migration stream?
That's possible. But requires mgmt tool to store (or get from source) and pass
these FDs. Requires mgmt to even know about these FDs. But why? QEMU already
can pass FDs through migration for vfio devices (CPR), why is TAP worse?

Like with persistent tap, it will require some changes in Qemu anyway, to avoid packet loss
(like patch 12/15 here).

> 
> IOW why does qemu need to bother.

QEMU owns the TAP fd and has full knowledge of its state. Pushing this responsibility
to an external tool means the tool needs to understand QEMU internals just to pass
an fd that QEMU already has. I think, that's a worse separation of concerns.

Of course, there are other ways to do TAP local migration. But looking at wider
picture, where we want to migrate not only TAP, but also vfio devices (already
implemented as CPR migration, but may be updated to use similar approach as in
this series, to use one migration channel), vhost-user-blk (my another series
in flight) and vhost-user-fs (not yet published), vhost-vsock migration
("[PATCH v3 0/7] migration/cpr: support vhost-vsock devices" in flight series),
it seems a good generic approach: simply pass backends (including open FDs) to
the target, not involving mgmt. Qemu has full knowledge about these FDs and
owns the whole state. Migrating them in QEMU looks correct for me.

-- 
Best regards,
Vladimir

