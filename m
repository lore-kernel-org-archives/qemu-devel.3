Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA5CE9B340
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzud-0005jv-0O; Mon, 02 Mar 2026 04:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vwzua-0005j9-HF; Mon, 02 Mar 2026 04:50:00 -0500
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1vwzuW-0002sF-L8; Mon, 02 Mar 2026 04:49:59 -0500
Received: from [IPV6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57] (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 969E41520EF9;
 Mon, 02 Mar 2026 10:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1772444991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Awojc3NkWMpcjBTXSfVDQ9dEQkrxypPGzOzBTYurdL4=;
 b=UNJVPkw4ovEK8IAhlxeBYI60Gr8+GXUV8iK5VpwH29CV5tTJLRo/vKg0NI0phZMbJaLey6
 VDcrB0aHKBXtS/bGWJ6bMqta7O7CT1EkXg4tPTev1fM+VB9QzC9r3xJT4aP1XsiJgmGLD7
 eVBDmWEadZaD/GhmvW/R2s8f8j5R1X4F810NGAxb8EgMb85pgHfoF2EeXv16ZzejAlVaHu
 FWD1ifZCrow1vIfYW7EldmUKXwO24HvMGPquQc2ByVHUiaEeG7c/no59R/xJOjA5GU2dbS
 UmQTGaSrUqMeuuNuwJYzXSb4+7Sayb6XkFe6peLLxAfHSI2KgdRiJ0PNSH7lBg==
Message-ID: <adc4bc7a-2ac3-4e37-8041-fcff77d96e15@dupond.be>
Date: Mon, 2 Mar 2026 10:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mirror: Fix missed dirty bitmap writes during startup
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: Kevin Wolf <kwolf@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, dionbosschieter@gmail.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20260219202446.312493-1-kwolf@redhat.com>
 <46ff60a0-56c7-49f0-ae8f-6a26504409b9@proxmox.com>
 <aZ2ubi7GsYmGmcl2@redhat.com>
 <c9455331-0b32-47c2-8df4-e106db6d1622@dupond.be>
Content-Language: en-US, en-GB, nl-BE
In-Reply-To: <c9455331-0b32-47c2-8df4-e106db6d1622@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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


On 25/02/2026 13:32, Jean-Louis Dupond wrote:
>
> On 24/02/2026 14:58, Kevin Wolf wrote:
>> Am 20.02.2026 um 15:00 hat Fiona Ebner geschrieben:
>>> Am 19.02.26 um 9:25 PM schrieb Kevin Wolf:
>>>> @@ -1672,9 +1673,9 @@ bdrv_mirror_top_do_write(BlockDriverState 
>>>> *bs, MirrorMethod method,
>>>>           abort();
>>>>       }
>>>>   -    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
>>>> +    if (!copy_to_target) {
>>>>           qatomic_set(&s->job->actively_synced, false);
>>> Here, we must check that s->job is set for the qatomic_set().
>>>
>>> Other than that, the patch looks good to me, thanks!
>> Thanks, good catch. I'm squashing in this change:
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index abdffc6de86..fa1d975eb9f 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1677,7 +1677,9 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, 
>> MirrorMethod method,
>>       }
>>
>>       if (!copy_to_target) {
>> -        qatomic_set(&s->job->actively_synced, false);
>> +        if (s->job) {
>> +            qatomic_set(&s->job->actively_synced, false);
>> +        }
>>           bdrv_set_dirty_bitmap(s->dirty_bitmap, offset, bytes);
>>       }
>>
>> Can I add your R-b with this?
>>
>> Jean-Louis, do you want to give this patch a test if it still fixes your
>> problem? The approach is a bit different from what we tried initially.
> We are running our test case for +24hours now without any issue with 
> this patch included.
> I am currently rebuilding el9 qemu with this patch included to run on 
> our production machines that had this corruption.
> Let me come back in some days to fully confirm it's also fixed there :)
Everything stays stable (without corruption), after a lot of servers in 
backup already with the patch.
So therefor:

Tested-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>
>> Kevin
>>
> Thanks for the effort on this! Good to see this nasty issue getting 
> resolved! :)
>
> Jean-Louis

