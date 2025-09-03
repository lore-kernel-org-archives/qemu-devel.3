Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0496DCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthzr-0004MQ-L8; Wed, 03 Sep 2025 03:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthzq-0004Lu-Df
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:33:34 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uthzo-0005eR-9b
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:33:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:90aa:0:640:b805:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5C719C0165;
 Wed, 03 Sep 2025 10:33:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QXaaRY2GoiE0-rtyrwMGe; Wed, 03 Sep 2025 10:33:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756884806;
 bh=KPyLUh7VUiABwgDjq4yRMACg/1YdzyIKA+Xvk6c8CxY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0PM4KpH60f5FJAbvdUN9LFREBZM1W7JA6fULeVN2LbJD/+ouxCpYgqeVAfMyZaCmD
 doCzKIhZq+5+3gJJCw2PwLxgPe7Zc+NNi55VW8fVk4zAsTuhx9gF/Lxgy+XKvpnvkC
 FnqzPwNn1Inio+Dh0c3ldRDMzGneXcLXtVPiJfmU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <082d7740-e77a-47a0-9741-4ad6358a0a2a@yandex-team.ru>
Date: Wed, 3 Sep 2025 10:33:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/20] net/tap: refactor net_tap_init() into
 net_tap_open_one()
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <20250823160323.20811-15-vsementsov@yandex-team.ru>
 <CACGkMEsWa62Su9jP7-swP9t4WjTfoNG9UoqG7_KHtoha4_WR+g@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEsWa62Su9jP7-swP9t4WjTfoNG9UoqG7_KHtoha4_WR+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 03.09.25 08:36, Jason Wang wrote:
> On Sun, Aug 24, 2025 at 12:03 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> net_tap_init() is used in one place. Let's move net_init_tap_one()
>> call to it and simplify outer loop code.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 54 +++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 83a1c9250a..57939ed16f 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -674,31 +674,37 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>>       return 0;
>>   }
>>
>> -static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
>> -                        const char *setup_script, char *ifname,
>> -                        size_t ifname_sz, int mq_required, Error **errp)
>> +static int net_tap_open_one(const Netdev *netdev,
>> +                            const char *name, NetClientState *peer,
>> +                            const char *script, const char *downscript,
> 
> I'd stick to "setup_script" as we have "downscript".

I decided to rename, because in other places the variable is called script, and the original option is also script=.

It would be more correct to rename in a separate commit. I can do this in v2, or just add a not to commit message here.

> 
> And we can save several lines of changes.
> 
> The rest looks good.
> 
> Thanks
> 

Thank you for reviewing!


-- 
Best regards,
Vladimir

