Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69B4FD063C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 06:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0DTG-0002Tk-IG; Wed, 11 Mar 2026 02:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0DTC-0002TA-6o
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:55:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0DTA-0007I0-1w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 02:55:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 66D228078E;
 Wed, 11 Mar 2026 09:54:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ts98N82BqmI0-DHJKjk6M; Wed, 11 Mar 2026 09:54:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773212096;
 bh=aMbF5JRxzcnuaO7af54ecboZp0xEUOXgBuizk2+dpDw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ewzzVCjeDsX35CQ0ZAVk4+XAVx2A1sYgykvKn8fTbCkJv+qvpZ7NF6ZdXapjP125f
 TbE4bS5tjEKDhTT/ZgU3NeLWFq9vdHpjTovzIHNG7TuaHUlqyuDeZmp803109O3XP8
 9mrOcuHzTmTDmK9af4UyZba2EyaGtRp5CQB2dnyA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a2ff189b-b72d-4378-b5b5-3b99a06dd07d@yandex-team.ru>
Date: Wed, 11 Mar 2026 09:54:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/8] qapi: add local migration parameter
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, thuth@redhat.com, eblake@redhat.com, 
 farosas@suse.de, peterx@redhat.com, zhao1.liu@intel.com,
 wangyanan55@huawei.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
 <20260306213235.216863-4-vsementsov@yandex-team.ru>
 <87cy1biyeq.fsf@pond.sub.org>
 <f3ac4e30-60ee-42f6-99a8-d43f8e4c3587@yandex-team.ru>
 <87wlzjg14q.fsf@pond.sub.org>
 <76aff934-3740-4c95-9cd4-da458e7e29f7@yandex-team.ru>
 <87o6kvfzgx.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87o6kvfzgx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10.03.26 18:58, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 10.03.26 18:22, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> On 10.03.26 16:53, Markus Armbruster wrote:
> 
> [...]
> 
>>>>> This needs polish.  Let me try.
>>>>>
>>>>>      # @local: Enable local migration for devices that support it.  Backend
>>>>>      #     state and its file descriptors are then passed to the
>>>>>      #     destination in the migration channel.  The migration channel
>>>>>      #     must be a Unix domain socket.  Also needs to be enabled per
>>>>>      #     device by setting device property "local" to true.
>>>>
>>>> As discussed in v11, we don't want to require neither concrete property name
>>>> nor even the existence of such property, that why it was worded "may have an option".
>>>>
>>>> https://lore.kernel.org/qemu-devel/aZyS4UizvDq1Wnpq@x1.local/
>>> Scratch "by setting ..." then, and maybe replace "also" by "usually".
>>>
>>
>> so,
>>
>>    # @local: Enable local migration for devices that support it.  Backend
>>    #     state and its file descriptors are then passed to the
> 
> Perhaps "can then passed", to further emphasize the need for per device
> enabling.

Ok

> 
>>    #     destination in the migration channel.  The migration channel
>>    #     must be a Unix domain socket.  Usually needs to be enabled per
>>    #     device.
>>
>>
>> Sounds good to me. Will use it for v13, if no more comments.
> 


-- 
Best regards,
Vladimir

