Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9BBC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOB4e-0004hk-Qz; Mon, 01 Jul 2024 03:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOB4c-0004gr-PW; Mon, 01 Jul 2024 03:03:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOB4a-0003mY-MI; Mon, 01 Jul 2024 03:03:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2D09960BE8;
 Mon,  1 Jul 2024 10:03:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6415::1:19] (unknown
 [2a02:6b8:b081:6415::1:19])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id U3PdrW1IeKo0-aunL961Z; Mon, 01 Jul 2024 10:03:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719817411;
 bh=KuBzGXqinD1kMSPdBAZWnaVRN1s/LYFcKiSXynpmdQ4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lxuYuPP8G8HjM5WUiyURbWmNhHQfewcmdCSl8iqG5wtbtrzxO6bw9XaiqH5gC3aGi
 m5WA5cwya13BVwgg1QVW0ulrMYV3ydL//mkAjpGrgQqQaqK45/uWFbvQnoBXNJIHe5
 TXdJ7/pFdYQ5F6vRkyIW1tc5UKrcX2spQzYO/gk4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <364d71ab-6852-45ed-81be-5121c44f746d@yandex-team.ru>
Date: Mon, 1 Jul 2024 10:03:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: rewrite http header parsing function
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-trivial@nongnu.org
References: <20240629142542.1086076-1-mjt@tls.msk.ru>
 <ead01cd7-80d7-4cfd-9b20-8417681fb3b8@yandex-team.ru>
 <7f5753b1-16f3-49d8-9394-7fe85286777a@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7f5753b1-16f3-49d8-9394-7fe85286777a@tls.msk.ru>
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

On 01.07.24 09:55, Michael Tokarev wrote:
> 01.07.2024 09:54, Vladimir Sementsov-Ogievskiy wrote:
> 
>>> +    const char *t = "accept-ranges : bytes "; /* A lowercase template */
>>
>> Note: you make parser less strict: you allow "bytes" to be uppercase (was allowed only for accept-ranges", and you allow whitespaces before colon.
> 
> Yes, exactly.
> 
> I should add this to the description (wanted to do that but forgot).
> I'll update the patch (without re-sending) - hopefully its' okay to
> keep your S-o-b :)
> 

Of course!

-- 
Best regards,
Vladimir


