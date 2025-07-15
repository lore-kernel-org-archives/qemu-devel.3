Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20339C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhZI-0003ej-7t; Tue, 15 Jul 2025 11:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubh7e-0006aZ-Uy
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:59:15 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ubh7Z-00066M-PJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:59:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:d42b:0:640:f3fc:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EE1D460B06;
 Tue, 15 Jul 2025 17:58:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:41c::1:33] (unknown
 [2a02:6bf:8080:41c::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vwMtQ10Fu4Y0-vS8dI4tp; Tue, 15 Jul 2025 17:58:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1752591538;
 bh=o0WYKc7XJjy6+U/q2az16XpS+WvXBa+CmzRuo/MRbfc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=snH61+uqrsVPMMZp6gsKoru6mn4aQ1f8gwJH5vS0amXG+wrxcnigiWMGQHP5sqTQM
 IC8cRj1yetxF9tnBDb4OceQG32OSY753IIxWblV23KIgdUaUQuj3FXpAUiN0lfJ1Gf
 +N268N7dtwOzrVyzcTlHvKzhoXhSCg7mGEtrzQdk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0e1f766d-8fc6-4e69-90ae-28e15fd39d4b@yandex-team.ru>
Date: Tue, 15 Jul 2025 17:58:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tap: drop too small packets
To: Jason Wang <jasowang@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
 <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
 <40114688-ffc6-4f33-9928-a383d69c9320@yandex-team.ru>
 <CACGkMEt8cFEc_sv=TLcCARNjAUsQm6p=Hz_ihBy19yKk9DoZjA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEt8cFEc_sv=TLcCARNjAUsQm6p=Hz_ihBy19yKk9DoZjA@mail.gmail.com>
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

On 14.07.25 05:12, Jason Wang wrote:
> On Wed, Jul 9, 2025 at 10:43 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> On 07.07.25 06:49, Jason Wang wrote:
>>> On Thu, Jul 3, 2025 at 10:59 PM Daniil Tatianin
>>> <d-tatianin@yandex-team.ru> wrote:
>>>>
>>>> On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>
>>>>> Theoretically tap_read_packet() may return size less than
>>>>> s->host_vnet_hdr_len, and next, we'll work with negative size
>>>>> (in case of !s->using_vnet_hdr). Let's avoid it.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>> ---
>>>>>     net/tap.c | 5 +++++
>>>>>     1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/net/tap.c b/net/tap.c
>>>>> index ae1c7e39832..20d0dc2eb35 100644
>>>>> --- a/net/tap.c
>>>>> +++ b/net/tap.c
>>>>> @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
>>>>>                 break;
>>>>>             }
>>>>>
>>>>> +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
>>
>> Should it be better to s/</<=/ here? To skip size == s->host_vnet_hdr_len as well?
> 
> It would be better.
> 
> Thanks

Could you apply it in your branch? Or I can resend, if it is more convenient.

> 
>>
>>>>> +            /* Invalid packet */
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>>             if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
>>>>>                 buf  += s->host_vnet_hdr_len;
>>>>>                 size -= s->host_vnet_hdr_len;
>>>>
>>>> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>>
>>> Queued.
>>>
>>> Thanks
>>>
>>>>
>>>>
>>>
>>
>> --
>> Best regards,
>> Vladimir
>>
> 

-- 
Best regards,
Vladimir


