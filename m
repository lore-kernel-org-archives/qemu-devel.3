Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5928CC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk66o-00066v-BU; Wed, 15 Jul 2026 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk66m-00066i-Cf
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:21:32 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk66j-0002RQ-Nl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:21:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 41CB58087F;
 Wed, 15 Jul 2026 23:21:25 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id NLXXEq0a9eA0-zYta51z1; Wed, 15 Jul 2026 23:21:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784146884;
 bh=jbwA8VUJFzH/lmZsNRpsV5ympZkzgkLkNCb0igDgsAA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=tY0OXNrMnSf2li/4YGCMKcyBtUe2rxLBCwrXSZU0CwhkKHPiwZDkklyqs5158HPjw
 ijrmoJK3Pnln+pNPTrwVz4IcLG8pTh/ifePZvCBK9mc1hzrVsYIPAkO13xi7O1iGOL
 eAO25H7waa8JhRUgIUb5moq8tga1U+l+o1fL6vDc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
Date: Wed, 15 Jul 2026 23:21:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 jasowang@redhat.com, armbru@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, yc-core@yandex-team.ru, mark.caveayland@nutanix.com
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org> <ales0BaHaS0ZgA2d@redhat.com>
 <aleut_YyeS_YeYus@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aleut_YyeS_YeYus@x1.local>
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

On 15.07.26 19:00, Peter Xu wrote:
> On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
>> On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
>>>> On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> Here is a migration for TAP net backend, including its properties and
>>>>> open fds.
>>>>>
>>>>> With this new feature, management software doesn't need to initialize
>>>>> new TAP and do a switch to it. Nothing should be done around
>>>>> virtio-net in local migration: it just migrates and continues to use
>>>>> same TAP device. So we avoid extra logic in management software, extra
>>>>> allocations in kernel (for new TAP), and corresponding extra delay in
>>>>> migration downtime.
>>>>
>>>> This is quite a big patch set, - is this really worth the effort to do
>>>> all this just for *local* migration?  What's the possible use case for
>>>> this in real, - am I right this is just about upgrading the host qemu?
>>>> And with that in mind, isn't it sufficient to use what we already have
>>>> (namely, create new tap, start new qemu instance, and migrate the usual
>>>> way), and tolerate some very minor downtime while the networking code
>>>> learns the new network topology (isn't it happening almost instantly
>>>> anyway, and if not, the management can help by sending gratitious ARP)?
>>>>
>>>> I wonder what's the use for this at yandex?
>>>>
>>>> Thanks,
>>>>
>>>> /mjt
>>>
>>> Well just theoretically, imagine a big VM, reserving twice the amount
>>> of memory just to migrate is not nice at all.
>>
>> Don't we already have the ability to skip memory transfer by setting
>> the "x-ignore-shared" capability, assuming the VM RAM has a shared
>> memory backing.
> 
> Right, IIUC all similar single-host migrations like this series or CPR (or
> anything else...) should always need to enable x-ignore-shared in the first
> place.  That's almost always the starting point of optimizing local
> migrations.. no matter how the memory will be shared (by the same pool of
> page cache, or persisted over kexec, etc.).
> 

Yes, sharing RAM between source and target + enabling x-ignore-shared is a first thing to do.

This series optimizes TAP recreating. Not only skip recreating but also allow to
exclude cloud-networking component form live-update entirely, making the process
simpler (less components involved), and as I already said, reducing corresponding
downtime.

-- 
Best regards,
Vladimir

