Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1DCEF8FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpee-0002jM-K6; Wed, 04 Mar 2026 12:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxped-0002iw-AG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:04:59 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxpeY-0005d2-Ip
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:04:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2F80580825;
 Wed, 04 Mar 2026 20:04:48 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id l4sSH60AnKo0-pG22VvdX; Wed, 04 Mar 2026 20:04:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772643887;
 bh=faF4Y3EediB2ksFICPS1lZvJ1jTaEsMCrFVabggfFpw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GAP/yDhXkbhiHwl9msvusTJyxHJwH/UdI/sUmL7xHZf0ubnUFarwxzWIQPACQcuT/
 nruHeGn6PJmd9MFNN3B2QxUYX17R9/LFLWQwVeuecz+vYirFgPK09Ze5woYScwUpZX
 kV6J31HZSNWa+o72DXrIppWZBd0o7numJM32sgw8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <03ef8e5c-5610-4498-98cf-ba864bda9c91@yandex-team.ru>
Date: Wed, 4 Mar 2026 20:04:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] migration/savevm: move to new migration APIs
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-16-vsementsov@yandex-team.ru>
 <aacPXDprRcJPtGf1@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aacPXDprRcJPtGf1@x1.local>
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

On 03.03.26 19:42, Peter Xu wrote:
>> -                                 errp);
>> -        if (ret) {
>> -            return ret;
>> -        }
>> +    } else if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
>> +        return -EINVAL;
>>       }
> I understand you may prefer merging them whenever possible, but for things
> like this personally I normally keep "else" and "if" separate:
> 
>        if (!se->vmsd) {
>            vmstate_save_old_style(f, se, vmdesc);
>        } else {
>            if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
>                return -EINVAL;
>            }
>        }
> 
> "if" / "else if" can hid problems when we grow the condition in the future
> (I recall we hit one when reviewing the other series adding the _errp()
> variances).  That doesn't apply here but split "if" and "else" also helps
> slightly on readabilty for me,

Hmm I thought about that. But it seemed strange to me to keep

} else {
    if () {
    }
}


Now looking at the code after a while, first thought is "o, I'm doing something
wrong removing "else" branch, some cases may be lost!", some extra time is
needed to understand it.


What's not pretty with my code is that when we have some

if () {}

else if () {}

else if () {}

...

We expect that conditions are of the same type, and actions are in corresponding
{} bodies - a kind of smart switch-case. But this final "else if" has absolutely
another type of condition: it's actually an action. And that's why it's hard to
read it for me.

I'll follow your suggestion.


> so it says: there's no priority of doing
> old_style or vmsd_style, it's just that we support both with/without vmsd
> pointer, and it shows clearly what we do on which path.
> 
> I would expect the compiler will always generate the same byte code, but I
> didn't check.
> 
> No strong feelings.


-- 
Best regards,
Vladimir

