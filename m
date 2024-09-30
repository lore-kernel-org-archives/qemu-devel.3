Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3DDCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCf5-00069W-Pi; Mon, 30 Sep 2024 05:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svCf2-0005yl-Vm; Mon, 30 Sep 2024 05:25:44 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svCf0-0006NI-El; Mon, 30 Sep 2024 05:25:44 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:1301:0:640:a2b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1EADB60D30;
 Mon, 30 Sep 2024 12:25:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b737::1:2c] (unknown
 [2a02:6b8:b081:b737::1:2c])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aPVMAE1IWKo0-jEv0KO1r; Mon, 30 Sep 2024 12:25:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727688336;
 bh=yNd2tEXVFldbPpGa92EU28elQt4tdL/SOMDRSmaK1qA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vBKQJ+zNBX1x9Jbv8603UwNUae+AbqWED/5PFZKye0V33I4qnruM509HMEVwGaOeJ
 cKZcKqxz6k19lH4Rm8yM99burRtTv7+zFUUZrVatwtof26MwwPwuJmxfLVqLborKOB
 qZrZkGTZP+O5RktRE7LdLfhaIa/frep+K2eM9HHg=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6fb3340a-f685-422f-acaf-ad968e854847@yandex-team.ru>
Date: Mon, 30 Sep 2024 12:25:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report][RFC PATCH 1/1] block: fix failing assert on paused
 VM migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eesposit@redhat.com, den@virtuozzo.com, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20240924125611.664315-1-andrey.drobyshev@virtuozzo.com>
 <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240924125611.664315-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
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

[add migration maintainers]

On 24.09.24 15:56, Andrey Drobyshev wrote:
> Instead of throwing an assert let's just ignore that flag is already set
> and return.  We assume that it's going to be safe to ignore.  Otherwise
> this assert fails when migrating a paused VM back and forth.
> 
> Ideally we'd like to have a more sophisticated solution, e.g. not even
> scan the nodes which should be inactive at this point.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 7d90007cae..c1dcf906d1 100644
> --- a/block.c
> +++ b/block.c
> @@ -6973,7 +6973,15 @@ static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
>           return 0;
>       }
>   
> -    assert(!(bs->open_flags & BDRV_O_INACTIVE));
> +    if (bs->open_flags & BDRV_O_INACTIVE) {
> +        /*
> +         * Return here instead of throwing assert as a workaround to
> +         * prevent failure on migrating paused VM.
> +         * Here we assume that if we're trying to inactivate BDS that's
> +         * already inactive, it's safe to just ignore it.
> +         */
> +        return 0;
> +    }
>   
>       /* Inactivate this node */
>       if (bs->drv->bdrv_inactivate) {

I doubt that this a correct way to go.

As far as I understand, "inactive" actually means that "storage is not belong to qemu, but to someone else (another qemu process for example), and may be changed transparently". In turn this means that Qemu should do nothing with inactive disks. So the problem is that nobody called bdrv_activate_all on target, and we shouldn't ignore that.

Hmm, I see in process_incoming_migration_bh() we do call bdrv_activate_all(), but only in some scenarios. May be, the condition should be less strict here.

Why we need any condition here at all? Don't we want to activate block-layer on target after migration anyway?

-- 
Best regards,
Vladimir


