Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F92FCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthWl-0003vH-B2; Wed, 03 Sep 2025 03:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthW6-0003qM-1Z
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:02:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthW4-0004rH-9V
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:02:49 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id DB465807D9;
 Wed, 03 Sep 2025 10:02:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i2a4da3Gla60-N7QvvhHQ; Wed, 03 Sep 2025 10:02:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756882965;
 bh=5rTRV48Q6/fEwBDT7/U7RJiPfmqYFsrf1qfIQNpQRlU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hQ5sKP1/8pjGPNI+LN8OFxUcgGiW+KlwgKjHsjQN2yVJ/e+gXzk7f+zyMnfEQj5C0
 6kDix722niGpbjZ+lOYwunWHwOmGojbvrm+bLf6SlmJ0/XiwGjkc5XsHpp066RsHed
 nE3mrYfMc+pkRuyad4QYYnkodmIrgqhavACGtPhc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <883a1b1a-0470-41d9-94aa-f20c3956d28d@yandex-team.ru>
Date: Wed, 3 Sep 2025 10:02:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] net/tap: net_init_tap_one(): move parameter
 checking earlier
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-6-vsementsov@yandex-team.ru>
 <CACGkMEsbnX5tqw_1RpKcfmg=0Q8bi2AgXsa+heps45XY1P3ObQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEsbnX5tqw_1RpKcfmg=0Q8bi2AgXsa+heps45XY1P3ObQ@mail.gmail.com>
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

On 03.09.25 07:18, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> Let's keep all similar argument checking in net_init_tap() function.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 58c3318b1c..3fe99ef63f 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -765,9 +765,6 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>>                          "vhost-net requested but could not be initialized");
>>               goto failed;
>>           }
>> -    } else if (vhostfdname) {
>> -        error_setg(errp, "vhostfd(s)= is not valid without vhost");
>> -        goto failed;
>>       }
>>
>>       return 0;
>> @@ -829,6 +826,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>           return -1;
>>       }
>>
>> +    if (tap->has_vhost && !tap->vhost && (tap->vhostfds || tap->vhostfd)) {
>> +        error_setg(errp, "vhostfd(s)= is not valid without vhost");
>> +        return -1;
>> +    }
> 
> So this doesn't deal with vhost force or is this expected to be
> applied on top of the deprecation of vhostforce?
> 

This patch doesn't modify existing logic. And deprecation doesn't modify logic in tap.c as well.
So, this series and deprecation may be applied in any order.

> 
>> +
>>       if (tap->fd) {
>>           if (tap->ifname || tap->script || tap->downscript ||
>>               tap->has_vnet_hdr || tap->helper || tap->has_queues ||
>> --
>> 2.48.1
>>
> 


-- 
Best regards,
Vladimir

