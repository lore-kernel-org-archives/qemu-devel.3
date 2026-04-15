Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903A3F531E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCwAF-0001st-S8; Wed, 15 Apr 2026 05:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCwAD-0001s4-Ta
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:04:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCwAC-0008GD-Ei
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:04:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so4050677f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776243838; x=1776848638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08ibk2THlU+RKclf2uoZTy9mDuqcett2w1CO4buhgfg=;
 b=lhf/YQ3o6w2GMONK8fY9Jd1bqmxsIYfJx2r98vpdJBYOQvnVLSdjDNVDsCNIBDQuse
 KgHonpYOfxERaD+iWcyr5rjMaoNe68elCD5/YFFHEWegtFAjQ+5yJoLdWZZsxA6Xk/wC
 +5kyVX3IRwbMIX/T2vE95SFpEDUsL/hN0Vl6qRiYcZBHTwS3bvjFI4JrvNr4kRyQGsqy
 Dr+l8aQrxgOQPh7U+dVOvxwdetTOLTKSwoPNQQmDsMhFqJ0g/1xzkZIX0Putox09LvwI
 7wNmiNlgNguqbtdebAYBFmeO9ehqXhDaqC31qqRH8gAIc2URzUwE/PeBNS0pTY4SnO5T
 91TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776243838; x=1776848638;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08ibk2THlU+RKclf2uoZTy9mDuqcett2w1CO4buhgfg=;
 b=JqA3rAhZnWKpDt4RPgxajWmLZko81BqnMffbyo4KN3Kpkh/dYu51h0rn/oIAgcCc8U
 y6g79Uf+6CBVK2vZrJd4nI+zuuEBavxAZAzlxbPyN5UUKKXD5CI+JoX+vVn2boV9x9zt
 lnhCrb1P9GuUFYVJOOUcvGoTHzrM+GlGAiQth5ofshvekO8j4F9JHxfzkPdW0uS4FXpP
 1PXOn0RAfSODjhZX01Y98GQ7Na0ovF8XxVnrVf6owS8ru96YglvUPlv5xIce6h0K4uNQ
 RUne3KbrvAJ4T9I30Wiv73MA5poZ39FYcp3Li1eMK33JOoyLx8GVmG5VpMe4l7T6vGBp
 GxgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GJOPIyasLSPxk613nSR6peAxwXinh+UYYUovQnag3kwhvwfIicp9LCS918MNZDqmpOK7uMGQVWHu9@nongnu.org
X-Gm-Message-State: AOJu0Yx8XpouzZs42KYVfSb45BxpOud5eY8abV6ePyQqjRsfKiSP2dtc
 wWrTXAU4c/ojNObQ+QenkNsiO3kCb1RnuZ43dITiVVBTzGQ5oKxDxjtoikvHp9t13QN+KzaOmIg
 5PBrN6AI=
X-Gm-Gg: AeBDiev9Jrr3DfdomwVJl+O160PfzTmgTFxAHsas9Lq2Cgp5/xRGxieBH4wuTUfSE5Q
 6eIT9+lPPfe/gJJDNcldsBc/EXJHZZNdnknFumyQCPYc9rZYpsoKJo9pcD/q8McSXbNxY6qGyng
 p1pm1lOsbLtvtsQEq9kmYL1Z+OmpBB9QFHE97tkOmoH28jpTZ3Oy4kZ/DE0N4Qg4d6DNTXla/WW
 XTIh6IMF8fwIkQz71lM6eE9a19njahFc6Pyd+yyt3ZKs0zkqnXC0GGNIVx3ZF/qQPzK9hKv9iw6
 qCwOEbs12RZjjJHNbOcKldsn1dcM0f9VWY2POXvf94WVyHLozZuox5Ng6L4GthpJboUnnu0ZO6t
 q5tRKoRovjNavhEB1xgTgqr7Y8FTU20o9uvewtUzULRIJZWexVb/AVgQULtJ8xSXIV0pnhAoSV8
 jLHgcVayEdONpJdbvhmjvsE/GZ3YF0npwMJv0DuQtqK+xxo+j9rnHzEIllFe5Wha2H+Q==
X-Received: by 2002:a05:6000:26cf:b0:43d:613:4036 with SMTP id
 ffacd0b85a97d-43d642be547mr29898627f8f.37.1776243838368; 
 Wed, 15 Apr 2026 02:03:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead402ee8sm3504249f8f.37.2026.04.15.02.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 02:03:57 -0700 (PDT)
Message-ID: <08d68fea-7f34-4590-a3d7-2727303f4f38@linaro.org>
Date: Wed, 15 Apr 2026 11:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
 <20260414080025.3005916-7-jamin_lin@aspeedtech.com>
 <7eb32749-dd83-48ea-94a4-41935cc90aca@linaro.org>
 <TYPPR06MB820645B6F63582C2FC44F7BEFC222@TYPPR06MB8206.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <TYPPR06MB820645B6F63582C2FC44F7BEFC222@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 15/4/26 02:54, Jamin Lin wrote:
> Hi Philippe
> 
>>>    const VMStateDescription vmstate_ehci = {
>>>        .name        = "ehci-core",
>>> -    .version_id  = 2,
>>> +    .version_id  = 3,
>>>        .minimum_version_id  = 1,
>>>        .pre_save    = usb_ehci_pre_save,
>>>        .post_load   = usb_ehci_post_load,
>>> @@ -2501,8 +2510,10 @@ const VMStateDescription vmstate_ehci = {
>>>            /* schedule state */
>>>            VMSTATE_UINT32(astate, EHCIState),
>>>            VMSTATE_UINT32(pstate, EHCIState),
>>> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
>>> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
>>> +        VMSTATE_UINT32_V(a_fetch_addr_pre_v3, EHCIState, 2),
>>> +        VMSTATE_UINT32_V(p_fetch_addr_pre_v3, EHCIState, 2),
>>
>> IIUC we want VMSTATE_UINT32_TEST(..., 3) here, for "<3".
>>
>>> +        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
>>> +        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),
>>
>> These ones are correct (">=3").
>>
>>>            VMSTATE_END_OF_LIST()
>>>        }
>>>    };
> 
> Thanks for the review and suggestion.
> How about the following changes?
> Thanks-Jamin
> 
> +static bool ehci_core_is_before_version_3(void *opaque, int version_id)
> +{
> +    return version_id < 3;
> +}
> +
>   const VMStateDescription vmstate_ehci = {
>       .name        = "ehci-core",
>       .version_id  = 3,
> @@ -2510,8 +2515,10 @@ const VMStateDescription vmstate_ehci = {
>           /* schedule state */
>           VMSTATE_UINT32(astate, EHCIState),
>           VMSTATE_UINT32(pstate, EHCIState),
> -        VMSTATE_UINT32_V(a_fetch_addr_pre_v3, EHCIState, 2),
> -        VMSTATE_UINT32_V(p_fetch_addr_pre_v3, EHCIState, 2),
> +        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState,
> +                            ehci_core_is_before_version_3),
> +        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState,
> +                            ehci_core_is_before_version_3),
>           VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
>           VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),
>           VMSTATE_END_OF_LIST()

LGTM, thanks!

