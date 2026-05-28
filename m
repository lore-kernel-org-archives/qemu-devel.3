Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E3CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScuK-00065t-6z; Thu, 28 May 2026 11:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScuI-00065d-4p
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:44:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wScuG-00045m-Fq
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:44:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4904fd4f6aeso51999845e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779983062; x=1780587862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uLKsokfzDW4KWcdI2ERTgmE3Ei3RvM52HI2PQd0sdVM=;
 b=jAKv/cf9INGpIa5ZJR1i0r7t8psUjObL61pM2jAS75K6PazH2bIRxGJGDNb0BifiTX
 fYtMSlqStwS7nv7KeafeUHSyj1Yx3Z074HjE5PbebP1lsWuko3T6QHEOq9PXAj9VhBDv
 7VPcki2+CnWBc21XPPgX3XJDQabQcN2bndTSPx7Q+KnfUYtwAQKJOFAXdvjzCPgTmYAq
 e4Gdr0gUhgijJUKOfBXpziJNUHSGwjzAFnqPHOqf+hoZrI2rc8IMmLvE2kfWBAjkOfDO
 1ifokPY1QlXNbv6NpszbxOXqrRc4a1/qQasJ8ynnsU9uRF4DcB12vMz31mMCJs8EC0ox
 pIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779983062; x=1780587862;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uLKsokfzDW4KWcdI2ERTgmE3Ei3RvM52HI2PQd0sdVM=;
 b=XLsL+lAi+ZIgtKPCgF+DED2YLNVASxdcwR0cfpv76X0Fzf/gArazAyN4+YiImHDElB
 wCtwZSQ2pUu1tLXkhpw920qbViFO7RKfOcRRca0n7YW9taYiWUt/2zRu/M2woJHZKofO
 6RPKvaUgShUJhA+7qZPxxjjTmhfjjLJatog+IF8XRmIvDNleiAP/Djr9GqDvvbfshV3Q
 yidrb0HOzsCvY9Q4tADpkcpnFPjqLx/2Ge1GwtEDPPbeBFZCJWN+XjhEp9AmJtLQnVzq
 zgjFr7bF+rUET8RCV0wwfZ112d9IJa0kbqmaUwKFTtNy77qS6LFPwrPXNmgCwP1XNiKR
 izJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sgwiz8tq63Da7Y6+LXO902RhnD6jBgqQ3Ro4+174RNslY8nW0ThJCNyJsujRnzSkMDvBqmtw5SgbS@nongnu.org
X-Gm-Message-State: AOJu0YwXzJtezxYYSb5OWeJJV4dfJilPXCf+I8fJHEZVQsrjSq5lwcZW
 ckMkgCNZlUe5Z9Rmro7UVkI2BEPJKcllbWQ7u1wHkNwEPhPAMSSqMJoEcbDTlf6Jk1Q=
X-Gm-Gg: Acq92OHrZS2sMUdsus4gU4qFpuemOwk733WlccD+3gINs+zgseoEpGU/l/B3hgqPPon
 jwkCYPafSxMDPrfamnjS3f8z3K/d6QEhKrfNOK/AZUQkwUyT0+A7KbAlwIX3oVY4TC04vP2bgNx
 pgySBdinq/vxBRZ6B0lusJJBdvVDuERA+exjew5Hl8nsH1T/fvgyG4+TLoqw+no1fORDEqhh2/5
 acg6ivfCCBL7rG3/PrIdrvCR+MSZYFe578F741ObHVB9eZPuPG7uFZjJXDtISv0/bn4KS4WLWft
 vOIbki9vwkgZoL6WXBbs9L4wq+6ESiNFMbNWOgl9hid3rzthx6AWroKR0j2L7f9dPzI/v3a95QC
 +095zlPFWbqH3hj4krXlaCyCWl3IzDcHTi3nZHn8lt4lVXzFthCYSWhh5oOsMGBaeYrmyUJONRO
 QYcZyznCRmIbuvlo7Ko4W6m0Ksl7cIC3uFCF1zltT8BD06p8sAJqyEwBaXHAt8iuentaLSYPYI5
 lgh
X-Received: by 2002:a05:600c:4510:b0:48f:d5d7:df63 with SMTP id
 5b1f17b1804b1-490428dfd36mr443161975e9.27.1779983062240; 
 Thu, 28 May 2026 08:44:22 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908ecb9ef9sm16908685e9.26.2026.05.28.08.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 08:44:21 -0700 (PDT)
Message-ID: <b8b50493-36e2-4d8e-ae06-cfdd1ce6f013@linaro.org>
Date: Thu, 28 May 2026 17:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: fix missing spaces in screendump help text
To: Brian Knutsson <development@knutsson.it>, qemu-devel@nongnu.org
References: <20260410151818.817298-1-development@knutsson.it>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410151818.817298-1-development@knutsson.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Brian,

On 10/4/26 17:18, Brian Knutsson wrote:
> From: Knutsson Development <development@knutsson.it>
> 
> Signed-off-by: Knutsson Development <development@knutsson.it>

Did you meant ' Brian F. Knutsson <development@knutsson.it>' here?

Anyhow, patch queued, thanks.

> ---
>   hmp-commands.hx | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5cc4788f12..b6f3b8a796 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -257,8 +257,8 @@ ERST
>           .name       = "screendump",
>           .args_type  = "filename:F,format:-fs,device:s?,head:i?",
>           .params     = "filename [-f format] [device [head]]",
> -        .help       = "save screen from head 'head' of display device 'device'"
> -                      "in specified format 'format' as image 'filename'."
> +        .help       = "save screen from head 'head' of display device 'device' "
> +                      "in specified format 'format' as image 'filename'. "
>                         "Currently only 'png' and 'ppm' formats are supported.",
>            .cmd        = hmp_screendump,
>           .coroutine  = true,


