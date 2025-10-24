Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B2ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDNF-0003Np-D8; Fri, 24 Oct 2025 04:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vCDN9-0003Nc-RV
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:42:07 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vCDN7-00067L-R7
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:42:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B951480867;
 Fri, 24 Oct 2025 11:42:01 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:d2ca:5878:b4a3:44a5] (unknown
 [2a02:6bf:803e:400:d2ca:5878:b4a3:44a5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0gUdph0FoeA0-De5F2Nv5; Fri, 24 Oct 2025 11:42:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761295321;
 bh=CR00evPpXnEnZEFGGBhirzbMQa+GpyEZfwE9GomxIt4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GFZnP5vduK7arguWmirUCo9vtDsaf8A8VSvCtSqeMPsmi3a4XdxNULJPQHcHV7PYw
 sd5+exEEEYKKZOqpDlQvzwF/usfLfnojpG7PZqWXBuWfxzLjG358zZzikOlO0cKmsS
 2Q6XLLiN+rtHnrvaHcWWpqwzPMY6eG25ZXciBeGc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8a3cffb7-0454-4ba4-9804-f9971a025f29@yandex-team.ru>
Date: Fri, 24 Oct 2025 13:42:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <878qh599tc.fsf@pond.sub.org>
 <d6cf9c5e-52da-49b8-ba39-2909a00f28eb@yandex-team.ru>
 <87frbd6bi7.fsf@pond.sub.org> <aPqA1H1NwRqH3Hlb@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aPqA1H1NwRqH3Hlb@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 10/24/25 00:24, Peter Xu wrote:
> On Mon, Oct 20, 2025 at 01:47:12PM +0200, Markus Armbruster wrote:
>> Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:
>>>> [...]
>>>>
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index be0f3fcc12..c9fea59515 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -517,9 +517,13 @@
>>>>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>>>>   #     such as a file.  (since 9.0)
>>>>>   #
>>>>> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
>>>>> +#    region for vhost-user-blk.  (since 10.2)
>>>>> +#
>>>> Any guidance why and when users would want to enable it?
>>>>
>>>> Is it a good idea to have device-specific capabilities?
>>> Hmm, maybe it's better way to make a parameter for the vhost-user-blk instead of migration capability?
>>>
>>> What do you think?
>> I think this is a question for the migration maintainers :)
> Oops, I missed this email previously..
>
> We discussed similar things with Vladimir on virtio-net.  Unless extremely
> necessary, we should avoid adding any cap into migration that is relevant
> to a specific device.  Yes, per-device is better..
>
> Thanks,
Arlight, thanks!


