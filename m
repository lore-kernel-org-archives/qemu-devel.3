Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E6CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFNi-0003DE-MO; Tue, 21 Oct 2025 12:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBFNh-0003D1-AX; Tue, 21 Oct 2025 12:38:41 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBFNe-0004X6-Pn; Tue, 21 Oct 2025 12:38:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E9C3888CA7;
 Tue, 21 Oct 2025 19:38:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4c::1:32] (unknown
 [2a02:6bf:8080:a4c::1:32])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WcZ3D40IwKo0-DZHAH6pN; Tue, 21 Oct 2025 19:38:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761064713;
 bh=+M2yk5pjMGJqz0H0XPVQIoVi13xyqkfCBglhuqHKhTU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=u89vb2JwX0HBwNLGfQBbDigxpKEJlvhfQ/imD6DVJvaGHonOjhP4gPZMkbbgmyGZL
 fVn1sHISig7ydLlpzFaDWSRqa3qe490Y7Uss0z+hYPWBc3VOKz22m2vUt7nIsBHxXE
 F/w4pYCqMkhiNbgXFHkkgWVL78Tpb6a6j37uIuJc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4d0b7502-831d-4a92-bf92-c503b81b7902@yandex-team.ru>
Date: Tue, 21 Oct 2025 19:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/25] vhost-user-blk: support vhost backend migration
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Cc: raphael@enfabrica.net, pbonzini@redhat.com, farosas@suse.de,
 mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
 <20251016114104.1384675-25-vsementsov@yandex-team.ru>
 <CAFubqFsNxUxg5c=4j2D3RFHT-E=EvLfjvJ4jV7HYu0mZE+WTPw@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFubqFsNxUxg5c=4j2D3RFHT-E=EvLfjvJ4jV7HYu0mZE+WTPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 21.10.25 02:53, Raphael Norwitz wrote:
> Overall looks ok. A couple comments
> 
> On Thu, Oct 16, 2025 at 7:49 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Opt-out backend initialization code, and instead get the state
>> from migration channel (including inflight region).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   hw/block/vhost-user-blk.c          | 129 ++++++++++++++++++++++++-----
>>   include/hw/virtio/vhost-user-blk.h |   2 +
>>   include/hw/virtio/vhost.h          |   3 +-
>>   3 files changed, 111 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index ffdd600526..a8fd90480a 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -17,6 +17,7 @@
>>    */

[..]

>> @@ -656,6 +680,64 @@ static const VMStateDescription vmstate_vhost_user_blk = {
>>       },
>>   };
>>
> 
> Rename vhost_user_blk_needed()?

Yes, will fix

> 
>> +static bool vhost_user_needed(void *opaque)
>> +{
>> +    return migrate_local_vhost_user_blk();
>> +}
>> +
>> +static const VMStateDescription vmstate_vhost_user_blk_device = {
>> +    .name = "vhost-user-blk-device",
>> +    .version_id = 1,
>> +    .needed = vhost_user_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_BACKEND_TRANSFER_CHARDEV(chardev, VHostUserBlk),
>> +        VMSTATE_BACKEND_TRANSFER_VHOST_INFLIGHT(inflight, VHostUserBlk),
>> +        VMSTATE_BACKEND_TRANSFER_VHOST_USER(dev, VHostUserBlk),
>> +        VMSTATE_BACKEND_TRANSFER_VHOST(dev, VHostUserBlk),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};

[..]

>> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
>> index a10f785672..b06f55fd6f 100644
>> --- a/include/hw/virtio/vhost-user-blk.h
>> +++ b/include/hw/virtio/vhost-user-blk.h
>> @@ -52,6 +52,8 @@ struct VHostUserBlk {
>>       bool started_vu;
>>
>>       bool skip_get_vring_base_on_force_shutdown;
> 
> Why do we need incoming_backend? Looks like it is unused.
> 

Oops right. Forget to delete, it was used in v1.

> 
>> +
>> +    bool incoming_backend;
>>   };
>>
>>   #endif


Thanks a lot for reviewing!

-- 
Best regards,
Vladimir

