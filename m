Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEF2F588EF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErPT-00010e-WE; Mon, 20 Apr 2026 12:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErPO-000108-O8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:23:39 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErPN-0003ya-5P
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:23:38 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 97E848063A;
 Mon, 20 Apr 2026 19:23:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:54b::1:34] (unknown
 [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id VNUiH20K34Y0-enXYpVUp; Mon, 20 Apr 2026 19:23:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776702214;
 bh=Zt+WdddVWvtD5+GFNCf5QI95AS+JHTENkFNj8nuU5Vs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1uB4IVtzhqKFtu1loMOSRlKmkeIqNPvkVm7dJvQ8CIp7RrpnjadMOnZnocU+mKEk/
 3t8HwFX94bS0/72HXk0kgb+PkkSxgMxSMq72ozc4c6PnkpU6/jvrj0NBgT9sAzUirl
 /dT6zu4I6YliFQr0ybycobmew+VFwDD+pvvtHScU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <224d780f-6dfe-498c-b66f-30037b08569c@yandex-team.ru>
Date: Mon, 20 Apr 2026 19:23:31 +0300
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
Received-SPF: pass client-ip=178.154.239.136;
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

ping4)

Hi! Any chance of this being merged?)

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

