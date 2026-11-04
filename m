Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367BD606D82A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=C5W9GwZp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhrP-00088Q-Lq; Wed, 04 Nov 2026 15:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOhrG-00085d-6d
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:45:23 -0500
Received: from forwardcorp2e.mail.yandex.net ([93.77.172.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xOhrE-0000ZL-2C
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:45:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-66
 (mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net)
 by forwardcorp2e.mail.yandex.net (postfix) with ESMTPS id 129B5C00A7;
 Wed, 04 Nov 2026 23:45:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b97::1:12]
 by mail-nwsmtp-smtp-corp-main-66 with ESMTPSA id CjTB0u2hvCg0-KNLyXW1I;
 Wed, 04 Nov 2026 23:45:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1793825113;
 bh=1M6LUV7mrHLKnYkY8TM9nP2S9ZMAS0W6hEtEQz0S0fQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=C5W9GwZpIXwxJLulrP2/R3Li2vnNu1PgSf9y7yQUN7GhwmH2qbPTnrLdIg2bc9BNJ
 w14VVuX1iPMil2JjBRQIWyAgjQFcepgfm/pHMPwKzsRnhBN207ZdGMqjiTV/5LpRSh
 x4l407FcgSNJ0JX1X+1R4Kw9ELldfL2m9XIcXmeI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <569d4721-f56f-4fb8-8e0e-6049d10c1505@yandex-team.ru>
Date: Wed, 4 Nov 2026 23:45:12 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: skip tsc synchronization on shutdown
To: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260127201831.179237-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260127201831.179237-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=93.77.172.5;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2e.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping.

On 27.01.26 23:18, Vladimir Sementsov-Ogievskiy wrote:
> That doesn't make real sense, but may take much time when
> there are a lot of vCPUs. Let's just skip it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/i386/kvm/clock.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index aba6842a22..46efdbed14 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -207,7 +207,9 @@ static void kvmclock_vm_state_change(void *opaque, bool running,
>   
>           s->runstate_paused = runstate_check(RUN_STATE_PAUSED);
>   
> -        kvm_synchronize_all_tsc();
> +        if (!runstate_check(RUN_STATE_SHUTDOWN)) {
> +            kvm_synchronize_all_tsc();
> +        }
>   
>           kvm_update_clock(s);
>           /*


-- 
Best regards,
Vladimir

