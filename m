Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2779DC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 20:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk6Wd-0005Mj-7X; Wed, 15 Jul 2026 16:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk6Wb-0005MN-UK
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:48:13 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wk6WY-0006MT-LR
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 16:48:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 1637F80884;
 Wed, 15 Jul 2026 23:48:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d6a::1:11] (unknown
 [2a02:6bf:8080:d6a::1:11])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 2mX3qi0aFGk0-supeRClO; Wed, 15 Jul 2026 23:48:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784148483;
 bh=gqP1vtDynADVHigNJ64aj9nGru6tz2quq5l3wnrAI0I=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=T6hA36ifocy3pL/aV0Zfpn5++iOkA3c2r4YXePUZHLJ0YTSKuQzgbLsAsTeh06Snw
 gqITt3TyCIGMqG8JwxwDqkc20HxBxIcFLMJ1xTB92GgeGJttOLDSuK4kaNzfcXhzN4
 OX1Umv2rmjcE3yTJHY7yytFcJiQNtIQjU4xIyMkM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4e406518-2668-497e-80cd-9b50db8dfa21@yandex-team.ru>
Date: Wed, 15 Jul 2026 23:48:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com, armbru@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru, mark.caveayland@nutanix.com
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <7453c24d-7daf-4dfb-9e16-0d6f4e1f6d76@yandex-team.ru>
 <20260715161756-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260715161756-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

On 15.07.26 23:20, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2026 at 11:10:28PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 15.07.26 18:01, Michael Tokarev wrote:
>>> On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> Here is a migration for TAP net backend, including its properties and
>>>> open fds.
>>>>
>>>> With this new feature, management software doesn't need to initialize
>>>> new TAP and do a switch to it. Nothing should be done around
>>>> virtio-net in local migration: it just migrates and continues to use
>>>> same TAP device. So we avoid extra logic in management software, extra
>>>> allocations in kernel (for new TAP), and corresponding extra delay in
>>>> migration downtime.
>>>
>>> This is quite a big patch set,
>>
>> You probably haven't been following Steve's work (about 5 years) on
>> CPR Live Update :) My patch set is small.
>>
>>> - is this really worth the effort to do
>>> all this just for *local* migration?  What's the possible use case for
>>> this in real, - am I right this is just about upgrading the host qemu?
>>
>> Exactly. You say "just for", but actually local migration is a lot more
>> "massive" operation for us. Remote migrations are done mostly to release the
>> physical server for service/redeploy (you should first migrate all the
>> vms to other servers).  That's a relatively seldom operation.
>>
>> On the contrary, when updating to new QEMU version, you migrate _all_
>> vms on _all_ servers.  These (minimal) downtimes affects all the
>> customers, some are sensitive to freezes.
>>
>>> And with that in mind, isn't it sufficient to use what we already have
>>> (namely, create new tap, start new qemu instance, and migrate the usual
>>> way), and tolerate some very minor downtime while the networking code
>>> learns the new network topology (isn't it happening almost instantly
>>> anyway, and if not, the management can help by sending gratitious ARP)?
>>>
>>> I wonder what's the use for this at yandex?
>>>
>>
>> This series together with similar about vhost-user-blk local migration
>> gives several times win in freeze-time. It's significant for us.
>>
>> -- 
>> Best regards,
>> Vladimir
> 
> 
> I believe it is.
> But let's focus on what exactly are we saving here.
> It is not that clear.
> 
> Is it the overhead of tap losing state such as
> bridge forgetting the tap mac. Or what?
> 

I don't have a full expertize here, but the overhead is in switching
to a new TAP in our cloud virtual networking component. Could this
switching be optimized, to always work very fast? That's a good
question that I don't have an answer to. Probably yes.

We decided to go another way: drop extra components from the process,
and avoid any extra switching at all. Both cloud networking component, and
storage (with vhost-usr-blk live-udpate series) don't even know, that
QEMU is migrating. That seems to be a clear design for local migration,
and shows good results.

-- 
Best regards,
Vladimir

