Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1B2C7115D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 18:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTPSl-000074-4g; Sun, 22 Jun 2025 14:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTPSf-00006P-IO
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 14:30:39 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTPSa-0007mB-RB
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 14:30:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-237e6963f63so5093605ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750617029; x=1751221829; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0I8b2xD576pIxbclpmezDVDv/+4+DeMTxXMw0keUAPU=;
 b=V0zRJTpYDik+fdAgWc5F+AsnSh8PNiAcEwEQqSm6VPBU3m3r4VnNTl/C6qO+yaiWhU
 o2eUBVjkKHr+xXwUjclsGvBQSM15neUK2VICeMf3k0sLhfeFPV9buSMTUoBmQ1BpSoVZ
 DNWXmmYWNsvUNl9BeIIJgN6b1YBHj2by4Q/6gBVNfHY74oUGgQE3fSkhHTvwsVHdbnR3
 d8VzpAfv/NUfBg/armkSymr/GP5bpNvLDPyHjxVVIlbzHJbJOYLIbsadWIq64jI1O2Ki
 OvrqlZsgSlG+3+F2hih5F+SLh67RRKEzVaqR7IuigPRIYUfm1kzuE1FevwACWIBav3+2
 ExXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750617029; x=1751221829;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0I8b2xD576pIxbclpmezDVDv/+4+DeMTxXMw0keUAPU=;
 b=hUs0o7HYVtQyDHR2ps4/JyTuoY4enH//qyFLvY4yVSvsbxSvno5jqbw4KhTPBf/LcE
 6oWmMh90tzvxeAg+o8vzdfhnZgC9V+tO39b3Zy9EGpBBfKhPvOddwMVWsq64nUjtZd5d
 W9hFHf+OeI47at7jCo2ieG4eLWdJ/y89enNT1gPnxx14kweDDWFzQ8R+GC1DYiU6D3VO
 SB+2Pvj35MXJwtmsN98gV3SlywLcD85iWbrJN65xAq2ePNAit5A9YiqTtXmeDxBBOKBY
 a6cwX1zVbUEl8yVScKSmMEdvum6gbhEQoSJHxbHaiPm8EURSKNlHkyNzRazSpwIXp50A
 yDjg==
X-Gm-Message-State: AOJu0YxhwH7hXl1w3WGpIZwmwnuxA6P2msWX6FQlnlyhgz2h30gOQUJC
 V7POgLKeHGdqwxznbgnzwCMQrECUfksVIAjahtivZYHVnXu1Imxvm8iZk1nc74uaDsw7E8k9ZrS
 FwDnSagA=
X-Gm-Gg: ASbGnctlX7yzIpCu2gdg1qCFDrlguq8FZVS1JuLR1eC2ziMMOcNpDOWLvUHK19b968j
 b46J01ZU5rANwCgvQJz0muRhZgUeduqsFWrFOOFFwBB8YyuMkh5GxrsahL7ECBlIqlhO4Nn3YLo
 TvqbHGu2pd/+GwmXHNEr8rZbh9RY/IF0YV+bCK+x+RX/bimScVerMNR3HWxfcXlRk+1dMYLFHEF
 +WFbsI/NVlu0TzgIjZW4QslF+xiPSv8Y1EZWkFJE3HhSezGv2RkU1QeaM4nu9gn0HmcG9yHtO77
 Q9gxP8nod53AB9kdDjP9lZ/6SCkUqGlPL8C6/5rJPD987r3i+ihL4JBUHejzFtmV4Y60u8ipcQl
 ma6I7kos5dGq5Qwo+o4reojtzMh5N
X-Google-Smtp-Source: AGHT+IEs6GklUV3HyT9WKzy9Kg2gF0D6aMCeA6tDWdX0Z3RAHSENewAqX4hlzvq/AJaOFgiX9qQc/g==
X-Received: by 2002:a17:902:fa4e:b0:237:d486:706a with SMTP id
 d9443c01a7336-237dc1d4c5emr108235655ad.48.1750617028902; 
 Sun, 22 Jun 2025 11:30:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86518b2sm64634895ad.152.2025.06.22.11.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 11:30:28 -0700 (PDT)
Message-ID: <75c1da85-d152-46bf-8e07-2dba0e6b3caf@linaro.org>
Date: Sun, 22 Jun 2025 11:30:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix SME vs AdvSIMD exception priority
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20250622175052.180728-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250622175052.180728-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/22/25 10:50, Richard Henderson wrote:
> We failed to raise an exception when
> sme_excp_el == 0 and fp_excp_el == 1.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 297064806e..427f029e28 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1494,7 +1494,8 @@ bool sme_enabled_check(DisasContext *s)
>        * to be zero when fp_excp_el has priority.  This is because we need
>        * sme_excp_el by itself for cpregs access checks.
>        */
> -    if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
> +    if (s->sme_excp_el
> +        && (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el)) {

One more fix: <=
SMEN is checked before FPEN in each block of CheckSMEEnabled().


r~

