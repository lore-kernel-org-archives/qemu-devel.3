Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A683C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7vy-0002l3-76; Fri, 15 Mar 2024 09:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rl7vv-0002jk-6v; Fri, 15 Mar 2024 09:49:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rl7vm-0008W3-VU; Fri, 15 Mar 2024 09:49:14 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:6c2d:0:640:316f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6004B61003;
 Fri, 15 Mar 2024 16:48:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b70d::1:34] (unknown
 [2a02:6b8:b081:b70d::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tmppvd7IbCg0-LLpYfkVr; Fri, 15 Mar 2024 16:48:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710510535;
 bh=7UYqzZlgDX6KYDDXVU/2pD5rQYBkgY9M/HjabE/RkbQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=J8d3NPOaDPDZwRRTWFOeMSUluhIGuuzjZuKycX0u5MnaViU8Q1AI7N0ZHOgfjbrK6
 CDqdbP60IA5U7C/CShvU4pa4K2WxPim1LH7fyChekAf7nuH+h1s78swxavaGuFNHRH
 zHyeizg2XIb8HySLUVyL5aqAbmYxwAuwYYZTUDfY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <403ec287-bddd-45ea-bf95-b15c6aff476b@yandex-team.ru>
Date: Fri, 15 Mar 2024 16:48:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
 <fd599353-5d83-46c7-938f-c5ff30c4b647@virtuozzo.com>
 <c9aa265d-9b3f-4504-a75b-31e08aef5c2f@yandex-team.ru>
 <711cd053-df5d-47e5-8562-367c437ad44c@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <711cd053-df5d-47e5-8562-367c437ad44c@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.03.24 12:55, Alexander Ivanov wrote:
> 
> 
> On 2/28/24 17:48, Vladimir Sementsov-Ogievskiy wrote:
>> On 09.02.24 15:29, Alexander Ivanov wrote:
>>> Could you please review the patch?
>>
>> Sorry for long delay.
>>
>> Honestly, I don't like refcnt in block-driver. It violate incapsulation, refcnt is interal thing of common block layer. And actually, you can't make any assumptions from value of refcnt, as you don't know which additional parents were created and why, and when they are going unref their children.
> Hmmm... Maybe I can just exclude refcnt check from the condition, can't I. If BDS will be removed it doesn't matter if we make it RO. What do you think?

Sounds good. I even don't see, why you need bdrv_chain_has_significant_parent() check. We just roll-back ro->rw transition on failure case, isn't just always correct thing to do?

>>
>> What was wrong with v2?
> My bad, it seems, I didn't send v2 before I decided to change the patch.

Hmm, somehow, I don't have it in my mailbox, but here it is: https://patchew.org/QEMU/20240109093128.157460-1-alexander.ivanov@virtuozzo.com/


===

More: in commit message you say about failure case. And it seems OK to roll-back ro->rw transition on failure, if we did it. But mirror_exit_common() called on success path too. I think, on success patch, we should do any additional reopenings?

-- 
Best regards,
Vladimir


