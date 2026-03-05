Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003A9EEF30C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy2rt-00011r-PU; Thu, 05 Mar 2026 02:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vy2rs-00011c-0T; Thu, 05 Mar 2026 02:11:32 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vy2rp-0001Hh-Od; Thu, 05 Mar 2026 02:11:31 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id DE71A808C0;
 Thu, 05 Mar 2026 10:11:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b93::1:1] (unknown [2a02:6bf:8080:b93::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NBjeIF0AEW20-YhtfKJKG; Thu, 05 Mar 2026 10:11:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772694684;
 bh=oEMnPZ5RdNETdGxqaXUbBw3SiUABRO+n0rTDhXAZT3o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=u5L/As59hSrzp/gEa8AonB6gIYWyZD9d0htAnE2A1P2+to5e4ccK94647XgzZfZEv
 QgszYX39C826IAKdbnyi/UxZVu3efUdqqEbcjdgoaLlS+aXPe014/CQ6JGUi37XIOt
 fjyY6WHe2jTI0lNdYmLPPNlGnny1bGS3XeKLdwfU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <364d7cf8-560a-4e3f-b6b6-4a0d208ff023@yandex-team.ru>
Date: Thu, 5 Mar 2026 10:11:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix NULL pointer dereference in
 legacy-cache=off handling
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260305060431.30347-1-heifetz@yandex-team.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260305060431.30347-1-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On 05.03.26 09:04, Sergei Heifetz wrote:
> The check that xcc->model is not NULL occurs after it is dereferenced
> inside x86_cpu_get_versioned_cache_info(), so something like
> `-cpu host,legacy-cache=off` leads to a segfault rather than an error.
> This patch fixes that.
> 
> Fixes: cca0a000d06f897411a8a ("target/i386: allow versioned CPUs to specify new cache_info")
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   target/i386/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 01b64940b1..00645e1149 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10023,8 +10023,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>   
>       /* Cache information initialization */
>       if (!cpu->legacy_cache) {
> -        const CPUCaches *cache_info =
> -            x86_cpu_get_versioned_cache_info(cpu, xcc->model);
> +        const CPUCaches *cache_info = xcc->model
> +            ? x86_cpu_get_versioned_cache_info(cpu, xcc->model)
> +            : NULL;
>   
>           if (!xcc->model || !cache_info) {
>               g_autofree char *name = x86_cpu_class_get_model_name(xcc);

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

